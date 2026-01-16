import 'package:freezed_annotation/freezed_annotation.dart';

part 'trip.freezed.dart';
part 'trip.g.dart';

@freezed
class Trip with _$Trip {
  const factory Trip({
    @JsonKey(name: '_id') required String id,
    required String organizationId,
    required String userId,
    String? clientId,
    required DateTime date,
    required String startLocation,
    required String endLocation,
    required double distance,
    required String tripType, // 'BETWEEN_CLIENTS', 'WITH_CLIENT', 'COMMUTE'
    required String status, // 'PENDING', 'APPROVED', 'REJECTED'
    String? adminApprovalStatus,
    @Default(false) bool isReimbursable,
    @Default(false) bool isBillable,
    
    // Joined fields
    EmployeeInfo? employee,
  }) = _Trip;

  factory Trip.fromJson(Map<String, dynamic> json) => _$TripFromJson(json);
}

@freezed
class EmployeeInfo with _$EmployeeInfo {
  const factory EmployeeInfo({
    String? firstName,
    String? lastName,
    String? email,
  }) = _EmployeeInfo;

  factory EmployeeInfo.fromJson(Map<String, dynamic> json) => _$EmployeeInfoFromJson(json);
}
