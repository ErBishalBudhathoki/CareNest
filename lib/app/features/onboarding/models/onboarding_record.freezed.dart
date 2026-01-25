// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'onboarding_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

OnboardingRecord _$OnboardingRecordFromJson(Map<String, dynamic> json) {
  return _OnboardingRecord.fromJson(json);
}

/// @nodoc
mixin _$OnboardingRecord {
  String get userId => throw _privateConstructorUsedError;
  String get organizationId => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  int get currentStep => throw _privateConstructorUsedError;
  OnboardingSteps get steps => throw _privateConstructorUsedError;
  ProbationDetails get probation => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OnboardingRecordCopyWith<OnboardingRecord> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OnboardingRecordCopyWith<$Res> {
  factory $OnboardingRecordCopyWith(
          OnboardingRecord value, $Res Function(OnboardingRecord) then) =
      _$OnboardingRecordCopyWithImpl<$Res, OnboardingRecord>;
  @useResult
  $Res call(
      {String userId,
      String organizationId,
      String status,
      int currentStep,
      OnboardingSteps steps,
      ProbationDetails probation,
      DateTime? createdAt,
      DateTime? updatedAt});

  $OnboardingStepsCopyWith<$Res> get steps;
  $ProbationDetailsCopyWith<$Res> get probation;
}

/// @nodoc
class _$OnboardingRecordCopyWithImpl<$Res, $Val extends OnboardingRecord>
    implements $OnboardingRecordCopyWith<$Res> {
  _$OnboardingRecordCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? organizationId = null,
    Object? status = null,
    Object? currentStep = null,
    Object? steps = null,
    Object? probation = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      currentStep: null == currentStep
          ? _value.currentStep
          : currentStep // ignore: cast_nullable_to_non_nullable
              as int,
      steps: null == steps
          ? _value.steps
          : steps // ignore: cast_nullable_to_non_nullable
              as OnboardingSteps,
      probation: null == probation
          ? _value.probation
          : probation // ignore: cast_nullable_to_non_nullable
              as ProbationDetails,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $OnboardingStepsCopyWith<$Res> get steps {
    return $OnboardingStepsCopyWith<$Res>(_value.steps, (value) {
      return _then(_value.copyWith(steps: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ProbationDetailsCopyWith<$Res> get probation {
    return $ProbationDetailsCopyWith<$Res>(_value.probation, (value) {
      return _then(_value.copyWith(probation: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$OnboardingRecordImplCopyWith<$Res>
    implements $OnboardingRecordCopyWith<$Res> {
  factory _$$OnboardingRecordImplCopyWith(_$OnboardingRecordImpl value,
          $Res Function(_$OnboardingRecordImpl) then) =
      __$$OnboardingRecordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userId,
      String organizationId,
      String status,
      int currentStep,
      OnboardingSteps steps,
      ProbationDetails probation,
      DateTime? createdAt,
      DateTime? updatedAt});

  @override
  $OnboardingStepsCopyWith<$Res> get steps;
  @override
  $ProbationDetailsCopyWith<$Res> get probation;
}

/// @nodoc
class __$$OnboardingRecordImplCopyWithImpl<$Res>
    extends _$OnboardingRecordCopyWithImpl<$Res, _$OnboardingRecordImpl>
    implements _$$OnboardingRecordImplCopyWith<$Res> {
  __$$OnboardingRecordImplCopyWithImpl(_$OnboardingRecordImpl _value,
      $Res Function(_$OnboardingRecordImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? organizationId = null,
    Object? status = null,
    Object? currentStep = null,
    Object? steps = null,
    Object? probation = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$OnboardingRecordImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      currentStep: null == currentStep
          ? _value.currentStep
          : currentStep // ignore: cast_nullable_to_non_nullable
              as int,
      steps: null == steps
          ? _value.steps
          : steps // ignore: cast_nullable_to_non_nullable
              as OnboardingSteps,
      probation: null == probation
          ? _value.probation
          : probation // ignore: cast_nullable_to_non_nullable
              as ProbationDetails,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OnboardingRecordImpl implements _OnboardingRecord {
  const _$OnboardingRecordImpl(
      {required this.userId,
      required this.organizationId,
      required this.status,
      required this.currentStep,
      required this.steps,
      required this.probation,
      this.createdAt,
      this.updatedAt});

  factory _$OnboardingRecordImpl.fromJson(Map<String, dynamic> json) =>
      _$$OnboardingRecordImplFromJson(json);

  @override
  final String userId;
  @override
  final String organizationId;
  @override
  final String status;
  @override
  final int currentStep;
  @override
  final OnboardingSteps steps;
  @override
  final ProbationDetails probation;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'OnboardingRecord(userId: $userId, organizationId: $organizationId, status: $status, currentStep: $currentStep, steps: $steps, probation: $probation, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OnboardingRecordImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.currentStep, currentStep) ||
                other.currentStep == currentStep) &&
            (identical(other.steps, steps) || other.steps == steps) &&
            (identical(other.probation, probation) ||
                other.probation == probation) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, userId, organizationId, status,
      currentStep, steps, probation, createdAt, updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OnboardingRecordImplCopyWith<_$OnboardingRecordImpl> get copyWith =>
      __$$OnboardingRecordImplCopyWithImpl<_$OnboardingRecordImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OnboardingRecordImplToJson(
      this,
    );
  }
}

abstract class _OnboardingRecord implements OnboardingRecord {
  const factory _OnboardingRecord(
      {required final String userId,
      required final String organizationId,
      required final String status,
      required final int currentStep,
      required final OnboardingSteps steps,
      required final ProbationDetails probation,
      final DateTime? createdAt,
      final DateTime? updatedAt}) = _$OnboardingRecordImpl;

  factory _OnboardingRecord.fromJson(Map<String, dynamic> json) =
      _$OnboardingRecordImpl.fromJson;

  @override
  String get userId;
  @override
  String get organizationId;
  @override
  String get status;
  @override
  int get currentStep;
  @override
  OnboardingSteps get steps;
  @override
  ProbationDetails get probation;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$OnboardingRecordImplCopyWith<_$OnboardingRecordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OnboardingSteps _$OnboardingStepsFromJson(Map<String, dynamic> json) {
  return _OnboardingSteps.fromJson(json);
}

/// @nodoc
mixin _$OnboardingSteps {
  StepDetail get personalDetails => throw _privateConstructorUsedError;
  BankDetailsStep get bankDetails => throw _privateConstructorUsedError;
  TaxDetailsStep get taxDetails => throw _privateConstructorUsedError;
  SuperannuationStep get superannuation => throw _privateConstructorUsedError;
  DocumentStep get documents => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OnboardingStepsCopyWith<OnboardingSteps> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OnboardingStepsCopyWith<$Res> {
  factory $OnboardingStepsCopyWith(
          OnboardingSteps value, $Res Function(OnboardingSteps) then) =
      _$OnboardingStepsCopyWithImpl<$Res, OnboardingSteps>;
  @useResult
  $Res call(
      {StepDetail personalDetails,
      BankDetailsStep bankDetails,
      TaxDetailsStep taxDetails,
      SuperannuationStep superannuation,
      DocumentStep documents});

  $StepDetailCopyWith<$Res> get personalDetails;
  $BankDetailsStepCopyWith<$Res> get bankDetails;
  $TaxDetailsStepCopyWith<$Res> get taxDetails;
  $SuperannuationStepCopyWith<$Res> get superannuation;
  $DocumentStepCopyWith<$Res> get documents;
}

/// @nodoc
class _$OnboardingStepsCopyWithImpl<$Res, $Val extends OnboardingSteps>
    implements $OnboardingStepsCopyWith<$Res> {
  _$OnboardingStepsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? personalDetails = null,
    Object? bankDetails = null,
    Object? taxDetails = null,
    Object? superannuation = null,
    Object? documents = null,
  }) {
    return _then(_value.copyWith(
      personalDetails: null == personalDetails
          ? _value.personalDetails
          : personalDetails // ignore: cast_nullable_to_non_nullable
              as StepDetail,
      bankDetails: null == bankDetails
          ? _value.bankDetails
          : bankDetails // ignore: cast_nullable_to_non_nullable
              as BankDetailsStep,
      taxDetails: null == taxDetails
          ? _value.taxDetails
          : taxDetails // ignore: cast_nullable_to_non_nullable
              as TaxDetailsStep,
      superannuation: null == superannuation
          ? _value.superannuation
          : superannuation // ignore: cast_nullable_to_non_nullable
              as SuperannuationStep,
      documents: null == documents
          ? _value.documents
          : documents // ignore: cast_nullable_to_non_nullable
              as DocumentStep,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $StepDetailCopyWith<$Res> get personalDetails {
    return $StepDetailCopyWith<$Res>(_value.personalDetails, (value) {
      return _then(_value.copyWith(personalDetails: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $BankDetailsStepCopyWith<$Res> get bankDetails {
    return $BankDetailsStepCopyWith<$Res>(_value.bankDetails, (value) {
      return _then(_value.copyWith(bankDetails: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $TaxDetailsStepCopyWith<$Res> get taxDetails {
    return $TaxDetailsStepCopyWith<$Res>(_value.taxDetails, (value) {
      return _then(_value.copyWith(taxDetails: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $SuperannuationStepCopyWith<$Res> get superannuation {
    return $SuperannuationStepCopyWith<$Res>(_value.superannuation, (value) {
      return _then(_value.copyWith(superannuation: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $DocumentStepCopyWith<$Res> get documents {
    return $DocumentStepCopyWith<$Res>(_value.documents, (value) {
      return _then(_value.copyWith(documents: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$OnboardingStepsImplCopyWith<$Res>
    implements $OnboardingStepsCopyWith<$Res> {
  factory _$$OnboardingStepsImplCopyWith(_$OnboardingStepsImpl value,
          $Res Function(_$OnboardingStepsImpl) then) =
      __$$OnboardingStepsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {StepDetail personalDetails,
      BankDetailsStep bankDetails,
      TaxDetailsStep taxDetails,
      SuperannuationStep superannuation,
      DocumentStep documents});

  @override
  $StepDetailCopyWith<$Res> get personalDetails;
  @override
  $BankDetailsStepCopyWith<$Res> get bankDetails;
  @override
  $TaxDetailsStepCopyWith<$Res> get taxDetails;
  @override
  $SuperannuationStepCopyWith<$Res> get superannuation;
  @override
  $DocumentStepCopyWith<$Res> get documents;
}

/// @nodoc
class __$$OnboardingStepsImplCopyWithImpl<$Res>
    extends _$OnboardingStepsCopyWithImpl<$Res, _$OnboardingStepsImpl>
    implements _$$OnboardingStepsImplCopyWith<$Res> {
  __$$OnboardingStepsImplCopyWithImpl(
      _$OnboardingStepsImpl _value, $Res Function(_$OnboardingStepsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? personalDetails = null,
    Object? bankDetails = null,
    Object? taxDetails = null,
    Object? superannuation = null,
    Object? documents = null,
  }) {
    return _then(_$OnboardingStepsImpl(
      personalDetails: null == personalDetails
          ? _value.personalDetails
          : personalDetails // ignore: cast_nullable_to_non_nullable
              as StepDetail,
      bankDetails: null == bankDetails
          ? _value.bankDetails
          : bankDetails // ignore: cast_nullable_to_non_nullable
              as BankDetailsStep,
      taxDetails: null == taxDetails
          ? _value.taxDetails
          : taxDetails // ignore: cast_nullable_to_non_nullable
              as TaxDetailsStep,
      superannuation: null == superannuation
          ? _value.superannuation
          : superannuation // ignore: cast_nullable_to_non_nullable
              as SuperannuationStep,
      documents: null == documents
          ? _value.documents
          : documents // ignore: cast_nullable_to_non_nullable
              as DocumentStep,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OnboardingStepsImpl implements _OnboardingSteps {
  const _$OnboardingStepsImpl(
      {required this.personalDetails,
      required this.bankDetails,
      required this.taxDetails,
      required this.superannuation,
      required this.documents});

  factory _$OnboardingStepsImpl.fromJson(Map<String, dynamic> json) =>
      _$$OnboardingStepsImplFromJson(json);

  @override
  final StepDetail personalDetails;
  @override
  final BankDetailsStep bankDetails;
  @override
  final TaxDetailsStep taxDetails;
  @override
  final SuperannuationStep superannuation;
  @override
  final DocumentStep documents;

  @override
  String toString() {
    return 'OnboardingSteps(personalDetails: $personalDetails, bankDetails: $bankDetails, taxDetails: $taxDetails, superannuation: $superannuation, documents: $documents)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OnboardingStepsImpl &&
            (identical(other.personalDetails, personalDetails) ||
                other.personalDetails == personalDetails) &&
            (identical(other.bankDetails, bankDetails) ||
                other.bankDetails == bankDetails) &&
            (identical(other.taxDetails, taxDetails) ||
                other.taxDetails == taxDetails) &&
            (identical(other.superannuation, superannuation) ||
                other.superannuation == superannuation) &&
            (identical(other.documents, documents) ||
                other.documents == documents));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, personalDetails, bankDetails,
      taxDetails, superannuation, documents);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OnboardingStepsImplCopyWith<_$OnboardingStepsImpl> get copyWith =>
      __$$OnboardingStepsImplCopyWithImpl<_$OnboardingStepsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OnboardingStepsImplToJson(
      this,
    );
  }
}

abstract class _OnboardingSteps implements OnboardingSteps {
  const factory _OnboardingSteps(
      {required final StepDetail personalDetails,
      required final BankDetailsStep bankDetails,
      required final TaxDetailsStep taxDetails,
      required final SuperannuationStep superannuation,
      required final DocumentStep documents}) = _$OnboardingStepsImpl;

  factory _OnboardingSteps.fromJson(Map<String, dynamic> json) =
      _$OnboardingStepsImpl.fromJson;

  @override
  StepDetail get personalDetails;
  @override
  BankDetailsStep get bankDetails;
  @override
  TaxDetailsStep get taxDetails;
  @override
  SuperannuationStep get superannuation;
  @override
  DocumentStep get documents;
  @override
  @JsonKey(ignore: true)
  _$$OnboardingStepsImplCopyWith<_$OnboardingStepsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BankDetailsStep _$BankDetailsStepFromJson(Map<String, dynamic> json) {
  return _BankDetailsStep.fromJson(json);
}

/// @nodoc
mixin _$BankDetailsStep {
  String get status => throw _privateConstructorUsedError;
  String? get bankName => throw _privateConstructorUsedError;
  String? get accountName => throw _privateConstructorUsedError;
  String? get bsb => throw _privateConstructorUsedError;
  String? get accountNumber => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BankDetailsStepCopyWith<BankDetailsStep> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BankDetailsStepCopyWith<$Res> {
  factory $BankDetailsStepCopyWith(
          BankDetailsStep value, $Res Function(BankDetailsStep) then) =
      _$BankDetailsStepCopyWithImpl<$Res, BankDetailsStep>;
  @useResult
  $Res call(
      {String status,
      String? bankName,
      String? accountName,
      String? bsb,
      String? accountNumber,
      DateTime? updatedAt});
}

/// @nodoc
class _$BankDetailsStepCopyWithImpl<$Res, $Val extends BankDetailsStep>
    implements $BankDetailsStepCopyWith<$Res> {
  _$BankDetailsStepCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? bankName = freezed,
    Object? accountName = freezed,
    Object? bsb = freezed,
    Object? accountNumber = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      bankName: freezed == bankName
          ? _value.bankName
          : bankName // ignore: cast_nullable_to_non_nullable
              as String?,
      accountName: freezed == accountName
          ? _value.accountName
          : accountName // ignore: cast_nullable_to_non_nullable
              as String?,
      bsb: freezed == bsb
          ? _value.bsb
          : bsb // ignore: cast_nullable_to_non_nullable
              as String?,
      accountNumber: freezed == accountNumber
          ? _value.accountNumber
          : accountNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BankDetailsStepImplCopyWith<$Res>
    implements $BankDetailsStepCopyWith<$Res> {
  factory _$$BankDetailsStepImplCopyWith(_$BankDetailsStepImpl value,
          $Res Function(_$BankDetailsStepImpl) then) =
      __$$BankDetailsStepImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String status,
      String? bankName,
      String? accountName,
      String? bsb,
      String? accountNumber,
      DateTime? updatedAt});
}

/// @nodoc
class __$$BankDetailsStepImplCopyWithImpl<$Res>
    extends _$BankDetailsStepCopyWithImpl<$Res, _$BankDetailsStepImpl>
    implements _$$BankDetailsStepImplCopyWith<$Res> {
  __$$BankDetailsStepImplCopyWithImpl(
      _$BankDetailsStepImpl _value, $Res Function(_$BankDetailsStepImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? bankName = freezed,
    Object? accountName = freezed,
    Object? bsb = freezed,
    Object? accountNumber = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$BankDetailsStepImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      bankName: freezed == bankName
          ? _value.bankName
          : bankName // ignore: cast_nullable_to_non_nullable
              as String?,
      accountName: freezed == accountName
          ? _value.accountName
          : accountName // ignore: cast_nullable_to_non_nullable
              as String?,
      bsb: freezed == bsb
          ? _value.bsb
          : bsb // ignore: cast_nullable_to_non_nullable
              as String?,
      accountNumber: freezed == accountNumber
          ? _value.accountNumber
          : accountNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BankDetailsStepImpl implements _BankDetailsStep {
  const _$BankDetailsStepImpl(
      {required this.status,
      this.bankName,
      this.accountName,
      this.bsb,
      this.accountNumber,
      this.updatedAt});

  factory _$BankDetailsStepImpl.fromJson(Map<String, dynamic> json) =>
      _$$BankDetailsStepImplFromJson(json);

  @override
  final String status;
  @override
  final String? bankName;
  @override
  final String? accountName;
  @override
  final String? bsb;
  @override
  final String? accountNumber;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'BankDetailsStep(status: $status, bankName: $bankName, accountName: $accountName, bsb: $bsb, accountNumber: $accountNumber, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BankDetailsStepImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.bankName, bankName) ||
                other.bankName == bankName) &&
            (identical(other.accountName, accountName) ||
                other.accountName == accountName) &&
            (identical(other.bsb, bsb) || other.bsb == bsb) &&
            (identical(other.accountNumber, accountNumber) ||
                other.accountNumber == accountNumber) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, status, bankName, accountName,
      bsb, accountNumber, updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BankDetailsStepImplCopyWith<_$BankDetailsStepImpl> get copyWith =>
      __$$BankDetailsStepImplCopyWithImpl<_$BankDetailsStepImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BankDetailsStepImplToJson(
      this,
    );
  }
}

abstract class _BankDetailsStep implements BankDetailsStep {
  const factory _BankDetailsStep(
      {required final String status,
      final String? bankName,
      final String? accountName,
      final String? bsb,
      final String? accountNumber,
      final DateTime? updatedAt}) = _$BankDetailsStepImpl;

  factory _BankDetailsStep.fromJson(Map<String, dynamic> json) =
      _$BankDetailsStepImpl.fromJson;

  @override
  String get status;
  @override
  String? get bankName;
  @override
  String? get accountName;
  @override
  String? get bsb;
  @override
  String? get accountNumber;
  @override
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$BankDetailsStepImplCopyWith<_$BankDetailsStepImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StepDetail _$StepDetailFromJson(Map<String, dynamic> json) {
  return _StepDetail.fromJson(json);
}

/// @nodoc
mixin _$StepDetail {
  String get status => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StepDetailCopyWith<StepDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StepDetailCopyWith<$Res> {
  factory $StepDetailCopyWith(
          StepDetail value, $Res Function(StepDetail) then) =
      _$StepDetailCopyWithImpl<$Res, StepDetail>;
  @useResult
  $Res call({String status, DateTime? updatedAt});
}

/// @nodoc
class _$StepDetailCopyWithImpl<$Res, $Val extends StepDetail>
    implements $StepDetailCopyWith<$Res> {
  _$StepDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StepDetailImplCopyWith<$Res>
    implements $StepDetailCopyWith<$Res> {
  factory _$$StepDetailImplCopyWith(
          _$StepDetailImpl value, $Res Function(_$StepDetailImpl) then) =
      __$$StepDetailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String status, DateTime? updatedAt});
}

/// @nodoc
class __$$StepDetailImplCopyWithImpl<$Res>
    extends _$StepDetailCopyWithImpl<$Res, _$StepDetailImpl>
    implements _$$StepDetailImplCopyWith<$Res> {
  __$$StepDetailImplCopyWithImpl(
      _$StepDetailImpl _value, $Res Function(_$StepDetailImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? updatedAt = freezed,
  }) {
    return _then(_$StepDetailImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StepDetailImpl implements _StepDetail {
  const _$StepDetailImpl({required this.status, this.updatedAt});

  factory _$StepDetailImpl.fromJson(Map<String, dynamic> json) =>
      _$$StepDetailImplFromJson(json);

  @override
  final String status;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'StepDetail(status: $status, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StepDetailImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, status, updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StepDetailImplCopyWith<_$StepDetailImpl> get copyWith =>
      __$$StepDetailImplCopyWithImpl<_$StepDetailImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StepDetailImplToJson(
      this,
    );
  }
}

abstract class _StepDetail implements StepDetail {
  const factory _StepDetail(
      {required final String status,
      final DateTime? updatedAt}) = _$StepDetailImpl;

  factory _StepDetail.fromJson(Map<String, dynamic> json) =
      _$StepDetailImpl.fromJson;

  @override
  String get status;
  @override
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$StepDetailImplCopyWith<_$StepDetailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TaxDetailsStep _$TaxDetailsStepFromJson(Map<String, dynamic> json) {
  return _TaxDetailsStep.fromJson(json);
}

/// @nodoc
mixin _$TaxDetailsStep {
  String get status => throw _privateConstructorUsedError;
  String? get tfn => throw _privateConstructorUsedError;
  String? get taxScale => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TaxDetailsStepCopyWith<TaxDetailsStep> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaxDetailsStepCopyWith<$Res> {
  factory $TaxDetailsStepCopyWith(
          TaxDetailsStep value, $Res Function(TaxDetailsStep) then) =
      _$TaxDetailsStepCopyWithImpl<$Res, TaxDetailsStep>;
  @useResult
  $Res call(
      {String status, String? tfn, String? taxScale, DateTime? updatedAt});
}

/// @nodoc
class _$TaxDetailsStepCopyWithImpl<$Res, $Val extends TaxDetailsStep>
    implements $TaxDetailsStepCopyWith<$Res> {
  _$TaxDetailsStepCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? tfn = freezed,
    Object? taxScale = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      tfn: freezed == tfn
          ? _value.tfn
          : tfn // ignore: cast_nullable_to_non_nullable
              as String?,
      taxScale: freezed == taxScale
          ? _value.taxScale
          : taxScale // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TaxDetailsStepImplCopyWith<$Res>
    implements $TaxDetailsStepCopyWith<$Res> {
  factory _$$TaxDetailsStepImplCopyWith(_$TaxDetailsStepImpl value,
          $Res Function(_$TaxDetailsStepImpl) then) =
      __$$TaxDetailsStepImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String status, String? tfn, String? taxScale, DateTime? updatedAt});
}

/// @nodoc
class __$$TaxDetailsStepImplCopyWithImpl<$Res>
    extends _$TaxDetailsStepCopyWithImpl<$Res, _$TaxDetailsStepImpl>
    implements _$$TaxDetailsStepImplCopyWith<$Res> {
  __$$TaxDetailsStepImplCopyWithImpl(
      _$TaxDetailsStepImpl _value, $Res Function(_$TaxDetailsStepImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? tfn = freezed,
    Object? taxScale = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$TaxDetailsStepImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      tfn: freezed == tfn
          ? _value.tfn
          : tfn // ignore: cast_nullable_to_non_nullable
              as String?,
      taxScale: freezed == taxScale
          ? _value.taxScale
          : taxScale // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TaxDetailsStepImpl implements _TaxDetailsStep {
  const _$TaxDetailsStepImpl(
      {required this.status, this.tfn, this.taxScale, this.updatedAt});

  factory _$TaxDetailsStepImpl.fromJson(Map<String, dynamic> json) =>
      _$$TaxDetailsStepImplFromJson(json);

  @override
  final String status;
  @override
  final String? tfn;
  @override
  final String? taxScale;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'TaxDetailsStep(status: $status, tfn: $tfn, taxScale: $taxScale, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaxDetailsStepImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.tfn, tfn) || other.tfn == tfn) &&
            (identical(other.taxScale, taxScale) ||
                other.taxScale == taxScale) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, status, tfn, taxScale, updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TaxDetailsStepImplCopyWith<_$TaxDetailsStepImpl> get copyWith =>
      __$$TaxDetailsStepImplCopyWithImpl<_$TaxDetailsStepImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TaxDetailsStepImplToJson(
      this,
    );
  }
}

abstract class _TaxDetailsStep implements TaxDetailsStep {
  const factory _TaxDetailsStep(
      {required final String status,
      final String? tfn,
      final String? taxScale,
      final DateTime? updatedAt}) = _$TaxDetailsStepImpl;

  factory _TaxDetailsStep.fromJson(Map<String, dynamic> json) =
      _$TaxDetailsStepImpl.fromJson;

  @override
  String get status;
  @override
  String? get tfn;
  @override
  String? get taxScale;
  @override
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$TaxDetailsStepImplCopyWith<_$TaxDetailsStepImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SuperannuationStep _$SuperannuationStepFromJson(Map<String, dynamic> json) {
  return _SuperannuationStep.fromJson(json);
}

/// @nodoc
mixin _$SuperannuationStep {
  String get status => throw _privateConstructorUsedError;
  String? get fundName => throw _privateConstructorUsedError;
  String? get memberNumber => throw _privateConstructorUsedError;
  String? get usi => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SuperannuationStepCopyWith<SuperannuationStep> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SuperannuationStepCopyWith<$Res> {
  factory $SuperannuationStepCopyWith(
          SuperannuationStep value, $Res Function(SuperannuationStep) then) =
      _$SuperannuationStepCopyWithImpl<$Res, SuperannuationStep>;
  @useResult
  $Res call(
      {String status,
      String? fundName,
      String? memberNumber,
      String? usi,
      DateTime? updatedAt});
}

/// @nodoc
class _$SuperannuationStepCopyWithImpl<$Res, $Val extends SuperannuationStep>
    implements $SuperannuationStepCopyWith<$Res> {
  _$SuperannuationStepCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? fundName = freezed,
    Object? memberNumber = freezed,
    Object? usi = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      fundName: freezed == fundName
          ? _value.fundName
          : fundName // ignore: cast_nullable_to_non_nullable
              as String?,
      memberNumber: freezed == memberNumber
          ? _value.memberNumber
          : memberNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      usi: freezed == usi
          ? _value.usi
          : usi // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SuperannuationStepImplCopyWith<$Res>
    implements $SuperannuationStepCopyWith<$Res> {
  factory _$$SuperannuationStepImplCopyWith(_$SuperannuationStepImpl value,
          $Res Function(_$SuperannuationStepImpl) then) =
      __$$SuperannuationStepImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String status,
      String? fundName,
      String? memberNumber,
      String? usi,
      DateTime? updatedAt});
}

/// @nodoc
class __$$SuperannuationStepImplCopyWithImpl<$Res>
    extends _$SuperannuationStepCopyWithImpl<$Res, _$SuperannuationStepImpl>
    implements _$$SuperannuationStepImplCopyWith<$Res> {
  __$$SuperannuationStepImplCopyWithImpl(_$SuperannuationStepImpl _value,
      $Res Function(_$SuperannuationStepImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? fundName = freezed,
    Object? memberNumber = freezed,
    Object? usi = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$SuperannuationStepImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      fundName: freezed == fundName
          ? _value.fundName
          : fundName // ignore: cast_nullable_to_non_nullable
              as String?,
      memberNumber: freezed == memberNumber
          ? _value.memberNumber
          : memberNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      usi: freezed == usi
          ? _value.usi
          : usi // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SuperannuationStepImpl implements _SuperannuationStep {
  const _$SuperannuationStepImpl(
      {required this.status,
      this.fundName,
      this.memberNumber,
      this.usi,
      this.updatedAt});

  factory _$SuperannuationStepImpl.fromJson(Map<String, dynamic> json) =>
      _$$SuperannuationStepImplFromJson(json);

  @override
  final String status;
  @override
  final String? fundName;
  @override
  final String? memberNumber;
  @override
  final String? usi;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'SuperannuationStep(status: $status, fundName: $fundName, memberNumber: $memberNumber, usi: $usi, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuperannuationStepImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.fundName, fundName) ||
                other.fundName == fundName) &&
            (identical(other.memberNumber, memberNumber) ||
                other.memberNumber == memberNumber) &&
            (identical(other.usi, usi) || other.usi == usi) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, status, fundName, memberNumber, usi, updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SuperannuationStepImplCopyWith<_$SuperannuationStepImpl> get copyWith =>
      __$$SuperannuationStepImplCopyWithImpl<_$SuperannuationStepImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SuperannuationStepImplToJson(
      this,
    );
  }
}

abstract class _SuperannuationStep implements SuperannuationStep {
  const factory _SuperannuationStep(
      {required final String status,
      final String? fundName,
      final String? memberNumber,
      final String? usi,
      final DateTime? updatedAt}) = _$SuperannuationStepImpl;

  factory _SuperannuationStep.fromJson(Map<String, dynamic> json) =
      _$SuperannuationStepImpl.fromJson;

  @override
  String get status;
  @override
  String? get fundName;
  @override
  String? get memberNumber;
  @override
  String? get usi;
  @override
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$SuperannuationStepImplCopyWith<_$SuperannuationStepImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DocumentStep _$DocumentStepFromJson(Map<String, dynamic> json) {
  return _DocumentStep.fromJson(json);
}

/// @nodoc
mixin _$DocumentStep {
  String get status => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DocumentStepCopyWith<DocumentStep> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DocumentStepCopyWith<$Res> {
  factory $DocumentStepCopyWith(
          DocumentStep value, $Res Function(DocumentStep) then) =
      _$DocumentStepCopyWithImpl<$Res, DocumentStep>;
  @useResult
  $Res call({String status, int count, DateTime? updatedAt});
}

/// @nodoc
class _$DocumentStepCopyWithImpl<$Res, $Val extends DocumentStep>
    implements $DocumentStepCopyWith<$Res> {
  _$DocumentStepCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? count = null,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DocumentStepImplCopyWith<$Res>
    implements $DocumentStepCopyWith<$Res> {
  factory _$$DocumentStepImplCopyWith(
          _$DocumentStepImpl value, $Res Function(_$DocumentStepImpl) then) =
      __$$DocumentStepImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String status, int count, DateTime? updatedAt});
}

/// @nodoc
class __$$DocumentStepImplCopyWithImpl<$Res>
    extends _$DocumentStepCopyWithImpl<$Res, _$DocumentStepImpl>
    implements _$$DocumentStepImplCopyWith<$Res> {
  __$$DocumentStepImplCopyWithImpl(
      _$DocumentStepImpl _value, $Res Function(_$DocumentStepImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? count = null,
    Object? updatedAt = freezed,
  }) {
    return _then(_$DocumentStepImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DocumentStepImpl implements _DocumentStep {
  const _$DocumentStepImpl(
      {required this.status, this.count = 0, this.updatedAt});

  factory _$DocumentStepImpl.fromJson(Map<String, dynamic> json) =>
      _$$DocumentStepImplFromJson(json);

  @override
  final String status;
  @override
  @JsonKey()
  final int count;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'DocumentStep(status: $status, count: $count, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DocumentStepImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, status, count, updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DocumentStepImplCopyWith<_$DocumentStepImpl> get copyWith =>
      __$$DocumentStepImplCopyWithImpl<_$DocumentStepImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DocumentStepImplToJson(
      this,
    );
  }
}

abstract class _DocumentStep implements DocumentStep {
  const factory _DocumentStep(
      {required final String status,
      final int count,
      final DateTime? updatedAt}) = _$DocumentStepImpl;

  factory _DocumentStep.fromJson(Map<String, dynamic> json) =
      _$DocumentStepImpl.fromJson;

  @override
  String get status;
  @override
  int get count;
  @override
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$DocumentStepImplCopyWith<_$DocumentStepImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ProbationDetails _$ProbationDetailsFromJson(Map<String, dynamic> json) {
  return _ProbationDetails.fromJson(json);
}

/// @nodoc
mixin _$ProbationDetails {
  DateTime? get startDate => throw _privateConstructorUsedError;
  DateTime? get endDate => throw _privateConstructorUsedError;
  DateTime? get reviewDate => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProbationDetailsCopyWith<ProbationDetails> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProbationDetailsCopyWith<$Res> {
  factory $ProbationDetailsCopyWith(
          ProbationDetails value, $Res Function(ProbationDetails) then) =
      _$ProbationDetailsCopyWithImpl<$Res, ProbationDetails>;
  @useResult
  $Res call(
      {DateTime? startDate,
      DateTime? endDate,
      DateTime? reviewDate,
      String status});
}

/// @nodoc
class _$ProbationDetailsCopyWithImpl<$Res, $Val extends ProbationDetails>
    implements $ProbationDetailsCopyWith<$Res> {
  _$ProbationDetailsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? reviewDate = freezed,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      reviewDate: freezed == reviewDate
          ? _value.reviewDate
          : reviewDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProbationDetailsImplCopyWith<$Res>
    implements $ProbationDetailsCopyWith<$Res> {
  factory _$$ProbationDetailsImplCopyWith(_$ProbationDetailsImpl value,
          $Res Function(_$ProbationDetailsImpl) then) =
      __$$ProbationDetailsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime? startDate,
      DateTime? endDate,
      DateTime? reviewDate,
      String status});
}

/// @nodoc
class __$$ProbationDetailsImplCopyWithImpl<$Res>
    extends _$ProbationDetailsCopyWithImpl<$Res, _$ProbationDetailsImpl>
    implements _$$ProbationDetailsImplCopyWith<$Res> {
  __$$ProbationDetailsImplCopyWithImpl(_$ProbationDetailsImpl _value,
      $Res Function(_$ProbationDetailsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? reviewDate = freezed,
    Object? status = null,
  }) {
    return _then(_$ProbationDetailsImpl(
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      reviewDate: freezed == reviewDate
          ? _value.reviewDate
          : reviewDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProbationDetailsImpl implements _ProbationDetails {
  const _$ProbationDetailsImpl(
      {this.startDate, this.endDate, this.reviewDate, required this.status});

  factory _$ProbationDetailsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProbationDetailsImplFromJson(json);

  @override
  final DateTime? startDate;
  @override
  final DateTime? endDate;
  @override
  final DateTime? reviewDate;
  @override
  final String status;

  @override
  String toString() {
    return 'ProbationDetails(startDate: $startDate, endDate: $endDate, reviewDate: $reviewDate, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProbationDetailsImpl &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.reviewDate, reviewDate) ||
                other.reviewDate == reviewDate) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, startDate, endDate, reviewDate, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProbationDetailsImplCopyWith<_$ProbationDetailsImpl> get copyWith =>
      __$$ProbationDetailsImplCopyWithImpl<_$ProbationDetailsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProbationDetailsImplToJson(
      this,
    );
  }
}

abstract class _ProbationDetails implements ProbationDetails {
  const factory _ProbationDetails(
      {final DateTime? startDate,
      final DateTime? endDate,
      final DateTime? reviewDate,
      required final String status}) = _$ProbationDetailsImpl;

  factory _ProbationDetails.fromJson(Map<String, dynamic> json) =
      _$ProbationDetailsImpl.fromJson;

  @override
  DateTime? get startDate;
  @override
  DateTime? get endDate;
  @override
  DateTime? get reviewDate;
  @override
  String get status;
  @override
  @JsonKey(ignore: true)
  _$$ProbationDetailsImplCopyWith<_$ProbationDetailsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
