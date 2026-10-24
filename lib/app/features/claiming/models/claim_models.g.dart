// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'claim_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ClaimPeriod _$ClaimPeriodFromJson(Map<String, dynamic> json) =>
    _ClaimPeriod(from: json['from'] as String?, to: json['to'] as String?);

Map<String, dynamic> _$ClaimPeriodToJson(_ClaimPeriod instance) =>
    <String, dynamic>{'from': instance.from, 'to': instance.to};

_ClaimTotals _$ClaimTotalsFromJson(Map<String, dynamic> json) => _ClaimTotals(
  lines: (json['lines'] as num?)?.toInt() ?? 0,
  amount: (json['amount'] as num?)?.toDouble() ?? 0,
);

Map<String, dynamic> _$ClaimTotalsToJson(_ClaimTotals instance) =>
    <String, dynamic>{'lines': instance.lines, 'amount': instance.amount};

_ClaimRemittance _$ClaimRemittanceFromJson(Map<String, dynamic> json) =>
    _ClaimRemittance(
      status: json['status'] as String? ?? 'unpaid',
      paidAmount: (json['paidAmount'] as num?)?.toDouble() ?? 0,
      paidAt: json['paidAt'] as String?,
      reference: json['reference'] as String? ?? '',
      notes: json['notes'] as String? ?? '',
    );

Map<String, dynamic> _$ClaimRemittanceToJson(_ClaimRemittance instance) =>
    <String, dynamic>{
      'status': instance.status,
      'paidAmount': instance.paidAmount,
      'paidAt': instance.paidAt,
      'reference': instance.reference,
      'notes': instance.notes,
    };

_ClaimBatch _$ClaimBatchFromJson(Map<String, dynamic> json) => _ClaimBatch(
  id: json['id'] as String,
  status: json['status'] as String? ?? 'draft',
  fundingType: json['fundingType'] as String? ?? 'ndia_managed',
  registrationNumber: json['registrationNumber'] as String? ?? '',
  abn: json['abn'] as String? ?? '',
  period: json['period'] == null
      ? null
      : ClaimPeriod.fromJson(json['period'] as Map<String, dynamic>),
  totals: json['totals'] == null
      ? const ClaimTotals()
      : ClaimTotals.fromJson(json['totals'] as Map<String, dynamic>),
  generatedAt: json['generatedAt'] as String?,
  submittedAt: json['submittedAt'] as String?,
  reconciledAt: json['reconciledAt'] as String?,
  portalReference: json['portalReference'] as String? ?? '',
  submittedBy: json['submittedBy'] as String? ?? '',
  remittance: json['remittance'] == null
      ? null
      : ClaimRemittance.fromJson(json['remittance'] as Map<String, dynamic>),
  resubmissionOf: json['resubmissionOf'] as String?,
  resubmittedBatchId: json['resubmittedBatchId'] as String?,
);

Map<String, dynamic> _$ClaimBatchToJson(_ClaimBatch instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'fundingType': instance.fundingType,
      'registrationNumber': instance.registrationNumber,
      'abn': instance.abn,
      'period': instance.period,
      'totals': instance.totals,
      'generatedAt': instance.generatedAt,
      'submittedAt': instance.submittedAt,
      'reconciledAt': instance.reconciledAt,
      'portalReference': instance.portalReference,
      'submittedBy': instance.submittedBy,
      'remittance': instance.remittance,
      'resubmissionOf': instance.resubmissionOf,
      'resubmittedBatchId': instance.resubmittedBatchId,
    };

_ClaimLine _$ClaimLineFromJson(Map<String, dynamic> json) => _ClaimLine(
  id: json['id'] as String,
  ndisNumber: json['ndisNumber'] as String? ?? '',
  supportNumber: json['supportNumber'] as String? ?? '',
  claimReference: json['claimReference'] as String? ?? '',
  quantity: (json['quantity'] as num?)?.toDouble() ?? 0,
  unitPrice: (json['unitPrice'] as num?)?.toDouble() ?? 0,
  requestedAmount: (json['requestedAmount'] as num?)?.toDouble() ?? 0,
  gstCode: json['gstCode'] as String? ?? 'P2',
  claimType: json['claimType'] as String? ?? 'DIRECT_SERVICE',
  status: json['status'] as String? ?? 'pending',
  rejectionReason: json['rejectionReason'] as String? ?? '',
  paidAmount: (json['paidAmount'] as num?)?.toDouble() ?? 0,
  paidAt: json['paidAt'] as String?,
  remittanceReference: json['remittanceReference'] as String? ?? '',
  resubmittedInBatchId: json['resubmittedInBatchId'] as String?,
  serviceDate: json['serviceDate'] as String?,
);

Map<String, dynamic> _$ClaimLineToJson(_ClaimLine instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ndisNumber': instance.ndisNumber,
      'supportNumber': instance.supportNumber,
      'claimReference': instance.claimReference,
      'quantity': instance.quantity,
      'unitPrice': instance.unitPrice,
      'requestedAmount': instance.requestedAmount,
      'gstCode': instance.gstCode,
      'claimType': instance.claimType,
      'status': instance.status,
      'rejectionReason': instance.rejectionReason,
      'paidAmount': instance.paidAmount,
      'paidAt': instance.paidAt,
      'remittanceReference': instance.remittanceReference,
      'resubmittedInBatchId': instance.resubmittedInBatchId,
      'serviceDate': instance.serviceDate,
    };

_ClaimValidationError _$ClaimValidationErrorFromJson(
  Map<String, dynamic> json,
) => _ClaimValidationError(
  claimReference: json['claimReference'] as String? ?? '',
  field: json['field'] as String? ?? '',
  message: json['message'] as String? ?? '',
);

Map<String, dynamic> _$ClaimValidationErrorToJson(
  _ClaimValidationError instance,
) => <String, dynamic>{
  'claimReference': instance.claimReference,
  'field': instance.field,
  'message': instance.message,
};

_ClaimValidation _$ClaimValidationFromJson(
  Map<String, dynamic> json,
) => _ClaimValidation(
  errors:
      (json['errors'] as List<dynamic>?)
          ?.map((e) => ClaimValidationError.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <ClaimValidationError>[],
  warnings:
      (json['warnings'] as List<dynamic>?)
          ?.map((e) => ClaimValidationError.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <ClaimValidationError>[],
);

Map<String, dynamic> _$ClaimValidationToJson(_ClaimValidation instance) =>
    <String, dynamic>{'errors': instance.errors, 'warnings': instance.warnings};
