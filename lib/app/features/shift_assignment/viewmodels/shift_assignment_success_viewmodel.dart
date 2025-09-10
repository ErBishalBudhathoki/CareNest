import 'package:flutter/material.dart';
import '../models/shift_assignment_model.dart';
import 'package:flutter/foundation.dart';

/// ViewModel for managing shift assignment success screen state and logic
class ShiftAssignmentSuccessViewModel extends ChangeNotifier {
  ShiftAssignmentModel? _assignment;
  bool _isLoading = false;
  String? _error;
  bool _animationsCompleted = false;

  // Getters
  ShiftAssignmentModel? get assignment => _assignment;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get animationsCompleted => _animationsCompleted;
  bool get hasAssignment => _assignment != null;

  /// Initialize the assignment data
  void initializeAssignment({
    required String userEmail,
    required String clientEmail,
    required Map<String, dynamic> shiftData,
    String? assignmentId,
  }) {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      _assignment = ShiftAssignmentModel.fromShiftData(
        userEmail: userEmail,
        clientEmail: clientEmail,
        shiftData: shiftData,
        assignmentId: assignmentId,
      );

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = 'Failed to initialize assignment: ${e.toString()}';
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Set assignment from existing model
  void setAssignment(ShiftAssignmentModel assignment) {
    _assignment = assignment;
    _error = null;
    notifyListeners();
  }

  /// Mark animations as completed
  void setAnimationsCompleted() {
    _animationsCompleted = true;
    notifyListeners();
  }

  /// Reset animations state
  void resetAnimations() {
    _animationsCompleted = false;
    notifyListeners();
  }

  /// Clear error state
  void clearError() {
    _error = null;
    notifyListeners();
  }

  /// Get formatted employee name (extract from email)
  String getEmployeeName() {
    if (_assignment?.userEmail.isEmpty ?? true) return 'Unknown Employee';
    final email = _assignment!.userEmail;
    final atIndex = email.indexOf('@');
    if (atIndex > 0) {
      return email
          .substring(0, atIndex)
          .replaceAll('.', ' ')
          .split(' ')
          .map((word) =>
              word.isNotEmpty ? word[0].toUpperCase() + word.substring(1) : '')
          .join(' ');
    }
    return email;
  }

  /// Get formatted client name (extract from email)
  String getClientName() {
    if (_assignment?.clientEmail.isEmpty ?? true) return 'Unknown Client';
    final email = _assignment!.clientEmail;
    final atIndex = email.indexOf('@');
    if (atIndex > 0) {
      return email
          .substring(0, atIndex)
          .replaceAll('.', ' ')
          .split(' ')
          .map((word) =>
              word.isNotEmpty ? word[0].toUpperCase() + word.substring(1) : '')
          .join(' ');
    }
    return email;
  }

  /// Get shift details for a specific index
  Map<String, String> getShiftDetails(int index) {
    if (_assignment == null || index >= _assignment!.totalShifts) {
      return {};
    }

    return {
      'date': _assignment!.dateList[index],
      'startTime': _assignment!.startTimeList[index],
      'endTime': _assignment!.endTimeList[index],
      'break': _assignment!.breakList[index],
      if (_assignment!.hasTimeWorked &&
          index < _assignment!.timeWorkedList!.length)
        'timeWorked': _assignment!.timeWorkedList![index],
    };
  }

  /// Calculate total working hours across all shifts
  String getTotalWorkingHours() {
    if (_assignment == null) return '0 hours';

    double totalHours = 0;

    for (int i = 0; i < _assignment!.totalShifts; i++) {
      try {
        final startTime = _parseTime(_assignment!.startTimeList[i]);
        final endTime = _parseTime(_assignment!.endTimeList[i]);
        final breakTime = _parseBreakTime(_assignment!.breakList[i]);

        if (startTime != null && endTime != null) {
          double shiftHours = _calculateShiftDuration(startTime, endTime);
          shiftHours -= breakTime; // Subtract break time
          if (shiftHours > 0) totalHours += shiftHours;
        }
      } catch (e) {
        // Skip invalid time entries
        continue;
      }
    }

    return '${totalHours.toStringAsFixed(1)} hours';
  }

  /// Calculate shift duration in hours, handling overnight shifts
  double _calculateShiftDuration(DateTime startTime, DateTime endTime) {
    Duration duration = endTime.difference(startTime);
    
    // Handle overnight shifts (when end time is before start time)
    if (duration.isNegative) {
      // Add 24 hours for overnight shifts
      duration = duration + const Duration(days: 1);
    }
    
    return duration.inMinutes / 60.0;
  }

  /// Parse time string to DateTime
  DateTime? _parseTime(String timeStr) {
    try {
      // Handle different time formats: "HH:MM", "H:MM AM/PM", etc.
      String cleanTimeStr = timeStr.trim();
      
      // Check if it's AM/PM format
      bool isPM = cleanTimeStr.toLowerCase().contains('pm');
      bool isAM = cleanTimeStr.toLowerCase().contains('am');
      
      // Remove AM/PM and extra spaces
      cleanTimeStr = cleanTimeStr.replaceAll(RegExp(r'\s*(am|pm)\s*', caseSensitive: false), '');
      
      final parts = cleanTimeStr.split(':');
      if (parts.length >= 2) {
        int hour = int.parse(parts[0]);
        final minuteParts = parts[1].split(' ');
        final minute = int.parse(minuteParts.isNotEmpty ? minuteParts[0] : parts[1]); // Handle any trailing spaces
        
        // Convert 12-hour to 24-hour format
        if (isPM && hour != 12) {
          hour += 12;
        } else if (isAM && hour == 12) {
          hour = 0;
        }
        
        final now = DateTime.now();
        return DateTime(now.year, now.month, now.day, hour, minute);
      }
    } catch (e) {
      // Invalid time format
      debugPrint('Error parsing time "$timeStr": $e');
    }
    return null;
  }

  /// Parse break time string to hours
  double _parseBreakTime(String breakStr) {
    try {
      // Handle "No" break case
      if (breakStr.toLowerCase() == 'no' || breakStr.toLowerCase() == 'none') {
        return 0.0;
      }
      
      // Handle "Yes" break case (default to 30 minutes)
      if (breakStr.toLowerCase() == 'yes') {
        return 0.5; // 30 minutes = 0.5 hours
      }
      
      // Handle different break formats: "30 min", "1 hour", "1.5", etc.
      final cleanStr =
          breakStr.toLowerCase().replaceAll(RegExp(r'[^0-9.]'), '');
      if (cleanStr.isNotEmpty) {
        final breakValue = double.parse(cleanStr);
        // If break contains "min", convert to hours
        if (breakStr.toLowerCase().contains('min')) {
          return breakValue / 60.0;
        }
        return breakValue;
      }
    } catch (e) {
      // Invalid break format
      debugPrint('Error parsing break "$breakStr": $e');
    }
    return 0.0;
  }

  @override
  void dispose() {
    super.dispose();
  }
}