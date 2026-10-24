import 'package:freezed_annotation/freezed_annotation.dart';

part 'claim_models.freezed.dart';
part 'claim_models.g.dart';

@freezed
abstract class ClaimPeriod with _$ClaimPeriod {
  const factory ClaimPeriod({String? from, String? to}) = _ClaimPeriod;

  factory ClaimPeriod.fromJson(Map<String, dynamic> json) =>
      _$ClaimPeriodFromJson(json);
}

@freezed
abstract class ClaimTotals with _$ClaimTotals {
  const factory ClaimTotals({
    @Default(0) int lines,
    @Default(0) double amount,
  }) = _ClaimTotals;

  factory ClaimTotals.fromJson(Map<String, dynamic> json) =>
      _$ClaimTotalsFromJson(json);
}

@freezed
abstract class ClaimRemittance with _$ClaimRemittance {
  const factory ClaimRemittance({
    @Default('unpaid') String status,
    @Default(0) double paidAmount,
    String? paidAt,
    @Default('') String reference,
    @Default('') String notes,
  }) = _ClaimRemittance;

  factory ClaimRemittance.fromJson(Map<String, dynamic> json) =>
      _$ClaimRemittanceFromJson(json);
}

@freezed
abstract class ClaimBatch with _$ClaimBatch {
  const factory ClaimBatch({
    required String id,
    @Default('draft') String status,
    @Default('ndia_managed') String fundingType,
    @Default('') String registrationNumber,
    @Default('') String abn,
    ClaimPeriod? period,
    @Default(ClaimTotals()) ClaimTotals totals,
    String? generatedAt,
    String? submittedAt,
    String? reconciledAt,
    @Default('') String portalReference,
    @Default('') String submittedBy,
    ClaimRemittance? remittance,
    String? resubmissionOf,
    String? resubmittedBatchId,
  }) = _ClaimBatch;

  factory ClaimBatch.fromJson(Map<String, dynamic> json) =>
      _$ClaimBatchFromJson(json);
}

@freezed
abstract class ClaimLine with _$ClaimLine {
  const factory ClaimLine({
    required String id,
    @Default('') String ndisNumber,
    @Default('') String supportNumber,
    @Default('') String claimReference,
    @Default(0) double quantity,
    @Default(0) double unitPrice,
    @Default(0) double requestedAmount,
    @Default('P2') String gstCode,
    @Default('DIRECT_SERVICE') String claimType,
    @Default('pending') String status,
    @Default('') String rejectionReason,
    @Default(0) double paidAmount,
    String? paidAt,
    @Default('') String remittanceReference,
    String? resubmittedInBatchId,
    String? serviceDate,
  }) = _ClaimLine;

  factory ClaimLine.fromJson(Map<String, dynamic> json) =>
      _$ClaimLineFromJson(json);
}

@freezed
abstract class ClaimValidationError with _$ClaimValidationError {
  const factory ClaimValidationError({
    @Default('') String claimReference,
    @Default('') String field,
    @Default('') String message,
  }) = _ClaimValidationError;

  factory ClaimValidationError.fromJson(Map<String, dynamic> json) =>
      _$ClaimValidationErrorFromJson(json);
}

@freezed
abstract class ClaimValidation with _$ClaimValidation {
  const factory ClaimValidation({
    @Default(<ClaimValidationError>[]) List<ClaimValidationError> errors,
    @Default(<ClaimValidationError>[]) List<ClaimValidationError> warnings,
  }) = _ClaimValidation;

  factory ClaimValidation.fromJson(Map<String, dynamic> json) =>
      _$ClaimValidationFromJson(json);
}
