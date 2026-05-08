import 'package:carenest/app/features/teams/models/team_models.dart';
import 'package:carenest/app/features/home/models/home_dashboard_data.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/core/providers/app_providers.dart';
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
      if (emergencyResponse['success'] == true && emergencyResponse['data'] != null) {
        final data = emergencyResponse['data'];
        if (data is List) {
          broadcasts = data
              .map((e) => EmergencyBroadcast.fromJson(e as Map<String, dynamic>))
              .toList();
        }
      }

      List<Map<String, dynamic>> appointments = [];
      if (appointmentResponse['success'] == true || appointmentResponse.containsKey('data')) {
        final data = appointmentResponse['data'];
        if (data is List) {
          final rawAssignments = List<Map<String, dynamic>>.from(data);
          
          for (var assignment in rawAssignments) {
            if (assignment['schedule'] != null && assignment['schedule'] is List) {
              final scheduleList = assignment['schedule'] as List;

              // Find the closest FUTURE shift
              Map<String, dynamic>? nextUpcomingShift;
              DateTime? nextShiftDate;

              for (var shift in scheduleList) {
                final shiftDate = _parseDateTime(shift['date'], shift['startTime']);
                if (shiftDate != null && shiftDate.isAfter(now)) {
                  if (nextShiftDate == null || shiftDate.isBefore(nextShiftDate)) {
                    nextShiftDate = shiftDate;
                    nextUpcomingShift = shift;
                  }
                }
              }

              // Only add if we have an upcoming shift
              if (nextUpcomingShift != null) {
                final newAssignment = Map<String, dynamic>.from(assignment);
                // Set the schedule to ONLY the next upcoming shift for the card display
                newAssignment['schedule'] = [nextUpcomingShift];
                appointments.add(newAssignment);
              }
            }
          }

          // Sort appointments by their next upcoming shift date
          appointments.sort((a, b) {
            final aDate = _parseDateTime(a['schedule'][0]['date'], a['schedule'][0]['startTime']);
            final bDate = _parseDateTime(b['schedule'][0]['date'], b['schedule'][0]['startTime']);
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
                int.parse(parts[2]), int.parse(parts[0]), int.parse(parts[1]));
          } catch (e) {
            // Fallback to DD/MM/YYYY
            parsedDate = DateTime(
                int.parse(parts[2]), int.parse(parts[1]), int.parse(parts[0]));
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
              .map((e) => EmergencyBroadcast.fromJson(e as Map<String, dynamic>))
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
        throw Exception(response['message'] ?? 'Failed to acknowledge broadcast');
      }
    } catch (e) {
      throw Exception('Error acknowledging broadcast: $e');
    }
  }
}
