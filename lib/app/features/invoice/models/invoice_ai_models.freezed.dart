// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'invoice_ai_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

InvoiceAnomaly _$InvoiceAnomalyFromJson(Map<String, dynamic> json) {
  return _InvoiceAnomaly.fromJson(json);
}

/// @nodoc
mixin _$InvoiceAnomaly {
  String get anomalyType => throw _privateConstructorUsedError;
  String get severity => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get field => throw _privateConstructorUsedError;
  dynamic get expectedValue => throw _privateConstructorUsedError;
  dynamic get actualValue => throw _privateConstructorUsedError;
  String? get suggestion => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InvoiceAnomalyCopyWith<InvoiceAnomaly> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InvoiceAnomalyCopyWith<$Res> {
  factory $InvoiceAnomalyCopyWith(
          InvoiceAnomaly value, $Res Function(InvoiceAnomaly) then) =
      _$InvoiceAnomalyCopyWithImpl<$Res, InvoiceAnomaly>;
  @useResult
  $Res call(
      {String anomalyType,
      String severity,
      String description,
      String field,
      dynamic expectedValue,
      dynamic actualValue,
      String? suggestion});
}

/// @nodoc
class _$InvoiceAnomalyCopyWithImpl<$Res, $Val extends InvoiceAnomaly>
    implements $InvoiceAnomalyCopyWith<$Res> {
  _$InvoiceAnomalyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? anomalyType = null,
    Object? severity = null,
    Object? description = null,
    Object? field = null,
    Object? expectedValue = freezed,
    Object? actualValue = freezed,
    Object? suggestion = freezed,
  }) {
    return _then(_value.copyWith(
      anomalyType: null == anomalyType
          ? _value.anomalyType
          : anomalyType // ignore: cast_nullable_to_non_nullable
              as String,
      severity: null == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      field: null == field
          ? _value.field
          : field // ignore: cast_nullable_to_non_nullable
              as String,
      expectedValue: freezed == expectedValue
          ? _value.expectedValue
          : expectedValue // ignore: cast_nullable_to_non_nullable
              as dynamic,
      actualValue: freezed == actualValue
          ? _value.actualValue
          : actualValue // ignore: cast_nullable_to_non_nullable
              as dynamic,
      suggestion: freezed == suggestion
          ? _value.suggestion
          : suggestion // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InvoiceAnomalyImplCopyWith<$Res>
    implements $InvoiceAnomalyCopyWith<$Res> {
  factory _$$InvoiceAnomalyImplCopyWith(_$InvoiceAnomalyImpl value,
          $Res Function(_$InvoiceAnomalyImpl) then) =
      __$$InvoiceAnomalyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String anomalyType,
      String severity,
      String description,
      String field,
      dynamic expectedValue,
      dynamic actualValue,
      String? suggestion});
}

/// @nodoc
class __$$InvoiceAnomalyImplCopyWithImpl<$Res>
    extends _$InvoiceAnomalyCopyWithImpl<$Res, _$InvoiceAnomalyImpl>
    implements _$$InvoiceAnomalyImplCopyWith<$Res> {
  __$$InvoiceAnomalyImplCopyWithImpl(
      _$InvoiceAnomalyImpl _value, $Res Function(_$InvoiceAnomalyImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? anomalyType = null,
    Object? severity = null,
    Object? description = null,
    Object? field = null,
    Object? expectedValue = freezed,
    Object? actualValue = freezed,
    Object? suggestion = freezed,
  }) {
    return _then(_$InvoiceAnomalyImpl(
      anomalyType: null == anomalyType
          ? _value.anomalyType
          : anomalyType // ignore: cast_nullable_to_non_nullable
              as String,
      severity: null == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      field: null == field
          ? _value.field
          : field // ignore: cast_nullable_to_non_nullable
              as String,
      expectedValue: freezed == expectedValue
          ? _value.expectedValue
          : expectedValue // ignore: cast_nullable_to_non_nullable
              as dynamic,
      actualValue: freezed == actualValue
          ? _value.actualValue
          : actualValue // ignore: cast_nullable_to_non_nullable
              as dynamic,
      suggestion: freezed == suggestion
          ? _value.suggestion
          : suggestion // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InvoiceAnomalyImpl implements _InvoiceAnomaly {
  const _$InvoiceAnomalyImpl(
      {required this.anomalyType,
      required this.severity,
      required this.description,
      required this.field,
      this.expectedValue,
      this.actualValue,
      this.suggestion});

  factory _$InvoiceAnomalyImpl.fromJson(Map<String, dynamic> json) =>
      _$$InvoiceAnomalyImplFromJson(json);

  @override
  final String anomalyType;
  @override
  final String severity;
  @override
  final String description;
  @override
  final String field;
  @override
  final dynamic expectedValue;
  @override
  final dynamic actualValue;
  @override
  final String? suggestion;

  @override
  String toString() {
    return 'InvoiceAnomaly(anomalyType: $anomalyType, severity: $severity, description: $description, field: $field, expectedValue: $expectedValue, actualValue: $actualValue, suggestion: $suggestion)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InvoiceAnomalyImpl &&
            (identical(other.anomalyType, anomalyType) ||
                other.anomalyType == anomalyType) &&
            (identical(other.severity, severity) ||
                other.severity == severity) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.field, field) || other.field == field) &&
            const DeepCollectionEquality()
                .equals(other.expectedValue, expectedValue) &&
            const DeepCollectionEquality()
                .equals(other.actualValue, actualValue) &&
            (identical(other.suggestion, suggestion) ||
                other.suggestion == suggestion));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      anomalyType,
      severity,
      description,
      field,
      const DeepCollectionEquality().hash(expectedValue),
      const DeepCollectionEquality().hash(actualValue),
      suggestion);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InvoiceAnomalyImplCopyWith<_$InvoiceAnomalyImpl> get copyWith =>
      __$$InvoiceAnomalyImplCopyWithImpl<_$InvoiceAnomalyImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InvoiceAnomalyImplToJson(
      this,
    );
  }
}

