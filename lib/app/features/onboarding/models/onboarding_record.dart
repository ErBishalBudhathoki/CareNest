import 'package:freezed_annotation/freezed_annotation.dart';

part 'onboarding_record.freezed.dart';
part 'onboarding_record.g.dart';

@freezed
class OnboardingRecord with _$OnboardingRecord {
  const factory OnboardingRecord({
    required String userId,
    required String organizationId,
    required String status,
    required int currentStep,
    required OnboardingSteps steps,
    required ProbationDetails probation,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _OnboardingRecord;

  factory OnboardingRecord.fromJson(Map<String, dynamic> json) =>
      _$OnboardingRecordFromJson(json);
}

@freezed
class OnboardingSteps with _$OnboardingSteps {
  const factory OnboardingSteps({
    required StepDetail personalDetails,
    required BankDetailsStep bankDetails,
    required TaxDetailsStep taxDetails,
    required SuperannuationStep superannuation,
    required DocumentStep documents,
  }) = _OnboardingSteps;

  factory OnboardingSteps.fromJson(Map<String, dynamic> json) =>
      _$OnboardingStepsFromJson(json);
}

@freezed
class BankDetailsStep with _$BankDetailsStep {
  const factory BankDetailsStep({
    required String status,
    String? bankName,
    String? accountName,
    String? bsb,
    String? accountNumber,
    DateTime? updatedAt,
  }) = _BankDetailsStep;

  factory BankDetailsStep.fromJson(Map<String, dynamic> json) =>
      _$BankDetailsStepFromJson(json);
}

@freezed
class StepDetail with _$StepDetail {
  const factory StepDetail({
    required String status,
    DateTime? updatedAt,
  }) = _StepDetail;

  factory StepDetail.fromJson(Map<String, dynamic> json) =>
      _$StepDetailFromJson(json);
}

@freezed
class TaxDetailsStep with _$TaxDetailsStep {
  const factory TaxDetailsStep({
    required String status,
    String? tfn,
    String? taxScale,
    DateTime? updatedAt,
  }) = _TaxDetailsStep;

  factory TaxDetailsStep.fromJson(Map<String, dynamic> json) =>
      _$TaxDetailsStepFromJson(json);
}

@freezed
class SuperannuationStep with _$SuperannuationStep {
  const factory SuperannuationStep({
    required String status,
    String? fundName,
    String? memberNumber,
    String? usi,
    DateTime? updatedAt,
  }) = _SuperannuationStep;

  factory SuperannuationStep.fromJson(Map<String, dynamic> json) =>
      _$SuperannuationStepFromJson(json);
}

@freezed
class DocumentStep with _$DocumentStep {
  const factory DocumentStep({
    required String status,
    @Default(0) int count,
    DateTime? updatedAt,
  }) = _DocumentStep;

  factory DocumentStep.fromJson(Map<String, dynamic> json) =>
      _$DocumentStepFromJson(json);
}

@freezed
class ProbationDetails with _$ProbationDetails {
  const factory ProbationDetails({
    DateTime? startDate,
    DateTime? endDate,
    DateTime? reviewDate,
    required String status,
  }) = _ProbationDetails;

  factory ProbationDetails.fromJson(Map<String, dynamic> json) =>
      _$ProbationDetailsFromJson(json);
}
