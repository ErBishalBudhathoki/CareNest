import 'package:freezed_annotation/freezed_annotation.dart';

part 'bulk_action_models.freezed.dart';
part 'bulk_action_models.g.dart';

// ============================================================================
// Bulk Timesheet Models
// ============================================================================

@freezed
class TimesheetItem with _$TimesheetItem {
  const factory TimesheetItem({
    required String id,
    required String workerId,
    required String workerName,
    required DateTime date,
    required double hours,
    required String status,
    String? clientName,
    String? serviceName,
  }) = _TimesheetItem;

  factory TimesheetItem.fromJson(Map<String, dynamic> json) =>
      _$TimesheetItemFromJson(json);
}

@freezed
class BulkTimesheetResult with _$BulkTimesheetResult {
  const factory BulkTimesheetResult({
    required int approvedCount,
    required int rejectedCount,
    required int totalRequested,
  }) = _BulkTimesheetResult;

  factory BulkTimesheetResult.fromJson(Map<String, dynamic> json) =>
      _$BulkTimesheetResultFromJson(json);
}

// ============================================================================
// Bulk Invoice Models
// ============================================================================

@freezed
class InvoicePreviewItem with _$InvoicePreviewItem {
  const factory InvoicePreviewItem({
    required String clientId,
    required String clientName,
    required String clientEmail,
    required List<AppointmentLineItem> appointments,
    required double totalAmount,
  }) = _InvoicePreviewItem;

  factory InvoicePreviewItem.fromJson(Map<String, dynamic> json) =>
      _$InvoicePreviewItemFromJson(json);
}

@freezed
class AppointmentLineItem with _$AppointmentLineItem {
  const factory AppointmentLineItem({
    required String appointmentId,
    required DateTime date,
    required String service,
    required double duration,
    required double rate,
    required double amount,
  }) = _AppointmentLineItem;

  factory AppointmentLineItem.fromJson(Map<String, dynamic> json) =>
      _$AppointmentLineItemFromJson(json);
}

@freezed
class InvoicePreview with _$InvoicePreview {
  const factory InvoicePreview({
    required int invoiceCount,
    required int totalAppointments,
    required double totalAmount,
    required List<InvoicePreviewItem> invoices,
  }) = _InvoicePreview;

  factory InvoicePreview.fromJson(Map<String, dynamic> json) =>
      _$InvoicePreviewFromJson(json);
}

@freezed
class BulkInvoiceResult with _$BulkInvoiceResult {
  const factory BulkInvoiceResult({
    required int invoiceCount,
    required int appointmentCount,
    required double totalAmount,
  }) = _BulkInvoiceResult;

  factory BulkInvoiceResult.fromJson(Map<String, dynamic> json) =>
      _$BulkInvoiceResultFromJson(json);
}

// ============================================================================
// Bulk Assignment Models
// ============================================================================

@freezed
class ShiftAssignment with _$ShiftAssignment {
  const factory ShiftAssignment({
    required String shiftId,
    required String? workerId,
    DateTime? shiftDate,
    String? shiftTime,
    String? service,
  }) = _ShiftAssignment;

  factory ShiftAssignment.fromJson(Map<String, dynamic> json) =>
      _$ShiftAssignmentFromJson(json);
}

@freezed
class WorkerSuggestion with _$WorkerSuggestion {
  const factory WorkerSuggestion({
    required String workerId,
    required String workerName,
    required String workerEmail,
    required double score,
    required String matchReason,
    required List<String> conflicts,
    required double rating,
  }) = _WorkerSuggestion;

  factory WorkerSuggestion.fromJson(Map<String, dynamic> json) =>
      _$WorkerSuggestionFromJson(json);
}

@freezed
class ShiftSuggestion with _$ShiftSuggestion {
  const factory ShiftSuggestion({
    required String shiftId,
    required DateTime shiftDate,
    required String shiftTime,
    required String service,
    required List<WorkerSuggestion> suggestedWorkers,
  }) = _ShiftSuggestion;

  factory ShiftSuggestion.fromJson(Map<String, dynamic> json) =>
      _$ShiftSuggestionFromJson(json);
}

@freezed
class AssignmentResult with _$AssignmentResult {
  const factory AssignmentResult({
    required String shiftId,
    required String workerId,
    String? workerName,
    String? reason,
  }) = _AssignmentResult;

  factory AssignmentResult.fromJson(Map<String, dynamic> json) =>
      _$AssignmentResultFromJson(json);
}

@freezed
class BulkAssignmentResult with _$BulkAssignmentResult {
  const factory BulkAssignmentResult({
    required int successfulCount,
    required int failedCount,
    required List<AssignmentResult> successful,
    required List<AssignmentResult> failed,
  }) = _BulkAssignmentResult;

  factory BulkAssignmentResult.fromJson(Map<String, dynamic> json) =>
      _$BulkAssignmentResultFromJson(json);
}

// ============================================================================
// Bulk Messaging Models
// ============================================================================

@freezed
class MessageRecipient with _$MessageRecipient {
  const factory MessageRecipient({
    required String id,
    required String name,
    required String email,
    required String role,
    required bool selected,
  }) = _MessageRecipient;

  factory MessageRecipient.fromJson(Map<String, dynamic> json) =>
      _$MessageRecipientFromJson(json);
}

@freezed
class MessageTemplate with _$MessageTemplate {
  const factory MessageTemplate({
    required String id,
    required String name,
    required String subject,
    required String body,
    required List<String> variables,
  }) = _MessageTemplate;

  factory MessageTemplate.fromJson(Map<String, dynamic> json) =>
      _$MessageTemplateFromJson(json);
}

enum MessageChannel {
  push,
  sms,
  email,
}

@freezed
class BulkMessage with _$BulkMessage {
  const factory BulkMessage({
    required List<String> recipientIds,
    required String subject,
    required String message,
    required List<MessageChannel> channels,
    DateTime? scheduledFor,
  }) = _BulkMessage;

  factory BulkMessage.fromJson(Map<String, dynamic> json) =>
      _$BulkMessageFromJson(json);
}

@freezed
class BulkMessageResult with _$BulkMessageResult {
  const factory BulkMessageResult({
    required int sentCount,
    required int scheduledCount,
    required int totalRequested,
    DateTime? scheduledFor,
  }) = _BulkMessageResult;

  factory BulkMessageResult.fromJson(Map<String, dynamic> json) =>
      _$BulkMessageResultFromJson(json);
}
