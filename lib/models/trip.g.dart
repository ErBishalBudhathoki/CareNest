// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Trip _$TripFromJson(Map<String, dynamic> json) => _Trip(
      id: json['_id'] as String,
      organizationId: json['organizationId'] as String,
      userId: json['userId'] as String,
      clientId: json['clientId'] as String?,
      date: DateTime.parse(json['date'] as String),
      startLocation: json['startLocation'] as String,
      endLocation: json['endLocation'] as String,
      distance: (json['distance'] as num).toDouble(),
      tripType: json['tripType'] as String,
      status: json['status'] as String,
      adminApprovalStatus: json['adminApprovalStatus'] as String?,
      isReimbursable: json['isReimbursable'] as bool? ?? false,
      isBillable: json['isBillable'] as bool? ?? false,
      employee: json['employee'] == null
          ? null
          : EmployeeInfo.fromJson(json['employee'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TripToJson(_Trip instance) => <String, dynamic>{
      '_id': instance.id,
      'organizationId': instance.organizationId,
      'userId': instance.userId,
      'clientId': instance.clientId,
      'date': instance.date.toIso8601String(),
      'startLocation': instance.startLocation,
      'endLocation': instance.endLocation,
      'distance': instance.distance,
      'tripType': instance.tripType,
      'status': instance.status,
      'adminApprovalStatus': instance.adminApprovalStatus,
      'isReimbursable': instance.isReimbursable,
      'isBillable': instance.isBillable,
      'employee': instance.employee,
    };

_EmployeeInfo _$EmployeeInfoFromJson(Map<String, dynamic> json) =>
    _EmployeeInfo(
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      email: json['email'] as String?,
    );

Map<String, dynamic> _$EmployeeInfoToJson(_EmployeeInfo instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
    };
