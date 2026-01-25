// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OnboardingRecordImpl _$$OnboardingRecordImplFromJson(
        Map<String, dynamic> json) =>
    _$OnboardingRecordImpl(
      userId: json['userId'] as String,
      organizationId: json['organizationId'] as String,
      status: json['status'] as String,
      currentStep: (json['currentStep'] as num).toInt(),
      steps: OnboardingSteps.fromJson(json['steps'] as Map<String, dynamic>),
      probation:
          ProbationDetails.fromJson(json['probation'] as Map<String, dynamic>),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$OnboardingRecordImplToJson(
        _$OnboardingRecordImpl instance) =>
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

_$OnboardingStepsImpl _$$OnboardingStepsImplFromJson(
        Map<String, dynamic> json) =>
    _$OnboardingStepsImpl(
      personalDetails:
          StepDetail.fromJson(json['personalDetails'] as Map<String, dynamic>),
      bankDetails:
          BankDetailsStep.fromJson(json['bankDetails'] as Map<String, dynamic>),
      taxDetails:
          TaxDetailsStep.fromJson(json['taxDetails'] as Map<String, dynamic>),
      superannuation: SuperannuationStep.fromJson(
          json['superannuation'] as Map<String, dynamic>),
      documents:
          DocumentStep.fromJson(json['documents'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$OnboardingStepsImplToJson(
        _$OnboardingStepsImpl instance) =>
    <String, dynamic>{
      'personalDetails': instance.personalDetails,
      'bankDetails': instance.bankDetails,
      'taxDetails': instance.taxDetails,
      'superannuation': instance.superannuation,
      'documents': instance.documents,
    };

_$BankDetailsStepImpl _$$BankDetailsStepImplFromJson(
        Map<String, dynamic> json) =>
    _$BankDetailsStepImpl(
      status: json['status'] as String,
      bankName: json['bankName'] as String?,
      accountName: json['accountName'] as String?,
      bsb: json['bsb'] as String?,
      accountNumber: json['accountNumber'] as String?,
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$BankDetailsStepImplToJson(
        _$BankDetailsStepImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'bankName': instance.bankName,
      'accountName': instance.accountName,
      'bsb': instance.bsb,
      'accountNumber': instance.accountNumber,
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

_$StepDetailImpl _$$StepDetailImplFromJson(Map<String, dynamic> json) =>
    _$StepDetailImpl(
      status: json['status'] as String,
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$StepDetailImplToJson(_$StepDetailImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

_$TaxDetailsStepImpl _$$TaxDetailsStepImplFromJson(Map<String, dynamic> json) =>
    _$TaxDetailsStepImpl(
      status: json['status'] as String,
      tfn: json['tfn'] as String?,
      taxScale: json['taxScale'] as String?,
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$TaxDetailsStepImplToJson(
        _$TaxDetailsStepImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'tfn': instance.tfn,
      'taxScale': instance.taxScale,
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

_$SuperannuationStepImpl _$$SuperannuationStepImplFromJson(
        Map<String, dynamic> json) =>
    _$SuperannuationStepImpl(
      status: json['status'] as String,
      fundName: json['fundName'] as String?,
      memberNumber: json['memberNumber'] as String?,
      usi: json['usi'] as String?,
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$SuperannuationStepImplToJson(
        _$SuperannuationStepImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'fundName': instance.fundName,
      'memberNumber': instance.memberNumber,
      'usi': instance.usi,
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

_$DocumentStepImpl _$$DocumentStepImplFromJson(Map<String, dynamic> json) =>
    _$DocumentStepImpl(
      status: json['status'] as String,
      count: (json['count'] as num?)?.toInt() ?? 0,
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$DocumentStepImplToJson(_$DocumentStepImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'count': instance.count,
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

_$ProbationDetailsImpl _$$ProbationDetailsImplFromJson(
        Map<String, dynamic> json) =>
    _$ProbationDetailsImpl(
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

Map<String, dynamic> _$$ProbationDetailsImplToJson(
        _$ProbationDetailsImpl instance) =>
    <String, dynamic>{
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'reviewDate': instance.reviewDate?.toIso8601String(),
      'status': instance.status,
    };
