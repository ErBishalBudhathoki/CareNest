// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LeaveBalanceImpl _$$LeaveBalanceImplFromJson(Map<String, dynamic> json) =>
    _$LeaveBalanceImpl(
      annualLeave: (json['annualLeave'] as num).toDouble(),
      sickLeave: (json['sickLeave'] as num).toDouble(),
      personalLeave: (json['personalLeave'] as num).toDouble(),
      longServiceLeave: (json['longServiceLeave'] as num).toDouble(),
    );

Map<String, dynamic> _$$LeaveBalanceImplToJson(_$LeaveBalanceImpl instance) =>
    <String, dynamic>{
      'annualLeave': instance.annualLeave,
      'sickLeave': instance.sickLeave,
      'personalLeave': instance.personalLeave,
      'longServiceLeave': instance.longServiceLeave,
    };

_$LeaveRequestImpl _$$LeaveRequestImplFromJson(Map<String, dynamic> json) =>
    _$LeaveRequestImpl(
      id: json['_id'] as String?,
      userId: json['userId'] as String,
      organizationId: json['organizationId'] as String,
      createdBy: json['createdBy'] as String,
      leaveType: json['leaveType'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      totalHours: (json['totalHours'] as num).toDouble(),
      reason: json['reason'] as String,
      status: json['status'] as String? ?? 'Pending',
      approverId: json['approverId'] as String?,
      approvedAt: json['approvedAt'] == null
          ? null
          : DateTime.parse(json['approvedAt'] as String),
      rejectionReason: json['rejectionReason'] as String?,
      attachments: (json['attachments'] as List<dynamic>?)
          ?.map((e) => LeaveAttachment.fromJson(e as Map<String, dynamic>))
          .toList(),
      history: (json['history'] as List<dynamic>?)
          ?.map((e) => LeaveHistory.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$LeaveRequestImplToJson(_$LeaveRequestImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'userId': instance.userId,
      'organizationId': instance.organizationId,
      'createdBy': instance.createdBy,
      'leaveType': instance.leaveType,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'totalHours': instance.totalHours,
      'reason': instance.reason,
      'status': instance.status,
      'approverId': instance.approverId,
      'approvedAt': instance.approvedAt?.toIso8601String(),
      'rejectionReason': instance.rejectionReason,
      'attachments': instance.attachments,
      'history': instance.history,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

_$LeaveAttachmentImpl _$$LeaveAttachmentImplFromJson(
        Map<String, dynamic> json) =>
    _$LeaveAttachmentImpl(
      filename: json['filename'] as String,
      url: json['url'] as String,
      uploadedAt: DateTime.parse(json['uploadedAt'] as String),
    );

Map<String, dynamic> _$$LeaveAttachmentImplToJson(
        _$LeaveAttachmentImpl instance) =>
    <String, dynamic>{
      'filename': instance.filename,
      'url': instance.url,
      'uploadedAt': instance.uploadedAt.toIso8601String(),
    };

_$LeaveHistoryImpl _$$LeaveHistoryImplFromJson(Map<String, dynamic> json) =>
    _$LeaveHistoryImpl(
      action: json['action'] as String,
      performedBy: json['performedBy'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      status: json['status'] as String?,
      reason: json['reason'] as String?,
    );

Map<String, dynamic> _$$LeaveHistoryImplToJson(_$LeaveHistoryImpl instance) =>
    <String, dynamic>{
      'action': instance.action,
      'performedBy': instance.performedBy,
      'timestamp': instance.timestamp.toIso8601String(),
      'status': instance.status,
      'reason': instance.reason,
    };

_$PublicHolidayImpl _$$PublicHolidayImplFromJson(Map<String, dynamic> json) =>
    _$PublicHolidayImpl(
      id: json['_id'] as String?,
      name: json['name'] as String,
      date: DateTime.parse(json['date'] as String),
      day: json['day'] as String,
      organizationId: json['organizationId'] as String?,
      isCustom: json['isCustom'] as bool? ?? false,
      state: json['state'] as String?,
    );

Map<String, dynamic> _$$PublicHolidayImplToJson(_$PublicHolidayImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'date': instance.date.toIso8601String(),
      'day': instance.day,
      'organizationId': instance.organizationId,
      'isCustom': instance.isCustom,
      'state': instance.state,
    };

_$LeaveForecastImpl _$$LeaveForecastImplFromJson(Map<String, dynamic> json) =>
    _$LeaveForecastImpl(
      forecast: LeaveBalance.fromJson(json['forecast'] as Map<String, dynamic>),
      accrualRate: (json['accrualRate'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
    );

Map<String, dynamic> _$$LeaveForecastImplToJson(_$LeaveForecastImpl instance) =>
    <String, dynamic>{
      'forecast': instance.forecast,
      'accrualRate': instance.accrualRate,
    };
