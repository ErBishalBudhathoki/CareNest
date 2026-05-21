// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shared_employee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SharedEmployeeAssignment _$SharedEmployeeAssignmentFromJson(
        Map<String, dynamic> json) =>
    _SharedEmployeeAssignment(
      id: json['id'] as String,
      employeeId: json['employeeId'] as String,
      organizationId: json['organizationId'] as String,
      assignmentType: json['assignmentType'] as String,
      costAllocation: (json['costAllocation'] as num?)?.toDouble() ?? 100,
      hourlyRate: (json['hourlyRate'] as num?)?.toDouble() ?? 0,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      status: json['status'] as String? ?? 'active',
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$SharedEmployeeAssignmentToJson(
        _SharedEmployeeAssignment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'employeeId': instance.employeeId,
      'organizationId': instance.organizationId,
      'assignmentType': instance.assignmentType,
      'costAllocation': instance.costAllocation,
      'hourlyRate': instance.hourlyRate,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'status': instance.status,
      'notes': instance.notes,
    };
