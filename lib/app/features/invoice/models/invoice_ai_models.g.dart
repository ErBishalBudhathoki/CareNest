// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_ai_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InvoiceAnomalyImpl _$$InvoiceAnomalyImplFromJson(Map<String, dynamic> json) =>
    _$InvoiceAnomalyImpl(
      anomalyType: json['anomalyType'] as String,
      severity: json['severity'] as String,
      description: json['description'] as String,
      field: json['field'] as String,
      expectedValue: json['expectedValue'],
      actualValue: json['actualValue'],
      suggestion: json['suggestion'] as String?,
    );

Map<String, dynamic> _$$InvoiceAnomalyImplToJson(
        _$InvoiceAnomalyImpl instance) =>
    <String, dynamic>{
      'anomalyType': instance.anomalyType,
      'severity': instance.severity,
      'description': instance.description,
      'field': instance.field,
      'expectedValue': instance.expectedValue,
      'actualValue': instance.actualValue,
      'suggestion': instance.suggestion,
    };

_$InvoiceValidationImpl _$$InvoiceValidationImplFromJson(
        Map<String, dynamic> json) =>
    _$InvoiceValidationImpl(
      isValid: json['isValid'] as bool,
      anomalies: (json['anomalies'] as List<dynamic>)
          .map((e) => InvoiceAnomaly.fromJson(e as Map<String, dynamic>))
          .toList(),
      warnings:
          (json['warnings'] as List<dynamic>).map((e) => e as String).toList(),
      confidenceScore: (json['confidenceScore'] as num).toDouble(),
      summary: json['summary'] as String?,
    );

Map<String, dynamic> _$$InvoiceValidationImplToJson(
        _$InvoiceValidationImpl instance) =>
    <String, dynamic>{
      'isValid': instance.isValid,
      'anomalies': instance.anomalies,
      'warnings': instance.warnings,
      'confidenceScore': instance.confidenceScore,
      'summary': instance.summary,
    };

_$PaymentPredictionImpl _$$PaymentPredictionImplFromJson(
        Map<String, dynamic> json) =>
    _$PaymentPredictionImpl(
      invoiceId: json['invoiceId'] as String,
      predictedPaymentDate:
          DateTime.parse(json['predictedPaymentDate'] as String),
      probability: (json['probability'] as num).toDouble(),
      riskLevel: json['riskLevel'] as String,
      factors:
          (json['factors'] as List<dynamic>).map((e) => e as String).toList(),
      recommendation: json['recommendation'] as String?,
    );

Map<String, dynamic> _$$PaymentPredictionImplToJson(
        _$PaymentPredictionImpl instance) =>
    <String, dynamic>{
      'invoiceId': instance.invoiceId,
      'predictedPaymentDate': instance.predictedPaymentDate.toIso8601String(),
      'probability': instance.probability,
      'riskLevel': instance.riskLevel,
      'factors': instance.factors,
      'recommendation': instance.recommendation,
    };

_$AutoGenerateRequestImpl _$$AutoGenerateRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$AutoGenerateRequestImpl(
      organizationId: json['organizationId'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      validateBeforeGeneration:
          json['validateBeforeGeneration'] as bool? ?? true,
      groupByClient: json['groupByClient'] as bool? ?? false,
    );

Map<String, dynamic> _$$AutoGenerateRequestImplToJson(
        _$AutoGenerateRequestImpl instance) =>
    <String, dynamic>{
      'organizationId': instance.organizationId,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'validateBeforeGeneration': instance.validateBeforeGeneration,
      'groupByClient': instance.groupByClient,
    };

_$AutoGenerateResultImpl _$$AutoGenerateResultImplFromJson(
        Map<String, dynamic> json) =>
    _$AutoGenerateResultImpl(
      totalInvoices: (json['totalInvoices'] as num).toInt(),
      successfulInvoices: (json['successfulInvoices'] as num).toInt(),
      failedInvoices: (json['failedInvoices'] as num).toInt(),
      invoiceIds: (json['invoiceIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      errors:
          (json['errors'] as List<dynamic>).map((e) => e as String).toList(),
      summary: json['summary'] as String?,
    );

Map<String, dynamic> _$$AutoGenerateResultImplToJson(
        _$AutoGenerateResultImpl instance) =>
    <String, dynamic>{
      'totalInvoices': instance.totalInvoices,
      'successfulInvoices': instance.successfulInvoices,
      'failedInvoices': instance.failedInvoices,
      'invoiceIds': instance.invoiceIds,
      'errors': instance.errors,
      'summary': instance.summary,
    };

_$SmartReminderImpl _$$SmartReminderImplFromJson(Map<String, dynamic> json) =>
    _$SmartReminderImpl(
      invoiceId: json['invoiceId'] as String,
      suggestedSendTime: DateTime.parse(json['suggestedSendTime'] as String),
      channel: json['channel'] as String,
      message: json['message'] as String,
      successProbability: (json['successProbability'] as num).toDouble(),
      reason: json['reason'] as String?,
    );

Map<String, dynamic> _$$SmartReminderImplToJson(_$SmartReminderImpl instance) =>
    <String, dynamic>{
      'invoiceId': instance.invoiceId,
      'suggestedSendTime': instance.suggestedSendTime.toIso8601String(),
      'channel': instance.channel,
      'message': instance.message,
      'successProbability': instance.successProbability,
      'reason': instance.reason,
    };
