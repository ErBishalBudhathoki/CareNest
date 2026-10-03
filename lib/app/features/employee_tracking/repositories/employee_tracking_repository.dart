import 'dart:typed_data';

import '../models/employee_tracking_model.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';
import 'package:carenest/app/shared/utils/image_utils.dart';

class EmployeeTrackingRepository {
  final ApiMethod _apiMethod;

  EmployeeTrackingRepository({required ApiMethod apiMethod})
    : _apiMethod = apiMethod;

  /// Fetches employee tracking data from the backend
  Future<EmployeeTrackingData> getEmployeeTrackingData() async {
    try {
      // Initialize SharedPreferences
      final sharedPrefs = SharedPreferencesUtils();
      await sharedPrefs.init();
      // Get organization ID from SharedPreferences
      final organizationId = sharedPrefs.getString('organizationId');
      if (organizationId == null || organizationId.isEmpty) {
        throw Exception('Organization ID not found in SharedPreferences');
      }

      // Make API call to get employee tracking data
      final response = await _apiMethod.getEmployeeTrackingData(organizationId);
      if (response['success'] == true) {
        final responseData = response['data'];
        final liveZoneEntries =
            responseData['liveZone'] as List<dynamic>? ?? [];
        final Map<String, Map<String, dynamic>> liveZoneByEmail = {};
        for (final entry in liveZoneEntries) {
          if (entry is! Map) continue;
          final email =
              entry['userEmail']?.toString().toLowerCase().trim() ?? '';
          if (email.isEmpty) continue;

          final existing = liveZoneByEmail[email];
          DateTime entryUpdatedAt = DateTime.fromMillisecondsSinceEpoch(0);
          DateTime existingUpdatedAt = DateTime.fromMillisecondsSinceEpoch(0);

          if (entry['lastUpdate'] != null) {
            entryUpdatedAt =
                DateTime.tryParse(entry['lastUpdate'].toString()) ??
                entryUpdatedAt;
          }
          if (existing != null && existing['lastUpdate'] != null) {
            existingUpdatedAt =
                DateTime.tryParse(existing['lastUpdate'].toString()) ??
                existingUpdatedAt;
          }

          if (existing == null || entryUpdatedAt.isAfter(existingUpdatedAt)) {
            liveZoneByEmail[email] = Map<String, dynamic>.from(entry);
          }
        }

        // Transform the backend response to match our model structure
        // Convert assignments to employee status format
        final assignments = responseData['assignments'] as List<dynamic>? ?? [];
        final fallbackEmployees =
            responseData['allEmployees'] as List<dynamic>? ?? [];
        final useFallbackEmployees =
            assignments.isEmpty && fallbackEmployees.isNotEmpty;
        final activeTimers =
            responseData['activeTimers'] as List<dynamic>? ?? [];
        final currentlyWorkingCount = responseData['currentlyWorking'] ?? 0;

        // Create a set of active user emails from activeTimers
        final activeUserEmails = activeTimers
            .map((timer) => timer['userEmail'] as String?)
            .whereType<String>()
            .toSet();
        if (activeUserEmails.isEmpty && useFallbackEmployees) {
          for (final emp in fallbackEmployees) {
            if (emp is! Map) continue;
            final isCurrentlyWorking = emp['isCurrentlyWorking'] == true;
            final userEmail = emp['userEmail']?.toString() ?? '';
            if (isCurrentlyWorking && userEmail.isNotEmpty) {
              activeUserEmails.add(userEmail);
            }
          }
        }
        // Create a map to track userName usage and ensure unique display names
        final Map<String, int> userNameCounts = {};
        final Map<String, String> uniqueDisplayNames = {};

        // First pass: count userName occurrences and create unique display names
        final nameSource = useFallbackEmployees
            ? fallbackEmployees
            : assignments;
        for (final entry in nameSource) {
          if (entry is! Map) continue;
          final userEmail = entry['userEmail'] ?? '';
          final userName =
              entry['userName'] ?? entry['userDetails']?['name'] ?? 'Unknown';

          userNameCounts[userName] = (userNameCounts[userName] ?? 0) + 1;
        }

        // Second pass: assign unique display names
        for (final entry in nameSource) {
          if (entry is! Map) continue;
          final userEmail = entry['userEmail'] ?? '';
          final userName =
              entry['userName'] ?? entry['userDetails']?['name'] ?? 'Unknown';

          String displayName;
          if (userNameCounts[userName]! > 1) {
            // Multiple users with same userName - use email to differentiate
            displayName = '$userName (${userEmail.split('@')[0]})';
          } else {
            // Unique userName - use as is
            displayName = userName;
          }

          uniqueDisplayNames[userEmail] = displayName;
        }

        final transformedEmployees = (useFallbackEmployees ? fallbackEmployees : assignments)
            .map((entry) {
              if (entry is! Map<String, dynamic>) {
                return <String, dynamic>{};
              }

              if (useFallbackEmployees) {
                final userEmail = entry['userEmail'] ?? '';
                final displayName =
                    uniqueDisplayNames[userEmail] ??
                    entry['userName'] ??
                    entry['userDetails']?['name'] ??
                    'Unknown';

                final isActive =
                    entry['isCurrentlyWorking'] == true ||
                    activeUserEmails.contains(userEmail);
                final status = isActive ? 'active' : 'offline';

                final timer = entry['currentTimer'] as Map<String, dynamic>?;
                final assignmentsList =
                    entry['assignments'] as List<dynamic>? ?? [];
                final firstAssignment =
                    assignmentsList.isNotEmpty && assignmentsList.first is Map
                    ? assignmentsList.first as Map<String, dynamic>
                    : null;
                final recentShifts =
                    entry['recentShifts'] as List<dynamic>? ?? [];
                final recentShift =
                    recentShifts.isNotEmpty && recentShifts.first is Map
                    ? recentShifts.first as Map<String, dynamic>
                    : null;

                final currentLocation =
                    timer?['clientAddress'] ??
                    timer?['clientDetails']?['clientAddress'] ??
                    firstAssignment?['clientAddress'];

                final lastSeen =
                    timer?['startTime'] ??
                    recentShift?['endTime'] ??
                    recentShift?['startTime'];

                final Map<String, dynamic> employeeData = {
                  'id': userEmail.toString().isNotEmpty
                      ? userEmail
                      : (entry['id'] ?? entry['_id'] ?? '').toString(),
                  'name': displayName,
                  'email': userEmail,
                  'status': status,
                  'profileImage': entry['profileImage'],
                  'filename': entry['filename'],
                  'currentLocation': currentLocation,
                  'lastSeen': lastSeen,
                  'currentShiftId': null,
                  'assignedClientId':
                      timer?['clientEmail'] ?? firstAssignment?['clientEmail'],
                  'liveLatitude': null,
                  'liveLongitude': null,
                  'liveAccuracy': null,
                  'liveUpdatedAt': null,
                  'liveAppointmentId': null,
                  'liveClientName': null,
                  'liveDistanceMeters': null,
                  'liveGeofenceRadiusMeters': null,
                  'liveInsideGeofence': null,
                  'hoursWorked': 0.0,
                  'isOnBreak': false,
                };

                final liveZoneEntry =
                    liveZoneByEmail[userEmail.toString().toLowerCase()];
                if (liveZoneEntry != null) {
                  employeeData['liveLatitude'] = liveZoneEntry['latitude'];
                  employeeData['liveLongitude'] = liveZoneEntry['longitude'];
                  employeeData['liveAccuracy'] = liveZoneEntry['accuracy'];
                  employeeData['liveUpdatedAt'] = liveZoneEntry['lastUpdate'];
                  employeeData['liveAppointmentId'] =
                      liveZoneEntry['appointmentId'];
                  employeeData['liveClientName'] = liveZoneEntry['clientName'];
                  employeeData['liveDistanceMeters'] =
                      liveZoneEntry['distanceMeters'];
                  employeeData['liveGeofenceRadiusMeters'] =
                      liveZoneEntry['geofenceRadiusMeters'];
                  employeeData['liveInsideGeofence'] =
                      liveZoneEntry['insideGeofence'];
                }

                return employeeData;
              }

              final assignment = entry;
              final userEmail = assignment['userEmail'] ?? '';

              // Determine status based on activeTimers data
              String status;
              bool isOnBreak = false;

              if (activeUserEmails.contains(userEmail)) {
                // User has an active timer - they are currently working
                status = 'active';
              } else {
                // User doesn't have an active timer - they are offline
                status = 'offline';
              }

              final displayName = uniqueDisplayNames[userEmail] ?? 'Unknown';
              // Process profile image
              String? profileImageUrl;
              Uint8List? decodedPhotoData;

              // Print the entire assignment structure to debug
              // Extract photoData and filename from the assignment or nested userDetails object
              final userDetails =
                  assignment['userDetails'] as Map<String, dynamic>?;

              // Print userDetails structure if available
              if (userDetails != null) {}

              // Look for profileImage in the assignment first, then photoData as fallback
              final photoData =
                  assignment['profileImage'] ??
                  userDetails?['photoData'] ??
                  userDetails?['profileImage'];
              final filename =
                  assignment['filename'] ?? userDetails?['filename'];

              if (photoData != null &&
                  photoData.toString().isNotEmpty &&
                  photoData.toString() != 'null') {
                // Decode the base64 image to Uint8List for photoData field
                try {
                  decodedPhotoData = ImageUtils.decodeBase64Image(
                    photoData.toString(),
                  );
                } catch (e) {
                  decodedPhotoData = null;
                }

                // Check if it's already a data URL
                if (photoData.toString().startsWith('data:image')) {
                  profileImageUrl = photoData.toString();
                } else {
                  // Convert base64 to data URL for profileImage
                  profileImageUrl = 'data:image/jpeg;base64,$photoData';
                }
              } else {
                // Fallback to profileImage if photoData is not available
                final profileImage = userDetails?['profileImage'];
                if (profileImage != null &&
                    profileImage.toString().isNotEmpty &&
                    profileImage.toString() != 'null') {
                  profileImageUrl = profileImage.toString();
                } else {}
              }

              final Map<String, dynamic> employeeData = {
                'id': assignment['assignmentId'] ?? '',
                'name': displayName,
                'email': userEmail,
                'status': status,
                'profileImage': profileImageUrl,
                'filename': filename,
                'currentLocation': assignment['clientAddress'],
                'lastSeen': assignment['createdAt'],
                'currentShiftId': assignment['assignmentId'],
                'assignedClientId': assignment['clientEmail'],
                'liveLatitude': null,
                'liveLongitude': null,
                'liveAccuracy': null,
                'liveUpdatedAt': null,
                'liveAppointmentId': null,
                'liveClientName': null,
                'liveDistanceMeters': null,
                'liveGeofenceRadiusMeters': null,
                'liveInsideGeofence': null,
                'hoursWorked': 0.0,
                'isOnBreak': isOnBreak,
              };

              final liveZoneEntry =
                  liveZoneByEmail[userEmail.toString().toLowerCase()];
              if (liveZoneEntry != null) {
                employeeData['liveLatitude'] = liveZoneEntry['latitude'];
                employeeData['liveLongitude'] = liveZoneEntry['longitude'];
                employeeData['liveAccuracy'] = liveZoneEntry['accuracy'];
                employeeData['liveUpdatedAt'] = liveZoneEntry['lastUpdate'];
                employeeData['liveAppointmentId'] =
                    liveZoneEntry['appointmentId'];
                employeeData['liveClientName'] = liveZoneEntry['clientName'];
                employeeData['liveDistanceMeters'] =
                    liveZoneEntry['distanceMeters'];
                employeeData['liveGeofenceRadiusMeters'] =
                    liveZoneEntry['geofenceRadiusMeters'];
                employeeData['liveInsideGeofence'] =
                    liveZoneEntry['insideGeofence'];
              }

              // Store the decoded photoData in the employee object
              // This will be manually assigned to the photoData field after JSON deserialization
              // since photoData is excluded from JSON serialization/deserialization
              if (decodedPhotoData != null) {
                // We'll use this to manually assign photoData after deserialization
                employeeData['_decodedPhotoData'] = decodedPhotoData;
              }

              return employeeData;
            })
            .where((e) => e.isNotEmpty)
            .toList();

        // Transform workedTimeRecords to match ShiftDetail model
        final workedTimeRecords =
            responseData['workedTimeRecords'] as List<dynamic>? ?? [];
        final transformedShifts = workedTimeRecords.map((record) {
          // Parse shift date and times to create DateTime objects
          final shiftDate =
              record['shiftDate'] ??
              DateTime.now().toIso8601String().split('T')[0];
          final startTime = record['shiftStartTime'] ?? '09:00';
          final endTime = record['shiftEndTime'] ?? '17:00';

          // Convert time to 24-hour format if it's in AM/PM format
          final convertedStartTime = _convertTo24HourFormat(startTime);
          final convertedEndTime = _convertTo24HourFormat(endTime);

          // Create full DateTime objects
          final startDateTime = DateTime.parse(
            '${shiftDate}T$convertedStartTime:00',
          );
          final endDateTime = DateTime.parse(
            '${shiftDate}T$convertedEndTime:00',
          );

          return {
            'id': record['recordId'] ?? record['shiftKey'] ?? '',
            'title': 'Shift at ${record['clientEmail'] ?? 'Unknown Client'}',
            'startTime': startDateTime.toIso8601String(),
            'endTime': endDateTime.toIso8601String(),
            'employeeId': record['userEmail'] ?? '',
            'employeeName': record['userName'] ?? 'Unknown',
            'clientId': record['clientEmail'] ?? '',
            'clientName':
                record['clientName'] ??
                record['clientEmail'] ??
                'Unknown Client',
            'location': null,
            'status': 'completed',
            'notes': 'Worked ${record['timeWorked'] ?? '0:00:00'} hours',
          };
        }).toList();

        // Transform assignments to match ClientAssignment model
        final transformedAssignments = assignments.map((assignment) {
          return {
            'id': assignment['assignmentId'] ?? '',
            'clientName': assignment['clientEmail'] ?? 'Unknown Client',
            'employeeId': assignment['assignmentId'] ?? '',
            'employeeName': assignment['userName'] ?? '',
            'assignedDate':
                assignment['createdAt'] ?? DateTime.now().toIso8601String(),
            'startDate': null,
            'endDate': null,
            'status': 'active',
            'notes': null,
            'location': assignment['clientAddress'],
          };
        }).toList();

        // Calculate employee counts based on actual status distribution
        final totalEmployees = transformedEmployees.length;
        final activeEmployees = transformedEmployees
            .where((e) => e['status'] == 'active')
            .length;
        final onBreakEmployees = transformedEmployees
            .where((e) => e['status'] == 'on_break')
            .length;
        final offlineEmployees = transformedEmployees
            .where((e) => e['status'] == 'offline')
            .length;

        final transformedData = {
          'employees': transformedEmployees,
          'shifts': transformedShifts,
          'assignments': transformedAssignments,
          'totalEmployees': totalEmployees,
          'activeEmployees': activeEmployees,
          'onBreakEmployees': onBreakEmployees,
          'offlineEmployees': offlineEmployees,
        };

        for (int i = 0; i < transformedEmployees.length; i++) {
          final emp = transformedEmployees[i];
        }

        // First, deserialize the data using the fromJson factory
        final employeeTrackingData = EmployeeTrackingData.fromJson(
          transformedData,
        );
        // Now we need to manually assign the decoded photoData to each employee
        // since photoData is excluded from JSON serialization/deserialization
        final List<EmployeeStatus> updatedEmployees = [];

        for (int i = 0; i < employeeTrackingData.employees.length; i++) {
          final emp = employeeTrackingData.employees[i];
          final originalData = transformedEmployees[i];

          // Check if we have decoded photoData for this employee
          if (originalData.containsKey('_decodedPhotoData')) {
            final Uint8List photoData = originalData['_decodedPhotoData'];
            // Create a new EmployeeStatus with the photoData field populated
            // Since we're using freezed, copyWith is automatically generated
            final updatedEmp = emp.copyWith(photoData: photoData);
            updatedEmployees.add(updatedEmp);
          } else {
            updatedEmployees.add(emp);
          }
        }

        // Create a new EmployeeTrackingData with the updated employees
        // Since we're using freezed, copyWith is automatically generated
        final updatedEmployeeTrackingData = employeeTrackingData.copyWith(
          employees: updatedEmployees,
        );

        return updatedEmployeeTrackingData;
      } else {
        throw Exception(
          'Failed to fetch employee tracking data: ${response['message'] ?? response['error'] ?? response['errorMessage'] ?? 'Unknown error'}',
        );
      }
    } catch (e) {
      // Handle error - you might want to show a snackbar
      rethrow;
    }
  }

