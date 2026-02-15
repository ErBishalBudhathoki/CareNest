import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/features/bulk_actions/models/bulk_action_models.dart';

class BulkActionsRepository {
  final ApiMethod _apiMethod;

  BulkActionsRepository(this._apiMethod);

  // ============================================================================
  // Timesheet Actions
  // ============================================================================

  Future<BulkTimesheetResult> approveTimesheets({
    required List<String> timesheetIds,
    required String organizationId,
    required String approvedBy,
  }) async {
    final response = await _apiMethod.bulkApproveTimesheets(
      timesheetIds: timesheetIds,
      organizationId: organizationId,
      approvedBy: approvedBy,
    );

    if (response['success'] == true) {
      return BulkTimesheetResult.fromJson(response['data']);
    } else {
      throw Exception(response['message'] ?? 'Failed to approve timesheets');
    }
  }

  Future<BulkTimesheetResult> rejectTimesheets({
    required List<String> timesheetIds,
    required String organizationId,
    required String rejectedBy,
    required String reason,
  }) async {
    final response = await _apiMethod.bulkRejectTimesheets(
      timesheetIds: timesheetIds,
      organizationId: organizationId,
      rejectedBy: rejectedBy,
      reason: reason,
    );

    if (response['success'] == true) {
      return BulkTimesheetResult(
        approvedCount: 0,
        rejectedCount: response['data']['rejectedCount'] ?? 0,
        totalRequested: response['data']['totalRequested'] ?? 0,
      );
    } else {
      throw Exception(response['message'] ?? 'Failed to reject timesheets');
    }
  }

  // ============================================================================
  // Invoice Actions
  // ============================================================================

  Future<InvoicePreview> previewInvoices({
    required List<String> appointmentIds,
    required String organizationId,
    required bool groupByClient,
  }) async {
    final response = await _apiMethod.previewInvoices(
      appointmentIds: appointmentIds,
      organizationId: organizationId,
      groupByClient: groupByClient,
    );

    if (response['success'] == true) {
      return InvoicePreview.fromJson(response['data']);
    } else {
      throw Exception(response['message'] ?? 'Failed to preview invoices');
    }
  }

  Future<BulkInvoiceResult> generateInvoices({
    required List<String> appointmentIds,
    required String organizationId,
    required bool groupByClient,
    DateTime? dueDate,
  }) async {
    final response = await _apiMethod.bulkGenerateInvoices(
      appointmentIds: appointmentIds,
      organizationId: organizationId,
      groupByClient: groupByClient,
      dueDate: dueDate,
    );

    if (response['success'] == true) {
      return BulkInvoiceResult.fromJson(response['data']);
    } else {
      throw Exception(response['message'] ?? 'Failed to generate invoices');
    }
  }

  // ============================================================================
  // Assignment Actions
  // ============================================================================

  Future<List<ShiftSuggestion>> suggestAssignments({
    required List<String> shiftIds,
    required String organizationId,
  }) async {
    final response = await _apiMethod.suggestWorkerAssignments(
      shiftIds: shiftIds,
      organizationId: organizationId,
    );

    if (response['success'] == true) {
      final data = response['data'] as List;
      return data.map((json) => ShiftSuggestion.fromJson(json)).toList();
    } else {
      throw Exception(response['message'] ?? 'Failed to get suggestions');
    }
  }

  Future<BulkAssignmentResult> assignShifts({
    required List<ShiftAssignment> assignments,
    required String organizationId,
  }) async {
    final assignmentMaps = assignments
        .where((a) => a.workerId != null)
        .map((a) => {
              'shiftId': a.shiftId,
              'workerId': a.workerId!,
            })
        .toList();

    final response = await _apiMethod.bulkAssignShifts(
      assignments: assignmentMaps,
      organizationId: organizationId,
    );

    if (response['success'] == true) {
      final data = response['data'];
      return BulkAssignmentResult(
        successfulCount: data['successfulCount'] ?? 0,
        failedCount: data['failedCount'] ?? 0,
        successful: (data['results']['successful'] as List? ?? [])
            .map((json) => AssignmentResult.fromJson(json))
            .toList(),
        failed: (data['results']['failed'] as List? ?? [])
            .map((json) => AssignmentResult.fromJson(json))
            .toList(),
      );
    } else {
      throw Exception(response['message'] ?? 'Failed to assign shifts');
    }
  }

  // ============================================================================
  // Messaging Actions
  // ============================================================================

  Future<BulkMessageResult> sendMessages({
    required List<String> recipientIds,
    required String organizationId,
    required String subject,
    required String message,
    required List<MessageChannel> channels,
  }) async {
    final channelStrings = channels.map((c) => c.name).toList();

    final response = await _apiMethod.bulkSendMessages(
      recipientIds: recipientIds,
      organizationId: organizationId,
      subject: subject,
      message: message,
      channels: channelStrings,
    );

    if (response['success'] == true) {
      return BulkMessageResult(
        sentCount: response['data']['sentCount'] ?? 0,
        scheduledCount: 0,
        totalRequested: response['data']['totalRequested'] ?? 0,
      );
    } else {
      throw Exception(response['message'] ?? 'Failed to send messages');
    }
  }

  Future<BulkMessageResult> scheduleMessages({
    required List<String> recipientIds,
    required String organizationId,
    required String subject,
    required String message,
    required List<MessageChannel> channels,
    required DateTime scheduledFor,
  }) async {
    final channelStrings = channels.map((c) => c.name).toList();

    final response = await _apiMethod.bulkScheduleMessages(
      recipientIds: recipientIds,
      organizationId: organizationId,
      subject: subject,
      message: message,
      channels: channelStrings,
      scheduledFor: scheduledFor,
    );

    if (response['success'] == true) {
      return BulkMessageResult(
        sentCount: 0,
        scheduledCount: response['data']['scheduledCount'] ?? 0,
        totalRequested: response['data']['totalRequested'] ?? 0,
        scheduledFor: scheduledFor,
      );
    } else {
      throw Exception(response['message'] ?? 'Failed to schedule messages');
    }
  }
}
