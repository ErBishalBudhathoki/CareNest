// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'workforce_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DemandForecast _$DemandForecastFromJson(Map<String, dynamic> json) {
  return _DemandForecast.fromJson(json);
}

/// @nodoc
mixin _$DemandForecast {
  DateTime get date => throw _privateConstructorUsedError;
  int get predicted => throw _privateConstructorUsedError;
  int get lower => throw _privateConstructorUsedError;
  int get upper => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DemandForecastCopyWith<DemandForecast> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DemandForecastCopyWith<$Res> {
  factory $DemandForecastCopyWith(
          DemandForecast value, $Res Function(DemandForecast) then) =
      _$DemandForecastCopyWithImpl<$Res, DemandForecast>;
  @useResult
  $Res call({DateTime date, int predicted, int lower, int upper});
}

/// @nodoc
class _$DemandForecastCopyWithImpl<$Res, $Val extends DemandForecast>
    implements $DemandForecastCopyWith<$Res> {
  _$DemandForecastCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? predicted = null,
    Object? lower = null,
    Object? upper = null,
  }) {
    return _then(_value.copyWith(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      predicted: null == predicted
          ? _value.predicted
          : predicted // ignore: cast_nullable_to_non_nullable
              as int,
      lower: null == lower
          ? _value.lower
          : lower // ignore: cast_nullable_to_non_nullable
              as int,
      upper: null == upper
          ? _value.upper
          : upper // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DemandForecastImplCopyWith<$Res>
    implements $DemandForecastCopyWith<$Res> {
  factory _$$DemandForecastImplCopyWith(_$DemandForecastImpl value,
          $Res Function(_$DemandForecastImpl) then) =
      __$$DemandForecastImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime date, int predicted, int lower, int upper});
}

/// @nodoc
class __$$DemandForecastImplCopyWithImpl<$Res>
    extends _$DemandForecastCopyWithImpl<$Res, _$DemandForecastImpl>
    implements _$$DemandForecastImplCopyWith<$Res> {
  __$$DemandForecastImplCopyWithImpl(
      _$DemandForecastImpl _value, $Res Function(_$DemandForecastImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? predicted = null,
    Object? lower = null,
    Object? upper = null,
  }) {
    return _then(_$DemandForecastImpl(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      predicted: null == predicted
          ? _value.predicted
          : predicted // ignore: cast_nullable_to_non_nullable
              as int,
      lower: null == lower
          ? _value.lower
          : lower // ignore: cast_nullable_to_non_nullable
              as int,
      upper: null == upper
          ? _value.upper
          : upper // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DemandForecastImpl implements _DemandForecast {
  const _$DemandForecastImpl(
      {required this.date,
      required this.predicted,
      required this.lower,
      required this.upper});

  factory _$DemandForecastImpl.fromJson(Map<String, dynamic> json) =>
      _$$DemandForecastImplFromJson(json);

  @override
  final DateTime date;
  @override
  final int predicted;
  @override
  final int lower;
  @override
  final int upper;

  @override
  String toString() {
    return 'DemandForecast(date: $date, predicted: $predicted, lower: $lower, upper: $upper)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DemandForecastImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.predicted, predicted) ||
                other.predicted == predicted) &&
            (identical(other.lower, lower) || other.lower == lower) &&
            (identical(other.upper, upper) || other.upper == upper));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, date, predicted, lower, upper);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DemandForecastImplCopyWith<_$DemandForecastImpl> get copyWith =>
      __$$DemandForecastImplCopyWithImpl<_$DemandForecastImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DemandForecastImplToJson(
      this,
    );
  }
}

abstract class _DemandForecast implements DemandForecast {
  const factory _DemandForecast(
      {required final DateTime date,
      required final int predicted,
      required final int lower,
      required final int upper}) = _$DemandForecastImpl;

  factory _DemandForecast.fromJson(Map<String, dynamic> json) =
      _$DemandForecastImpl.fromJson;

  @override
  DateTime get date;
  @override
  int get predicted;
  @override
  int get lower;
  @override
  int get upper;
  @override
  @JsonKey(ignore: true)
  _$$DemandForecastImplCopyWith<_$DemandForecastImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SeasonalPattern _$SeasonalPatternFromJson(Map<String, dynamic> json) {
  return _SeasonalPattern.fromJson(json);
}

/// @nodoc
mixin _$SeasonalPattern {
  int get day => throw _privateConstructorUsedError;
  double get average => throw _privateConstructorUsedError;
  double get variance => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SeasonalPatternCopyWith<SeasonalPattern> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SeasonalPatternCopyWith<$Res> {
  factory $SeasonalPatternCopyWith(
          SeasonalPattern value, $Res Function(SeasonalPattern) then) =
      _$SeasonalPatternCopyWithImpl<$Res, SeasonalPattern>;
  @useResult
  $Res call({int day, double average, double variance});
}

/// @nodoc
class _$SeasonalPatternCopyWithImpl<$Res, $Val extends SeasonalPattern>
    implements $SeasonalPatternCopyWith<$Res> {
  _$SeasonalPatternCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? day = null,
    Object? average = null,
    Object? variance = null,
  }) {
    return _then(_value.copyWith(
      day: null == day
          ? _value.day
          : day // ignore: cast_nullable_to_non_nullable
              as int,
      average: null == average
          ? _value.average
          : average // ignore: cast_nullable_to_non_nullable
              as double,
      variance: null == variance
          ? _value.variance
          : variance // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SeasonalPatternImplCopyWith<$Res>
    implements $SeasonalPatternCopyWith<$Res> {
  factory _$$SeasonalPatternImplCopyWith(_$SeasonalPatternImpl value,
          $Res Function(_$SeasonalPatternImpl) then) =
      __$$SeasonalPatternImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int day, double average, double variance});
}

/// @nodoc
class __$$SeasonalPatternImplCopyWithImpl<$Res>
    extends _$SeasonalPatternCopyWithImpl<$Res, _$SeasonalPatternImpl>
    implements _$$SeasonalPatternImplCopyWith<$Res> {
  __$$SeasonalPatternImplCopyWithImpl(
      _$SeasonalPatternImpl _value, $Res Function(_$SeasonalPatternImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? day = null,
    Object? average = null,
    Object? variance = null,
  }) {
    return _then(_$SeasonalPatternImpl(
      day: null == day
          ? _value.day
          : day // ignore: cast_nullable_to_non_nullable
              as int,
      average: null == average
          ? _value.average
          : average // ignore: cast_nullable_to_non_nullable
              as double,
      variance: null == variance
          ? _value.variance
          : variance // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SeasonalPatternImpl implements _SeasonalPattern {
  const _$SeasonalPatternImpl(
      {required this.day, required this.average, required this.variance});

  factory _$SeasonalPatternImpl.fromJson(Map<String, dynamic> json) =>
      _$$SeasonalPatternImplFromJson(json);

  @override
  final int day;
  @override
  final double average;
  @override
  final double variance;

  @override
  String toString() {
    return 'SeasonalPattern(day: $day, average: $average, variance: $variance)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SeasonalPatternImpl &&
            (identical(other.day, day) || other.day == day) &&
            (identical(other.average, average) || other.average == average) &&
            (identical(other.variance, variance) ||
                other.variance == variance));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, day, average, variance);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SeasonalPatternImplCopyWith<_$SeasonalPatternImpl> get copyWith =>
      __$$SeasonalPatternImplCopyWithImpl<_$SeasonalPatternImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SeasonalPatternImplToJson(
      this,
    );
  }
}

abstract class _SeasonalPattern implements SeasonalPattern {
  const factory _SeasonalPattern(
      {required final int day,
      required final double average,
      required final double variance}) = _$SeasonalPatternImpl;

  factory _SeasonalPattern.fromJson(Map<String, dynamic> json) =
      _$SeasonalPatternImpl.fromJson;

  @override
  int get day;
  @override
  double get average;
  @override
  double get variance;
  @override
  @JsonKey(ignore: true)
  _$$SeasonalPatternImplCopyWith<_$SeasonalPatternImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ForecastConfidence _$ForecastConfidenceFromJson(Map<String, dynamic> json) {
  return _ForecastConfidence.fromJson(json);
}

/// @nodoc
mixin _$ForecastConfidence {
  double get mae => throw _privateConstructorUsedError;
  double get rmse => throw _privateConstructorUsedError;
  double get accuracy => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ForecastConfidenceCopyWith<ForecastConfidence> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ForecastConfidenceCopyWith<$Res> {
  factory $ForecastConfidenceCopyWith(
          ForecastConfidence value, $Res Function(ForecastConfidence) then) =
      _$ForecastConfidenceCopyWithImpl<$Res, ForecastConfidence>;
  @useResult
  $Res call({double mae, double rmse, double accuracy});
}

/// @nodoc
class _$ForecastConfidenceCopyWithImpl<$Res, $Val extends ForecastConfidence>
    implements $ForecastConfidenceCopyWith<$Res> {
  _$ForecastConfidenceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mae = null,
    Object? rmse = null,
    Object? accuracy = null,
  }) {
    return _then(_value.copyWith(
      mae: null == mae
          ? _value.mae
          : mae // ignore: cast_nullable_to_non_nullable
              as double,
      rmse: null == rmse
          ? _value.rmse
          : rmse // ignore: cast_nullable_to_non_nullable
              as double,
      accuracy: null == accuracy
          ? _value.accuracy
          : accuracy // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ForecastConfidenceImplCopyWith<$Res>
    implements $ForecastConfidenceCopyWith<$Res> {
  factory _$$ForecastConfidenceImplCopyWith(_$ForecastConfidenceImpl value,
          $Res Function(_$ForecastConfidenceImpl) then) =
      __$$ForecastConfidenceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double mae, double rmse, double accuracy});
}

/// @nodoc
class __$$ForecastConfidenceImplCopyWithImpl<$Res>
    extends _$ForecastConfidenceCopyWithImpl<$Res, _$ForecastConfidenceImpl>
    implements _$$ForecastConfidenceImplCopyWith<$Res> {
  __$$ForecastConfidenceImplCopyWithImpl(_$ForecastConfidenceImpl _value,
      $Res Function(_$ForecastConfidenceImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mae = null,
    Object? rmse = null,
    Object? accuracy = null,
  }) {
    return _then(_$ForecastConfidenceImpl(
      mae: null == mae
          ? _value.mae
          : mae // ignore: cast_nullable_to_non_nullable
              as double,
      rmse: null == rmse
          ? _value.rmse
          : rmse // ignore: cast_nullable_to_non_nullable
              as double,
      accuracy: null == accuracy
          ? _value.accuracy
          : accuracy // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ForecastConfidenceImpl implements _ForecastConfidence {
  const _$ForecastConfidenceImpl(
      {required this.mae, required this.rmse, required this.accuracy});

  factory _$ForecastConfidenceImpl.fromJson(Map<String, dynamic> json) =>
      _$$ForecastConfidenceImplFromJson(json);

  @override
  final double mae;
  @override
  final double rmse;
  @override
  final double accuracy;

  @override
  String toString() {
    return 'ForecastConfidence(mae: $mae, rmse: $rmse, accuracy: $accuracy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ForecastConfidenceImpl &&
            (identical(other.mae, mae) || other.mae == mae) &&
            (identical(other.rmse, rmse) || other.rmse == rmse) &&
            (identical(other.accuracy, accuracy) ||
                other.accuracy == accuracy));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, mae, rmse, accuracy);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ForecastConfidenceImplCopyWith<_$ForecastConfidenceImpl> get copyWith =>
      __$$ForecastConfidenceImplCopyWithImpl<_$ForecastConfidenceImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ForecastConfidenceImplToJson(
      this,
    );
  }
}

abstract class _ForecastConfidence implements ForecastConfidence {
  const factory _ForecastConfidence(
      {required final double mae,
      required final double rmse,
      required final double accuracy}) = _$ForecastConfidenceImpl;

  factory _ForecastConfidence.fromJson(Map<String, dynamic> json) =
      _$ForecastConfidenceImpl.fromJson;

  @override
  double get mae;
  @override
  double get rmse;
  @override
  double get accuracy;
  @override
  @JsonKey(ignore: true)
  _$$ForecastConfidenceImplCopyWith<_$ForecastConfidenceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WorkforcePlan _$WorkforcePlanFromJson(Map<String, dynamic> json) {
  return _WorkforcePlan.fromJson(json);
}

/// @nodoc
mixin _$WorkforcePlan {
  int get currentCapacity => throw _privateConstructorUsedError;
  int get requiredCapacity => throw _privateConstructorUsedError;
  int get surplus => throw _privateConstructorUsedError;
  double get utilizationRate => throw _privateConstructorUsedError;
  String get recommendation => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WorkforcePlanCopyWith<WorkforcePlan> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkforcePlanCopyWith<$Res> {
  factory $WorkforcePlanCopyWith(
          WorkforcePlan value, $Res Function(WorkforcePlan) then) =
      _$WorkforcePlanCopyWithImpl<$Res, WorkforcePlan>;
  @useResult
  $Res call(
      {int currentCapacity,
      int requiredCapacity,
      int surplus,
      double utilizationRate,
      String recommendation});
}

/// @nodoc
class _$WorkforcePlanCopyWithImpl<$Res, $Val extends WorkforcePlan>
    implements $WorkforcePlanCopyWith<$Res> {
  _$WorkforcePlanCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentCapacity = null,
    Object? requiredCapacity = null,
    Object? surplus = null,
    Object? utilizationRate = null,
    Object? recommendation = null,
  }) {
    return _then(_value.copyWith(
      currentCapacity: null == currentCapacity
          ? _value.currentCapacity
          : currentCapacity // ignore: cast_nullable_to_non_nullable
              as int,
      requiredCapacity: null == requiredCapacity
          ? _value.requiredCapacity
          : requiredCapacity // ignore: cast_nullable_to_non_nullable
              as int,
      surplus: null == surplus
          ? _value.surplus
          : surplus // ignore: cast_nullable_to_non_nullable
              as int,
      utilizationRate: null == utilizationRate
          ? _value.utilizationRate
          : utilizationRate // ignore: cast_nullable_to_non_nullable
              as double,
      recommendation: null == recommendation
          ? _value.recommendation
          : recommendation // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WorkforcePlanImplCopyWith<$Res>
    implements $WorkforcePlanCopyWith<$Res> {
  factory _$$WorkforcePlanImplCopyWith(
          _$WorkforcePlanImpl value, $Res Function(_$WorkforcePlanImpl) then) =
      __$$WorkforcePlanImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int currentCapacity,
      int requiredCapacity,
      int surplus,
      double utilizationRate,
      String recommendation});
}

/// @nodoc
class __$$WorkforcePlanImplCopyWithImpl<$Res>
    extends _$WorkforcePlanCopyWithImpl<$Res, _$WorkforcePlanImpl>
    implements _$$WorkforcePlanImplCopyWith<$Res> {
  __$$WorkforcePlanImplCopyWithImpl(
      _$WorkforcePlanImpl _value, $Res Function(_$WorkforcePlanImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentCapacity = null,
    Object? requiredCapacity = null,
    Object? surplus = null,
    Object? utilizationRate = null,
    Object? recommendation = null,
  }) {
    return _then(_$WorkforcePlanImpl(
      currentCapacity: null == currentCapacity
          ? _value.currentCapacity
          : currentCapacity // ignore: cast_nullable_to_non_nullable
              as int,
      requiredCapacity: null == requiredCapacity
          ? _value.requiredCapacity
          : requiredCapacity // ignore: cast_nullable_to_non_nullable
              as int,
      surplus: null == surplus
          ? _value.surplus
          : surplus // ignore: cast_nullable_to_non_nullable
              as int,
      utilizationRate: null == utilizationRate
          ? _value.utilizationRate
          : utilizationRate // ignore: cast_nullable_to_non_nullable
              as double,
      recommendation: null == recommendation
          ? _value.recommendation
          : recommendation // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WorkforcePlanImpl implements _WorkforcePlan {
  const _$WorkforcePlanImpl(
      {required this.currentCapacity,
      required this.requiredCapacity,
      required this.surplus,
      required this.utilizationRate,
      required this.recommendation});

  factory _$WorkforcePlanImpl.fromJson(Map<String, dynamic> json) =>
      _$$WorkforcePlanImplFromJson(json);

  @override
  final int currentCapacity;
  @override
  final int requiredCapacity;
  @override
  final int surplus;
  @override
  final double utilizationRate;
  @override
  final String recommendation;

  @override
  String toString() {
    return 'WorkforcePlan(currentCapacity: $currentCapacity, requiredCapacity: $requiredCapacity, surplus: $surplus, utilizationRate: $utilizationRate, recommendation: $recommendation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkforcePlanImpl &&
            (identical(other.currentCapacity, currentCapacity) ||
                other.currentCapacity == currentCapacity) &&
            (identical(other.requiredCapacity, requiredCapacity) ||
                other.requiredCapacity == requiredCapacity) &&
            (identical(other.surplus, surplus) || other.surplus == surplus) &&
            (identical(other.utilizationRate, utilizationRate) ||
                other.utilizationRate == utilizationRate) &&
            (identical(other.recommendation, recommendation) ||
                other.recommendation == recommendation));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, currentCapacity,
      requiredCapacity, surplus, utilizationRate, recommendation);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkforcePlanImplCopyWith<_$WorkforcePlanImpl> get copyWith =>
      __$$WorkforcePlanImplCopyWithImpl<_$WorkforcePlanImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WorkforcePlanImplToJson(
      this,
    );
  }
}

abstract class _WorkforcePlan implements WorkforcePlan {
  const factory _WorkforcePlan(
      {required final int currentCapacity,
      required final int requiredCapacity,
      required final int surplus,
      required final double utilizationRate,
      required final String recommendation}) = _$WorkforcePlanImpl;

  factory _WorkforcePlan.fromJson(Map<String, dynamic> json) =
      _$WorkforcePlanImpl.fromJson;

  @override
  int get currentCapacity;
  @override
  int get requiredCapacity;
  @override
  int get surplus;
  @override
  double get utilizationRate;
  @override
  String get recommendation;
  @override
  @JsonKey(ignore: true)
  _$$WorkforcePlanImplCopyWith<_$WorkforcePlanImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SkillGap _$SkillGapFromJson(Map<String, dynamic> json) {
  return _SkillGap.fromJson(json);
}

/// @nodoc
mixin _$SkillGap {
  String get skill => throw _privateConstructorUsedError;
  int get current => throw _privateConstructorUsedError;
  int get required => throw _privateConstructorUsedError;
  int get gap => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SkillGapCopyWith<SkillGap> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SkillGapCopyWith<$Res> {
  factory $SkillGapCopyWith(SkillGap value, $Res Function(SkillGap) then) =
      _$SkillGapCopyWithImpl<$Res, SkillGap>;
  @useResult
  $Res call({String skill, int current, int required, int gap});
}

/// @nodoc
class _$SkillGapCopyWithImpl<$Res, $Val extends SkillGap>
    implements $SkillGapCopyWith<$Res> {
  _$SkillGapCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? skill = null,
    Object? current = null,
    Object? required = null,
    Object? gap = null,
  }) {
    return _then(_value.copyWith(
      skill: null == skill
          ? _value.skill
          : skill // ignore: cast_nullable_to_non_nullable
              as String,
      current: null == current
          ? _value.current
          : current // ignore: cast_nullable_to_non_nullable
              as int,
      required: null == required
          ? _value.required
          : required // ignore: cast_nullable_to_non_nullable
              as int,
      gap: null == gap
          ? _value.gap
          : gap // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SkillGapImplCopyWith<$Res>
    implements $SkillGapCopyWith<$Res> {
  factory _$$SkillGapImplCopyWith(
          _$SkillGapImpl value, $Res Function(_$SkillGapImpl) then) =
      __$$SkillGapImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String skill, int current, int required, int gap});
}

/// @nodoc
class __$$SkillGapImplCopyWithImpl<$Res>
    extends _$SkillGapCopyWithImpl<$Res, _$SkillGapImpl>
    implements _$$SkillGapImplCopyWith<$Res> {
  __$$SkillGapImplCopyWithImpl(
      _$SkillGapImpl _value, $Res Function(_$SkillGapImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? skill = null,
    Object? current = null,
    Object? required = null,
    Object? gap = null,
  }) {
    return _then(_$SkillGapImpl(
      skill: null == skill
          ? _value.skill
          : skill // ignore: cast_nullable_to_non_nullable
              as String,
      current: null == current
          ? _value.current
          : current // ignore: cast_nullable_to_non_nullable
              as int,
      required: null == required
          ? _value.required
          : required // ignore: cast_nullable_to_non_nullable
              as int,
      gap: null == gap
          ? _value.gap
          : gap // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SkillGapImpl implements _SkillGap {
  const _$SkillGapImpl(
      {required this.skill,
      required this.current,
      required this.required,
      required this.gap});

  factory _$SkillGapImpl.fromJson(Map<String, dynamic> json) =>
      _$$SkillGapImplFromJson(json);

  @override
  final String skill;
  @override
  final int current;
  @override
  final int required;
  @override
  final int gap;

  @override
  String toString() {
    return 'SkillGap(skill: $skill, current: $current, required: $required, gap: $gap)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SkillGapImpl &&
            (identical(other.skill, skill) || other.skill == skill) &&
            (identical(other.current, current) || other.current == current) &&
            (identical(other.required, required) ||
                other.required == required) &&
            (identical(other.gap, gap) || other.gap == gap));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, skill, current, required, gap);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SkillGapImplCopyWith<_$SkillGapImpl> get copyWith =>
      __$$SkillGapImplCopyWithImpl<_$SkillGapImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SkillGapImplToJson(
      this,
    );
  }
}

abstract class _SkillGap implements SkillGap {
  const factory _SkillGap(
      {required final String skill,
      required final int current,
      required final int required,
      required final int gap}) = _$SkillGapImpl;

  factory _SkillGap.fromJson(Map<String, dynamic> json) =
      _$SkillGapImpl.fromJson;

  @override
  String get skill;
  @override
  int get current;
  @override
  int get required;
  @override
  int get gap;
  @override
  @JsonKey(ignore: true)
  _$$SkillGapImplCopyWith<_$SkillGapImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TurnoverPrediction _$TurnoverPredictionFromJson(Map<String, dynamic> json) {
  return _TurnoverPrediction.fromJson(json);
}

/// @nodoc
mixin _$TurnoverPrediction {
  String get employeeId => throw _privateConstructorUsedError;
  double get riskScore => throw _privateConstructorUsedError;
  String get riskLevel => throw _privateConstructorUsedError;
  List<String> get factors => throw _privateConstructorUsedError;
  List<String> get recommendations => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TurnoverPredictionCopyWith<TurnoverPrediction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TurnoverPredictionCopyWith<$Res> {
  factory $TurnoverPredictionCopyWith(
          TurnoverPrediction value, $Res Function(TurnoverPrediction) then) =
      _$TurnoverPredictionCopyWithImpl<$Res, TurnoverPrediction>;
  @useResult
  $Res call(
      {String employeeId,
      double riskScore,
      String riskLevel,
      List<String> factors,
      List<String> recommendations});
}

/// @nodoc
class _$TurnoverPredictionCopyWithImpl<$Res, $Val extends TurnoverPrediction>
    implements $TurnoverPredictionCopyWith<$Res> {
  _$TurnoverPredictionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? employeeId = null,
    Object? riskScore = null,
    Object? riskLevel = null,
    Object? factors = null,
    Object? recommendations = null,
  }) {
    return _then(_value.copyWith(
      employeeId: null == employeeId
          ? _value.employeeId
          : employeeId // ignore: cast_nullable_to_non_nullable
              as String,
      riskScore: null == riskScore
          ? _value.riskScore
          : riskScore // ignore: cast_nullable_to_non_nullable
              as double,
      riskLevel: null == riskLevel
          ? _value.riskLevel
          : riskLevel // ignore: cast_nullable_to_non_nullable
              as String,
      factors: null == factors
          ? _value.factors
          : factors // ignore: cast_nullable_to_non_nullable
              as List<String>,
      recommendations: null == recommendations
          ? _value.recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TurnoverPredictionImplCopyWith<$Res>
    implements $TurnoverPredictionCopyWith<$Res> {
  factory _$$TurnoverPredictionImplCopyWith(_$TurnoverPredictionImpl value,
          $Res Function(_$TurnoverPredictionImpl) then) =
      __$$TurnoverPredictionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String employeeId,
      double riskScore,
      String riskLevel,
      List<String> factors,
      List<String> recommendations});
}

/// @nodoc
class __$$TurnoverPredictionImplCopyWithImpl<$Res>
    extends _$TurnoverPredictionCopyWithImpl<$Res, _$TurnoverPredictionImpl>
    implements _$$TurnoverPredictionImplCopyWith<$Res> {
  __$$TurnoverPredictionImplCopyWithImpl(_$TurnoverPredictionImpl _value,
      $Res Function(_$TurnoverPredictionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? employeeId = null,
    Object? riskScore = null,
    Object? riskLevel = null,
    Object? factors = null,
    Object? recommendations = null,
  }) {
    return _then(_$TurnoverPredictionImpl(
      employeeId: null == employeeId
          ? _value.employeeId
          : employeeId // ignore: cast_nullable_to_non_nullable
              as String,
      riskScore: null == riskScore
          ? _value.riskScore
          : riskScore // ignore: cast_nullable_to_non_nullable
              as double,
      riskLevel: null == riskLevel
          ? _value.riskLevel
          : riskLevel // ignore: cast_nullable_to_non_nullable
              as String,
      factors: null == factors
          ? _value._factors
          : factors // ignore: cast_nullable_to_non_nullable
              as List<String>,
      recommendations: null == recommendations
          ? _value._recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TurnoverPredictionImpl implements _TurnoverPrediction {
  const _$TurnoverPredictionImpl(
      {required this.employeeId,
      required this.riskScore,
      required this.riskLevel,
      required final List<String> factors,
      required final List<String> recommendations})
      : _factors = factors,
        _recommendations = recommendations;

  factory _$TurnoverPredictionImpl.fromJson(Map<String, dynamic> json) =>
      _$$TurnoverPredictionImplFromJson(json);

  @override
  final String employeeId;
  @override
  final double riskScore;
  @override
  final String riskLevel;
  final List<String> _factors;
  @override
  List<String> get factors {
    if (_factors is EqualUnmodifiableListView) return _factors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_factors);
  }

  final List<String> _recommendations;
  @override
  List<String> get recommendations {
    if (_recommendations is EqualUnmodifiableListView) return _recommendations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recommendations);
  }

  @override
  String toString() {
    return 'TurnoverPrediction(employeeId: $employeeId, riskScore: $riskScore, riskLevel: $riskLevel, factors: $factors, recommendations: $recommendations)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TurnoverPredictionImpl &&
            (identical(other.employeeId, employeeId) ||
                other.employeeId == employeeId) &&
            (identical(other.riskScore, riskScore) ||
                other.riskScore == riskScore) &&
            (identical(other.riskLevel, riskLevel) ||
                other.riskLevel == riskLevel) &&
            const DeepCollectionEquality().equals(other._factors, _factors) &&
            const DeepCollectionEquality()
                .equals(other._recommendations, _recommendations));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      employeeId,
      riskScore,
      riskLevel,
      const DeepCollectionEquality().hash(_factors),
      const DeepCollectionEquality().hash(_recommendations));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TurnoverPredictionImplCopyWith<_$TurnoverPredictionImpl> get copyWith =>
      __$$TurnoverPredictionImplCopyWithImpl<_$TurnoverPredictionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TurnoverPredictionImplToJson(
      this,
    );
  }
}

abstract class _TurnoverPrediction implements TurnoverPrediction {
  const factory _TurnoverPrediction(
      {required final String employeeId,
      required final double riskScore,
      required final String riskLevel,
      required final List<String> factors,
      required final List<String> recommendations}) = _$TurnoverPredictionImpl;

  factory _TurnoverPrediction.fromJson(Map<String, dynamic> json) =
      _$TurnoverPredictionImpl.fromJson;

  @override
  String get employeeId;
  @override
  double get riskScore;
  @override
  String get riskLevel;
  @override
  List<String> get factors;
  @override
  List<String> get recommendations;
  @override
  @JsonKey(ignore: true)
  _$$TurnoverPredictionImplCopyWith<_$TurnoverPredictionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ScenarioAnalysis _$ScenarioAnalysisFromJson(Map<String, dynamic> json) {
  return _ScenarioAnalysis.fromJson(json);
}

/// @nodoc
mixin _$ScenarioAnalysis {
  String get name => throw _privateConstructorUsedError;
  double get projectedRevenue => throw _privateConstructorUsedError;
  double get projectedCost => throw _privateConstructorUsedError;
  double get netBenefit => throw _privateConstructorUsedError;
  String get feasibility => throw _privateConstructorUsedError;
  double get roi => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ScenarioAnalysisCopyWith<ScenarioAnalysis> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScenarioAnalysisCopyWith<$Res> {
  factory $ScenarioAnalysisCopyWith(
          ScenarioAnalysis value, $Res Function(ScenarioAnalysis) then) =
      _$ScenarioAnalysisCopyWithImpl<$Res, ScenarioAnalysis>;
  @useResult
  $Res call(
      {String name,
      double projectedRevenue,
      double projectedCost,
      double netBenefit,
      String feasibility,
      double roi});
}

/// @nodoc
class _$ScenarioAnalysisCopyWithImpl<$Res, $Val extends ScenarioAnalysis>
    implements $ScenarioAnalysisCopyWith<$Res> {
  _$ScenarioAnalysisCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? projectedRevenue = null,
    Object? projectedCost = null,
    Object? netBenefit = null,
    Object? feasibility = null,
    Object? roi = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      projectedRevenue: null == projectedRevenue
          ? _value.projectedRevenue
          : projectedRevenue // ignore: cast_nullable_to_non_nullable
              as double,
      projectedCost: null == projectedCost
          ? _value.projectedCost
          : projectedCost // ignore: cast_nullable_to_non_nullable
              as double,
      netBenefit: null == netBenefit
          ? _value.netBenefit
          : netBenefit // ignore: cast_nullable_to_non_nullable
              as double,
      feasibility: null == feasibility
          ? _value.feasibility
          : feasibility // ignore: cast_nullable_to_non_nullable
              as String,
      roi: null == roi
          ? _value.roi
          : roi // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ScenarioAnalysisImplCopyWith<$Res>
    implements $ScenarioAnalysisCopyWith<$Res> {
  factory _$$ScenarioAnalysisImplCopyWith(_$ScenarioAnalysisImpl value,
          $Res Function(_$ScenarioAnalysisImpl) then) =
      __$$ScenarioAnalysisImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      double projectedRevenue,
      double projectedCost,
      double netBenefit,
      String feasibility,
      double roi});
}

/// @nodoc
class __$$ScenarioAnalysisImplCopyWithImpl<$Res>
    extends _$ScenarioAnalysisCopyWithImpl<$Res, _$ScenarioAnalysisImpl>
    implements _$$ScenarioAnalysisImplCopyWith<$Res> {
  __$$ScenarioAnalysisImplCopyWithImpl(_$ScenarioAnalysisImpl _value,
      $Res Function(_$ScenarioAnalysisImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? projectedRevenue = null,
    Object? projectedCost = null,
    Object? netBenefit = null,
    Object? feasibility = null,
    Object? roi = null,
  }) {
    return _then(_$ScenarioAnalysisImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      projectedRevenue: null == projectedRevenue
          ? _value.projectedRevenue
          : projectedRevenue // ignore: cast_nullable_to_non_nullable
              as double,
      projectedCost: null == projectedCost
          ? _value.projectedCost
          : projectedCost // ignore: cast_nullable_to_non_nullable
              as double,
      netBenefit: null == netBenefit
          ? _value.netBenefit
          : netBenefit // ignore: cast_nullable_to_non_nullable
              as double,
      feasibility: null == feasibility
          ? _value.feasibility
          : feasibility // ignore: cast_nullable_to_non_nullable
              as String,
      roi: null == roi
          ? _value.roi
          : roi // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ScenarioAnalysisImpl implements _ScenarioAnalysis {
  const _$ScenarioAnalysisImpl(
      {required this.name,
      required this.projectedRevenue,
      required this.projectedCost,
      required this.netBenefit,
      required this.feasibility,
      required this.roi});

  factory _$ScenarioAnalysisImpl.fromJson(Map<String, dynamic> json) =>
      _$$ScenarioAnalysisImplFromJson(json);

  @override
  final String name;
  @override
  final double projectedRevenue;
  @override
  final double projectedCost;
  @override
  final double netBenefit;
  @override
  final String feasibility;
  @override
  final double roi;

  @override
  String toString() {
    return 'ScenarioAnalysis(name: $name, projectedRevenue: $projectedRevenue, projectedCost: $projectedCost, netBenefit: $netBenefit, feasibility: $feasibility, roi: $roi)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScenarioAnalysisImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.projectedRevenue, projectedRevenue) ||
                other.projectedRevenue == projectedRevenue) &&
            (identical(other.projectedCost, projectedCost) ||
                other.projectedCost == projectedCost) &&
            (identical(other.netBenefit, netBenefit) ||
                other.netBenefit == netBenefit) &&
            (identical(other.feasibility, feasibility) ||
                other.feasibility == feasibility) &&
            (identical(other.roi, roi) || other.roi == roi));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, projectedRevenue,
      projectedCost, netBenefit, feasibility, roi);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ScenarioAnalysisImplCopyWith<_$ScenarioAnalysisImpl> get copyWith =>
      __$$ScenarioAnalysisImplCopyWithImpl<_$ScenarioAnalysisImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ScenarioAnalysisImplToJson(
      this,
    );
  }
}

abstract class _ScenarioAnalysis implements ScenarioAnalysis {
  const factory _ScenarioAnalysis(
      {required final String name,
      required final double projectedRevenue,
      required final double projectedCost,
      required final double netBenefit,
      required final String feasibility,
      required final double roi}) = _$ScenarioAnalysisImpl;

  factory _ScenarioAnalysis.fromJson(Map<String, dynamic> json) =
      _$ScenarioAnalysisImpl.fromJson;

  @override
  String get name;
  @override
  double get projectedRevenue;
  @override
  double get projectedCost;
  @override
  double get netBenefit;
  @override
  String get feasibility;
  @override
  double get roi;
  @override
  @JsonKey(ignore: true)
  _$$ScenarioAnalysisImplCopyWith<_$ScenarioAnalysisImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ResourceAllocation _$ResourceAllocationFromJson(Map<String, dynamic> json) {
  return _ResourceAllocation.fromJson(json);
}

/// @nodoc
mixin _$ResourceAllocation {
  String get appointmentId => throw _privateConstructorUsedError;
  String get workerId => throw _privateConstructorUsedError;
  double get score => throw _privateConstructorUsedError;
  double get cost => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ResourceAllocationCopyWith<ResourceAllocation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResourceAllocationCopyWith<$Res> {
  factory $ResourceAllocationCopyWith(
          ResourceAllocation value, $Res Function(ResourceAllocation) then) =
      _$ResourceAllocationCopyWithImpl<$Res, ResourceAllocation>;
  @useResult
  $Res call({String appointmentId, String workerId, double score, double cost});
}

/// @nodoc
class _$ResourceAllocationCopyWithImpl<$Res, $Val extends ResourceAllocation>
    implements $ResourceAllocationCopyWith<$Res> {
  _$ResourceAllocationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appointmentId = null,
    Object? workerId = null,
    Object? score = null,
    Object? cost = null,
  }) {
    return _then(_value.copyWith(
      appointmentId: null == appointmentId
          ? _value.appointmentId
          : appointmentId // ignore: cast_nullable_to_non_nullable
              as String,
      workerId: null == workerId
          ? _value.workerId
          : workerId // ignore: cast_nullable_to_non_nullable
              as String,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as double,
      cost: null == cost
          ? _value.cost
          : cost // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ResourceAllocationImplCopyWith<$Res>
    implements $ResourceAllocationCopyWith<$Res> {
  factory _$$ResourceAllocationImplCopyWith(_$ResourceAllocationImpl value,
          $Res Function(_$ResourceAllocationImpl) then) =
      __$$ResourceAllocationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String appointmentId, String workerId, double score, double cost});
}

/// @nodoc
class __$$ResourceAllocationImplCopyWithImpl<$Res>
    extends _$ResourceAllocationCopyWithImpl<$Res, _$ResourceAllocationImpl>
    implements _$$ResourceAllocationImplCopyWith<$Res> {
  __$$ResourceAllocationImplCopyWithImpl(_$ResourceAllocationImpl _value,
      $Res Function(_$ResourceAllocationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appointmentId = null,
    Object? workerId = null,
    Object? score = null,
    Object? cost = null,
  }) {
    return _then(_$ResourceAllocationImpl(
      appointmentId: null == appointmentId
          ? _value.appointmentId
          : appointmentId // ignore: cast_nullable_to_non_nullable
              as String,
      workerId: null == workerId
          ? _value.workerId
          : workerId // ignore: cast_nullable_to_non_nullable
              as String,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as double,
      cost: null == cost
          ? _value.cost
          : cost // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ResourceAllocationImpl implements _ResourceAllocation {
  const _$ResourceAllocationImpl(
      {required this.appointmentId,
      required this.workerId,
      required this.score,
      required this.cost});

  factory _$ResourceAllocationImpl.fromJson(Map<String, dynamic> json) =>
      _$$ResourceAllocationImplFromJson(json);

  @override
  final String appointmentId;
  @override
  final String workerId;
  @override
  final double score;
  @override
  final double cost;

  @override
  String toString() {
    return 'ResourceAllocation(appointmentId: $appointmentId, workerId: $workerId, score: $score, cost: $cost)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResourceAllocationImpl &&
            (identical(other.appointmentId, appointmentId) ||
                other.appointmentId == appointmentId) &&
            (identical(other.workerId, workerId) ||
                other.workerId == workerId) &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.cost, cost) || other.cost == cost));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, appointmentId, workerId, score, cost);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ResourceAllocationImplCopyWith<_$ResourceAllocationImpl> get copyWith =>
      __$$ResourceAllocationImplCopyWithImpl<_$ResourceAllocationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ResourceAllocationImplToJson(
      this,
    );
  }
}

abstract class _ResourceAllocation implements ResourceAllocation {
  const factory _ResourceAllocation(
      {required final String appointmentId,
      required final String workerId,
      required final double score,
      required final double cost}) = _$ResourceAllocationImpl;

  factory _ResourceAllocation.fromJson(Map<String, dynamic> json) =
      _$ResourceAllocationImpl.fromJson;

  @override
  String get appointmentId;
  @override
  String get workerId;
  @override
  double get score;
  @override
  double get cost;
  @override
  @JsonKey(ignore: true)
  _$$ResourceAllocationImplCopyWith<_$ResourceAllocationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AllocationMetrics _$AllocationMetricsFromJson(Map<String, dynamic> json) {
  return _AllocationMetrics.fromJson(json);
}

/// @nodoc
mixin _$AllocationMetrics {
  int get totalAllocations => throw _privateConstructorUsedError;
  double get averageScore => throw _privateConstructorUsedError;
  double get totalCost => throw _privateConstructorUsedError;
  double get utilizationRate => throw _privateConstructorUsedError;
  int get unassignedCount => throw _privateConstructorUsedError;
  int get conflictCount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AllocationMetricsCopyWith<AllocationMetrics> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AllocationMetricsCopyWith<$Res> {
  factory $AllocationMetricsCopyWith(
          AllocationMetrics value, $Res Function(AllocationMetrics) then) =
      _$AllocationMetricsCopyWithImpl<$Res, AllocationMetrics>;
  @useResult
  $Res call(
      {int totalAllocations,
      double averageScore,
      double totalCost,
      double utilizationRate,
      int unassignedCount,
      int conflictCount});
}

/// @nodoc
class _$AllocationMetricsCopyWithImpl<$Res, $Val extends AllocationMetrics>
    implements $AllocationMetricsCopyWith<$Res> {
  _$AllocationMetricsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalAllocations = null,
    Object? averageScore = null,
    Object? totalCost = null,
    Object? utilizationRate = null,
    Object? unassignedCount = null,
    Object? conflictCount = null,
  }) {
    return _then(_value.copyWith(
      totalAllocations: null == totalAllocations
          ? _value.totalAllocations
          : totalAllocations // ignore: cast_nullable_to_non_nullable
              as int,
      averageScore: null == averageScore
          ? _value.averageScore
          : averageScore // ignore: cast_nullable_to_non_nullable
              as double,
      totalCost: null == totalCost
          ? _value.totalCost
          : totalCost // ignore: cast_nullable_to_non_nullable
              as double,
      utilizationRate: null == utilizationRate
          ? _value.utilizationRate
          : utilizationRate // ignore: cast_nullable_to_non_nullable
              as double,
      unassignedCount: null == unassignedCount
          ? _value.unassignedCount
          : unassignedCount // ignore: cast_nullable_to_non_nullable
              as int,
      conflictCount: null == conflictCount
          ? _value.conflictCount
          : conflictCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AllocationMetricsImplCopyWith<$Res>
    implements $AllocationMetricsCopyWith<$Res> {
  factory _$$AllocationMetricsImplCopyWith(_$AllocationMetricsImpl value,
          $Res Function(_$AllocationMetricsImpl) then) =
      __$$AllocationMetricsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int totalAllocations,
      double averageScore,
      double totalCost,
      double utilizationRate,
      int unassignedCount,
      int conflictCount});
}

/// @nodoc
class __$$AllocationMetricsImplCopyWithImpl<$Res>
    extends _$AllocationMetricsCopyWithImpl<$Res, _$AllocationMetricsImpl>
    implements _$$AllocationMetricsImplCopyWith<$Res> {
  __$$AllocationMetricsImplCopyWithImpl(_$AllocationMetricsImpl _value,
      $Res Function(_$AllocationMetricsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalAllocations = null,
    Object? averageScore = null,
    Object? totalCost = null,
    Object? utilizationRate = null,
    Object? unassignedCount = null,
    Object? conflictCount = null,
  }) {
    return _then(_$AllocationMetricsImpl(
      totalAllocations: null == totalAllocations
          ? _value.totalAllocations
          : totalAllocations // ignore: cast_nullable_to_non_nullable
              as int,
      averageScore: null == averageScore
          ? _value.averageScore
          : averageScore // ignore: cast_nullable_to_non_nullable
              as double,
      totalCost: null == totalCost
          ? _value.totalCost
          : totalCost // ignore: cast_nullable_to_non_nullable
              as double,
      utilizationRate: null == utilizationRate
          ? _value.utilizationRate
          : utilizationRate // ignore: cast_nullable_to_non_nullable
              as double,
      unassignedCount: null == unassignedCount
          ? _value.unassignedCount
          : unassignedCount // ignore: cast_nullable_to_non_nullable
              as int,
      conflictCount: null == conflictCount
          ? _value.conflictCount
          : conflictCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AllocationMetricsImpl implements _AllocationMetrics {
  const _$AllocationMetricsImpl(
      {required this.totalAllocations,
      required this.averageScore,
      required this.totalCost,
      required this.utilizationRate,
      required this.unassignedCount,
      required this.conflictCount});

  factory _$AllocationMetricsImpl.fromJson(Map<String, dynamic> json) =>
      _$$AllocationMetricsImplFromJson(json);

  @override
  final int totalAllocations;
  @override
  final double averageScore;
  @override
  final double totalCost;
  @override
  final double utilizationRate;
  @override
  final int unassignedCount;
  @override
  final int conflictCount;

  @override
  String toString() {
    return 'AllocationMetrics(totalAllocations: $totalAllocations, averageScore: $averageScore, totalCost: $totalCost, utilizationRate: $utilizationRate, unassignedCount: $unassignedCount, conflictCount: $conflictCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AllocationMetricsImpl &&
            (identical(other.totalAllocations, totalAllocations) ||
                other.totalAllocations == totalAllocations) &&
            (identical(other.averageScore, averageScore) ||
                other.averageScore == averageScore) &&
            (identical(other.totalCost, totalCost) ||
                other.totalCost == totalCost) &&
            (identical(other.utilizationRate, utilizationRate) ||
                other.utilizationRate == utilizationRate) &&
            (identical(other.unassignedCount, unassignedCount) ||
                other.unassignedCount == unassignedCount) &&
            (identical(other.conflictCount, conflictCount) ||
                other.conflictCount == conflictCount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, totalAllocations, averageScore,
      totalCost, utilizationRate, unassignedCount, conflictCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AllocationMetricsImplCopyWith<_$AllocationMetricsImpl> get copyWith =>
      __$$AllocationMetricsImplCopyWithImpl<_$AllocationMetricsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AllocationMetricsImplToJson(
      this,
    );
  }
}

abstract class _AllocationMetrics implements AllocationMetrics {
  const factory _AllocationMetrics(
      {required final int totalAllocations,
      required final double averageScore,
      required final double totalCost,
      required final double utilizationRate,
      required final int unassignedCount,
      required final int conflictCount}) = _$AllocationMetricsImpl;

  factory _AllocationMetrics.fromJson(Map<String, dynamic> json) =
      _$AllocationMetricsImpl.fromJson;

  @override
  int get totalAllocations;
  @override
  double get averageScore;
  @override
  double get totalCost;
  @override
  double get utilizationRate;
  @override
  int get unassignedCount;
  @override
  int get conflictCount;
  @override
  @JsonKey(ignore: true)
  _$$AllocationMetricsImplCopyWith<_$AllocationMetricsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WorkerRecommendation _$WorkerRecommendationFromJson(Map<String, dynamic> json) {
  return _WorkerRecommendation.fromJson(json);
}

/// @nodoc
mixin _$WorkerRecommendation {
  String get workerId => throw _privateConstructorUsedError;
  String get workerName => throw _privateConstructorUsedError;
  double get score => throw _privateConstructorUsedError;
  Map<String, dynamic> get factors => throw _privateConstructorUsedError;
  bool get availability => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WorkerRecommendationCopyWith<WorkerRecommendation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkerRecommendationCopyWith<$Res> {
  factory $WorkerRecommendationCopyWith(WorkerRecommendation value,
          $Res Function(WorkerRecommendation) then) =
      _$WorkerRecommendationCopyWithImpl<$Res, WorkerRecommendation>;
  @useResult
  $Res call(
      {String workerId,
      String workerName,
      double score,
      Map<String, dynamic> factors,
      bool availability});
}

/// @nodoc
class _$WorkerRecommendationCopyWithImpl<$Res,
        $Val extends WorkerRecommendation>
    implements $WorkerRecommendationCopyWith<$Res> {
  _$WorkerRecommendationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? workerId = null,
    Object? workerName = null,
    Object? score = null,
    Object? factors = null,
    Object? availability = null,
  }) {
    return _then(_value.copyWith(
      workerId: null == workerId
          ? _value.workerId
          : workerId // ignore: cast_nullable_to_non_nullable
              as String,
      workerName: null == workerName
          ? _value.workerName
          : workerName // ignore: cast_nullable_to_non_nullable
              as String,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as double,
      factors: null == factors
          ? _value.factors
          : factors // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      availability: null == availability
          ? _value.availability
          : availability // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WorkerRecommendationImplCopyWith<$Res>
    implements $WorkerRecommendationCopyWith<$Res> {
  factory _$$WorkerRecommendationImplCopyWith(_$WorkerRecommendationImpl value,
          $Res Function(_$WorkerRecommendationImpl) then) =
      __$$WorkerRecommendationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String workerId,
      String workerName,
      double score,
      Map<String, dynamic> factors,
      bool availability});
}

/// @nodoc
class __$$WorkerRecommendationImplCopyWithImpl<$Res>
    extends _$WorkerRecommendationCopyWithImpl<$Res, _$WorkerRecommendationImpl>
    implements _$$WorkerRecommendationImplCopyWith<$Res> {
  __$$WorkerRecommendationImplCopyWithImpl(_$WorkerRecommendationImpl _value,
      $Res Function(_$WorkerRecommendationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? workerId = null,
    Object? workerName = null,
    Object? score = null,
    Object? factors = null,
    Object? availability = null,
  }) {
    return _then(_$WorkerRecommendationImpl(
      workerId: null == workerId
          ? _value.workerId
          : workerId // ignore: cast_nullable_to_non_nullable
              as String,
      workerName: null == workerName
          ? _value.workerName
          : workerName // ignore: cast_nullable_to_non_nullable
              as String,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as double,
      factors: null == factors
          ? _value._factors
          : factors // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      availability: null == availability
          ? _value.availability
          : availability // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WorkerRecommendationImpl implements _WorkerRecommendation {
  const _$WorkerRecommendationImpl(
      {required this.workerId,
      required this.workerName,
      required this.score,
      required final Map<String, dynamic> factors,
      required this.availability})
      : _factors = factors;

  factory _$WorkerRecommendationImpl.fromJson(Map<String, dynamic> json) =>
      _$$WorkerRecommendationImplFromJson(json);

  @override
  final String workerId;
  @override
  final String workerName;
  @override
  final double score;
  final Map<String, dynamic> _factors;
  @override
  Map<String, dynamic> get factors {
    if (_factors is EqualUnmodifiableMapView) return _factors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_factors);
  }

  @override
  final bool availability;

  @override
  String toString() {
    return 'WorkerRecommendation(workerId: $workerId, workerName: $workerName, score: $score, factors: $factors, availability: $availability)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkerRecommendationImpl &&
            (identical(other.workerId, workerId) ||
                other.workerId == workerId) &&
            (identical(other.workerName, workerName) ||
                other.workerName == workerName) &&
            (identical(other.score, score) || other.score == score) &&
            const DeepCollectionEquality().equals(other._factors, _factors) &&
            (identical(other.availability, availability) ||
                other.availability == availability));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, workerId, workerName, score,
      const DeepCollectionEquality().hash(_factors), availability);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkerRecommendationImplCopyWith<_$WorkerRecommendationImpl>
      get copyWith =>
          __$$WorkerRecommendationImplCopyWithImpl<_$WorkerRecommendationImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WorkerRecommendationImplToJson(
      this,
    );
  }
}

abstract class _WorkerRecommendation implements WorkerRecommendation {
  const factory _WorkerRecommendation(
      {required final String workerId,
      required final String workerName,
      required final double score,
      required final Map<String, dynamic> factors,
      required final bool availability}) = _$WorkerRecommendationImpl;

  factory _WorkerRecommendation.fromJson(Map<String, dynamic> json) =
      _$WorkerRecommendationImpl.fromJson;

  @override
  String get workerId;
  @override
  String get workerName;
  @override
  double get score;
  @override
  Map<String, dynamic> get factors;
  @override
  bool get availability;
  @override
  @JsonKey(ignore: true)
  _$$WorkerRecommendationImplCopyWith<_$WorkerRecommendationImpl>
      get copyWith => throw _privateConstructorUsedError;
}

WorkloadAnalysis _$WorkloadAnalysisFromJson(Map<String, dynamic> json) {
  return _WorkloadAnalysis.fromJson(json);
}

/// @nodoc
mixin _$WorkloadAnalysis {
  String get workerId => throw _privateConstructorUsedError;
  String get workerName => throw _privateConstructorUsedError;
  int get appointments => throw _privateConstructorUsedError;
  double get hours => throw _privateConstructorUsedError;
  double get utilization => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WorkloadAnalysisCopyWith<WorkloadAnalysis> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkloadAnalysisCopyWith<$Res> {
  factory $WorkloadAnalysisCopyWith(
          WorkloadAnalysis value, $Res Function(WorkloadAnalysis) then) =
      _$WorkloadAnalysisCopyWithImpl<$Res, WorkloadAnalysis>;
  @useResult
  $Res call(
      {String workerId,
      String workerName,
      int appointments,
      double hours,
      double utilization});
}

/// @nodoc
class _$WorkloadAnalysisCopyWithImpl<$Res, $Val extends WorkloadAnalysis>
    implements $WorkloadAnalysisCopyWith<$Res> {
  _$WorkloadAnalysisCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? workerId = null,
    Object? workerName = null,
    Object? appointments = null,
    Object? hours = null,
    Object? utilization = null,
  }) {
    return _then(_value.copyWith(
      workerId: null == workerId
          ? _value.workerId
          : workerId // ignore: cast_nullable_to_non_nullable
              as String,
      workerName: null == workerName
          ? _value.workerName
          : workerName // ignore: cast_nullable_to_non_nullable
              as String,
      appointments: null == appointments
          ? _value.appointments
          : appointments // ignore: cast_nullable_to_non_nullable
              as int,
      hours: null == hours
          ? _value.hours
          : hours // ignore: cast_nullable_to_non_nullable
              as double,
      utilization: null == utilization
          ? _value.utilization
          : utilization // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WorkloadAnalysisImplCopyWith<$Res>
    implements $WorkloadAnalysisCopyWith<$Res> {
  factory _$$WorkloadAnalysisImplCopyWith(_$WorkloadAnalysisImpl value,
          $Res Function(_$WorkloadAnalysisImpl) then) =
      __$$WorkloadAnalysisImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String workerId,
      String workerName,
      int appointments,
      double hours,
      double utilization});
}

/// @nodoc
class __$$WorkloadAnalysisImplCopyWithImpl<$Res>
    extends _$WorkloadAnalysisCopyWithImpl<$Res, _$WorkloadAnalysisImpl>
    implements _$$WorkloadAnalysisImplCopyWith<$Res> {
  __$$WorkloadAnalysisImplCopyWithImpl(_$WorkloadAnalysisImpl _value,
      $Res Function(_$WorkloadAnalysisImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? workerId = null,
    Object? workerName = null,
    Object? appointments = null,
    Object? hours = null,
    Object? utilization = null,
  }) {
    return _then(_$WorkloadAnalysisImpl(
      workerId: null == workerId
          ? _value.workerId
          : workerId // ignore: cast_nullable_to_non_nullable
              as String,
      workerName: null == workerName
          ? _value.workerName
          : workerName // ignore: cast_nullable_to_non_nullable
              as String,
      appointments: null == appointments
          ? _value.appointments
          : appointments // ignore: cast_nullable_to_non_nullable
              as int,
      hours: null == hours
          ? _value.hours
          : hours // ignore: cast_nullable_to_non_nullable
              as double,
      utilization: null == utilization
          ? _value.utilization
          : utilization // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WorkloadAnalysisImpl implements _WorkloadAnalysis {
  const _$WorkloadAnalysisImpl(
      {required this.workerId,
      required this.workerName,
      required this.appointments,
      required this.hours,
      required this.utilization});

  factory _$WorkloadAnalysisImpl.fromJson(Map<String, dynamic> json) =>
      _$$WorkloadAnalysisImplFromJson(json);

  @override
  final String workerId;
  @override
  final String workerName;
  @override
  final int appointments;
  @override
  final double hours;
  @override
  final double utilization;

  @override
  String toString() {
    return 'WorkloadAnalysis(workerId: $workerId, workerName: $workerName, appointments: $appointments, hours: $hours, utilization: $utilization)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkloadAnalysisImpl &&
            (identical(other.workerId, workerId) ||
                other.workerId == workerId) &&
            (identical(other.workerName, workerName) ||
                other.workerName == workerName) &&
            (identical(other.appointments, appointments) ||
                other.appointments == appointments) &&
            (identical(other.hours, hours) || other.hours == hours) &&
            (identical(other.utilization, utilization) ||
                other.utilization == utilization));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, workerId, workerName, appointments, hours, utilization);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkloadAnalysisImplCopyWith<_$WorkloadAnalysisImpl> get copyWith =>
      __$$WorkloadAnalysisImplCopyWithImpl<_$WorkloadAnalysisImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WorkloadAnalysisImplToJson(
      this,
    );
  }
}

abstract class _WorkloadAnalysis implements WorkloadAnalysis {
  const factory _WorkloadAnalysis(
      {required final String workerId,
      required final String workerName,
      required final int appointments,
      required final double hours,
      required final double utilization}) = _$WorkloadAnalysisImpl;

  factory _WorkloadAnalysis.fromJson(Map<String, dynamic> json) =
      _$WorkloadAnalysisImpl.fromJson;

  @override
  String get workerId;
  @override
  String get workerName;
  @override
  int get appointments;
  @override
  double get hours;
  @override
  double get utilization;
  @override
  @JsonKey(ignore: true)
  _$$WorkloadAnalysisImplCopyWith<_$WorkloadAnalysisImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PerformanceMetrics _$PerformanceMetricsFromJson(Map<String, dynamic> json) {
  return _PerformanceMetrics.fromJson(json);
}

/// @nodoc
mixin _$PerformanceMetrics {
  int get totalAppointments => throw _privateConstructorUsedError;
  double get avgRating => throw _privateConstructorUsedError;
  double get completionRate => throw _privateConstructorUsedError;
  double get revenue => throw _privateConstructorUsedError;
  double get revenuePerAppointment => throw _privateConstructorUsedError;
  double get punctualityScore => throw _privateConstructorUsedError;
  double get qualityScore => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PerformanceMetricsCopyWith<PerformanceMetrics> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PerformanceMetricsCopyWith<$Res> {
  factory $PerformanceMetricsCopyWith(
          PerformanceMetrics value, $Res Function(PerformanceMetrics) then) =
      _$PerformanceMetricsCopyWithImpl<$Res, PerformanceMetrics>;
  @useResult
  $Res call(
      {int totalAppointments,
      double avgRating,
      double completionRate,
      double revenue,
      double revenuePerAppointment,
      double punctualityScore,
      double qualityScore});
}

/// @nodoc
class _$PerformanceMetricsCopyWithImpl<$Res, $Val extends PerformanceMetrics>
    implements $PerformanceMetricsCopyWith<$Res> {
  _$PerformanceMetricsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalAppointments = null,
    Object? avgRating = null,
    Object? completionRate = null,
    Object? revenue = null,
    Object? revenuePerAppointment = null,
    Object? punctualityScore = null,
    Object? qualityScore = null,
  }) {
    return _then(_value.copyWith(
      totalAppointments: null == totalAppointments
          ? _value.totalAppointments
          : totalAppointments // ignore: cast_nullable_to_non_nullable
              as int,
      avgRating: null == avgRating
          ? _value.avgRating
          : avgRating // ignore: cast_nullable_to_non_nullable
              as double,
      completionRate: null == completionRate
          ? _value.completionRate
          : completionRate // ignore: cast_nullable_to_non_nullable
              as double,
      revenue: null == revenue
          ? _value.revenue
          : revenue // ignore: cast_nullable_to_non_nullable
              as double,
      revenuePerAppointment: null == revenuePerAppointment
          ? _value.revenuePerAppointment
          : revenuePerAppointment // ignore: cast_nullable_to_non_nullable
              as double,
      punctualityScore: null == punctualityScore
          ? _value.punctualityScore
          : punctualityScore // ignore: cast_nullable_to_non_nullable
              as double,
      qualityScore: null == qualityScore
          ? _value.qualityScore
          : qualityScore // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PerformanceMetricsImplCopyWith<$Res>
    implements $PerformanceMetricsCopyWith<$Res> {
  factory _$$PerformanceMetricsImplCopyWith(_$PerformanceMetricsImpl value,
          $Res Function(_$PerformanceMetricsImpl) then) =
      __$$PerformanceMetricsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int totalAppointments,
      double avgRating,
      double completionRate,
      double revenue,
      double revenuePerAppointment,
      double punctualityScore,
      double qualityScore});
}

/// @nodoc
class __$$PerformanceMetricsImplCopyWithImpl<$Res>
    extends _$PerformanceMetricsCopyWithImpl<$Res, _$PerformanceMetricsImpl>
    implements _$$PerformanceMetricsImplCopyWith<$Res> {
  __$$PerformanceMetricsImplCopyWithImpl(_$PerformanceMetricsImpl _value,
      $Res Function(_$PerformanceMetricsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalAppointments = null,
    Object? avgRating = null,
    Object? completionRate = null,
    Object? revenue = null,
    Object? revenuePerAppointment = null,
    Object? punctualityScore = null,
    Object? qualityScore = null,
  }) {
    return _then(_$PerformanceMetricsImpl(
      totalAppointments: null == totalAppointments
          ? _value.totalAppointments
          : totalAppointments // ignore: cast_nullable_to_non_nullable
              as int,
      avgRating: null == avgRating
          ? _value.avgRating
          : avgRating // ignore: cast_nullable_to_non_nullable
              as double,
      completionRate: null == completionRate
          ? _value.completionRate
          : completionRate // ignore: cast_nullable_to_non_nullable
              as double,
      revenue: null == revenue
          ? _value.revenue
          : revenue // ignore: cast_nullable_to_non_nullable
              as double,
      revenuePerAppointment: null == revenuePerAppointment
          ? _value.revenuePerAppointment
          : revenuePerAppointment // ignore: cast_nullable_to_non_nullable
              as double,
      punctualityScore: null == punctualityScore
          ? _value.punctualityScore
          : punctualityScore // ignore: cast_nullable_to_non_nullable
              as double,
      qualityScore: null == qualityScore
          ? _value.qualityScore
          : qualityScore // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PerformanceMetricsImpl implements _PerformanceMetrics {
  const _$PerformanceMetricsImpl(
      {required this.totalAppointments,
      required this.avgRating,
      required this.completionRate,
      required this.revenue,
      required this.revenuePerAppointment,
      required this.punctualityScore,
      required this.qualityScore});

  factory _$PerformanceMetricsImpl.fromJson(Map<String, dynamic> json) =>
      _$$PerformanceMetricsImplFromJson(json);

  @override
  final int totalAppointments;
  @override
  final double avgRating;
  @override
  final double completionRate;
  @override
  final double revenue;
  @override
  final double revenuePerAppointment;
  @override
  final double punctualityScore;
  @override
  final double qualityScore;

  @override
  String toString() {
    return 'PerformanceMetrics(totalAppointments: $totalAppointments, avgRating: $avgRating, completionRate: $completionRate, revenue: $revenue, revenuePerAppointment: $revenuePerAppointment, punctualityScore: $punctualityScore, qualityScore: $qualityScore)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PerformanceMetricsImpl &&
            (identical(other.totalAppointments, totalAppointments) ||
                other.totalAppointments == totalAppointments) &&
            (identical(other.avgRating, avgRating) ||
                other.avgRating == avgRating) &&
            (identical(other.completionRate, completionRate) ||
                other.completionRate == completionRate) &&
            (identical(other.revenue, revenue) || other.revenue == revenue) &&
            (identical(other.revenuePerAppointment, revenuePerAppointment) ||
                other.revenuePerAppointment == revenuePerAppointment) &&
            (identical(other.punctualityScore, punctualityScore) ||
                other.punctualityScore == punctualityScore) &&
            (identical(other.qualityScore, qualityScore) ||
                other.qualityScore == qualityScore));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      totalAppointments,
      avgRating,
      completionRate,
      revenue,
      revenuePerAppointment,
      punctualityScore,
      qualityScore);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PerformanceMetricsImplCopyWith<_$PerformanceMetricsImpl> get copyWith =>
      __$$PerformanceMetricsImplCopyWithImpl<_$PerformanceMetricsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PerformanceMetricsImplToJson(
      this,
    );
  }
}

abstract class _PerformanceMetrics implements PerformanceMetrics {
  const factory _PerformanceMetrics(
      {required final int totalAppointments,
      required final double avgRating,
      required final double completionRate,
      required final double revenue,
      required final double revenuePerAppointment,
      required final double punctualityScore,
      required final double qualityScore}) = _$PerformanceMetricsImpl;

  factory _PerformanceMetrics.fromJson(Map<String, dynamic> json) =
      _$PerformanceMetricsImpl.fromJson;

  @override
  int get totalAppointments;
  @override
  double get avgRating;
  @override
  double get completionRate;
  @override
  double get revenue;
  @override
  double get revenuePerAppointment;
  @override
  double get punctualityScore;
  @override
  double get qualityScore;
  @override
  @JsonKey(ignore: true)
  _$$PerformanceMetricsImplCopyWith<_$PerformanceMetricsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PerformanceAnalytics _$PerformanceAnalyticsFromJson(Map<String, dynamic> json) {
  return _PerformanceAnalytics.fromJson(json);
}

/// @nodoc
mixin _$PerformanceAnalytics {
  String get employeeId => throw _privateConstructorUsedError;
  String get employeeName => throw _privateConstructorUsedError;
  PerformanceMetrics get metrics => throw _privateConstructorUsedError;
  PerformanceTrend get trends => throw _privateConstructorUsedError;
  PeerComparison get comparison => throw _privateConstructorUsedError;
  double get score => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PerformanceAnalyticsCopyWith<PerformanceAnalytics> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PerformanceAnalyticsCopyWith<$Res> {
  factory $PerformanceAnalyticsCopyWith(PerformanceAnalytics value,
          $Res Function(PerformanceAnalytics) then) =
      _$PerformanceAnalyticsCopyWithImpl<$Res, PerformanceAnalytics>;
  @useResult
  $Res call(
      {String employeeId,
      String employeeName,
      PerformanceMetrics metrics,
      PerformanceTrend trends,
      PeerComparison comparison,
      double score});

  $PerformanceMetricsCopyWith<$Res> get metrics;
  $PerformanceTrendCopyWith<$Res> get trends;
  $PeerComparisonCopyWith<$Res> get comparison;
}

/// @nodoc
class _$PerformanceAnalyticsCopyWithImpl<$Res,
        $Val extends PerformanceAnalytics>
    implements $PerformanceAnalyticsCopyWith<$Res> {
  _$PerformanceAnalyticsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? employeeId = null,
    Object? employeeName = null,
    Object? metrics = null,
    Object? trends = null,
    Object? comparison = null,
    Object? score = null,
  }) {
    return _then(_value.copyWith(
      employeeId: null == employeeId
          ? _value.employeeId
          : employeeId // ignore: cast_nullable_to_non_nullable
              as String,
      employeeName: null == employeeName
          ? _value.employeeName
          : employeeName // ignore: cast_nullable_to_non_nullable
              as String,
      metrics: null == metrics
          ? _value.metrics
          : metrics // ignore: cast_nullable_to_non_nullable
              as PerformanceMetrics,
      trends: null == trends
          ? _value.trends
          : trends // ignore: cast_nullable_to_non_nullable
              as PerformanceTrend,
      comparison: null == comparison
          ? _value.comparison
          : comparison // ignore: cast_nullable_to_non_nullable
              as PeerComparison,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PerformanceMetricsCopyWith<$Res> get metrics {
    return $PerformanceMetricsCopyWith<$Res>(_value.metrics, (value) {
      return _then(_value.copyWith(metrics: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PerformanceTrendCopyWith<$Res> get trends {
    return $PerformanceTrendCopyWith<$Res>(_value.trends, (value) {
      return _then(_value.copyWith(trends: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PeerComparisonCopyWith<$Res> get comparison {
    return $PeerComparisonCopyWith<$Res>(_value.comparison, (value) {
      return _then(_value.copyWith(comparison: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PerformanceAnalyticsImplCopyWith<$Res>
    implements $PerformanceAnalyticsCopyWith<$Res> {
  factory _$$PerformanceAnalyticsImplCopyWith(_$PerformanceAnalyticsImpl value,
          $Res Function(_$PerformanceAnalyticsImpl) then) =
      __$$PerformanceAnalyticsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String employeeId,
      String employeeName,
      PerformanceMetrics metrics,
      PerformanceTrend trends,
      PeerComparison comparison,
      double score});

  @override
  $PerformanceMetricsCopyWith<$Res> get metrics;
  @override
  $PerformanceTrendCopyWith<$Res> get trends;
  @override
  $PeerComparisonCopyWith<$Res> get comparison;
}

/// @nodoc
class __$$PerformanceAnalyticsImplCopyWithImpl<$Res>
    extends _$PerformanceAnalyticsCopyWithImpl<$Res, _$PerformanceAnalyticsImpl>
    implements _$$PerformanceAnalyticsImplCopyWith<$Res> {
  __$$PerformanceAnalyticsImplCopyWithImpl(_$PerformanceAnalyticsImpl _value,
      $Res Function(_$PerformanceAnalyticsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? employeeId = null,
    Object? employeeName = null,
    Object? metrics = null,
    Object? trends = null,
    Object? comparison = null,
    Object? score = null,
  }) {
    return _then(_$PerformanceAnalyticsImpl(
      employeeId: null == employeeId
          ? _value.employeeId
          : employeeId // ignore: cast_nullable_to_non_nullable
              as String,
      employeeName: null == employeeName
          ? _value.employeeName
          : employeeName // ignore: cast_nullable_to_non_nullable
              as String,
      metrics: null == metrics
          ? _value.metrics
          : metrics // ignore: cast_nullable_to_non_nullable
              as PerformanceMetrics,
      trends: null == trends
          ? _value.trends
          : trends // ignore: cast_nullable_to_non_nullable
              as PerformanceTrend,
      comparison: null == comparison
          ? _value.comparison
          : comparison // ignore: cast_nullable_to_non_nullable
              as PeerComparison,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PerformanceAnalyticsImpl implements _PerformanceAnalytics {
  const _$PerformanceAnalyticsImpl(
      {required this.employeeId,
      required this.employeeName,
      required this.metrics,
      required this.trends,
      required this.comparison,
      required this.score});

  factory _$PerformanceAnalyticsImpl.fromJson(Map<String, dynamic> json) =>
      _$$PerformanceAnalyticsImplFromJson(json);

  @override
  final String employeeId;
  @override
  final String employeeName;
  @override
  final PerformanceMetrics metrics;
  @override
  final PerformanceTrend trends;
  @override
  final PeerComparison comparison;
  @override
  final double score;

  @override
  String toString() {
    return 'PerformanceAnalytics(employeeId: $employeeId, employeeName: $employeeName, metrics: $metrics, trends: $trends, comparison: $comparison, score: $score)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PerformanceAnalyticsImpl &&
            (identical(other.employeeId, employeeId) ||
                other.employeeId == employeeId) &&
            (identical(other.employeeName, employeeName) ||
                other.employeeName == employeeName) &&
            (identical(other.metrics, metrics) || other.metrics == metrics) &&
            (identical(other.trends, trends) || other.trends == trends) &&
            (identical(other.comparison, comparison) ||
                other.comparison == comparison) &&
            (identical(other.score, score) || other.score == score));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, employeeId, employeeName,
      metrics, trends, comparison, score);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PerformanceAnalyticsImplCopyWith<_$PerformanceAnalyticsImpl>
      get copyWith =>
          __$$PerformanceAnalyticsImplCopyWithImpl<_$PerformanceAnalyticsImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PerformanceAnalyticsImplToJson(
      this,
    );
  }
}

abstract class _PerformanceAnalytics implements PerformanceAnalytics {
  const factory _PerformanceAnalytics(
      {required final String employeeId,
      required final String employeeName,
      required final PerformanceMetrics metrics,
      required final PerformanceTrend trends,
      required final PeerComparison comparison,
      required final double score}) = _$PerformanceAnalyticsImpl;

  factory _PerformanceAnalytics.fromJson(Map<String, dynamic> json) =
      _$PerformanceAnalyticsImpl.fromJson;

  @override
  String get employeeId;
  @override
  String get employeeName;
  @override
  PerformanceMetrics get metrics;
  @override
  PerformanceTrend get trends;
  @override
  PeerComparison get comparison;
  @override
  double get score;
  @override
  @JsonKey(ignore: true)
  _$$PerformanceAnalyticsImplCopyWith<_$PerformanceAnalyticsImpl>
      get copyWith => throw _privateConstructorUsedError;
}

PerformanceTrend _$PerformanceTrendFromJson(Map<String, dynamic> json) {
  return _PerformanceTrend.fromJson(json);
}

/// @nodoc
mixin _$PerformanceTrend {
  String get direction => throw _privateConstructorUsedError;
  double get growth => throw _privateConstructorUsedError;
  double get volatility => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PerformanceTrendCopyWith<PerformanceTrend> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PerformanceTrendCopyWith<$Res> {
  factory $PerformanceTrendCopyWith(
          PerformanceTrend value, $Res Function(PerformanceTrend) then) =
      _$PerformanceTrendCopyWithImpl<$Res, PerformanceTrend>;
  @useResult
  $Res call({String direction, double growth, double volatility});
}

/// @nodoc
class _$PerformanceTrendCopyWithImpl<$Res, $Val extends PerformanceTrend>
    implements $PerformanceTrendCopyWith<$Res> {
  _$PerformanceTrendCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? direction = null,
    Object? growth = null,
    Object? volatility = null,
  }) {
    return _then(_value.copyWith(
      direction: null == direction
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as String,
      growth: null == growth
          ? _value.growth
          : growth // ignore: cast_nullable_to_non_nullable
              as double,
      volatility: null == volatility
          ? _value.volatility
          : volatility // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PerformanceTrendImplCopyWith<$Res>
    implements $PerformanceTrendCopyWith<$Res> {
  factory _$$PerformanceTrendImplCopyWith(_$PerformanceTrendImpl value,
          $Res Function(_$PerformanceTrendImpl) then) =
      __$$PerformanceTrendImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String direction, double growth, double volatility});
}

/// @nodoc
class __$$PerformanceTrendImplCopyWithImpl<$Res>
    extends _$PerformanceTrendCopyWithImpl<$Res, _$PerformanceTrendImpl>
    implements _$$PerformanceTrendImplCopyWith<$Res> {
  __$$PerformanceTrendImplCopyWithImpl(_$PerformanceTrendImpl _value,
      $Res Function(_$PerformanceTrendImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? direction = null,
    Object? growth = null,
    Object? volatility = null,
  }) {
    return _then(_$PerformanceTrendImpl(
      direction: null == direction
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as String,
      growth: null == growth
          ? _value.growth
          : growth // ignore: cast_nullable_to_non_nullable
              as double,
      volatility: null == volatility
          ? _value.volatility
          : volatility // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PerformanceTrendImpl implements _PerformanceTrend {
  const _$PerformanceTrendImpl(
      {required this.direction,
      required this.growth,
      required this.volatility});

  factory _$PerformanceTrendImpl.fromJson(Map<String, dynamic> json) =>
      _$$PerformanceTrendImplFromJson(json);

  @override
  final String direction;
  @override
  final double growth;
  @override
  final double volatility;

  @override
  String toString() {
    return 'PerformanceTrend(direction: $direction, growth: $growth, volatility: $volatility)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PerformanceTrendImpl &&
            (identical(other.direction, direction) ||
                other.direction == direction) &&
            (identical(other.growth, growth) || other.growth == growth) &&
            (identical(other.volatility, volatility) ||
                other.volatility == volatility));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, direction, growth, volatility);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PerformanceTrendImplCopyWith<_$PerformanceTrendImpl> get copyWith =>
      __$$PerformanceTrendImplCopyWithImpl<_$PerformanceTrendImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PerformanceTrendImplToJson(
      this,
    );
  }
}

abstract class _PerformanceTrend implements PerformanceTrend {
  const factory _PerformanceTrend(
      {required final String direction,
      required final double growth,
      required final double volatility}) = _$PerformanceTrendImpl;

  factory _PerformanceTrend.fromJson(Map<String, dynamic> json) =
      _$PerformanceTrendImpl.fromJson;

  @override
  String get direction;
  @override
  double get growth;
  @override
  double get volatility;
  @override
  @JsonKey(ignore: true)
  _$$PerformanceTrendImplCopyWith<_$PerformanceTrendImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PeerComparison _$PeerComparisonFromJson(Map<String, dynamic> json) {
  return _PeerComparison.fromJson(json);
}

/// @nodoc
mixin _$PeerComparison {
  double get avgPeerScore => throw _privateConstructorUsedError;
  double get percentile => throw _privateConstructorUsedError;
  String get ranking => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PeerComparisonCopyWith<PeerComparison> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PeerComparisonCopyWith<$Res> {
  factory $PeerComparisonCopyWith(
          PeerComparison value, $Res Function(PeerComparison) then) =
      _$PeerComparisonCopyWithImpl<$Res, PeerComparison>;
  @useResult
  $Res call({double avgPeerScore, double percentile, String ranking});
}

/// @nodoc
class _$PeerComparisonCopyWithImpl<$Res, $Val extends PeerComparison>
    implements $PeerComparisonCopyWith<$Res> {
  _$PeerComparisonCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? avgPeerScore = null,
    Object? percentile = null,
    Object? ranking = null,
  }) {
    return _then(_value.copyWith(
      avgPeerScore: null == avgPeerScore
          ? _value.avgPeerScore
          : avgPeerScore // ignore: cast_nullable_to_non_nullable
              as double,
      percentile: null == percentile
          ? _value.percentile
          : percentile // ignore: cast_nullable_to_non_nullable
              as double,
      ranking: null == ranking
          ? _value.ranking
          : ranking // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PeerComparisonImplCopyWith<$Res>
    implements $PeerComparisonCopyWith<$Res> {
  factory _$$PeerComparisonImplCopyWith(_$PeerComparisonImpl value,
          $Res Function(_$PeerComparisonImpl) then) =
      __$$PeerComparisonImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double avgPeerScore, double percentile, String ranking});
}

/// @nodoc
class __$$PeerComparisonImplCopyWithImpl<$Res>
    extends _$PeerComparisonCopyWithImpl<$Res, _$PeerComparisonImpl>
    implements _$$PeerComparisonImplCopyWith<$Res> {
  __$$PeerComparisonImplCopyWithImpl(
      _$PeerComparisonImpl _value, $Res Function(_$PeerComparisonImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? avgPeerScore = null,
    Object? percentile = null,
    Object? ranking = null,
  }) {
    return _then(_$PeerComparisonImpl(
      avgPeerScore: null == avgPeerScore
          ? _value.avgPeerScore
          : avgPeerScore // ignore: cast_nullable_to_non_nullable
              as double,
      percentile: null == percentile
          ? _value.percentile
          : percentile // ignore: cast_nullable_to_non_nullable
              as double,
      ranking: null == ranking
          ? _value.ranking
          : ranking // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PeerComparisonImpl implements _PeerComparison {
  const _$PeerComparisonImpl(
      {required this.avgPeerScore,
      required this.percentile,
      required this.ranking});

  factory _$PeerComparisonImpl.fromJson(Map<String, dynamic> json) =>
      _$$PeerComparisonImplFromJson(json);

  @override
  final double avgPeerScore;
  @override
  final double percentile;
  @override
  final String ranking;

  @override
  String toString() {
    return 'PeerComparison(avgPeerScore: $avgPeerScore, percentile: $percentile, ranking: $ranking)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PeerComparisonImpl &&
            (identical(other.avgPeerScore, avgPeerScore) ||
                other.avgPeerScore == avgPeerScore) &&
            (identical(other.percentile, percentile) ||
                other.percentile == percentile) &&
            (identical(other.ranking, ranking) || other.ranking == ranking));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, avgPeerScore, percentile, ranking);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PeerComparisonImplCopyWith<_$PeerComparisonImpl> get copyWith =>
      __$$PeerComparisonImplCopyWithImpl<_$PeerComparisonImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PeerComparisonImplToJson(
      this,
    );
  }
}

abstract class _PeerComparison implements PeerComparison {
  const factory _PeerComparison(
      {required final double avgPeerScore,
      required final double percentile,
      required final String ranking}) = _$PeerComparisonImpl;

  factory _PeerComparison.fromJson(Map<String, dynamic> json) =
      _$PeerComparisonImpl.fromJson;

  @override
  double get avgPeerScore;
  @override
  double get percentile;
  @override
  String get ranking;
  @override
  @JsonKey(ignore: true)
  _$$PeerComparisonImplCopyWith<_$PeerComparisonImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SkillProficiency _$SkillProficiencyFromJson(Map<String, dynamic> json) {
  return _SkillProficiency.fromJson(json);
}

/// @nodoc
mixin _$SkillProficiency {
  String get skill => throw _privateConstructorUsedError;
  String get level => throw _privateConstructorUsedError;
  List<String> get certifications => throw _privateConstructorUsedError;
  DateTime get lastAssessed => throw _privateConstructorUsedError;
  double get growthRate => throw _privateConstructorUsedError;
  String get recommendation => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SkillProficiencyCopyWith<SkillProficiency> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SkillProficiencyCopyWith<$Res> {
  factory $SkillProficiencyCopyWith(
          SkillProficiency value, $Res Function(SkillProficiency) then) =
      _$SkillProficiencyCopyWithImpl<$Res, SkillProficiency>;
  @useResult
  $Res call(
      {String skill,
      String level,
      List<String> certifications,
      DateTime lastAssessed,
      double growthRate,
      String recommendation});
}

/// @nodoc
class _$SkillProficiencyCopyWithImpl<$Res, $Val extends SkillProficiency>
    implements $SkillProficiencyCopyWith<$Res> {
  _$SkillProficiencyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? skill = null,
    Object? level = null,
    Object? certifications = null,
    Object? lastAssessed = null,
    Object? growthRate = null,
    Object? recommendation = null,
  }) {
    return _then(_value.copyWith(
      skill: null == skill
          ? _value.skill
          : skill // ignore: cast_nullable_to_non_nullable
              as String,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as String,
      certifications: null == certifications
          ? _value.certifications
          : certifications // ignore: cast_nullable_to_non_nullable
              as List<String>,
      lastAssessed: null == lastAssessed
          ? _value.lastAssessed
          : lastAssessed // ignore: cast_nullable_to_non_nullable
              as DateTime,
      growthRate: null == growthRate
          ? _value.growthRate
          : growthRate // ignore: cast_nullable_to_non_nullable
              as double,
      recommendation: null == recommendation
          ? _value.recommendation
          : recommendation // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SkillProficiencyImplCopyWith<$Res>
    implements $SkillProficiencyCopyWith<$Res> {
  factory _$$SkillProficiencyImplCopyWith(_$SkillProficiencyImpl value,
          $Res Function(_$SkillProficiencyImpl) then) =
      __$$SkillProficiencyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String skill,
      String level,
      List<String> certifications,
      DateTime lastAssessed,
      double growthRate,
      String recommendation});
}

/// @nodoc
class __$$SkillProficiencyImplCopyWithImpl<$Res>
    extends _$SkillProficiencyCopyWithImpl<$Res, _$SkillProficiencyImpl>
    implements _$$SkillProficiencyImplCopyWith<$Res> {
  __$$SkillProficiencyImplCopyWithImpl(_$SkillProficiencyImpl _value,
      $Res Function(_$SkillProficiencyImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? skill = null,
    Object? level = null,
    Object? certifications = null,
    Object? lastAssessed = null,
    Object? growthRate = null,
    Object? recommendation = null,
  }) {
    return _then(_$SkillProficiencyImpl(
      skill: null == skill
          ? _value.skill
          : skill // ignore: cast_nullable_to_non_nullable
              as String,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as String,
      certifications: null == certifications
          ? _value._certifications
          : certifications // ignore: cast_nullable_to_non_nullable
              as List<String>,
      lastAssessed: null == lastAssessed
          ? _value.lastAssessed
          : lastAssessed // ignore: cast_nullable_to_non_nullable
              as DateTime,
      growthRate: null == growthRate
          ? _value.growthRate
          : growthRate // ignore: cast_nullable_to_non_nullable
              as double,
      recommendation: null == recommendation
          ? _value.recommendation
          : recommendation // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SkillProficiencyImpl implements _SkillProficiency {
  const _$SkillProficiencyImpl(
      {required this.skill,
      required this.level,
      required final List<String> certifications,
      required this.lastAssessed,
      required this.growthRate,
      required this.recommendation})
      : _certifications = certifications;

  factory _$SkillProficiencyImpl.fromJson(Map<String, dynamic> json) =>
      _$$SkillProficiencyImplFromJson(json);

  @override
  final String skill;
  @override
  final String level;
  final List<String> _certifications;
  @override
  List<String> get certifications {
    if (_certifications is EqualUnmodifiableListView) return _certifications;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_certifications);
  }

  @override
  final DateTime lastAssessed;
  @override
  final double growthRate;
  @override
  final String recommendation;

  @override
  String toString() {
    return 'SkillProficiency(skill: $skill, level: $level, certifications: $certifications, lastAssessed: $lastAssessed, growthRate: $growthRate, recommendation: $recommendation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SkillProficiencyImpl &&
            (identical(other.skill, skill) || other.skill == skill) &&
            (identical(other.level, level) || other.level == level) &&
            const DeepCollectionEquality()
                .equals(other._certifications, _certifications) &&
            (identical(other.lastAssessed, lastAssessed) ||
                other.lastAssessed == lastAssessed) &&
            (identical(other.growthRate, growthRate) ||
                other.growthRate == growthRate) &&
            (identical(other.recommendation, recommendation) ||
                other.recommendation == recommendation));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      skill,
      level,
      const DeepCollectionEquality().hash(_certifications),
      lastAssessed,
      growthRate,
      recommendation);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SkillProficiencyImplCopyWith<_$SkillProficiencyImpl> get copyWith =>
      __$$SkillProficiencyImplCopyWithImpl<_$SkillProficiencyImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SkillProficiencyImplToJson(
      this,
    );
  }
}

abstract class _SkillProficiency implements SkillProficiency {
  const factory _SkillProficiency(
      {required final String skill,
      required final String level,
      required final List<String> certifications,
      required final DateTime lastAssessed,
      required final double growthRate,
      required final String recommendation}) = _$SkillProficiencyImpl;

  factory _SkillProficiency.fromJson(Map<String, dynamic> json) =
      _$SkillProficiencyImpl.fromJson;

  @override
  String get skill;
  @override
  String get level;
  @override
  List<String> get certifications;
  @override
  DateTime get lastAssessed;
  @override
  double get growthRate;
  @override
  String get recommendation;
  @override
  @JsonKey(ignore: true)
  _$$SkillProficiencyImplCopyWith<_$SkillProficiencyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

QualityScore _$QualityScoreFromJson(Map<String, dynamic> json) {
  return _QualityScore.fromJson(json);
}

/// @nodoc
mixin _$QualityScore {
  String get appointmentId => throw _privateConstructorUsedError;
  double get overallScore => throw _privateConstructorUsedError;
  QualityFactors get factors => throw _privateConstructorUsedError;
  String get grade => throw _privateConstructorUsedError;
  List<QualityIssue> get issues => throw _privateConstructorUsedError;
  List<String> get recommendations => throw _privateConstructorUsedError;
  DateTime get assessedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $QualityScoreCopyWith<QualityScore> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QualityScoreCopyWith<$Res> {
  factory $QualityScoreCopyWith(
          QualityScore value, $Res Function(QualityScore) then) =
      _$QualityScoreCopyWithImpl<$Res, QualityScore>;
  @useResult
  $Res call(
      {String appointmentId,
      double overallScore,
      QualityFactors factors,
      String grade,
      List<QualityIssue> issues,
      List<String> recommendations,
      DateTime assessedAt});

  $QualityFactorsCopyWith<$Res> get factors;
}

/// @nodoc
class _$QualityScoreCopyWithImpl<$Res, $Val extends QualityScore>
    implements $QualityScoreCopyWith<$Res> {
  _$QualityScoreCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appointmentId = null,
    Object? overallScore = null,
    Object? factors = null,
    Object? grade = null,
    Object? issues = null,
    Object? recommendations = null,
    Object? assessedAt = null,
  }) {
    return _then(_value.copyWith(
      appointmentId: null == appointmentId
          ? _value.appointmentId
          : appointmentId // ignore: cast_nullable_to_non_nullable
              as String,
      overallScore: null == overallScore
          ? _value.overallScore
          : overallScore // ignore: cast_nullable_to_non_nullable
              as double,
      factors: null == factors
          ? _value.factors
          : factors // ignore: cast_nullable_to_non_nullable
              as QualityFactors,
      grade: null == grade
          ? _value.grade
          : grade // ignore: cast_nullable_to_non_nullable
              as String,
      issues: null == issues
          ? _value.issues
          : issues // ignore: cast_nullable_to_non_nullable
              as List<QualityIssue>,
      recommendations: null == recommendations
          ? _value.recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as List<String>,
      assessedAt: null == assessedAt
          ? _value.assessedAt
          : assessedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $QualityFactorsCopyWith<$Res> get factors {
    return $QualityFactorsCopyWith<$Res>(_value.factors, (value) {
      return _then(_value.copyWith(factors: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$QualityScoreImplCopyWith<$Res>
    implements $QualityScoreCopyWith<$Res> {
  factory _$$QualityScoreImplCopyWith(
          _$QualityScoreImpl value, $Res Function(_$QualityScoreImpl) then) =
      __$$QualityScoreImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String appointmentId,
      double overallScore,
      QualityFactors factors,
      String grade,
      List<QualityIssue> issues,
      List<String> recommendations,
      DateTime assessedAt});

  @override
  $QualityFactorsCopyWith<$Res> get factors;
}

/// @nodoc
class __$$QualityScoreImplCopyWithImpl<$Res>
    extends _$QualityScoreCopyWithImpl<$Res, _$QualityScoreImpl>
    implements _$$QualityScoreImplCopyWith<$Res> {
  __$$QualityScoreImplCopyWithImpl(
      _$QualityScoreImpl _value, $Res Function(_$QualityScoreImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appointmentId = null,
    Object? overallScore = null,
    Object? factors = null,
    Object? grade = null,
    Object? issues = null,
    Object? recommendations = null,
    Object? assessedAt = null,
  }) {
    return _then(_$QualityScoreImpl(
      appointmentId: null == appointmentId
          ? _value.appointmentId
          : appointmentId // ignore: cast_nullable_to_non_nullable
              as String,
      overallScore: null == overallScore
          ? _value.overallScore
          : overallScore // ignore: cast_nullable_to_non_nullable
              as double,
      factors: null == factors
          ? _value.factors
          : factors // ignore: cast_nullable_to_non_nullable
              as QualityFactors,
      grade: null == grade
          ? _value.grade
          : grade // ignore: cast_nullable_to_non_nullable
              as String,
      issues: null == issues
          ? _value._issues
          : issues // ignore: cast_nullable_to_non_nullable
              as List<QualityIssue>,
      recommendations: null == recommendations
          ? _value._recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as List<String>,
      assessedAt: null == assessedAt
          ? _value.assessedAt
          : assessedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$QualityScoreImpl implements _QualityScore {
  const _$QualityScoreImpl(
      {required this.appointmentId,
      required this.overallScore,
      required this.factors,
      required this.grade,
      required final List<QualityIssue> issues,
      required final List<String> recommendations,
      required this.assessedAt})
      : _issues = issues,
        _recommendations = recommendations;

  factory _$QualityScoreImpl.fromJson(Map<String, dynamic> json) =>
      _$$QualityScoreImplFromJson(json);

  @override
  final String appointmentId;
  @override
  final double overallScore;
  @override
  final QualityFactors factors;
  @override
  final String grade;
  final List<QualityIssue> _issues;
  @override
  List<QualityIssue> get issues {
    if (_issues is EqualUnmodifiableListView) return _issues;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_issues);
  }

  final List<String> _recommendations;
  @override
  List<String> get recommendations {
    if (_recommendations is EqualUnmodifiableListView) return _recommendations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recommendations);
  }

  @override
  final DateTime assessedAt;

  @override
  String toString() {
    return 'QualityScore(appointmentId: $appointmentId, overallScore: $overallScore, factors: $factors, grade: $grade, issues: $issues, recommendations: $recommendations, assessedAt: $assessedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QualityScoreImpl &&
            (identical(other.appointmentId, appointmentId) ||
                other.appointmentId == appointmentId) &&
            (identical(other.overallScore, overallScore) ||
                other.overallScore == overallScore) &&
            (identical(other.factors, factors) || other.factors == factors) &&
            (identical(other.grade, grade) || other.grade == grade) &&
            const DeepCollectionEquality().equals(other._issues, _issues) &&
            const DeepCollectionEquality()
                .equals(other._recommendations, _recommendations) &&
            (identical(other.assessedAt, assessedAt) ||
                other.assessedAt == assessedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      appointmentId,
      overallScore,
      factors,
      grade,
      const DeepCollectionEquality().hash(_issues),
      const DeepCollectionEquality().hash(_recommendations),
      assessedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$QualityScoreImplCopyWith<_$QualityScoreImpl> get copyWith =>
      __$$QualityScoreImplCopyWithImpl<_$QualityScoreImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QualityScoreImplToJson(
      this,
    );
  }
}

abstract class _QualityScore implements QualityScore {
  const factory _QualityScore(
      {required final String appointmentId,
      required final double overallScore,
      required final QualityFactors factors,
      required final String grade,
      required final List<QualityIssue> issues,
      required final List<String> recommendations,
      required final DateTime assessedAt}) = _$QualityScoreImpl;

  factory _QualityScore.fromJson(Map<String, dynamic> json) =
      _$QualityScoreImpl.fromJson;

  @override
  String get appointmentId;
  @override
  double get overallScore;
  @override
  QualityFactors get factors;
  @override
  String get grade;
  @override
  List<QualityIssue> get issues;
  @override
  List<String> get recommendations;
  @override
  DateTime get assessedAt;
  @override
  @JsonKey(ignore: true)
  _$$QualityScoreImplCopyWith<_$QualityScoreImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

QualityFactors _$QualityFactorsFromJson(Map<String, dynamic> json) {
  return _QualityFactors.fromJson(json);
}

/// @nodoc
mixin _$QualityFactors {
  double get punctuality => throw _privateConstructorUsedError;
  double get completion => throw _privateConstructorUsedError;
  double get clientSatisfaction => throw _privateConstructorUsedError;
  double get documentation => throw _privateConstructorUsedError;
  double get compliance => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $QualityFactorsCopyWith<QualityFactors> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QualityFactorsCopyWith<$Res> {
  factory $QualityFactorsCopyWith(
          QualityFactors value, $Res Function(QualityFactors) then) =
      _$QualityFactorsCopyWithImpl<$Res, QualityFactors>;
  @useResult
  $Res call(
      {double punctuality,
      double completion,
      double clientSatisfaction,
      double documentation,
      double compliance});
}

/// @nodoc
class _$QualityFactorsCopyWithImpl<$Res, $Val extends QualityFactors>
    implements $QualityFactorsCopyWith<$Res> {
  _$QualityFactorsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? punctuality = null,
    Object? completion = null,
    Object? clientSatisfaction = null,
    Object? documentation = null,
    Object? compliance = null,
  }) {
    return _then(_value.copyWith(
      punctuality: null == punctuality
          ? _value.punctuality
          : punctuality // ignore: cast_nullable_to_non_nullable
              as double,
      completion: null == completion
          ? _value.completion
          : completion // ignore: cast_nullable_to_non_nullable
              as double,
      clientSatisfaction: null == clientSatisfaction
          ? _value.clientSatisfaction
          : clientSatisfaction // ignore: cast_nullable_to_non_nullable
              as double,
      documentation: null == documentation
          ? _value.documentation
          : documentation // ignore: cast_nullable_to_non_nullable
              as double,
      compliance: null == compliance
          ? _value.compliance
          : compliance // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$QualityFactorsImplCopyWith<$Res>
    implements $QualityFactorsCopyWith<$Res> {
  factory _$$QualityFactorsImplCopyWith(_$QualityFactorsImpl value,
          $Res Function(_$QualityFactorsImpl) then) =
      __$$QualityFactorsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double punctuality,
      double completion,
      double clientSatisfaction,
      double documentation,
      double compliance});
}

/// @nodoc
class __$$QualityFactorsImplCopyWithImpl<$Res>
    extends _$QualityFactorsCopyWithImpl<$Res, _$QualityFactorsImpl>
    implements _$$QualityFactorsImplCopyWith<$Res> {
  __$$QualityFactorsImplCopyWithImpl(
      _$QualityFactorsImpl _value, $Res Function(_$QualityFactorsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? punctuality = null,
    Object? completion = null,
    Object? clientSatisfaction = null,
    Object? documentation = null,
    Object? compliance = null,
  }) {
    return _then(_$QualityFactorsImpl(
      punctuality: null == punctuality
          ? _value.punctuality
          : punctuality // ignore: cast_nullable_to_non_nullable
              as double,
      completion: null == completion
          ? _value.completion
          : completion // ignore: cast_nullable_to_non_nullable
              as double,
      clientSatisfaction: null == clientSatisfaction
          ? _value.clientSatisfaction
          : clientSatisfaction // ignore: cast_nullable_to_non_nullable
              as double,
      documentation: null == documentation
          ? _value.documentation
          : documentation // ignore: cast_nullable_to_non_nullable
              as double,
      compliance: null == compliance
          ? _value.compliance
          : compliance // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$QualityFactorsImpl implements _QualityFactors {
  const _$QualityFactorsImpl(
      {required this.punctuality,
      required this.completion,
      required this.clientSatisfaction,
      required this.documentation,
      required this.compliance});

  factory _$QualityFactorsImpl.fromJson(Map<String, dynamic> json) =>
      _$$QualityFactorsImplFromJson(json);

  @override
  final double punctuality;
  @override
  final double completion;
  @override
  final double clientSatisfaction;
  @override
  final double documentation;
  @override
  final double compliance;

  @override
  String toString() {
    return 'QualityFactors(punctuality: $punctuality, completion: $completion, clientSatisfaction: $clientSatisfaction, documentation: $documentation, compliance: $compliance)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QualityFactorsImpl &&
            (identical(other.punctuality, punctuality) ||
                other.punctuality == punctuality) &&
            (identical(other.completion, completion) ||
                other.completion == completion) &&
            (identical(other.clientSatisfaction, clientSatisfaction) ||
                other.clientSatisfaction == clientSatisfaction) &&
            (identical(other.documentation, documentation) ||
                other.documentation == documentation) &&
            (identical(other.compliance, compliance) ||
                other.compliance == compliance));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, punctuality, completion,
      clientSatisfaction, documentation, compliance);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$QualityFactorsImplCopyWith<_$QualityFactorsImpl> get copyWith =>
      __$$QualityFactorsImplCopyWithImpl<_$QualityFactorsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QualityFactorsImplToJson(
      this,
    );
  }
}

abstract class _QualityFactors implements QualityFactors {
  const factory _QualityFactors(
      {required final double punctuality,
      required final double completion,
      required final double clientSatisfaction,
      required final double documentation,
      required final double compliance}) = _$QualityFactorsImpl;

  factory _QualityFactors.fromJson(Map<String, dynamic> json) =
      _$QualityFactorsImpl.fromJson;

  @override
  double get punctuality;
  @override
  double get completion;
  @override
  double get clientSatisfaction;
  @override
  double get documentation;
  @override
  double get compliance;
  @override
  @JsonKey(ignore: true)
  _$$QualityFactorsImplCopyWith<_$QualityFactorsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

QualityIssue _$QualityIssueFromJson(Map<String, dynamic> json) {
  return _QualityIssue.fromJson(json);
}

/// @nodoc
mixin _$QualityIssue {
  String get type => throw _privateConstructorUsedError;
  String get severity => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $QualityIssueCopyWith<QualityIssue> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QualityIssueCopyWith<$Res> {
  factory $QualityIssueCopyWith(
          QualityIssue value, $Res Function(QualityIssue) then) =
      _$QualityIssueCopyWithImpl<$Res, QualityIssue>;
  @useResult
  $Res call({String type, String severity, String message});
}

/// @nodoc
class _$QualityIssueCopyWithImpl<$Res, $Val extends QualityIssue>
    implements $QualityIssueCopyWith<$Res> {
  _$QualityIssueCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? severity = null,
    Object? message = null,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      severity: null == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$QualityIssueImplCopyWith<$Res>
    implements $QualityIssueCopyWith<$Res> {
  factory _$$QualityIssueImplCopyWith(
          _$QualityIssueImpl value, $Res Function(_$QualityIssueImpl) then) =
      __$$QualityIssueImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String type, String severity, String message});
}

/// @nodoc
class __$$QualityIssueImplCopyWithImpl<$Res>
    extends _$QualityIssueCopyWithImpl<$Res, _$QualityIssueImpl>
    implements _$$QualityIssueImplCopyWith<$Res> {
  __$$QualityIssueImplCopyWithImpl(
      _$QualityIssueImpl _value, $Res Function(_$QualityIssueImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? severity = null,
    Object? message = null,
  }) {
    return _then(_$QualityIssueImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      severity: null == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$QualityIssueImpl implements _QualityIssue {
  const _$QualityIssueImpl(
      {required this.type, required this.severity, required this.message});

  factory _$QualityIssueImpl.fromJson(Map<String, dynamic> json) =>
      _$$QualityIssueImplFromJson(json);

  @override
  final String type;
  @override
  final String severity;
  @override
  final String message;

  @override
  String toString() {
    return 'QualityIssue(type: $type, severity: $severity, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QualityIssueImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.severity, severity) ||
                other.severity == severity) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, type, severity, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$QualityIssueImplCopyWith<_$QualityIssueImpl> get copyWith =>
      __$$QualityIssueImplCopyWithImpl<_$QualityIssueImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QualityIssueImplToJson(
      this,
    );
  }
}

abstract class _QualityIssue implements QualityIssue {
  const factory _QualityIssue(
      {required final String type,
      required final String severity,
      required final String message}) = _$QualityIssueImpl;

  factory _QualityIssue.fromJson(Map<String, dynamic> json) =
      _$QualityIssueImpl.fromJson;

  @override
  String get type;
  @override
  String get severity;
  @override
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$QualityIssueImplCopyWith<_$QualityIssueImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ComplianceCheck _$ComplianceCheckFromJson(Map<String, dynamic> json) {
  return _ComplianceCheck.fromJson(json);
}

/// @nodoc
mixin _$ComplianceCheck {
  String get appointmentId => throw _privateConstructorUsedError;
  Map<String, ComplianceResult> get checks =>
      throw _privateConstructorUsedError;
  bool get compliant => throw _privateConstructorUsedError;
  List<ComplianceViolation> get violations =>
      throw _privateConstructorUsedError;
  String get riskLevel => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ComplianceCheckCopyWith<ComplianceCheck> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ComplianceCheckCopyWith<$Res> {
  factory $ComplianceCheckCopyWith(
          ComplianceCheck value, $Res Function(ComplianceCheck) then) =
      _$ComplianceCheckCopyWithImpl<$Res, ComplianceCheck>;
  @useResult
  $Res call(
      {String appointmentId,
      Map<String, ComplianceResult> checks,
      bool compliant,
      List<ComplianceViolation> violations,
      String riskLevel});
}

/// @nodoc
class _$ComplianceCheckCopyWithImpl<$Res, $Val extends ComplianceCheck>
    implements $ComplianceCheckCopyWith<$Res> {
  _$ComplianceCheckCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appointmentId = null,
    Object? checks = null,
    Object? compliant = null,
    Object? violations = null,
    Object? riskLevel = null,
  }) {
    return _then(_value.copyWith(
      appointmentId: null == appointmentId
          ? _value.appointmentId
          : appointmentId // ignore: cast_nullable_to_non_nullable
              as String,
      checks: null == checks
          ? _value.checks
          : checks // ignore: cast_nullable_to_non_nullable
              as Map<String, ComplianceResult>,
      compliant: null == compliant
          ? _value.compliant
          : compliant // ignore: cast_nullable_to_non_nullable
              as bool,
      violations: null == violations
          ? _value.violations
          : violations // ignore: cast_nullable_to_non_nullable
              as List<ComplianceViolation>,
      riskLevel: null == riskLevel
          ? _value.riskLevel
          : riskLevel // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ComplianceCheckImplCopyWith<$Res>
    implements $ComplianceCheckCopyWith<$Res> {
  factory _$$ComplianceCheckImplCopyWith(_$ComplianceCheckImpl value,
          $Res Function(_$ComplianceCheckImpl) then) =
      __$$ComplianceCheckImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String appointmentId,
      Map<String, ComplianceResult> checks,
      bool compliant,
      List<ComplianceViolation> violations,
      String riskLevel});
}

/// @nodoc
class __$$ComplianceCheckImplCopyWithImpl<$Res>
    extends _$ComplianceCheckCopyWithImpl<$Res, _$ComplianceCheckImpl>
    implements _$$ComplianceCheckImplCopyWith<$Res> {
  __$$ComplianceCheckImplCopyWithImpl(
      _$ComplianceCheckImpl _value, $Res Function(_$ComplianceCheckImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appointmentId = null,
    Object? checks = null,
    Object? compliant = null,
    Object? violations = null,
    Object? riskLevel = null,
  }) {
    return _then(_$ComplianceCheckImpl(
      appointmentId: null == appointmentId
          ? _value.appointmentId
          : appointmentId // ignore: cast_nullable_to_non_nullable
              as String,
      checks: null == checks
          ? _value._checks
          : checks // ignore: cast_nullable_to_non_nullable
              as Map<String, ComplianceResult>,
      compliant: null == compliant
          ? _value.compliant
          : compliant // ignore: cast_nullable_to_non_nullable
              as bool,
      violations: null == violations
          ? _value._violations
          : violations // ignore: cast_nullable_to_non_nullable
              as List<ComplianceViolation>,
      riskLevel: null == riskLevel
          ? _value.riskLevel
          : riskLevel // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ComplianceCheckImpl implements _ComplianceCheck {
  const _$ComplianceCheckImpl(
      {required this.appointmentId,
      required final Map<String, ComplianceResult> checks,
      required this.compliant,
      required final List<ComplianceViolation> violations,
      required this.riskLevel})
      : _checks = checks,
        _violations = violations;

  factory _$ComplianceCheckImpl.fromJson(Map<String, dynamic> json) =>
      _$$ComplianceCheckImplFromJson(json);

  @override
  final String appointmentId;
  final Map<String, ComplianceResult> _checks;
  @override
  Map<String, ComplianceResult> get checks {
    if (_checks is EqualUnmodifiableMapView) return _checks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_checks);
  }

  @override
  final bool compliant;
  final List<ComplianceViolation> _violations;
  @override
  List<ComplianceViolation> get violations {
    if (_violations is EqualUnmodifiableListView) return _violations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_violations);
  }

  @override
  final String riskLevel;

  @override
  String toString() {
    return 'ComplianceCheck(appointmentId: $appointmentId, checks: $checks, compliant: $compliant, violations: $violations, riskLevel: $riskLevel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ComplianceCheckImpl &&
            (identical(other.appointmentId, appointmentId) ||
                other.appointmentId == appointmentId) &&
            const DeepCollectionEquality().equals(other._checks, _checks) &&
            (identical(other.compliant, compliant) ||
                other.compliant == compliant) &&
            const DeepCollectionEquality()
                .equals(other._violations, _violations) &&
            (identical(other.riskLevel, riskLevel) ||
                other.riskLevel == riskLevel));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      appointmentId,
      const DeepCollectionEquality().hash(_checks),
      compliant,
      const DeepCollectionEquality().hash(_violations),
      riskLevel);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ComplianceCheckImplCopyWith<_$ComplianceCheckImpl> get copyWith =>
      __$$ComplianceCheckImplCopyWithImpl<_$ComplianceCheckImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ComplianceCheckImplToJson(
      this,
    );
  }
}

abstract class _ComplianceCheck implements ComplianceCheck {
  const factory _ComplianceCheck(
      {required final String appointmentId,
      required final Map<String, ComplianceResult> checks,
      required final bool compliant,
      required final List<ComplianceViolation> violations,
      required final String riskLevel}) = _$ComplianceCheckImpl;

  factory _ComplianceCheck.fromJson(Map<String, dynamic> json) =
      _$ComplianceCheckImpl.fromJson;

  @override
  String get appointmentId;
  @override
  Map<String, ComplianceResult> get checks;
  @override
  bool get compliant;
  @override
  List<ComplianceViolation> get violations;
  @override
  String get riskLevel;
  @override
  @JsonKey(ignore: true)
  _$$ComplianceCheckImplCopyWith<_$ComplianceCheckImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ComplianceResult _$ComplianceResultFromJson(Map<String, dynamic> json) {
  return _ComplianceResult.fromJson(json);
}

/// @nodoc
mixin _$ComplianceResult {
  bool get passed => throw _privateConstructorUsedError;
  String? get reason => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ComplianceResultCopyWith<ComplianceResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ComplianceResultCopyWith<$Res> {
  factory $ComplianceResultCopyWith(
          ComplianceResult value, $Res Function(ComplianceResult) then) =
      _$ComplianceResultCopyWithImpl<$Res, ComplianceResult>;
  @useResult
  $Res call({bool passed, String? reason});
}

/// @nodoc
class _$ComplianceResultCopyWithImpl<$Res, $Val extends ComplianceResult>
    implements $ComplianceResultCopyWith<$Res> {
  _$ComplianceResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? passed = null,
    Object? reason = freezed,
  }) {
    return _then(_value.copyWith(
      passed: null == passed
          ? _value.passed
          : passed // ignore: cast_nullable_to_non_nullable
              as bool,
      reason: freezed == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ComplianceResultImplCopyWith<$Res>
    implements $ComplianceResultCopyWith<$Res> {
  factory _$$ComplianceResultImplCopyWith(_$ComplianceResultImpl value,
          $Res Function(_$ComplianceResultImpl) then) =
      __$$ComplianceResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool passed, String? reason});
}

/// @nodoc
class __$$ComplianceResultImplCopyWithImpl<$Res>
    extends _$ComplianceResultCopyWithImpl<$Res, _$ComplianceResultImpl>
    implements _$$ComplianceResultImplCopyWith<$Res> {
  __$$ComplianceResultImplCopyWithImpl(_$ComplianceResultImpl _value,
      $Res Function(_$ComplianceResultImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? passed = null,
    Object? reason = freezed,
  }) {
    return _then(_$ComplianceResultImpl(
      passed: null == passed
          ? _value.passed
          : passed // ignore: cast_nullable_to_non_nullable
              as bool,
      reason: freezed == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ComplianceResultImpl implements _ComplianceResult {
  const _$ComplianceResultImpl({required this.passed, this.reason});

  factory _$ComplianceResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$ComplianceResultImplFromJson(json);

  @override
  final bool passed;
  @override
  final String? reason;

  @override
  String toString() {
    return 'ComplianceResult(passed: $passed, reason: $reason)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ComplianceResultImpl &&
            (identical(other.passed, passed) || other.passed == passed) &&
            (identical(other.reason, reason) || other.reason == reason));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, passed, reason);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ComplianceResultImplCopyWith<_$ComplianceResultImpl> get copyWith =>
      __$$ComplianceResultImplCopyWithImpl<_$ComplianceResultImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ComplianceResultImplToJson(
      this,
    );
  }
}

abstract class _ComplianceResult implements ComplianceResult {
  const factory _ComplianceResult(
      {required final bool passed,
      final String? reason}) = _$ComplianceResultImpl;

  factory _ComplianceResult.fromJson(Map<String, dynamic> json) =
      _$ComplianceResultImpl.fromJson;

  @override
  bool get passed;
  @override
  String? get reason;
  @override
  @JsonKey(ignore: true)
  _$$ComplianceResultImplCopyWith<_$ComplianceResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ComplianceViolation _$ComplianceViolationFromJson(Map<String, dynamic> json) {
  return _ComplianceViolation.fromJson(json);
}

/// @nodoc
mixin _$ComplianceViolation {
  String get check => throw _privateConstructorUsedError;
  String get reason => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ComplianceViolationCopyWith<ComplianceViolation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ComplianceViolationCopyWith<$Res> {
  factory $ComplianceViolationCopyWith(
          ComplianceViolation value, $Res Function(ComplianceViolation) then) =
      _$ComplianceViolationCopyWithImpl<$Res, ComplianceViolation>;
  @useResult
  $Res call({String check, String reason});
}

/// @nodoc
class _$ComplianceViolationCopyWithImpl<$Res, $Val extends ComplianceViolation>
    implements $ComplianceViolationCopyWith<$Res> {
  _$ComplianceViolationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? check = null,
    Object? reason = null,
  }) {
    return _then(_value.copyWith(
      check: null == check
          ? _value.check
          : check // ignore: cast_nullable_to_non_nullable
              as String,
      reason: null == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ComplianceViolationImplCopyWith<$Res>
    implements $ComplianceViolationCopyWith<$Res> {
  factory _$$ComplianceViolationImplCopyWith(_$ComplianceViolationImpl value,
          $Res Function(_$ComplianceViolationImpl) then) =
      __$$ComplianceViolationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String check, String reason});
}

/// @nodoc
class __$$ComplianceViolationImplCopyWithImpl<$Res>
    extends _$ComplianceViolationCopyWithImpl<$Res, _$ComplianceViolationImpl>
    implements _$$ComplianceViolationImplCopyWith<$Res> {
  __$$ComplianceViolationImplCopyWithImpl(_$ComplianceViolationImpl _value,
      $Res Function(_$ComplianceViolationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? check = null,
    Object? reason = null,
  }) {
    return _then(_$ComplianceViolationImpl(
      check: null == check
          ? _value.check
          : check // ignore: cast_nullable_to_non_nullable
              as String,
      reason: null == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ComplianceViolationImpl implements _ComplianceViolation {
  const _$ComplianceViolationImpl({required this.check, required this.reason});

  factory _$ComplianceViolationImpl.fromJson(Map<String, dynamic> json) =>
      _$$ComplianceViolationImplFromJson(json);

  @override
  final String check;
  @override
  final String reason;

  @override
  String toString() {
    return 'ComplianceViolation(check: $check, reason: $reason)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ComplianceViolationImpl &&
            (identical(other.check, check) || other.check == check) &&
            (identical(other.reason, reason) || other.reason == reason));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, check, reason);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ComplianceViolationImplCopyWith<_$ComplianceViolationImpl> get copyWith =>
      __$$ComplianceViolationImplCopyWithImpl<_$ComplianceViolationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ComplianceViolationImplToJson(
      this,
    );
  }
}

abstract class _ComplianceViolation implements ComplianceViolation {
  const factory _ComplianceViolation(
      {required final String check,
      required final String reason}) = _$ComplianceViolationImpl;

  factory _ComplianceViolation.fromJson(Map<String, dynamic> json) =
      _$ComplianceViolationImpl.fromJson;

  @override
  String get check;
  @override
  String get reason;
  @override
  @JsonKey(ignore: true)
  _$$ComplianceViolationImplCopyWith<_$ComplianceViolationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SentimentAnalysis _$SentimentAnalysisFromJson(Map<String, dynamic> json) {
  return _SentimentAnalysis.fromJson(json);
}

/// @nodoc
mixin _$SentimentAnalysis {
  String get appointmentId => throw _privateConstructorUsedError;
  String get feedback => throw _privateConstructorUsedError;
  String get sentiment => throw _privateConstructorUsedError;
  double get score => throw _privateConstructorUsedError;
  double get confidence => throw _privateConstructorUsedError;
  List<String> get keywords => throw _privateConstructorUsedError;
  List<String> get topics => throw _privateConstructorUsedError;
  double get rating => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SentimentAnalysisCopyWith<SentimentAnalysis> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SentimentAnalysisCopyWith<$Res> {
  factory $SentimentAnalysisCopyWith(
          SentimentAnalysis value, $Res Function(SentimentAnalysis) then) =
      _$SentimentAnalysisCopyWithImpl<$Res, SentimentAnalysis>;
  @useResult
  $Res call(
      {String appointmentId,
      String feedback,
      String sentiment,
      double score,
      double confidence,
      List<String> keywords,
      List<String> topics,
      double rating});
}

/// @nodoc
class _$SentimentAnalysisCopyWithImpl<$Res, $Val extends SentimentAnalysis>
    implements $SentimentAnalysisCopyWith<$Res> {
  _$SentimentAnalysisCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appointmentId = null,
    Object? feedback = null,
    Object? sentiment = null,
    Object? score = null,
    Object? confidence = null,
    Object? keywords = null,
    Object? topics = null,
    Object? rating = null,
  }) {
    return _then(_value.copyWith(
      appointmentId: null == appointmentId
          ? _value.appointmentId
          : appointmentId // ignore: cast_nullable_to_non_nullable
              as String,
      feedback: null == feedback
          ? _value.feedback
          : feedback // ignore: cast_nullable_to_non_nullable
              as String,
      sentiment: null == sentiment
          ? _value.sentiment
          : sentiment // ignore: cast_nullable_to_non_nullable
              as String,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as double,
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
      keywords: null == keywords
          ? _value.keywords
          : keywords // ignore: cast_nullable_to_non_nullable
              as List<String>,
      topics: null == topics
          ? _value.topics
          : topics // ignore: cast_nullable_to_non_nullable
              as List<String>,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SentimentAnalysisImplCopyWith<$Res>
    implements $SentimentAnalysisCopyWith<$Res> {
  factory _$$SentimentAnalysisImplCopyWith(_$SentimentAnalysisImpl value,
          $Res Function(_$SentimentAnalysisImpl) then) =
      __$$SentimentAnalysisImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String appointmentId,
      String feedback,
      String sentiment,
      double score,
      double confidence,
      List<String> keywords,
      List<String> topics,
      double rating});
}

/// @nodoc
class __$$SentimentAnalysisImplCopyWithImpl<$Res>
    extends _$SentimentAnalysisCopyWithImpl<$Res, _$SentimentAnalysisImpl>
    implements _$$SentimentAnalysisImplCopyWith<$Res> {
  __$$SentimentAnalysisImplCopyWithImpl(_$SentimentAnalysisImpl _value,
      $Res Function(_$SentimentAnalysisImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appointmentId = null,
    Object? feedback = null,
    Object? sentiment = null,
    Object? score = null,
    Object? confidence = null,
    Object? keywords = null,
    Object? topics = null,
    Object? rating = null,
  }) {
    return _then(_$SentimentAnalysisImpl(
      appointmentId: null == appointmentId
          ? _value.appointmentId
          : appointmentId // ignore: cast_nullable_to_non_nullable
              as String,
      feedback: null == feedback
          ? _value.feedback
          : feedback // ignore: cast_nullable_to_non_nullable
              as String,
      sentiment: null == sentiment
          ? _value.sentiment
          : sentiment // ignore: cast_nullable_to_non_nullable
              as String,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as double,
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
      keywords: null == keywords
          ? _value._keywords
          : keywords // ignore: cast_nullable_to_non_nullable
              as List<String>,
      topics: null == topics
          ? _value._topics
          : topics // ignore: cast_nullable_to_non_nullable
              as List<String>,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SentimentAnalysisImpl implements _SentimentAnalysis {
  const _$SentimentAnalysisImpl(
      {required this.appointmentId,
      required this.feedback,
      required this.sentiment,
      required this.score,
      required this.confidence,
      required final List<String> keywords,
      required final List<String> topics,
      required this.rating})
      : _keywords = keywords,
        _topics = topics;

  factory _$SentimentAnalysisImpl.fromJson(Map<String, dynamic> json) =>
      _$$SentimentAnalysisImplFromJson(json);

  @override
  final String appointmentId;
  @override
  final String feedback;
  @override
  final String sentiment;
  @override
  final double score;
  @override
  final double confidence;
  final List<String> _keywords;
  @override
  List<String> get keywords {
    if (_keywords is EqualUnmodifiableListView) return _keywords;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_keywords);
  }

  final List<String> _topics;
  @override
  List<String> get topics {
    if (_topics is EqualUnmodifiableListView) return _topics;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_topics);
  }

  @override
  final double rating;

  @override
  String toString() {
    return 'SentimentAnalysis(appointmentId: $appointmentId, feedback: $feedback, sentiment: $sentiment, score: $score, confidence: $confidence, keywords: $keywords, topics: $topics, rating: $rating)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SentimentAnalysisImpl &&
            (identical(other.appointmentId, appointmentId) ||
                other.appointmentId == appointmentId) &&
            (identical(other.feedback, feedback) ||
                other.feedback == feedback) &&
            (identical(other.sentiment, sentiment) ||
                other.sentiment == sentiment) &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence) &&
            const DeepCollectionEquality().equals(other._keywords, _keywords) &&
            const DeepCollectionEquality().equals(other._topics, _topics) &&
            (identical(other.rating, rating) || other.rating == rating));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      appointmentId,
      feedback,
      sentiment,
      score,
      confidence,
      const DeepCollectionEquality().hash(_keywords),
      const DeepCollectionEquality().hash(_topics),
      rating);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SentimentAnalysisImplCopyWith<_$SentimentAnalysisImpl> get copyWith =>
      __$$SentimentAnalysisImplCopyWithImpl<_$SentimentAnalysisImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SentimentAnalysisImplToJson(
      this,
    );
  }
}

abstract class _SentimentAnalysis implements SentimentAnalysis {
  const factory _SentimentAnalysis(
      {required final String appointmentId,
      required final String feedback,
      required final String sentiment,
      required final double score,
      required final double confidence,
      required final List<String> keywords,
      required final List<String> topics,
      required final double rating}) = _$SentimentAnalysisImpl;

  factory _SentimentAnalysis.fromJson(Map<String, dynamic> json) =
      _$SentimentAnalysisImpl.fromJson;

  @override
  String get appointmentId;
  @override
  String get feedback;
  @override
  String get sentiment;
  @override
  double get score;
  @override
  double get confidence;
  @override
  List<String> get keywords;
  @override
  List<String> get topics;
  @override
  double get rating;
  @override
  @JsonKey(ignore: true)
  _$$SentimentAnalysisImplCopyWith<_$SentimentAnalysisImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RiskAssessment _$RiskAssessmentFromJson(Map<String, dynamic> json) {
  return _RiskAssessment.fromJson(json);
}

/// @nodoc
mixin _$RiskAssessment {
  String get appointmentId => throw _privateConstructorUsedError;
  double get riskScore => throw _privateConstructorUsedError;
  String get riskLevel => throw _privateConstructorUsedError;
  RiskFactors get factors => throw _privateConstructorUsedError;
  List<String> get mitigations => throw _privateConstructorUsedError;
  bool get requiresApproval => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RiskAssessmentCopyWith<RiskAssessment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RiskAssessmentCopyWith<$Res> {
  factory $RiskAssessmentCopyWith(
          RiskAssessment value, $Res Function(RiskAssessment) then) =
      _$RiskAssessmentCopyWithImpl<$Res, RiskAssessment>;
  @useResult
  $Res call(
      {String appointmentId,
      double riskScore,
      String riskLevel,
      RiskFactors factors,
      List<String> mitigations,
      bool requiresApproval});

  $RiskFactorsCopyWith<$Res> get factors;
}

/// @nodoc
class _$RiskAssessmentCopyWithImpl<$Res, $Val extends RiskAssessment>
    implements $RiskAssessmentCopyWith<$Res> {
  _$RiskAssessmentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appointmentId = null,
    Object? riskScore = null,
    Object? riskLevel = null,
    Object? factors = null,
    Object? mitigations = null,
    Object? requiresApproval = null,
  }) {
    return _then(_value.copyWith(
      appointmentId: null == appointmentId
          ? _value.appointmentId
          : appointmentId // ignore: cast_nullable_to_non_nullable
              as String,
      riskScore: null == riskScore
          ? _value.riskScore
          : riskScore // ignore: cast_nullable_to_non_nullable
              as double,
      riskLevel: null == riskLevel
          ? _value.riskLevel
          : riskLevel // ignore: cast_nullable_to_non_nullable
              as String,
      factors: null == factors
          ? _value.factors
          : factors // ignore: cast_nullable_to_non_nullable
              as RiskFactors,
      mitigations: null == mitigations
          ? _value.mitigations
          : mitigations // ignore: cast_nullable_to_non_nullable
              as List<String>,
      requiresApproval: null == requiresApproval
          ? _value.requiresApproval
          : requiresApproval // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $RiskFactorsCopyWith<$Res> get factors {
    return $RiskFactorsCopyWith<$Res>(_value.factors, (value) {
      return _then(_value.copyWith(factors: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$RiskAssessmentImplCopyWith<$Res>
    implements $RiskAssessmentCopyWith<$Res> {
  factory _$$RiskAssessmentImplCopyWith(_$RiskAssessmentImpl value,
          $Res Function(_$RiskAssessmentImpl) then) =
      __$$RiskAssessmentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String appointmentId,
      double riskScore,
      String riskLevel,
      RiskFactors factors,
      List<String> mitigations,
      bool requiresApproval});

  @override
  $RiskFactorsCopyWith<$Res> get factors;
}

/// @nodoc
class __$$RiskAssessmentImplCopyWithImpl<$Res>
    extends _$RiskAssessmentCopyWithImpl<$Res, _$RiskAssessmentImpl>
    implements _$$RiskAssessmentImplCopyWith<$Res> {
  __$$RiskAssessmentImplCopyWithImpl(
      _$RiskAssessmentImpl _value, $Res Function(_$RiskAssessmentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appointmentId = null,
    Object? riskScore = null,
    Object? riskLevel = null,
    Object? factors = null,
    Object? mitigations = null,
    Object? requiresApproval = null,
  }) {
    return _then(_$RiskAssessmentImpl(
      appointmentId: null == appointmentId
          ? _value.appointmentId
          : appointmentId // ignore: cast_nullable_to_non_nullable
              as String,
      riskScore: null == riskScore
          ? _value.riskScore
          : riskScore // ignore: cast_nullable_to_non_nullable
              as double,
      riskLevel: null == riskLevel
          ? _value.riskLevel
          : riskLevel // ignore: cast_nullable_to_non_nullable
              as String,
      factors: null == factors
          ? _value.factors
          : factors // ignore: cast_nullable_to_non_nullable
              as RiskFactors,
      mitigations: null == mitigations
          ? _value._mitigations
          : mitigations // ignore: cast_nullable_to_non_nullable
              as List<String>,
      requiresApproval: null == requiresApproval
          ? _value.requiresApproval
          : requiresApproval // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RiskAssessmentImpl implements _RiskAssessment {
  const _$RiskAssessmentImpl(
      {required this.appointmentId,
      required this.riskScore,
      required this.riskLevel,
      required this.factors,
      required final List<String> mitigations,
      required this.requiresApproval})
      : _mitigations = mitigations;

  factory _$RiskAssessmentImpl.fromJson(Map<String, dynamic> json) =>
      _$$RiskAssessmentImplFromJson(json);

  @override
  final String appointmentId;
  @override
  final double riskScore;
  @override
  final String riskLevel;
  @override
  final RiskFactors factors;
  final List<String> _mitigations;
  @override
  List<String> get mitigations {
    if (_mitigations is EqualUnmodifiableListView) return _mitigations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_mitigations);
  }

  @override
  final bool requiresApproval;

  @override
  String toString() {
    return 'RiskAssessment(appointmentId: $appointmentId, riskScore: $riskScore, riskLevel: $riskLevel, factors: $factors, mitigations: $mitigations, requiresApproval: $requiresApproval)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RiskAssessmentImpl &&
            (identical(other.appointmentId, appointmentId) ||
                other.appointmentId == appointmentId) &&
            (identical(other.riskScore, riskScore) ||
                other.riskScore == riskScore) &&
            (identical(other.riskLevel, riskLevel) ||
                other.riskLevel == riskLevel) &&
            (identical(other.factors, factors) || other.factors == factors) &&
            const DeepCollectionEquality()
                .equals(other._mitigations, _mitigations) &&
            (identical(other.requiresApproval, requiresApproval) ||
                other.requiresApproval == requiresApproval));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      appointmentId,
      riskScore,
      riskLevel,
      factors,
      const DeepCollectionEquality().hash(_mitigations),
      requiresApproval);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RiskAssessmentImplCopyWith<_$RiskAssessmentImpl> get copyWith =>
      __$$RiskAssessmentImplCopyWithImpl<_$RiskAssessmentImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RiskAssessmentImplToJson(
      this,
    );
  }
}

abstract class _RiskAssessment implements RiskAssessment {
  const factory _RiskAssessment(
      {required final String appointmentId,
      required final double riskScore,
      required final String riskLevel,
      required final RiskFactors factors,
      required final List<String> mitigations,
      required final bool requiresApproval}) = _$RiskAssessmentImpl;

  factory _RiskAssessment.fromJson(Map<String, dynamic> json) =
      _$RiskAssessmentImpl.fromJson;

  @override
  String get appointmentId;
  @override
  double get riskScore;
  @override
  String get riskLevel;
  @override
  RiskFactors get factors;
  @override
  List<String> get mitigations;
  @override
  bool get requiresApproval;
  @override
  @JsonKey(ignore: true)
  _$$RiskAssessmentImplCopyWith<_$RiskAssessmentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RiskFactors _$RiskFactorsFromJson(Map<String, dynamic> json) {
  return _RiskFactors.fromJson(json);
}

/// @nodoc
mixin _$RiskFactors {
  double get workerExperience => throw _privateConstructorUsedError;
  double get clientComplexity => throw _privateConstructorUsedError;
  double get serviceType => throw _privateConstructorUsedError;
  double get location => throw _privateConstructorUsedError;
  double get timeOfDay => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RiskFactorsCopyWith<RiskFactors> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RiskFactorsCopyWith<$Res> {
  factory $RiskFactorsCopyWith(
          RiskFactors value, $Res Function(RiskFactors) then) =
      _$RiskFactorsCopyWithImpl<$Res, RiskFactors>;
  @useResult
  $Res call(
      {double workerExperience,
      double clientComplexity,
      double serviceType,
      double location,
      double timeOfDay});
}

/// @nodoc
class _$RiskFactorsCopyWithImpl<$Res, $Val extends RiskFactors>
    implements $RiskFactorsCopyWith<$Res> {
  _$RiskFactorsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? workerExperience = null,
    Object? clientComplexity = null,
    Object? serviceType = null,
    Object? location = null,
    Object? timeOfDay = null,
  }) {
    return _then(_value.copyWith(
      workerExperience: null == workerExperience
          ? _value.workerExperience
          : workerExperience // ignore: cast_nullable_to_non_nullable
              as double,
      clientComplexity: null == clientComplexity
          ? _value.clientComplexity
          : clientComplexity // ignore: cast_nullable_to_non_nullable
              as double,
      serviceType: null == serviceType
          ? _value.serviceType
          : serviceType // ignore: cast_nullable_to_non_nullable
              as double,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as double,
      timeOfDay: null == timeOfDay
          ? _value.timeOfDay
          : timeOfDay // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RiskFactorsImplCopyWith<$Res>
    implements $RiskFactorsCopyWith<$Res> {
  factory _$$RiskFactorsImplCopyWith(
          _$RiskFactorsImpl value, $Res Function(_$RiskFactorsImpl) then) =
      __$$RiskFactorsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double workerExperience,
      double clientComplexity,
      double serviceType,
      double location,
      double timeOfDay});
}

/// @nodoc
class __$$RiskFactorsImplCopyWithImpl<$Res>
    extends _$RiskFactorsCopyWithImpl<$Res, _$RiskFactorsImpl>
    implements _$$RiskFactorsImplCopyWith<$Res> {
  __$$RiskFactorsImplCopyWithImpl(
      _$RiskFactorsImpl _value, $Res Function(_$RiskFactorsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? workerExperience = null,
    Object? clientComplexity = null,
    Object? serviceType = null,
    Object? location = null,
    Object? timeOfDay = null,
  }) {
    return _then(_$RiskFactorsImpl(
      workerExperience: null == workerExperience
          ? _value.workerExperience
          : workerExperience // ignore: cast_nullable_to_non_nullable
              as double,
      clientComplexity: null == clientComplexity
          ? _value.clientComplexity
          : clientComplexity // ignore: cast_nullable_to_non_nullable
              as double,
      serviceType: null == serviceType
          ? _value.serviceType
          : serviceType // ignore: cast_nullable_to_non_nullable
              as double,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as double,
      timeOfDay: null == timeOfDay
          ? _value.timeOfDay
          : timeOfDay // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RiskFactorsImpl implements _RiskFactors {
  const _$RiskFactorsImpl(
      {required this.workerExperience,
      required this.clientComplexity,
      required this.serviceType,
      required this.location,
      required this.timeOfDay});

  factory _$RiskFactorsImpl.fromJson(Map<String, dynamic> json) =>
      _$$RiskFactorsImplFromJson(json);

  @override
  final double workerExperience;
  @override
  final double clientComplexity;
  @override
  final double serviceType;
  @override
  final double location;
  @override
  final double timeOfDay;

  @override
  String toString() {
    return 'RiskFactors(workerExperience: $workerExperience, clientComplexity: $clientComplexity, serviceType: $serviceType, location: $location, timeOfDay: $timeOfDay)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RiskFactorsImpl &&
            (identical(other.workerExperience, workerExperience) ||
                other.workerExperience == workerExperience) &&
            (identical(other.clientComplexity, clientComplexity) ||
                other.clientComplexity == clientComplexity) &&
            (identical(other.serviceType, serviceType) ||
                other.serviceType == serviceType) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.timeOfDay, timeOfDay) ||
                other.timeOfDay == timeOfDay));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, workerExperience,
      clientComplexity, serviceType, location, timeOfDay);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RiskFactorsImplCopyWith<_$RiskFactorsImpl> get copyWith =>
      __$$RiskFactorsImplCopyWithImpl<_$RiskFactorsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RiskFactorsImplToJson(
      this,
    );
  }
}

abstract class _RiskFactors implements RiskFactors {
  const factory _RiskFactors(
      {required final double workerExperience,
      required final double clientComplexity,
      required final double serviceType,
      required final double location,
      required final double timeOfDay}) = _$RiskFactorsImpl;

  factory _RiskFactors.fromJson(Map<String, dynamic> json) =
      _$RiskFactorsImpl.fromJson;

  @override
  double get workerExperience;
  @override
  double get clientComplexity;
  @override
  double get serviceType;
  @override
  double get location;
  @override
  double get timeOfDay;
  @override
  @JsonKey(ignore: true)
  _$$RiskFactorsImplCopyWith<_$RiskFactorsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

IncidentPattern _$IncidentPatternFromJson(Map<String, dynamic> json) {
  return _IncidentPattern.fromJson(json);
}

/// @nodoc
mixin _$IncidentPattern {
  int get totalIncidents => throw _privateConstructorUsedError;
  Map<String, dynamic> get patterns => throw _privateConstructorUsedError;
  List<RecurringIssue> get recurringIssues =>
      throw _privateConstructorUsedError;
  List<PreventiveAction> get preventiveActions =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $IncidentPatternCopyWith<IncidentPattern> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IncidentPatternCopyWith<$Res> {
  factory $IncidentPatternCopyWith(
          IncidentPattern value, $Res Function(IncidentPattern) then) =
      _$IncidentPatternCopyWithImpl<$Res, IncidentPattern>;
  @useResult
  $Res call(
      {int totalIncidents,
      Map<String, dynamic> patterns,
      List<RecurringIssue> recurringIssues,
      List<PreventiveAction> preventiveActions});
}

/// @nodoc
class _$IncidentPatternCopyWithImpl<$Res, $Val extends IncidentPattern>
    implements $IncidentPatternCopyWith<$Res> {
  _$IncidentPatternCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalIncidents = null,
    Object? patterns = null,
    Object? recurringIssues = null,
    Object? preventiveActions = null,
  }) {
    return _then(_value.copyWith(
      totalIncidents: null == totalIncidents
          ? _value.totalIncidents
          : totalIncidents // ignore: cast_nullable_to_non_nullable
              as int,
      patterns: null == patterns
          ? _value.patterns
          : patterns // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      recurringIssues: null == recurringIssues
          ? _value.recurringIssues
          : recurringIssues // ignore: cast_nullable_to_non_nullable
              as List<RecurringIssue>,
      preventiveActions: null == preventiveActions
          ? _value.preventiveActions
          : preventiveActions // ignore: cast_nullable_to_non_nullable
              as List<PreventiveAction>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$IncidentPatternImplCopyWith<$Res>
    implements $IncidentPatternCopyWith<$Res> {
  factory _$$IncidentPatternImplCopyWith(_$IncidentPatternImpl value,
          $Res Function(_$IncidentPatternImpl) then) =
      __$$IncidentPatternImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int totalIncidents,
      Map<String, dynamic> patterns,
      List<RecurringIssue> recurringIssues,
      List<PreventiveAction> preventiveActions});
}

/// @nodoc
class __$$IncidentPatternImplCopyWithImpl<$Res>
    extends _$IncidentPatternCopyWithImpl<$Res, _$IncidentPatternImpl>
    implements _$$IncidentPatternImplCopyWith<$Res> {
  __$$IncidentPatternImplCopyWithImpl(
      _$IncidentPatternImpl _value, $Res Function(_$IncidentPatternImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalIncidents = null,
    Object? patterns = null,
    Object? recurringIssues = null,
    Object? preventiveActions = null,
  }) {
    return _then(_$IncidentPatternImpl(
      totalIncidents: null == totalIncidents
          ? _value.totalIncidents
          : totalIncidents // ignore: cast_nullable_to_non_nullable
              as int,
      patterns: null == patterns
          ? _value._patterns
          : patterns // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      recurringIssues: null == recurringIssues
          ? _value._recurringIssues
          : recurringIssues // ignore: cast_nullable_to_non_nullable
              as List<RecurringIssue>,
      preventiveActions: null == preventiveActions
          ? _value._preventiveActions
          : preventiveActions // ignore: cast_nullable_to_non_nullable
              as List<PreventiveAction>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$IncidentPatternImpl implements _IncidentPattern {
  const _$IncidentPatternImpl(
      {required this.totalIncidents,
      required final Map<String, dynamic> patterns,
      required final List<RecurringIssue> recurringIssues,
      required final List<PreventiveAction> preventiveActions})
      : _patterns = patterns,
        _recurringIssues = recurringIssues,
        _preventiveActions = preventiveActions;

  factory _$IncidentPatternImpl.fromJson(Map<String, dynamic> json) =>
      _$$IncidentPatternImplFromJson(json);

  @override
  final int totalIncidents;
  final Map<String, dynamic> _patterns;
  @override
  Map<String, dynamic> get patterns {
    if (_patterns is EqualUnmodifiableMapView) return _patterns;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_patterns);
  }

  final List<RecurringIssue> _recurringIssues;
  @override
  List<RecurringIssue> get recurringIssues {
    if (_recurringIssues is EqualUnmodifiableListView) return _recurringIssues;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recurringIssues);
  }

  final List<PreventiveAction> _preventiveActions;
  @override
  List<PreventiveAction> get preventiveActions {
    if (_preventiveActions is EqualUnmodifiableListView)
      return _preventiveActions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_preventiveActions);
  }

  @override
  String toString() {
    return 'IncidentPattern(totalIncidents: $totalIncidents, patterns: $patterns, recurringIssues: $recurringIssues, preventiveActions: $preventiveActions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IncidentPatternImpl &&
            (identical(other.totalIncidents, totalIncidents) ||
                other.totalIncidents == totalIncidents) &&
            const DeepCollectionEquality().equals(other._patterns, _patterns) &&
            const DeepCollectionEquality()
                .equals(other._recurringIssues, _recurringIssues) &&
            const DeepCollectionEquality()
                .equals(other._preventiveActions, _preventiveActions));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      totalIncidents,
      const DeepCollectionEquality().hash(_patterns),
      const DeepCollectionEquality().hash(_recurringIssues),
      const DeepCollectionEquality().hash(_preventiveActions));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$IncidentPatternImplCopyWith<_$IncidentPatternImpl> get copyWith =>
      __$$IncidentPatternImplCopyWithImpl<_$IncidentPatternImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IncidentPatternImplToJson(
      this,
    );
  }
}

abstract class _IncidentPattern implements IncidentPattern {
  const factory _IncidentPattern(
          {required final int totalIncidents,
          required final Map<String, dynamic> patterns,
          required final List<RecurringIssue> recurringIssues,
          required final List<PreventiveAction> preventiveActions}) =
      _$IncidentPatternImpl;

  factory _IncidentPattern.fromJson(Map<String, dynamic> json) =
      _$IncidentPatternImpl.fromJson;

  @override
  int get totalIncidents;
  @override
  Map<String, dynamic> get patterns;
  @override
  List<RecurringIssue> get recurringIssues;
  @override
  List<PreventiveAction> get preventiveActions;
  @override
  @JsonKey(ignore: true)
  _$$IncidentPatternImplCopyWith<_$IncidentPatternImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RecurringIssue _$RecurringIssueFromJson(Map<String, dynamic> json) {
  return _RecurringIssue.fromJson(json);
}

/// @nodoc
mixin _$RecurringIssue {
  String get type => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get severity => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RecurringIssueCopyWith<RecurringIssue> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecurringIssueCopyWith<$Res> {
  factory $RecurringIssueCopyWith(
          RecurringIssue value, $Res Function(RecurringIssue) then) =
      _$RecurringIssueCopyWithImpl<$Res, RecurringIssue>;
  @useResult
  $Res call({String type, String description, String severity});
}

/// @nodoc
class _$RecurringIssueCopyWithImpl<$Res, $Val extends RecurringIssue>
    implements $RecurringIssueCopyWith<$Res> {
  _$RecurringIssueCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? description = null,
    Object? severity = null,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      severity: null == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RecurringIssueImplCopyWith<$Res>
    implements $RecurringIssueCopyWith<$Res> {
  factory _$$RecurringIssueImplCopyWith(_$RecurringIssueImpl value,
          $Res Function(_$RecurringIssueImpl) then) =
      __$$RecurringIssueImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String type, String description, String severity});
}

/// @nodoc
class __$$RecurringIssueImplCopyWithImpl<$Res>
    extends _$RecurringIssueCopyWithImpl<$Res, _$RecurringIssueImpl>
    implements _$$RecurringIssueImplCopyWith<$Res> {
  __$$RecurringIssueImplCopyWithImpl(
      _$RecurringIssueImpl _value, $Res Function(_$RecurringIssueImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? description = null,
    Object? severity = null,
  }) {
    return _then(_$RecurringIssueImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      severity: null == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RecurringIssueImpl implements _RecurringIssue {
  const _$RecurringIssueImpl(
      {required this.type, required this.description, required this.severity});

  factory _$RecurringIssueImpl.fromJson(Map<String, dynamic> json) =>
      _$$RecurringIssueImplFromJson(json);

  @override
  final String type;
  @override
  final String description;
  @override
  final String severity;

  @override
  String toString() {
    return 'RecurringIssue(type: $type, description: $description, severity: $severity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecurringIssueImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.severity, severity) ||
                other.severity == severity));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, type, description, severity);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RecurringIssueImplCopyWith<_$RecurringIssueImpl> get copyWith =>
      __$$RecurringIssueImplCopyWithImpl<_$RecurringIssueImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RecurringIssueImplToJson(
      this,
    );
  }
}

abstract class _RecurringIssue implements RecurringIssue {
  const factory _RecurringIssue(
      {required final String type,
      required final String description,
      required final String severity}) = _$RecurringIssueImpl;

  factory _RecurringIssue.fromJson(Map<String, dynamic> json) =
      _$RecurringIssueImpl.fromJson;

  @override
  String get type;
  @override
  String get description;
  @override
  String get severity;
  @override
  @JsonKey(ignore: true)
  _$$RecurringIssueImplCopyWith<_$RecurringIssueImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PreventiveAction _$PreventiveActionFromJson(Map<String, dynamic> json) {
  return _PreventiveAction.fromJson(json);
}

/// @nodoc
mixin _$PreventiveAction {
  String get action => throw _privateConstructorUsedError;
  String get priority => throw _privateConstructorUsedError;
  String get expectedImpact => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PreventiveActionCopyWith<PreventiveAction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PreventiveActionCopyWith<$Res> {
  factory $PreventiveActionCopyWith(
          PreventiveAction value, $Res Function(PreventiveAction) then) =
      _$PreventiveActionCopyWithImpl<$Res, PreventiveAction>;
  @useResult
  $Res call({String action, String priority, String expectedImpact});
}

/// @nodoc
class _$PreventiveActionCopyWithImpl<$Res, $Val extends PreventiveAction>
    implements $PreventiveActionCopyWith<$Res> {
  _$PreventiveActionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? action = null,
    Object? priority = null,
    Object? expectedImpact = null,
  }) {
    return _then(_value.copyWith(
      action: null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as String,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as String,
      expectedImpact: null == expectedImpact
          ? _value.expectedImpact
          : expectedImpact // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PreventiveActionImplCopyWith<$Res>
    implements $PreventiveActionCopyWith<$Res> {
  factory _$$PreventiveActionImplCopyWith(_$PreventiveActionImpl value,
          $Res Function(_$PreventiveActionImpl) then) =
      __$$PreventiveActionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String action, String priority, String expectedImpact});
}

/// @nodoc
class __$$PreventiveActionImplCopyWithImpl<$Res>
    extends _$PreventiveActionCopyWithImpl<$Res, _$PreventiveActionImpl>
    implements _$$PreventiveActionImplCopyWith<$Res> {
  __$$PreventiveActionImplCopyWithImpl(_$PreventiveActionImpl _value,
      $Res Function(_$PreventiveActionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? action = null,
    Object? priority = null,
    Object? expectedImpact = null,
  }) {
    return _then(_$PreventiveActionImpl(
      action: null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as String,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as String,
      expectedImpact: null == expectedImpact
          ? _value.expectedImpact
          : expectedImpact // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PreventiveActionImpl implements _PreventiveAction {
  const _$PreventiveActionImpl(
      {required this.action,
      required this.priority,
      required this.expectedImpact});

  factory _$PreventiveActionImpl.fromJson(Map<String, dynamic> json) =>
      _$$PreventiveActionImplFromJson(json);

  @override
  final String action;
  @override
  final String priority;
  @override
  final String expectedImpact;

  @override
  String toString() {
    return 'PreventiveAction(action: $action, priority: $priority, expectedImpact: $expectedImpact)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PreventiveActionImpl &&
            (identical(other.action, action) || other.action == action) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.expectedImpact, expectedImpact) ||
                other.expectedImpact == expectedImpact));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, action, priority, expectedImpact);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PreventiveActionImplCopyWith<_$PreventiveActionImpl> get copyWith =>
      __$$PreventiveActionImplCopyWithImpl<_$PreventiveActionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PreventiveActionImplToJson(
      this,
    );
  }
}

abstract class _PreventiveAction implements PreventiveAction {
  const factory _PreventiveAction(
      {required final String action,
      required final String priority,
      required final String expectedImpact}) = _$PreventiveActionImpl;

  factory _PreventiveAction.fromJson(Map<String, dynamic> json) =
      _$PreventiveActionImpl.fromJson;

  @override
  String get action;
  @override
  String get priority;
  @override
  String get expectedImpact;
  @override
  @JsonKey(ignore: true)
  _$$PreventiveActionImplCopyWith<_$PreventiveActionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ExecutiveDashboard _$ExecutiveDashboardFromJson(Map<String, dynamic> json) {
  return _ExecutiveDashboard.fromJson(json);
}

/// @nodoc
mixin _$ExecutiveDashboard {
  DashboardKPIs get kpis => throw _privateConstructorUsedError;
  RevenueMetrics get revenue => throw _privateConstructorUsedError;
  OperationalMetrics get operations => throw _privateConstructorUsedError;
  ClientMetrics get clients => throw _privateConstructorUsedError;
  WorkforceMetrics get workforce => throw _privateConstructorUsedError;
  Map<String, TrendData> get trends => throw _privateConstructorUsedError;
  String get period => throw _privateConstructorUsedError;
  DateTime get generatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ExecutiveDashboardCopyWith<ExecutiveDashboard> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExecutiveDashboardCopyWith<$Res> {
  factory $ExecutiveDashboardCopyWith(
          ExecutiveDashboard value, $Res Function(ExecutiveDashboard) then) =
      _$ExecutiveDashboardCopyWithImpl<$Res, ExecutiveDashboard>;
  @useResult
  $Res call(
      {DashboardKPIs kpis,
      RevenueMetrics revenue,
      OperationalMetrics operations,
      ClientMetrics clients,
      WorkforceMetrics workforce,
      Map<String, TrendData> trends,
      String period,
      DateTime generatedAt});

  $DashboardKPIsCopyWith<$Res> get kpis;
  $RevenueMetricsCopyWith<$Res> get revenue;
  $OperationalMetricsCopyWith<$Res> get operations;
  $ClientMetricsCopyWith<$Res> get clients;
  $WorkforceMetricsCopyWith<$Res> get workforce;
}

/// @nodoc
class _$ExecutiveDashboardCopyWithImpl<$Res, $Val extends ExecutiveDashboard>
    implements $ExecutiveDashboardCopyWith<$Res> {
  _$ExecutiveDashboardCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? kpis = null,
    Object? revenue = null,
    Object? operations = null,
    Object? clients = null,
    Object? workforce = null,
    Object? trends = null,
    Object? period = null,
    Object? generatedAt = null,
  }) {
    return _then(_value.copyWith(
      kpis: null == kpis
          ? _value.kpis
          : kpis // ignore: cast_nullable_to_non_nullable
              as DashboardKPIs,
      revenue: null == revenue
          ? _value.revenue
          : revenue // ignore: cast_nullable_to_non_nullable
              as RevenueMetrics,
      operations: null == operations
          ? _value.operations
          : operations // ignore: cast_nullable_to_non_nullable
              as OperationalMetrics,
      clients: null == clients
          ? _value.clients
          : clients // ignore: cast_nullable_to_non_nullable
              as ClientMetrics,
      workforce: null == workforce
          ? _value.workforce
          : workforce // ignore: cast_nullable_to_non_nullable
              as WorkforceMetrics,
      trends: null == trends
          ? _value.trends
          : trends // ignore: cast_nullable_to_non_nullable
              as Map<String, TrendData>,
      period: null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as String,
      generatedAt: null == generatedAt
          ? _value.generatedAt
          : generatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $DashboardKPIsCopyWith<$Res> get kpis {
    return $DashboardKPIsCopyWith<$Res>(_value.kpis, (value) {
      return _then(_value.copyWith(kpis: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $RevenueMetricsCopyWith<$Res> get revenue {
    return $RevenueMetricsCopyWith<$Res>(_value.revenue, (value) {
      return _then(_value.copyWith(revenue: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $OperationalMetricsCopyWith<$Res> get operations {
    return $OperationalMetricsCopyWith<$Res>(_value.operations, (value) {
      return _then(_value.copyWith(operations: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ClientMetricsCopyWith<$Res> get clients {
    return $ClientMetricsCopyWith<$Res>(_value.clients, (value) {
      return _then(_value.copyWith(clients: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $WorkforceMetricsCopyWith<$Res> get workforce {
    return $WorkforceMetricsCopyWith<$Res>(_value.workforce, (value) {
      return _then(_value.copyWith(workforce: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ExecutiveDashboardImplCopyWith<$Res>
    implements $ExecutiveDashboardCopyWith<$Res> {
  factory _$$ExecutiveDashboardImplCopyWith(_$ExecutiveDashboardImpl value,
          $Res Function(_$ExecutiveDashboardImpl) then) =
      __$$ExecutiveDashboardImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DashboardKPIs kpis,
      RevenueMetrics revenue,
      OperationalMetrics operations,
      ClientMetrics clients,
      WorkforceMetrics workforce,
      Map<String, TrendData> trends,
      String period,
      DateTime generatedAt});

  @override
  $DashboardKPIsCopyWith<$Res> get kpis;
  @override
  $RevenueMetricsCopyWith<$Res> get revenue;
  @override
  $OperationalMetricsCopyWith<$Res> get operations;
  @override
  $ClientMetricsCopyWith<$Res> get clients;
  @override
  $WorkforceMetricsCopyWith<$Res> get workforce;
}

/// @nodoc
class __$$ExecutiveDashboardImplCopyWithImpl<$Res>
    extends _$ExecutiveDashboardCopyWithImpl<$Res, _$ExecutiveDashboardImpl>
    implements _$$ExecutiveDashboardImplCopyWith<$Res> {
  __$$ExecutiveDashboardImplCopyWithImpl(_$ExecutiveDashboardImpl _value,
      $Res Function(_$ExecutiveDashboardImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? kpis = null,
    Object? revenue = null,
    Object? operations = null,
    Object? clients = null,
    Object? workforce = null,
    Object? trends = null,
    Object? period = null,
    Object? generatedAt = null,
  }) {
    return _then(_$ExecutiveDashboardImpl(
      kpis: null == kpis
          ? _value.kpis
          : kpis // ignore: cast_nullable_to_non_nullable
              as DashboardKPIs,
      revenue: null == revenue
          ? _value.revenue
          : revenue // ignore: cast_nullable_to_non_nullable
              as RevenueMetrics,
      operations: null == operations
          ? _value.operations
          : operations // ignore: cast_nullable_to_non_nullable
              as OperationalMetrics,
      clients: null == clients
          ? _value.clients
          : clients // ignore: cast_nullable_to_non_nullable
              as ClientMetrics,
      workforce: null == workforce
          ? _value.workforce
          : workforce // ignore: cast_nullable_to_non_nullable
              as WorkforceMetrics,
      trends: null == trends
          ? _value._trends
          : trends // ignore: cast_nullable_to_non_nullable
              as Map<String, TrendData>,
      period: null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as String,
      generatedAt: null == generatedAt
          ? _value.generatedAt
          : generatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExecutiveDashboardImpl implements _ExecutiveDashboard {
  const _$ExecutiveDashboardImpl(
      {required this.kpis,
      required this.revenue,
      required this.operations,
      required this.clients,
      required this.workforce,
      required final Map<String, TrendData> trends,
      required this.period,
      required this.generatedAt})
      : _trends = trends;

  factory _$ExecutiveDashboardImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExecutiveDashboardImplFromJson(json);

  @override
  final DashboardKPIs kpis;
  @override
  final RevenueMetrics revenue;
  @override
  final OperationalMetrics operations;
  @override
  final ClientMetrics clients;
  @override
  final WorkforceMetrics workforce;
  final Map<String, TrendData> _trends;
  @override
  Map<String, TrendData> get trends {
    if (_trends is EqualUnmodifiableMapView) return _trends;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_trends);
  }

  @override
  final String period;
  @override
  final DateTime generatedAt;

  @override
  String toString() {
    return 'ExecutiveDashboard(kpis: $kpis, revenue: $revenue, operations: $operations, clients: $clients, workforce: $workforce, trends: $trends, period: $period, generatedAt: $generatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExecutiveDashboardImpl &&
            (identical(other.kpis, kpis) || other.kpis == kpis) &&
            (identical(other.revenue, revenue) || other.revenue == revenue) &&
            (identical(other.operations, operations) ||
                other.operations == operations) &&
            (identical(other.clients, clients) || other.clients == clients) &&
            (identical(other.workforce, workforce) ||
                other.workforce == workforce) &&
            const DeepCollectionEquality().equals(other._trends, _trends) &&
            (identical(other.period, period) || other.period == period) &&
            (identical(other.generatedAt, generatedAt) ||
                other.generatedAt == generatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      kpis,
      revenue,
      operations,
      clients,
      workforce,
      const DeepCollectionEquality().hash(_trends),
      period,
      generatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ExecutiveDashboardImplCopyWith<_$ExecutiveDashboardImpl> get copyWith =>
      __$$ExecutiveDashboardImplCopyWithImpl<_$ExecutiveDashboardImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExecutiveDashboardImplToJson(
      this,
    );
  }
}

abstract class _ExecutiveDashboard implements ExecutiveDashboard {
  const factory _ExecutiveDashboard(
      {required final DashboardKPIs kpis,
      required final RevenueMetrics revenue,
      required final OperationalMetrics operations,
      required final ClientMetrics clients,
      required final WorkforceMetrics workforce,
      required final Map<String, TrendData> trends,
      required final String period,
      required final DateTime generatedAt}) = _$ExecutiveDashboardImpl;

  factory _ExecutiveDashboard.fromJson(Map<String, dynamic> json) =
      _$ExecutiveDashboardImpl.fromJson;

  @override
  DashboardKPIs get kpis;
  @override
  RevenueMetrics get revenue;
  @override
  OperationalMetrics get operations;
  @override
  ClientMetrics get clients;
  @override
  WorkforceMetrics get workforce;
  @override
  Map<String, TrendData> get trends;
  @override
  String get period;
  @override
  DateTime get generatedAt;
  @override
  @JsonKey(ignore: true)
  _$$ExecutiveDashboardImplCopyWith<_$ExecutiveDashboardImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DashboardKPIs _$DashboardKPIsFromJson(Map<String, dynamic> json) {
  return _DashboardKPIs.fromJson(json);
}

/// @nodoc
mixin _$DashboardKPIs {
  double get totalRevenue => throw _privateConstructorUsedError;
  int get totalAppointments => throw _privateConstructorUsedError;
  int get completedAppointments => throw _privateConstructorUsedError;
  double get completionRate => throw _privateConstructorUsedError;
  double get avgRevenuePerAppointment => throw _privateConstructorUsedError;
  double get growth => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DashboardKPIsCopyWith<DashboardKPIs> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DashboardKPIsCopyWith<$Res> {
  factory $DashboardKPIsCopyWith(
          DashboardKPIs value, $Res Function(DashboardKPIs) then) =
      _$DashboardKPIsCopyWithImpl<$Res, DashboardKPIs>;
  @useResult
  $Res call(
      {double totalRevenue,
      int totalAppointments,
      int completedAppointments,
      double completionRate,
      double avgRevenuePerAppointment,
      double growth});
}

/// @nodoc
class _$DashboardKPIsCopyWithImpl<$Res, $Val extends DashboardKPIs>
    implements $DashboardKPIsCopyWith<$Res> {
  _$DashboardKPIsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalRevenue = null,
    Object? totalAppointments = null,
    Object? completedAppointments = null,
    Object? completionRate = null,
    Object? avgRevenuePerAppointment = null,
    Object? growth = null,
  }) {
    return _then(_value.copyWith(
      totalRevenue: null == totalRevenue
          ? _value.totalRevenue
          : totalRevenue // ignore: cast_nullable_to_non_nullable
              as double,
      totalAppointments: null == totalAppointments
          ? _value.totalAppointments
          : totalAppointments // ignore: cast_nullable_to_non_nullable
              as int,
      completedAppointments: null == completedAppointments
          ? _value.completedAppointments
          : completedAppointments // ignore: cast_nullable_to_non_nullable
              as int,
      completionRate: null == completionRate
          ? _value.completionRate
          : completionRate // ignore: cast_nullable_to_non_nullable
              as double,
      avgRevenuePerAppointment: null == avgRevenuePerAppointment
          ? _value.avgRevenuePerAppointment
          : avgRevenuePerAppointment // ignore: cast_nullable_to_non_nullable
              as double,
      growth: null == growth
          ? _value.growth
          : growth // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DashboardKPIsImplCopyWith<$Res>
    implements $DashboardKPIsCopyWith<$Res> {
  factory _$$DashboardKPIsImplCopyWith(
          _$DashboardKPIsImpl value, $Res Function(_$DashboardKPIsImpl) then) =
      __$$DashboardKPIsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double totalRevenue,
      int totalAppointments,
      int completedAppointments,
      double completionRate,
      double avgRevenuePerAppointment,
      double growth});
}

/// @nodoc
class __$$DashboardKPIsImplCopyWithImpl<$Res>
    extends _$DashboardKPIsCopyWithImpl<$Res, _$DashboardKPIsImpl>
    implements _$$DashboardKPIsImplCopyWith<$Res> {
  __$$DashboardKPIsImplCopyWithImpl(
      _$DashboardKPIsImpl _value, $Res Function(_$DashboardKPIsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalRevenue = null,
    Object? totalAppointments = null,
    Object? completedAppointments = null,
    Object? completionRate = null,
    Object? avgRevenuePerAppointment = null,
    Object? growth = null,
  }) {
    return _then(_$DashboardKPIsImpl(
      totalRevenue: null == totalRevenue
          ? _value.totalRevenue
          : totalRevenue // ignore: cast_nullable_to_non_nullable
              as double,
      totalAppointments: null == totalAppointments
          ? _value.totalAppointments
          : totalAppointments // ignore: cast_nullable_to_non_nullable
              as int,
      completedAppointments: null == completedAppointments
          ? _value.completedAppointments
          : completedAppointments // ignore: cast_nullable_to_non_nullable
              as int,
      completionRate: null == completionRate
          ? _value.completionRate
          : completionRate // ignore: cast_nullable_to_non_nullable
              as double,
      avgRevenuePerAppointment: null == avgRevenuePerAppointment
          ? _value.avgRevenuePerAppointment
          : avgRevenuePerAppointment // ignore: cast_nullable_to_non_nullable
              as double,
      growth: null == growth
          ? _value.growth
          : growth // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DashboardKPIsImpl implements _DashboardKPIs {
  const _$DashboardKPIsImpl(
      {required this.totalRevenue,
      required this.totalAppointments,
      required this.completedAppointments,
      required this.completionRate,
      required this.avgRevenuePerAppointment,
      required this.growth});

  factory _$DashboardKPIsImpl.fromJson(Map<String, dynamic> json) =>
      _$$DashboardKPIsImplFromJson(json);

  @override
  final double totalRevenue;
  @override
  final int totalAppointments;
  @override
  final int completedAppointments;
  @override
  final double completionRate;
  @override
  final double avgRevenuePerAppointment;
  @override
  final double growth;

  @override
  String toString() {
    return 'DashboardKPIs(totalRevenue: $totalRevenue, totalAppointments: $totalAppointments, completedAppointments: $completedAppointments, completionRate: $completionRate, avgRevenuePerAppointment: $avgRevenuePerAppointment, growth: $growth)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DashboardKPIsImpl &&
            (identical(other.totalRevenue, totalRevenue) ||
                other.totalRevenue == totalRevenue) &&
            (identical(other.totalAppointments, totalAppointments) ||
                other.totalAppointments == totalAppointments) &&
            (identical(other.completedAppointments, completedAppointments) ||
                other.completedAppointments == completedAppointments) &&
            (identical(other.completionRate, completionRate) ||
                other.completionRate == completionRate) &&
            (identical(
                    other.avgRevenuePerAppointment, avgRevenuePerAppointment) ||
                other.avgRevenuePerAppointment == avgRevenuePerAppointment) &&
            (identical(other.growth, growth) || other.growth == growth));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, totalRevenue, totalAppointments,
      completedAppointments, completionRate, avgRevenuePerAppointment, growth);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DashboardKPIsImplCopyWith<_$DashboardKPIsImpl> get copyWith =>
      __$$DashboardKPIsImplCopyWithImpl<_$DashboardKPIsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DashboardKPIsImplToJson(
      this,
    );
  }
}

abstract class _DashboardKPIs implements DashboardKPIs {
  const factory _DashboardKPIs(
      {required final double totalRevenue,
      required final int totalAppointments,
      required final int completedAppointments,
      required final double completionRate,
      required final double avgRevenuePerAppointment,
      required final double growth}) = _$DashboardKPIsImpl;

  factory _DashboardKPIs.fromJson(Map<String, dynamic> json) =
      _$DashboardKPIsImpl.fromJson;

  @override
  double get totalRevenue;
  @override
  int get totalAppointments;
  @override
  int get completedAppointments;
  @override
  double get completionRate;
  @override
  double get avgRevenuePerAppointment;
  @override
  double get growth;
  @override
  @JsonKey(ignore: true)
  _$$DashboardKPIsImplCopyWith<_$DashboardKPIsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RevenueMetrics _$RevenueMetricsFromJson(Map<String, dynamic> json) {
  return _RevenueMetrics.fromJson(json);
}

/// @nodoc
mixin _$RevenueMetrics {
  double get total => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;
  double get avg => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RevenueMetricsCopyWith<RevenueMetrics> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RevenueMetricsCopyWith<$Res> {
  factory $RevenueMetricsCopyWith(
          RevenueMetrics value, $Res Function(RevenueMetrics) then) =
      _$RevenueMetricsCopyWithImpl<$Res, RevenueMetrics>;
  @useResult
  $Res call({double total, int count, double avg});
}

/// @nodoc
class _$RevenueMetricsCopyWithImpl<$Res, $Val extends RevenueMetrics>
    implements $RevenueMetricsCopyWith<$Res> {
  _$RevenueMetricsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? total = null,
    Object? count = null,
    Object? avg = null,
  }) {
    return _then(_value.copyWith(
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as double,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      avg: null == avg
          ? _value.avg
          : avg // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RevenueMetricsImplCopyWith<$Res>
    implements $RevenueMetricsCopyWith<$Res> {
  factory _$$RevenueMetricsImplCopyWith(_$RevenueMetricsImpl value,
          $Res Function(_$RevenueMetricsImpl) then) =
      __$$RevenueMetricsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double total, int count, double avg});
}

/// @nodoc
class __$$RevenueMetricsImplCopyWithImpl<$Res>
    extends _$RevenueMetricsCopyWithImpl<$Res, _$RevenueMetricsImpl>
    implements _$$RevenueMetricsImplCopyWith<$Res> {
  __$$RevenueMetricsImplCopyWithImpl(
      _$RevenueMetricsImpl _value, $Res Function(_$RevenueMetricsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? total = null,
    Object? count = null,
    Object? avg = null,
  }) {
    return _then(_$RevenueMetricsImpl(
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as double,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      avg: null == avg
          ? _value.avg
          : avg // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RevenueMetricsImpl implements _RevenueMetrics {
  const _$RevenueMetricsImpl(
      {required this.total, required this.count, required this.avg});

  factory _$RevenueMetricsImpl.fromJson(Map<String, dynamic> json) =>
      _$$RevenueMetricsImplFromJson(json);

  @override
  final double total;
  @override
  final int count;
  @override
  final double avg;

  @override
  String toString() {
    return 'RevenueMetrics(total: $total, count: $count, avg: $avg)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RevenueMetricsImpl &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.avg, avg) || other.avg == avg));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, total, count, avg);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RevenueMetricsImplCopyWith<_$RevenueMetricsImpl> get copyWith =>
      __$$RevenueMetricsImplCopyWithImpl<_$RevenueMetricsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RevenueMetricsImplToJson(
      this,
    );
  }
}

abstract class _RevenueMetrics implements RevenueMetrics {
  const factory _RevenueMetrics(
      {required final double total,
      required final int count,
      required final double avg}) = _$RevenueMetricsImpl;

  factory _RevenueMetrics.fromJson(Map<String, dynamic> json) =
      _$RevenueMetricsImpl.fromJson;

  @override
  double get total;
  @override
  int get count;
  @override
  double get avg;
  @override
  @JsonKey(ignore: true)
  _$$RevenueMetricsImplCopyWith<_$RevenueMetricsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OperationalMetrics _$OperationalMetricsFromJson(Map<String, dynamic> json) {
  return _OperationalMetrics.fromJson(json);
}

/// @nodoc
mixin _$OperationalMetrics {
  double get utilization => throw _privateConstructorUsedError;
  double get efficiency => throw _privateConstructorUsedError;
  double get onTimeRate => throw _privateConstructorUsedError;
  double get cancellationRate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OperationalMetricsCopyWith<OperationalMetrics> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OperationalMetricsCopyWith<$Res> {
  factory $OperationalMetricsCopyWith(
          OperationalMetrics value, $Res Function(OperationalMetrics) then) =
      _$OperationalMetricsCopyWithImpl<$Res, OperationalMetrics>;
  @useResult
  $Res call(
      {double utilization,
      double efficiency,
      double onTimeRate,
      double cancellationRate});
}

/// @nodoc
class _$OperationalMetricsCopyWithImpl<$Res, $Val extends OperationalMetrics>
    implements $OperationalMetricsCopyWith<$Res> {
  _$OperationalMetricsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? utilization = null,
    Object? efficiency = null,
    Object? onTimeRate = null,
    Object? cancellationRate = null,
  }) {
    return _then(_value.copyWith(
      utilization: null == utilization
          ? _value.utilization
          : utilization // ignore: cast_nullable_to_non_nullable
              as double,
      efficiency: null == efficiency
          ? _value.efficiency
          : efficiency // ignore: cast_nullable_to_non_nullable
              as double,
      onTimeRate: null == onTimeRate
          ? _value.onTimeRate
          : onTimeRate // ignore: cast_nullable_to_non_nullable
              as double,
      cancellationRate: null == cancellationRate
          ? _value.cancellationRate
          : cancellationRate // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OperationalMetricsImplCopyWith<$Res>
    implements $OperationalMetricsCopyWith<$Res> {
  factory _$$OperationalMetricsImplCopyWith(_$OperationalMetricsImpl value,
          $Res Function(_$OperationalMetricsImpl) then) =
      __$$OperationalMetricsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double utilization,
      double efficiency,
      double onTimeRate,
      double cancellationRate});
}

/// @nodoc
class __$$OperationalMetricsImplCopyWithImpl<$Res>
    extends _$OperationalMetricsCopyWithImpl<$Res, _$OperationalMetricsImpl>
    implements _$$OperationalMetricsImplCopyWith<$Res> {
  __$$OperationalMetricsImplCopyWithImpl(_$OperationalMetricsImpl _value,
      $Res Function(_$OperationalMetricsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? utilization = null,
    Object? efficiency = null,
    Object? onTimeRate = null,
    Object? cancellationRate = null,
  }) {
    return _then(_$OperationalMetricsImpl(
      utilization: null == utilization
          ? _value.utilization
          : utilization // ignore: cast_nullable_to_non_nullable
              as double,
      efficiency: null == efficiency
          ? _value.efficiency
          : efficiency // ignore: cast_nullable_to_non_nullable
              as double,
      onTimeRate: null == onTimeRate
          ? _value.onTimeRate
          : onTimeRate // ignore: cast_nullable_to_non_nullable
              as double,
      cancellationRate: null == cancellationRate
          ? _value.cancellationRate
          : cancellationRate // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OperationalMetricsImpl implements _OperationalMetrics {
  const _$OperationalMetricsImpl(
      {required this.utilization,
      required this.efficiency,
      required this.onTimeRate,
      required this.cancellationRate});

  factory _$OperationalMetricsImpl.fromJson(Map<String, dynamic> json) =>
      _$$OperationalMetricsImplFromJson(json);

  @override
  final double utilization;
  @override
  final double efficiency;
  @override
  final double onTimeRate;
  @override
  final double cancellationRate;

  @override
  String toString() {
    return 'OperationalMetrics(utilization: $utilization, efficiency: $efficiency, onTimeRate: $onTimeRate, cancellationRate: $cancellationRate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OperationalMetricsImpl &&
            (identical(other.utilization, utilization) ||
                other.utilization == utilization) &&
            (identical(other.efficiency, efficiency) ||
                other.efficiency == efficiency) &&
            (identical(other.onTimeRate, onTimeRate) ||
                other.onTimeRate == onTimeRate) &&
            (identical(other.cancellationRate, cancellationRate) ||
                other.cancellationRate == cancellationRate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, utilization, efficiency, onTimeRate, cancellationRate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OperationalMetricsImplCopyWith<_$OperationalMetricsImpl> get copyWith =>
      __$$OperationalMetricsImplCopyWithImpl<_$OperationalMetricsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OperationalMetricsImplToJson(
      this,
    );
  }
}

abstract class _OperationalMetrics implements OperationalMetrics {
  const factory _OperationalMetrics(
      {required final double utilization,
      required final double efficiency,
      required final double onTimeRate,
      required final double cancellationRate}) = _$OperationalMetricsImpl;

  factory _OperationalMetrics.fromJson(Map<String, dynamic> json) =
      _$OperationalMetricsImpl.fromJson;

  @override
  double get utilization;
  @override
  double get efficiency;
  @override
  double get onTimeRate;
  @override
  double get cancellationRate;
  @override
  @JsonKey(ignore: true)
  _$$OperationalMetricsImplCopyWith<_$OperationalMetricsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ClientMetrics _$ClientMetricsFromJson(Map<String, dynamic> json) {
  return _ClientMetrics.fromJson(json);
}

/// @nodoc
mixin _$ClientMetrics {
  int get total => throw _privateConstructorUsedError;
  int get active => throw _privateConstructorUsedError;
  double get retention => throw _privateConstructorUsedError;
  double get satisfaction => throw _privateConstructorUsedError;
  int get nps => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ClientMetricsCopyWith<ClientMetrics> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClientMetricsCopyWith<$Res> {
  factory $ClientMetricsCopyWith(
          ClientMetrics value, $Res Function(ClientMetrics) then) =
      _$ClientMetricsCopyWithImpl<$Res, ClientMetrics>;
  @useResult
  $Res call(
      {int total, int active, double retention, double satisfaction, int nps});
}

/// @nodoc
class _$ClientMetricsCopyWithImpl<$Res, $Val extends ClientMetrics>
    implements $ClientMetricsCopyWith<$Res> {
  _$ClientMetricsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? total = null,
    Object? active = null,
    Object? retention = null,
    Object? satisfaction = null,
    Object? nps = null,
  }) {
    return _then(_value.copyWith(
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      active: null == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as int,
      retention: null == retention
          ? _value.retention
          : retention // ignore: cast_nullable_to_non_nullable
              as double,
      satisfaction: null == satisfaction
          ? _value.satisfaction
          : satisfaction // ignore: cast_nullable_to_non_nullable
              as double,
      nps: null == nps
          ? _value.nps
          : nps // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ClientMetricsImplCopyWith<$Res>
    implements $ClientMetricsCopyWith<$Res> {
  factory _$$ClientMetricsImplCopyWith(
          _$ClientMetricsImpl value, $Res Function(_$ClientMetricsImpl) then) =
      __$$ClientMetricsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int total, int active, double retention, double satisfaction, int nps});
}

/// @nodoc
class __$$ClientMetricsImplCopyWithImpl<$Res>
    extends _$ClientMetricsCopyWithImpl<$Res, _$ClientMetricsImpl>
    implements _$$ClientMetricsImplCopyWith<$Res> {
  __$$ClientMetricsImplCopyWithImpl(
      _$ClientMetricsImpl _value, $Res Function(_$ClientMetricsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? total = null,
    Object? active = null,
    Object? retention = null,
    Object? satisfaction = null,
    Object? nps = null,
  }) {
    return _then(_$ClientMetricsImpl(
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      active: null == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as int,
      retention: null == retention
          ? _value.retention
          : retention // ignore: cast_nullable_to_non_nullable
              as double,
      satisfaction: null == satisfaction
          ? _value.satisfaction
          : satisfaction // ignore: cast_nullable_to_non_nullable
              as double,
      nps: null == nps
          ? _value.nps
          : nps // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ClientMetricsImpl implements _ClientMetrics {
  const _$ClientMetricsImpl(
      {required this.total,
      required this.active,
      required this.retention,
      required this.satisfaction,
      required this.nps});

  factory _$ClientMetricsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClientMetricsImplFromJson(json);

  @override
  final int total;
  @override
  final int active;
  @override
  final double retention;
  @override
  final double satisfaction;
  @override
  final int nps;

  @override
  String toString() {
    return 'ClientMetrics(total: $total, active: $active, retention: $retention, satisfaction: $satisfaction, nps: $nps)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClientMetricsImpl &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.active, active) || other.active == active) &&
            (identical(other.retention, retention) ||
                other.retention == retention) &&
            (identical(other.satisfaction, satisfaction) ||
                other.satisfaction == satisfaction) &&
            (identical(other.nps, nps) || other.nps == nps));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, total, active, retention, satisfaction, nps);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ClientMetricsImplCopyWith<_$ClientMetricsImpl> get copyWith =>
      __$$ClientMetricsImplCopyWithImpl<_$ClientMetricsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClientMetricsImplToJson(
      this,
    );
  }
}

abstract class _ClientMetrics implements ClientMetrics {
  const factory _ClientMetrics(
      {required final int total,
      required final int active,
      required final double retention,
      required final double satisfaction,
      required final int nps}) = _$ClientMetricsImpl;

  factory _ClientMetrics.fromJson(Map<String, dynamic> json) =
      _$ClientMetricsImpl.fromJson;

  @override
  int get total;
  @override
  int get active;
  @override
  double get retention;
  @override
  double get satisfaction;
  @override
  int get nps;
  @override
  @JsonKey(ignore: true)
  _$$ClientMetricsImplCopyWith<_$ClientMetricsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WorkforceMetrics _$WorkforceMetricsFromJson(Map<String, dynamic> json) {
  return _WorkforceMetrics.fromJson(json);
}

/// @nodoc
mixin _$WorkforceMetrics {
  int get total => throw _privateConstructorUsedError;
  double get utilization => throw _privateConstructorUsedError;
  double get productivity => throw _privateConstructorUsedError;
  double get satisfaction => throw _privateConstructorUsedError;
  double get turnover => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WorkforceMetricsCopyWith<WorkforceMetrics> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkforceMetricsCopyWith<$Res> {
  factory $WorkforceMetricsCopyWith(
          WorkforceMetrics value, $Res Function(WorkforceMetrics) then) =
      _$WorkforceMetricsCopyWithImpl<$Res, WorkforceMetrics>;
  @useResult
  $Res call(
      {int total,
      double utilization,
      double productivity,
      double satisfaction,
      double turnover});
}

/// @nodoc
class _$WorkforceMetricsCopyWithImpl<$Res, $Val extends WorkforceMetrics>
    implements $WorkforceMetricsCopyWith<$Res> {
  _$WorkforceMetricsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? total = null,
    Object? utilization = null,
    Object? productivity = null,
    Object? satisfaction = null,
    Object? turnover = null,
  }) {
    return _then(_value.copyWith(
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      utilization: null == utilization
          ? _value.utilization
          : utilization // ignore: cast_nullable_to_non_nullable
              as double,
      productivity: null == productivity
          ? _value.productivity
          : productivity // ignore: cast_nullable_to_non_nullable
              as double,
      satisfaction: null == satisfaction
          ? _value.satisfaction
          : satisfaction // ignore: cast_nullable_to_non_nullable
              as double,
      turnover: null == turnover
          ? _value.turnover
          : turnover // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WorkforceMetricsImplCopyWith<$Res>
    implements $WorkforceMetricsCopyWith<$Res> {
  factory _$$WorkforceMetricsImplCopyWith(_$WorkforceMetricsImpl value,
          $Res Function(_$WorkforceMetricsImpl) then) =
      __$$WorkforceMetricsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int total,
      double utilization,
      double productivity,
      double satisfaction,
      double turnover});
}

/// @nodoc
class __$$WorkforceMetricsImplCopyWithImpl<$Res>
    extends _$WorkforceMetricsCopyWithImpl<$Res, _$WorkforceMetricsImpl>
    implements _$$WorkforceMetricsImplCopyWith<$Res> {
  __$$WorkforceMetricsImplCopyWithImpl(_$WorkforceMetricsImpl _value,
      $Res Function(_$WorkforceMetricsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? total = null,
    Object? utilization = null,
    Object? productivity = null,
    Object? satisfaction = null,
    Object? turnover = null,
  }) {
    return _then(_$WorkforceMetricsImpl(
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      utilization: null == utilization
          ? _value.utilization
          : utilization // ignore: cast_nullable_to_non_nullable
              as double,
      productivity: null == productivity
          ? _value.productivity
          : productivity // ignore: cast_nullable_to_non_nullable
              as double,
      satisfaction: null == satisfaction
          ? _value.satisfaction
          : satisfaction // ignore: cast_nullable_to_non_nullable
              as double,
      turnover: null == turnover
          ? _value.turnover
          : turnover // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WorkforceMetricsImpl implements _WorkforceMetrics {
  const _$WorkforceMetricsImpl(
      {required this.total,
      required this.utilization,
      required this.productivity,
      required this.satisfaction,
      required this.turnover});

  factory _$WorkforceMetricsImpl.fromJson(Map<String, dynamic> json) =>
      _$$WorkforceMetricsImplFromJson(json);

  @override
  final int total;
  @override
  final double utilization;
  @override
  final double productivity;
  @override
  final double satisfaction;
  @override
  final double turnover;

  @override
  String toString() {
    return 'WorkforceMetrics(total: $total, utilization: $utilization, productivity: $productivity, satisfaction: $satisfaction, turnover: $turnover)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkforceMetricsImpl &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.utilization, utilization) ||
                other.utilization == utilization) &&
            (identical(other.productivity, productivity) ||
                other.productivity == productivity) &&
            (identical(other.satisfaction, satisfaction) ||
                other.satisfaction == satisfaction) &&
            (identical(other.turnover, turnover) ||
                other.turnover == turnover));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, total, utilization, productivity, satisfaction, turnover);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkforceMetricsImplCopyWith<_$WorkforceMetricsImpl> get copyWith =>
      __$$WorkforceMetricsImplCopyWithImpl<_$WorkforceMetricsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WorkforceMetricsImplToJson(
      this,
    );
  }
}

abstract class _WorkforceMetrics implements WorkforceMetrics {
  const factory _WorkforceMetrics(
      {required final int total,
      required final double utilization,
      required final double productivity,
      required final double satisfaction,
      required final double turnover}) = _$WorkforceMetricsImpl;

  factory _WorkforceMetrics.fromJson(Map<String, dynamic> json) =
      _$WorkforceMetricsImpl.fromJson;

  @override
  int get total;
  @override
  double get utilization;
  @override
  double get productivity;
  @override
  double get satisfaction;
  @override
  double get turnover;
  @override
  @JsonKey(ignore: true)
  _$$WorkforceMetricsImplCopyWith<_$WorkforceMetricsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TrendData _$TrendDataFromJson(Map<String, dynamic> json) {
  return _TrendData.fromJson(json);
}

/// @nodoc
mixin _$TrendData {
  String get direction => throw _privateConstructorUsedError;
  double get change => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TrendDataCopyWith<TrendData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrendDataCopyWith<$Res> {
  factory $TrendDataCopyWith(TrendData value, $Res Function(TrendData) then) =
      _$TrendDataCopyWithImpl<$Res, TrendData>;
  @useResult
  $Res call({String direction, double change});
}

/// @nodoc
class _$TrendDataCopyWithImpl<$Res, $Val extends TrendData>
    implements $TrendDataCopyWith<$Res> {
  _$TrendDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? direction = null,
    Object? change = null,
  }) {
    return _then(_value.copyWith(
      direction: null == direction
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as String,
      change: null == change
          ? _value.change
          : change // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TrendDataImplCopyWith<$Res>
    implements $TrendDataCopyWith<$Res> {
  factory _$$TrendDataImplCopyWith(
          _$TrendDataImpl value, $Res Function(_$TrendDataImpl) then) =
      __$$TrendDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String direction, double change});
}

/// @nodoc
class __$$TrendDataImplCopyWithImpl<$Res>
    extends _$TrendDataCopyWithImpl<$Res, _$TrendDataImpl>
    implements _$$TrendDataImplCopyWith<$Res> {
  __$$TrendDataImplCopyWithImpl(
      _$TrendDataImpl _value, $Res Function(_$TrendDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? direction = null,
    Object? change = null,
  }) {
    return _then(_$TrendDataImpl(
      direction: null == direction
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as String,
      change: null == change
          ? _value.change
          : change // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TrendDataImpl implements _TrendData {
  const _$TrendDataImpl({required this.direction, required this.change});

  factory _$TrendDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$TrendDataImplFromJson(json);

  @override
  final String direction;
  @override
  final double change;

  @override
  String toString() {
    return 'TrendData(direction: $direction, change: $change)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TrendDataImpl &&
            (identical(other.direction, direction) ||
                other.direction == direction) &&
            (identical(other.change, change) || other.change == change));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, direction, change);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TrendDataImplCopyWith<_$TrendDataImpl> get copyWith =>
      __$$TrendDataImplCopyWithImpl<_$TrendDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TrendDataImplToJson(
      this,
    );
  }
}

abstract class _TrendData implements TrendData {
  const factory _TrendData(
      {required final String direction,
      required final double change}) = _$TrendDataImpl;

  factory _TrendData.fromJson(Map<String, dynamic> json) =
      _$TrendDataImpl.fromJson;

  @override
  String get direction;
  @override
  double get change;
  @override
  @JsonKey(ignore: true)
  _$$TrendDataImplCopyWith<_$TrendDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RevenueForecast _$RevenueForecastFromJson(Map<String, dynamic> json) {
  return _RevenueForecast.fromJson(json);
}

/// @nodoc
mixin _$RevenueForecast {
  int get period => throw _privateConstructorUsedError;
  double get predicted => throw _privateConstructorUsedError;
  double get lower => throw _privateConstructorUsedError;
  double get upper => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RevenueForecastCopyWith<RevenueForecast> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RevenueForecastCopyWith<$Res> {
  factory $RevenueForecastCopyWith(
          RevenueForecast value, $Res Function(RevenueForecast) then) =
      _$RevenueForecastCopyWithImpl<$Res, RevenueForecast>;
  @useResult
  $Res call({int period, double predicted, double lower, double upper});
}

/// @nodoc
class _$RevenueForecastCopyWithImpl<$Res, $Val extends RevenueForecast>
    implements $RevenueForecastCopyWith<$Res> {
  _$RevenueForecastCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? period = null,
    Object? predicted = null,
    Object? lower = null,
    Object? upper = null,
  }) {
    return _then(_value.copyWith(
      period: null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as int,
      predicted: null == predicted
          ? _value.predicted
          : predicted // ignore: cast_nullable_to_non_nullable
              as double,
      lower: null == lower
          ? _value.lower
          : lower // ignore: cast_nullable_to_non_nullable
              as double,
      upper: null == upper
          ? _value.upper
          : upper // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RevenueForecastImplCopyWith<$Res>
    implements $RevenueForecastCopyWith<$Res> {
  factory _$$RevenueForecastImplCopyWith(_$RevenueForecastImpl value,
          $Res Function(_$RevenueForecastImpl) then) =
      __$$RevenueForecastImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int period, double predicted, double lower, double upper});
}

/// @nodoc
class __$$RevenueForecastImplCopyWithImpl<$Res>
    extends _$RevenueForecastCopyWithImpl<$Res, _$RevenueForecastImpl>
    implements _$$RevenueForecastImplCopyWith<$Res> {
  __$$RevenueForecastImplCopyWithImpl(
      _$RevenueForecastImpl _value, $Res Function(_$RevenueForecastImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? period = null,
    Object? predicted = null,
    Object? lower = null,
    Object? upper = null,
  }) {
    return _then(_$RevenueForecastImpl(
      period: null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as int,
      predicted: null == predicted
          ? _value.predicted
          : predicted // ignore: cast_nullable_to_non_nullable
              as double,
      lower: null == lower
          ? _value.lower
          : lower // ignore: cast_nullable_to_non_nullable
              as double,
      upper: null == upper
          ? _value.upper
          : upper // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RevenueForecastImpl implements _RevenueForecast {
  const _$RevenueForecastImpl(
      {required this.period,
      required this.predicted,
      required this.lower,
      required this.upper});

  factory _$RevenueForecastImpl.fromJson(Map<String, dynamic> json) =>
      _$$RevenueForecastImplFromJson(json);

  @override
  final int period;
  @override
  final double predicted;
  @override
  final double lower;
  @override
  final double upper;

  @override
  String toString() {
    return 'RevenueForecast(period: $period, predicted: $predicted, lower: $lower, upper: $upper)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RevenueForecastImpl &&
            (identical(other.period, period) || other.period == period) &&
            (identical(other.predicted, predicted) ||
                other.predicted == predicted) &&
            (identical(other.lower, lower) || other.lower == lower) &&
            (identical(other.upper, upper) || other.upper == upper));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, period, predicted, lower, upper);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RevenueForecastImplCopyWith<_$RevenueForecastImpl> get copyWith =>
      __$$RevenueForecastImplCopyWithImpl<_$RevenueForecastImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RevenueForecastImplToJson(
      this,
    );
  }
}

abstract class _RevenueForecast implements RevenueForecast {
  const factory _RevenueForecast(
      {required final int period,
      required final double predicted,
      required final double lower,
      required final double upper}) = _$RevenueForecastImpl;

  factory _RevenueForecast.fromJson(Map<String, dynamic> json) =
      _$RevenueForecastImpl.fromJson;

  @override
  int get period;
  @override
  double get predicted;
  @override
  double get lower;
  @override
  double get upper;
  @override
  @JsonKey(ignore: true)
  _$$RevenueForecastImplCopyWith<_$RevenueForecastImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ChurnPrediction _$ChurnPredictionFromJson(Map<String, dynamic> json) {
  return _ChurnPrediction.fromJson(json);
}

/// @nodoc
mixin _$ChurnPrediction {
  String get clientId => throw _privateConstructorUsedError;
  String get clientName => throw _privateConstructorUsedError;
  double get churnScore => throw _privateConstructorUsedError;
  String get churnRisk => throw _privateConstructorUsedError;
  ChurnFactors get factors => throw _privateConstructorUsedError;
  List<ChurnIntervention> get interventions =>
      throw _privateConstructorUsedError;
  double get lifetimeValue => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChurnPredictionCopyWith<ChurnPrediction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChurnPredictionCopyWith<$Res> {
  factory $ChurnPredictionCopyWith(
          ChurnPrediction value, $Res Function(ChurnPrediction) then) =
      _$ChurnPredictionCopyWithImpl<$Res, ChurnPrediction>;
  @useResult
  $Res call(
      {String clientId,
      String clientName,
      double churnScore,
      String churnRisk,
      ChurnFactors factors,
      List<ChurnIntervention> interventions,
      double lifetimeValue});

  $ChurnFactorsCopyWith<$Res> get factors;
}

/// @nodoc
class _$ChurnPredictionCopyWithImpl<$Res, $Val extends ChurnPrediction>
    implements $ChurnPredictionCopyWith<$Res> {
  _$ChurnPredictionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clientId = null,
    Object? clientName = null,
    Object? churnScore = null,
    Object? churnRisk = null,
    Object? factors = null,
    Object? interventions = null,
    Object? lifetimeValue = null,
  }) {
    return _then(_value.copyWith(
      clientId: null == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      clientName: null == clientName
          ? _value.clientName
          : clientName // ignore: cast_nullable_to_non_nullable
              as String,
      churnScore: null == churnScore
          ? _value.churnScore
          : churnScore // ignore: cast_nullable_to_non_nullable
              as double,
      churnRisk: null == churnRisk
          ? _value.churnRisk
          : churnRisk // ignore: cast_nullable_to_non_nullable
              as String,
      factors: null == factors
          ? _value.factors
          : factors // ignore: cast_nullable_to_non_nullable
              as ChurnFactors,
      interventions: null == interventions
          ? _value.interventions
          : interventions // ignore: cast_nullable_to_non_nullable
              as List<ChurnIntervention>,
      lifetimeValue: null == lifetimeValue
          ? _value.lifetimeValue
          : lifetimeValue // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ChurnFactorsCopyWith<$Res> get factors {
    return $ChurnFactorsCopyWith<$Res>(_value.factors, (value) {
      return _then(_value.copyWith(factors: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ChurnPredictionImplCopyWith<$Res>
    implements $ChurnPredictionCopyWith<$Res> {
  factory _$$ChurnPredictionImplCopyWith(_$ChurnPredictionImpl value,
          $Res Function(_$ChurnPredictionImpl) then) =
      __$$ChurnPredictionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String clientId,
      String clientName,
      double churnScore,
      String churnRisk,
      ChurnFactors factors,
      List<ChurnIntervention> interventions,
      double lifetimeValue});

  @override
  $ChurnFactorsCopyWith<$Res> get factors;
}

/// @nodoc
class __$$ChurnPredictionImplCopyWithImpl<$Res>
    extends _$ChurnPredictionCopyWithImpl<$Res, _$ChurnPredictionImpl>
    implements _$$ChurnPredictionImplCopyWith<$Res> {
  __$$ChurnPredictionImplCopyWithImpl(
      _$ChurnPredictionImpl _value, $Res Function(_$ChurnPredictionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clientId = null,
    Object? clientName = null,
    Object? churnScore = null,
    Object? churnRisk = null,
    Object? factors = null,
    Object? interventions = null,
    Object? lifetimeValue = null,
  }) {
    return _then(_$ChurnPredictionImpl(
      clientId: null == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      clientName: null == clientName
          ? _value.clientName
          : clientName // ignore: cast_nullable_to_non_nullable
              as String,
      churnScore: null == churnScore
          ? _value.churnScore
          : churnScore // ignore: cast_nullable_to_non_nullable
              as double,
      churnRisk: null == churnRisk
          ? _value.churnRisk
          : churnRisk // ignore: cast_nullable_to_non_nullable
              as String,
      factors: null == factors
          ? _value.factors
          : factors // ignore: cast_nullable_to_non_nullable
              as ChurnFactors,
      interventions: null == interventions
          ? _value._interventions
          : interventions // ignore: cast_nullable_to_non_nullable
              as List<ChurnIntervention>,
      lifetimeValue: null == lifetimeValue
          ? _value.lifetimeValue
          : lifetimeValue // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChurnPredictionImpl implements _ChurnPrediction {
  const _$ChurnPredictionImpl(
      {required this.clientId,
      required this.clientName,
      required this.churnScore,
      required this.churnRisk,
      required this.factors,
      required final List<ChurnIntervention> interventions,
      required this.lifetimeValue})
      : _interventions = interventions;

  factory _$ChurnPredictionImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChurnPredictionImplFromJson(json);

  @override
  final String clientId;
  @override
  final String clientName;
  @override
  final double churnScore;
  @override
  final String churnRisk;
  @override
  final ChurnFactors factors;
  final List<ChurnIntervention> _interventions;
  @override
  List<ChurnIntervention> get interventions {
    if (_interventions is EqualUnmodifiableListView) return _interventions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_interventions);
  }

  @override
  final double lifetimeValue;

  @override
  String toString() {
    return 'ChurnPrediction(clientId: $clientId, clientName: $clientName, churnScore: $churnScore, churnRisk: $churnRisk, factors: $factors, interventions: $interventions, lifetimeValue: $lifetimeValue)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChurnPredictionImpl &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.clientName, clientName) ||
                other.clientName == clientName) &&
            (identical(other.churnScore, churnScore) ||
                other.churnScore == churnScore) &&
            (identical(other.churnRisk, churnRisk) ||
                other.churnRisk == churnRisk) &&
            (identical(other.factors, factors) || other.factors == factors) &&
            const DeepCollectionEquality()
                .equals(other._interventions, _interventions) &&
            (identical(other.lifetimeValue, lifetimeValue) ||
                other.lifetimeValue == lifetimeValue));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      clientId,
      clientName,
      churnScore,
      churnRisk,
      factors,
      const DeepCollectionEquality().hash(_interventions),
      lifetimeValue);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChurnPredictionImplCopyWith<_$ChurnPredictionImpl> get copyWith =>
      __$$ChurnPredictionImplCopyWithImpl<_$ChurnPredictionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChurnPredictionImplToJson(
      this,
    );
  }
}

abstract class _ChurnPrediction implements ChurnPrediction {
  const factory _ChurnPrediction(
      {required final String clientId,
      required final String clientName,
      required final double churnScore,
      required final String churnRisk,
      required final ChurnFactors factors,
      required final List<ChurnIntervention> interventions,
      required final double lifetimeValue}) = _$ChurnPredictionImpl;

  factory _ChurnPrediction.fromJson(Map<String, dynamic> json) =
      _$ChurnPredictionImpl.fromJson;

  @override
  String get clientId;
  @override
  String get clientName;
  @override
  double get churnScore;
  @override
  String get churnRisk;
  @override
  ChurnFactors get factors;
  @override
  List<ChurnIntervention> get interventions;
  @override
  double get lifetimeValue;
  @override
  @JsonKey(ignore: true)
  _$$ChurnPredictionImplCopyWith<_$ChurnPredictionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ChurnFactors _$ChurnFactorsFromJson(Map<String, dynamic> json) {
  return _ChurnFactors.fromJson(json);
}

/// @nodoc
mixin _$ChurnFactors {
  double get recency => throw _privateConstructorUsedError;
  double get frequency => throw _privateConstructorUsedError;
  double get monetary => throw _privateConstructorUsedError;
  double get satisfaction => throw _privateConstructorUsedError;
  double get engagement => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChurnFactorsCopyWith<ChurnFactors> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChurnFactorsCopyWith<$Res> {
  factory $ChurnFactorsCopyWith(
          ChurnFactors value, $Res Function(ChurnFactors) then) =
      _$ChurnFactorsCopyWithImpl<$Res, ChurnFactors>;
  @useResult
  $Res call(
      {double recency,
      double frequency,
      double monetary,
      double satisfaction,
      double engagement});
}

/// @nodoc
class _$ChurnFactorsCopyWithImpl<$Res, $Val extends ChurnFactors>
    implements $ChurnFactorsCopyWith<$Res> {
  _$ChurnFactorsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? recency = null,
    Object? frequency = null,
    Object? monetary = null,
    Object? satisfaction = null,
    Object? engagement = null,
  }) {
    return _then(_value.copyWith(
      recency: null == recency
          ? _value.recency
          : recency // ignore: cast_nullable_to_non_nullable
              as double,
      frequency: null == frequency
          ? _value.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as double,
      monetary: null == monetary
          ? _value.monetary
          : monetary // ignore: cast_nullable_to_non_nullable
              as double,
      satisfaction: null == satisfaction
          ? _value.satisfaction
          : satisfaction // ignore: cast_nullable_to_non_nullable
              as double,
      engagement: null == engagement
          ? _value.engagement
          : engagement // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChurnFactorsImplCopyWith<$Res>
    implements $ChurnFactorsCopyWith<$Res> {
  factory _$$ChurnFactorsImplCopyWith(
          _$ChurnFactorsImpl value, $Res Function(_$ChurnFactorsImpl) then) =
      __$$ChurnFactorsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double recency,
      double frequency,
      double monetary,
      double satisfaction,
      double engagement});
}

/// @nodoc
class __$$ChurnFactorsImplCopyWithImpl<$Res>
    extends _$ChurnFactorsCopyWithImpl<$Res, _$ChurnFactorsImpl>
    implements _$$ChurnFactorsImplCopyWith<$Res> {
  __$$ChurnFactorsImplCopyWithImpl(
      _$ChurnFactorsImpl _value, $Res Function(_$ChurnFactorsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? recency = null,
    Object? frequency = null,
    Object? monetary = null,
    Object? satisfaction = null,
    Object? engagement = null,
  }) {
    return _then(_$ChurnFactorsImpl(
      recency: null == recency
          ? _value.recency
          : recency // ignore: cast_nullable_to_non_nullable
              as double,
      frequency: null == frequency
          ? _value.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as double,
      monetary: null == monetary
          ? _value.monetary
          : monetary // ignore: cast_nullable_to_non_nullable
              as double,
      satisfaction: null == satisfaction
          ? _value.satisfaction
          : satisfaction // ignore: cast_nullable_to_non_nullable
              as double,
      engagement: null == engagement
          ? _value.engagement
          : engagement // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChurnFactorsImpl implements _ChurnFactors {
  const _$ChurnFactorsImpl(
      {required this.recency,
      required this.frequency,
      required this.monetary,
      required this.satisfaction,
      required this.engagement});

  factory _$ChurnFactorsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChurnFactorsImplFromJson(json);

  @override
  final double recency;
  @override
  final double frequency;
  @override
  final double monetary;
  @override
  final double satisfaction;
  @override
  final double engagement;

  @override
  String toString() {
    return 'ChurnFactors(recency: $recency, frequency: $frequency, monetary: $monetary, satisfaction: $satisfaction, engagement: $engagement)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChurnFactorsImpl &&
            (identical(other.recency, recency) || other.recency == recency) &&
            (identical(other.frequency, frequency) ||
                other.frequency == frequency) &&
            (identical(other.monetary, monetary) ||
                other.monetary == monetary) &&
            (identical(other.satisfaction, satisfaction) ||
                other.satisfaction == satisfaction) &&
            (identical(other.engagement, engagement) ||
                other.engagement == engagement));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, recency, frequency, monetary, satisfaction, engagement);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChurnFactorsImplCopyWith<_$ChurnFactorsImpl> get copyWith =>
      __$$ChurnFactorsImplCopyWithImpl<_$ChurnFactorsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChurnFactorsImplToJson(
      this,
    );
  }
}

abstract class _ChurnFactors implements ChurnFactors {
  const factory _ChurnFactors(
      {required final double recency,
      required final double frequency,
      required final double monetary,
      required final double satisfaction,
      required final double engagement}) = _$ChurnFactorsImpl;

  factory _ChurnFactors.fromJson(Map<String, dynamic> json) =
      _$ChurnFactorsImpl.fromJson;

  @override
  double get recency;
  @override
  double get frequency;
  @override
  double get monetary;
  @override
  double get satisfaction;
  @override
  double get engagement;
  @override
  @JsonKey(ignore: true)
  _$$ChurnFactorsImplCopyWith<_$ChurnFactorsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ChurnIntervention _$ChurnInterventionFromJson(Map<String, dynamic> json) {
  return _ChurnIntervention.fromJson(json);
}

/// @nodoc
mixin _$ChurnIntervention {
  String get action => throw _privateConstructorUsedError;
  String get priority => throw _privateConstructorUsedError;
  String get expectedImpact => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChurnInterventionCopyWith<ChurnIntervention> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChurnInterventionCopyWith<$Res> {
  factory $ChurnInterventionCopyWith(
          ChurnIntervention value, $Res Function(ChurnIntervention) then) =
      _$ChurnInterventionCopyWithImpl<$Res, ChurnIntervention>;
  @useResult
  $Res call({String action, String priority, String expectedImpact});
}

/// @nodoc
class _$ChurnInterventionCopyWithImpl<$Res, $Val extends ChurnIntervention>
    implements $ChurnInterventionCopyWith<$Res> {
  _$ChurnInterventionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? action = null,
    Object? priority = null,
    Object? expectedImpact = null,
  }) {
    return _then(_value.copyWith(
      action: null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as String,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as String,
      expectedImpact: null == expectedImpact
          ? _value.expectedImpact
          : expectedImpact // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChurnInterventionImplCopyWith<$Res>
    implements $ChurnInterventionCopyWith<$Res> {
  factory _$$ChurnInterventionImplCopyWith(_$ChurnInterventionImpl value,
          $Res Function(_$ChurnInterventionImpl) then) =
      __$$ChurnInterventionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String action, String priority, String expectedImpact});
}

/// @nodoc
class __$$ChurnInterventionImplCopyWithImpl<$Res>
    extends _$ChurnInterventionCopyWithImpl<$Res, _$ChurnInterventionImpl>
    implements _$$ChurnInterventionImplCopyWith<$Res> {
  __$$ChurnInterventionImplCopyWithImpl(_$ChurnInterventionImpl _value,
      $Res Function(_$ChurnInterventionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? action = null,
    Object? priority = null,
    Object? expectedImpact = null,
  }) {
    return _then(_$ChurnInterventionImpl(
      action: null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as String,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as String,
      expectedImpact: null == expectedImpact
          ? _value.expectedImpact
          : expectedImpact // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChurnInterventionImpl implements _ChurnIntervention {
  const _$ChurnInterventionImpl(
      {required this.action,
      required this.priority,
      required this.expectedImpact});

  factory _$ChurnInterventionImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChurnInterventionImplFromJson(json);

  @override
  final String action;
  @override
  final String priority;
  @override
  final String expectedImpact;

  @override
  String toString() {
    return 'ChurnIntervention(action: $action, priority: $priority, expectedImpact: $expectedImpact)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChurnInterventionImpl &&
            (identical(other.action, action) || other.action == action) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.expectedImpact, expectedImpact) ||
                other.expectedImpact == expectedImpact));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, action, priority, expectedImpact);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChurnInterventionImplCopyWith<_$ChurnInterventionImpl> get copyWith =>
      __$$ChurnInterventionImplCopyWithImpl<_$ChurnInterventionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChurnInterventionImplToJson(
      this,
    );
  }
}

abstract class _ChurnIntervention implements ChurnIntervention {
  const factory _ChurnIntervention(
      {required final String action,
      required final String priority,
      required final String expectedImpact}) = _$ChurnInterventionImpl;

  factory _ChurnIntervention.fromJson(Map<String, dynamic> json) =
      _$ChurnInterventionImpl.fromJson;

  @override
  String get action;
  @override
  String get priority;
  @override
  String get expectedImpact;
  @override
  @JsonKey(ignore: true)
  _$$ChurnInterventionImplCopyWith<_$ChurnInterventionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ProfitabilityAnalysis _$ProfitabilityAnalysisFromJson(
    Map<String, dynamic> json) {
  return _ProfitabilityAnalysis.fromJson(json);
}

/// @nodoc
mixin _$ProfitabilityAnalysis {
  String get dimension => throw _privateConstructorUsedError;
  double get revenue => throw _privateConstructorUsedError;
  double get cost => throw _privateConstructorUsedError;
  double get profit => throw _privateConstructorUsedError;
  double get margin => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProfitabilityAnalysisCopyWith<ProfitabilityAnalysis> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfitabilityAnalysisCopyWith<$Res> {
  factory $ProfitabilityAnalysisCopyWith(ProfitabilityAnalysis value,
          $Res Function(ProfitabilityAnalysis) then) =
      _$ProfitabilityAnalysisCopyWithImpl<$Res, ProfitabilityAnalysis>;
  @useResult
  $Res call(
      {String dimension,
      double revenue,
      double cost,
      double profit,
      double margin,
      int count});
}

/// @nodoc
class _$ProfitabilityAnalysisCopyWithImpl<$Res,
        $Val extends ProfitabilityAnalysis>
    implements $ProfitabilityAnalysisCopyWith<$Res> {
  _$ProfitabilityAnalysisCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dimension = null,
    Object? revenue = null,
    Object? cost = null,
    Object? profit = null,
    Object? margin = null,
    Object? count = null,
  }) {
    return _then(_value.copyWith(
      dimension: null == dimension
          ? _value.dimension
          : dimension // ignore: cast_nullable_to_non_nullable
              as String,
      revenue: null == revenue
          ? _value.revenue
          : revenue // ignore: cast_nullable_to_non_nullable
              as double,
      cost: null == cost
          ? _value.cost
          : cost // ignore: cast_nullable_to_non_nullable
              as double,
      profit: null == profit
          ? _value.profit
          : profit // ignore: cast_nullable_to_non_nullable
              as double,
      margin: null == margin
          ? _value.margin
          : margin // ignore: cast_nullable_to_non_nullable
              as double,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProfitabilityAnalysisImplCopyWith<$Res>
    implements $ProfitabilityAnalysisCopyWith<$Res> {
  factory _$$ProfitabilityAnalysisImplCopyWith(
          _$ProfitabilityAnalysisImpl value,
          $Res Function(_$ProfitabilityAnalysisImpl) then) =
      __$$ProfitabilityAnalysisImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String dimension,
      double revenue,
      double cost,
      double profit,
      double margin,
      int count});
}

/// @nodoc
class __$$ProfitabilityAnalysisImplCopyWithImpl<$Res>
    extends _$ProfitabilityAnalysisCopyWithImpl<$Res,
        _$ProfitabilityAnalysisImpl>
    implements _$$ProfitabilityAnalysisImplCopyWith<$Res> {
  __$$ProfitabilityAnalysisImplCopyWithImpl(_$ProfitabilityAnalysisImpl _value,
      $Res Function(_$ProfitabilityAnalysisImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dimension = null,
    Object? revenue = null,
    Object? cost = null,
    Object? profit = null,
    Object? margin = null,
    Object? count = null,
  }) {
    return _then(_$ProfitabilityAnalysisImpl(
      dimension: null == dimension
          ? _value.dimension
          : dimension // ignore: cast_nullable_to_non_nullable
              as String,
      revenue: null == revenue
          ? _value.revenue
          : revenue // ignore: cast_nullable_to_non_nullable
              as double,
      cost: null == cost
          ? _value.cost
          : cost // ignore: cast_nullable_to_non_nullable
              as double,
      profit: null == profit
          ? _value.profit
          : profit // ignore: cast_nullable_to_non_nullable
              as double,
      margin: null == margin
          ? _value.margin
          : margin // ignore: cast_nullable_to_non_nullable
              as double,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProfitabilityAnalysisImpl implements _ProfitabilityAnalysis {
  const _$ProfitabilityAnalysisImpl(
      {required this.dimension,
      required this.revenue,
      required this.cost,
      required this.profit,
      required this.margin,
      required this.count});

  factory _$ProfitabilityAnalysisImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProfitabilityAnalysisImplFromJson(json);

  @override
  final String dimension;
  @override
  final double revenue;
  @override
  final double cost;
  @override
  final double profit;
  @override
  final double margin;
  @override
  final int count;

  @override
  String toString() {
    return 'ProfitabilityAnalysis(dimension: $dimension, revenue: $revenue, cost: $cost, profit: $profit, margin: $margin, count: $count)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfitabilityAnalysisImpl &&
            (identical(other.dimension, dimension) ||
                other.dimension == dimension) &&
            (identical(other.revenue, revenue) || other.revenue == revenue) &&
            (identical(other.cost, cost) || other.cost == cost) &&
            (identical(other.profit, profit) || other.profit == profit) &&
            (identical(other.margin, margin) || other.margin == margin) &&
            (identical(other.count, count) || other.count == count));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, dimension, revenue, cost, profit, margin, count);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfitabilityAnalysisImplCopyWith<_$ProfitabilityAnalysisImpl>
      get copyWith => __$$ProfitabilityAnalysisImplCopyWithImpl<
          _$ProfitabilityAnalysisImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProfitabilityAnalysisImplToJson(
      this,
    );
  }
}

abstract class _ProfitabilityAnalysis implements ProfitabilityAnalysis {
  const factory _ProfitabilityAnalysis(
      {required final String dimension,
      required final double revenue,
      required final double cost,
      required final double profit,
      required final double margin,
      required final int count}) = _$ProfitabilityAnalysisImpl;

  factory _ProfitabilityAnalysis.fromJson(Map<String, dynamic> json) =
      _$ProfitabilityAnalysisImpl.fromJson;

  @override
  String get dimension;
  @override
  double get revenue;
  @override
  double get cost;
  @override
  double get profit;
  @override
  double get margin;
  @override
  int get count;
  @override
  @JsonKey(ignore: true)
  _$$ProfitabilityAnalysisImplCopyWith<_$ProfitabilityAnalysisImpl>
      get copyWith => throw _privateConstructorUsedError;
}

WhatIfScenario _$WhatIfScenarioFromJson(Map<String, dynamic> json) {
  return _WhatIfScenario.fromJson(json);
}

/// @nodoc
mixin _$WhatIfScenario {
  String get name => throw _privateConstructorUsedError;
  ScenarioMetrics get baseline => throw _privateConstructorUsedError;
  ScenarioMetrics get projected => throw _privateConstructorUsedError;
  ScenarioImpact get impact => throw _privateConstructorUsedError;
  ScenarioFeasibility get feasibility => throw _privateConstructorUsedError;
  ScenarioRecommendation get recommendation =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WhatIfScenarioCopyWith<WhatIfScenario> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WhatIfScenarioCopyWith<$Res> {
  factory $WhatIfScenarioCopyWith(
          WhatIfScenario value, $Res Function(WhatIfScenario) then) =
      _$WhatIfScenarioCopyWithImpl<$Res, WhatIfScenario>;
  @useResult
  $Res call(
      {String name,
      ScenarioMetrics baseline,
      ScenarioMetrics projected,
      ScenarioImpact impact,
      ScenarioFeasibility feasibility,
      ScenarioRecommendation recommendation});

  $ScenarioMetricsCopyWith<$Res> get baseline;
  $ScenarioMetricsCopyWith<$Res> get projected;
  $ScenarioImpactCopyWith<$Res> get impact;
  $ScenarioFeasibilityCopyWith<$Res> get feasibility;
  $ScenarioRecommendationCopyWith<$Res> get recommendation;
}

/// @nodoc
class _$WhatIfScenarioCopyWithImpl<$Res, $Val extends WhatIfScenario>
    implements $WhatIfScenarioCopyWith<$Res> {
  _$WhatIfScenarioCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? baseline = null,
    Object? projected = null,
    Object? impact = null,
    Object? feasibility = null,
    Object? recommendation = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      baseline: null == baseline
          ? _value.baseline
          : baseline // ignore: cast_nullable_to_non_nullable
              as ScenarioMetrics,
      projected: null == projected
          ? _value.projected
          : projected // ignore: cast_nullable_to_non_nullable
              as ScenarioMetrics,
      impact: null == impact
          ? _value.impact
          : impact // ignore: cast_nullable_to_non_nullable
              as ScenarioImpact,
      feasibility: null == feasibility
          ? _value.feasibility
          : feasibility // ignore: cast_nullable_to_non_nullable
              as ScenarioFeasibility,
      recommendation: null == recommendation
          ? _value.recommendation
          : recommendation // ignore: cast_nullable_to_non_nullable
              as ScenarioRecommendation,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ScenarioMetricsCopyWith<$Res> get baseline {
    return $ScenarioMetricsCopyWith<$Res>(_value.baseline, (value) {
      return _then(_value.copyWith(baseline: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ScenarioMetricsCopyWith<$Res> get projected {
    return $ScenarioMetricsCopyWith<$Res>(_value.projected, (value) {
      return _then(_value.copyWith(projected: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ScenarioImpactCopyWith<$Res> get impact {
    return $ScenarioImpactCopyWith<$Res>(_value.impact, (value) {
      return _then(_value.copyWith(impact: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ScenarioFeasibilityCopyWith<$Res> get feasibility {
    return $ScenarioFeasibilityCopyWith<$Res>(_value.feasibility, (value) {
      return _then(_value.copyWith(feasibility: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ScenarioRecommendationCopyWith<$Res> get recommendation {
    return $ScenarioRecommendationCopyWith<$Res>(_value.recommendation,
        (value) {
      return _then(_value.copyWith(recommendation: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$WhatIfScenarioImplCopyWith<$Res>
    implements $WhatIfScenarioCopyWith<$Res> {
  factory _$$WhatIfScenarioImplCopyWith(_$WhatIfScenarioImpl value,
          $Res Function(_$WhatIfScenarioImpl) then) =
      __$$WhatIfScenarioImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      ScenarioMetrics baseline,
      ScenarioMetrics projected,
      ScenarioImpact impact,
      ScenarioFeasibility feasibility,
      ScenarioRecommendation recommendation});

  @override
  $ScenarioMetricsCopyWith<$Res> get baseline;
  @override
  $ScenarioMetricsCopyWith<$Res> get projected;
  @override
  $ScenarioImpactCopyWith<$Res> get impact;
  @override
  $ScenarioFeasibilityCopyWith<$Res> get feasibility;
  @override
  $ScenarioRecommendationCopyWith<$Res> get recommendation;
}

/// @nodoc
class __$$WhatIfScenarioImplCopyWithImpl<$Res>
    extends _$WhatIfScenarioCopyWithImpl<$Res, _$WhatIfScenarioImpl>
    implements _$$WhatIfScenarioImplCopyWith<$Res> {
  __$$WhatIfScenarioImplCopyWithImpl(
      _$WhatIfScenarioImpl _value, $Res Function(_$WhatIfScenarioImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? baseline = null,
    Object? projected = null,
    Object? impact = null,
    Object? feasibility = null,
    Object? recommendation = null,
  }) {
    return _then(_$WhatIfScenarioImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      baseline: null == baseline
          ? _value.baseline
          : baseline // ignore: cast_nullable_to_non_nullable
              as ScenarioMetrics,
      projected: null == projected
          ? _value.projected
          : projected // ignore: cast_nullable_to_non_nullable
              as ScenarioMetrics,
      impact: null == impact
          ? _value.impact
          : impact // ignore: cast_nullable_to_non_nullable
              as ScenarioImpact,
      feasibility: null == feasibility
          ? _value.feasibility
          : feasibility // ignore: cast_nullable_to_non_nullable
              as ScenarioFeasibility,
      recommendation: null == recommendation
          ? _value.recommendation
          : recommendation // ignore: cast_nullable_to_non_nullable
              as ScenarioRecommendation,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WhatIfScenarioImpl implements _WhatIfScenario {
  const _$WhatIfScenarioImpl(
      {required this.name,
      required this.baseline,
      required this.projected,
      required this.impact,
      required this.feasibility,
      required this.recommendation});

  factory _$WhatIfScenarioImpl.fromJson(Map<String, dynamic> json) =>
      _$$WhatIfScenarioImplFromJson(json);

  @override
  final String name;
  @override
  final ScenarioMetrics baseline;
  @override
  final ScenarioMetrics projected;
  @override
  final ScenarioImpact impact;
  @override
  final ScenarioFeasibility feasibility;
  @override
  final ScenarioRecommendation recommendation;

  @override
  String toString() {
    return 'WhatIfScenario(name: $name, baseline: $baseline, projected: $projected, impact: $impact, feasibility: $feasibility, recommendation: $recommendation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WhatIfScenarioImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.baseline, baseline) ||
                other.baseline == baseline) &&
            (identical(other.projected, projected) ||
                other.projected == projected) &&
            (identical(other.impact, impact) || other.impact == impact) &&
            (identical(other.feasibility, feasibility) ||
                other.feasibility == feasibility) &&
            (identical(other.recommendation, recommendation) ||
                other.recommendation == recommendation));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, baseline, projected,
      impact, feasibility, recommendation);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WhatIfScenarioImplCopyWith<_$WhatIfScenarioImpl> get copyWith =>
      __$$WhatIfScenarioImplCopyWithImpl<_$WhatIfScenarioImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WhatIfScenarioImplToJson(
      this,
    );
  }
}

abstract class _WhatIfScenario implements WhatIfScenario {
  const factory _WhatIfScenario(
          {required final String name,
          required final ScenarioMetrics baseline,
          required final ScenarioMetrics projected,
          required final ScenarioImpact impact,
          required final ScenarioFeasibility feasibility,
          required final ScenarioRecommendation recommendation}) =
      _$WhatIfScenarioImpl;

  factory _WhatIfScenario.fromJson(Map<String, dynamic> json) =
      _$WhatIfScenarioImpl.fromJson;

  @override
  String get name;
  @override
  ScenarioMetrics get baseline;
  @override
  ScenarioMetrics get projected;
  @override
  ScenarioImpact get impact;
  @override
  ScenarioFeasibility get feasibility;
  @override
  ScenarioRecommendation get recommendation;
  @override
  @JsonKey(ignore: true)
  _$$WhatIfScenarioImplCopyWith<_$WhatIfScenarioImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ScenarioMetrics _$ScenarioMetricsFromJson(Map<String, dynamic> json) {
  return _ScenarioMetrics.fromJson(json);
}

/// @nodoc
mixin _$ScenarioMetrics {
  int get appointments => throw _privateConstructorUsedError;
  int get workers => throw _privateConstructorUsedError;
  double get revenue => throw _privateConstructorUsedError;
  double get avgRevenuePerWorker => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ScenarioMetricsCopyWith<ScenarioMetrics> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScenarioMetricsCopyWith<$Res> {
  factory $ScenarioMetricsCopyWith(
          ScenarioMetrics value, $Res Function(ScenarioMetrics) then) =
      _$ScenarioMetricsCopyWithImpl<$Res, ScenarioMetrics>;
  @useResult
  $Res call(
      {int appointments,
      int workers,
      double revenue,
      double avgRevenuePerWorker});
}

/// @nodoc
class _$ScenarioMetricsCopyWithImpl<$Res, $Val extends ScenarioMetrics>
    implements $ScenarioMetricsCopyWith<$Res> {
  _$ScenarioMetricsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appointments = null,
    Object? workers = null,
    Object? revenue = null,
    Object? avgRevenuePerWorker = null,
  }) {
    return _then(_value.copyWith(
      appointments: null == appointments
          ? _value.appointments
          : appointments // ignore: cast_nullable_to_non_nullable
              as int,
      workers: null == workers
          ? _value.workers
          : workers // ignore: cast_nullable_to_non_nullable
              as int,
      revenue: null == revenue
          ? _value.revenue
          : revenue // ignore: cast_nullable_to_non_nullable
              as double,
      avgRevenuePerWorker: null == avgRevenuePerWorker
          ? _value.avgRevenuePerWorker
          : avgRevenuePerWorker // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ScenarioMetricsImplCopyWith<$Res>
    implements $ScenarioMetricsCopyWith<$Res> {
  factory _$$ScenarioMetricsImplCopyWith(_$ScenarioMetricsImpl value,
          $Res Function(_$ScenarioMetricsImpl) then) =
      __$$ScenarioMetricsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int appointments,
      int workers,
      double revenue,
      double avgRevenuePerWorker});
}

/// @nodoc
class __$$ScenarioMetricsImplCopyWithImpl<$Res>
    extends _$ScenarioMetricsCopyWithImpl<$Res, _$ScenarioMetricsImpl>
    implements _$$ScenarioMetricsImplCopyWith<$Res> {
  __$$ScenarioMetricsImplCopyWithImpl(
      _$ScenarioMetricsImpl _value, $Res Function(_$ScenarioMetricsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appointments = null,
    Object? workers = null,
    Object? revenue = null,
    Object? avgRevenuePerWorker = null,
  }) {
    return _then(_$ScenarioMetricsImpl(
      appointments: null == appointments
          ? _value.appointments
          : appointments // ignore: cast_nullable_to_non_nullable
              as int,
      workers: null == workers
          ? _value.workers
          : workers // ignore: cast_nullable_to_non_nullable
              as int,
      revenue: null == revenue
          ? _value.revenue
          : revenue // ignore: cast_nullable_to_non_nullable
              as double,
      avgRevenuePerWorker: null == avgRevenuePerWorker
          ? _value.avgRevenuePerWorker
          : avgRevenuePerWorker // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ScenarioMetricsImpl implements _ScenarioMetrics {
  const _$ScenarioMetricsImpl(
      {required this.appointments,
      required this.workers,
      required this.revenue,
      required this.avgRevenuePerWorker});

  factory _$ScenarioMetricsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ScenarioMetricsImplFromJson(json);

  @override
  final int appointments;
  @override
  final int workers;
  @override
  final double revenue;
  @override
  final double avgRevenuePerWorker;

  @override
  String toString() {
    return 'ScenarioMetrics(appointments: $appointments, workers: $workers, revenue: $revenue, avgRevenuePerWorker: $avgRevenuePerWorker)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScenarioMetricsImpl &&
            (identical(other.appointments, appointments) ||
                other.appointments == appointments) &&
            (identical(other.workers, workers) || other.workers == workers) &&
            (identical(other.revenue, revenue) || other.revenue == revenue) &&
            (identical(other.avgRevenuePerWorker, avgRevenuePerWorker) ||
                other.avgRevenuePerWorker == avgRevenuePerWorker));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, appointments, workers, revenue, avgRevenuePerWorker);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ScenarioMetricsImplCopyWith<_$ScenarioMetricsImpl> get copyWith =>
      __$$ScenarioMetricsImplCopyWithImpl<_$ScenarioMetricsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ScenarioMetricsImplToJson(
      this,
    );
  }
}

abstract class _ScenarioMetrics implements ScenarioMetrics {
  const factory _ScenarioMetrics(
      {required final int appointments,
      required final int workers,
      required final double revenue,
      required final double avgRevenuePerWorker}) = _$ScenarioMetricsImpl;

  factory _ScenarioMetrics.fromJson(Map<String, dynamic> json) =
      _$ScenarioMetricsImpl.fromJson;

  @override
  int get appointments;
  @override
  int get workers;
  @override
  double get revenue;
  @override
  double get avgRevenuePerWorker;
  @override
  @JsonKey(ignore: true)
  _$$ScenarioMetricsImplCopyWith<_$ScenarioMetricsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ScenarioImpact _$ScenarioImpactFromJson(Map<String, dynamic> json) {
  return _ScenarioImpact.fromJson(json);
}

/// @nodoc
mixin _$ScenarioImpact {
  double get revenueChange => throw _privateConstructorUsedError;
  String get revenueChangePercent => throw _privateConstructorUsedError;
  int get appointmentChange => throw _privateConstructorUsedError;
  int get workerChange => throw _privateConstructorUsedError;
  double get productivityChange => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ScenarioImpactCopyWith<ScenarioImpact> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScenarioImpactCopyWith<$Res> {
  factory $ScenarioImpactCopyWith(
          ScenarioImpact value, $Res Function(ScenarioImpact) then) =
      _$ScenarioImpactCopyWithImpl<$Res, ScenarioImpact>;
  @useResult
  $Res call(
      {double revenueChange,
      String revenueChangePercent,
      int appointmentChange,
      int workerChange,
      double productivityChange});
}

/// @nodoc
class _$ScenarioImpactCopyWithImpl<$Res, $Val extends ScenarioImpact>
    implements $ScenarioImpactCopyWith<$Res> {
  _$ScenarioImpactCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? revenueChange = null,
    Object? revenueChangePercent = null,
    Object? appointmentChange = null,
    Object? workerChange = null,
    Object? productivityChange = null,
  }) {
    return _then(_value.copyWith(
      revenueChange: null == revenueChange
          ? _value.revenueChange
          : revenueChange // ignore: cast_nullable_to_non_nullable
              as double,
      revenueChangePercent: null == revenueChangePercent
          ? _value.revenueChangePercent
          : revenueChangePercent // ignore: cast_nullable_to_non_nullable
              as String,
      appointmentChange: null == appointmentChange
          ? _value.appointmentChange
          : appointmentChange // ignore: cast_nullable_to_non_nullable
              as int,
      workerChange: null == workerChange
          ? _value.workerChange
          : workerChange // ignore: cast_nullable_to_non_nullable
              as int,
      productivityChange: null == productivityChange
          ? _value.productivityChange
          : productivityChange // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ScenarioImpactImplCopyWith<$Res>
    implements $ScenarioImpactCopyWith<$Res> {
  factory _$$ScenarioImpactImplCopyWith(_$ScenarioImpactImpl value,
          $Res Function(_$ScenarioImpactImpl) then) =
      __$$ScenarioImpactImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double revenueChange,
      String revenueChangePercent,
      int appointmentChange,
      int workerChange,
      double productivityChange});
}

/// @nodoc
class __$$ScenarioImpactImplCopyWithImpl<$Res>
    extends _$ScenarioImpactCopyWithImpl<$Res, _$ScenarioImpactImpl>
    implements _$$ScenarioImpactImplCopyWith<$Res> {
  __$$ScenarioImpactImplCopyWithImpl(
      _$ScenarioImpactImpl _value, $Res Function(_$ScenarioImpactImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? revenueChange = null,
    Object? revenueChangePercent = null,
    Object? appointmentChange = null,
    Object? workerChange = null,
    Object? productivityChange = null,
  }) {
    return _then(_$ScenarioImpactImpl(
      revenueChange: null == revenueChange
          ? _value.revenueChange
          : revenueChange // ignore: cast_nullable_to_non_nullable
              as double,
      revenueChangePercent: null == revenueChangePercent
          ? _value.revenueChangePercent
          : revenueChangePercent // ignore: cast_nullable_to_non_nullable
              as String,
      appointmentChange: null == appointmentChange
          ? _value.appointmentChange
          : appointmentChange // ignore: cast_nullable_to_non_nullable
              as int,
      workerChange: null == workerChange
          ? _value.workerChange
          : workerChange // ignore: cast_nullable_to_non_nullable
              as int,
      productivityChange: null == productivityChange
          ? _value.productivityChange
          : productivityChange // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ScenarioImpactImpl implements _ScenarioImpact {
  const _$ScenarioImpactImpl(
      {required this.revenueChange,
      required this.revenueChangePercent,
      required this.appointmentChange,
      required this.workerChange,
      required this.productivityChange});

  factory _$ScenarioImpactImpl.fromJson(Map<String, dynamic> json) =>
      _$$ScenarioImpactImplFromJson(json);

  @override
  final double revenueChange;
  @override
  final String revenueChangePercent;
  @override
  final int appointmentChange;
  @override
  final int workerChange;
  @override
  final double productivityChange;

  @override
  String toString() {
    return 'ScenarioImpact(revenueChange: $revenueChange, revenueChangePercent: $revenueChangePercent, appointmentChange: $appointmentChange, workerChange: $workerChange, productivityChange: $productivityChange)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScenarioImpactImpl &&
            (identical(other.revenueChange, revenueChange) ||
                other.revenueChange == revenueChange) &&
            (identical(other.revenueChangePercent, revenueChangePercent) ||
                other.revenueChangePercent == revenueChangePercent) &&
            (identical(other.appointmentChange, appointmentChange) ||
                other.appointmentChange == appointmentChange) &&
            (identical(other.workerChange, workerChange) ||
                other.workerChange == workerChange) &&
            (identical(other.productivityChange, productivityChange) ||
                other.productivityChange == productivityChange));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      revenueChange,
      revenueChangePercent,
      appointmentChange,
      workerChange,
      productivityChange);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ScenarioImpactImplCopyWith<_$ScenarioImpactImpl> get copyWith =>
      __$$ScenarioImpactImplCopyWithImpl<_$ScenarioImpactImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ScenarioImpactImplToJson(
      this,
    );
  }
}

abstract class _ScenarioImpact implements ScenarioImpact {
  const factory _ScenarioImpact(
      {required final double revenueChange,
      required final String revenueChangePercent,
      required final int appointmentChange,
      required final int workerChange,
      required final double productivityChange}) = _$ScenarioImpactImpl;

  factory _ScenarioImpact.fromJson(Map<String, dynamic> json) =
      _$ScenarioImpactImpl.fromJson;

  @override
  double get revenueChange;
  @override
  String get revenueChangePercent;
  @override
  int get appointmentChange;
  @override
  int get workerChange;
  @override
  double get productivityChange;
  @override
  @JsonKey(ignore: true)
  _$$ScenarioImpactImplCopyWith<_$ScenarioImpactImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ScenarioFeasibility _$ScenarioFeasibilityFromJson(Map<String, dynamic> json) {
  return _ScenarioFeasibility.fromJson(json);
}

/// @nodoc
mixin _$ScenarioFeasibility {
  Map<String, double> get scores => throw _privateConstructorUsedError;
  double get overall => throw _privateConstructorUsedError;
  String get rating => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ScenarioFeasibilityCopyWith<ScenarioFeasibility> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScenarioFeasibilityCopyWith<$Res> {
  factory $ScenarioFeasibilityCopyWith(
          ScenarioFeasibility value, $Res Function(ScenarioFeasibility) then) =
      _$ScenarioFeasibilityCopyWithImpl<$Res, ScenarioFeasibility>;
  @useResult
  $Res call({Map<String, double> scores, double overall, String rating});
}

/// @nodoc
class _$ScenarioFeasibilityCopyWithImpl<$Res, $Val extends ScenarioFeasibility>
    implements $ScenarioFeasibilityCopyWith<$Res> {
  _$ScenarioFeasibilityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? scores = null,
    Object? overall = null,
    Object? rating = null,
  }) {
    return _then(_value.copyWith(
      scores: null == scores
          ? _value.scores
          : scores // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      overall: null == overall
          ? _value.overall
          : overall // ignore: cast_nullable_to_non_nullable
              as double,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ScenarioFeasibilityImplCopyWith<$Res>
    implements $ScenarioFeasibilityCopyWith<$Res> {
  factory _$$ScenarioFeasibilityImplCopyWith(_$ScenarioFeasibilityImpl value,
          $Res Function(_$ScenarioFeasibilityImpl) then) =
      __$$ScenarioFeasibilityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Map<String, double> scores, double overall, String rating});
}

/// @nodoc
class __$$ScenarioFeasibilityImplCopyWithImpl<$Res>
    extends _$ScenarioFeasibilityCopyWithImpl<$Res, _$ScenarioFeasibilityImpl>
    implements _$$ScenarioFeasibilityImplCopyWith<$Res> {
  __$$ScenarioFeasibilityImplCopyWithImpl(_$ScenarioFeasibilityImpl _value,
      $Res Function(_$ScenarioFeasibilityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? scores = null,
    Object? overall = null,
    Object? rating = null,
  }) {
    return _then(_$ScenarioFeasibilityImpl(
      scores: null == scores
          ? _value._scores
          : scores // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      overall: null == overall
          ? _value.overall
          : overall // ignore: cast_nullable_to_non_nullable
              as double,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ScenarioFeasibilityImpl implements _ScenarioFeasibility {
  const _$ScenarioFeasibilityImpl(
      {required final Map<String, double> scores,
      required this.overall,
      required this.rating})
      : _scores = scores;

  factory _$ScenarioFeasibilityImpl.fromJson(Map<String, dynamic> json) =>
      _$$ScenarioFeasibilityImplFromJson(json);

  final Map<String, double> _scores;
  @override
  Map<String, double> get scores {
    if (_scores is EqualUnmodifiableMapView) return _scores;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_scores);
  }

  @override
  final double overall;
  @override
  final String rating;

  @override
  String toString() {
    return 'ScenarioFeasibility(scores: $scores, overall: $overall, rating: $rating)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScenarioFeasibilityImpl &&
            const DeepCollectionEquality().equals(other._scores, _scores) &&
            (identical(other.overall, overall) || other.overall == overall) &&
            (identical(other.rating, rating) || other.rating == rating));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_scores), overall, rating);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ScenarioFeasibilityImplCopyWith<_$ScenarioFeasibilityImpl> get copyWith =>
      __$$ScenarioFeasibilityImplCopyWithImpl<_$ScenarioFeasibilityImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ScenarioFeasibilityImplToJson(
      this,
    );
  }
}

abstract class _ScenarioFeasibility implements ScenarioFeasibility {
  const factory _ScenarioFeasibility(
      {required final Map<String, double> scores,
      required final double overall,
      required final String rating}) = _$ScenarioFeasibilityImpl;

  factory _ScenarioFeasibility.fromJson(Map<String, dynamic> json) =
      _$ScenarioFeasibilityImpl.fromJson;

  @override
  Map<String, double> get scores;
  @override
  double get overall;
  @override
  String get rating;
  @override
  @JsonKey(ignore: true)
  _$$ScenarioFeasibilityImplCopyWith<_$ScenarioFeasibilityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ScenarioRecommendation _$ScenarioRecommendationFromJson(
    Map<String, dynamic> json) {
  return _ScenarioRecommendation.fromJson(json);
}

/// @nodoc
mixin _$ScenarioRecommendation {
  String get decision => throw _privateConstructorUsedError;
  String get confidence => throw _privateConstructorUsedError;
  String get reasoning => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ScenarioRecommendationCopyWith<ScenarioRecommendation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScenarioRecommendationCopyWith<$Res> {
  factory $ScenarioRecommendationCopyWith(ScenarioRecommendation value,
          $Res Function(ScenarioRecommendation) then) =
      _$ScenarioRecommendationCopyWithImpl<$Res, ScenarioRecommendation>;
  @useResult
  $Res call({String decision, String confidence, String reasoning});
}

/// @nodoc
class _$ScenarioRecommendationCopyWithImpl<$Res,
        $Val extends ScenarioRecommendation>
    implements $ScenarioRecommendationCopyWith<$Res> {
  _$ScenarioRecommendationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? decision = null,
    Object? confidence = null,
    Object? reasoning = null,
  }) {
    return _then(_value.copyWith(
      decision: null == decision
          ? _value.decision
          : decision // ignore: cast_nullable_to_non_nullable
              as String,
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as String,
      reasoning: null == reasoning
          ? _value.reasoning
          : reasoning // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ScenarioRecommendationImplCopyWith<$Res>
    implements $ScenarioRecommendationCopyWith<$Res> {
  factory _$$ScenarioRecommendationImplCopyWith(
          _$ScenarioRecommendationImpl value,
          $Res Function(_$ScenarioRecommendationImpl) then) =
      __$$ScenarioRecommendationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String decision, String confidence, String reasoning});
}

/// @nodoc
class __$$ScenarioRecommendationImplCopyWithImpl<$Res>
    extends _$ScenarioRecommendationCopyWithImpl<$Res,
        _$ScenarioRecommendationImpl>
    implements _$$ScenarioRecommendationImplCopyWith<$Res> {
  __$$ScenarioRecommendationImplCopyWithImpl(
      _$ScenarioRecommendationImpl _value,
      $Res Function(_$ScenarioRecommendationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? decision = null,
    Object? confidence = null,
    Object? reasoning = null,
  }) {
    return _then(_$ScenarioRecommendationImpl(
      decision: null == decision
          ? _value.decision
          : decision // ignore: cast_nullable_to_non_nullable
              as String,
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as String,
      reasoning: null == reasoning
          ? _value.reasoning
          : reasoning // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ScenarioRecommendationImpl implements _ScenarioRecommendation {
  const _$ScenarioRecommendationImpl(
      {required this.decision,
      required this.confidence,
      required this.reasoning});

  factory _$ScenarioRecommendationImpl.fromJson(Map<String, dynamic> json) =>
      _$$ScenarioRecommendationImplFromJson(json);

  @override
  final String decision;
  @override
  final String confidence;
  @override
  final String reasoning;

  @override
  String toString() {
    return 'ScenarioRecommendation(decision: $decision, confidence: $confidence, reasoning: $reasoning)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScenarioRecommendationImpl &&
            (identical(other.decision, decision) ||
                other.decision == decision) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence) &&
            (identical(other.reasoning, reasoning) ||
                other.reasoning == reasoning));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, decision, confidence, reasoning);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ScenarioRecommendationImplCopyWith<_$ScenarioRecommendationImpl>
      get copyWith => __$$ScenarioRecommendationImplCopyWithImpl<
          _$ScenarioRecommendationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ScenarioRecommendationImplToJson(
      this,
    );
  }
}

abstract class _ScenarioRecommendation implements ScenarioRecommendation {
  const factory _ScenarioRecommendation(
      {required final String decision,
      required final String confidence,
      required final String reasoning}) = _$ScenarioRecommendationImpl;

  factory _ScenarioRecommendation.fromJson(Map<String, dynamic> json) =
      _$ScenarioRecommendationImpl.fromJson;

  @override
  String get decision;
  @override
  String get confidence;
  @override
  String get reasoning;
  @override
  @JsonKey(ignore: true)
  _$$ScenarioRecommendationImplCopyWith<_$ScenarioRecommendationImpl>
      get copyWith => throw _privateConstructorUsedError;
}

CustomerLifetimeValue _$CustomerLifetimeValueFromJson(
    Map<String, dynamic> json) {
  return _CustomerLifetimeValue.fromJson(json);
}

/// @nodoc
mixin _$CustomerLifetimeValue {
  String get clientId => throw _privateConstructorUsedError;
  String get clientName => throw _privateConstructorUsedError;
  double get clv => throw _privateConstructorUsedError;
  String get segment => throw _privateConstructorUsedError;
  CLVMetrics get metrics => throw _privateConstructorUsedError;
  List<String> get recommendations => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CustomerLifetimeValueCopyWith<CustomerLifetimeValue> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomerLifetimeValueCopyWith<$Res> {
  factory $CustomerLifetimeValueCopyWith(CustomerLifetimeValue value,
          $Res Function(CustomerLifetimeValue) then) =
      _$CustomerLifetimeValueCopyWithImpl<$Res, CustomerLifetimeValue>;
  @useResult
  $Res call(
      {String clientId,
      String clientName,
      double clv,
      String segment,
      CLVMetrics metrics,
      List<String> recommendations});

  $CLVMetricsCopyWith<$Res> get metrics;
}

/// @nodoc
class _$CustomerLifetimeValueCopyWithImpl<$Res,
        $Val extends CustomerLifetimeValue>
    implements $CustomerLifetimeValueCopyWith<$Res> {
  _$CustomerLifetimeValueCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clientId = null,
    Object? clientName = null,
    Object? clv = null,
    Object? segment = null,
    Object? metrics = null,
    Object? recommendations = null,
  }) {
    return _then(_value.copyWith(
      clientId: null == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      clientName: null == clientName
          ? _value.clientName
          : clientName // ignore: cast_nullable_to_non_nullable
              as String,
      clv: null == clv
          ? _value.clv
          : clv // ignore: cast_nullable_to_non_nullable
              as double,
      segment: null == segment
          ? _value.segment
          : segment // ignore: cast_nullable_to_non_nullable
              as String,
      metrics: null == metrics
          ? _value.metrics
          : metrics // ignore: cast_nullable_to_non_nullable
              as CLVMetrics,
      recommendations: null == recommendations
          ? _value.recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CLVMetricsCopyWith<$Res> get metrics {
    return $CLVMetricsCopyWith<$Res>(_value.metrics, (value) {
      return _then(_value.copyWith(metrics: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CustomerLifetimeValueImplCopyWith<$Res>
    implements $CustomerLifetimeValueCopyWith<$Res> {
  factory _$$CustomerLifetimeValueImplCopyWith(
          _$CustomerLifetimeValueImpl value,
          $Res Function(_$CustomerLifetimeValueImpl) then) =
      __$$CustomerLifetimeValueImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String clientId,
      String clientName,
      double clv,
      String segment,
      CLVMetrics metrics,
      List<String> recommendations});

  @override
  $CLVMetricsCopyWith<$Res> get metrics;
}

/// @nodoc
class __$$CustomerLifetimeValueImplCopyWithImpl<$Res>
    extends _$CustomerLifetimeValueCopyWithImpl<$Res,
        _$CustomerLifetimeValueImpl>
    implements _$$CustomerLifetimeValueImplCopyWith<$Res> {
  __$$CustomerLifetimeValueImplCopyWithImpl(_$CustomerLifetimeValueImpl _value,
      $Res Function(_$CustomerLifetimeValueImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clientId = null,
    Object? clientName = null,
    Object? clv = null,
    Object? segment = null,
    Object? metrics = null,
    Object? recommendations = null,
  }) {
    return _then(_$CustomerLifetimeValueImpl(
      clientId: null == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      clientName: null == clientName
          ? _value.clientName
          : clientName // ignore: cast_nullable_to_non_nullable
              as String,
      clv: null == clv
          ? _value.clv
          : clv // ignore: cast_nullable_to_non_nullable
              as double,
      segment: null == segment
          ? _value.segment
          : segment // ignore: cast_nullable_to_non_nullable
              as String,
      metrics: null == metrics
          ? _value.metrics
          : metrics // ignore: cast_nullable_to_non_nullable
              as CLVMetrics,
      recommendations: null == recommendations
          ? _value._recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CustomerLifetimeValueImpl implements _CustomerLifetimeValue {
  const _$CustomerLifetimeValueImpl(
      {required this.clientId,
      required this.clientName,
      required this.clv,
      required this.segment,
      required this.metrics,
      required final List<String> recommendations})
      : _recommendations = recommendations;

  factory _$CustomerLifetimeValueImpl.fromJson(Map<String, dynamic> json) =>
      _$$CustomerLifetimeValueImplFromJson(json);

  @override
  final String clientId;
  @override
  final String clientName;
  @override
  final double clv;
  @override
  final String segment;
  @override
  final CLVMetrics metrics;
  final List<String> _recommendations;
  @override
  List<String> get recommendations {
    if (_recommendations is EqualUnmodifiableListView) return _recommendations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recommendations);
  }

  @override
  String toString() {
    return 'CustomerLifetimeValue(clientId: $clientId, clientName: $clientName, clv: $clv, segment: $segment, metrics: $metrics, recommendations: $recommendations)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomerLifetimeValueImpl &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.clientName, clientName) ||
                other.clientName == clientName) &&
            (identical(other.clv, clv) || other.clv == clv) &&
            (identical(other.segment, segment) || other.segment == segment) &&
            (identical(other.metrics, metrics) || other.metrics == metrics) &&
            const DeepCollectionEquality()
                .equals(other._recommendations, _recommendations));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, clientId, clientName, clv,
      segment, metrics, const DeepCollectionEquality().hash(_recommendations));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomerLifetimeValueImplCopyWith<_$CustomerLifetimeValueImpl>
      get copyWith => __$$CustomerLifetimeValueImplCopyWithImpl<
          _$CustomerLifetimeValueImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CustomerLifetimeValueImplToJson(
      this,
    );
  }
}

abstract class _CustomerLifetimeValue implements CustomerLifetimeValue {
  const factory _CustomerLifetimeValue(
          {required final String clientId,
          required final String clientName,
          required final double clv,
          required final String segment,
          required final CLVMetrics metrics,
          required final List<String> recommendations}) =
      _$CustomerLifetimeValueImpl;

  factory _CustomerLifetimeValue.fromJson(Map<String, dynamic> json) =
      _$CustomerLifetimeValueImpl.fromJson;

  @override
  String get clientId;
  @override
  String get clientName;
  @override
  double get clv;
  @override
  String get segment;
  @override
  CLVMetrics get metrics;
  @override
  List<String> get recommendations;
  @override
  @JsonKey(ignore: true)
  _$$CustomerLifetimeValueImplCopyWith<_$CustomerLifetimeValueImpl>
      get copyWith => throw _privateConstructorUsedError;
}

CLVMetrics _$CLVMetricsFromJson(Map<String, dynamic> json) {
  return _CLVMetrics.fromJson(json);
}

/// @nodoc
mixin _$CLVMetrics {
  double get totalRevenue => throw _privateConstructorUsedError;
  int get appointmentCount => throw _privateConstructorUsedError;
  double get avgOrderValue => throw _privateConstructorUsedError;
  double get frequency => throw _privateConstructorUsedError;
  double get tenure => throw _privateConstructorUsedError;
  double get churnProbability => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CLVMetricsCopyWith<CLVMetrics> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CLVMetricsCopyWith<$Res> {
  factory $CLVMetricsCopyWith(
          CLVMetrics value, $Res Function(CLVMetrics) then) =
      _$CLVMetricsCopyWithImpl<$Res, CLVMetrics>;
  @useResult
  $Res call(
      {double totalRevenue,
      int appointmentCount,
      double avgOrderValue,
      double frequency,
      double tenure,
      double churnProbability});
}

/// @nodoc
class _$CLVMetricsCopyWithImpl<$Res, $Val extends CLVMetrics>
    implements $CLVMetricsCopyWith<$Res> {
  _$CLVMetricsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalRevenue = null,
    Object? appointmentCount = null,
    Object? avgOrderValue = null,
    Object? frequency = null,
    Object? tenure = null,
    Object? churnProbability = null,
  }) {
    return _then(_value.copyWith(
      totalRevenue: null == totalRevenue
          ? _value.totalRevenue
          : totalRevenue // ignore: cast_nullable_to_non_nullable
              as double,
      appointmentCount: null == appointmentCount
          ? _value.appointmentCount
          : appointmentCount // ignore: cast_nullable_to_non_nullable
              as int,
      avgOrderValue: null == avgOrderValue
          ? _value.avgOrderValue
          : avgOrderValue // ignore: cast_nullable_to_non_nullable
              as double,
      frequency: null == frequency
          ? _value.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as double,
      tenure: null == tenure
          ? _value.tenure
          : tenure // ignore: cast_nullable_to_non_nullable
              as double,
      churnProbability: null == churnProbability
          ? _value.churnProbability
          : churnProbability // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CLVMetricsImplCopyWith<$Res>
    implements $CLVMetricsCopyWith<$Res> {
  factory _$$CLVMetricsImplCopyWith(
          _$CLVMetricsImpl value, $Res Function(_$CLVMetricsImpl) then) =
      __$$CLVMetricsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double totalRevenue,
      int appointmentCount,
      double avgOrderValue,
      double frequency,
      double tenure,
      double churnProbability});
}

/// @nodoc
class __$$CLVMetricsImplCopyWithImpl<$Res>
    extends _$CLVMetricsCopyWithImpl<$Res, _$CLVMetricsImpl>
    implements _$$CLVMetricsImplCopyWith<$Res> {
  __$$CLVMetricsImplCopyWithImpl(
      _$CLVMetricsImpl _value, $Res Function(_$CLVMetricsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalRevenue = null,
    Object? appointmentCount = null,
    Object? avgOrderValue = null,
    Object? frequency = null,
    Object? tenure = null,
    Object? churnProbability = null,
  }) {
    return _then(_$CLVMetricsImpl(
      totalRevenue: null == totalRevenue
          ? _value.totalRevenue
          : totalRevenue // ignore: cast_nullable_to_non_nullable
              as double,
      appointmentCount: null == appointmentCount
          ? _value.appointmentCount
          : appointmentCount // ignore: cast_nullable_to_non_nullable
              as int,
      avgOrderValue: null == avgOrderValue
          ? _value.avgOrderValue
          : avgOrderValue // ignore: cast_nullable_to_non_nullable
              as double,
      frequency: null == frequency
          ? _value.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as double,
      tenure: null == tenure
          ? _value.tenure
          : tenure // ignore: cast_nullable_to_non_nullable
              as double,
      churnProbability: null == churnProbability
          ? _value.churnProbability
          : churnProbability // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CLVMetricsImpl implements _CLVMetrics {
  const _$CLVMetricsImpl(
      {required this.totalRevenue,
      required this.appointmentCount,
      required this.avgOrderValue,
      required this.frequency,
      required this.tenure,
      required this.churnProbability});

  factory _$CLVMetricsImpl.fromJson(Map<String, dynamic> json) =>
      _$$CLVMetricsImplFromJson(json);

  @override
  final double totalRevenue;
  @override
  final int appointmentCount;
  @override
  final double avgOrderValue;
  @override
  final double frequency;
  @override
  final double tenure;
  @override
  final double churnProbability;

  @override
  String toString() {
    return 'CLVMetrics(totalRevenue: $totalRevenue, appointmentCount: $appointmentCount, avgOrderValue: $avgOrderValue, frequency: $frequency, tenure: $tenure, churnProbability: $churnProbability)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CLVMetricsImpl &&
            (identical(other.totalRevenue, totalRevenue) ||
                other.totalRevenue == totalRevenue) &&
            (identical(other.appointmentCount, appointmentCount) ||
                other.appointmentCount == appointmentCount) &&
            (identical(other.avgOrderValue, avgOrderValue) ||
                other.avgOrderValue == avgOrderValue) &&
            (identical(other.frequency, frequency) ||
                other.frequency == frequency) &&
            (identical(other.tenure, tenure) || other.tenure == tenure) &&
            (identical(other.churnProbability, churnProbability) ||
                other.churnProbability == churnProbability));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, totalRevenue, appointmentCount,
      avgOrderValue, frequency, tenure, churnProbability);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CLVMetricsImplCopyWith<_$CLVMetricsImpl> get copyWith =>
      __$$CLVMetricsImplCopyWithImpl<_$CLVMetricsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CLVMetricsImplToJson(
      this,
    );
  }
}

abstract class _CLVMetrics implements CLVMetrics {
  const factory _CLVMetrics(
      {required final double totalRevenue,
      required final int appointmentCount,
      required final double avgOrderValue,
      required final double frequency,
      required final double tenure,
      required final double churnProbability}) = _$CLVMetricsImpl;

  factory _CLVMetrics.fromJson(Map<String, dynamic> json) =
      _$CLVMetricsImpl.fromJson;

  @override
  double get totalRevenue;
  @override
  int get appointmentCount;
  @override
  double get avgOrderValue;
  @override
  double get frequency;
  @override
  double get tenure;
  @override
  double get churnProbability;
  @override
  @JsonKey(ignore: true)
  _$$CLVMetricsImplCopyWith<_$CLVMetricsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MLModel _$MLModelFromJson(Map<String, dynamic> json) {
  return _MLModel.fromJson(json);
}

/// @nodoc
mixin _$MLModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get version => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  DateTime get trainedAt => throw _privateConstructorUsedError;
  MLMetrics get metrics => throw _privateConstructorUsedError;
  List<String> get features => throw _privateConstructorUsedError;
  Map<String, dynamic> get hyperparameters =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MLModelCopyWith<MLModel> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MLModelCopyWith<$Res> {
  factory $MLModelCopyWith(MLModel value, $Res Function(MLModel) then) =
      _$MLModelCopyWithImpl<$Res, MLModel>;
  @useResult
  $Res call(
      {String id,
      String name,
      String type,
      String version,
      String status,
      DateTime trainedAt,
      MLMetrics metrics,
      List<String> features,
      Map<String, dynamic> hyperparameters});

  $MLMetricsCopyWith<$Res> get metrics;
}

/// @nodoc
class _$MLModelCopyWithImpl<$Res, $Val extends MLModel>
    implements $MLModelCopyWith<$Res> {
  _$MLModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? version = null,
    Object? status = null,
    Object? trainedAt = null,
    Object? metrics = null,
    Object? features = null,
    Object? hyperparameters = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      trainedAt: null == trainedAt
          ? _value.trainedAt
          : trainedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      metrics: null == metrics
          ? _value.metrics
          : metrics // ignore: cast_nullable_to_non_nullable
              as MLMetrics,
      features: null == features
          ? _value.features
          : features // ignore: cast_nullable_to_non_nullable
              as List<String>,
      hyperparameters: null == hyperparameters
          ? _value.hyperparameters
          : hyperparameters // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $MLMetricsCopyWith<$Res> get metrics {
    return $MLMetricsCopyWith<$Res>(_value.metrics, (value) {
      return _then(_value.copyWith(metrics: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MLModelImplCopyWith<$Res> implements $MLModelCopyWith<$Res> {
  factory _$$MLModelImplCopyWith(
          _$MLModelImpl value, $Res Function(_$MLModelImpl) then) =
      __$$MLModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String type,
      String version,
      String status,
      DateTime trainedAt,
      MLMetrics metrics,
      List<String> features,
      Map<String, dynamic> hyperparameters});

  @override
  $MLMetricsCopyWith<$Res> get metrics;
}

/// @nodoc
class __$$MLModelImplCopyWithImpl<$Res>
    extends _$MLModelCopyWithImpl<$Res, _$MLModelImpl>
    implements _$$MLModelImplCopyWith<$Res> {
  __$$MLModelImplCopyWithImpl(
      _$MLModelImpl _value, $Res Function(_$MLModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? version = null,
    Object? status = null,
    Object? trainedAt = null,
    Object? metrics = null,
    Object? features = null,
    Object? hyperparameters = null,
  }) {
    return _then(_$MLModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      trainedAt: null == trainedAt
          ? _value.trainedAt
          : trainedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      metrics: null == metrics
          ? _value.metrics
          : metrics // ignore: cast_nullable_to_non_nullable
              as MLMetrics,
      features: null == features
          ? _value._features
          : features // ignore: cast_nullable_to_non_nullable
              as List<String>,
      hyperparameters: null == hyperparameters
          ? _value._hyperparameters
          : hyperparameters // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MLModelImpl implements _MLModel {
  const _$MLModelImpl(
      {required this.id,
      required this.name,
      required this.type,
      required this.version,
      required this.status,
      required this.trainedAt,
      required this.metrics,
      required final List<String> features,
      required final Map<String, dynamic> hyperparameters})
      : _features = features,
        _hyperparameters = hyperparameters;

  factory _$MLModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$MLModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String type;
  @override
  final String version;
  @override
  final String status;
  @override
  final DateTime trainedAt;
  @override
  final MLMetrics metrics;
  final List<String> _features;
  @override
  List<String> get features {
    if (_features is EqualUnmodifiableListView) return _features;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_features);
  }

  final Map<String, dynamic> _hyperparameters;
  @override
  Map<String, dynamic> get hyperparameters {
    if (_hyperparameters is EqualUnmodifiableMapView) return _hyperparameters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_hyperparameters);
  }

  @override
  String toString() {
    return 'MLModel(id: $id, name: $name, type: $type, version: $version, status: $status, trainedAt: $trainedAt, metrics: $metrics, features: $features, hyperparameters: $hyperparameters)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MLModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.trainedAt, trainedAt) ||
                other.trainedAt == trainedAt) &&
            (identical(other.metrics, metrics) || other.metrics == metrics) &&
            const DeepCollectionEquality().equals(other._features, _features) &&
            const DeepCollectionEquality()
                .equals(other._hyperparameters, _hyperparameters));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      type,
      version,
      status,
      trainedAt,
      metrics,
      const DeepCollectionEquality().hash(_features),
      const DeepCollectionEquality().hash(_hyperparameters));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MLModelImplCopyWith<_$MLModelImpl> get copyWith =>
      __$$MLModelImplCopyWithImpl<_$MLModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MLModelImplToJson(
      this,
    );
  }
}

abstract class _MLModel implements MLModel {
  const factory _MLModel(
      {required final String id,
      required final String name,
      required final String type,
      required final String version,
      required final String status,
      required final DateTime trainedAt,
      required final MLMetrics metrics,
      required final List<String> features,
      required final Map<String, dynamic> hyperparameters}) = _$MLModelImpl;

  factory _MLModel.fromJson(Map<String, dynamic> json) = _$MLModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get type;
  @override
  String get version;
  @override
  String get status;
  @override
  DateTime get trainedAt;
  @override
  MLMetrics get metrics;
  @override
  List<String> get features;
  @override
  Map<String, dynamic> get hyperparameters;
  @override
  @JsonKey(ignore: true)
  _$$MLModelImplCopyWith<_$MLModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MLMetrics _$MLMetricsFromJson(Map<String, dynamic> json) {
  return _MLMetrics.fromJson(json);
}

/// @nodoc
mixin _$MLMetrics {
  double get accuracy => throw _privateConstructorUsedError;
  double get precision => throw _privateConstructorUsedError;
  double get recall => throw _privateConstructorUsedError;
  double get f1Score => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MLMetricsCopyWith<MLMetrics> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MLMetricsCopyWith<$Res> {
  factory $MLMetricsCopyWith(MLMetrics value, $Res Function(MLMetrics) then) =
      _$MLMetricsCopyWithImpl<$Res, MLMetrics>;
  @useResult
  $Res call({double accuracy, double precision, double recall, double f1Score});
}

/// @nodoc
class _$MLMetricsCopyWithImpl<$Res, $Val extends MLMetrics>
    implements $MLMetricsCopyWith<$Res> {
  _$MLMetricsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accuracy = null,
    Object? precision = null,
    Object? recall = null,
    Object? f1Score = null,
  }) {
    return _then(_value.copyWith(
      accuracy: null == accuracy
          ? _value.accuracy
          : accuracy // ignore: cast_nullable_to_non_nullable
              as double,
      precision: null == precision
          ? _value.precision
          : precision // ignore: cast_nullable_to_non_nullable
              as double,
      recall: null == recall
          ? _value.recall
          : recall // ignore: cast_nullable_to_non_nullable
              as double,
      f1Score: null == f1Score
          ? _value.f1Score
          : f1Score // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MLMetricsImplCopyWith<$Res>
    implements $MLMetricsCopyWith<$Res> {
  factory _$$MLMetricsImplCopyWith(
          _$MLMetricsImpl value, $Res Function(_$MLMetricsImpl) then) =
      __$$MLMetricsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double accuracy, double precision, double recall, double f1Score});
}

/// @nodoc
class __$$MLMetricsImplCopyWithImpl<$Res>
    extends _$MLMetricsCopyWithImpl<$Res, _$MLMetricsImpl>
    implements _$$MLMetricsImplCopyWith<$Res> {
  __$$MLMetricsImplCopyWithImpl(
      _$MLMetricsImpl _value, $Res Function(_$MLMetricsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accuracy = null,
    Object? precision = null,
    Object? recall = null,
    Object? f1Score = null,
  }) {
    return _then(_$MLMetricsImpl(
      accuracy: null == accuracy
          ? _value.accuracy
          : accuracy // ignore: cast_nullable_to_non_nullable
              as double,
      precision: null == precision
          ? _value.precision
          : precision // ignore: cast_nullable_to_non_nullable
              as double,
      recall: null == recall
          ? _value.recall
          : recall // ignore: cast_nullable_to_non_nullable
              as double,
      f1Score: null == f1Score
          ? _value.f1Score
          : f1Score // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MLMetricsImpl implements _MLMetrics {
  const _$MLMetricsImpl(
      {required this.accuracy,
      required this.precision,
      required this.recall,
      required this.f1Score});

  factory _$MLMetricsImpl.fromJson(Map<String, dynamic> json) =>
      _$$MLMetricsImplFromJson(json);

  @override
  final double accuracy;
  @override
  final double precision;
  @override
  final double recall;
  @override
  final double f1Score;

  @override
  String toString() {
    return 'MLMetrics(accuracy: $accuracy, precision: $precision, recall: $recall, f1Score: $f1Score)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MLMetricsImpl &&
            (identical(other.accuracy, accuracy) ||
                other.accuracy == accuracy) &&
            (identical(other.precision, precision) ||
                other.precision == precision) &&
            (identical(other.recall, recall) || other.recall == recall) &&
            (identical(other.f1Score, f1Score) || other.f1Score == f1Score));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, accuracy, precision, recall, f1Score);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MLMetricsImplCopyWith<_$MLMetricsImpl> get copyWith =>
      __$$MLMetricsImplCopyWithImpl<_$MLMetricsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MLMetricsImplToJson(
      this,
    );
  }
}

abstract class _MLMetrics implements MLMetrics {
  const factory _MLMetrics(
      {required final double accuracy,
      required final double precision,
      required final double recall,
      required final double f1Score}) = _$MLMetricsImpl;

  factory _MLMetrics.fromJson(Map<String, dynamic> json) =
      _$MLMetricsImpl.fromJson;

  @override
  double get accuracy;
  @override
  double get precision;
  @override
  double get recall;
  @override
  double get f1Score;
  @override
  @JsonKey(ignore: true)
  _$$MLMetricsImplCopyWith<_$MLMetricsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MLPrediction _$MLPredictionFromJson(Map<String, dynamic> json) {
  return _MLPrediction.fromJson(json);
}

/// @nodoc
mixin _$MLPrediction {
  String get modelId => throw _privateConstructorUsedError;
  PredictionResult get prediction => throw _privateConstructorUsedError;
  double get confidence => throw _privateConstructorUsedError;
  Map<String, dynamic> get features => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MLPredictionCopyWith<MLPrediction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MLPredictionCopyWith<$Res> {
  factory $MLPredictionCopyWith(
          MLPrediction value, $Res Function(MLPrediction) then) =
      _$MLPredictionCopyWithImpl<$Res, MLPrediction>;
  @useResult
  $Res call(
      {String modelId,
      PredictionResult prediction,
      double confidence,
      Map<String, dynamic> features,
      DateTime timestamp});

  $PredictionResultCopyWith<$Res> get prediction;
}

/// @nodoc
class _$MLPredictionCopyWithImpl<$Res, $Val extends MLPrediction>
    implements $MLPredictionCopyWith<$Res> {
  _$MLPredictionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? modelId = null,
    Object? prediction = null,
    Object? confidence = null,
    Object? features = null,
    Object? timestamp = null,
  }) {
    return _then(_value.copyWith(
      modelId: null == modelId
          ? _value.modelId
          : modelId // ignore: cast_nullable_to_non_nullable
              as String,
      prediction: null == prediction
          ? _value.prediction
          : prediction // ignore: cast_nullable_to_non_nullable
              as PredictionResult,
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
      features: null == features
          ? _value.features
          : features // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PredictionResultCopyWith<$Res> get prediction {
    return $PredictionResultCopyWith<$Res>(_value.prediction, (value) {
      return _then(_value.copyWith(prediction: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MLPredictionImplCopyWith<$Res>
    implements $MLPredictionCopyWith<$Res> {
  factory _$$MLPredictionImplCopyWith(
          _$MLPredictionImpl value, $Res Function(_$MLPredictionImpl) then) =
      __$$MLPredictionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String modelId,
      PredictionResult prediction,
      double confidence,
      Map<String, dynamic> features,
      DateTime timestamp});

  @override
  $PredictionResultCopyWith<$Res> get prediction;
}

/// @nodoc
class __$$MLPredictionImplCopyWithImpl<$Res>
    extends _$MLPredictionCopyWithImpl<$Res, _$MLPredictionImpl>
    implements _$$MLPredictionImplCopyWith<$Res> {
  __$$MLPredictionImplCopyWithImpl(
      _$MLPredictionImpl _value, $Res Function(_$MLPredictionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? modelId = null,
    Object? prediction = null,
    Object? confidence = null,
    Object? features = null,
    Object? timestamp = null,
  }) {
    return _then(_$MLPredictionImpl(
      modelId: null == modelId
          ? _value.modelId
          : modelId // ignore: cast_nullable_to_non_nullable
              as String,
      prediction: null == prediction
          ? _value.prediction
          : prediction // ignore: cast_nullable_to_non_nullable
              as PredictionResult,
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
      features: null == features
          ? _value._features
          : features // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MLPredictionImpl implements _MLPrediction {
  const _$MLPredictionImpl(
      {required this.modelId,
      required this.prediction,
      required this.confidence,
      required final Map<String, dynamic> features,
      required this.timestamp})
      : _features = features;

  factory _$MLPredictionImpl.fromJson(Map<String, dynamic> json) =>
      _$$MLPredictionImplFromJson(json);

  @override
  final String modelId;
  @override
  final PredictionResult prediction;
  @override
  final double confidence;
  final Map<String, dynamic> _features;
  @override
  Map<String, dynamic> get features {
    if (_features is EqualUnmodifiableMapView) return _features;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_features);
  }

  @override
  final DateTime timestamp;

  @override
  String toString() {
    return 'MLPrediction(modelId: $modelId, prediction: $prediction, confidence: $confidence, features: $features, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MLPredictionImpl &&
            (identical(other.modelId, modelId) || other.modelId == modelId) &&
            (identical(other.prediction, prediction) ||
                other.prediction == prediction) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence) &&
            const DeepCollectionEquality().equals(other._features, _features) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, modelId, prediction, confidence,
      const DeepCollectionEquality().hash(_features), timestamp);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MLPredictionImplCopyWith<_$MLPredictionImpl> get copyWith =>
      __$$MLPredictionImplCopyWithImpl<_$MLPredictionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MLPredictionImplToJson(
      this,
    );
  }
}

abstract class _MLPrediction implements MLPrediction {
  const factory _MLPrediction(
      {required final String modelId,
      required final PredictionResult prediction,
      required final double confidence,
      required final Map<String, dynamic> features,
      required final DateTime timestamp}) = _$MLPredictionImpl;

  factory _MLPrediction.fromJson(Map<String, dynamic> json) =
      _$MLPredictionImpl.fromJson;

  @override
  String get modelId;
  @override
  PredictionResult get prediction;
  @override
  double get confidence;
  @override
  Map<String, dynamic> get features;
  @override
  DateTime get timestamp;
  @override
  @JsonKey(ignore: true)
  _$$MLPredictionImplCopyWith<_$MLPredictionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PredictionResult _$PredictionResultFromJson(Map<String, dynamic> json) {
  return _PredictionResult.fromJson(json);
}

/// @nodoc
mixin _$PredictionResult {
  String get predictedClass => throw _privateConstructorUsedError;
  double get score => throw _privateConstructorUsedError;
  Map<String, double> get probabilities => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PredictionResultCopyWith<PredictionResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PredictionResultCopyWith<$Res> {
  factory $PredictionResultCopyWith(
          PredictionResult value, $Res Function(PredictionResult) then) =
      _$PredictionResultCopyWithImpl<$Res, PredictionResult>;
  @useResult
  $Res call(
      {String predictedClass, double score, Map<String, double> probabilities});
}

/// @nodoc
class _$PredictionResultCopyWithImpl<$Res, $Val extends PredictionResult>
    implements $PredictionResultCopyWith<$Res> {
  _$PredictionResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? predictedClass = null,
    Object? score = null,
    Object? probabilities = null,
  }) {
    return _then(_value.copyWith(
      predictedClass: null == predictedClass
          ? _value.predictedClass
          : predictedClass // ignore: cast_nullable_to_non_nullable
              as String,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as double,
      probabilities: null == probabilities
          ? _value.probabilities
          : probabilities // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PredictionResultImplCopyWith<$Res>
    implements $PredictionResultCopyWith<$Res> {
  factory _$$PredictionResultImplCopyWith(_$PredictionResultImpl value,
          $Res Function(_$PredictionResultImpl) then) =
      __$$PredictionResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String predictedClass, double score, Map<String, double> probabilities});
}

/// @nodoc
class __$$PredictionResultImplCopyWithImpl<$Res>
    extends _$PredictionResultCopyWithImpl<$Res, _$PredictionResultImpl>
    implements _$$PredictionResultImplCopyWith<$Res> {
  __$$PredictionResultImplCopyWithImpl(_$PredictionResultImpl _value,
      $Res Function(_$PredictionResultImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? predictedClass = null,
    Object? score = null,
    Object? probabilities = null,
  }) {
    return _then(_$PredictionResultImpl(
      predictedClass: null == predictedClass
          ? _value.predictedClass
          : predictedClass // ignore: cast_nullable_to_non_nullable
              as String,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as double,
      probabilities: null == probabilities
          ? _value._probabilities
          : probabilities // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PredictionResultImpl implements _PredictionResult {
  const _$PredictionResultImpl(
      {required this.predictedClass,
      required this.score,
      required final Map<String, double> probabilities})
      : _probabilities = probabilities;

  factory _$PredictionResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$PredictionResultImplFromJson(json);

  @override
  final String predictedClass;
  @override
  final double score;
  final Map<String, double> _probabilities;
  @override
  Map<String, double> get probabilities {
    if (_probabilities is EqualUnmodifiableMapView) return _probabilities;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_probabilities);
  }

  @override
  String toString() {
    return 'PredictionResult(predictedClass: $predictedClass, score: $score, probabilities: $probabilities)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PredictionResultImpl &&
            (identical(other.predictedClass, predictedClass) ||
                other.predictedClass == predictedClass) &&
            (identical(other.score, score) || other.score == score) &&
            const DeepCollectionEquality()
                .equals(other._probabilities, _probabilities));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, predictedClass, score,
      const DeepCollectionEquality().hash(_probabilities));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PredictionResultImplCopyWith<_$PredictionResultImpl> get copyWith =>
      __$$PredictionResultImplCopyWithImpl<_$PredictionResultImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PredictionResultImplToJson(
      this,
    );
  }
}

abstract class _PredictionResult implements PredictionResult {
  const factory _PredictionResult(
          {required final String predictedClass,
          required final double score,
          required final Map<String, double> probabilities}) =
      _$PredictionResultImpl;

  factory _PredictionResult.fromJson(Map<String, dynamic> json) =
      _$PredictionResultImpl.fromJson;

  @override
  String get predictedClass;
  @override
  double get score;
  @override
  Map<String, double> get probabilities;
  @override
  @JsonKey(ignore: true)
  _$$PredictionResultImplCopyWith<_$PredictionResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
