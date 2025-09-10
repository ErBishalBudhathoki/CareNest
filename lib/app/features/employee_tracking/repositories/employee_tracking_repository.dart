import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import '../models/employee_tracking_model.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';
import 'package:carenest/app/shared/utils/image_utils.dart';

class EmployeeTrackingRepository {
  final ApiMethod _apiMethod = ApiMethod();

  /// Fetches employee tracking data from the backend
  Future<EmployeeTrackingData> getEmployeeTrackingData() async {
    debugPrint(
        '🔍 DEBUG: EmployeeTrackingRepository.getEmployeeTrackingData() called');

    try {
      // Initialize SharedPreferences
      final sharedPrefs = SharedPreferencesUtils();
      await sharedPrefs.init();
      debugPrint('🔍 DEBUG: SharedPreferences initialized');

      // Get organization ID from SharedPreferences
      final organizationId = sharedPrefs.getString('organizationId');
      debugPrint(
          '🔍 DEBUG: Retrieved organizationId from SharedPreferences: $organizationId');

      if (organizationId == null || organizationId.isEmpty) {
        debugPrint('🔍 DEBUG: ERROR - Organization ID is null or empty!');
        throw Exception('Organization ID not found in SharedPreferences');
      }

      debugPrint(
          '🔍 DEBUG: Making API call to getEmployeeTrackingData with organizationId: $organizationId');

      // Make API call to get employee tracking data
      final response = await _apiMethod.getEmployeeTrackingData(organizationId);
      debugPrint('🔍 DEBUG: API response received');
      debugPrint('🔍 DEBUG: Response type: ${response.runtimeType}');
      debugPrint('🔍 DEBUG: Full response: $response');

      if (response != null && response['success'] == true) {
        debugPrint(
            '🔍 DEBUG: Parsing response data to EmployeeTrackingData model');
        final responseData = response['data'];
        debugPrint('🔍 DEBUG: Response data: $responseData');

        // Transform the backend response to match our model structure
        // Convert assignments to employee status format
        final assignments = responseData['assignments'] as List<dynamic>? ?? [];
        final activeTimers =
            responseData['activeTimers'] as List<dynamic>? ?? [];
        final currentlyWorkingCount = responseData['currentlyWorking'] ?? 0;

        debugPrint('🔍 DEBUG: Active timers from backend: $activeTimers');
        debugPrint('🔍 DEBUG: Currently working count: $currentlyWorkingCount');

        // Create a set of active user emails from activeTimers
        final activeUserEmails =
            activeTimers.map((timer) => timer['userEmail'] as String).toSet();
        debugPrint('🔍 DEBUG: Active user emails: $activeUserEmails');

        // Create a map to track userName usage and ensure unique display names
        final Map<String, int> userNameCounts = {};
        final Map<String, String> uniqueDisplayNames = {};

        // First pass: count userName occurrences and create unique display names
        for (final assignment in assignments) {
          final userEmail = assignment['userEmail'] ?? '';
          final userName = assignment['userName'] ?? 'Unknown';

          debugPrint(
              '🔍 DEBUG: Processing assignment for $userEmail with userName: $userName');
          debugPrint('🔍 DEBUG: Full assignment data: $assignment');

          userNameCounts[userName] = (userNameCounts[userName] ?? 0) + 1;
        }

        // Second pass: assign unique display names
        final Map<String, int> userNameCounters = {};
        for (final assignment in assignments) {
          final userEmail = assignment['userEmail'] ?? '';
          final userName = assignment['userName'] ?? 'Unknown';

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

        final transformedEmployees = assignments.map((assignment) {
          final userEmail = assignment['userEmail'] ?? '';

          // Determine status based on activeTimers data
          String status;
          bool isOnBreak = false;

          if (activeUserEmails.contains(userEmail)) {
            // User has an active timer - they are currently working
            status = 'active';
            debugPrint(
                '🔍 DEBUG: User $userEmail is ACTIVE (has active timer)');
          } else {
            // User doesn't have an active timer - they are offline
            status = 'offline';
            debugPrint(
                '🔍 DEBUG: User $userEmail is OFFLINE (no active timer)');
          }

          final displayName = uniqueDisplayNames[userEmail] ?? 'Unknown';
          debugPrint('🔍 DEBUG: User $userEmail display name: $displayName');

          // Process profile image
          String? profileImageUrl;
          Uint8List? decodedPhotoData;

          // Print the entire assignment structure to debug
          debugPrint(
              '🔍 DEBUG: Full assignment structure: ${assignment.keys.toList()}');

          // Extract photoData and filename from the assignment or nested userDetails object
          final userDetails =
              assignment['userDetails'] as Map<String, dynamic>?;

          // Print userDetails structure if available
          if (userDetails != null) {
            debugPrint(
                '🔍 DEBUG: userDetails structure: ${userDetails.keys.toList()}');
          }

          // Look for profileImage in the assignment first, then photoData as fallback
          final photoData = assignment['profileImage'] ??
              userDetails?['photoData'] ??
              userDetails?['profileImage'];
          final filename = assignment['filename'] ?? userDetails?['filename'];

          debugPrint('🔍 DEBUG: PhotoData for $userEmail: $photoData');
          debugPrint('🔍 DEBUG: Filename for $userEmail: $filename');
          debugPrint('🔍 DEBUG: PhotoData type: ${photoData.runtimeType}');
          debugPrint(
              '🔍 DEBUG: PhotoData length: ${photoData?.toString().length}');

          if (photoData != null &&
              photoData.toString().isNotEmpty &&
              photoData.toString() != 'null') {
            // Decode the base64 image to Uint8List for photoData field
            try {
              decodedPhotoData =
                  ImageUtils.decodeBase64Image(photoData.toString());
              debugPrint(
                  '🔍 DEBUG: Successfully decoded photoData for $userEmail (${decodedPhotoData?.length ?? 0} bytes)');
            } catch (e) {
              debugPrint('🔍 DEBUG: Error decoding photoData: $e');
              decodedPhotoData = null;
            }

            // Check if it's already a data URL
            if (photoData.toString().startsWith('data:image')) {
              profileImageUrl = photoData.toString();
              debugPrint('🔍 DEBUG: Using existing data URL for $userEmail');
            } else {
              // Convert base64 to data URL for profileImage
              profileImageUrl = 'data:image/jpeg;base64,$photoData';
              debugPrint(
                  '🔍 DEBUG: Created profile image URL for $userEmail: ${profileImageUrl.substring(0, 50)}...');
            }
          } else {
            // Fallback to profileImage if photoData is not available
            final profileImage = userDetails?['profileImage'];
            if (profileImage != null &&
                profileImage.toString().isNotEmpty &&
                profileImage.toString() != 'null') {
              profileImageUrl = profileImage.toString();
              debugPrint(
                  '🔍 DEBUG: Using profileImage as fallback for $userEmail');
            } else {
              debugPrint(
                  '🔍 DEBUG: No photoData or profileImage available for $userEmail');
            }
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
            'hoursWorked': 0.0,
            'isOnBreak': isOnBreak,
          };

          // Store the decoded photoData in the employee object
          // This will be manually assigned to the photoData field after JSON deserialization
          // since photoData is excluded from JSON serialization/deserialization
          if (decodedPhotoData != null) {
            debugPrint(
                '🔍 DEBUG: Storing decoded photoData for $userEmail (${decodedPhotoData.length} bytes)');
            // We'll use this to manually assign photoData after deserialization
            employeeData['_decodedPhotoData'] = decodedPhotoData;
          }

          return employeeData;
        }).toList();

        // Transform workedTimeRecords to match ShiftDetail model
        final workedTimeRecords =
            responseData['workedTimeRecords'] as List<dynamic>? ?? [];
        final transformedShifts = workedTimeRecords.map((record) {
          // Parse shift date and times to create DateTime objects
          final shiftDate = record['shiftDate'] ??
              DateTime.now().toIso8601String().split('T')[0];
          final startTime = record['shiftStartTime'] ?? '09:00';
          final endTime = record['shiftEndTime'] ?? '17:00';

          // Convert time to 24-hour format if it's in AM/PM format
          final convertedStartTime = _convertTo24HourFormat(startTime);
          final convertedEndTime = _convertTo24HourFormat(endTime);

          // Create full DateTime objects
          final startDateTime =
              DateTime.parse('${shiftDate}T${convertedStartTime}:00');
          final endDateTime =
              DateTime.parse('${shiftDate}T${convertedEndTime}:00');

          return {
            'id': record['recordId'] ?? record['shiftKey'] ?? '',
            'title': 'Shift at ${record['clientEmail'] ?? 'Unknown Client'}',
            'startTime': startDateTime.toIso8601String(),
            'endTime': endDateTime.toIso8601String(),
            'employeeId': record['userEmail'] ?? '',
            'employeeName': record['userName'] ?? 'Unknown',
            'clientId': record['clientEmail'] ?? '',
            'clientName': record['clientName'] ??
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
        final activeEmployees =
            transformedEmployees.where((e) => e['status'] == 'active').length;
        final onBreakEmployees =
            transformedEmployees.where((e) => e['status'] == 'on_break').length;
        final offlineEmployees =
            transformedEmployees.where((e) => e['status'] == 'offline').length;

        final transformedData = {
          'employees': transformedEmployees,
          'shifts': transformedShifts,
          'assignments': transformedAssignments,
          'totalEmployees': totalEmployees,
          'activeEmployees': activeEmployees,
          'onBreakEmployees': onBreakEmployees,
          'offlineEmployees': offlineEmployees,
        };

        debugPrint('🔍 DEBUG: Final transformed employees data:');
        for (int i = 0; i < transformedEmployees.length; i++) {
          final emp = transformedEmployees[i];
          debugPrint(
              '🔍 DEBUG: Employee $i: ${emp['email']} -> ${emp['name']}');
        }

        // First, deserialize the data using the fromJson factory
        final employeeTrackingData =
            EmployeeTrackingData.fromJson(transformedData);
        debugPrint('🔍 DEBUG: Successfully parsed EmployeeTrackingData');
        debugPrint(
            '🔍 DEBUG: Employees in response: ${employeeTrackingData.employees.length}');

        // Now we need to manually assign the decoded photoData to each employee
        // since photoData is excluded from JSON serialization/deserialization
        final List<EmployeeStatus> updatedEmployees = [];

        for (int i = 0; i < employeeTrackingData.employees.length; i++) {
          final emp = employeeTrackingData.employees[i];
          final originalData = transformedEmployees[i];

          // Check if we have decoded photoData for this employee
          if (originalData.containsKey('_decodedPhotoData')) {
            final Uint8List photoData = originalData['_decodedPhotoData'];
            debugPrint(
                '🔍 DEBUG: Assigning decoded photoData to ${emp.email} (${photoData.length} bytes)');

            // Create a new EmployeeStatus with the photoData field populated
            // Since we're using freezed, copyWith is automatically generated
            final updatedEmp = emp.copyWith(photoData: photoData);
            updatedEmployees.add(updatedEmp);
          } else {
            updatedEmployees.add(emp);
          }

          debugPrint(
              '🔍 DEBUG: Final Employee $i: ${emp.email} -> ${emp.name}');
        }

        // Create a new EmployeeTrackingData with the updated employees
        // Since we're using freezed, copyWith is automatically generated
        final updatedEmployeeTrackingData =
            employeeTrackingData.copyWith(employees: updatedEmployees);

        return updatedEmployeeTrackingData;
      } else {
        debugPrint('🔍 DEBUG: ERROR - API response failed or is null');
        debugPrint('🔍 DEBUG: Response: $response');
        throw Exception(
            'Failed to fetch employee tracking data: ${response?['error'] ?? 'Unknown error'}');
      }
    } catch (e) {
      debugPrint('🔍 DEBUG: Exception in getEmployeeTrackingData: $e');
      // Handle error - you might want to show a snackbar
      rethrow;
    }
  }

  /// Refreshes employee tracking data
  Future<EmployeeTrackingData> refreshEmployeeTrackingData() async {
    return await getEmployeeTrackingData();
  }

  /// Updates employee status (placeholder for future functionality)
  /// TODO: Implement updateEmployeeStatus method in ApiMethod class
  Future<bool> updateEmployeeStatus(
      String employeeId, WorkStatus status) async {
    try {
      final sharedPrefs = SharedPreferencesUtils();
      await sharedPrefs.init();
      final organizationId = sharedPrefs.getString('organizationId');

      if (organizationId == null || organizationId.isEmpty) {
        throw Exception('Organization ID not found');
      }

      // TODO: Implement the actual API call once the backend endpoint is ready
      // For now, return true as a placeholder
      debugPrint(
          'updateEmployeeStatus called for employee: $employeeId, status: ${status.name}');
      debugPrint('Organization ID: $organizationId');

      // Simulate successful update
      await Future.delayed(const Duration(milliseconds: 500));
      return true;
    } catch (e) {
      throw Exception('Error updating employee status: ${e.toString()}');
    }
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
            const Duration(seconds: 30)); // Poll every 30 seconds
      } catch (e) {
        // Handle error silently or yield empty list
        yield [];
        await Future.delayed(
            const Duration(seconds: 60)); // Wait longer on error
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
          RegExp(r'\s*(am|pm)\s*', caseSensitive: false), '');

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
      debugPrint('Error converting time format: $e');
    }

    // Return original string if conversion fails
    return timeStr;
  }
}
