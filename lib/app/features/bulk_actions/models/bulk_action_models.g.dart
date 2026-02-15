// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bulk_action_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TimesheetItemImpl _$$TimesheetItemImplFromJson(Map<String, dynamic> json) =>
    _$TimesheetItemImpl(
      id: json['id'] as String,
      workerId: json['workerId'] as String,
      workerName: json['workerName'] as String,
      date: DateTime.parse(json['date'] as String),
      hours: (json['hours'] as num).toDouble(),
      status: json['status'] as String,
      clientName: json['clientName'] as String?,
      serviceName: json['serviceName'] as String?,
    );

Map<String, dynamic> _$$TimesheetItemImplToJson(_$TimesheetItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'workerId': instance.workerId,
      'workerName': instance.workerName,
      'date': instance.date.toIso8601String(),
      'hours': instance.hours,
      'status': instance.status,
      'clientName': instance.clientName,
      'serviceName': instance.serviceName,
    };

_$BulkTimesheetResultImpl _$$BulkTimesheetResultImplFromJson(
        Map<String, dynamic> json) =>
    _$BulkTimesheetResultImpl(
      approvedCount: (json['approvedCount'] as num).toInt(),
      rejectedCount: (json['rejectedCount'] as num).toInt(),
      totalRequested: (json['totalRequested'] as num).toInt(),
    );

Map<String, dynamic> _$$BulkTimesheetResultImplToJson(
        _$BulkTimesheetResultImpl instance) =>
    <String, dynamic>{
      'approvedCount': instance.approvedCount,
      'rejectedCount': instance.rejectedCount,
      'totalRequested': instance.totalRequested,
    };