abstract class _InvoiceAnomaly implements InvoiceAnomaly {
  const factory _InvoiceAnomaly(
      {required final String anomalyType,
      required final String severity,
      required final String description,
      required final String field,
      final dynamic expectedValue,
      final dynamic actualValue,
      final String? suggestion}) = _$InvoiceAnomalyImpl;

  factory _InvoiceAnomaly.fromJson(Map<String, dynamic> json) =
      _$InvoiceAnomalyImpl.fromJson;

  @override
  String get anomalyType;
  @override
  String get severity;
  @override
  String get description;
  @override
  String get field;
  @override
  dynamic get expectedValue;
  @override
  dynamic get actualValue;
  @override
  String? get suggestion;
  @override
  @JsonKey(ignore: true)
  _$$InvoiceAnomalyImplCopyWith<_$InvoiceAnomalyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

InvoiceValidation _$InvoiceValidationFromJson(Map<String, dynamic> json) {
  return _InvoiceValidation.fromJson(json);
}

/// @nodoc
mixin _$InvoiceValidation {
  bool get isValid => throw _privateConstructorUsedError;
  List<InvoiceAnomaly> get anomalies => throw _privateConstructorUsedError;
  List<String> get warnings => throw _privateConstructorUsedError;
  double get confidenceScore => throw _privateConstructorUsedError;
  String? get summary => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InvoiceValidationCopyWith<InvoiceValidation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InvoiceValidationCopyWith<$Res> {
  factory $InvoiceValidationCopyWith(
          InvoiceValidation value, $Res Function(InvoiceValidation) then) =
      _$InvoiceValidationCopyWithImpl<$Res, InvoiceValidation>;
  @useResult
  $Res call(
      {bool isValid,
      List<InvoiceAnomaly> anomalies,
      List<String> warnings,
      double confidenceScore,
      String? summary});
}

/// @nodoc
class _$InvoiceValidationCopyWithImpl<$Res, $Val extends InvoiceValidation>
    implements $InvoiceValidationCopyWith<$Res> {
  _$InvoiceValidationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isValid = null,
    Object? anomalies = null,
    Object? warnings = null,
    Object? confidenceScore = null,
    Object? summary = freezed,
  }) {
    return _then(_value.copyWith(
      isValid: null == isValid
          ? _value.isValid
          : isValid // ignore: cast_nullable_to_non_nullable
              as bool,
      anomalies: null == anomalies
          ? _value.anomalies
          : anomalies // ignore: cast_nullable_to_non_nullable
              as List<InvoiceAnomaly>,
      warnings: null == warnings
          ? _value.warnings
          : warnings // ignore: cast_nullable_to_non_nullable
              as List<String>,
      confidenceScore: null == confidenceScore
          ? _value.confidenceScore
          : confidenceScore // ignore: cast_nullable_to_non_nullable
              as double,
      summary: freezed == summary
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InvoiceValidationImplCopyWith<$Res>
    implements $InvoiceValidationCopyWith<$Res> {
  factory _$$InvoiceValidationImplCopyWith(_$InvoiceValidationImpl value,
          $Res Function(_$InvoiceValidationImpl) then) =
      __$$InvoiceValidationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isValid,
      List<InvoiceAnomaly> anomalies,
      List<String> warnings,
      double confidenceScore,
      String? summary});
}

/// @nodoc
class __$$InvoiceValidationImplCopyWithImpl<$Res>
    extends _$InvoiceValidationCopyWithImpl<$Res, _$InvoiceValidationImpl>
    implements _$$InvoiceValidationImplCopyWith<$Res> {
  __$$InvoiceValidationImplCopyWithImpl(_$InvoiceValidationImpl _value,
      $Res Function(_$InvoiceValidationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isValid = null,
    Object? anomalies = null,
    Object? warnings = null,
    Object? confidenceScore = null,
    Object? summary = freezed,
  }) {
    return _then(_$InvoiceValidationImpl(
      isValid: null == isValid
          ? _value.isValid
          : isValid // ignore: cast_nullable_to_non_nullable
              as bool,
      anomalies: null == anomalies
          ? _value._anomalies
          : anomalies // ignore: cast_nullable_to_non_nullable
              as List<InvoiceAnomaly>,
      warnings: null == warnings
          ? _value._warnings
          : warnings // ignore: cast_nullable_to_non_nullable
              as List<String>,
      confidenceScore: null == confidenceScore
          ? _value.confidenceScore
          : confidenceScore // ignore: cast_nullable_to_non_nullable
              as double,
      summary: freezed == summary
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InvoiceValidationImpl implements _InvoiceValidation {
  const _$InvoiceValidationImpl(
      {required this.isValid,
      required final List<InvoiceAnomaly> anomalies,
      required final List<String> warnings,
      required this.confidenceScore,
      this.summary})
      : _anomalies = anomalies,
        _warnings = warnings;

  factory _$InvoiceValidationImpl.fromJson(Map<String, dynamic> json) =>
      _$$InvoiceValidationImplFromJson(json);

  @override
  final bool isValid;
  final List<InvoiceAnomaly> _anomalies;
  @override
  List<InvoiceAnomaly> get anomalies {
    if (_anomalies is EqualUnmodifiableListView) return _anomalies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_anomalies);
  }

  final List<String> _warnings;
  @override
  List<String> get warnings {
    if (_warnings is EqualUnmodifiableListView) return _warnings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_warnings);
  }

  @override
  final double confidenceScore;
  @override
  final String? summary;

  @override
  String toString() {
    return 'InvoiceValidation(isValid: $isValid, anomalies: $anomalies, warnings: $warnings, confidenceScore: $confidenceScore, summary: $summary)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InvoiceValidationImpl &&
            (identical(other.isValid, isValid) || other.isValid == isValid) &&
            const DeepCollectionEquality()
                .equals(other._anomalies, _anomalies) &&
            const DeepCollectionEquality().equals(other._warnings, _warnings) &&
            (identical(other.confidenceScore, confidenceScore) ||
                other.confidenceScore == confidenceScore) &&
            (identical(other.summary, summary) || other.summary == summary));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      isValid,
      const DeepCollectionEquality().hash(_anomalies),
      const DeepCollectionEquality().hash(_warnings),
      confidenceScore,
      summary);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InvoiceValidationImplCopyWith<_$InvoiceValidationImpl> get copyWith =>
      __$$InvoiceValidationImplCopyWithImpl<_$InvoiceValidationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InvoiceValidationImplToJson(
      this,
    );
  }
}

abstract class _InvoiceValidation implements InvoiceValidation {
  const factory _InvoiceValidation(
      {required final bool isValid,
      required final List<InvoiceAnomaly> anomalies,
      required final List<String> warnings,
      required final double confidenceScore,
      final String? summary}) = _$InvoiceValidationImpl;

  factory _InvoiceValidation.fromJson(Map<String, dynamic> json) =
      _$InvoiceValidationImpl.fromJson;

  @override
  bool get isValid;
  @override
  List<InvoiceAnomaly> get anomalies;
  @override
  List<String> get warnings;
  @override
  double get confidenceScore;
  @override
  String? get summary;
  @override
  @JsonKey(ignore: true)
  _$$InvoiceValidationImplCopyWith<_$InvoiceValidationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PaymentPrediction _$PaymentPredictionFromJson(Map<String, dynamic> json) {
  return _PaymentPrediction.fromJson(json);
}

/// @nodoc
mixin _$PaymentPrediction {
  String get invoiceId => throw _privateConstructorUsedError;
  DateTime get predictedPaymentDate => throw _privateConstructorUsedError;
  double get probability => throw _privateConstructorUsedError;
  String get riskLevel => throw _privateConstructorUsedError;
  List<String> get factors => throw _privateConstructorUsedError;
  String? get recommendation => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PaymentPredictionCopyWith<PaymentPrediction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentPredictionCopyWith<$Res> {
  factory $PaymentPredictionCopyWith(
          PaymentPrediction value, $Res Function(PaymentPrediction) then) =
      _$PaymentPredictionCopyWithImpl<$Res, PaymentPrediction>;
  @useResult
  $Res call(
      {String invoiceId,
      DateTime predictedPaymentDate,
      double probability,
      String riskLevel,
      List<String> factors,
      String? recommendation});
}

/// @nodoc
class _$PaymentPredictionCopyWithImpl<$Res, $Val extends PaymentPrediction>
    implements $PaymentPredictionCopyWith<$Res> {
  _$PaymentPredictionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? invoiceId = null,
    Object? predictedPaymentDate = null,
    Object? probability = null,
    Object? riskLevel = null,
    Object? factors = null,
    Object? recommendation = freezed,
  }) {
    return _then(_value.copyWith(
      invoiceId: null == invoiceId
          ? _value.invoiceId
          : invoiceId // ignore: cast_nullable_to_non_nullable
              as String,
      predictedPaymentDate: null == predictedPaymentDate
          ? _value.predictedPaymentDate
          : predictedPaymentDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      probability: null == probability
          ? _value.probability
          : probability // ignore: cast_nullable_to_non_nullable
              as double,
      riskLevel: null == riskLevel
          ? _value.riskLevel
          : riskLevel // ignore: cast_nullable_to_non_nullable
              as String,
      factors: null == factors
          ? _value.factors
          : factors // ignore: cast_nullable_to_non_nullable
              as List<String>,
      recommendation: freezed == recommendation
          ? _value.recommendation
          : recommendation // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PaymentPredictionImplCopyWith<$Res>
    implements $PaymentPredictionCopyWith<$Res> {
  factory _$$PaymentPredictionImplCopyWith(_$PaymentPredictionImpl value,
          $Res Function(_$PaymentPredictionImpl) then) =
      __$$PaymentPredictionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String invoiceId,
      DateTime predictedPaymentDate,
      double probability,
      String riskLevel,
      List<String> factors,
      String? recommendation});
}

/// @nodoc
class __$$PaymentPredictionImplCopyWithImpl<$Res>
    extends _$PaymentPredictionCopyWithImpl<$Res, _$PaymentPredictionImpl>
    implements _$$PaymentPredictionImplCopyWith<$Res> {
  __$$PaymentPredictionImplCopyWithImpl(_$PaymentPredictionImpl _value,
      $Res Function(_$PaymentPredictionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? invoiceId = null,
    Object? predictedPaymentDate = null,
    Object? probability = null,
    Object? riskLevel = null,
    Object? factors = null,
    Object? recommendation = freezed,
  }) {
    return _then(_$PaymentPredictionImpl(
      invoiceId: null == invoiceId
          ? _value.invoiceId
          : invoiceId // ignore: cast_nullable_to_non_nullable
              as String,
      predictedPaymentDate: null == predictedPaymentDate
          ? _value.predictedPaymentDate
          : predictedPaymentDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      probability: null == probability
          ? _value.probability
          : probability // ignore: cast_nullable_to_non_nullable
              as double,
      riskLevel: null == riskLevel
          ? _value.riskLevel
          : riskLevel // ignore: cast_nullable_to_non_nullable
              as String,
      factors: null == factors
          ? _value._factors
          : factors // ignore: cast_nullable_to_non_nullable
              as List<String>,
      recommendation: freezed == recommendation
          ? _value.recommendation
          : recommendation // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PaymentPredictionImpl implements _PaymentPrediction {
  const _$PaymentPredictionImpl(
      {required this.invoiceId,
      required this.predictedPaymentDate,
      required this.probability,
      required this.riskLevel,
      required final List<String> factors,
      this.recommendation})
      : _factors = factors;

  factory _$PaymentPredictionImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaymentPredictionImplFromJson(json);

  @override
  final String invoiceId;
  @override
  final DateTime predictedPaymentDate;
  @override
  final double probability;
  @override
  final String riskLevel;
  final List<String> _factors;
  @override
  List<String> get factors {
    if (_factors is EqualUnmodifiableListView) return _factors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_factors);
  }

  @override
  final String? recommendation;

  @override
  String toString() {
    return 'PaymentPrediction(invoiceId: $invoiceId, predictedPaymentDate: $predictedPaymentDate, probability: $probability, riskLevel: $riskLevel, factors: $factors, recommendation: $recommendation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentPredictionImpl &&
            (identical(other.invoiceId, invoiceId) ||
                other.invoiceId == invoiceId) &&
            (identical(other.predictedPaymentDate, predictedPaymentDate) ||
                other.predictedPaymentDate == predictedPaymentDate) &&
            (identical(other.probability, probability) ||
                other.probability == probability) &&
            (identical(other.riskLevel, riskLevel) ||
                other.riskLevel == riskLevel) &&
            const DeepCollectionEquality().equals(other._factors, _factors) &&
            (identical(other.recommendation, recommendation) ||
                other.recommendation == recommendation));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      invoiceId,
      predictedPaymentDate,
      probability,
      riskLevel,
      const DeepCollectionEquality().hash(_factors),
      recommendation);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentPredictionImplCopyWith<_$PaymentPredictionImpl> get copyWith =>
      __$$PaymentPredictionImplCopyWithImpl<_$PaymentPredictionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PaymentPredictionImplToJson(
      this,
    );
  }
}

abstract class _PaymentPrediction implements PaymentPrediction {
  const factory _PaymentPrediction(
      {required final String invoiceId,
      required final DateTime predictedPaymentDate,
      required final double probability,
      required final String riskLevel,
      required final List<String> factors,
      final String? recommendation}) = _$PaymentPredictionImpl;

  factory _PaymentPrediction.fromJson(Map<String, dynamic> json) =
      _$PaymentPredictionImpl.fromJson;

  @override
  String get invoiceId;
  @override
  DateTime get predictedPaymentDate;
  @override
  double get probability;
  @override
  String get riskLevel;
  @override
  List<String> get factors;
  @override
  String? get recommendation;
  @override
  @JsonKey(ignore: true)
  _$$PaymentPredictionImplCopyWith<_$PaymentPredictionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AutoGenerateRequest _$AutoGenerateRequestFromJson(Map<String, dynamic> json) {
  return _AutoGenerateRequest.fromJson(json);
}

/// @nodoc
mixin _$AutoGenerateRequest {
  String get organizationId => throw _privateConstructorUsedError;
  DateTime get startDate => throw _privateConstructorUsedError;
  DateTime get endDate => throw _privateConstructorUsedError;
  bool get validateBeforeGeneration => throw _privateConstructorUsedError;
  bool get groupByClient => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AutoGenerateRequestCopyWith<AutoGenerateRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AutoGenerateRequestCopyWith<$Res> {
  factory $AutoGenerateRequestCopyWith(
          AutoGenerateRequest value, $Res Function(AutoGenerateRequest) then) =
      _$AutoGenerateRequestCopyWithImpl<$Res, AutoGenerateRequest>;
  @useResult
  $Res call(
      {String organizationId,
      DateTime startDate,
      DateTime endDate,
      bool validateBeforeGeneration,
      bool groupByClient});
}

/// @nodoc
class _$AutoGenerateRequestCopyWithImpl<$Res, $Val extends AutoGenerateRequest>
    implements $AutoGenerateRequestCopyWith<$Res> {
  _$AutoGenerateRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? organizationId = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? validateBeforeGeneration = null,
    Object? groupByClient = null,
  }) {
    return _then(_value.copyWith(
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      validateBeforeGeneration: null == validateBeforeGeneration
          ? _value.validateBeforeGeneration
          : validateBeforeGeneration // ignore: cast_nullable_to_non_nullable
              as bool,
      groupByClient: null == groupByClient
          ? _value.groupByClient
          : groupByClient // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AutoGenerateRequestImplCopyWith<$Res>
    implements $AutoGenerateRequestCopyWith<$Res> {
  factory _$$AutoGenerateRequestImplCopyWith(_$AutoGenerateRequestImpl value,
          $Res Function(_$AutoGenerateRequestImpl) then) =
      __$$AutoGenerateRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String organizationId,
      DateTime startDate,
      DateTime endDate,
      bool validateBeforeGeneration,
      bool groupByClient});
}

/// @nodoc
class __$$AutoGenerateRequestImplCopyWithImpl<$Res>
    extends _$AutoGenerateRequestCopyWithImpl<$Res, _$AutoGenerateRequestImpl>
    implements _$$AutoGenerateRequestImplCopyWith<$Res> {
  __$$AutoGenerateRequestImplCopyWithImpl(_$AutoGenerateRequestImpl _value,
      $Res Function(_$AutoGenerateRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? organizationId = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? validateBeforeGeneration = null,
    Object? groupByClient = null,
  }) {
    return _then(_$AutoGenerateRequestImpl(
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      validateBeforeGeneration: null == validateBeforeGeneration
          ? _value.validateBeforeGeneration
          : validateBeforeGeneration // ignore: cast_nullable_to_non_nullable
              as bool,
      groupByClient: null == groupByClient
          ? _value.groupByClient
          : groupByClient // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AutoGenerateRequestImpl implements _AutoGenerateRequest {
  const _$AutoGenerateRequestImpl(
      {required this.organizationId,
      required this.startDate,
      required this.endDate,
      this.validateBeforeGeneration = true,
      this.groupByClient = false});

  factory _$AutoGenerateRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$AutoGenerateRequestImplFromJson(json);

  @override
  final String organizationId;
  @override
  final DateTime startDate;
  @override
  final DateTime endDate;
  @override
  @JsonKey()
  final bool validateBeforeGeneration;
  @override
  @JsonKey()
  final bool groupByClient;

  @override
  String toString() {
    return 'AutoGenerateRequest(organizationId: $organizationId, startDate: $startDate, endDate: $endDate, validateBeforeGeneration: $validateBeforeGeneration, groupByClient: $groupByClient)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AutoGenerateRequestImpl &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(
                    other.validateBeforeGeneration, validateBeforeGeneration) ||
                other.validateBeforeGeneration == validateBeforeGeneration) &&
            (identical(other.groupByClient, groupByClient) ||
                other.groupByClient == groupByClient));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, organizationId, startDate,
      endDate, validateBeforeGeneration, groupByClient);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AutoGenerateRequestImplCopyWith<_$AutoGenerateRequestImpl> get copyWith =>
      __$$AutoGenerateRequestImplCopyWithImpl<_$AutoGenerateRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AutoGenerateRequestImplToJson(
      this,
    );
  }
}

abstract class _AutoGenerateRequest implements AutoGenerateRequest {
  const factory _AutoGenerateRequest(
      {required final String organizationId,
      required final DateTime startDate,
      required final DateTime endDate,
      final bool validateBeforeGeneration,
      final bool groupByClient}) = _$AutoGenerateRequestImpl;

  factory _AutoGenerateRequest.fromJson(Map<String, dynamic> json) =
      _$AutoGenerateRequestImpl.fromJson;

  @override
  String get organizationId;
  @override
  DateTime get startDate;
  @override
  DateTime get endDate;
  @override
  bool get validateBeforeGeneration;
  @override
  bool get groupByClient;
  @override
  @JsonKey(ignore: true)
  _$$AutoGenerateRequestImplCopyWith<_$AutoGenerateRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AutoGenerateResult _$AutoGenerateResultFromJson(Map<String, dynamic> json) {
  return _AutoGenerateResult.fromJson(json);
}

/// @nodoc
mixin _$AutoGenerateResult {
  int get totalInvoices => throw _privateConstructorUsedError;
  int get successfulInvoices => throw _privateConstructorUsedError;
  int get failedInvoices => throw _privateConstructorUsedError;
  List<String> get invoiceIds => throw _privateConstructorUsedError;
  List<String> get errors => throw _privateConstructorUsedError;
  String? get summary => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AutoGenerateResultCopyWith<AutoGenerateResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AutoGenerateResultCopyWith<$Res> {
  factory $AutoGenerateResultCopyWith(
          AutoGenerateResult value, $Res Function(AutoGenerateResult) then) =
      _$AutoGenerateResultCopyWithImpl<$Res, AutoGenerateResult>;
  @useResult
  $Res call(
      {int totalInvoices,
      int successfulInvoices,
      int failedInvoices,
      List<String> invoiceIds,
      List<String> errors,
      String? summary});
}

/// @nodoc
class _$AutoGenerateResultCopyWithImpl<$Res, $Val extends AutoGenerateResult>
    implements $AutoGenerateResultCopyWith<$Res> {
  _$AutoGenerateResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalInvoices = null,
    Object? successfulInvoices = null,
    Object? failedInvoices = null,
    Object? invoiceIds = null,
    Object? errors = null,
    Object? summary = freezed,
  }) {
    return _then(_value.copyWith(
      totalInvoices: null == totalInvoices
          ? _value.totalInvoices
          : totalInvoices // ignore: cast_nullable_to_non_nullable
              as int,
      successfulInvoices: null == successfulInvoices
          ? _value.successfulInvoices
          : successfulInvoices // ignore: cast_nullable_to_non_nullable
              as int,
      failedInvoices: null == failedInvoices
          ? _value.failedInvoices
          : failedInvoices // ignore: cast_nullable_to_non_nullable
              as int,
      invoiceIds: null == invoiceIds
          ? _value.invoiceIds
          : invoiceIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      errors: null == errors
          ? _value.errors
          : errors // ignore: cast_nullable_to_non_nullable
              as List<String>,
      summary: freezed == summary
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AutoGenerateResultImplCopyWith<$Res>
    implements $AutoGenerateResultCopyWith<$Res> {
  factory _$$AutoGenerateResultImplCopyWith(_$AutoGenerateResultImpl value,
          $Res Function(_$AutoGenerateResultImpl) then) =
      __$$AutoGenerateResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int totalInvoices,
      int successfulInvoices,
      int failedInvoices,
      List<String> invoiceIds,
      List<String> errors,
      String? summary});
}

/// @nodoc
class __$$AutoGenerateResultImplCopyWithImpl<$Res>
    extends _$AutoGenerateResultCopyWithImpl<$Res, _$AutoGenerateResultImpl>
    implements _$$AutoGenerateResultImplCopyWith<$Res> {
  __$$AutoGenerateResultImplCopyWithImpl(_$AutoGenerateResultImpl _value,
      $Res Function(_$AutoGenerateResultImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalInvoices = null,
    Object? successfulInvoices = null,
    Object? failedInvoices = null,
    Object? invoiceIds = null,
    Object? errors = null,
    Object? summary = freezed,
  }) {
    return _then(_$AutoGenerateResultImpl(
      totalInvoices: null == totalInvoices
          ? _value.totalInvoices
          : totalInvoices // ignore: cast_nullable_to_non_nullable
              as int,
      successfulInvoices: null == successfulInvoices
          ? _value.successfulInvoices
          : successfulInvoices // ignore: cast_nullable_to_non_nullable
              as int,
      failedInvoices: null == failedInvoices
          ? _value.failedInvoices
          : failedInvoices // ignore: cast_nullable_to_non_nullable
              as int,
      invoiceIds: null == invoiceIds
          ? _value._invoiceIds
          : invoiceIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      errors: null == errors
          ? _value._errors
          : errors // ignore: cast_nullable_to_non_nullable
              as List<String>,
      summary: freezed == summary
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AutoGenerateResultImpl implements _AutoGenerateResult {
  const _$AutoGenerateResultImpl(
      {required this.totalInvoices,
      required this.successfulInvoices,
      required this.failedInvoices,
      required final List<String> invoiceIds,
      required final List<String> errors,
      this.summary})
      : _invoiceIds = invoiceIds,
        _errors = errors;

  factory _$AutoGenerateResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$AutoGenerateResultImplFromJson(json);

  @override
  final int totalInvoices;
  @override
  final int successfulInvoices;
  @override
  final int failedInvoices;
  final List<String> _invoiceIds;
  @override
  List<String> get invoiceIds {
    if (_invoiceIds is EqualUnmodifiableListView) return _invoiceIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_invoiceIds);
  }

  final List<String> _errors;
  @override
  List<String> get errors {
    if (_errors is EqualUnmodifiableListView) return _errors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_errors);
  }

  @override
  final String? summary;

  @override
  String toString() {
    return 'AutoGenerateResult(totalInvoices: $totalInvoices, successfulInvoices: $successfulInvoices, failedInvoices: $failedInvoices, invoiceIds: $invoiceIds, errors: $errors, summary: $summary)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AutoGenerateResultImpl &&
            (identical(other.totalInvoices, totalInvoices) ||
                other.totalInvoices == totalInvoices) &&
            (identical(other.successfulInvoices, successfulInvoices) ||
                other.successfulInvoices == successfulInvoices) &&
            (identical(other.failedInvoices, failedInvoices) ||
                other.failedInvoices == failedInvoices) &&
            const DeepCollectionEquality()
                .equals(other._invoiceIds, _invoiceIds) &&
            const DeepCollectionEquality().equals(other._errors, _errors) &&
            (identical(other.summary, summary) || other.summary == summary));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      totalInvoices,
      successfulInvoices,
      failedInvoices,
      const DeepCollectionEquality().hash(_invoiceIds),
      const DeepCollectionEquality().hash(_errors),
      summary);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AutoGenerateResultImplCopyWith<_$AutoGenerateResultImpl> get copyWith =>
      __$$AutoGenerateResultImplCopyWithImpl<_$AutoGenerateResultImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AutoGenerateResultImplToJson(
      this,
    );
  }
}

abstract class _AutoGenerateResult implements AutoGenerateResult {
  const factory _AutoGenerateResult(
      {required final int totalInvoices,
      required final int successfulInvoices,
      required final int failedInvoices,
      required final List<String> invoiceIds,
      required final List<String> errors,
      final String? summary}) = _$AutoGenerateResultImpl;

  factory _AutoGenerateResult.fromJson(Map<String, dynamic> json) =
      _$AutoGenerateResultImpl.fromJson;

  @override
  int get totalInvoices;
  @override
  int get successfulInvoices;
  @override
  int get failedInvoices;
  @override
  List<String> get invoiceIds;
  @override
  List<String> get errors;
  @override
  String? get summary;
  @override
  @JsonKey(ignore: true)
  _$$AutoGenerateResultImplCopyWith<_$AutoGenerateResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SmartReminder _$SmartReminderFromJson(Map<String, dynamic> json) {
  return _SmartReminder.fromJson(json);
}

/// @nodoc
mixin _$SmartReminder {
  String get invoiceId => throw _privateConstructorUsedError;
  DateTime get suggestedSendTime => throw _privateConstructorUsedError;
  String get channel => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  double get successProbability => throw _privateConstructorUsedError;
  String? get reason => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SmartReminderCopyWith<SmartReminder> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SmartReminderCopyWith<$Res> {
  factory $SmartReminderCopyWith(
          SmartReminder value, $Res Function(SmartReminder) then) =
      _$SmartReminderCopyWithImpl<$Res, SmartReminder>;
  @useResult
  $Res call(
      {String invoiceId,
      DateTime suggestedSendTime,
      String channel,
      String message,
      double successProbability,
      String? reason});
}

/// @nodoc
class _$SmartReminderCopyWithImpl<$Res, $Val extends SmartReminder>
    implements $SmartReminderCopyWith<$Res> {
  _$SmartReminderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? invoiceId = null,
    Object? suggestedSendTime = null,
    Object? channel = null,
    Object? message = null,
    Object? successProbability = null,
    Object? reason = freezed,
  }) {
    return _then(_value.copyWith(
      invoiceId: null == invoiceId
          ? _value.invoiceId
          : invoiceId // ignore: cast_nullable_to_non_nullable
              as String,
      suggestedSendTime: null == suggestedSendTime
          ? _value.suggestedSendTime
          : suggestedSendTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      channel: null == channel
          ? _value.channel
          : channel // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      successProbability: null == successProbability
          ? _value.successProbability
          : successProbability // ignore: cast_nullable_to_non_nullable
              as double,
      reason: freezed == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SmartReminderImplCopyWith<$Res>
    implements $SmartReminderCopyWith<$Res> {
  factory _$$SmartReminderImplCopyWith(
          _$SmartReminderImpl value, $Res Function(_$SmartReminderImpl) then) =
      __$$SmartReminderImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String invoiceId,
      DateTime suggestedSendTime,
      String channel,
      String message,
      double successProbability,
      String? reason});
}

/// @nodoc
class __$$SmartReminderImplCopyWithImpl<$Res>
    extends _$SmartReminderCopyWithImpl<$Res, _$SmartReminderImpl>
    implements _$$SmartReminderImplCopyWith<$Res> {
  __$$SmartReminderImplCopyWithImpl(
      _$SmartReminderImpl _value, $Res Function(_$SmartReminderImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? invoiceId = null,
    Object? suggestedSendTime = null,
    Object? channel = null,
    Object? message = null,
    Object? successProbability = null,
    Object? reason = freezed,
  }) {
    return _then(_$SmartReminderImpl(
      invoiceId: null == invoiceId
          ? _value.invoiceId
          : invoiceId // ignore: cast_nullable_to_non_nullable
              as String,
      suggestedSendTime: null == suggestedSendTime
          ? _value.suggestedSendTime
          : suggestedSendTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      channel: null == channel
          ? _value.channel
          : channel // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      successProbability: null == successProbability
          ? _value.successProbability
          : successProbability // ignore: cast_nullable_to_non_nullable
              as double,
      reason: freezed == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SmartReminderImpl implements _SmartReminder {
  const _$SmartReminderImpl(
      {required this.invoiceId,
      required this.suggestedSendTime,
      required this.channel,
      required this.message,
      required this.successProbability,
      this.reason});

  factory _$SmartReminderImpl.fromJson(Map<String, dynamic> json) =>
      _$$SmartReminderImplFromJson(json);

  @override
  final String invoiceId;
  @override
  final DateTime suggestedSendTime;
  @override
  final String channel;
  @override
  final String message;
  @override
  final double successProbability;
  @override
  final String? reason;

  @override
  String toString() {
    return 'SmartReminder(invoiceId: $invoiceId, suggestedSendTime: $suggestedSendTime, channel: $channel, message: $message, successProbability: $successProbability, reason: $reason)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SmartReminderImpl &&
            (identical(other.invoiceId, invoiceId) ||
                other.invoiceId == invoiceId) &&
            (identical(other.suggestedSendTime, suggestedSendTime) ||
                other.suggestedSendTime == suggestedSendTime) &&
            (identical(other.channel, channel) || other.channel == channel) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.successProbability, successProbability) ||
                other.successProbability == successProbability) &&
            (identical(other.reason, reason) || other.reason == reason));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, invoiceId, suggestedSendTime,
      channel, message, successProbability, reason);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SmartReminderImplCopyWith<_$SmartReminderImpl> get copyWith =>
      __$$SmartReminderImplCopyWithImpl<_$SmartReminderImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SmartReminderImplToJson(
      this,
    );
  }
}

abstract class _SmartReminder implements SmartReminder {
  const factory _SmartReminder(
      {required final String invoiceId,
      required final DateTime suggestedSendTime,
      required final String channel,
      required final String message,
      required final double successProbability,
      final String? reason}) = _$SmartReminderImpl;

  factory _SmartReminder.fromJson(Map<String, dynamic> json) =
      _$SmartReminderImpl.fromJson;

  @override
  String get invoiceId;
  @override
  DateTime get suggestedSendTime;
  @override
  String get channel;
  @override
  String get message;
  @override
  double get successProbability;
  @override
  String? get reason;
  @override
  @JsonKey(ignore: true)
  _$$SmartReminderImplCopyWith<_$SmartReminderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
