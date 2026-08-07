import 'package:freezed_annotation/freezed_annotation.dart';

part 'invoice_ai_models.freezed.dart';
part 'invoice_ai_models.g.dart';

// ============================================================================
// Invoice Anomaly Models
// ============================================================================

@freezed
abstract class InvoiceAnomaly with _$InvoiceAnomaly {
  const factory InvoiceAnomaly({
    required String anomalyType,
    required String severity,
    required String description,
    required String field,
    dynamic expectedValue,
    dynamic actualValue,
    String? suggestion,
  }) = _InvoiceAnomaly;

  factory InvoiceAnomaly.fromJson(Map<String, dynamic> json) =>
      _$InvoiceAnomalyFromJson(json);
}

enum AnomalySeverity { low, medium, high, critical }

// ============================================================================
// Invoice Validation Models
// ============================================================================

@freezed
abstract class InvoiceValidation with _$InvoiceValidation {
  const factory InvoiceValidation({
    required bool isValid,
    required List<InvoiceAnomaly> anomalies,
    required List<String> warnings,
    required double confidenceScore,
    String? summary,
  }) = _InvoiceValidation;

  factory InvoiceValidation.fromJson(Map<String, dynamic> json) =>
      _$InvoiceValidationFromJson(json);
}

// ============================================================================
// Payment Prediction Models
// ============================================================================

@freezed
abstract class PaymentPrediction with _$PaymentPrediction {
  const factory PaymentPrediction({
    required String invoiceId,
    required DateTime predictedPaymentDate,
    required double probability,
    required String riskLevel,
    required List<String> factors,
    String? recommendation,
  }) = _PaymentPrediction;

  factory PaymentPrediction.fromJson(Map<String, dynamic> json) =>
      _$PaymentPredictionFromJson(json);
}

enum PaymentRiskLevel { low, medium, high }

// ============================================================================
// Auto-Generation Models
// ============================================================================

@freezed
abstract class AutoGenerateRequest with _$AutoGenerateRequest {
  const factory AutoGenerateRequest({
    required String organizationId,
    required DateTime startDate,
    required DateTime endDate,
    @Default(true) bool validateBeforeGeneration,
    @Default(false) bool groupByClient,
  }) = _AutoGenerateRequest;

  factory AutoGenerateRequest.fromJson(Map<String, dynamic> json) =>
      _$AutoGenerateRequestFromJson(json);
}

@freezed
abstract class AutoGenerateResult with _$AutoGenerateResult {
  const factory AutoGenerateResult({
    required int totalInvoices,
    required int successfulInvoices,
    required int failedInvoices,
    required List<String> invoiceIds,
    required List<String> errors,
    String? summary,
  }) = _AutoGenerateResult;

  factory AutoGenerateResult.fromJson(Map<String, dynamic> json) =>
      _$AutoGenerateResultFromJson(json);
}

// ============================================================================
// Smart Reminder Models
// ============================================================================

@freezed
abstract class SmartReminder with _$SmartReminder {
  const factory SmartReminder({
    required String invoiceId,
    required DateTime suggestedSendTime,
    required String channel,
    required String message,
    required double successProbability,
    String? reason,
  }) = _SmartReminder;

  factory SmartReminder.fromJson(Map<String, dynamic> json) =>
      _$SmartReminderFromJson(json);
}
