import 'package:carenest/app/features/teams/models/team_models.dart';
import 'package:carenest/app/features/home/models/home_dashboard_data.dart';
import 'package:carenest/app/features/home/services/home_cache_service.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/core/providers/app_providers.dart';
import 'package:carenest/app/core/services/timer_service.dart';
import 'package:carenest/app/shared/utils/schedule_time_parser.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider for HomeRepository
final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  final apiMethod = ref.read(apiMethodProvider);
  return HomeRepository(apiMethod);
});

/// Home Repository
///
/// Handles data fetching specifically for the Employee Home View.
class HomeRepository {
  final ApiMethod _apiMethod;
  final HomeCacheService _cache;

  HomeRepository(this._apiMethod, {HomeCacheService? cache})
    : _cache = cache ?? HomeCacheService();

  /// Fetch all data needed for the home dashboard
  Future<HomeDashboardData> getHomeDashboardData(String email) async {
    try {
      final now = DateTime.now();
      // Fetch emergency broadcasts and appointment data in parallel
      final results = await Future.wait([
        _apiMethod.get('emergency/active'),
        _apiMethod.getAppointmentData(email),
      ]);

      final emergencyResponse = results[0] as Map<String, dynamic>;
      final appointmentResponse = results[1] as Map<String, dynamic>;

      List<EmergencyBroadcast> broadcasts = [];
      if (emergencyResponse['success'] == true &&
          emergencyResponse['data'] != null) {
        final data = emergencyResponse['data'];
        if (data is List) {
          broadcasts = data
              .map(
                (e) => EmergencyBroadcast.fromJson(e as Map<String, dynamic>),
              )
              .toList();
        }
      }

      List<Map<String, dynamic>> appointments = [];
      var shiftsUnavailable = false;
      String? shiftsErrorMessage;

      // `getAppointmentData` reports transport/server failures with
      // success:false; a 404 (no appointments) is success:true with an empty
      // list. Only the former should surface a retry affordance.
      if (appointmentResponse['success'] == false) {
        shiftsUnavailable = true;
        shiftsErrorMessage = appointmentResponse['message']?.toString();
      }

      if (appointmentResponse['success'] == true ||
          appointmentResponse.containsKey('data')) {
        final data = appointmentResponse['data'];
        if (data is List) {
          final rawAssignments = List<Map<String, dynamic>>.from(data);

          for (var assignment in rawAssignments) {
            if (assignment['schedule'] != null &&
                assignment['schedule'] is List) {
              final scheduleList = assignment['schedule'] as List;

              // Find the closest active or future shift
              Map<String, dynamic>? nextUpcomingShift;
              DateTime? nextShiftDate;
              bool isInProgress = false;

              for (var shift in scheduleList) {
                final shiftStartTime = _parseDateTime(
                  shift['date'],
                  shift['startTime'],
                );
                if (shiftStartTime == null) continue;

                var shiftEndTime = _parseDateTime(
                  shift['date'],
                  shift['endTime'],
                );
                if (shiftEndTime != null &&
                    shiftEndTime.isBefore(shiftStartTime)) {
                  shiftEndTime = shiftEndTime.add(const Duration(days: 1));
                }

                final effectiveEndTime =
                    shiftEndTime ??
                    shiftStartTime.add(const Duration(hours: 4));

                bool isShiftActive = effectiveEndTime.isAfter(now);
                if (!isShiftActive) {
                  final timerService = TimerService();
                  if (timerService.isRunning &&
                      timerService.timerClientEmail ==
                          assignment['clientEmail']) {
                    final shiftDate = ScheduleTimeParser.parseDate(
                      shift['date'],
                    );
                    if (shiftDate != null) {
                      final today = DateTime(now.year, now.month, now.day);
                      final isToday =
                          shiftDate.year == today.year &&
                          shiftDate.month == today.month &&
                          shiftDate.day == today.day;
                      final isYesterday =
                          shiftDate.year ==
                              today.subtract(const Duration(days: 1)).year &&
                          shiftDate.month ==
                              today.subtract(const Duration(days: 1)).month &&
                          shiftDate.day ==
                              today.subtract(const Duration(days: 1)).day;
                      if (isToday || isYesterday) {
                        isShiftActive = true;
                      }
                    }
                  }
                }

                if (isShiftActive) {
                  if (nextShiftDate == null ||
                      shiftStartTime.isBefore(nextShiftDate)) {
                    nextShiftDate = shiftStartTime;
                    nextUpcomingShift = shift;
                    isInProgress =
                        shiftStartTime.isBefore(now) ||
                        shiftStartTime.isAtSameMomentAs(now);
                  }
                }
              }

              // Only add if we have a relevant shift
              if (nextUpcomingShift != null) {
                final newAssignment = Map<String, dynamic>.from(assignment);
                // Set the schedule to ONLY the next relevant shift for the card display
                newAssignment['schedule'] = [nextUpcomingShift];

                final shiftStart = _parseDateTime(
                  nextUpcomingShift['date'],
                  nextUpcomingShift['startTime'],
                );
                var shiftEnd = _parseDateTime(
                  nextUpcomingShift['date'],
                  nextUpcomingShift['endTime'],
                );

                // Handle cross-midnight shifts
                if (shiftEnd != null &&
                    shiftStart != null &&
                    shiftEnd.isBefore(shiftStart)) {
                  shiftEnd = shiftEnd.add(const Duration(days: 1));
                }
                final effectiveEnd =
                    shiftEnd ?? shiftStart?.add(const Duration(hours: 4));

                if (isInProgress) {
                  // Timer running past end → overtime; timer running within shift → in_progress; nothing running → overdue
                  final timerService = TimerService();
                  final clientEmail = assignment['clientEmail']?.toString();
                  final timerRunning =
                      timerService.isRunning &&
                      clientEmail != null &&
                      timerService.timerClientEmail == clientEmail;

                  if (shiftEnd != null &&
                      effectiveEnd != null &&
                      effectiveEnd.isBefore(now)) {
                    newAssignment['_shiftStatus'] = timerRunning
                        ? 'overtime'
                        : 'overdue';
                  } else {
                    newAssignment['_shiftStatus'] = 'in_progress';
                  }
                }
                appointments.add(newAssignment);
              }
            }
          }

          // Sort appointments by their next upcoming shift date
          appointments.sort((a, b) {
            final aDate = _parseDateTime(
              a['schedule'][0]['date'],
              a['schedule'][0]['startTime'],
            );
            final bDate = _parseDateTime(
              b['schedule'][0]['date'],
              b['schedule'][0]['startTime'],
            );
            if (aDate == null || bDate == null) return 0;
            return aDate.compareTo(bDate);
          });
        }
      }

      final result = HomeDashboardData(
        activeBroadcasts: broadcasts,
        upcomingAppointments: appointments,
        shiftsUnavailable: shiftsUnavailable,
        shiftsErrorMessage: shiftsErrorMessage,
      );

      if (!shiftsUnavailable) {
        await _cache.save(email, result);
        return result;
      }

      // The live appointment feed failed but broadcasts may still be fresh.
      // Fall back to the last successful card set and mark it stale so the
      // worker can still open the shift and clock in/out offline.
      final cached = await _cache.read(email);
      if (cached != null && cached.data.upcomingAppointments.isNotEmpty) {
        return result.copyWith(
          upcomingAppointments: cached.data.upcomingAppointments,
          isStale: true,
          lastSyncedAt: cached.cachedAt,
          shiftsUnavailable: false,
        );
      }
      return result;
    } catch (e) {
      final cached = await _cache.read(email);
      if (cached != null && cached.data.upcomingAppointments.isNotEmpty) {
        return cached.data.copyWith(
          isStale: true,
          lastSyncedAt: cached.cachedAt,
          shiftsUnavailable: false,
        );
      }
      throw Exception('Failed to load home dashboard data: $e');
    }
  }

  DateTime? _parseDateTime(dynamic date, dynamic time) {
    return ScheduleTimeParser.parseDateTime(date, time);
  }

  /// Fetch only active emergency broadcasts (used by the polling timer).
  Future<List<EmergencyBroadcast>> getActiveBroadcasts() async {
    try {
      final response = await _apiMethod.get('emergency/active');
      if (response['success'] == true && response['data'] != null) {
        final data = response['data'];
        if (data is List) {
          return data
              .map(
                (e) => EmergencyBroadcast.fromJson(e as Map<String, dynamic>),
              )
              .toList();
        }
      }
      return [];
    } catch (e) {
      throw Exception('Failed to fetch active broadcasts: $e');
    }
  }

  /// Acknowledge an emergency broadcast
  Future<void> acknowledgeBroadcast(String broadcastId) async {
    try {
      final response = await _apiMethod.post(
        'emergency/acknowledge/$broadcastId',
      );

      if (response['success'] != true) {
        throw Exception(
          response['message'] ?? 'Failed to acknowledge broadcast',
        );
      }
    } catch (e) {
      throw Exception('Error acknowledging broadcast: $e');
    }
  }
}
