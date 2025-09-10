import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:typed_data';

part 'employee_tracking_model.freezed.dart';
part 'employee_tracking_model.g.dart';

@freezed
class EmployeeTrackingData with _$EmployeeTrackingData {
  const factory EmployeeTrackingData({
    @Default([]) List<EmployeeStatus> employees,
    @Default([]) List<ShiftDetail> shifts,
    @Default([]) List<ClientAssignment> assignments,
    @Default(0) int totalEmployees,
    @Default(0) int activeEmployees,
    @Default(0) int onBreakEmployees,
    @Default(0) int offlineEmployees,
  }) = _EmployeeTrackingData;

  factory EmployeeTrackingData.fromJson(Map<String, dynamic> json) =>
      _$EmployeeTrackingDataFromJson(json);
}

@freezed
class EmployeeStatus with _$EmployeeStatus {
  const factory EmployeeStatus({
    required String id,
    required String name,
    required String email,
    required WorkStatus status,
    String? profileImage,
    String? filename,
    @JsonKey(includeFromJson: false, includeToJson: false) Uint8List? photoData,
    String? currentLocation,
    DateTime? lastSeen,
    String? currentShiftId,
    String? assignedClientId,
    @Default(0.0) double hoursWorked,
    @Default(false) bool isOnBreak,
  }) = _EmployeeStatus;

  factory EmployeeStatus.fromJson(Map<String, dynamic> json) =>
      _$EmployeeStatusFromJson(json);
}

@freezed
class ShiftDetail with _$ShiftDetail {
  const factory ShiftDetail({
    required String id,
    required String title,
    required DateTime startTime,
    required DateTime endTime,
    required String employeeId,
    required String employeeName,
    String? clientId,
    String? clientName,
    String? location,
    required ShiftStatus status,
    String? notes,
  }) = _ShiftDetail;

  factory ShiftDetail.fromJson(Map<String, dynamic> json) =>
      _$ShiftDetailFromJson(json);
}

@freezed
class ClientAssignment with _$ClientAssignment {
  const factory ClientAssignment({
    required String id,
    required String clientName,
    required String employeeId,
    required String employeeName,
    required DateTime assignedDate,
    DateTime? startDate,
    DateTime? endDate,
    required AssignmentStatus status,
    String? notes,
    String? location,
  }) = _ClientAssignment;

  factory ClientAssignment.fromJson(Map<String, dynamic> json) =>
      _$ClientAssignmentFromJson(json);
}

enum WorkStatus {
  @JsonValue('active')
  active,
  @JsonValue('on_break')
  onBreak,
  @JsonValue('offline')
  offline,
  @JsonValue('clocked_out')
  clockedOut,
}

enum ShiftStatus {
  @JsonValue('scheduled')
  scheduled,
  @JsonValue('in_progress')
  inProgress,
  @JsonValue('completed')
  completed,
  @JsonValue('cancelled')
  cancelled,
}

enum AssignmentStatus {
  @JsonValue('active')
  active,
  @JsonValue('pending')
  pending,
  @JsonValue('completed')
  completed,
  @JsonValue('cancelled')
  cancelled,
}
