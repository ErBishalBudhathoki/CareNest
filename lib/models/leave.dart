import 'package:freezed_annotation/freezed_annotation.dart';

part 'leave.freezed.dart';
part 'leave.g.dart';

@freezed
abstract class LeaveBalance with _$LeaveBalance {
  const factory LeaveBalance({
    required double annualLeave,
    required double sickLeave,
    required double personalLeave,
    required double longServiceLeave,
  }) = _LeaveBalance;

  factory LeaveBalance.fromJson(Map<String, dynamic> json) =>
      _$LeaveBalanceFromJson(json);
}

@freezed
abstract class LeaveRequest with _$LeaveRequest {
  const factory LeaveRequest({
    @JsonKey(name: '_id') String? id,
    required String userId,
    required String organizationId,
    required String createdBy,
    required String leaveType,
    required DateTime startDate,
    required DateTime endDate,
    required double totalHours,
    required String reason,
    @Default('Pending') String status,
    String? approverId,
    DateTime? approvedAt,
    String? rejectionReason,
    List<LeaveAttachment>? attachments,
    List<LeaveHistory>? history,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _LeaveRequest;

  factory LeaveRequest.fromJson(Map<String, dynamic> json) =>
      _$LeaveRequestFromJson(json);
}

@freezed
abstract class LeaveAttachment with _$LeaveAttachment {
  const factory LeaveAttachment({
    required String filename,
    required String url,
    required DateTime uploadedAt,
  }) = _LeaveAttachment;

  factory LeaveAttachment.fromJson(Map<String, dynamic> json) =>
      _$LeaveAttachmentFromJson(json);
}

@freezed
abstract class LeaveHistory with _$LeaveHistory {
  const factory LeaveHistory({
    required String action,
    required String performedBy,
    required DateTime timestamp,
    String? status,
    String? reason,
  }) = _LeaveHistory;

  factory LeaveHistory.fromJson(Map<String, dynamic> json) =>
      _$LeaveHistoryFromJson(json);
}

@freezed
abstract class PublicHoliday with _$PublicHoliday {
  const factory PublicHoliday({
    @JsonKey(name: '_id') String? id,
    required String name,
    required DateTime date,
    required String day,
    String? organizationId,
    @Default(false) bool isCustom,
    String? state,
  }) = _PublicHoliday;

  factory PublicHoliday.fromJson(Map<String, dynamic> json) =>
      _$PublicHolidayFromJson(json);
}

@freezed
abstract class LeaveForecast with _$LeaveForecast {
  const factory LeaveForecast({
    required LeaveBalance forecast,
    required Map<String, double> accrualRate,
  }) = _LeaveForecast;

  factory LeaveForecast.fromJson(Map<String, dynamic> json) =>
      _$LeaveForecastFromJson(json);
}
