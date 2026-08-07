import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/features/invoice/models/invoice_ai_models.dart';

class InvoiceAIRepository {
  final ApiMethod _apiMethod;

  InvoiceAIRepository(this._apiMethod);

  /// Validate an invoice
  Future<InvoiceValidation> validateInvoice({
    required Map<String, dynamic> invoice,
  }) async {
    try {
      final response = await _apiMethod.validateInvoice(invoice: invoice);

      if (response['success'] == true && response['data'] != null) {
        return InvoiceValidation.fromJson(response['data']);
      }

      throw Exception(response['message'] ?? 'Failed to validate invoice');
    } catch (e) {
      throw Exception('Error validating invoice: $e');
    }
  }

  /// Detect anomalies in an invoice
  Future<List<InvoiceAnomaly>> detectAnomalies({
    required Map<String, dynamic> invoice,
  }) async {
    try {
      final response = await _apiMethod.detectInvoiceAnomalies(
        invoice: invoice,
      );

      if (response['success'] == true && response['data'] != null) {
        final anomalies = response['data']['anomalies'] as List;
        return anomalies.map((a) => InvoiceAnomaly.fromJson(a)).toList();
      }

      throw Exception(response['message'] ?? 'Failed to detect anomalies');
    } catch (e) {
      throw Exception('Error detecting anomalies: $e');
    }
  }

  /// Predict payment date for an invoice
  Future<PaymentPrediction> predictPaymentDate({
    required String invoiceId,
  }) async {
    try {
      final response = await _apiMethod.predictPaymentDate(
        invoiceId: invoiceId,
      );

      if (response['success'] == true && response['data'] != null) {
        return PaymentPrediction.fromJson(response['data']);
      }

      throw Exception(response['message'] ?? 'Failed to predict payment date');
    } catch (e) {
      throw Exception('Error predicting payment date: $e');
    }
  }

  /// Auto-generate invoices for a period
  Future<AutoGenerateResult> autoGenerateInvoices({
    required String organizationId,
    DateTime? startDate,
    DateTime? endDate,
    bool validateBeforeGeneration = true,
    bool groupByClient = false,
    bool forceManual = false,
  }) async {
    try {
      final response = await _apiMethod.autoGenerateInvoices(
        organizationId: organizationId,
        startDate: startDate,
        endDate: endDate,
        validateBeforeGeneration: validateBeforeGeneration,
        groupByClient: groupByClient,
        forceManual: forceManual,
      );

      if (response['success'] == true && response['data'] != null) {
        return AutoGenerateResult.fromJson(response['data']);
      }

      throw Exception(
        response['message'] ?? 'Failed to auto-generate invoices',
      );
    } catch (e) {
      throw Exception('Error auto-generating invoices: $e');
    }
  }

  /// Generate invoice from free text prompt
  Future<AutoGenerateResult> generateFromText({
    required String organizationId,
    required String textNote,
  }) async {
    try {
      final response = await _apiMethod.generateFromText(
        organizationId: organizationId,
        textNote: textNote,
      );

      if (response['success'] == true && response['data'] != null) {
        return AutoGenerateResult.fromJson(response['data']);
      }

      throw Exception(
        response['message'] ?? 'Failed to generate invoice from text',
      );
    } catch (e) {
      throw Exception('Error generating invoice from text: $e');
    }
  }

  /// Get smart reminders for an invoice
  Future<List<SmartReminder>> getSmartReminders({
    required String invoiceId,
  }) async {
    try {
      final response = await _apiMethod.getSmartReminders(invoiceId: invoiceId);

      if (response['success'] == true && response['data'] != null) {
        final reminders = response['data']['reminders'] as List;
        return reminders.map((r) => SmartReminder.fromJson(r)).toList();
      }

      throw Exception(response['message'] ?? 'Failed to get smart reminders');
    } catch (e) {
      throw Exception('Error getting smart reminders: $e');
    }
  }
}
