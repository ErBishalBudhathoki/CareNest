import 'package:carenest/app/core/providers/app_providers.dart';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';
import 'package:carenest/backend/api_method.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final assignmentListViewModelProvider =
    NotifierProvider<AssignmentListViewModel, AssignmentListState>(
  AssignmentListViewModel.new,
);

// --- State Class ---
@immutable
class AssignmentListState {
  final List<Map<String, dynamic>> assignments;
  final bool isLoading;
  final String errorMessage;

  const AssignmentListState({
    this.assignments = const [],
    this.isLoading = false,
    this.errorMessage = '',
  });

  AssignmentListState copyWith({
    List<Map<String, dynamic>>? assignments,
    bool? isLoading,
    String? errorMessage,
  }) {
    return AssignmentListState(
      assignments: assignments ?? this.assignments,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

// --- Notifier Class ---
class AssignmentListViewModel extends Notifier<AssignmentListState> {
  late ApiMethod _apiMethod;
  late SharedPreferencesUtils _sharedPrefs;

  @override
  AssignmentListState build() {
    // Read dependencies inside the build method
    _apiMethod = ref.read(apiMethodProvider);
    _sharedPrefs = ref.read(sharedPreferencesProvider);
    // Return the initial state
    return const AssignmentListState();
  }

  /// Load all assignments for a specific organization
  /// This method fetches assignments only for the admin's organization
  // Future<void> loadOrganizationAssignments(String organizationId) async {
  //   await _sharedPrefs.init();
  //   final String? orgId = _sharedPrefs.getString('organizationId');
  //   debugPrint("org id $orgId");
  //   if (orgId == null) {
  //     errorMessage.value = 'Organization ID not found';
  //     return;
  //   }

  //   if (orgId.isEmpty) {
  //     errorMessage.value = 'Organization ID is required';
  //     return;
  //   }

  //   try {
  //     isLoading.value = true;
  //     errorMessage.value = '';

  //     debugPrint('Loading assignments for organization: $orgId');

  //     final response = await _apiMethod.getOrganizationAssignments(orgId);

  //     debugPrint('Assignment response: $response');

  //     if (response['success'] == true) {
  //       final List<dynamic> assignmentData = response['assignments'] ?? [];

  //       // Convert to List<Map<String, dynamic>> and sort by creation date
  //       assignments.value = assignmentData
  //           .map((item) => Map<String, dynamic>.from(item)
  //             ..['assignedNdisItemNumber'] = item['assignedNdisItemNumber'])
  //           .toList()
  //         ..sort((a, b) {
  //           final aDate = a['createdAt']?.toString() ?? '';
  //           final bDate = b['createdAt']?.toString() ?? '';
  //           return bDate.compareTo(aDate); // Sort newest first
  //         });

  //       debugPrint('Loaded ${assignments.length} assignments');
  //     } else {
  //       errorMessage.value =
  //           response['message'] ?? 'Failed to load assignments';
  //       assignments.clear();
  //     }
  //   } catch (e) {
  //     debugPrint('Error loading organization assignments: $e');
  //     errorMessage.value = 'Error loading assignments: $e';
  //     assignments.clear();
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  /// Load all assignments for a specific organization
  Future<void> loadOrganizationAssignments(String organizationId) async {
    await _sharedPrefs.init();
    final String? orgId = _sharedPrefs.getString('organizationId');
    if (orgId == null || orgId.isEmpty) {
      state = state.copyWith(errorMessage: 'Organization ID not found');
      return;
    }

    state = state.copyWith(isLoading: true, errorMessage: '');

    try {
      debugPrint('Loading assignments for organization: $orgId');
      final response = await _apiMethod.getOrganizationAssignments(orgId);

      if (response != null && response['success'] == true) {
        final List<dynamic> assignmentData = response['assignments'] ?? [];
        final newAssignments = assignmentData
            .map((item) => Map<String, dynamic>.from(item)
              ..['assignedNdisItemNumber'] = item['assignedNdisItemNumber'])
            .toList()
          ..sort((a, b) {
            final aDate = a['createdAt']?.toString() ?? '';
            final bDate = b['createdAt']?.toString() ?? '';
            return bDate.compareTo(aDate); // Sort newest first
          });

        state = state.copyWith(assignments: newAssignments, isLoading: false);
      } else {
        state = state.copyWith(
          errorMessage: response?['message'] ?? 'Failed to load assignments',
          assignments: [],
          isLoading: false,
        );
      }
    } catch (e) {
      debugPrint('Error loading organization assignments: $e');
      state = state.copyWith(
        errorMessage: 'Error loading assignments: $e',
        assignments: [],
        isLoading: false,
      );
    }
  }

  /// Load assignments for a specific user (alternative method)
  /// This can be used if we want to show assignments for a specific user
  Future<void> loadUserAssignments(String userEmail) async {
    if (userEmail.isEmpty) {
      state = state.copyWith(errorMessage: 'User email is required');
      return;
    }

    state = state.copyWith(isLoading: true, errorMessage: '');

    try {
      debugPrint('Loading assignments for user: $userEmail');

      final response = await _apiMethod.getUserAssignments(userEmail);

      debugPrint('User assignment response: $response');

      if (response['success'] == true) {
        final List<dynamic> assignmentData = response['assignments'] ?? [];

        // Convert to List<Map<String, dynamic>> and sort by creation date
        final newAssignments = assignmentData
            .map((item) => Map<String, dynamic>.from(item)
              ..['assignedNdisItemNumber'] = item['assignedNdisItemNumber'])
            .toList()
          ..sort((a, b) {
            final aDate = a['createdAt']?.toString() ?? '';
            final bDate = b['createdAt']?.toString() ?? '';
            return bDate.compareTo(aDate); // Sort newest first
          });

        state = state.copyWith(assignments: newAssignments, isLoading: false);
        debugPrint('Loaded ${state.assignments.length} user assignments');
      } else {
        state = state.copyWith(
          errorMessage:
              response['message'] ?? 'Failed to load user assignments',
          assignments: [],
          isLoading: false,
        );
      }
    } catch (e) {
      debugPrint('Error loading user assignments: $e');
      state = state.copyWith(
        errorMessage: 'Error loading user assignments: $e',
        assignments: [],
        isLoading: false,
      );
    }
  }

  /// Refresh assignments
  Future<void> refreshAssignments(String organizationId) async {
    await loadOrganizationAssignments(organizationId);
  }

  /// Clear all data
  void clearData() {
    state = state.copyWith(
      assignments: [],
      errorMessage: '',
      isLoading: false,
    );
  }

  /// Get assignment count
  int get assignmentCount => state.assignments.length;

  /// Check if there are any assignments
  bool get hasAssignments => state.assignments.isNotEmpty;

  /// Get assignments for a specific user
  List<Map<String, dynamic>> getAssignmentsForUser(String userEmail) {
    return state.assignments
        .where((assignment) =>
            assignment['userEmail']?.toString().toLowerCase() ==
            userEmail.toLowerCase())
        .toList();
  }

  /// Get assignments for a specific client
  List<Map<String, dynamic>> getAssignmentsForClient(String clientEmail) {
    return state.assignments
        .where((assignment) =>
            assignment['clientEmail']?.toString().toLowerCase() ==
            clientEmail.toLowerCase())
        .toList();
  }

  /// Calculate total hours for all assignments
  double getTotalHours() {
    double total = 0.0;

    for (final assignment in state.assignments) {
      final List<dynamic> startTimes = assignment['startTimeList'] ?? [];
      final List<dynamic> endTimes = assignment['endTimeList'] ?? [];
      final List<dynamic> breaks = assignment['breakList'] ?? [];

      total += _calculateAssignmentHours(startTimes, endTimes, breaks);
    }

    return total;
  }

  /// Calculate hours for a single assignment
  double _calculateAssignmentHours(
      List<dynamic> startTimes, List<dynamic> endTimes, List<dynamic> breaks) {
    if (startTimes.isEmpty || endTimes.isEmpty) return 0.0;

    double totalHours = 0.0;

    for (int i = 0; i < startTimes.length && i < endTimes.length; i++) {
      final startTime = startTimes[i]?.toString() ?? '';
      final endTime = endTimes[i]?.toString() ?? '';
      final breakTime = i < breaks.length ? breaks[i]?.toString() ?? '' : '';

      final shiftHours = _calculateShiftHours(startTime, endTime, breakTime);
      totalHours += shiftHours;
    }

    return totalHours;
  }

  /// Calculate hours for a single shift
  double _calculateShiftHours(
      String startTime, String endTime, String breakTime) {
    try {
      final start = _parseTime(startTime);
      final end = _parseTime(endTime);
      final breakHours = _parseBreakTime(breakTime);

      if (start != null && end != null) {
        double duration = end.difference(start).inMinutes / 60.0;
        if (duration < 0) duration += 24; // Handle overnight shifts
        return (duration - breakHours).clamp(0.0, 24.0);
      }
    } catch (e) {
      debugPrint('Error calculating shift hours: $e');
    }
    return 0.0;
  }

  /// Parse time string to DateTime
  DateTime? _parseTime(String timeString) {
    if (timeString.isEmpty) return null;

    try {
      final now = DateTime.now();

      // Handle 12-hour format with AM/PM
      if (timeString.toUpperCase().contains('AM') ||
          timeString.toUpperCase().contains('PM')) {
        final cleanTime = timeString.trim().toUpperCase();
        final isAM = cleanTime.contains('AM');
        final timeOnly = cleanTime.replaceAll(RegExp(r'[AP]M'), '').trim();

        final parts = timeOnly.split(':');
        if (parts.length >= 2) {
          int hour = int.parse(parts[0]);
          final minute = int.parse(parts[1]);

          // Convert to 24-hour format
          if (!isAM && hour != 12) {
            hour += 12;
          } else if (isAM && hour == 12) {
            hour = 0;
          }

          return DateTime(now.year, now.month, now.day, hour, minute);
        }
      }

      // Handle 24-hour format
      if (timeString.contains(':')) {
        final parts = timeString.split(':');
        if (parts.length >= 2) {
          final hour = int.parse(parts[0]);
          final minute = int.parse(parts[1]);
          return DateTime(now.year, now.month, now.day, hour, minute);
        }
      }
    } catch (e) {
      debugPrint('Error parsing time "$timeString": $e');
    }

    return null;
  }

  /// Parse break time string to hours
  double _parseBreakTime(String breakString) {
    if (breakString.isEmpty) return 0.0;

    final breakLower = breakString.toLowerCase().trim();

    // Handle "No" or "None" cases
    if (breakLower == 'no' || breakLower == 'none') {
      return 0.0;
    }

    // Handle "Yes" case (assume 0.5 hours)
    if (breakLower == 'yes') {
      return 0.5;
    }

    // Try to parse as number
    try {
      return double.parse(breakString);
    } catch (e) {
      debugPrint('Error parsing break time "$breakString": $e');
      return 0.0;
    }
  }
}
