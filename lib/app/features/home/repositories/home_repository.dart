import 'package:carenest/app/features/teams/models/team_models.dart';
import 'package:carenest/app/features/home/models/home_dashboard_data.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/core/providers/app_providers.dart';
import 'package:carenest/app/core/services/timer_service.dart';
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

  HomeRepository(this._apiMethod);

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
                    final shiftDate = DateTime.tryParse(shift['date'] ?? '');
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
                  final clientEmail =
                      assignment['clientEmail']?.toString();
                  final timerRunning = timerService.isRunning &&
                      clientEmail != null &&
                      timerService.timerClientEmail == clientEmail;

                  if (shiftEnd != null && effectiveEnd != null && effectiveEnd.isBefore(now)) {
                    newAssignment['_shiftStatus'] = timerRunning ? 'overtime' : 'overdue';
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

      return HomeDashboardData(
        activeBroadcasts: broadcasts,
        upcomingAppointments: appointments,
      );
    } catch (e) {
      throw Exception('Failed to load home dashboard data: $e');
    }
  }

  DateTime? _parseDateTime(dynamic date, dynamic time) {
    try {
      if (date == null || time == null) return null;

      String dateStr = date.toString().trim();
      String timeStr = time.toString().trim();

      DateTime parsedDate;
      if (dateStr.contains('-')) {
        parsedDate = DateTime.parse(dateStr);
      } else if (dateStr.contains('/')) {
        final parts = dateStr.split('/');
        if (parts.length == 3) {
          try {
            // Try MM/DD/YYYY first
            parsedDate = DateTime(
              int.parse(parts[2]),
              int.parse(parts[0]),
              int.parse(parts[1]),
            );
          } catch (e) {
            // Fallback to DD/MM/YYYY
            parsedDate = DateTime(
              int.parse(parts[2]),
              int.parse(parts[1]),
              int.parse(parts[0]),
            );
          }
        } else {
          return null;
        }
      } else {
        return null;
      }

      if (timeStr.contains(':')) {
        final timeParts = timeStr.split(':');
        if (timeParts.length >= 2) {
          int hour = int.parse(timeParts[0].trim());
          String minutePart = timeParts[1].replaceAll(RegExp(r'[^0-9]'), '');
          int minute = minutePart.isNotEmpty ? int.parse(minutePart) : 0;

          if (timeStr.toUpperCase().contains('PM') && hour != 12) {
            hour += 12;
          } else if (timeStr.toUpperCase().contains('AM') && hour == 12) {
            hour = 0;
          }
          return DateTime(
            parsedDate.year,
            parsedDate.month,
            parsedDate.day,
            hour,
            minute,
          );
        }
      }
      return null;
    } catch (e) {
      return null;
    }
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
