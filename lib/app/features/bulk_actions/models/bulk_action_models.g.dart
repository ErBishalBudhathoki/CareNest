// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bulk_action_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TimesheetItem _$TimesheetItemFromJson(Map<String, dynamic> json) =>
    _TimesheetItem(
      id: json['id'] as String,
      workerId: json['workerId'] as String,
      workerName: json['workerName'] as String,
      date: DateTime.parse(json['date'] as String),
      hours: (json['hours'] as num).toDouble(),
      status: json['status'] as String,
      clientName: json['clientName'] as String?,
      serviceName: json['serviceName'] as String?,
    );

Map<String, dynamic> _$TimesheetItemToJson(_TimesheetItem instance) =>
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

_BulkTimesheetResult _$BulkTimesheetResultFromJson(Map<String, dynamic> json) =>
    _BulkTimesheetResult(
      approvedCount: (json['approvedCount'] as num).toInt(),
      rejectedCount: (json['rejectedCount'] as num).toInt(),
      totalRequested: (json['totalRequested'] as num).toInt(),
    );

Map<String, dynamic> _$BulkTimesheetResultToJson(
        _BulkTimesheetResult instance) =>
    <String, dynamic>{
      'approvedCount': instance.approvedCount,
      'rejectedCount': instance.rejectedCount,
      'totalRequested': instance.totalRequested,
    };