  /// Refreshes employee tracking data
  Future<EmployeeTrackingData> refreshEmployeeTrackingData() async {
    return await getEmployeeTrackingData();
  }

  /// Updates employee status.
  ///
  /// NOT YET IMPLEMENTED: there is no stored work-status field (User and
  /// Employee schemas have none; tracking status is derived from
  /// timers/sessions) and no backend endpoint (see
  /// backend/employee_tracking_endpoint.js). This throws instead of
  /// pretending success so no caller can mistake it for a real update.
  ///
  /// TODO(backend, separate cycle): full design is
  /// 1. Add `workStatus` String field (enum active|on_break|offline|
  ///    clocked_out, default active) to the User schema.
  /// 2. Add admin-gated `PUT /api/employee-tracking/:organizationId/status`
  ///    route + controller updating that field.
  /// 3. Merge the stored value into the derived status in
  ///    employeeTrackingService.getEmployeeTrackingData.
  /// 4. Add ApiMethod.updateEmployeeStatus, then implement this method
  ///    and remove the throw. Verified: nothing in the app calls this yet.
  Future<bool> updateEmployeeStatus(
    String employeeId,
    WorkStatus status,
  ) async {
    final sharedPrefs = SharedPreferencesUtils();
    await sharedPrefs.init();
    final organizationId = sharedPrefs.getString('organizationId');

    if (organizationId == null || organizationId.isEmpty) {
      throw Exception('Organization ID not found');
    }

    throw UnimplementedError(
      'updateEmployeeStatus has no backend endpoint yet '
      '(employee: $employeeId, status: ${status.name})',
    );
  }

