// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_tracking_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EmployeeTrackingDataImpl _$$EmployeeTrackingDataImplFromJson(
        Map<String, dynamic> json) =>
    _$EmployeeTrackingDataImpl(
      employees: (json['employees'] as List<dynamic>?)
              ?.map((e) => EmployeeStatus.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      shifts: (json['shifts'] as List<dynamic>?)
              ?.map((e) => ShiftDetail.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      assignments: (json['assignments'] as List<dynamic>?)
              ?.map((e) => ClientAssignment.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      totalEmployees: (json['totalEmployees'] as num?)?.toInt() ?? 0,
      activeEmployees: (json['activeEmployees'] as num?)?.toInt() ?? 0,
      onBreakEmployees: (json['onBreakEmployees'] as num?)?.toInt() ?? 0,
      offlineEmployees: (json['offlineEmployees'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$EmployeeTrackingDataImplToJson(
        _$EmployeeTrackingDataImpl instance) =>
    <String, dynamic>{
      'employees': instance.employees,
      'shifts': instance.shifts,
      'assignments': instance.assignments,
      'totalEmployees': instance.totalEmployees,
      'activeEmployees': instance.activeEmployees,
      'onBreakEmployees': instance.onBreakEmployees,
      'offlineEmployees': instance.offlineEmployees,
    };

_$EmployeeStatusImpl _$$EmployeeStatusImplFromJson(Map<String, dynamic> json) =>
    _$EmployeeStatusImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      status: $enumDecode(_$WorkStatusEnumMap, json['status']),
      profileImage: json['profileImage'] as String?,
      filename: json['filename'] as String?,
      currentLocation: json['currentLocation'] as String?,
      lastSeen: json['lastSeen'] == null
          ? null
          : DateTime.parse(json['lastSeen'] as String),
      currentShiftId: json['currentShiftId'] as String?,
      assignedClientId: json['assignedClientId'] as String?,
      hoursWorked: (json['hoursWorked'] as num?)?.toDouble() ?? 0.0,
      isOnBreak: json['isOnBreak'] as bool? ?? false,
    );

Map<String, dynamic> _$$EmployeeStatusImplToJson(
        _$EmployeeStatusImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'status': _$WorkStatusEnumMap[instance.status]!,
      'profileImage': instance.profileImage,
      'filename': instance.filename,
      'currentLocation': instance.currentLocation,
      'lastSeen': instance.lastSeen?.toIso8601String(),
      'currentShiftId': instance.currentShiftId,
      'assignedClientId': instance.assignedClientId,
      'hoursWorked': instance.hoursWorked,
      'isOnBreak': instance.isOnBreak,
    };

const _$WorkStatusEnumMap = {
  WorkStatus.active: 'active',
  WorkStatus.onBreak: 'on_break',
  WorkStatus.offline: 'offline',
  WorkStatus.clockedOut: 'clocked_out',
};

_$ShiftDetailImpl _$$ShiftDetailImplFromJson(Map<String, dynamic> json) =>
    _$ShiftDetailImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      employeeId: json['employeeId'] as String,
      employeeName: json['employeeName'] as String,
      clientId: json['clientId'] as String?,
      clientName: json['clientName'] as String?,
      location: json['location'] as String?,
      status: $enumDecode(_$ShiftStatusEnumMap, json['status']),
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$$ShiftDetailImplToJson(_$ShiftDetailImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime.toIso8601String(),
      'employeeId': instance.employeeId,
      'employeeName': instance.employeeName,
      'clientId': instance.clientId,
      'clientName': instance.clientName,
      'location': instance.location,
      'status': _$ShiftStatusEnumMap[instance.status]!,
      'notes': instance.notes,
    };

const _$ShiftStatusEnumMap = {
  ShiftStatus.scheduled: 'scheduled',
  ShiftStatus.inProgress: 'in_progress',
  ShiftStatus.completed: 'completed',
  ShiftStatus.cancelled: 'cancelled',
};

_$ClientAssignmentImpl _$$ClientAssignmentImplFromJson(
        Map<String, dynamic> json) =>
    _$ClientAssignmentImpl(
      id: json['id'] as String,
      clientName: json['clientName'] as String,
      employeeId: json['employeeId'] as String,
      employeeName: json['employeeName'] as String,
      assignedDate: DateTime.parse(json['assignedDate'] as String),
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      status: $enumDecode(_$AssignmentStatusEnumMap, json['status']),
      notes: json['notes'] as String?,
      location: json['location'] as String?,
    );

Map<String, dynamic> _$$ClientAssignmentImplToJson(
        _$ClientAssignmentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'clientName': instance.clientName,
      'employeeId': instance.employeeId,
      'employeeName': instance.employeeName,
      'assignedDate': instance.assignedDate.toIso8601String(),
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'status': _$AssignmentStatusEnumMap[instance.status]!,
      'notes': instance.notes,
      'location': instance.location,
    };

const _$AssignmentStatusEnumMap = {
  AssignmentStatus.active: 'active',
  AssignmentStatus.pending: 'pending',
  AssignmentStatus.completed: 'completed',
  AssignmentStatus.cancelled: 'cancelled',
};
