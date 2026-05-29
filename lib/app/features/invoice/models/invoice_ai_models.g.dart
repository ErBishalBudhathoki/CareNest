// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_ai_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_InvoiceAnomaly _$InvoiceAnomalyFromJson(Map<String, dynamic> json) =>
    _InvoiceAnomaly(
      anomalyType: json['anomalyType'] as String,
      severity: json['severity'] as String,
      description: json['description'] as String,
      field: json['field'] as String,
      expectedValue: json['expectedValue'],
      actualValue: json['actualValue'],
      suggestion: json['suggestion'] as String?,
    );

Map<String, dynamic> _$InvoiceAnomalyToJson(_InvoiceAnomaly instance) =>
    <String, dynamic>{
      'anomalyType': instance.anomalyType,
      'severity': instance.severity,
      'description': instance.description,
      'field': instance.field,
      'expectedValue': instance.expectedValue,
      'actualValue': instance.actualValue,
      'suggestion': instance.suggestion,
    };

_InvoiceValidation _$InvoiceValidationFromJson(Map<String, dynamic> json) =>
    _InvoiceValidation(
      isValid: json['isValid'] as bool,
      anomalies: (json['anomalies'] as List<dynamic>)
          .map((e) => InvoiceAnomaly.fromJson(e as Map<String, dynamic>))
          .toList(),
      warnings: (json['warnings'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      confidenceScore: (json['confidenceScore'] as num).toDouble(),
      summary: json['summary'] as String?,
    );

Map<String, dynamic> _$InvoiceValidationToJson(_InvoiceValidation instance) =>
    <String, dynamic>{
      'isValid': instance.isValid,
      'anomalies': instance.anomalies,
      'warnings': instance.warnings,
      'confidenceScore': instance.confidenceScore,
      'summary': instance.summary,
    };

_PaymentPrediction _$PaymentPredictionFromJson(
  Map<String, dynamic> json,
) => _PaymentPrediction(
  invoiceId: json['invoiceId'] as String,
  predictedPaymentDate: DateTime.parse(json['predictedPaymentDate'] as String),
  probability: (json['probability'] as num).toDouble(),
  riskLevel: json['riskLevel'] as String,
  factors: (json['factors'] as List<dynamic>).map((e) => e as String).toList(),
  recommendation: json['recommendation'] as String?,
);

Map<String, dynamic> _$PaymentPredictionToJson(_PaymentPrediction instance) =>
    <String, dynamic>{
      'invoiceId': instance.invoiceId,
      'predictedPaymentDate': instance.predictedPaymentDate.toIso8601String(),
      'probability': instance.probability,
      'riskLevel': instance.riskLevel,
      'factors': instance.factors,
      'recommendation': instance.recommendation,
    };

_AutoGenerateRequest _$AutoGenerateRequestFromJson(Map<String, dynamic> json) =>
    _AutoGenerateRequest(
      organizationId: json['organizationId'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      validateBeforeGeneration:
          json['validateBeforeGeneration'] as bool? ?? true,
      groupByClient: json['groupByClient'] as bool? ?? false,
    );

Map<String, dynamic> _$AutoGenerateRequestToJson(
  _AutoGenerateRequest instance,
) => <String, dynamic>{
  'organizationId': instance.organizationId,
  'startDate': instance.startDate.toIso8601String(),
  'endDate': instance.endDate.toIso8601String(),
  'validateBeforeGeneration': instance.validateBeforeGeneration,
  'groupByClient': instance.groupByClient,
};

_AutoGenerateResult _$AutoGenerateResultFromJson(Map<String, dynamic> json) =>
    _AutoGenerateResult(
      totalInvoices: (json['totalInvoices'] as num).toInt(),
      successfulInvoices: (json['successfulInvoices'] as num).toInt(),
      failedInvoices: (json['failedInvoices'] as num).toInt(),
      invoiceIds: (json['invoiceIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      errors: (json['errors'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      summary: json['summary'] as String?,
    );

Map<String, dynamic> _$AutoGenerateResultToJson(_AutoGenerateResult instance) =>
    <String, dynamic>{
      'totalInvoices': instance.totalInvoices,
      'successfulInvoices': instance.successfulInvoices,
      'failedInvoices': instance.failedInvoices,
      'invoiceIds': instance.invoiceIds,
      'errors': instance.errors,
      'summary': instance.summary,
    };

_SmartReminder _$SmartReminderFromJson(Map<String, dynamic> json) =>
    _SmartReminder(
      invoiceId: json['invoiceId'] as String,
      suggestedSendTime: DateTime.parse(json['suggestedSendTime'] as String),
      channel: json['channel'] as String,
      message: json['message'] as String,
      successProbability: (json['successProbability'] as num).toDouble(),
      reason: json['reason'] as String?,
    );

Map<String, dynamic> _$SmartReminderToJson(_SmartReminder instance) =>
    <String, dynamic>{
      'invoiceId': instance.invoiceId,
      'suggestedSendTime': instance.suggestedSendTime.toIso8601String(),
      'channel': instance.channel,
      'message': instance.message,
      'successProbability': instance.successProbability,
      'reason': instance.reason,
    };