  /// Gets real-time employee location updates (placeholder for future implementation)
  Stream<List<EmployeeStatus>> getEmployeeLocationUpdates() async* {
    // This would typically connect to a WebSocket or polling mechanism
    // For now, we'll implement a simple polling approach
    while (true) {
      try {
        final data = await getEmployeeTrackingData();
        yield data.employees;
        await Future.delayed(
          const Duration(seconds: 30),
        ); // Poll every 30 seconds
      } catch (e) {
        // Handle error silently or yield empty list
        yield [];
        await Future.delayed(
          const Duration(seconds: 60),
        ); // Wait longer on error
      }
    }
  }

  /// Convert time from AM/PM format to 24-hour format
  String _convertTo24HourFormat(String timeStr) {
    try {
      String cleanTimeStr = timeStr.trim();

      // Check if it's already in 24-hour format (no AM/PM)
      if (!cleanTimeStr.toLowerCase().contains('am') &&
          !cleanTimeStr.toLowerCase().contains('pm')) {
        return cleanTimeStr;
      }

      // Check if it's AM/PM format
      bool isPM = cleanTimeStr.toLowerCase().contains('pm');
      bool isAM = cleanTimeStr.toLowerCase().contains('am');

      // Remove AM/PM and extra spaces
      cleanTimeStr = cleanTimeStr.replaceAll(
        RegExp(r'\s*(am|pm)\s*', caseSensitive: false),
        '',
      );

      final parts = cleanTimeStr.split(':');
      if (parts.length >= 2) {
        int hour = int.parse(parts[0]);
        final minuteParts = parts[1].split(' ');
        final minute = minuteParts.isNotEmpty
            ? minuteParts[0]
            : parts[1]; // Handle any trailing spaces

        // Convert 12-hour to 24-hour format
        if (isPM && hour != 12) {
          hour += 12;
        } else if (isAM && hour == 12) {
          hour = 0;
        }

        return '${hour.toString().padLeft(2, '0')}:${minute.padLeft(2, '0')}';
      }
    } catch (e) {
      // Not a time string we can parse, so hand back what we were given. The
      // caller's next line does exactly that.
    }

    // Return original string if conversion fails
    return timeStr;
  }
}