_InvoicePreviewItem _$InvoicePreviewItemFromJson(Map<String, dynamic> json) =>
    _InvoicePreviewItem(
      clientId: json['clientId'] as String,
      clientName: json['clientName'] as String,
      clientEmail: json['clientEmail'] as String,
      appointments: (json['appointments'] as List<dynamic>)
          .map((e) => AppointmentLineItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalAmount: (json['totalAmount'] as num).toDouble(),
    );

Map<String, dynamic> _$InvoicePreviewItemToJson(_InvoicePreviewItem instance) =>
    <String, dynamic>{
      'clientId': instance.clientId,
      'clientName': instance.clientName,
      'clientEmail': instance.clientEmail,
      'appointments': instance.appointments,
      'totalAmount': instance.totalAmount,
    };

_AppointmentLineItem _$AppointmentLineItemFromJson(Map<String, dynamic> json) =>
    _AppointmentLineItem(
      appointmentId: json['appointmentId'] as String,
      date: DateTime.parse(json['date'] as String),
      service: json['service'] as String,
      duration: (json['duration'] as num).toDouble(),
      rate: (json['rate'] as num).toDouble(),
      amount: (json['amount'] as num).toDouble(),
    );

Map<String, dynamic> _$AppointmentLineItemToJson(
        _AppointmentLineItem instance) =>
    <String, dynamic>{
      'appointmentId': instance.appointmentId,
      'date': instance.date.toIso8601String(),
      'service': instance.service,
      'duration': instance.duration,
      'rate': instance.rate,
      'amount': instance.amount,
    };

_InvoicePreview _$InvoicePreviewFromJson(Map<String, dynamic> json) =>
    _InvoicePreview(
      invoiceCount: (json['invoiceCount'] as num).toInt(),
      totalAppointments: (json['totalAppointments'] as num).toInt(),
      totalAmount: (json['totalAmount'] as num).toDouble(),
      invoices: (json['invoices'] as List<dynamic>)
          .map((e) => InvoicePreviewItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$InvoicePreviewToJson(_InvoicePreview instance) =>
    <String, dynamic>{
      'invoiceCount': instance.invoiceCount,
      'totalAppointments': instance.totalAppointments,
      'totalAmount': instance.totalAmount,
      'invoices': instance.invoices,
    };

_BulkInvoiceResult _$BulkInvoiceResultFromJson(Map<String, dynamic> json) =>
    _BulkInvoiceResult(
      invoiceCount: (json['invoiceCount'] as num).toInt(),
      appointmentCount: (json['appointmentCount'] as num).toInt(),
      totalAmount: (json['totalAmount'] as num).toDouble(),
    );

Map<String, dynamic> _$BulkInvoiceResultToJson(_BulkInvoiceResult instance) =>
    <String, dynamic>{
      'invoiceCount': instance.invoiceCount,
      'appointmentCount': instance.appointmentCount,
      'totalAmount': instance.totalAmount,
    };

_ShiftAssignment _$ShiftAssignmentFromJson(Map<String, dynamic> json) =>
    _ShiftAssignment(
      shiftId: json['shiftId'] as String,
      workerId: json['workerId'] as String?,
      shiftDate: json['shiftDate'] == null
          ? null
          : DateTime.parse(json['shiftDate'] as String),
      shiftTime: json['shiftTime'] as String?,
      service: json['service'] as String?,
    );

Map<String, dynamic> _$ShiftAssignmentToJson(_ShiftAssignment instance) =>
    <String, dynamic>{
      'shiftId': instance.shiftId,
      'workerId': instance.workerId,
      'shiftDate': instance.shiftDate?.toIso8601String(),
      'shiftTime': instance.shiftTime,
      'service': instance.service,
    };

_WorkerSuggestion _$WorkerSuggestionFromJson(Map<String, dynamic> json) =>
    _WorkerSuggestion(
      workerId: json['workerId'] as String,
      workerName: json['workerName'] as String,
      workerEmail: json['workerEmail'] as String,
      score: (json['score'] as num).toDouble(),
      matchReason: json['matchReason'] as String,
      conflicts:
          (json['conflicts'] as List<dynamic>).map((e) => e as String).toList(),
      rating: (json['rating'] as num).toDouble(),
    );

Map<String, dynamic> _$WorkerSuggestionToJson(_WorkerSuggestion instance) =>
    <String, dynamic>{
      'workerId': instance.workerId,
      'workerName': instance.workerName,
      'workerEmail': instance.workerEmail,
      'score': instance.score,
      'matchReason': instance.matchReason,
      'conflicts': instance.conflicts,
      'rating': instance.rating,
    };

_ShiftSuggestion _$ShiftSuggestionFromJson(Map<String, dynamic> json) =>
    _ShiftSuggestion(
      shiftId: json['shiftId'] as String,
      shiftDate: DateTime.parse(json['shiftDate'] as String),
      shiftTime: json['shiftTime'] as String,
      service: json['service'] as String,
      suggestedWorkers: (json['suggestedWorkers'] as List<dynamic>)
          .map((e) => WorkerSuggestion.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ShiftSuggestionToJson(_ShiftSuggestion instance) =>
    <String, dynamic>{
      'shiftId': instance.shiftId,
      'shiftDate': instance.shiftDate.toIso8601String(),
      'shiftTime': instance.shiftTime,
      'service': instance.service,
      'suggestedWorkers': instance.suggestedWorkers,
    };

_AssignmentResult _$AssignmentResultFromJson(Map<String, dynamic> json) =>
    _AssignmentResult(
      shiftId: json['shiftId'] as String,
      workerId: json['workerId'] as String,
      workerName: json['workerName'] as String?,
      reason: json['reason'] as String?,
    );

Map<String, dynamic> _$AssignmentResultToJson(_AssignmentResult instance) =>
    <String, dynamic>{
      'shiftId': instance.shiftId,
      'workerId': instance.workerId,
      'workerName': instance.workerName,
      'reason': instance.reason,
    };

_BulkAssignmentResult _$BulkAssignmentResultFromJson(
        Map<String, dynamic> json) =>
    _BulkAssignmentResult(
      successfulCount: (json['successfulCount'] as num).toInt(),
      failedCount: (json['failedCount'] as num).toInt(),
      successful: (json['successful'] as List<dynamic>)
          .map((e) => AssignmentResult.fromJson(e as Map<String, dynamic>))
          .toList(),
      failed: (json['failed'] as List<dynamic>)
          .map((e) => AssignmentResult.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BulkAssignmentResultToJson(
        _BulkAssignmentResult instance) =>
    <String, dynamic>{
      'successfulCount': instance.successfulCount,
      'failedCount': instance.failedCount,
      'successful': instance.successful,
      'failed': instance.failed,
    };

_MessageRecipient _$MessageRecipientFromJson(Map<String, dynamic> json) =>
    _MessageRecipient(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
      selected: json['selected'] as bool,
    );

Map<String, dynamic> _$MessageRecipientToJson(_MessageRecipient instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'role': instance.role,
      'selected': instance.selected,
    };

_MessageTemplate _$MessageTemplateFromJson(Map<String, dynamic> json) =>
    _MessageTemplate(
      id: json['id'] as String,
      name: json['name'] as String,
      subject: json['subject'] as String,
      body: json['body'] as String,
      variables:
          (json['variables'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$MessageTemplateToJson(_MessageTemplate instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'subject': instance.subject,
      'body': instance.body,
      'variables': instance.variables,
    };

_BulkMessage _$BulkMessageFromJson(Map<String, dynamic> json) => _BulkMessage(
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

Map<String, dynamic> _$BulkMessageToJson(_BulkMessage instance) =>
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

_BulkMessageResult _$BulkMessageResultFromJson(Map<String, dynamic> json) =>
    _BulkMessageResult(
      sentCount: (json['sentCount'] as num).toInt(),
      scheduledCount: (json['scheduledCount'] as num).toInt(),
      totalRequested: (json['totalRequested'] as num).toInt(),
      scheduledFor: json['scheduledFor'] == null
          ? null
          : DateTime.parse(json['scheduledFor'] as String),
    );

Map<String, dynamic> _$BulkMessageResultToJson(_BulkMessageResult instance) =>
    <String, dynamic>{
      'sentCount': instance.sentCount,
      'scheduledCount': instance.scheduledCount,
      'totalRequested': instance.totalRequested,
      'scheduledFor': instance.scheduledFor?.toIso8601String(),
    };