_$InvoicePreviewItemImpl _$$InvoicePreviewItemImplFromJson(
        Map<String, dynamic> json) =>
    _$InvoicePreviewItemImpl(
      clientId: json['clientId'] as String,
      clientName: json['clientName'] as String,
      clientEmail: json['clientEmail'] as String,
      appointments: (json['appointments'] as List<dynamic>)
          .map((e) => AppointmentLineItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalAmount: (json['totalAmount'] as num).toDouble(),
    );

Map<String, dynamic> _$$InvoicePreviewItemImplToJson(
        _$InvoicePreviewItemImpl instance) =>
    <String, dynamic>{
      'clientId': instance.clientId,
      'clientName': instance.clientName,
      'clientEmail': instance.clientEmail,
      'appointments': instance.appointments,
      'totalAmount': instance.totalAmount,
    };

_$AppointmentLineItemImpl _$$AppointmentLineItemImplFromJson(
        Map<String, dynamic> json) =>
    _$AppointmentLineItemImpl(
      appointmentId: json['appointmentId'] as String,
      date: DateTime.parse(json['date'] as String),
      service: json['service'] as String,
      duration: (json['duration'] as num).toDouble(),
      rate: (json['rate'] as num).toDouble(),
      amount: (json['amount'] as num).toDouble(),
    );

Map<String, dynamic> _$$AppointmentLineItemImplToJson(
        _$AppointmentLineItemImpl instance) =>
    <String, dynamic>{
      'appointmentId': instance.appointmentId,
      'date': instance.date.toIso8601String(),
      'service': instance.service,
      'duration': instance.duration,
      'rate': instance.rate,
      'amount': instance.amount,
    };

_$InvoicePreviewImpl _$$InvoicePreviewImplFromJson(Map<String, dynamic> json) =>
    _$InvoicePreviewImpl(
      invoiceCount: (json['invoiceCount'] as num).toInt(),
      totalAppointments: (json['totalAppointments'] as num).toInt(),
      totalAmount: (json['totalAmount'] as num).toDouble(),
      invoices: (json['invoices'] as List<dynamic>)
          .map((e) => InvoicePreviewItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$InvoicePreviewImplToJson(
        _$InvoicePreviewImpl instance) =>
    <String, dynamic>{
      'invoiceCount': instance.invoiceCount,
      'totalAppointments': instance.totalAppointments,
      'totalAmount': instance.totalAmount,
      'invoices': instance.invoices,
    };

_$BulkInvoiceResultImpl _$$BulkInvoiceResultImplFromJson(
        Map<String, dynamic> json) =>
    _$BulkInvoiceResultImpl(
      invoiceCount: (json['invoiceCount'] as num).toInt(),
      appointmentCount: (json['appointmentCount'] as num).toInt(),
      totalAmount: (json['totalAmount'] as num).toDouble(),
    );

Map<String, dynamic> _$$BulkInvoiceResultImplToJson(
        _$BulkInvoiceResultImpl instance) =>
    <String, dynamic>{
      'invoiceCount': instance.invoiceCount,
      'appointmentCount': instance.appointmentCount,
      'totalAmount': instance.totalAmount,
    };

_$ShiftAssignmentImpl _$$ShiftAssignmentImplFromJson(
        Map<String, dynamic> json) =>
    _$ShiftAssignmentImpl(
      shiftId: json['shiftId'] as String,
      workerId: json['workerId'] as String?,
      shiftDate: json['shiftDate'] == null
          ? null
          : DateTime.parse(json['shiftDate'] as String),
      shiftTime: json['shiftTime'] as String?,
      service: json['service'] as String?,
    );

Map<String, dynamic> _$$ShiftAssignmentImplToJson(
        _$ShiftAssignmentImpl instance) =>
    <String, dynamic>{
      'shiftId': instance.shiftId,
      'workerId': instance.workerId,
      'shiftDate': instance.shiftDate?.toIso8601String(),
      'shiftTime': instance.shiftTime,
      'service': instance.service,
    };

_$WorkerSuggestionImpl _$$WorkerSuggestionImplFromJson(
        Map<String, dynamic> json) =>
    _$WorkerSuggestionImpl(
      workerId: json['workerId'] as String,
      workerName: json['workerName'] as String,
      workerEmail: json['workerEmail'] as String,
      score: (json['score'] as num).toDouble(),
      matchReason: json['matchReason'] as String,
      conflicts:
          (json['conflicts'] as List<dynamic>).map((e) => e as String).toList(),
      rating: (json['rating'] as num).toDouble(),
    );

Map<String, dynamic> _$$WorkerSuggestionImplToJson(
        _$WorkerSuggestionImpl instance) =>
    <String, dynamic>{
      'workerId': instance.workerId,
      'workerName': instance.workerName,
      'workerEmail': instance.workerEmail,
      'score': instance.score,
      'matchReason': instance.matchReason,
      'conflicts': instance.conflicts,
      'rating': instance.rating,
    };

_$ShiftSuggestionImpl _$$ShiftSuggestionImplFromJson(
        Map<String, dynamic> json) =>
    _$ShiftSuggestionImpl(
      shiftId: json['shiftId'] as String,
      shiftDate: DateTime.parse(json['shiftDate'] as String),
      shiftTime: json['shiftTime'] as String,
      service: json['service'] as String,
      suggestedWorkers: (json['suggestedWorkers'] as List<dynamic>)
          .map((e) => WorkerSuggestion.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ShiftSuggestionImplToJson(
        _$ShiftSuggestionImpl instance) =>
    <String, dynamic>{
      'shiftId': instance.shiftId,
      'shiftDate': instance.shiftDate.toIso8601String(),
      'shiftTime': instance.shiftTime,
      'service': instance.service,
      'suggestedWorkers': instance.suggestedWorkers,
    };

_$AssignmentResultImpl _$$AssignmentResultImplFromJson(
        Map<String, dynamic> json) =>
    _$AssignmentResultImpl(
      shiftId: json['shiftId'] as String,
      workerId: json['workerId'] as String,
      workerName: json['workerName'] as String?,
      reason: json['reason'] as String?,
    );

Map<String, dynamic> _$$AssignmentResultImplToJson(
        _$AssignmentResultImpl instance) =>
    <String, dynamic>{
      'shiftId': instance.shiftId,
      'workerId': instance.workerId,
      'workerName': instance.workerName,
      'reason': instance.reason,
    };

_$BulkAssignmentResultImpl _$$BulkAssignmentResultImplFromJson(
        Map<String, dynamic> json) =>
    _$BulkAssignmentResultImpl(
      successfulCount: (json['successfulCount'] as num).toInt(),
      failedCount: (json['failedCount'] as num).toInt(),
      successful: (json['successful'] as List<dynamic>)
          .map((e) => AssignmentResult.fromJson(e as Map<String, dynamic>))
          .toList(),
      failed: (json['failed'] as List<dynamic>)
          .map((e) => AssignmentResult.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$BulkAssignmentResultImplToJson(
        _$BulkAssignmentResultImpl instance) =>
    <String, dynamic>{
      'successfulCount': instance.successfulCount,
      'failedCount': instance.failedCount,
      'successful': instance.successful,
      'failed': instance.failed,
    };

_$MessageRecipientImpl _$$MessageRecipientImplFromJson(
        Map<String, dynamic> json) =>
    _$MessageRecipientImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
      selected: json['selected'] as bool,
    );

Map<String, dynamic> _$$MessageRecipientImplToJson(
        _$MessageRecipientImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'role': instance.role,
      'selected': instance.selected,
    };

_$MessageTemplateImpl _$$MessageTemplateImplFromJson(
        Map<String, dynamic> json) =>
    _$MessageTemplateImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      subject: json['subject'] as String,
      body: json['body'] as String,
      variables:
          (json['variables'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$MessageTemplateImplToJson(
        _$MessageTemplateImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'subject': instance.subject,
      'body': instance.body,
      'variables': instance.variables,
    };

_$BulkMessageImpl _$$BulkMessageImplFromJson(Map<String, dynamic> json) =>
    _$BulkMessageImpl(
      recipientIds: (json['recipientIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      subject: json['subject'] as String,
      message: json['message'] as String,
      channels: (json['channels'] as List<dynamic>)
          .map((e) => $enumDecode(_$MessageChannelEnumMap, e))
          .toList(),
      scheduledFor: json['scheduledFor'] == null
          ? null
          : DateTime.parse(json['scheduledFor'] as String),
    );

Map<String, dynamic> _$$BulkMessageImplToJson(_$BulkMessageImpl instance) =>
    <String, dynamic>{
      'recipientIds': instance.recipientIds,
      'subject': instance.subject,
      'message': instance.message,
      'channels':
          instance.channels.map((e) => _$MessageChannelEnumMap[e]!).toList(),
      'scheduledFor': instance.scheduledFor?.toIso8601String(),
    };

const _$MessageChannelEnumMap = {
  MessageChannel.push: 'push',
  MessageChannel.sms: 'sms',
  MessageChannel.email: 'email',
};

_$BulkMessageResultImpl _$$BulkMessageResultImplFromJson(
        Map<String, dynamic> json) =>
    _$BulkMessageResultImpl(
      sentCount: (json['sentCount'] as num).toInt(),
      scheduledCount: (json['scheduledCount'] as num).toInt(),
      totalRequested: (json['totalRequested'] as num).toInt(),
      scheduledFor: json['scheduledFor'] == null
          ? null
          : DateTime.parse(json['scheduledFor'] as String),
    );

Map<String, dynamic> _$$BulkMessageResultImplToJson(
        _$BulkMessageResultImpl instance) =>
    <String, dynamic>{
      'sentCount': instance.sentCount,
      'scheduledCount': instance.scheduledCount,
      'totalRequested': instance.totalRequested,
      'scheduledFor': instance.scheduledFor?.toIso8601String(),
    };
