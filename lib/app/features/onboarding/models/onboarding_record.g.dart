// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OnboardingRecord _$OnboardingRecordFromJson(Map<String, dynamic> json) =>
    _OnboardingRecord(
      userId: json['userId'] as String,
      organizationId: json['organizationId'] as String,
      status: json['status'] as String,
      currentStep: (json['currentStep'] as num).toInt(),
      steps: OnboardingSteps.fromJson(json['steps'] as Map<String, dynamic>),
      probation: ProbationDetails.fromJson(
        json['probation'] as Map<String, dynamic>,
      ),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$OnboardingRecordToJson(_OnboardingRecord instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'organizationId': instance.organizationId,
      'status': instance.status,
      'currentStep': instance.currentStep,
      'steps': instance.steps,
      'probation': instance.probation,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

_OnboardingSteps _$OnboardingStepsFromJson(Map<String, dynamic> json) =>
    _OnboardingSteps(
      personalDetails: StepDetail.fromJson(
        json['personalDetails'] as Map<String, dynamic>,
      ),
      bankDetails: BankDetailsStep.fromJson(
        json['bankDetails'] as Map<String, dynamic>,
      ),
      taxDetails: TaxDetailsStep.fromJson(
        json['taxDetails'] as Map<String, dynamic>,
      ),
      superannuation: SuperannuationStep.fromJson(
        json['superannuation'] as Map<String, dynamic>,
      ),
      documents: DocumentStep.fromJson(
        json['documents'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$OnboardingStepsToJson(_OnboardingSteps instance) =>
    <String, dynamic>{
      'personalDetails': instance.personalDetails,
      'bankDetails': instance.bankDetails,
      'taxDetails': instance.taxDetails,
      'superannuation': instance.superannuation,
      'documents': instance.documents,
    };

_BankDetailsStep _$BankDetailsStepFromJson(Map<String, dynamic> json) =>
    _BankDetailsStep(
      status: json['status'] as String,
      bankName: json['bankName'] as String?,
      accountName: json['accountName'] as String?,
      bsb: json['bsb'] as String?,
      accountNumber: json['accountNumber'] as String?,
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$BankDetailsStepToJson(_BankDetailsStep instance) =>
    <String, dynamic>{
      'status': instance.status,
      'bankName': instance.bankName,
      'accountName': instance.accountName,
      'bsb': instance.bsb,
      'accountNumber': instance.accountNumber,
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

_StepDetail _$StepDetailFromJson(Map<String, dynamic> json) => _StepDetail(
  status: json['status'] as String,
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$StepDetailToJson(_StepDetail instance) =>
    <String, dynamic>{
      'status': instance.status,
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

_TaxDetailsStep _$TaxDetailsStepFromJson(Map<String, dynamic> json) =>
    _TaxDetailsStep(
      status: json['status'] as String,
      tfn: json['tfn'] as String?,
      taxScale: json['taxScale'] as String?,
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$TaxDetailsStepToJson(_TaxDetailsStep instance) =>
    <String, dynamic>{
      'status': instance.status,
      'tfn': instance.tfn,
      'taxScale': instance.taxScale,
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

_SuperannuationStep _$SuperannuationStepFromJson(Map<String, dynamic> json) =>
    _SuperannuationStep(
      status: json['status'] as String,
      fundName: json['fundName'] as String?,
      memberNumber: json['memberNumber'] as String?,
      usi: json['usi'] as String?,
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$SuperannuationStepToJson(_SuperannuationStep instance) =>
    <String, dynamic>{
      'status': instance.status,
      'fundName': instance.fundName,
      'memberNumber': instance.memberNumber,
      'usi': instance.usi,
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

_DocumentStep _$DocumentStepFromJson(Map<String, dynamic> json) =>
    _DocumentStep(
      status: json['status'] as String,
      count: (json['count'] as num?)?.toInt() ?? 0,
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$DocumentStepToJson(_DocumentStep instance) =>
    <String, dynamic>{
      'status': instance.status,
      'count': instance.count,
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

_ProbationDetails _$ProbationDetailsFromJson(Map<String, dynamic> json) =>
    _ProbationDetails(
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      reviewDate: json['reviewDate'] == null
          ? null
          : DateTime.parse(json['reviewDate'] as String),
      status: json['status'] as String,
    );

Map<String, dynamic> _$ProbationDetailsToJson(_ProbationDetails instance) =>
    <String, dynamic>{
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'reviewDate': instance.reviewDate?.toIso8601String(),
      'status': instance.status,
    };
