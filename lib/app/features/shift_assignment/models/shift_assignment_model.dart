

import 'package:flutter/foundation.dart';

/// Model representing a shift assignment with all necessary details
class ShiftAssignmentModel {
  final String userEmail;
  final String clientEmail;
  final List<String> dateList;
  final List<String> startTimeList;
  final List<String> endTimeList;
  final List<String> breakList;
  final List<String>? timeWorkedList;
  final DateTime createdAt;
  final String assignmentId;

  const ShiftAssignmentModel({
    required this.userEmail,
    required this.clientEmail,
    required this.dateList,
    required this.startTimeList,
    required this.endTimeList,
    required this.breakList,
    this.timeWorkedList,
    required this.createdAt,
    required this.assignmentId,
  });

  /// Factory constructor to create from Map (API response)
  factory ShiftAssignmentModel.fromMap(Map<String, dynamic> map) {
    return ShiftAssignmentModel(
      userEmail: map['userEmail'] ?? '',
      clientEmail: map['clientEmail'] ?? '',
      dateList: List<String>.from(map['dateList'] ?? []),
      startTimeList: List<String>.from(map['startTimeList'] ?? []),
      endTimeList: List<String>.from(map['endTimeList'] ?? []),
      breakList: List<String>.from(map['breakList'] ?? []),
      timeWorkedList: map['timeWorkedList'] != null
          ? List<String>.from(map['timeWorkedList'])
          : null,
      createdAt: DateTime.tryParse(map['createdAt'] ?? '') ?? DateTime.now(),
      assignmentId: map['assignmentId'] ?? '',
    );
  }

  /// Factory constructor to create from shift data
  factory ShiftAssignmentModel.fromShiftData({
    required String userEmail,
    required String clientEmail,
    required Map<String, dynamic> shiftData,
    String? assignmentId,
  }) {
    return ShiftAssignmentModel(
      userEmail: userEmail,
      clientEmail: clientEmail,
      dateList: List<String>.from(shiftData['dateList'] ?? []),
      startTimeList: List<String>.from(shiftData['startTimeList'] ?? []),
      endTimeList: List<String>.from(shiftData['endTimeList'] ?? []),
      breakList: List<String>.from(shiftData['breakList'] ?? []),
      timeWorkedList: shiftData['Time'] != null
          ? List<String>.from(shiftData['Time'])
          : null,
      createdAt: DateTime.now(),
      assignmentId:
          assignmentId ?? DateTime.now().millisecondsSinceEpoch.toString(),
    );
  }

  /// Convert to Map for API calls
  Map<String, dynamic> toMap() {
    return {
      'userEmail': userEmail,
      'clientEmail': clientEmail,
      'dateList': dateList,
      'startTimeList': startTimeList,
      'endTimeList': endTimeList,
      'breakList': breakList,
      'timeWorkedList': timeWorkedList,
      'createdAt': createdAt.toIso8601String(),
      'assignmentId': assignmentId,
    };
  }

  /// Get total number of shifts
  int get totalShifts => dateList.length;

  /// Check if assignment has time worked data
  bool get hasTimeWorked =>
      timeWorkedList != null && timeWorkedList!.isNotEmpty;

  /// Get formatted assignment summary
  String get assignmentSummary =>
      '$totalShifts shift${totalShifts > 1 ? 's' : ''} assigned';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ShiftAssignmentModel &&
        other.userEmail == userEmail &&
        other.clientEmail == clientEmail &&
        listEquals(other.dateList, dateList) &&
        listEquals(other.startTimeList, startTimeList) &&
        listEquals(other.endTimeList, endTimeList) &&
        listEquals(other.breakList, breakList) &&
        listEquals(other.timeWorkedList, timeWorkedList) &&
        other.createdAt == createdAt &&
        other.assignmentId == assignmentId;
  }

  @override
  int get hashCode {
    return Object.hash(
      userEmail,
      clientEmail,
      Object.hashAll(dateList),
      Object.hashAll(startTimeList),
      Object.hashAll(endTimeList),
      Object.hashAll(breakList),
      Object.hashAll(timeWorkedList ?? []),
      createdAt,
      assignmentId,
    );
  }

  @override
  String toString() {
    return 'ShiftAssignmentModel(userEmail: $userEmail, clientEmail: $clientEmail, totalShifts: $totalShifts, assignmentId: $assignmentId)';
  }
}
