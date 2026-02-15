// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'financial_intelligence_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RevenueForecast _$RevenueForecastFromJson(Map<String, dynamic> json) {
  return _RevenueForecast.fromJson(json);
}

/// @nodoc
mixin _$RevenueForecast {
  String get organizationId => throw _privateConstructorUsedError;
  String get generatedAt => throw _privateConstructorUsedError;
  int get horizon => throw _privateConstructorUsedError;
  String get model => throw _privateConstructorUsedError;
  double get accuracy => throw _privateConstructorUsedError;
  List<DailyPrediction> get predictions => throw _privateConstructorUsedError;
  ConfidenceIntervals? get confidenceIntervals =>
      throw _privateConstructorUsedError;
  ForecastScenarios? get scenarios => throw _privateConstructorUsedError;
  ForecastMetrics get metrics => throw _privateConstructorUsedError;
  List<String> get insights => throw _privateConstructorUsedError;

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
  $Res call(
      {String organizationId,
      String generatedAt,
      int horizon,
      String model,
      double accuracy,
      List<DailyPrediction> predictions,
      ConfidenceIntervals? confidenceIntervals,
      ForecastScenarios? scenarios,
      ForecastMetrics metrics,
      List<String> insights});

  $ConfidenceIntervalsCopyWith<$Res>? get confidenceIntervals;
  $ForecastScenariosCopyWith<$Res>? get scenarios;
  $ForecastMetricsCopyWith<$Res> get metrics;
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
    Object? organizationId = null,
    Object? generatedAt = null,
    Object? horizon = null,
    Object? model = null,
    Object? accuracy = null,
    Object? predictions = null,
    Object? confidenceIntervals = freezed,
    Object? scenarios = freezed,
    Object? metrics = null,
    Object? insights = null,
  }) {
    return _then(_value.copyWith(
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      generatedAt: null == generatedAt
          ? _value.generatedAt
          : generatedAt // ignore: cast_nullable_to_non_nullable
              as String,
      horizon: null == horizon
          ? _value.horizon
          : horizon // ignore: cast_nullable_to_non_nullable
              as int,
      model: null == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as String,
      accuracy: null == accuracy
          ? _value.accuracy
          : accuracy // ignore: cast_nullable_to_non_nullable
              as double,
      predictions: null == predictions
          ? _value.predictions
          : predictions // ignore: cast_nullable_to_non_nullable
              as List<DailyPrediction>,
      confidenceIntervals: freezed == confidenceIntervals
          ? _value.confidenceIntervals
          : confidenceIntervals // ignore: cast_nullable_to_non_nullable
              as ConfidenceIntervals?,
      scenarios: freezed == scenarios
          ? _value.scenarios
          : scenarios // ignore: cast_nullable_to_non_nullable
              as ForecastScenarios?,
      metrics: null == metrics
          ? _value.metrics
          : metrics // ignore: cast_nullable_to_non_nullable
              as ForecastMetrics,
      insights: null == insights
          ? _value.insights
          : insights // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ConfidenceIntervalsCopyWith<$Res>? get confidenceIntervals {
    if (_value.confidenceIntervals == null) {
      return null;
    }

    return $ConfidenceIntervalsCopyWith<$Res>(_value.confidenceIntervals!,
        (value) {
      return _then(_value.copyWith(confidenceIntervals: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ForecastScenariosCopyWith<$Res>? get scenarios {
    if (_value.scenarios == null) {
      return null;
    }

    return $ForecastScenariosCopyWith<$Res>(_value.scenarios!, (value) {
      return _then(_value.copyWith(scenarios: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ForecastMetricsCopyWith<$Res> get metrics {
    return $ForecastMetricsCopyWith<$Res>(_value.metrics, (value) {
      return _then(_value.copyWith(metrics: value) as $Val);
    });
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
  $Res call(
      {String organizationId,
      String generatedAt,
      int horizon,
      String model,
      double accuracy,
      List<DailyPrediction> predictions,
      ConfidenceIntervals? confidenceIntervals,
      ForecastScenarios? scenarios,
      ForecastMetrics metrics,
      List<String> insights});

  @override
  $ConfidenceIntervalsCopyWith<$Res>? get confidenceIntervals;
  @override
  $ForecastScenariosCopyWith<$Res>? get scenarios;
  @override
  $ForecastMetricsCopyWith<$Res> get metrics;
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
    Object? organizationId = null,
    Object? generatedAt = null,
    Object? horizon = null,
    Object? model = null,
    Object? accuracy = null,
    Object? predictions = null,
    Object? confidenceIntervals = freezed,
    Object? scenarios = freezed,
    Object? metrics = null,
    Object? insights = null,
  }) {
    return _then(_$RevenueForecastImpl(
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      generatedAt: null == generatedAt
          ? _value.generatedAt
          : generatedAt // ignore: cast_nullable_to_non_nullable
              as String,
      horizon: null == horizon
          ? _value.horizon
          : horizon // ignore: cast_nullable_to_non_nullable
              as int,
      model: null == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as String,
      accuracy: null == accuracy
          ? _value.accuracy
          : accuracy // ignore: cast_nullable_to_non_nullable
              as double,
      predictions: null == predictions
          ? _value._predictions
          : predictions // ignore: cast_nullable_to_non_nullable
              as List<DailyPrediction>,
      confidenceIntervals: freezed == confidenceIntervals
          ? _value.confidenceIntervals
          : confidenceIntervals // ignore: cast_nullable_to_non_nullable
              as ConfidenceIntervals?,
      scenarios: freezed == scenarios
          ? _value.scenarios
          : scenarios // ignore: cast_nullable_to_non_nullable
              as ForecastScenarios?,
      metrics: null == metrics
          ? _value.metrics
          : metrics // ignore: cast_nullable_to_non_nullable
              as ForecastMetrics,
      insights: null == insights
          ? _value._insights
          : insights // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RevenueForecastImpl implements _RevenueForecast {
  const _$RevenueForecastImpl(
      {required this.organizationId,
      required this.generatedAt,
      required this.horizon,
      required this.model,
      required this.accuracy,
      required final List<DailyPrediction> predictions,
      this.confidenceIntervals,
      this.scenarios,
      required this.metrics,
      required final List<String> insights})
      : _predictions = predictions,
        _insights = insights;

  factory _$RevenueForecastImpl.fromJson(Map<String, dynamic> json) =>
      _$$RevenueForecastImplFromJson(json);

  @override
  final String organizationId;
  @override
  final String generatedAt;
  @override
  final int horizon;
  @override
  final String model;
  @override
  final double accuracy;
  final List<DailyPrediction> _predictions;
  @override
  List<DailyPrediction> get predictions {
    if (_predictions is EqualUnmodifiableListView) return _predictions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_predictions);
  }

  @override
  final ConfidenceIntervals? confidenceIntervals;
  @override
  final ForecastScenarios? scenarios;
  @override
  final ForecastMetrics metrics;
  final List<String> _insights;
  @override
  List<String> get insights {
    if (_insights is EqualUnmodifiableListView) return _insights;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_insights);
  }

  @override
  String toString() {
    return 'RevenueForecast(organizationId: $organizationId, generatedAt: $generatedAt, horizon: $horizon, model: $model, accuracy: $accuracy, predictions: $predictions, confidenceIntervals: $confidenceIntervals, scenarios: $scenarios, metrics: $metrics, insights: $insights)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RevenueForecastImpl &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.generatedAt, generatedAt) ||
                other.generatedAt == generatedAt) &&
            (identical(other.horizon, horizon) || other.horizon == horizon) &&
            (identical(other.model, model) || other.model == model) &&
            (identical(other.accuracy, accuracy) ||
                other.accuracy == accuracy) &&
            const DeepCollectionEquality()
                .equals(other._predictions, _predictions) &&
            (identical(other.confidenceIntervals, confidenceIntervals) ||
                other.confidenceIntervals == confidenceIntervals) &&
            (identical(other.scenarios, scenarios) ||
                other.scenarios == scenarios) &&
            (identical(other.metrics, metrics) || other.metrics == metrics) &&
            const DeepCollectionEquality().equals(other._insights, _insights));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      organizationId,
      generatedAt,
      horizon,
      model,
      accuracy,
      const DeepCollectionEquality().hash(_predictions),
      confidenceIntervals,
      scenarios,
      metrics,
      const DeepCollectionEquality().hash(_insights));

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
      {required final String organizationId,
      required final String generatedAt,
      required final int horizon,
      required final String model,
      required final double accuracy,
      required final List<DailyPrediction> predictions,
      final ConfidenceIntervals? confidenceIntervals,
      final ForecastScenarios? scenarios,
      required final ForecastMetrics metrics,
      required final List<String> insights}) = _$RevenueForecastImpl;

  factory _RevenueForecast.fromJson(Map<String, dynamic> json) =
      _$RevenueForecastImpl.fromJson;

  @override
  String get organizationId;
  @override
  String get generatedAt;
  @override
  int get horizon;
  @override
  String get model;
  @override
  double get accuracy;
  @override
  List<DailyPrediction> get predictions;
  @override
  ConfidenceIntervals? get confidenceIntervals;
  @override
  ForecastScenarios? get scenarios;
  @override
  ForecastMetrics get metrics;
  @override
  List<String> get insights;
  @override
  @JsonKey(ignore: true)
  _$$RevenueForecastImplCopyWith<_$RevenueForecastImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DailyPrediction _$DailyPredictionFromJson(Map<String, dynamic> json) {
  return _DailyPrediction.fromJson(json);
}

/// @nodoc
mixin _$DailyPrediction {
  String get date => throw _privateConstructorUsedError;
  double get predicted => throw _privateConstructorUsedError;
  double get confidence => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DailyPredictionCopyWith<DailyPrediction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailyPredictionCopyWith<$Res> {
  factory $DailyPredictionCopyWith(
          DailyPrediction value, $Res Function(DailyPrediction) then) =
      _$DailyPredictionCopyWithImpl<$Res, DailyPrediction>;
  @useResult
  $Res call({String date, double predicted, double confidence});
}

/// @nodoc
class _$DailyPredictionCopyWithImpl<$Res, $Val extends DailyPrediction>
    implements $DailyPredictionCopyWith<$Res> {
  _$DailyPredictionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? predicted = null,
    Object? confidence = null,
  }) {
    return _then(_value.copyWith(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      predicted: null == predicted
          ? _value.predicted
          : predicted // ignore: cast_nullable_to_non_nullable
              as double,
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DailyPredictionImplCopyWith<$Res>
    implements $DailyPredictionCopyWith<$Res> {
  factory _$$DailyPredictionImplCopyWith(_$DailyPredictionImpl value,
          $Res Function(_$DailyPredictionImpl) then) =
      __$$DailyPredictionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String date, double predicted, double confidence});
}

/// @nodoc
class __$$DailyPredictionImplCopyWithImpl<$Res>
    extends _$DailyPredictionCopyWithImpl<$Res, _$DailyPredictionImpl>
    implements _$$DailyPredictionImplCopyWith<$Res> {
  __$$DailyPredictionImplCopyWithImpl(
      _$DailyPredictionImpl _value, $Res Function(_$DailyPredictionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? predicted = null,
    Object? confidence = null,
  }) {
    return _then(_$DailyPredictionImpl(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      predicted: null == predicted
          ? _value.predicted
          : predicted // ignore: cast_nullable_to_non_nullable
              as double,
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DailyPredictionImpl implements _DailyPrediction {
  const _$DailyPredictionImpl(
      {required this.date, required this.predicted, required this.confidence});

  factory _$DailyPredictionImpl.fromJson(Map<String, dynamic> json) =>
      _$$DailyPredictionImplFromJson(json);

  @override
  final String date;
  @override
  final double predicted;
  @override
  final double confidence;

  @override
  String toString() {
    return 'DailyPrediction(date: $date, predicted: $predicted, confidence: $confidence)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DailyPredictionImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.predicted, predicted) ||
                other.predicted == predicted) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, date, predicted, confidence);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DailyPredictionImplCopyWith<_$DailyPredictionImpl> get copyWith =>
      __$$DailyPredictionImplCopyWithImpl<_$DailyPredictionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DailyPredictionImplToJson(
      this,
    );
  }
}

abstract class _DailyPrediction implements DailyPrediction {
  const factory _DailyPrediction(
      {required final String date,
      required final double predicted,
      required final double confidence}) = _$DailyPredictionImpl;

  factory _DailyPrediction.fromJson(Map<String, dynamic> json) =
      _$DailyPredictionImpl.fromJson;

  @override
  String get date;
  @override
  double get predicted;
  @override
  double get confidence;
  @override
  @JsonKey(ignore: true)
  _$$DailyPredictionImplCopyWith<_$DailyPredictionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ConfidenceIntervals _$ConfidenceIntervalsFromJson(Map<String, dynamic> json) {
  return _ConfidenceIntervals.fromJson(json);
}

/// @nodoc
mixin _$ConfidenceIntervals {
  List<ConfidenceInterval> get intervals => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ConfidenceIntervalsCopyWith<ConfidenceIntervals> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConfidenceIntervalsCopyWith<$Res> {
  factory $ConfidenceIntervalsCopyWith(
          ConfidenceIntervals value, $Res Function(ConfidenceIntervals) then) =
      _$ConfidenceIntervalsCopyWithImpl<$Res, ConfidenceIntervals>;
  @useResult
  $Res call({List<ConfidenceInterval> intervals});
}

/// @nodoc
class _$ConfidenceIntervalsCopyWithImpl<$Res, $Val extends ConfidenceIntervals>
    implements $ConfidenceIntervalsCopyWith<$Res> {
  _$ConfidenceIntervalsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? intervals = null,
  }) {
    return _then(_value.copyWith(
      intervals: null == intervals
          ? _value.intervals
          : intervals // ignore: cast_nullable_to_non_nullable
              as List<ConfidenceInterval>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ConfidenceIntervalsImplCopyWith<$Res>
    implements $ConfidenceIntervalsCopyWith<$Res> {
  factory _$$ConfidenceIntervalsImplCopyWith(_$ConfidenceIntervalsImpl value,
          $Res Function(_$ConfidenceIntervalsImpl) then) =
      __$$ConfidenceIntervalsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<ConfidenceInterval> intervals});
}

/// @nodoc
class __$$ConfidenceIntervalsImplCopyWithImpl<$Res>
    extends _$ConfidenceIntervalsCopyWithImpl<$Res, _$ConfidenceIntervalsImpl>
    implements _$$ConfidenceIntervalsImplCopyWith<$Res> {
  __$$ConfidenceIntervalsImplCopyWithImpl(_$ConfidenceIntervalsImpl _value,
      $Res Function(_$ConfidenceIntervalsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? intervals = null,
  }) {
    return _then(_$ConfidenceIntervalsImpl(
      intervals: null == intervals
          ? _value._intervals
          : intervals // ignore: cast_nullable_to_non_nullable
              as List<ConfidenceInterval>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ConfidenceIntervalsImpl implements _ConfidenceIntervals {
  const _$ConfidenceIntervalsImpl(
      {required final List<ConfidenceInterval> intervals})
      : _intervals = intervals;

  factory _$ConfidenceIntervalsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConfidenceIntervalsImplFromJson(json);

  final List<ConfidenceInterval> _intervals;
  @override
  List<ConfidenceInterval> get intervals {
    if (_intervals is EqualUnmodifiableListView) return _intervals;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_intervals);
  }

  @override
  String toString() {
    return 'ConfidenceIntervals(intervals: $intervals)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConfidenceIntervalsImpl &&
            const DeepCollectionEquality()
                .equals(other._intervals, _intervals));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_intervals));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ConfidenceIntervalsImplCopyWith<_$ConfidenceIntervalsImpl> get copyWith =>
      __$$ConfidenceIntervalsImplCopyWithImpl<_$ConfidenceIntervalsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConfidenceIntervalsImplToJson(
      this,
    );
  }
}

abstract class _ConfidenceIntervals implements ConfidenceIntervals {
  const factory _ConfidenceIntervals(
          {required final List<ConfidenceInterval> intervals}) =
      _$ConfidenceIntervalsImpl;

  factory _ConfidenceIntervals.fromJson(Map<String, dynamic> json) =
      _$ConfidenceIntervalsImpl.fromJson;

  @override
  List<ConfidenceInterval> get intervals;
  @override
  @JsonKey(ignore: true)
  _$$ConfidenceIntervalsImplCopyWith<_$ConfidenceIntervalsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ConfidenceInterval _$ConfidenceIntervalFromJson(Map<String, dynamic> json) {
  return _ConfidenceInterval.fromJson(json);
}

/// @nodoc
mixin _$ConfidenceInterval {
  String get date => throw _privateConstructorUsedError;
  double get lower => throw _privateConstructorUsedError;
  double get upper => throw _privateConstructorUsedError;
  double get confidence => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ConfidenceIntervalCopyWith<ConfidenceInterval> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConfidenceIntervalCopyWith<$Res> {
  factory $ConfidenceIntervalCopyWith(
          ConfidenceInterval value, $Res Function(ConfidenceInterval) then) =
      _$ConfidenceIntervalCopyWithImpl<$Res, ConfidenceInterval>;
  @useResult
  $Res call({String date, double lower, double upper, double confidence});
}

/// @nodoc
class _$ConfidenceIntervalCopyWithImpl<$Res, $Val extends ConfidenceInterval>
    implements $ConfidenceIntervalCopyWith<$Res> {
  _$ConfidenceIntervalCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? lower = null,
    Object? upper = null,
    Object? confidence = null,
  }) {
    return _then(_value.copyWith(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      lower: null == lower
          ? _value.lower
          : lower // ignore: cast_nullable_to_non_nullable
              as double,
      upper: null == upper
          ? _value.upper
          : upper // ignore: cast_nullable_to_non_nullable
              as double,
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ConfidenceIntervalImplCopyWith<$Res>
    implements $ConfidenceIntervalCopyWith<$Res> {
  factory _$$ConfidenceIntervalImplCopyWith(_$ConfidenceIntervalImpl value,
          $Res Function(_$ConfidenceIntervalImpl) then) =
      __$$ConfidenceIntervalImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String date, double lower, double upper, double confidence});
}

/// @nodoc
class __$$ConfidenceIntervalImplCopyWithImpl<$Res>
    extends _$ConfidenceIntervalCopyWithImpl<$Res, _$ConfidenceIntervalImpl>
    implements _$$ConfidenceIntervalImplCopyWith<$Res> {
  __$$ConfidenceIntervalImplCopyWithImpl(_$ConfidenceIntervalImpl _value,
      $Res Function(_$ConfidenceIntervalImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? lower = null,
    Object? upper = null,
    Object? confidence = null,
  }) {
    return _then(_$ConfidenceIntervalImpl(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      lower: null == lower
          ? _value.lower
          : lower // ignore: cast_nullable_to_non_nullable
              as double,
      upper: null == upper
          ? _value.upper
          : upper // ignore: cast_nullable_to_non_nullable
              as double,
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ConfidenceIntervalImpl implements _ConfidenceInterval {
  const _$ConfidenceIntervalImpl(
      {required this.date,
      required this.lower,
      required this.upper,
      required this.confidence});

  factory _$ConfidenceIntervalImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConfidenceIntervalImplFromJson(json);

  @override
  final String date;
  @override
  final double lower;
  @override
  final double upper;
  @override
  final double confidence;

  @override
  String toString() {
    return 'ConfidenceInterval(date: $date, lower: $lower, upper: $upper, confidence: $confidence)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConfidenceIntervalImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.lower, lower) || other.lower == lower) &&
            (identical(other.upper, upper) || other.upper == upper) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, date, lower, upper, confidence);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ConfidenceIntervalImplCopyWith<_$ConfidenceIntervalImpl> get copyWith =>
      __$$ConfidenceIntervalImplCopyWithImpl<_$ConfidenceIntervalImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConfidenceIntervalImplToJson(
      this,
    );
  }
}

abstract class _ConfidenceInterval implements ConfidenceInterval {
  const factory _ConfidenceInterval(
      {required final String date,
      required final double lower,
      required final double upper,
      required final double confidence}) = _$ConfidenceIntervalImpl;

  factory _ConfidenceInterval.fromJson(Map<String, dynamic> json) =
      _$ConfidenceIntervalImpl.fromJson;

  @override
  String get date;
  @override
  double get lower;
  @override
  double get upper;
  @override
  double get confidence;
  @override
  @JsonKey(ignore: true)
  _$$ConfidenceIntervalImplCopyWith<_$ConfidenceIntervalImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ForecastScenarios _$ForecastScenariosFromJson(Map<String, dynamic> json) {
  return _ForecastScenarios.fromJson(json);
}

/// @nodoc
mixin _$ForecastScenarios {
  double get bestCase => throw _privateConstructorUsedError;
  double get mostLikely => throw _privateConstructorUsedError;
  double get worstCase => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ForecastScenariosCopyWith<ForecastScenarios> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ForecastScenariosCopyWith<$Res> {
  factory $ForecastScenariosCopyWith(
          ForecastScenarios value, $Res Function(ForecastScenarios) then) =
      _$ForecastScenariosCopyWithImpl<$Res, ForecastScenarios>;
  @useResult
  $Res call({double bestCase, double mostLikely, double worstCase});
}

/// @nodoc
class _$ForecastScenariosCopyWithImpl<$Res, $Val extends ForecastScenarios>
    implements $ForecastScenariosCopyWith<$Res> {
  _$ForecastScenariosCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bestCase = null,
    Object? mostLikely = null,
    Object? worstCase = null,
  }) {
    return _then(_value.copyWith(
      bestCase: null == bestCase
          ? _value.bestCase
          : bestCase // ignore: cast_nullable_to_non_nullable
              as double,
      mostLikely: null == mostLikely
          ? _value.mostLikely
          : mostLikely // ignore: cast_nullable_to_non_nullable
              as double,
      worstCase: null == worstCase
          ? _value.worstCase
          : worstCase // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ForecastScenariosImplCopyWith<$Res>
    implements $ForecastScenariosCopyWith<$Res> {
  factory _$$ForecastScenariosImplCopyWith(_$ForecastScenariosImpl value,
          $Res Function(_$ForecastScenariosImpl) then) =
      __$$ForecastScenariosImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double bestCase, double mostLikely, double worstCase});
}

/// @nodoc
class __$$ForecastScenariosImplCopyWithImpl<$Res>
    extends _$ForecastScenariosCopyWithImpl<$Res, _$ForecastScenariosImpl>
    implements _$$ForecastScenariosImplCopyWith<$Res> {
  __$$ForecastScenariosImplCopyWithImpl(_$ForecastScenariosImpl _value,
      $Res Function(_$ForecastScenariosImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bestCase = null,
    Object? mostLikely = null,
    Object? worstCase = null,
  }) {
    return _then(_$ForecastScenariosImpl(
      bestCase: null == bestCase
          ? _value.bestCase
          : bestCase // ignore: cast_nullable_to_non_nullable
              as double,
      mostLikely: null == mostLikely
          ? _value.mostLikely
          : mostLikely // ignore: cast_nullable_to_non_nullable
              as double,
      worstCase: null == worstCase
          ? _value.worstCase
          : worstCase // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ForecastScenariosImpl implements _ForecastScenarios {
  const _$ForecastScenariosImpl(
      {required this.bestCase,
      required this.mostLikely,
      required this.worstCase});

  factory _$ForecastScenariosImpl.fromJson(Map<String, dynamic> json) =>
      _$$ForecastScenariosImplFromJson(json);

  @override
  final double bestCase;
  @override
  final double mostLikely;
  @override
  final double worstCase;

  @override
  String toString() {
    return 'ForecastScenarios(bestCase: $bestCase, mostLikely: $mostLikely, worstCase: $worstCase)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ForecastScenariosImpl &&
            (identical(other.bestCase, bestCase) ||
                other.bestCase == bestCase) &&
            (identical(other.mostLikely, mostLikely) ||
                other.mostLikely == mostLikely) &&
            (identical(other.worstCase, worstCase) ||
                other.worstCase == worstCase));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, bestCase, mostLikely, worstCase);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ForecastScenariosImplCopyWith<_$ForecastScenariosImpl> get copyWith =>
      __$$ForecastScenariosImplCopyWithImpl<_$ForecastScenariosImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ForecastScenariosImplToJson(
      this,
    );
  }
}

abstract class _ForecastScenarios implements ForecastScenarios {
  const factory _ForecastScenarios(
      {required final double bestCase,
      required final double mostLikely,
      required final double worstCase}) = _$ForecastScenariosImpl;

  factory _ForecastScenarios.fromJson(Map<String, dynamic> json) =
      _$ForecastScenariosImpl.fromJson;

  @override
  double get bestCase;
  @override
  double get mostLikely;
  @override
  double get worstCase;
  @override
  @JsonKey(ignore: true)
  _$$ForecastScenariosImplCopyWith<_$ForecastScenariosImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ForecastMetrics _$ForecastMetricsFromJson(Map<String, dynamic> json) {
  return _ForecastMetrics.fromJson(json);
}

/// @nodoc
mixin _$ForecastMetrics {
  double get arimaAccuracy => throw _privateConstructorUsedError;
  double get prophetAccuracy => throw _privateConstructorUsedError;
  double get lstmAccuracy => throw _privateConstructorUsedError;
  double get ensembleAccuracy => throw _privateConstructorUsedError;
  double get mae => throw _privateConstructorUsedError;
  double get rmse => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ForecastMetricsCopyWith<ForecastMetrics> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ForecastMetricsCopyWith<$Res> {
  factory $ForecastMetricsCopyWith(
          ForecastMetrics value, $Res Function(ForecastMetrics) then) =
      _$ForecastMetricsCopyWithImpl<$Res, ForecastMetrics>;
  @useResult
  $Res call(
      {double arimaAccuracy,
      double prophetAccuracy,
      double lstmAccuracy,
      double ensembleAccuracy,
      double mae,
      double rmse});
}

/// @nodoc
class _$ForecastMetricsCopyWithImpl<$Res, $Val extends ForecastMetrics>
    implements $ForecastMetricsCopyWith<$Res> {
  _$ForecastMetricsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? arimaAccuracy = null,
    Object? prophetAccuracy = null,
    Object? lstmAccuracy = null,
    Object? ensembleAccuracy = null,
    Object? mae = null,
    Object? rmse = null,
  }) {
    return _then(_value.copyWith(
      arimaAccuracy: null == arimaAccuracy
          ? _value.arimaAccuracy
          : arimaAccuracy // ignore: cast_nullable_to_non_nullable
              as double,
      prophetAccuracy: null == prophetAccuracy
          ? _value.prophetAccuracy
          : prophetAccuracy // ignore: cast_nullable_to_non_nullable
              as double,
      lstmAccuracy: null == lstmAccuracy
          ? _value.lstmAccuracy
          : lstmAccuracy // ignore: cast_nullable_to_non_nullable
              as double,
      ensembleAccuracy: null == ensembleAccuracy
          ? _value.ensembleAccuracy
          : ensembleAccuracy // ignore: cast_nullable_to_non_nullable
              as double,
      mae: null == mae
          ? _value.mae
          : mae // ignore: cast_nullable_to_non_nullable
              as double,
      rmse: null == rmse
          ? _value.rmse
          : rmse // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ForecastMetricsImplCopyWith<$Res>
    implements $ForecastMetricsCopyWith<$Res> {
  factory _$$ForecastMetricsImplCopyWith(_$ForecastMetricsImpl value,
          $Res Function(_$ForecastMetricsImpl) then) =
      __$$ForecastMetricsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double arimaAccuracy,
      double prophetAccuracy,
      double lstmAccuracy,
      double ensembleAccuracy,
      double mae,
      double rmse});
}

/// @nodoc
class __$$ForecastMetricsImplCopyWithImpl<$Res>
    extends _$ForecastMetricsCopyWithImpl<$Res, _$ForecastMetricsImpl>
    implements _$$ForecastMetricsImplCopyWith<$Res> {
  __$$ForecastMetricsImplCopyWithImpl(
      _$ForecastMetricsImpl _value, $Res Function(_$ForecastMetricsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? arimaAccuracy = null,
    Object? prophetAccuracy = null,
    Object? lstmAccuracy = null,
    Object? ensembleAccuracy = null,
    Object? mae = null,
    Object? rmse = null,
  }) {
    return _then(_$ForecastMetricsImpl(
      arimaAccuracy: null == arimaAccuracy
          ? _value.arimaAccuracy
          : arimaAccuracy // ignore: cast_nullable_to_non_nullable
              as double,
      prophetAccuracy: null == prophetAccuracy
          ? _value.prophetAccuracy
          : prophetAccuracy // ignore: cast_nullable_to_non_nullable
              as double,
      lstmAccuracy: null == lstmAccuracy
          ? _value.lstmAccuracy
          : lstmAccuracy // ignore: cast_nullable_to_non_nullable
              as double,
      ensembleAccuracy: null == ensembleAccuracy
          ? _value.ensembleAccuracy
          : ensembleAccuracy // ignore: cast_nullable_to_non_nullable
              as double,
      mae: null == mae
          ? _value.mae
          : mae // ignore: cast_nullable_to_non_nullable
              as double,
      rmse: null == rmse
          ? _value.rmse
          : rmse // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ForecastMetricsImpl implements _ForecastMetrics {
  const _$ForecastMetricsImpl(
      {required this.arimaAccuracy,
      required this.prophetAccuracy,
      required this.lstmAccuracy,
      required this.ensembleAccuracy,
      required this.mae,
      required this.rmse});

  factory _$ForecastMetricsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ForecastMetricsImplFromJson(json);

  @override
  final double arimaAccuracy;
  @override
  final double prophetAccuracy;
  @override
  final double lstmAccuracy;
  @override
  final double ensembleAccuracy;
  @override
  final double mae;
  @override
  final double rmse;

  @override
  String toString() {
    return 'ForecastMetrics(arimaAccuracy: $arimaAccuracy, prophetAccuracy: $prophetAccuracy, lstmAccuracy: $lstmAccuracy, ensembleAccuracy: $ensembleAccuracy, mae: $mae, rmse: $rmse)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ForecastMetricsImpl &&
            (identical(other.arimaAccuracy, arimaAccuracy) ||
                other.arimaAccuracy == arimaAccuracy) &&
            (identical(other.prophetAccuracy, prophetAccuracy) ||
                other.prophetAccuracy == prophetAccuracy) &&
            (identical(other.lstmAccuracy, lstmAccuracy) ||
                other.lstmAccuracy == lstmAccuracy) &&
            (identical(other.ensembleAccuracy, ensembleAccuracy) ||
                other.ensembleAccuracy == ensembleAccuracy) &&
            (identical(other.mae, mae) || other.mae == mae) &&
            (identical(other.rmse, rmse) || other.rmse == rmse));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, arimaAccuracy, prophetAccuracy,
      lstmAccuracy, ensembleAccuracy, mae, rmse);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ForecastMetricsImplCopyWith<_$ForecastMetricsImpl> get copyWith =>
      __$$ForecastMetricsImplCopyWithImpl<_$ForecastMetricsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ForecastMetricsImplToJson(
      this,
    );
  }
}

abstract class _ForecastMetrics implements ForecastMetrics {
  const factory _ForecastMetrics(
      {required final double arimaAccuracy,
      required final double prophetAccuracy,
      required final double lstmAccuracy,
      required final double ensembleAccuracy,
      required final double mae,
      required final double rmse}) = _$ForecastMetricsImpl;

  factory _ForecastMetrics.fromJson(Map<String, dynamic> json) =
      _$ForecastMetricsImpl.fromJson;

  @override
  double get arimaAccuracy;
  @override
  double get prophetAccuracy;
  @override
  double get lstmAccuracy;
  @override
  double get ensembleAccuracy;
  @override
  double get mae;
  @override
  double get rmse;
  @override
  @JsonKey(ignore: true)
  _$$ForecastMetricsImplCopyWith<_$ForecastMetricsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RevenueDrivers _$RevenueDriversFromJson(Map<String, dynamic> json) {
  return _RevenueDrivers.fromJson(json);
}

/// @nodoc
mixin _$RevenueDrivers {
  String get organizationId => throw _privateConstructorUsedError;
  int get period => throw _privateConstructorUsedError;
  String get analyzedAt => throw _privateConstructorUsedError;
  List<PrimaryDriver> get primaryDrivers => throw _privateConstructorUsedError;
  List<ExternalFactor> get externalFactors =>
      throw _privateConstructorUsedError;
  List<String> get recommendations => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RevenueDriversCopyWith<RevenueDrivers> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RevenueDriversCopyWith<$Res> {
  factory $RevenueDriversCopyWith(
          RevenueDrivers value, $Res Function(RevenueDrivers) then) =
      _$RevenueDriversCopyWithImpl<$Res, RevenueDrivers>;
  @useResult
  $Res call(
      {String organizationId,
      int period,
      String analyzedAt,
      List<PrimaryDriver> primaryDrivers,
      List<ExternalFactor> externalFactors,
      List<String> recommendations});
}

/// @nodoc
class _$RevenueDriversCopyWithImpl<$Res, $Val extends RevenueDrivers>
    implements $RevenueDriversCopyWith<$Res> {
  _$RevenueDriversCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? organizationId = null,
    Object? period = null,
    Object? analyzedAt = null,
    Object? primaryDrivers = null,
    Object? externalFactors = null,
    Object? recommendations = null,
  }) {
    return _then(_value.copyWith(
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      period: null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as int,
      analyzedAt: null == analyzedAt
          ? _value.analyzedAt
          : analyzedAt // ignore: cast_nullable_to_non_nullable
              as String,
      primaryDrivers: null == primaryDrivers
          ? _value.primaryDrivers
          : primaryDrivers // ignore: cast_nullable_to_non_nullable
              as List<PrimaryDriver>,
      externalFactors: null == externalFactors
          ? _value.externalFactors
          : externalFactors // ignore: cast_nullable_to_non_nullable
              as List<ExternalFactor>,
      recommendations: null == recommendations
          ? _value.recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RevenueDriversImplCopyWith<$Res>
    implements $RevenueDriversCopyWith<$Res> {
  factory _$$RevenueDriversImplCopyWith(_$RevenueDriversImpl value,
          $Res Function(_$RevenueDriversImpl) then) =
      __$$RevenueDriversImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String organizationId,
      int period,
      String analyzedAt,
      List<PrimaryDriver> primaryDrivers,
      List<ExternalFactor> externalFactors,
      List<String> recommendations});
}

/// @nodoc
class __$$RevenueDriversImplCopyWithImpl<$Res>
    extends _$RevenueDriversCopyWithImpl<$Res, _$RevenueDriversImpl>
    implements _$$RevenueDriversImplCopyWith<$Res> {
  __$$RevenueDriversImplCopyWithImpl(
      _$RevenueDriversImpl _value, $Res Function(_$RevenueDriversImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? organizationId = null,
    Object? period = null,
    Object? analyzedAt = null,
    Object? primaryDrivers = null,
    Object? externalFactors = null,
    Object? recommendations = null,
  }) {
    return _then(_$RevenueDriversImpl(
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      period: null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as int,
      analyzedAt: null == analyzedAt
          ? _value.analyzedAt
          : analyzedAt // ignore: cast_nullable_to_non_nullable
              as String,
      primaryDrivers: null == primaryDrivers
          ? _value._primaryDrivers
          : primaryDrivers // ignore: cast_nullable_to_non_nullable
              as List<PrimaryDriver>,
      externalFactors: null == externalFactors
          ? _value._externalFactors
          : externalFactors // ignore: cast_nullable_to_non_nullable
              as List<ExternalFactor>,
      recommendations: null == recommendations
          ? _value._recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RevenueDriversImpl implements _RevenueDrivers {
  const _$RevenueDriversImpl(
      {required this.organizationId,
      required this.period,
      required this.analyzedAt,
      required final List<PrimaryDriver> primaryDrivers,
      required final List<ExternalFactor> externalFactors,
      required final List<String> recommendations})
      : _primaryDrivers = primaryDrivers,
        _externalFactors = externalFactors,
        _recommendations = recommendations;

  factory _$RevenueDriversImpl.fromJson(Map<String, dynamic> json) =>
      _$$RevenueDriversImplFromJson(json);

  @override
  final String organizationId;
  @override
  final int period;
  @override
  final String analyzedAt;
  final List<PrimaryDriver> _primaryDrivers;
  @override
  List<PrimaryDriver> get primaryDrivers {
    if (_primaryDrivers is EqualUnmodifiableListView) return _primaryDrivers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_primaryDrivers);
  }

  final List<ExternalFactor> _externalFactors;
  @override
  List<ExternalFactor> get externalFactors {
    if (_externalFactors is EqualUnmodifiableListView) return _externalFactors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_externalFactors);
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
    return 'RevenueDrivers(organizationId: $organizationId, period: $period, analyzedAt: $analyzedAt, primaryDrivers: $primaryDrivers, externalFactors: $externalFactors, recommendations: $recommendations)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RevenueDriversImpl &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.period, period) || other.period == period) &&
            (identical(other.analyzedAt, analyzedAt) ||
                other.analyzedAt == analyzedAt) &&
            const DeepCollectionEquality()
                .equals(other._primaryDrivers, _primaryDrivers) &&
            const DeepCollectionEquality()
                .equals(other._externalFactors, _externalFactors) &&
            const DeepCollectionEquality()
                .equals(other._recommendations, _recommendations));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      organizationId,
      period,
      analyzedAt,
      const DeepCollectionEquality().hash(_primaryDrivers),
      const DeepCollectionEquality().hash(_externalFactors),
      const DeepCollectionEquality().hash(_recommendations));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RevenueDriversImplCopyWith<_$RevenueDriversImpl> get copyWith =>
      __$$RevenueDriversImplCopyWithImpl<_$RevenueDriversImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RevenueDriversImplToJson(
      this,
    );
  }
}

abstract class _RevenueDrivers implements RevenueDrivers {
  const factory _RevenueDrivers(
      {required final String organizationId,
      required final int period,
      required final String analyzedAt,
      required final List<PrimaryDriver> primaryDrivers,
      required final List<ExternalFactor> externalFactors,
      required final List<String> recommendations}) = _$RevenueDriversImpl;

  factory _RevenueDrivers.fromJson(Map<String, dynamic> json) =
      _$RevenueDriversImpl.fromJson;

  @override
  String get organizationId;
  @override
  int get period;
  @override
  String get analyzedAt;
  @override
  List<PrimaryDriver> get primaryDrivers;
  @override
  List<ExternalFactor> get externalFactors;
  @override
  List<String> get recommendations;
  @override
  @JsonKey(ignore: true)
  _$$RevenueDriversImplCopyWith<_$RevenueDriversImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PrimaryDriver _$PrimaryDriverFromJson(Map<String, dynamic> json) {
  return _PrimaryDriver.fromJson(json);
}

/// @nodoc
mixin _$PrimaryDriver {
  String get driver => throw _privateConstructorUsedError;
  double get impact => throw _privateConstructorUsedError;
  String get trend => throw _privateConstructorUsedError;
  double get correlation => throw _privateConstructorUsedError;
  double get elasticity => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PrimaryDriverCopyWith<PrimaryDriver> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PrimaryDriverCopyWith<$Res> {
  factory $PrimaryDriverCopyWith(
          PrimaryDriver value, $Res Function(PrimaryDriver) then) =
      _$PrimaryDriverCopyWithImpl<$Res, PrimaryDriver>;
  @useResult
  $Res call(
      {String driver,
      double impact,
      String trend,
      double correlation,
      double elasticity});
}

/// @nodoc
class _$PrimaryDriverCopyWithImpl<$Res, $Val extends PrimaryDriver>
    implements $PrimaryDriverCopyWith<$Res> {
  _$PrimaryDriverCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? driver = null,
    Object? impact = null,
    Object? trend = null,
    Object? correlation = null,
    Object? elasticity = null,
  }) {
    return _then(_value.copyWith(
      driver: null == driver
          ? _value.driver
          : driver // ignore: cast_nullable_to_non_nullable
              as String,
      impact: null == impact
          ? _value.impact
          : impact // ignore: cast_nullable_to_non_nullable
              as double,
      trend: null == trend
          ? _value.trend
          : trend // ignore: cast_nullable_to_non_nullable
              as String,
      correlation: null == correlation
          ? _value.correlation
          : correlation // ignore: cast_nullable_to_non_nullable
              as double,
      elasticity: null == elasticity
          ? _value.elasticity
          : elasticity // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PrimaryDriverImplCopyWith<$Res>
    implements $PrimaryDriverCopyWith<$Res> {
  factory _$$PrimaryDriverImplCopyWith(
          _$PrimaryDriverImpl value, $Res Function(_$PrimaryDriverImpl) then) =
      __$$PrimaryDriverImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String driver,
      double impact,
      String trend,
      double correlation,
      double elasticity});
}

/// @nodoc
class __$$PrimaryDriverImplCopyWithImpl<$Res>
    extends _$PrimaryDriverCopyWithImpl<$Res, _$PrimaryDriverImpl>
    implements _$$PrimaryDriverImplCopyWith<$Res> {
  __$$PrimaryDriverImplCopyWithImpl(
      _$PrimaryDriverImpl _value, $Res Function(_$PrimaryDriverImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? driver = null,
    Object? impact = null,
    Object? trend = null,
    Object? correlation = null,
    Object? elasticity = null,
  }) {
    return _then(_$PrimaryDriverImpl(
      driver: null == driver
          ? _value.driver
          : driver // ignore: cast_nullable_to_non_nullable
              as String,
      impact: null == impact
          ? _value.impact
          : impact // ignore: cast_nullable_to_non_nullable
              as double,
      trend: null == trend
          ? _value.trend
          : trend // ignore: cast_nullable_to_non_nullable
              as String,
      correlation: null == correlation
          ? _value.correlation
          : correlation // ignore: cast_nullable_to_non_nullable
              as double,
      elasticity: null == elasticity
          ? _value.elasticity
          : elasticity // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PrimaryDriverImpl implements _PrimaryDriver {
  const _$PrimaryDriverImpl(
      {required this.driver,
      required this.impact,
      required this.trend,
      required this.correlation,
      required this.elasticity});

  factory _$PrimaryDriverImpl.fromJson(Map<String, dynamic> json) =>
      _$$PrimaryDriverImplFromJson(json);

  @override
  final String driver;
  @override
  final double impact;
  @override
  final String trend;
  @override
  final double correlation;
  @override
  final double elasticity;

  @override
  String toString() {
    return 'PrimaryDriver(driver: $driver, impact: $impact, trend: $trend, correlation: $correlation, elasticity: $elasticity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PrimaryDriverImpl &&
            (identical(other.driver, driver) || other.driver == driver) &&
            (identical(other.impact, impact) || other.impact == impact) &&
            (identical(other.trend, trend) || other.trend == trend) &&
            (identical(other.correlation, correlation) ||
                other.correlation == correlation) &&
            (identical(other.elasticity, elasticity) ||
                other.elasticity == elasticity));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, driver, impact, trend, correlation, elasticity);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PrimaryDriverImplCopyWith<_$PrimaryDriverImpl> get copyWith =>
      __$$PrimaryDriverImplCopyWithImpl<_$PrimaryDriverImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PrimaryDriverImplToJson(
      this,
    );
  }
}

abstract class _PrimaryDriver implements PrimaryDriver {
  const factory _PrimaryDriver(
      {required final String driver,
      required final double impact,
      required final String trend,
      required final double correlation,
      required final double elasticity}) = _$PrimaryDriverImpl;

  factory _PrimaryDriver.fromJson(Map<String, dynamic> json) =
      _$PrimaryDriverImpl.fromJson;

  @override
  String get driver;
  @override
  double get impact;
  @override
  String get trend;
  @override
  double get correlation;
  @override
  double get elasticity;
  @override
  @JsonKey(ignore: true)
  _$$PrimaryDriverImplCopyWith<_$PrimaryDriverImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ExternalFactor _$ExternalFactorFromJson(Map<String, dynamic> json) {
  return _ExternalFactor.fromJson(json);
}

/// @nodoc
mixin _$ExternalFactor {
  String get factor => throw _privateConstructorUsedError;
  double get impact => throw _privateConstructorUsedError;
  double get probability => throw _privateConstructorUsedError;
  String get potentialEffect => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ExternalFactorCopyWith<ExternalFactor> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExternalFactorCopyWith<$Res> {
  factory $ExternalFactorCopyWith(
          ExternalFactor value, $Res Function(ExternalFactor) then) =
      _$ExternalFactorCopyWithImpl<$Res, ExternalFactor>;
  @useResult
  $Res call(
      {String factor,
      double impact,
      double probability,
      String potentialEffect});
}

/// @nodoc
class _$ExternalFactorCopyWithImpl<$Res, $Val extends ExternalFactor>
    implements $ExternalFactorCopyWith<$Res> {
  _$ExternalFactorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? factor = null,
    Object? impact = null,
    Object? probability = null,
    Object? potentialEffect = null,
  }) {
    return _then(_value.copyWith(
      factor: null == factor
          ? _value.factor
          : factor // ignore: cast_nullable_to_non_nullable
              as String,
      impact: null == impact
          ? _value.impact
          : impact // ignore: cast_nullable_to_non_nullable
              as double,
      probability: null == probability
          ? _value.probability
          : probability // ignore: cast_nullable_to_non_nullable
              as double,
      potentialEffect: null == potentialEffect
          ? _value.potentialEffect
          : potentialEffect // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ExternalFactorImplCopyWith<$Res>
    implements $ExternalFactorCopyWith<$Res> {
  factory _$$ExternalFactorImplCopyWith(_$ExternalFactorImpl value,
          $Res Function(_$ExternalFactorImpl) then) =
      __$$ExternalFactorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String factor,
      double impact,
      double probability,
      String potentialEffect});
}

/// @nodoc
class __$$ExternalFactorImplCopyWithImpl<$Res>
    extends _$ExternalFactorCopyWithImpl<$Res, _$ExternalFactorImpl>
    implements _$$ExternalFactorImplCopyWith<$Res> {
  __$$ExternalFactorImplCopyWithImpl(
      _$ExternalFactorImpl _value, $Res Function(_$ExternalFactorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? factor = null,
    Object? impact = null,
    Object? probability = null,
    Object? potentialEffect = null,
  }) {
    return _then(_$ExternalFactorImpl(
      factor: null == factor
          ? _value.factor
          : factor // ignore: cast_nullable_to_non_nullable
              as String,
      impact: null == impact
          ? _value.impact
          : impact // ignore: cast_nullable_to_non_nullable
              as double,
      probability: null == probability
          ? _value.probability
          : probability // ignore: cast_nullable_to_non_nullable
              as double,
      potentialEffect: null == potentialEffect
          ? _value.potentialEffect
          : potentialEffect // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExternalFactorImpl implements _ExternalFactor {
  const _$ExternalFactorImpl(
      {required this.factor,
      required this.impact,
      required this.probability,
      required this.potentialEffect});

  factory _$ExternalFactorImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExternalFactorImplFromJson(json);

  @override
  final String factor;
  @override
  final double impact;
  @override
  final double probability;
  @override
  final String potentialEffect;

  @override
  String toString() {
    return 'ExternalFactor(factor: $factor, impact: $impact, probability: $probability, potentialEffect: $potentialEffect)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExternalFactorImpl &&
            (identical(other.factor, factor) || other.factor == factor) &&
            (identical(other.impact, impact) || other.impact == impact) &&
            (identical(other.probability, probability) ||
                other.probability == probability) &&
            (identical(other.potentialEffect, potentialEffect) ||
                other.potentialEffect == potentialEffect));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, factor, impact, probability, potentialEffect);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ExternalFactorImplCopyWith<_$ExternalFactorImpl> get copyWith =>
      __$$ExternalFactorImplCopyWithImpl<_$ExternalFactorImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExternalFactorImplToJson(
      this,
    );
  }
}

abstract class _ExternalFactor implements ExternalFactor {
  const factory _ExternalFactor(
      {required final String factor,
      required final double impact,
      required final double probability,
      required final String potentialEffect}) = _$ExternalFactorImpl;

  factory _ExternalFactor.fromJson(Map<String, dynamic> json) =
      _$ExternalFactorImpl.fromJson;

  @override
  String get factor;
  @override
  double get impact;
  @override
  double get probability;
  @override
  String get potentialEffect;
  @override
  @JsonKey(ignore: true)
  _$$ExternalFactorImplCopyWith<_$ExternalFactorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PriceOptimization _$PriceOptimizationFromJson(Map<String, dynamic> json) {
  return _PriceOptimization.fromJson(json);
}

/// @nodoc
mixin _$PriceOptimization {
  String get serviceId => throw _privateConstructorUsedError;
  String get serviceName => throw _privateConstructorUsedError;
  double get currentPrice => throw _privateConstructorUsedError;
  double get optimalPrice => throw _privateConstructorUsedError;
  double get priceChange => throw _privateConstructorUsedError;
  double get percentageChange => throw _privateConstructorUsedError;
  PriceImpact get impact => throw _privateConstructorUsedError;
  double get confidence => throw _privateConstructorUsedError;
  String get recommendation => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PriceOptimizationCopyWith<PriceOptimization> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PriceOptimizationCopyWith<$Res> {
  factory $PriceOptimizationCopyWith(
          PriceOptimization value, $Res Function(PriceOptimization) then) =
      _$PriceOptimizationCopyWithImpl<$Res, PriceOptimization>;
  @useResult
  $Res call(
      {String serviceId,
      String serviceName,
      double currentPrice,
      double optimalPrice,
      double priceChange,
      double percentageChange,
      PriceImpact impact,
      double confidence,
      String recommendation});

  $PriceImpactCopyWith<$Res> get impact;
}

/// @nodoc
class _$PriceOptimizationCopyWithImpl<$Res, $Val extends PriceOptimization>
    implements $PriceOptimizationCopyWith<$Res> {
  _$PriceOptimizationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? serviceId = null,
    Object? serviceName = null,
    Object? currentPrice = null,
    Object? optimalPrice = null,
    Object? priceChange = null,
    Object? percentageChange = null,
    Object? impact = null,
    Object? confidence = null,
    Object? recommendation = null,
  }) {
    return _then(_value.copyWith(
      serviceId: null == serviceId
          ? _value.serviceId
          : serviceId // ignore: cast_nullable_to_non_nullable
              as String,
      serviceName: null == serviceName
          ? _value.serviceName
          : serviceName // ignore: cast_nullable_to_non_nullable
              as String,
      currentPrice: null == currentPrice
          ? _value.currentPrice
          : currentPrice // ignore: cast_nullable_to_non_nullable
              as double,
      optimalPrice: null == optimalPrice
          ? _value.optimalPrice
          : optimalPrice // ignore: cast_nullable_to_non_nullable
              as double,
      priceChange: null == priceChange
          ? _value.priceChange
          : priceChange // ignore: cast_nullable_to_non_nullable
              as double,
      percentageChange: null == percentageChange
          ? _value.percentageChange
          : percentageChange // ignore: cast_nullable_to_non_nullable
              as double,
      impact: null == impact
          ? _value.impact
          : impact // ignore: cast_nullable_to_non_nullable
              as PriceImpact,
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
      recommendation: null == recommendation
          ? _value.recommendation
          : recommendation // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PriceImpactCopyWith<$Res> get impact {
    return $PriceImpactCopyWith<$Res>(_value.impact, (value) {
      return _then(_value.copyWith(impact: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PriceOptimizationImplCopyWith<$Res>
    implements $PriceOptimizationCopyWith<$Res> {
  factory _$$PriceOptimizationImplCopyWith(_$PriceOptimizationImpl value,
          $Res Function(_$PriceOptimizationImpl) then) =
      __$$PriceOptimizationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String serviceId,
      String serviceName,
      double currentPrice,
      double optimalPrice,
      double priceChange,
      double percentageChange,
      PriceImpact impact,
      double confidence,
      String recommendation});

  @override
  $PriceImpactCopyWith<$Res> get impact;
}

/// @nodoc
class __$$PriceOptimizationImplCopyWithImpl<$Res>
    extends _$PriceOptimizationCopyWithImpl<$Res, _$PriceOptimizationImpl>
    implements _$$PriceOptimizationImplCopyWith<$Res> {
  __$$PriceOptimizationImplCopyWithImpl(_$PriceOptimizationImpl _value,
      $Res Function(_$PriceOptimizationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? serviceId = null,
    Object? serviceName = null,
    Object? currentPrice = null,
    Object? optimalPrice = null,
    Object? priceChange = null,
    Object? percentageChange = null,
    Object? impact = null,
    Object? confidence = null,
    Object? recommendation = null,
  }) {
    return _then(_$PriceOptimizationImpl(
      serviceId: null == serviceId
          ? _value.serviceId
          : serviceId // ignore: cast_nullable_to_non_nullable
              as String,
      serviceName: null == serviceName
          ? _value.serviceName
          : serviceName // ignore: cast_nullable_to_non_nullable
              as String,
      currentPrice: null == currentPrice
          ? _value.currentPrice
          : currentPrice // ignore: cast_nullable_to_non_nullable
              as double,
      optimalPrice: null == optimalPrice
          ? _value.optimalPrice
          : optimalPrice // ignore: cast_nullable_to_non_nullable
              as double,
      priceChange: null == priceChange
          ? _value.priceChange
          : priceChange // ignore: cast_nullable_to_non_nullable
              as double,
      percentageChange: null == percentageChange
          ? _value.percentageChange
          : percentageChange // ignore: cast_nullable_to_non_nullable
              as double,
      impact: null == impact
          ? _value.impact
          : impact // ignore: cast_nullable_to_non_nullable
              as PriceImpact,
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
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
class _$PriceOptimizationImpl implements _PriceOptimization {
  const _$PriceOptimizationImpl(
      {required this.serviceId,
      required this.serviceName,
      required this.currentPrice,
      required this.optimalPrice,
      required this.priceChange,
      required this.percentageChange,
      required this.impact,
      required this.confidence,
      required this.recommendation});

  factory _$PriceOptimizationImpl.fromJson(Map<String, dynamic> json) =>
      _$$PriceOptimizationImplFromJson(json);

  @override
  final String serviceId;
  @override
  final String serviceName;
  @override
  final double currentPrice;
  @override
  final double optimalPrice;
  @override
  final double priceChange;
  @override
  final double percentageChange;
  @override
  final PriceImpact impact;
  @override
  final double confidence;
  @override
  final String recommendation;

  @override
  String toString() {
    return 'PriceOptimization(serviceId: $serviceId, serviceName: $serviceName, currentPrice: $currentPrice, optimalPrice: $optimalPrice, priceChange: $priceChange, percentageChange: $percentageChange, impact: $impact, confidence: $confidence, recommendation: $recommendation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PriceOptimizationImpl &&
            (identical(other.serviceId, serviceId) ||
                other.serviceId == serviceId) &&
            (identical(other.serviceName, serviceName) ||
                other.serviceName == serviceName) &&
            (identical(other.currentPrice, currentPrice) ||
                other.currentPrice == currentPrice) &&
            (identical(other.optimalPrice, optimalPrice) ||
                other.optimalPrice == optimalPrice) &&
            (identical(other.priceChange, priceChange) ||
                other.priceChange == priceChange) &&
            (identical(other.percentageChange, percentageChange) ||
                other.percentageChange == percentageChange) &&
            (identical(other.impact, impact) || other.impact == impact) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence) &&
            (identical(other.recommendation, recommendation) ||
                other.recommendation == recommendation));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      serviceId,
      serviceName,
      currentPrice,
      optimalPrice,
      priceChange,
      percentageChange,
      impact,
      confidence,
      recommendation);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PriceOptimizationImplCopyWith<_$PriceOptimizationImpl> get copyWith =>
      __$$PriceOptimizationImplCopyWithImpl<_$PriceOptimizationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PriceOptimizationImplToJson(
      this,
    );
  }
}

abstract class _PriceOptimization implements PriceOptimization {
  const factory _PriceOptimization(
      {required final String serviceId,
      required final String serviceName,
      required final double currentPrice,
      required final double optimalPrice,
      required final double priceChange,
      required final double percentageChange,
      required final PriceImpact impact,
      required final double confidence,
      required final String recommendation}) = _$PriceOptimizationImpl;

  factory _PriceOptimization.fromJson(Map<String, dynamic> json) =
      _$PriceOptimizationImpl.fromJson;

  @override
  String get serviceId;
  @override
  String get serviceName;
  @override
  double get currentPrice;
  @override
  double get optimalPrice;
  @override
  double get priceChange;
  @override
  double get percentageChange;
  @override
  PriceImpact get impact;
  @override
  double get confidence;
  @override
  String get recommendation;
  @override
  @JsonKey(ignore: true)
  _$$PriceOptimizationImplCopyWith<_$PriceOptimizationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PriceImpact _$PriceImpactFromJson(Map<String, dynamic> json) {
  return _PriceImpact.fromJson(json);
}

/// @nodoc
mixin _$PriceImpact {
  double get demandChange => throw _privateConstructorUsedError;
  double get revenueChange => throw _privateConstructorUsedError;
  double get marginChange => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PriceImpactCopyWith<PriceImpact> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PriceImpactCopyWith<$Res> {
  factory $PriceImpactCopyWith(
          PriceImpact value, $Res Function(PriceImpact) then) =
      _$PriceImpactCopyWithImpl<$Res, PriceImpact>;
  @useResult
  $Res call({double demandChange, double revenueChange, double marginChange});
}

/// @nodoc
class _$PriceImpactCopyWithImpl<$Res, $Val extends PriceImpact>
    implements $PriceImpactCopyWith<$Res> {
  _$PriceImpactCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? demandChange = null,
    Object? revenueChange = null,
    Object? marginChange = null,
  }) {
    return _then(_value.copyWith(
      demandChange: null == demandChange
          ? _value.demandChange
          : demandChange // ignore: cast_nullable_to_non_nullable
              as double,
      revenueChange: null == revenueChange
          ? _value.revenueChange
          : revenueChange // ignore: cast_nullable_to_non_nullable
              as double,
      marginChange: null == marginChange
          ? _value.marginChange
          : marginChange // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PriceImpactImplCopyWith<$Res>
    implements $PriceImpactCopyWith<$Res> {
  factory _$$PriceImpactImplCopyWith(
          _$PriceImpactImpl value, $Res Function(_$PriceImpactImpl) then) =
      __$$PriceImpactImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double demandChange, double revenueChange, double marginChange});
}

/// @nodoc
class __$$PriceImpactImplCopyWithImpl<$Res>
    extends _$PriceImpactCopyWithImpl<$Res, _$PriceImpactImpl>
    implements _$$PriceImpactImplCopyWith<$Res> {
  __$$PriceImpactImplCopyWithImpl(
      _$PriceImpactImpl _value, $Res Function(_$PriceImpactImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? demandChange = null,
    Object? revenueChange = null,
    Object? marginChange = null,
  }) {
    return _then(_$PriceImpactImpl(
      demandChange: null == demandChange
          ? _value.demandChange
          : demandChange // ignore: cast_nullable_to_non_nullable
              as double,
      revenueChange: null == revenueChange
          ? _value.revenueChange
          : revenueChange // ignore: cast_nullable_to_non_nullable
              as double,
      marginChange: null == marginChange
          ? _value.marginChange
          : marginChange // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PriceImpactImpl implements _PriceImpact {
  const _$PriceImpactImpl(
      {required this.demandChange,
      required this.revenueChange,
      required this.marginChange});

  factory _$PriceImpactImpl.fromJson(Map<String, dynamic> json) =>
      _$$PriceImpactImplFromJson(json);

  @override
  final double demandChange;
  @override
  final double revenueChange;
  @override
  final double marginChange;

  @override
  String toString() {
    return 'PriceImpact(demandChange: $demandChange, revenueChange: $revenueChange, marginChange: $marginChange)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PriceImpactImpl &&
            (identical(other.demandChange, demandChange) ||
                other.demandChange == demandChange) &&
            (identical(other.revenueChange, revenueChange) ||
                other.revenueChange == revenueChange) &&
            (identical(other.marginChange, marginChange) ||
                other.marginChange == marginChange));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, demandChange, revenueChange, marginChange);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PriceImpactImplCopyWith<_$PriceImpactImpl> get copyWith =>
      __$$PriceImpactImplCopyWithImpl<_$PriceImpactImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PriceImpactImplToJson(
      this,
    );
  }
}

abstract class _PriceImpact implements PriceImpact {
  const factory _PriceImpact(
      {required final double demandChange,
      required final double revenueChange,
      required final double marginChange}) = _$PriceImpactImpl;

  factory _PriceImpact.fromJson(Map<String, dynamic> json) =
      _$PriceImpactImpl.fromJson;

  @override
  double get demandChange;
  @override
  double get revenueChange;
  @override
  double get marginChange;
  @override
  @JsonKey(ignore: true)
  _$$PriceImpactImplCopyWith<_$PriceImpactImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ABTest _$ABTestFromJson(Map<String, dynamic> json) {
  return _ABTest.fromJson(json);
}

/// @nodoc
mixin _$ABTest {
  String get testId => throw _privateConstructorUsedError;
  String get organizationId => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;
  Map<String, ABVariant> get variants => throw _privateConstructorUsedError;
  int get duration => throw _privateConstructorUsedError;
  int get minimumSampleSize => throw _privateConstructorUsedError;
  double get significanceLevel => throw _privateConstructorUsedError;
  List<String> get successMetrics => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ABTestCopyWith<ABTest> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ABTestCopyWith<$Res> {
  factory $ABTestCopyWith(ABTest value, $Res Function(ABTest) then) =
      _$ABTestCopyWithImpl<$Res, ABTest>;
  @useResult
  $Res call(
      {String testId,
      String organizationId,
      String status,
      String createdAt,
      Map<String, ABVariant> variants,
      int duration,
      int minimumSampleSize,
      double significanceLevel,
      List<String> successMetrics});
}

/// @nodoc
class _$ABTestCopyWithImpl<$Res, $Val extends ABTest>
    implements $ABTestCopyWith<$Res> {
  _$ABTestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? testId = null,
    Object? organizationId = null,
    Object? status = null,
    Object? createdAt = null,
    Object? variants = null,
    Object? duration = null,
    Object? minimumSampleSize = null,
    Object? significanceLevel = null,
    Object? successMetrics = null,
  }) {
    return _then(_value.copyWith(
      testId: null == testId
          ? _value.testId
          : testId // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      variants: null == variants
          ? _value.variants
          : variants // ignore: cast_nullable_to_non_nullable
              as Map<String, ABVariant>,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int,
      minimumSampleSize: null == minimumSampleSize
          ? _value.minimumSampleSize
          : minimumSampleSize // ignore: cast_nullable_to_non_nullable
              as int,
      significanceLevel: null == significanceLevel
          ? _value.significanceLevel
          : significanceLevel // ignore: cast_nullable_to_non_nullable
              as double,
      successMetrics: null == successMetrics
          ? _value.successMetrics
          : successMetrics // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ABTestImplCopyWith<$Res> implements $ABTestCopyWith<$Res> {
  factory _$$ABTestImplCopyWith(
          _$ABTestImpl value, $Res Function(_$ABTestImpl) then) =
      __$$ABTestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String testId,
      String organizationId,
      String status,
      String createdAt,
      Map<String, ABVariant> variants,
      int duration,
      int minimumSampleSize,
      double significanceLevel,
      List<String> successMetrics});
}

/// @nodoc
class __$$ABTestImplCopyWithImpl<$Res>
    extends _$ABTestCopyWithImpl<$Res, _$ABTestImpl>
    implements _$$ABTestImplCopyWith<$Res> {
  __$$ABTestImplCopyWithImpl(
      _$ABTestImpl _value, $Res Function(_$ABTestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? testId = null,
    Object? organizationId = null,
    Object? status = null,
    Object? createdAt = null,
    Object? variants = null,
    Object? duration = null,
    Object? minimumSampleSize = null,
    Object? significanceLevel = null,
    Object? successMetrics = null,
  }) {
    return _then(_$ABTestImpl(
      testId: null == testId
          ? _value.testId
          : testId // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      variants: null == variants
          ? _value._variants
          : variants // ignore: cast_nullable_to_non_nullable
              as Map<String, ABVariant>,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int,
      minimumSampleSize: null == minimumSampleSize
          ? _value.minimumSampleSize
          : minimumSampleSize // ignore: cast_nullable_to_non_nullable
              as int,
      significanceLevel: null == significanceLevel
          ? _value.significanceLevel
          : significanceLevel // ignore: cast_nullable_to_non_nullable
              as double,
      successMetrics: null == successMetrics
          ? _value._successMetrics
          : successMetrics // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ABTestImpl implements _ABTest {
  const _$ABTestImpl(
      {required this.testId,
      required this.organizationId,
      required this.status,
      required this.createdAt,
      required final Map<String, ABVariant> variants,
      required this.duration,
      required this.minimumSampleSize,
      required this.significanceLevel,
      required final List<String> successMetrics})
      : _variants = variants,
        _successMetrics = successMetrics;

  factory _$ABTestImpl.fromJson(Map<String, dynamic> json) =>
      _$$ABTestImplFromJson(json);

  @override
  final String testId;
  @override
  final String organizationId;
  @override
  final String status;
  @override
  final String createdAt;
  final Map<String, ABVariant> _variants;
  @override
  Map<String, ABVariant> get variants {
    if (_variants is EqualUnmodifiableMapView) return _variants;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_variants);
  }

  @override
  final int duration;
  @override
  final int minimumSampleSize;
  @override
  final double significanceLevel;
  final List<String> _successMetrics;
  @override
  List<String> get successMetrics {
    if (_successMetrics is EqualUnmodifiableListView) return _successMetrics;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_successMetrics);
  }

  @override
  String toString() {
    return 'ABTest(testId: $testId, organizationId: $organizationId, status: $status, createdAt: $createdAt, variants: $variants, duration: $duration, minimumSampleSize: $minimumSampleSize, significanceLevel: $significanceLevel, successMetrics: $successMetrics)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ABTestImpl &&
            (identical(other.testId, testId) || other.testId == testId) &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality().equals(other._variants, _variants) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.minimumSampleSize, minimumSampleSize) ||
                other.minimumSampleSize == minimumSampleSize) &&
            (identical(other.significanceLevel, significanceLevel) ||
                other.significanceLevel == significanceLevel) &&
            const DeepCollectionEquality()
                .equals(other._successMetrics, _successMetrics));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      testId,
      organizationId,
      status,
      createdAt,
      const DeepCollectionEquality().hash(_variants),
      duration,
      minimumSampleSize,
      significanceLevel,
      const DeepCollectionEquality().hash(_successMetrics));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ABTestImplCopyWith<_$ABTestImpl> get copyWith =>
      __$$ABTestImplCopyWithImpl<_$ABTestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ABTestImplToJson(
      this,
    );
  }
}

abstract class _ABTest implements ABTest {
  const factory _ABTest(
      {required final String testId,
      required final String organizationId,
      required final String status,
      required final String createdAt,
      required final Map<String, ABVariant> variants,
      required final int duration,
      required final int minimumSampleSize,
      required final double significanceLevel,
      required final List<String> successMetrics}) = _$ABTestImpl;

  factory _ABTest.fromJson(Map<String, dynamic> json) = _$ABTestImpl.fromJson;

  @override
  String get testId;
  @override
  String get organizationId;
  @override
  String get status;
  @override
  String get createdAt;
  @override
  Map<String, ABVariant> get variants;
  @override
  int get duration;
  @override
  int get minimumSampleSize;
  @override
  double get significanceLevel;
  @override
  List<String> get successMetrics;
  @override
  @JsonKey(ignore: true)
  _$$ABTestImplCopyWith<_$ABTestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ABVariant _$ABVariantFromJson(Map<String, dynamic> json) {
  return _ABVariant.fromJson(json);
}

/// @nodoc
mixin _$ABVariant {
  String get name => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  double get allocation => throw _privateConstructorUsedError;
  ABMetrics get metrics => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ABVariantCopyWith<ABVariant> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ABVariantCopyWith<$Res> {
  factory $ABVariantCopyWith(ABVariant value, $Res Function(ABVariant) then) =
      _$ABVariantCopyWithImpl<$Res, ABVariant>;
  @useResult
  $Res call({String name, double price, double allocation, ABMetrics metrics});

  $ABMetricsCopyWith<$Res> get metrics;
}

/// @nodoc
class _$ABVariantCopyWithImpl<$Res, $Val extends ABVariant>
    implements $ABVariantCopyWith<$Res> {
  _$ABVariantCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? price = null,
    Object? allocation = null,
    Object? metrics = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      allocation: null == allocation
          ? _value.allocation
          : allocation // ignore: cast_nullable_to_non_nullable
              as double,
      metrics: null == metrics
          ? _value.metrics
          : metrics // ignore: cast_nullable_to_non_nullable
              as ABMetrics,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ABMetricsCopyWith<$Res> get metrics {
    return $ABMetricsCopyWith<$Res>(_value.metrics, (value) {
      return _then(_value.copyWith(metrics: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ABVariantImplCopyWith<$Res>
    implements $ABVariantCopyWith<$Res> {
  factory _$$ABVariantImplCopyWith(
          _$ABVariantImpl value, $Res Function(_$ABVariantImpl) then) =
      __$$ABVariantImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, double price, double allocation, ABMetrics metrics});

  @override
  $ABMetricsCopyWith<$Res> get metrics;
}

/// @nodoc
class __$$ABVariantImplCopyWithImpl<$Res>
    extends _$ABVariantCopyWithImpl<$Res, _$ABVariantImpl>
    implements _$$ABVariantImplCopyWith<$Res> {
  __$$ABVariantImplCopyWithImpl(
      _$ABVariantImpl _value, $Res Function(_$ABVariantImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? price = null,
    Object? allocation = null,
    Object? metrics = null,
  }) {
    return _then(_$ABVariantImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      allocation: null == allocation
          ? _value.allocation
          : allocation // ignore: cast_nullable_to_non_nullable
              as double,
      metrics: null == metrics
          ? _value.metrics
          : metrics // ignore: cast_nullable_to_non_nullable
              as ABMetrics,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ABVariantImpl implements _ABVariant {
  const _$ABVariantImpl(
      {required this.name,
      required this.price,
      required this.allocation,
      required this.metrics});

  factory _$ABVariantImpl.fromJson(Map<String, dynamic> json) =>
      _$$ABVariantImplFromJson(json);

  @override
  final String name;
  @override
  final double price;
  @override
  final double allocation;
  @override
  final ABMetrics metrics;

  @override
  String toString() {
    return 'ABVariant(name: $name, price: $price, allocation: $allocation, metrics: $metrics)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ABVariantImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.allocation, allocation) ||
                other.allocation == allocation) &&
            (identical(other.metrics, metrics) || other.metrics == metrics));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, name, price, allocation, metrics);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ABVariantImplCopyWith<_$ABVariantImpl> get copyWith =>
      __$$ABVariantImplCopyWithImpl<_$ABVariantImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ABVariantImplToJson(
      this,
    );
  }
}

abstract class _ABVariant implements ABVariant {
  const factory _ABVariant(
      {required final String name,
      required final double price,
      required final double allocation,
      required final ABMetrics metrics}) = _$ABVariantImpl;

  factory _ABVariant.fromJson(Map<String, dynamic> json) =
      _$ABVariantImpl.fromJson;

  @override
  String get name;
  @override
  double get price;
  @override
  double get allocation;
  @override
  ABMetrics get metrics;
  @override
  @JsonKey(ignore: true)
  _$$ABVariantImplCopyWith<_$ABVariantImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ABMetrics _$ABMetricsFromJson(Map<String, dynamic> json) {
  return _ABMetrics.fromJson(json);
}

/// @nodoc
mixin _$ABMetrics {
  int get conversions => throw _privateConstructorUsedError;
  double get revenue => throw _privateConstructorUsedError;
  int get sampleSize => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ABMetricsCopyWith<ABMetrics> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ABMetricsCopyWith<$Res> {
  factory $ABMetricsCopyWith(ABMetrics value, $Res Function(ABMetrics) then) =
      _$ABMetricsCopyWithImpl<$Res, ABMetrics>;
  @useResult
  $Res call({int conversions, double revenue, int sampleSize});
}

/// @nodoc
class _$ABMetricsCopyWithImpl<$Res, $Val extends ABMetrics>
    implements $ABMetricsCopyWith<$Res> {
  _$ABMetricsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? conversions = null,
    Object? revenue = null,
    Object? sampleSize = null,
  }) {
    return _then(_value.copyWith(
      conversions: null == conversions
          ? _value.conversions
          : conversions // ignore: cast_nullable_to_non_nullable
              as int,
      revenue: null == revenue
          ? _value.revenue
          : revenue // ignore: cast_nullable_to_non_nullable
              as double,
      sampleSize: null == sampleSize
          ? _value.sampleSize
          : sampleSize // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ABMetricsImplCopyWith<$Res>
    implements $ABMetricsCopyWith<$Res> {
  factory _$$ABMetricsImplCopyWith(
          _$ABMetricsImpl value, $Res Function(_$ABMetricsImpl) then) =
      __$$ABMetricsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int conversions, double revenue, int sampleSize});
}

/// @nodoc
class __$$ABMetricsImplCopyWithImpl<$Res>
    extends _$ABMetricsCopyWithImpl<$Res, _$ABMetricsImpl>
    implements _$$ABMetricsImplCopyWith<$Res> {
  __$$ABMetricsImplCopyWithImpl(
      _$ABMetricsImpl _value, $Res Function(_$ABMetricsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? conversions = null,
    Object? revenue = null,
    Object? sampleSize = null,
  }) {
    return _then(_$ABMetricsImpl(
      conversions: null == conversions
          ? _value.conversions
          : conversions // ignore: cast_nullable_to_non_nullable
              as int,
      revenue: null == revenue
          ? _value.revenue
          : revenue // ignore: cast_nullable_to_non_nullable
              as double,
      sampleSize: null == sampleSize
          ? _value.sampleSize
          : sampleSize // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ABMetricsImpl implements _ABMetrics {
  const _$ABMetricsImpl(
      {required this.conversions,
      required this.revenue,
      required this.sampleSize});

  factory _$ABMetricsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ABMetricsImplFromJson(json);

  @override
  final int conversions;
  @override
  final double revenue;
  @override
  final int sampleSize;

  @override
  String toString() {
    return 'ABMetrics(conversions: $conversions, revenue: $revenue, sampleSize: $sampleSize)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ABMetricsImpl &&
            (identical(other.conversions, conversions) ||
                other.conversions == conversions) &&
            (identical(other.revenue, revenue) || other.revenue == revenue) &&
            (identical(other.sampleSize, sampleSize) ||
                other.sampleSize == sampleSize));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, conversions, revenue, sampleSize);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ABMetricsImplCopyWith<_$ABMetricsImpl> get copyWith =>
      __$$ABMetricsImplCopyWithImpl<_$ABMetricsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ABMetricsImplToJson(
      this,
    );
  }
}

abstract class _ABMetrics implements ABMetrics {
  const factory _ABMetrics(
      {required final int conversions,
      required final double revenue,
      required final int sampleSize}) = _$ABMetricsImpl;

  factory _ABMetrics.fromJson(Map<String, dynamic> json) =
      _$ABMetricsImpl.fromJson;

  @override
  int get conversions;
  @override
  double get revenue;
  @override
  int get sampleSize;
  @override
  @JsonKey(ignore: true)
  _$$ABMetricsImplCopyWith<_$ABMetricsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PricingRecommendations _$PricingRecommendationsFromJson(
    Map<String, dynamic> json) {
  return _PricingRecommendations.fromJson(json);
}

/// @nodoc
mixin _$PricingRecommendations {
  String get serviceId => throw _privateConstructorUsedError;
  String get analyzedAt => throw _privateConstructorUsedError;
  CurrentPricing get current => throw _privateConstructorUsedError;
  List<PricingStrategy> get strategies => throw _privateConstructorUsedError;
  MarketInsights get marketInsights => throw _privateConstructorUsedError;
  String get topRecommendation => throw _privateConstructorUsedError;
  String get reasoning => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PricingRecommendationsCopyWith<PricingRecommendations> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PricingRecommendationsCopyWith<$Res> {
  factory $PricingRecommendationsCopyWith(PricingRecommendations value,
          $Res Function(PricingRecommendations) then) =
      _$PricingRecommendationsCopyWithImpl<$Res, PricingRecommendations>;
  @useResult
  $Res call(
      {String serviceId,
      String analyzedAt,
      CurrentPricing current,
      List<PricingStrategy> strategies,
      MarketInsights marketInsights,
      String topRecommendation,
      String reasoning});

  $CurrentPricingCopyWith<$Res> get current;
  $MarketInsightsCopyWith<$Res> get marketInsights;
}

/// @nodoc
class _$PricingRecommendationsCopyWithImpl<$Res,
        $Val extends PricingRecommendations>
    implements $PricingRecommendationsCopyWith<$Res> {
  _$PricingRecommendationsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? serviceId = null,
    Object? analyzedAt = null,
    Object? current = null,
    Object? strategies = null,
    Object? marketInsights = null,
    Object? topRecommendation = null,
    Object? reasoning = null,
  }) {
    return _then(_value.copyWith(
      serviceId: null == serviceId
          ? _value.serviceId
          : serviceId // ignore: cast_nullable_to_non_nullable
              as String,
      analyzedAt: null == analyzedAt
          ? _value.analyzedAt
          : analyzedAt // ignore: cast_nullable_to_non_nullable
              as String,
      current: null == current
          ? _value.current
          : current // ignore: cast_nullable_to_non_nullable
              as CurrentPricing,
      strategies: null == strategies
          ? _value.strategies
          : strategies // ignore: cast_nullable_to_non_nullable
              as List<PricingStrategy>,
      marketInsights: null == marketInsights
          ? _value.marketInsights
          : marketInsights // ignore: cast_nullable_to_non_nullable
              as MarketInsights,
      topRecommendation: null == topRecommendation
          ? _value.topRecommendation
          : topRecommendation // ignore: cast_nullable_to_non_nullable
              as String,
      reasoning: null == reasoning
          ? _value.reasoning
          : reasoning // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CurrentPricingCopyWith<$Res> get current {
    return $CurrentPricingCopyWith<$Res>(_value.current, (value) {
      return _then(_value.copyWith(current: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $MarketInsightsCopyWith<$Res> get marketInsights {
    return $MarketInsightsCopyWith<$Res>(_value.marketInsights, (value) {
      return _then(_value.copyWith(marketInsights: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PricingRecommendationsImplCopyWith<$Res>
    implements $PricingRecommendationsCopyWith<$Res> {
  factory _$$PricingRecommendationsImplCopyWith(
          _$PricingRecommendationsImpl value,
          $Res Function(_$PricingRecommendationsImpl) then) =
      __$$PricingRecommendationsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String serviceId,
      String analyzedAt,
      CurrentPricing current,
      List<PricingStrategy> strategies,
      MarketInsights marketInsights,
      String topRecommendation,
      String reasoning});

  @override
  $CurrentPricingCopyWith<$Res> get current;
  @override
  $MarketInsightsCopyWith<$Res> get marketInsights;
}

/// @nodoc
class __$$PricingRecommendationsImplCopyWithImpl<$Res>
    extends _$PricingRecommendationsCopyWithImpl<$Res,
        _$PricingRecommendationsImpl>
    implements _$$PricingRecommendationsImplCopyWith<$Res> {
  __$$PricingRecommendationsImplCopyWithImpl(
      _$PricingRecommendationsImpl _value,
      $Res Function(_$PricingRecommendationsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? serviceId = null,
    Object? analyzedAt = null,
    Object? current = null,
    Object? strategies = null,
    Object? marketInsights = null,
    Object? topRecommendation = null,
    Object? reasoning = null,
  }) {
    return _then(_$PricingRecommendationsImpl(
      serviceId: null == serviceId
          ? _value.serviceId
          : serviceId // ignore: cast_nullable_to_non_nullable
              as String,
      analyzedAt: null == analyzedAt
          ? _value.analyzedAt
          : analyzedAt // ignore: cast_nullable_to_non_nullable
              as String,
      current: null == current
          ? _value.current
          : current // ignore: cast_nullable_to_non_nullable
              as CurrentPricing,
      strategies: null == strategies
          ? _value._strategies
          : strategies // ignore: cast_nullable_to_non_nullable
              as List<PricingStrategy>,
      marketInsights: null == marketInsights
          ? _value.marketInsights
          : marketInsights // ignore: cast_nullable_to_non_nullable
              as MarketInsights,
      topRecommendation: null == topRecommendation
          ? _value.topRecommendation
          : topRecommendation // ignore: cast_nullable_to_non_nullable
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
class _$PricingRecommendationsImpl implements _PricingRecommendations {
  const _$PricingRecommendationsImpl(
      {required this.serviceId,
      required this.analyzedAt,
      required this.current,
      required final List<PricingStrategy> strategies,
      required this.marketInsights,
      required this.topRecommendation,
      required this.reasoning})
      : _strategies = strategies;

  factory _$PricingRecommendationsImpl.fromJson(Map<String, dynamic> json) =>
      _$$PricingRecommendationsImplFromJson(json);

  @override
  final String serviceId;
  @override
  final String analyzedAt;
  @override
  final CurrentPricing current;
  final List<PricingStrategy> _strategies;
  @override
  List<PricingStrategy> get strategies {
    if (_strategies is EqualUnmodifiableListView) return _strategies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_strategies);
  }

  @override
  final MarketInsights marketInsights;
  @override
  final String topRecommendation;
  @override
  final String reasoning;

  @override
  String toString() {
    return 'PricingRecommendations(serviceId: $serviceId, analyzedAt: $analyzedAt, current: $current, strategies: $strategies, marketInsights: $marketInsights, topRecommendation: $topRecommendation, reasoning: $reasoning)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PricingRecommendationsImpl &&
            (identical(other.serviceId, serviceId) ||
                other.serviceId == serviceId) &&
            (identical(other.analyzedAt, analyzedAt) ||
                other.analyzedAt == analyzedAt) &&
            (identical(other.current, current) || other.current == current) &&
            const DeepCollectionEquality()
                .equals(other._strategies, _strategies) &&
            (identical(other.marketInsights, marketInsights) ||
                other.marketInsights == marketInsights) &&
            (identical(other.topRecommendation, topRecommendation) ||
                other.topRecommendation == topRecommendation) &&
            (identical(other.reasoning, reasoning) ||
                other.reasoning == reasoning));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      serviceId,
      analyzedAt,
      current,
      const DeepCollectionEquality().hash(_strategies),
      marketInsights,
      topRecommendation,
      reasoning);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PricingRecommendationsImplCopyWith<_$PricingRecommendationsImpl>
      get copyWith => __$$PricingRecommendationsImplCopyWithImpl<
          _$PricingRecommendationsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PricingRecommendationsImplToJson(
      this,
    );
  }
}

abstract class _PricingRecommendations implements PricingRecommendations {
  const factory _PricingRecommendations(
      {required final String serviceId,
      required final String analyzedAt,
      required final CurrentPricing current,
      required final List<PricingStrategy> strategies,
      required final MarketInsights marketInsights,
      required final String topRecommendation,
      required final String reasoning}) = _$PricingRecommendationsImpl;

  factory _PricingRecommendations.fromJson(Map<String, dynamic> json) =
      _$PricingRecommendationsImpl.fromJson;

  @override
  String get serviceId;
  @override
  String get analyzedAt;
  @override
  CurrentPricing get current;
  @override
  List<PricingStrategy> get strategies;
  @override
  MarketInsights get marketInsights;
  @override
  String get topRecommendation;
  @override
  String get reasoning;
  @override
  @JsonKey(ignore: true)
  _$$PricingRecommendationsImplCopyWith<_$PricingRecommendationsImpl>
      get copyWith => throw _privateConstructorUsedError;
}

CurrentPricing _$CurrentPricingFromJson(Map<String, dynamic> json) {
  return _CurrentPricing.fromJson(json);
}

/// @nodoc
mixin _$CurrentPricing {
  double get price => throw _privateConstructorUsedError;
  double get demand => throw _privateConstructorUsedError;
  double get margin => throw _privateConstructorUsedError;
  String get competitiveness => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CurrentPricingCopyWith<CurrentPricing> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CurrentPricingCopyWith<$Res> {
  factory $CurrentPricingCopyWith(
          CurrentPricing value, $Res Function(CurrentPricing) then) =
      _$CurrentPricingCopyWithImpl<$Res, CurrentPricing>;
  @useResult
  $Res call(
      {double price, double demand, double margin, String competitiveness});
}

/// @nodoc
class _$CurrentPricingCopyWithImpl<$Res, $Val extends CurrentPricing>
    implements $CurrentPricingCopyWith<$Res> {
  _$CurrentPricingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? price = null,
    Object? demand = null,
    Object? margin = null,
    Object? competitiveness = null,
  }) {
    return _then(_value.copyWith(
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      demand: null == demand
          ? _value.demand
          : demand // ignore: cast_nullable_to_non_nullable
              as double,
      margin: null == margin
          ? _value.margin
          : margin // ignore: cast_nullable_to_non_nullable
              as double,
      competitiveness: null == competitiveness
          ? _value.competitiveness
          : competitiveness // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CurrentPricingImplCopyWith<$Res>
    implements $CurrentPricingCopyWith<$Res> {
  factory _$$CurrentPricingImplCopyWith(_$CurrentPricingImpl value,
          $Res Function(_$CurrentPricingImpl) then) =
      __$$CurrentPricingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double price, double demand, double margin, String competitiveness});
}

/// @nodoc
class __$$CurrentPricingImplCopyWithImpl<$Res>
    extends _$CurrentPricingCopyWithImpl<$Res, _$CurrentPricingImpl>
    implements _$$CurrentPricingImplCopyWith<$Res> {
  __$$CurrentPricingImplCopyWithImpl(
      _$CurrentPricingImpl _value, $Res Function(_$CurrentPricingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? price = null,
    Object? demand = null,
    Object? margin = null,
    Object? competitiveness = null,
  }) {
    return _then(_$CurrentPricingImpl(
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      demand: null == demand
          ? _value.demand
          : demand // ignore: cast_nullable_to_non_nullable
              as double,
      margin: null == margin
          ? _value.margin
          : margin // ignore: cast_nullable_to_non_nullable
              as double,
      competitiveness: null == competitiveness
          ? _value.competitiveness
          : competitiveness // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CurrentPricingImpl implements _CurrentPricing {
  const _$CurrentPricingImpl(
      {required this.price,
      required this.demand,
      required this.margin,
      required this.competitiveness});

  factory _$CurrentPricingImpl.fromJson(Map<String, dynamic> json) =>
      _$$CurrentPricingImplFromJson(json);

  @override
  final double price;
  @override
  final double demand;
  @override
  final double margin;
  @override
  final String competitiveness;

  @override
  String toString() {
    return 'CurrentPricing(price: $price, demand: $demand, margin: $margin, competitiveness: $competitiveness)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CurrentPricingImpl &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.demand, demand) || other.demand == demand) &&
            (identical(other.margin, margin) || other.margin == margin) &&
            (identical(other.competitiveness, competitiveness) ||
                other.competitiveness == competitiveness));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, price, demand, margin, competitiveness);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CurrentPricingImplCopyWith<_$CurrentPricingImpl> get copyWith =>
      __$$CurrentPricingImplCopyWithImpl<_$CurrentPricingImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CurrentPricingImplToJson(
      this,
    );
  }
}

abstract class _CurrentPricing implements CurrentPricing {
  const factory _CurrentPricing(
      {required final double price,
      required final double demand,
      required final double margin,
      required final String competitiveness}) = _$CurrentPricingImpl;

  factory _CurrentPricing.fromJson(Map<String, dynamic> json) =
      _$CurrentPricingImpl.fromJson;

  @override
  double get price;
  @override
  double get demand;
  @override
  double get margin;
  @override
  String get competitiveness;
  @override
  @JsonKey(ignore: true)
  _$$CurrentPricingImplCopyWith<_$CurrentPricingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PricingStrategy _$PricingStrategyFromJson(Map<String, dynamic> json) {
  return _PricingStrategy.fromJson(json);
}

/// @nodoc
mixin _$PricingStrategy {
  String get strategy => throw _privateConstructorUsedError;
  double get recommendedPrice => throw _privateConstructorUsedError;
  double get expectedRevenue => throw _privateConstructorUsedError;
  double get expectedMargin => throw _privateConstructorUsedError;
  List<String> get pros => throw _privateConstructorUsedError;
  List<String> get cons => throw _privateConstructorUsedError;
  double get confidence => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PricingStrategyCopyWith<PricingStrategy> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PricingStrategyCopyWith<$Res> {
  factory $PricingStrategyCopyWith(
          PricingStrategy value, $Res Function(PricingStrategy) then) =
      _$PricingStrategyCopyWithImpl<$Res, PricingStrategy>;
  @useResult
  $Res call(
      {String strategy,
      double recommendedPrice,
      double expectedRevenue,
      double expectedMargin,
      List<String> pros,
      List<String> cons,
      double confidence});
}

/// @nodoc
class _$PricingStrategyCopyWithImpl<$Res, $Val extends PricingStrategy>
    implements $PricingStrategyCopyWith<$Res> {
  _$PricingStrategyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? strategy = null,
    Object? recommendedPrice = null,
    Object? expectedRevenue = null,
    Object? expectedMargin = null,
    Object? pros = null,
    Object? cons = null,
    Object? confidence = null,
  }) {
    return _then(_value.copyWith(
      strategy: null == strategy
          ? _value.strategy
          : strategy // ignore: cast_nullable_to_non_nullable
              as String,
      recommendedPrice: null == recommendedPrice
          ? _value.recommendedPrice
          : recommendedPrice // ignore: cast_nullable_to_non_nullable
              as double,
      expectedRevenue: null == expectedRevenue
          ? _value.expectedRevenue
          : expectedRevenue // ignore: cast_nullable_to_non_nullable
              as double,
      expectedMargin: null == expectedMargin
          ? _value.expectedMargin
          : expectedMargin // ignore: cast_nullable_to_non_nullable
              as double,
      pros: null == pros
          ? _value.pros
          : pros // ignore: cast_nullable_to_non_nullable
              as List<String>,
      cons: null == cons
          ? _value.cons
          : cons // ignore: cast_nullable_to_non_nullable
              as List<String>,
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PricingStrategyImplCopyWith<$Res>
    implements $PricingStrategyCopyWith<$Res> {
  factory _$$PricingStrategyImplCopyWith(_$PricingStrategyImpl value,
          $Res Function(_$PricingStrategyImpl) then) =
      __$$PricingStrategyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String strategy,
      double recommendedPrice,
      double expectedRevenue,
      double expectedMargin,
      List<String> pros,
      List<String> cons,
      double confidence});
}

/// @nodoc
class __$$PricingStrategyImplCopyWithImpl<$Res>
    extends _$PricingStrategyCopyWithImpl<$Res, _$PricingStrategyImpl>
    implements _$$PricingStrategyImplCopyWith<$Res> {
  __$$PricingStrategyImplCopyWithImpl(
      _$PricingStrategyImpl _value, $Res Function(_$PricingStrategyImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? strategy = null,
    Object? recommendedPrice = null,
    Object? expectedRevenue = null,
    Object? expectedMargin = null,
    Object? pros = null,
    Object? cons = null,
    Object? confidence = null,
  }) {
    return _then(_$PricingStrategyImpl(
      strategy: null == strategy
          ? _value.strategy
          : strategy // ignore: cast_nullable_to_non_nullable
              as String,
      recommendedPrice: null == recommendedPrice
          ? _value.recommendedPrice
          : recommendedPrice // ignore: cast_nullable_to_non_nullable
              as double,
      expectedRevenue: null == expectedRevenue
          ? _value.expectedRevenue
          : expectedRevenue // ignore: cast_nullable_to_non_nullable
              as double,
      expectedMargin: null == expectedMargin
          ? _value.expectedMargin
          : expectedMargin // ignore: cast_nullable_to_non_nullable
              as double,
      pros: null == pros
          ? _value._pros
          : pros // ignore: cast_nullable_to_non_nullable
              as List<String>,
      cons: null == cons
          ? _value._cons
          : cons // ignore: cast_nullable_to_non_nullable
              as List<String>,
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PricingStrategyImpl implements _PricingStrategy {
  const _$PricingStrategyImpl(
      {required this.strategy,
      required this.recommendedPrice,
      required this.expectedRevenue,
      required this.expectedMargin,
      required final List<String> pros,
      required final List<String> cons,
      required this.confidence})
      : _pros = pros,
        _cons = cons;

  factory _$PricingStrategyImpl.fromJson(Map<String, dynamic> json) =>
      _$$PricingStrategyImplFromJson(json);

  @override
  final String strategy;
  @override
  final double recommendedPrice;
  @override
  final double expectedRevenue;
  @override
  final double expectedMargin;
  final List<String> _pros;
  @override
  List<String> get pros {
    if (_pros is EqualUnmodifiableListView) return _pros;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pros);
  }

  final List<String> _cons;
  @override
  List<String> get cons {
    if (_cons is EqualUnmodifiableListView) return _cons;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cons);
  }

  @override
  final double confidence;

  @override
  String toString() {
    return 'PricingStrategy(strategy: $strategy, recommendedPrice: $recommendedPrice, expectedRevenue: $expectedRevenue, expectedMargin: $expectedMargin, pros: $pros, cons: $cons, confidence: $confidence)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PricingStrategyImpl &&
            (identical(other.strategy, strategy) ||
                other.strategy == strategy) &&
            (identical(other.recommendedPrice, recommendedPrice) ||
                other.recommendedPrice == recommendedPrice) &&
            (identical(other.expectedRevenue, expectedRevenue) ||
                other.expectedRevenue == expectedRevenue) &&
            (identical(other.expectedMargin, expectedMargin) ||
                other.expectedMargin == expectedMargin) &&
            const DeepCollectionEquality().equals(other._pros, _pros) &&
            const DeepCollectionEquality().equals(other._cons, _cons) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      strategy,
      recommendedPrice,
      expectedRevenue,
      expectedMargin,
      const DeepCollectionEquality().hash(_pros),
      const DeepCollectionEquality().hash(_cons),
      confidence);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PricingStrategyImplCopyWith<_$PricingStrategyImpl> get copyWith =>
      __$$PricingStrategyImplCopyWithImpl<_$PricingStrategyImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PricingStrategyImplToJson(
      this,
    );
  }
}

abstract class _PricingStrategy implements PricingStrategy {
  const factory _PricingStrategy(
      {required final String strategy,
      required final double recommendedPrice,
      required final double expectedRevenue,
      required final double expectedMargin,
      required final List<String> pros,
      required final List<String> cons,
      required final double confidence}) = _$PricingStrategyImpl;

  factory _PricingStrategy.fromJson(Map<String, dynamic> json) =
      _$PricingStrategyImpl.fromJson;

  @override
  String get strategy;
  @override
  double get recommendedPrice;
  @override
  double get expectedRevenue;
  @override
  double get expectedMargin;
  @override
  List<String> get pros;
  @override
  List<String> get cons;
  @override
  double get confidence;
  @override
  @JsonKey(ignore: true)
  _$$PricingStrategyImplCopyWith<_$PricingStrategyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MarketInsights _$MarketInsightsFromJson(Map<String, dynamic> json) {
  return _MarketInsights.fromJson(json);
}

/// @nodoc
mixin _$MarketInsights {
  CompetitorPricing get competitorPricing => throw _privateConstructorUsedError;
  double get demandElasticity => throw _privateConstructorUsedError;
  double get priceOptimizationPotential => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MarketInsightsCopyWith<MarketInsights> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MarketInsightsCopyWith<$Res> {
  factory $MarketInsightsCopyWith(
          MarketInsights value, $Res Function(MarketInsights) then) =
      _$MarketInsightsCopyWithImpl<$Res, MarketInsights>;
  @useResult
  $Res call(
      {CompetitorPricing competitorPricing,
      double demandElasticity,
      double priceOptimizationPotential});

  $CompetitorPricingCopyWith<$Res> get competitorPricing;
}

/// @nodoc
class _$MarketInsightsCopyWithImpl<$Res, $Val extends MarketInsights>
    implements $MarketInsightsCopyWith<$Res> {
  _$MarketInsightsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? competitorPricing = null,
    Object? demandElasticity = null,
    Object? priceOptimizationPotential = null,
  }) {
    return _then(_value.copyWith(
      competitorPricing: null == competitorPricing
          ? _value.competitorPricing
          : competitorPricing // ignore: cast_nullable_to_non_nullable
              as CompetitorPricing,
      demandElasticity: null == demandElasticity
          ? _value.demandElasticity
          : demandElasticity // ignore: cast_nullable_to_non_nullable
              as double,
      priceOptimizationPotential: null == priceOptimizationPotential
          ? _value.priceOptimizationPotential
          : priceOptimizationPotential // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CompetitorPricingCopyWith<$Res> get competitorPricing {
    return $CompetitorPricingCopyWith<$Res>(_value.competitorPricing, (value) {
      return _then(_value.copyWith(competitorPricing: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MarketInsightsImplCopyWith<$Res>
    implements $MarketInsightsCopyWith<$Res> {
  factory _$$MarketInsightsImplCopyWith(_$MarketInsightsImpl value,
          $Res Function(_$MarketInsightsImpl) then) =
      __$$MarketInsightsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {CompetitorPricing competitorPricing,
      double demandElasticity,
      double priceOptimizationPotential});

  @override
  $CompetitorPricingCopyWith<$Res> get competitorPricing;
}

/// @nodoc
class __$$MarketInsightsImplCopyWithImpl<$Res>
    extends _$MarketInsightsCopyWithImpl<$Res, _$MarketInsightsImpl>
    implements _$$MarketInsightsImplCopyWith<$Res> {
  __$$MarketInsightsImplCopyWithImpl(
      _$MarketInsightsImpl _value, $Res Function(_$MarketInsightsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? competitorPricing = null,
    Object? demandElasticity = null,
    Object? priceOptimizationPotential = null,
  }) {
    return _then(_$MarketInsightsImpl(
      competitorPricing: null == competitorPricing
          ? _value.competitorPricing
          : competitorPricing // ignore: cast_nullable_to_non_nullable
              as CompetitorPricing,
      demandElasticity: null == demandElasticity
          ? _value.demandElasticity
          : demandElasticity // ignore: cast_nullable_to_non_nullable
              as double,
      priceOptimizationPotential: null == priceOptimizationPotential
          ? _value.priceOptimizationPotential
          : priceOptimizationPotential // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MarketInsightsImpl implements _MarketInsights {
  const _$MarketInsightsImpl(
      {required this.competitorPricing,
      required this.demandElasticity,
      required this.priceOptimizationPotential});

  factory _$MarketInsightsImpl.fromJson(Map<String, dynamic> json) =>
      _$$MarketInsightsImplFromJson(json);

  @override
  final CompetitorPricing competitorPricing;
  @override
  final double demandElasticity;
  @override
  final double priceOptimizationPotential;

  @override
  String toString() {
    return 'MarketInsights(competitorPricing: $competitorPricing, demandElasticity: $demandElasticity, priceOptimizationPotential: $priceOptimizationPotential)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MarketInsightsImpl &&
            (identical(other.competitorPricing, competitorPricing) ||
                other.competitorPricing == competitorPricing) &&
            (identical(other.demandElasticity, demandElasticity) ||
                other.demandElasticity == demandElasticity) &&
            (identical(other.priceOptimizationPotential,
                    priceOptimizationPotential) ||
                other.priceOptimizationPotential ==
                    priceOptimizationPotential));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, competitorPricing,
      demandElasticity, priceOptimizationPotential);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MarketInsightsImplCopyWith<_$MarketInsightsImpl> get copyWith =>
      __$$MarketInsightsImplCopyWithImpl<_$MarketInsightsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MarketInsightsImplToJson(
      this,
    );
  }
}

abstract class _MarketInsights implements MarketInsights {
  const factory _MarketInsights(
      {required final CompetitorPricing competitorPricing,
      required final double demandElasticity,
      required final double priceOptimizationPotential}) = _$MarketInsightsImpl;

  factory _MarketInsights.fromJson(Map<String, dynamic> json) =
      _$MarketInsightsImpl.fromJson;

  @override
  CompetitorPricing get competitorPricing;
  @override
  double get demandElasticity;
  @override
  double get priceOptimizationPotential;
  @override
  @JsonKey(ignore: true)
  _$$MarketInsightsImplCopyWith<_$MarketInsightsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CompetitorPricing _$CompetitorPricingFromJson(Map<String, dynamic> json) {
  return _CompetitorPricing.fromJson(json);
}

/// @nodoc
mixin _$CompetitorPricing {
  double get average => throw _privateConstructorUsedError;
  List<double> get range => throw _privateConstructorUsedError;
  String get position => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CompetitorPricingCopyWith<CompetitorPricing> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CompetitorPricingCopyWith<$Res> {
  factory $CompetitorPricingCopyWith(
          CompetitorPricing value, $Res Function(CompetitorPricing) then) =
      _$CompetitorPricingCopyWithImpl<$Res, CompetitorPricing>;
  @useResult
  $Res call({double average, List<double> range, String position});
}

/// @nodoc
class _$CompetitorPricingCopyWithImpl<$Res, $Val extends CompetitorPricing>
    implements $CompetitorPricingCopyWith<$Res> {
  _$CompetitorPricingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? average = null,
    Object? range = null,
    Object? position = null,
  }) {
    return _then(_value.copyWith(
      average: null == average
          ? _value.average
          : average // ignore: cast_nullable_to_non_nullable
              as double,
      range: null == range
          ? _value.range
          : range // ignore: cast_nullable_to_non_nullable
              as List<double>,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CompetitorPricingImplCopyWith<$Res>
    implements $CompetitorPricingCopyWith<$Res> {
  factory _$$CompetitorPricingImplCopyWith(_$CompetitorPricingImpl value,
          $Res Function(_$CompetitorPricingImpl) then) =
      __$$CompetitorPricingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double average, List<double> range, String position});
}

/// @nodoc
class __$$CompetitorPricingImplCopyWithImpl<$Res>
    extends _$CompetitorPricingCopyWithImpl<$Res, _$CompetitorPricingImpl>
    implements _$$CompetitorPricingImplCopyWith<$Res> {
  __$$CompetitorPricingImplCopyWithImpl(_$CompetitorPricingImpl _value,
      $Res Function(_$CompetitorPricingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? average = null,
    Object? range = null,
    Object? position = null,
  }) {
    return _then(_$CompetitorPricingImpl(
      average: null == average
          ? _value.average
          : average // ignore: cast_nullable_to_non_nullable
              as double,
      range: null == range
          ? _value._range
          : range // ignore: cast_nullable_to_non_nullable
              as List<double>,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CompetitorPricingImpl implements _CompetitorPricing {
  const _$CompetitorPricingImpl(
      {required this.average,
      required final List<double> range,
      required this.position})
      : _range = range;

  factory _$CompetitorPricingImpl.fromJson(Map<String, dynamic> json) =>
      _$$CompetitorPricingImplFromJson(json);

  @override
  final double average;
  final List<double> _range;
  @override
  List<double> get range {
    if (_range is EqualUnmodifiableListView) return _range;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_range);
  }

  @override
  final String position;

  @override
  String toString() {
    return 'CompetitorPricing(average: $average, range: $range, position: $position)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CompetitorPricingImpl &&
            (identical(other.average, average) || other.average == average) &&
            const DeepCollectionEquality().equals(other._range, _range) &&
            (identical(other.position, position) ||
                other.position == position));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, average,
      const DeepCollectionEquality().hash(_range), position);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CompetitorPricingImplCopyWith<_$CompetitorPricingImpl> get copyWith =>
      __$$CompetitorPricingImplCopyWithImpl<_$CompetitorPricingImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CompetitorPricingImplToJson(
      this,
    );
  }
}

abstract class _CompetitorPricing implements CompetitorPricing {
  const factory _CompetitorPricing(
      {required final double average,
      required final List<double> range,
      required final String position}) = _$CompetitorPricingImpl;

  factory _CompetitorPricing.fromJson(Map<String, dynamic> json) =
      _$CompetitorPricingImpl.fromJson;

  @override
  double get average;
  @override
  List<double> get range;
  @override
  String get position;
  @override
  @JsonKey(ignore: true)
  _$$CompetitorPricingImplCopyWith<_$CompetitorPricingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Invoice _$InvoiceFromJson(Map<String, dynamic> json) {
  return _Invoice.fromJson(json);
}

/// @nodoc
mixin _$Invoice {
  String get invoiceId => throw _privateConstructorUsedError;
  String get organizationId => throw _privateConstructorUsedError;
  String get clientId => throw _privateConstructorUsedError;
  String get period => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  double get gst => throw _privateConstructorUsedError;
  double get total => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;
  List<LineItem> get lineItems => throw _privateConstructorUsedError;
  ValidationResult? get validation => throw _privateConstructorUsedError;
  List<BillingAnomaly>? get anomalies => throw _privateConstructorUsedError;
  String? get approvedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InvoiceCopyWith<Invoice> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InvoiceCopyWith<$Res> {
  factory $InvoiceCopyWith(Invoice value, $Res Function(Invoice) then) =
      _$InvoiceCopyWithImpl<$Res, Invoice>;
  @useResult
  $Res call(
      {String invoiceId,
      String organizationId,
      String clientId,
      String period,
      double amount,
      double gst,
      double total,
      String status,
      String createdAt,
      List<LineItem> lineItems,
      ValidationResult? validation,
      List<BillingAnomaly>? anomalies,
      String? approvedAt});

  $ValidationResultCopyWith<$Res>? get validation;
}

/// @nodoc
class _$InvoiceCopyWithImpl<$Res, $Val extends Invoice>
    implements $InvoiceCopyWith<$Res> {
  _$InvoiceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? invoiceId = null,
    Object? organizationId = null,
    Object? clientId = null,
    Object? period = null,
    Object? amount = null,
    Object? gst = null,
    Object? total = null,
    Object? status = null,
    Object? createdAt = null,
    Object? lineItems = null,
    Object? validation = freezed,
    Object? anomalies = freezed,
    Object? approvedAt = freezed,
  }) {
    return _then(_value.copyWith(
      invoiceId: null == invoiceId
          ? _value.invoiceId
          : invoiceId // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      clientId: null == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      period: null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      gst: null == gst
          ? _value.gst
          : gst // ignore: cast_nullable_to_non_nullable
              as double,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as double,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      lineItems: null == lineItems
          ? _value.lineItems
          : lineItems // ignore: cast_nullable_to_non_nullable
              as List<LineItem>,
      validation: freezed == validation
          ? _value.validation
          : validation // ignore: cast_nullable_to_non_nullable
              as ValidationResult?,
      anomalies: freezed == anomalies
          ? _value.anomalies
          : anomalies // ignore: cast_nullable_to_non_nullable
              as List<BillingAnomaly>?,
      approvedAt: freezed == approvedAt
          ? _value.approvedAt
          : approvedAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ValidationResultCopyWith<$Res>? get validation {
    if (_value.validation == null) {
      return null;
    }

    return $ValidationResultCopyWith<$Res>(_value.validation!, (value) {
      return _then(_value.copyWith(validation: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$InvoiceImplCopyWith<$Res> implements $InvoiceCopyWith<$Res> {
  factory _$$InvoiceImplCopyWith(
          _$InvoiceImpl value, $Res Function(_$InvoiceImpl) then) =
      __$$InvoiceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String invoiceId,
      String organizationId,
      String clientId,
      String period,
      double amount,
      double gst,
      double total,
      String status,
      String createdAt,
      List<LineItem> lineItems,
      ValidationResult? validation,
      List<BillingAnomaly>? anomalies,
      String? approvedAt});

  @override
  $ValidationResultCopyWith<$Res>? get validation;
}

/// @nodoc
class __$$InvoiceImplCopyWithImpl<$Res>
    extends _$InvoiceCopyWithImpl<$Res, _$InvoiceImpl>
    implements _$$InvoiceImplCopyWith<$Res> {
  __$$InvoiceImplCopyWithImpl(
      _$InvoiceImpl _value, $Res Function(_$InvoiceImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? invoiceId = null,
    Object? organizationId = null,
    Object? clientId = null,
    Object? period = null,
    Object? amount = null,
    Object? gst = null,
    Object? total = null,
    Object? status = null,
    Object? createdAt = null,
    Object? lineItems = null,
    Object? validation = freezed,
    Object? anomalies = freezed,
    Object? approvedAt = freezed,
  }) {
    return _then(_$InvoiceImpl(
      invoiceId: null == invoiceId
          ? _value.invoiceId
          : invoiceId // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      clientId: null == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      period: null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      gst: null == gst
          ? _value.gst
          : gst // ignore: cast_nullable_to_non_nullable
              as double,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as double,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      lineItems: null == lineItems
          ? _value._lineItems
          : lineItems // ignore: cast_nullable_to_non_nullable
              as List<LineItem>,
      validation: freezed == validation
          ? _value.validation
          : validation // ignore: cast_nullable_to_non_nullable
              as ValidationResult?,
      anomalies: freezed == anomalies
          ? _value._anomalies
          : anomalies // ignore: cast_nullable_to_non_nullable
              as List<BillingAnomaly>?,
      approvedAt: freezed == approvedAt
          ? _value.approvedAt
          : approvedAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InvoiceImpl implements _Invoice {
  const _$InvoiceImpl(
      {required this.invoiceId,
      required this.organizationId,
      required this.clientId,
      required this.period,
      required this.amount,
      required this.gst,
      required this.total,
      required this.status,
      required this.createdAt,
      required final List<LineItem> lineItems,
      this.validation,
      final List<BillingAnomaly>? anomalies,
      this.approvedAt})
      : _lineItems = lineItems,
        _anomalies = anomalies;

  factory _$InvoiceImpl.fromJson(Map<String, dynamic> json) =>
      _$$InvoiceImplFromJson(json);

  @override
  final String invoiceId;
  @override
  final String organizationId;
  @override
  final String clientId;
  @override
  final String period;
  @override
  final double amount;
  @override
  final double gst;
  @override
  final double total;
  @override
  final String status;
  @override
  final String createdAt;
  final List<LineItem> _lineItems;
  @override
  List<LineItem> get lineItems {
    if (_lineItems is EqualUnmodifiableListView) return _lineItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_lineItems);
  }

  @override
  final ValidationResult? validation;
  final List<BillingAnomaly>? _anomalies;
  @override
  List<BillingAnomaly>? get anomalies {
    final value = _anomalies;
    if (value == null) return null;
    if (_anomalies is EqualUnmodifiableListView) return _anomalies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? approvedAt;

  @override
  String toString() {
    return 'Invoice(invoiceId: $invoiceId, organizationId: $organizationId, clientId: $clientId, period: $period, amount: $amount, gst: $gst, total: $total, status: $status, createdAt: $createdAt, lineItems: $lineItems, validation: $validation, anomalies: $anomalies, approvedAt: $approvedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InvoiceImpl &&
            (identical(other.invoiceId, invoiceId) ||
                other.invoiceId == invoiceId) &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.period, period) || other.period == period) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.gst, gst) || other.gst == gst) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality()
                .equals(other._lineItems, _lineItems) &&
            (identical(other.validation, validation) ||
                other.validation == validation) &&
            const DeepCollectionEquality()
                .equals(other._anomalies, _anomalies) &&
            (identical(other.approvedAt, approvedAt) ||
                other.approvedAt == approvedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      invoiceId,
      organizationId,
      clientId,
      period,
      amount,
      gst,
      total,
      status,
      createdAt,
      const DeepCollectionEquality().hash(_lineItems),
      validation,
      const DeepCollectionEquality().hash(_anomalies),
      approvedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InvoiceImplCopyWith<_$InvoiceImpl> get copyWith =>
      __$$InvoiceImplCopyWithImpl<_$InvoiceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InvoiceImplToJson(
      this,
    );
  }
}

abstract class _Invoice implements Invoice {
  const factory _Invoice(
      {required final String invoiceId,
      required final String organizationId,
      required final String clientId,
      required final String period,
      required final double amount,
      required final double gst,
      required final double total,
      required final String status,
      required final String createdAt,
      required final List<LineItem> lineItems,
      final ValidationResult? validation,
      final List<BillingAnomaly>? anomalies,
      final String? approvedAt}) = _$InvoiceImpl;

  factory _Invoice.fromJson(Map<String, dynamic> json) = _$InvoiceImpl.fromJson;

  @override
  String get invoiceId;
  @override
  String get organizationId;
  @override
  String get clientId;
  @override
  String get period;
  @override
  double get amount;
  @override
  double get gst;
  @override
  double get total;
  @override
  String get status;
  @override
  String get createdAt;
  @override
  List<LineItem> get lineItems;
  @override
  ValidationResult? get validation;
  @override
  List<BillingAnomaly>? get anomalies;
  @override
  String? get approvedAt;
  @override
  @JsonKey(ignore: true)
  _$$InvoiceImplCopyWith<_$InvoiceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LineItem _$LineItemFromJson(Map<String, dynamic> json) {
  return _LineItem.fromJson(json);
}

/// @nodoc
mixin _$LineItem {
  String get description => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  double get rate => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LineItemCopyWith<LineItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LineItemCopyWith<$Res> {
  factory $LineItemCopyWith(LineItem value, $Res Function(LineItem) then) =
      _$LineItemCopyWithImpl<$Res, LineItem>;
  @useResult
  $Res call({String description, int quantity, double rate, double amount});
}

/// @nodoc
class _$LineItemCopyWithImpl<$Res, $Val extends LineItem>
    implements $LineItemCopyWith<$Res> {
  _$LineItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = null,
    Object? quantity = null,
    Object? rate = null,
    Object? amount = null,
  }) {
    return _then(_value.copyWith(
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      rate: null == rate
          ? _value.rate
          : rate // ignore: cast_nullable_to_non_nullable
              as double,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LineItemImplCopyWith<$Res>
    implements $LineItemCopyWith<$Res> {
  factory _$$LineItemImplCopyWith(
          _$LineItemImpl value, $Res Function(_$LineItemImpl) then) =
      __$$LineItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String description, int quantity, double rate, double amount});
}

/// @nodoc
class __$$LineItemImplCopyWithImpl<$Res>
    extends _$LineItemCopyWithImpl<$Res, _$LineItemImpl>
    implements _$$LineItemImplCopyWith<$Res> {
  __$$LineItemImplCopyWithImpl(
      _$LineItemImpl _value, $Res Function(_$LineItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = null,
    Object? quantity = null,
    Object? rate = null,
    Object? amount = null,
  }) {
    return _then(_$LineItemImpl(
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      rate: null == rate
          ? _value.rate
          : rate // ignore: cast_nullable_to_non_nullable
              as double,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LineItemImpl implements _LineItem {
  const _$LineItemImpl(
      {required this.description,
      required this.quantity,
      required this.rate,
      required this.amount});

  factory _$LineItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$LineItemImplFromJson(json);

  @override
  final String description;
  @override
  final int quantity;
  @override
  final double rate;
  @override
  final double amount;

  @override
  String toString() {
    return 'LineItem(description: $description, quantity: $quantity, rate: $rate, amount: $amount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LineItemImpl &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.rate, rate) || other.rate == rate) &&
            (identical(other.amount, amount) || other.amount == amount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, description, quantity, rate, amount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LineItemImplCopyWith<_$LineItemImpl> get copyWith =>
      __$$LineItemImplCopyWithImpl<_$LineItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LineItemImplToJson(
      this,
    );
  }
}

abstract class _LineItem implements LineItem {
  const factory _LineItem(
      {required final String description,
      required final int quantity,
      required final double rate,
      required final double amount}) = _$LineItemImpl;

  factory _LineItem.fromJson(Map<String, dynamic> json) =
      _$LineItemImpl.fromJson;

  @override
  String get description;
  @override
  int get quantity;
  @override
  double get rate;
  @override
  double get amount;
  @override
  @JsonKey(ignore: true)
  _$$LineItemImplCopyWith<_$LineItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ValidationResult _$ValidationResultFromJson(Map<String, dynamic> json) {
  return _ValidationResult.fromJson(json);
}

/// @nodoc
mixin _$ValidationResult {
  bool get passed => throw _privateConstructorUsedError;
  List<String> get errors => throw _privateConstructorUsedError;
  List<String> get warnings => throw _privateConstructorUsedError;
  List<ValidationCheck> get checks => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ValidationResultCopyWith<ValidationResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ValidationResultCopyWith<$Res> {
  factory $ValidationResultCopyWith(
          ValidationResult value, $Res Function(ValidationResult) then) =
      _$ValidationResultCopyWithImpl<$Res, ValidationResult>;
  @useResult
  $Res call(
      {bool passed,
      List<String> errors,
      List<String> warnings,
      List<ValidationCheck> checks});
}

/// @nodoc
class _$ValidationResultCopyWithImpl<$Res, $Val extends ValidationResult>
    implements $ValidationResultCopyWith<$Res> {
  _$ValidationResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? passed = null,
    Object? errors = null,
    Object? warnings = null,
    Object? checks = null,
  }) {
    return _then(_value.copyWith(
      passed: null == passed
          ? _value.passed
          : passed // ignore: cast_nullable_to_non_nullable
              as bool,
      errors: null == errors
          ? _value.errors
          : errors // ignore: cast_nullable_to_non_nullable
              as List<String>,
      warnings: null == warnings
          ? _value.warnings
          : warnings // ignore: cast_nullable_to_non_nullable
              as List<String>,
      checks: null == checks
          ? _value.checks
          : checks // ignore: cast_nullable_to_non_nullable
              as List<ValidationCheck>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ValidationResultImplCopyWith<$Res>
    implements $ValidationResultCopyWith<$Res> {
  factory _$$ValidationResultImplCopyWith(_$ValidationResultImpl value,
          $Res Function(_$ValidationResultImpl) then) =
      __$$ValidationResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool passed,
      List<String> errors,
      List<String> warnings,
      List<ValidationCheck> checks});
}

/// @nodoc
class __$$ValidationResultImplCopyWithImpl<$Res>
    extends _$ValidationResultCopyWithImpl<$Res, _$ValidationResultImpl>
    implements _$$ValidationResultImplCopyWith<$Res> {
  __$$ValidationResultImplCopyWithImpl(_$ValidationResultImpl _value,
      $Res Function(_$ValidationResultImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? passed = null,
    Object? errors = null,
    Object? warnings = null,
    Object? checks = null,
  }) {
    return _then(_$ValidationResultImpl(
      passed: null == passed
          ? _value.passed
          : passed // ignore: cast_nullable_to_non_nullable
              as bool,
      errors: null == errors
          ? _value._errors
          : errors // ignore: cast_nullable_to_non_nullable
              as List<String>,
      warnings: null == warnings
          ? _value._warnings
          : warnings // ignore: cast_nullable_to_non_nullable
              as List<String>,
      checks: null == checks
          ? _value._checks
          : checks // ignore: cast_nullable_to_non_nullable
              as List<ValidationCheck>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ValidationResultImpl implements _ValidationResult {
  const _$ValidationResultImpl(
      {required this.passed,
      required final List<String> errors,
      required final List<String> warnings,
      required final List<ValidationCheck> checks})
      : _errors = errors,
        _warnings = warnings,
        _checks = checks;

  factory _$ValidationResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$ValidationResultImplFromJson(json);

  @override
  final bool passed;
  final List<String> _errors;
  @override
  List<String> get errors {
    if (_errors is EqualUnmodifiableListView) return _errors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_errors);
  }

  final List<String> _warnings;
  @override
  List<String> get warnings {
    if (_warnings is EqualUnmodifiableListView) return _warnings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_warnings);
  }

  final List<ValidationCheck> _checks;
  @override
  List<ValidationCheck> get checks {
    if (_checks is EqualUnmodifiableListView) return _checks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_checks);
  }

  @override
  String toString() {
    return 'ValidationResult(passed: $passed, errors: $errors, warnings: $warnings, checks: $checks)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ValidationResultImpl &&
            (identical(other.passed, passed) || other.passed == passed) &&
            const DeepCollectionEquality().equals(other._errors, _errors) &&
            const DeepCollectionEquality().equals(other._warnings, _warnings) &&
            const DeepCollectionEquality().equals(other._checks, _checks));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      passed,
      const DeepCollectionEquality().hash(_errors),
      const DeepCollectionEquality().hash(_warnings),
      const DeepCollectionEquality().hash(_checks));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ValidationResultImplCopyWith<_$ValidationResultImpl> get copyWith =>
      __$$ValidationResultImplCopyWithImpl<_$ValidationResultImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ValidationResultImplToJson(
      this,
    );
  }
}

abstract class _ValidationResult implements ValidationResult {
  const factory _ValidationResult(
      {required final bool passed,
      required final List<String> errors,
      required final List<String> warnings,
      required final List<ValidationCheck> checks}) = _$ValidationResultImpl;

  factory _ValidationResult.fromJson(Map<String, dynamic> json) =
      _$ValidationResultImpl.fromJson;

  @override
  bool get passed;
  @override
  List<String> get errors;
  @override
  List<String> get warnings;
  @override
  List<ValidationCheck> get checks;
  @override
  @JsonKey(ignore: true)
  _$$ValidationResultImplCopyWith<_$ValidationResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ValidationCheck _$ValidationCheckFromJson(Map<String, dynamic> json) {
  return _ValidationCheck.fromJson(json);
}

/// @nodoc
mixin _$ValidationCheck {
  String get check => throw _privateConstructorUsedError;
  bool get passed => throw _privateConstructorUsedError;
  List<String> get errors => throw _privateConstructorUsedError;
  String get details => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ValidationCheckCopyWith<ValidationCheck> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ValidationCheckCopyWith<$Res> {
  factory $ValidationCheckCopyWith(
          ValidationCheck value, $Res Function(ValidationCheck) then) =
      _$ValidationCheckCopyWithImpl<$Res, ValidationCheck>;
  @useResult
  $Res call({String check, bool passed, List<String> errors, String details});
}

/// @nodoc
class _$ValidationCheckCopyWithImpl<$Res, $Val extends ValidationCheck>
    implements $ValidationCheckCopyWith<$Res> {
  _$ValidationCheckCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? check = null,
    Object? passed = null,
    Object? errors = null,
    Object? details = null,
  }) {
    return _then(_value.copyWith(
      check: null == check
          ? _value.check
          : check // ignore: cast_nullable_to_non_nullable
              as String,
      passed: null == passed
          ? _value.passed
          : passed // ignore: cast_nullable_to_non_nullable
              as bool,
      errors: null == errors
          ? _value.errors
          : errors // ignore: cast_nullable_to_non_nullable
              as List<String>,
      details: null == details
          ? _value.details
          : details // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ValidationCheckImplCopyWith<$Res>
    implements $ValidationCheckCopyWith<$Res> {
  factory _$$ValidationCheckImplCopyWith(_$ValidationCheckImpl value,
          $Res Function(_$ValidationCheckImpl) then) =
      __$$ValidationCheckImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String check, bool passed, List<String> errors, String details});
}

/// @nodoc
class __$$ValidationCheckImplCopyWithImpl<$Res>
    extends _$ValidationCheckCopyWithImpl<$Res, _$ValidationCheckImpl>
    implements _$$ValidationCheckImplCopyWith<$Res> {
  __$$ValidationCheckImplCopyWithImpl(
      _$ValidationCheckImpl _value, $Res Function(_$ValidationCheckImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? check = null,
    Object? passed = null,
    Object? errors = null,
    Object? details = null,
  }) {
    return _then(_$ValidationCheckImpl(
      check: null == check
          ? _value.check
          : check // ignore: cast_nullable_to_non_nullable
              as String,
      passed: null == passed
          ? _value.passed
          : passed // ignore: cast_nullable_to_non_nullable
              as bool,
      errors: null == errors
          ? _value._errors
          : errors // ignore: cast_nullable_to_non_nullable
              as List<String>,
      details: null == details
          ? _value.details
          : details // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ValidationCheckImpl implements _ValidationCheck {
  const _$ValidationCheckImpl(
      {required this.check,
      required this.passed,
      required final List<String> errors,
      required this.details})
      : _errors = errors;

  factory _$ValidationCheckImpl.fromJson(Map<String, dynamic> json) =>
      _$$ValidationCheckImplFromJson(json);

  @override
  final String check;
  @override
  final bool passed;
  final List<String> _errors;
  @override
  List<String> get errors {
    if (_errors is EqualUnmodifiableListView) return _errors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_errors);
  }

  @override
  final String details;

  @override
  String toString() {
    return 'ValidationCheck(check: $check, passed: $passed, errors: $errors, details: $details)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ValidationCheckImpl &&
            (identical(other.check, check) || other.check == check) &&
            (identical(other.passed, passed) || other.passed == passed) &&
            const DeepCollectionEquality().equals(other._errors, _errors) &&
            (identical(other.details, details) || other.details == details));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, check, passed,
      const DeepCollectionEquality().hash(_errors), details);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ValidationCheckImplCopyWith<_$ValidationCheckImpl> get copyWith =>
      __$$ValidationCheckImplCopyWithImpl<_$ValidationCheckImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ValidationCheckImplToJson(
      this,
    );
  }
}

abstract class _ValidationCheck implements ValidationCheck {
  const factory _ValidationCheck(
      {required final String check,
      required final bool passed,
      required final List<String> errors,
      required final String details}) = _$ValidationCheckImpl;

  factory _ValidationCheck.fromJson(Map<String, dynamic> json) =
      _$ValidationCheckImpl.fromJson;

  @override
  String get check;
  @override
  bool get passed;
  @override
  List<String> get errors;
  @override
  String get details;
  @override
  @JsonKey(ignore: true)
  _$$ValidationCheckImplCopyWith<_$ValidationCheckImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BillingAnomaly _$BillingAnomalyFromJson(Map<String, dynamic> json) {
  return _BillingAnomaly.fromJson(json);
}

/// @nodoc
mixin _$BillingAnomaly {
  String get type => throw _privateConstructorUsedError;
  String get severity => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  Map<String, dynamic>? get details => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BillingAnomalyCopyWith<BillingAnomaly> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BillingAnomalyCopyWith<$Res> {
  factory $BillingAnomalyCopyWith(
          BillingAnomaly value, $Res Function(BillingAnomaly) then) =
      _$BillingAnomalyCopyWithImpl<$Res, BillingAnomaly>;
  @useResult
  $Res call(
      {String type,
      String severity,
      String description,
      Map<String, dynamic>? details});
}

/// @nodoc
class _$BillingAnomalyCopyWithImpl<$Res, $Val extends BillingAnomaly>
    implements $BillingAnomalyCopyWith<$Res> {
  _$BillingAnomalyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? severity = null,
    Object? description = null,
    Object? details = freezed,
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
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      details: freezed == details
          ? _value.details
          : details // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BillingAnomalyImplCopyWith<$Res>
    implements $BillingAnomalyCopyWith<$Res> {
  factory _$$BillingAnomalyImplCopyWith(_$BillingAnomalyImpl value,
          $Res Function(_$BillingAnomalyImpl) then) =
      __$$BillingAnomalyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String type,
      String severity,
      String description,
      Map<String, dynamic>? details});
}

/// @nodoc
class __$$BillingAnomalyImplCopyWithImpl<$Res>
    extends _$BillingAnomalyCopyWithImpl<$Res, _$BillingAnomalyImpl>
    implements _$$BillingAnomalyImplCopyWith<$Res> {
  __$$BillingAnomalyImplCopyWithImpl(
      _$BillingAnomalyImpl _value, $Res Function(_$BillingAnomalyImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? severity = null,
    Object? description = null,
    Object? details = freezed,
  }) {
    return _then(_$BillingAnomalyImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      severity: null == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      details: freezed == details
          ? _value._details
          : details // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BillingAnomalyImpl implements _BillingAnomaly {
  const _$BillingAnomalyImpl(
      {required this.type,
      required this.severity,
      required this.description,
      final Map<String, dynamic>? details})
      : _details = details;

  factory _$BillingAnomalyImpl.fromJson(Map<String, dynamic> json) =>
      _$$BillingAnomalyImplFromJson(json);

  @override
  final String type;
  @override
  final String severity;
  @override
  final String description;
  final Map<String, dynamic>? _details;
  @override
  Map<String, dynamic>? get details {
    final value = _details;
    if (value == null) return null;
    if (_details is EqualUnmodifiableMapView) return _details;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'BillingAnomaly(type: $type, severity: $severity, description: $description, details: $details)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BillingAnomalyImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.severity, severity) ||
                other.severity == severity) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._details, _details));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, type, severity, description,
      const DeepCollectionEquality().hash(_details));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BillingAnomalyImplCopyWith<_$BillingAnomalyImpl> get copyWith =>
      __$$BillingAnomalyImplCopyWithImpl<_$BillingAnomalyImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BillingAnomalyImplToJson(
      this,
    );
  }
}

abstract class _BillingAnomaly implements BillingAnomaly {
  const factory _BillingAnomaly(
      {required final String type,
      required final String severity,
      required final String description,
      final Map<String, dynamic>? details}) = _$BillingAnomalyImpl;

  factory _BillingAnomaly.fromJson(Map<String, dynamic> json) =
      _$BillingAnomalyImpl.fromJson;

  @override
  String get type;
  @override
  String get severity;
  @override
  String get description;
  @override
  Map<String, dynamic>? get details;
  @override
  @JsonKey(ignore: true)
  _$$BillingAnomalyImplCopyWith<_$BillingAnomalyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CreditNote _$CreditNoteFromJson(Map<String, dynamic> json) {
  return _CreditNote.fromJson(json);
}

/// @nodoc
mixin _$CreditNote {
  String get creditNoteId => throw _privateConstructorUsedError;
  String get invoiceId => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  String get reason => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;
  double get gst => throw _privateConstructorUsedError;
  double get totalCredit => throw _privateConstructorUsedError;
  CreditNoteWorkflow get workflow => throw _privateConstructorUsedError;
  List<AuditEntry> get auditTrail => throw _privateConstructorUsedError;
  String? get approvedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CreditNoteCopyWith<CreditNote> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreditNoteCopyWith<$Res> {
  factory $CreditNoteCopyWith(
          CreditNote value, $Res Function(CreditNote) then) =
      _$CreditNoteCopyWithImpl<$Res, CreditNote>;
  @useResult
  $Res call(
      {String creditNoteId,
      String invoiceId,
      double amount,
      String reason,
      String status,
      String createdAt,
      double gst,
      double totalCredit,
      CreditNoteWorkflow workflow,
      List<AuditEntry> auditTrail,
      String? approvedAt});

  $CreditNoteWorkflowCopyWith<$Res> get workflow;
}

/// @nodoc
class _$CreditNoteCopyWithImpl<$Res, $Val extends CreditNote>
    implements $CreditNoteCopyWith<$Res> {
  _$CreditNoteCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? creditNoteId = null,
    Object? invoiceId = null,
    Object? amount = null,
    Object? reason = null,
    Object? status = null,
    Object? createdAt = null,
    Object? gst = null,
    Object? totalCredit = null,
    Object? workflow = null,
    Object? auditTrail = null,
    Object? approvedAt = freezed,
  }) {
    return _then(_value.copyWith(
      creditNoteId: null == creditNoteId
          ? _value.creditNoteId
          : creditNoteId // ignore: cast_nullable_to_non_nullable
              as String,
      invoiceId: null == invoiceId
          ? _value.invoiceId
          : invoiceId // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      reason: null == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      gst: null == gst
          ? _value.gst
          : gst // ignore: cast_nullable_to_non_nullable
              as double,
      totalCredit: null == totalCredit
          ? _value.totalCredit
          : totalCredit // ignore: cast_nullable_to_non_nullable
              as double,
      workflow: null == workflow
          ? _value.workflow
          : workflow // ignore: cast_nullable_to_non_nullable
              as CreditNoteWorkflow,
      auditTrail: null == auditTrail
          ? _value.auditTrail
          : auditTrail // ignore: cast_nullable_to_non_nullable
              as List<AuditEntry>,
      approvedAt: freezed == approvedAt
          ? _value.approvedAt
          : approvedAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CreditNoteWorkflowCopyWith<$Res> get workflow {
    return $CreditNoteWorkflowCopyWith<$Res>(_value.workflow, (value) {
      return _then(_value.copyWith(workflow: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CreditNoteImplCopyWith<$Res>
    implements $CreditNoteCopyWith<$Res> {
  factory _$$CreditNoteImplCopyWith(
          _$CreditNoteImpl value, $Res Function(_$CreditNoteImpl) then) =
      __$$CreditNoteImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String creditNoteId,
      String invoiceId,
      double amount,
      String reason,
      String status,
      String createdAt,
      double gst,
      double totalCredit,
      CreditNoteWorkflow workflow,
      List<AuditEntry> auditTrail,
      String? approvedAt});

  @override
  $CreditNoteWorkflowCopyWith<$Res> get workflow;
}

/// @nodoc
class __$$CreditNoteImplCopyWithImpl<$Res>
    extends _$CreditNoteCopyWithImpl<$Res, _$CreditNoteImpl>
    implements _$$CreditNoteImplCopyWith<$Res> {
  __$$CreditNoteImplCopyWithImpl(
      _$CreditNoteImpl _value, $Res Function(_$CreditNoteImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? creditNoteId = null,
    Object? invoiceId = null,
    Object? amount = null,
    Object? reason = null,
    Object? status = null,
    Object? createdAt = null,
    Object? gst = null,
    Object? totalCredit = null,
    Object? workflow = null,
    Object? auditTrail = null,
    Object? approvedAt = freezed,
  }) {
    return _then(_$CreditNoteImpl(
      creditNoteId: null == creditNoteId
          ? _value.creditNoteId
          : creditNoteId // ignore: cast_nullable_to_non_nullable
              as String,
      invoiceId: null == invoiceId
          ? _value.invoiceId
          : invoiceId // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      reason: null == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      gst: null == gst
          ? _value.gst
          : gst // ignore: cast_nullable_to_non_nullable
              as double,
      totalCredit: null == totalCredit
          ? _value.totalCredit
          : totalCredit // ignore: cast_nullable_to_non_nullable
              as double,
      workflow: null == workflow
          ? _value.workflow
          : workflow // ignore: cast_nullable_to_non_nullable
              as CreditNoteWorkflow,
      auditTrail: null == auditTrail
          ? _value._auditTrail
          : auditTrail // ignore: cast_nullable_to_non_nullable
              as List<AuditEntry>,
      approvedAt: freezed == approvedAt
          ? _value.approvedAt
          : approvedAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CreditNoteImpl implements _CreditNote {
  const _$CreditNoteImpl(
      {required this.creditNoteId,
      required this.invoiceId,
      required this.amount,
      required this.reason,
      required this.status,
      required this.createdAt,
      required this.gst,
      required this.totalCredit,
      required this.workflow,
      required final List<AuditEntry> auditTrail,
      this.approvedAt})
      : _auditTrail = auditTrail;

  factory _$CreditNoteImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreditNoteImplFromJson(json);

  @override
  final String creditNoteId;
  @override
  final String invoiceId;
  @override
  final double amount;
  @override
  final String reason;
  @override
  final String status;
  @override
  final String createdAt;
  @override
  final double gst;
  @override
  final double totalCredit;
  @override
  final CreditNoteWorkflow workflow;
  final List<AuditEntry> _auditTrail;
  @override
  List<AuditEntry> get auditTrail {
    if (_auditTrail is EqualUnmodifiableListView) return _auditTrail;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_auditTrail);
  }

  @override
  final String? approvedAt;

  @override
  String toString() {
    return 'CreditNote(creditNoteId: $creditNoteId, invoiceId: $invoiceId, amount: $amount, reason: $reason, status: $status, createdAt: $createdAt, gst: $gst, totalCredit: $totalCredit, workflow: $workflow, auditTrail: $auditTrail, approvedAt: $approvedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreditNoteImpl &&
            (identical(other.creditNoteId, creditNoteId) ||
                other.creditNoteId == creditNoteId) &&
            (identical(other.invoiceId, invoiceId) ||
                other.invoiceId == invoiceId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.gst, gst) || other.gst == gst) &&
            (identical(other.totalCredit, totalCredit) ||
                other.totalCredit == totalCredit) &&
            (identical(other.workflow, workflow) ||
                other.workflow == workflow) &&
            const DeepCollectionEquality()
                .equals(other._auditTrail, _auditTrail) &&
            (identical(other.approvedAt, approvedAt) ||
                other.approvedAt == approvedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      creditNoteId,
      invoiceId,
      amount,
      reason,
      status,
      createdAt,
      gst,
      totalCredit,
      workflow,
      const DeepCollectionEquality().hash(_auditTrail),
      approvedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CreditNoteImplCopyWith<_$CreditNoteImpl> get copyWith =>
      __$$CreditNoteImplCopyWithImpl<_$CreditNoteImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreditNoteImplToJson(
      this,
    );
  }
}

abstract class _CreditNote implements CreditNote {
  const factory _CreditNote(
      {required final String creditNoteId,
      required final String invoiceId,
      required final double amount,
      required final String reason,
      required final String status,
      required final String createdAt,
      required final double gst,
      required final double totalCredit,
      required final CreditNoteWorkflow workflow,
      required final List<AuditEntry> auditTrail,
      final String? approvedAt}) = _$CreditNoteImpl;

  factory _CreditNote.fromJson(Map<String, dynamic> json) =
      _$CreditNoteImpl.fromJson;

  @override
  String get creditNoteId;
  @override
  String get invoiceId;
  @override
  double get amount;
  @override
  String get reason;
  @override
  String get status;
  @override
  String get createdAt;
  @override
  double get gst;
  @override
  double get totalCredit;
  @override
  CreditNoteWorkflow get workflow;
  @override
  List<AuditEntry> get auditTrail;
  @override
  String? get approvedAt;
  @override
  @JsonKey(ignore: true)
  _$$CreditNoteImplCopyWith<_$CreditNoteImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CreditNoteWorkflow _$CreditNoteWorkflowFromJson(Map<String, dynamic> json) {
  return _CreditNoteWorkflow.fromJson(json);
}

/// @nodoc
mixin _$CreditNoteWorkflow {
  bool get requiresApproval => throw _privateConstructorUsedError;
  String get approvalLevel => throw _privateConstructorUsedError;
  bool get autoApprove => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CreditNoteWorkflowCopyWith<CreditNoteWorkflow> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreditNoteWorkflowCopyWith<$Res> {
  factory $CreditNoteWorkflowCopyWith(
          CreditNoteWorkflow value, $Res Function(CreditNoteWorkflow) then) =
      _$CreditNoteWorkflowCopyWithImpl<$Res, CreditNoteWorkflow>;
  @useResult
  $Res call({bool requiresApproval, String approvalLevel, bool autoApprove});
}

/// @nodoc
class _$CreditNoteWorkflowCopyWithImpl<$Res, $Val extends CreditNoteWorkflow>
    implements $CreditNoteWorkflowCopyWith<$Res> {
  _$CreditNoteWorkflowCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? requiresApproval = null,
    Object? approvalLevel = null,
    Object? autoApprove = null,
  }) {
    return _then(_value.copyWith(
      requiresApproval: null == requiresApproval
          ? _value.requiresApproval
          : requiresApproval // ignore: cast_nullable_to_non_nullable
              as bool,
      approvalLevel: null == approvalLevel
          ? _value.approvalLevel
          : approvalLevel // ignore: cast_nullable_to_non_nullable
              as String,
      autoApprove: null == autoApprove
          ? _value.autoApprove
          : autoApprove // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreditNoteWorkflowImplCopyWith<$Res>
    implements $CreditNoteWorkflowCopyWith<$Res> {
  factory _$$CreditNoteWorkflowImplCopyWith(_$CreditNoteWorkflowImpl value,
          $Res Function(_$CreditNoteWorkflowImpl) then) =
      __$$CreditNoteWorkflowImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool requiresApproval, String approvalLevel, bool autoApprove});
}

/// @nodoc
class __$$CreditNoteWorkflowImplCopyWithImpl<$Res>
    extends _$CreditNoteWorkflowCopyWithImpl<$Res, _$CreditNoteWorkflowImpl>
    implements _$$CreditNoteWorkflowImplCopyWith<$Res> {
  __$$CreditNoteWorkflowImplCopyWithImpl(_$CreditNoteWorkflowImpl _value,
      $Res Function(_$CreditNoteWorkflowImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? requiresApproval = null,
    Object? approvalLevel = null,
    Object? autoApprove = null,
  }) {
    return _then(_$CreditNoteWorkflowImpl(
      requiresApproval: null == requiresApproval
          ? _value.requiresApproval
          : requiresApproval // ignore: cast_nullable_to_non_nullable
              as bool,
      approvalLevel: null == approvalLevel
          ? _value.approvalLevel
          : approvalLevel // ignore: cast_nullable_to_non_nullable
              as String,
      autoApprove: null == autoApprove
          ? _value.autoApprove
          : autoApprove // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CreditNoteWorkflowImpl implements _CreditNoteWorkflow {
  const _$CreditNoteWorkflowImpl(
      {required this.requiresApproval,
      required this.approvalLevel,
      required this.autoApprove});

  factory _$CreditNoteWorkflowImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreditNoteWorkflowImplFromJson(json);

  @override
  final bool requiresApproval;
  @override
  final String approvalLevel;
  @override
  final bool autoApprove;

  @override
  String toString() {
    return 'CreditNoteWorkflow(requiresApproval: $requiresApproval, approvalLevel: $approvalLevel, autoApprove: $autoApprove)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreditNoteWorkflowImpl &&
            (identical(other.requiresApproval, requiresApproval) ||
                other.requiresApproval == requiresApproval) &&
            (identical(other.approvalLevel, approvalLevel) ||
                other.approvalLevel == approvalLevel) &&
            (identical(other.autoApprove, autoApprove) ||
                other.autoApprove == autoApprove));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, requiresApproval, approvalLevel, autoApprove);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CreditNoteWorkflowImplCopyWith<_$CreditNoteWorkflowImpl> get copyWith =>
      __$$CreditNoteWorkflowImplCopyWithImpl<_$CreditNoteWorkflowImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreditNoteWorkflowImplToJson(
      this,
    );
  }
}

abstract class _CreditNoteWorkflow implements CreditNoteWorkflow {
  const factory _CreditNoteWorkflow(
      {required final bool requiresApproval,
      required final String approvalLevel,
      required final bool autoApprove}) = _$CreditNoteWorkflowImpl;

  factory _CreditNoteWorkflow.fromJson(Map<String, dynamic> json) =
      _$CreditNoteWorkflowImpl.fromJson;

  @override
  bool get requiresApproval;
  @override
  String get approvalLevel;
  @override
  bool get autoApprove;
  @override
  @JsonKey(ignore: true)
  _$$CreditNoteWorkflowImplCopyWith<_$CreditNoteWorkflowImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AuditEntry _$AuditEntryFromJson(Map<String, dynamic> json) {
  return _AuditEntry.fromJson(json);
}

/// @nodoc
mixin _$AuditEntry {
  String get action => throw _privateConstructorUsedError;
  String get timestamp => throw _privateConstructorUsedError;
  String get reason => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AuditEntryCopyWith<AuditEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuditEntryCopyWith<$Res> {
  factory $AuditEntryCopyWith(
          AuditEntry value, $Res Function(AuditEntry) then) =
      _$AuditEntryCopyWithImpl<$Res, AuditEntry>;
  @useResult
  $Res call({String action, String timestamp, String reason});
}

/// @nodoc
class _$AuditEntryCopyWithImpl<$Res, $Val extends AuditEntry>
    implements $AuditEntryCopyWith<$Res> {
  _$AuditEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? action = null,
    Object? timestamp = null,
    Object? reason = null,
  }) {
    return _then(_value.copyWith(
      action: null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as String,
      reason: null == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AuditEntryImplCopyWith<$Res>
    implements $AuditEntryCopyWith<$Res> {
  factory _$$AuditEntryImplCopyWith(
          _$AuditEntryImpl value, $Res Function(_$AuditEntryImpl) then) =
      __$$AuditEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String action, String timestamp, String reason});
}

/// @nodoc
class __$$AuditEntryImplCopyWithImpl<$Res>
    extends _$AuditEntryCopyWithImpl<$Res, _$AuditEntryImpl>
    implements _$$AuditEntryImplCopyWith<$Res> {
  __$$AuditEntryImplCopyWithImpl(
      _$AuditEntryImpl _value, $Res Function(_$AuditEntryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? action = null,
    Object? timestamp = null,
    Object? reason = null,
  }) {
    return _then(_$AuditEntryImpl(
      action: null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
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
class _$AuditEntryImpl implements _AuditEntry {
  const _$AuditEntryImpl(
      {required this.action, required this.timestamp, required this.reason});

  factory _$AuditEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$AuditEntryImplFromJson(json);

  @override
  final String action;
  @override
  final String timestamp;
  @override
  final String reason;

  @override
  String toString() {
    return 'AuditEntry(action: $action, timestamp: $timestamp, reason: $reason)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuditEntryImpl &&
            (identical(other.action, action) || other.action == action) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.reason, reason) || other.reason == reason));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, action, timestamp, reason);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AuditEntryImplCopyWith<_$AuditEntryImpl> get copyWith =>
      __$$AuditEntryImplCopyWithImpl<_$AuditEntryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AuditEntryImplToJson(
      this,
    );
  }
}

abstract class _AuditEntry implements AuditEntry {
  const factory _AuditEntry(
      {required final String action,
      required final String timestamp,
      required final String reason}) = _$AuditEntryImpl;

  factory _AuditEntry.fromJson(Map<String, dynamic> json) =
      _$AuditEntryImpl.fromJson;

  @override
  String get action;
  @override
  String get timestamp;
  @override
  String get reason;
  @override
  @JsonKey(ignore: true)
  _$$AuditEntryImplCopyWith<_$AuditEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CashFlowForecast _$CashFlowForecastFromJson(Map<String, dynamic> json) {
  return _CashFlowForecast.fromJson(json);
}

/// @nodoc
mixin _$CashFlowForecast {
  String get organizationId => throw _privateConstructorUsedError;
  int get horizon => throw _privateConstructorUsedError;
  String get generatedAt => throw _privateConstructorUsedError;
  CashPosition get currentPosition => throw _privateConstructorUsedError;
  List<DailyCashFlow> get dailyForecast => throw _privateConstructorUsedError;
  CashFlowSummary get summary => throw _privateConstructorUsedError;
  List<CashFlowRisk> get risks => throw _privateConstructorUsedError;
  List<String> get recommendations => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CashFlowForecastCopyWith<CashFlowForecast> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CashFlowForecastCopyWith<$Res> {
  factory $CashFlowForecastCopyWith(
          CashFlowForecast value, $Res Function(CashFlowForecast) then) =
      _$CashFlowForecastCopyWithImpl<$Res, CashFlowForecast>;
  @useResult
  $Res call(
      {String organizationId,
      int horizon,
      String generatedAt,
      CashPosition currentPosition,
      List<DailyCashFlow> dailyForecast,
      CashFlowSummary summary,
      List<CashFlowRisk> risks,
      List<String> recommendations});

  $CashPositionCopyWith<$Res> get currentPosition;
  $CashFlowSummaryCopyWith<$Res> get summary;
}

/// @nodoc
class _$CashFlowForecastCopyWithImpl<$Res, $Val extends CashFlowForecast>
    implements $CashFlowForecastCopyWith<$Res> {
  _$CashFlowForecastCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? organizationId = null,
    Object? horizon = null,
    Object? generatedAt = null,
    Object? currentPosition = null,
    Object? dailyForecast = null,
    Object? summary = null,
    Object? risks = null,
    Object? recommendations = null,
  }) {
    return _then(_value.copyWith(
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      horizon: null == horizon
          ? _value.horizon
          : horizon // ignore: cast_nullable_to_non_nullable
              as int,
      generatedAt: null == generatedAt
          ? _value.generatedAt
          : generatedAt // ignore: cast_nullable_to_non_nullable
              as String,
      currentPosition: null == currentPosition
          ? _value.currentPosition
          : currentPosition // ignore: cast_nullable_to_non_nullable
              as CashPosition,
      dailyForecast: null == dailyForecast
          ? _value.dailyForecast
          : dailyForecast // ignore: cast_nullable_to_non_nullable
              as List<DailyCashFlow>,
      summary: null == summary
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as CashFlowSummary,
      risks: null == risks
          ? _value.risks
          : risks // ignore: cast_nullable_to_non_nullable
              as List<CashFlowRisk>,
      recommendations: null == recommendations
          ? _value.recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CashPositionCopyWith<$Res> get currentPosition {
    return $CashPositionCopyWith<$Res>(_value.currentPosition, (value) {
      return _then(_value.copyWith(currentPosition: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CashFlowSummaryCopyWith<$Res> get summary {
    return $CashFlowSummaryCopyWith<$Res>(_value.summary, (value) {
      return _then(_value.copyWith(summary: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CashFlowForecastImplCopyWith<$Res>
    implements $CashFlowForecastCopyWith<$Res> {
  factory _$$CashFlowForecastImplCopyWith(_$CashFlowForecastImpl value,
          $Res Function(_$CashFlowForecastImpl) then) =
      __$$CashFlowForecastImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String organizationId,
      int horizon,
      String generatedAt,
      CashPosition currentPosition,
      List<DailyCashFlow> dailyForecast,
      CashFlowSummary summary,
      List<CashFlowRisk> risks,
      List<String> recommendations});

  @override
  $CashPositionCopyWith<$Res> get currentPosition;
  @override
  $CashFlowSummaryCopyWith<$Res> get summary;
}

/// @nodoc
class __$$CashFlowForecastImplCopyWithImpl<$Res>
    extends _$CashFlowForecastCopyWithImpl<$Res, _$CashFlowForecastImpl>
    implements _$$CashFlowForecastImplCopyWith<$Res> {
  __$$CashFlowForecastImplCopyWithImpl(_$CashFlowForecastImpl _value,
      $Res Function(_$CashFlowForecastImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? organizationId = null,
    Object? horizon = null,
    Object? generatedAt = null,
    Object? currentPosition = null,
    Object? dailyForecast = null,
    Object? summary = null,
    Object? risks = null,
    Object? recommendations = null,
  }) {
    return _then(_$CashFlowForecastImpl(
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      horizon: null == horizon
          ? _value.horizon
          : horizon // ignore: cast_nullable_to_non_nullable
              as int,
      generatedAt: null == generatedAt
          ? _value.generatedAt
          : generatedAt // ignore: cast_nullable_to_non_nullable
              as String,
      currentPosition: null == currentPosition
          ? _value.currentPosition
          : currentPosition // ignore: cast_nullable_to_non_nullable
              as CashPosition,
      dailyForecast: null == dailyForecast
          ? _value._dailyForecast
          : dailyForecast // ignore: cast_nullable_to_non_nullable
              as List<DailyCashFlow>,
      summary: null == summary
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as CashFlowSummary,
      risks: null == risks
          ? _value._risks
          : risks // ignore: cast_nullable_to_non_nullable
              as List<CashFlowRisk>,
      recommendations: null == recommendations
          ? _value._recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CashFlowForecastImpl implements _CashFlowForecast {
  const _$CashFlowForecastImpl(
      {required this.organizationId,
      required this.horizon,
      required this.generatedAt,
      required this.currentPosition,
      required final List<DailyCashFlow> dailyForecast,
      required this.summary,
      required final List<CashFlowRisk> risks,
      required final List<String> recommendations})
      : _dailyForecast = dailyForecast,
        _risks = risks,
        _recommendations = recommendations;

  factory _$CashFlowForecastImpl.fromJson(Map<String, dynamic> json) =>
      _$$CashFlowForecastImplFromJson(json);

  @override
  final String organizationId;
  @override
  final int horizon;
  @override
  final String generatedAt;
  @override
  final CashPosition currentPosition;
  final List<DailyCashFlow> _dailyForecast;
  @override
  List<DailyCashFlow> get dailyForecast {
    if (_dailyForecast is EqualUnmodifiableListView) return _dailyForecast;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_dailyForecast);
  }

  @override
  final CashFlowSummary summary;
  final List<CashFlowRisk> _risks;
  @override
  List<CashFlowRisk> get risks {
    if (_risks is EqualUnmodifiableListView) return _risks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_risks);
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
    return 'CashFlowForecast(organizationId: $organizationId, horizon: $horizon, generatedAt: $generatedAt, currentPosition: $currentPosition, dailyForecast: $dailyForecast, summary: $summary, risks: $risks, recommendations: $recommendations)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CashFlowForecastImpl &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.horizon, horizon) || other.horizon == horizon) &&
            (identical(other.generatedAt, generatedAt) ||
                other.generatedAt == generatedAt) &&
            (identical(other.currentPosition, currentPosition) ||
                other.currentPosition == currentPosition) &&
            const DeepCollectionEquality()
                .equals(other._dailyForecast, _dailyForecast) &&
            (identical(other.summary, summary) || other.summary == summary) &&
            const DeepCollectionEquality().equals(other._risks, _risks) &&
            const DeepCollectionEquality()
                .equals(other._recommendations, _recommendations));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      organizationId,
      horizon,
      generatedAt,
      currentPosition,
      const DeepCollectionEquality().hash(_dailyForecast),
      summary,
      const DeepCollectionEquality().hash(_risks),
      const DeepCollectionEquality().hash(_recommendations));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CashFlowForecastImplCopyWith<_$CashFlowForecastImpl> get copyWith =>
      __$$CashFlowForecastImplCopyWithImpl<_$CashFlowForecastImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CashFlowForecastImplToJson(
      this,
    );
  }
}

abstract class _CashFlowForecast implements CashFlowForecast {
  const factory _CashFlowForecast(
      {required final String organizationId,
      required final int horizon,
      required final String generatedAt,
      required final CashPosition currentPosition,
      required final List<DailyCashFlow> dailyForecast,
      required final CashFlowSummary summary,
      required final List<CashFlowRisk> risks,
      required final List<String> recommendations}) = _$CashFlowForecastImpl;

  factory _CashFlowForecast.fromJson(Map<String, dynamic> json) =
      _$CashFlowForecastImpl.fromJson;

  @override
  String get organizationId;
  @override
  int get horizon;
  @override
  String get generatedAt;
  @override
  CashPosition get currentPosition;
  @override
  List<DailyCashFlow> get dailyForecast;
  @override
  CashFlowSummary get summary;
  @override
  List<CashFlowRisk> get risks;
  @override
  List<String> get recommendations;
  @override
  @JsonKey(ignore: true)
  _$$CashFlowForecastImplCopyWith<_$CashFlowForecastImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CashPosition _$CashPositionFromJson(Map<String, dynamic> json) {
  return _CashPosition.fromJson(json);
}

/// @nodoc
mixin _$CashPosition {
  double get cash => throw _privateConstructorUsedError;
  double get receivables => throw _privateConstructorUsedError;
  double get payables => throw _privateConstructorUsedError;
  double get netPosition => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CashPositionCopyWith<CashPosition> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CashPositionCopyWith<$Res> {
  factory $CashPositionCopyWith(
          CashPosition value, $Res Function(CashPosition) then) =
      _$CashPositionCopyWithImpl<$Res, CashPosition>;
  @useResult
  $Res call(
      {double cash, double receivables, double payables, double netPosition});
}

/// @nodoc
class _$CashPositionCopyWithImpl<$Res, $Val extends CashPosition>
    implements $CashPositionCopyWith<$Res> {
  _$CashPositionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cash = null,
    Object? receivables = null,
    Object? payables = null,
    Object? netPosition = null,
  }) {
    return _then(_value.copyWith(
      cash: null == cash
          ? _value.cash
          : cash // ignore: cast_nullable_to_non_nullable
              as double,
      receivables: null == receivables
          ? _value.receivables
          : receivables // ignore: cast_nullable_to_non_nullable
              as double,
      payables: null == payables
          ? _value.payables
          : payables // ignore: cast_nullable_to_non_nullable
              as double,
      netPosition: null == netPosition
          ? _value.netPosition
          : netPosition // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CashPositionImplCopyWith<$Res>
    implements $CashPositionCopyWith<$Res> {
  factory _$$CashPositionImplCopyWith(
          _$CashPositionImpl value, $Res Function(_$CashPositionImpl) then) =
      __$$CashPositionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double cash, double receivables, double payables, double netPosition});
}

/// @nodoc
class __$$CashPositionImplCopyWithImpl<$Res>
    extends _$CashPositionCopyWithImpl<$Res, _$CashPositionImpl>
    implements _$$CashPositionImplCopyWith<$Res> {
  __$$CashPositionImplCopyWithImpl(
      _$CashPositionImpl _value, $Res Function(_$CashPositionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cash = null,
    Object? receivables = null,
    Object? payables = null,
    Object? netPosition = null,
  }) {
    return _then(_$CashPositionImpl(
      cash: null == cash
          ? _value.cash
          : cash // ignore: cast_nullable_to_non_nullable
              as double,
      receivables: null == receivables
          ? _value.receivables
          : receivables // ignore: cast_nullable_to_non_nullable
              as double,
      payables: null == payables
          ? _value.payables
          : payables // ignore: cast_nullable_to_non_nullable
              as double,
      netPosition: null == netPosition
          ? _value.netPosition
          : netPosition // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CashPositionImpl implements _CashPosition {
  const _$CashPositionImpl(
      {required this.cash,
      required this.receivables,
      required this.payables,
      required this.netPosition});

  factory _$CashPositionImpl.fromJson(Map<String, dynamic> json) =>
      _$$CashPositionImplFromJson(json);

  @override
  final double cash;
  @override
  final double receivables;
  @override
  final double payables;
  @override
  final double netPosition;

  @override
  String toString() {
    return 'CashPosition(cash: $cash, receivables: $receivables, payables: $payables, netPosition: $netPosition)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CashPositionImpl &&
            (identical(other.cash, cash) || other.cash == cash) &&
            (identical(other.receivables, receivables) ||
                other.receivables == receivables) &&
            (identical(other.payables, payables) ||
                other.payables == payables) &&
            (identical(other.netPosition, netPosition) ||
                other.netPosition == netPosition));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, cash, receivables, payables, netPosition);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CashPositionImplCopyWith<_$CashPositionImpl> get copyWith =>
      __$$CashPositionImplCopyWithImpl<_$CashPositionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CashPositionImplToJson(
      this,
    );
  }
}

abstract class _CashPosition implements CashPosition {
  const factory _CashPosition(
      {required final double cash,
      required final double receivables,
      required final double payables,
      required final double netPosition}) = _$CashPositionImpl;

  factory _CashPosition.fromJson(Map<String, dynamic> json) =
      _$CashPositionImpl.fromJson;

  @override
  double get cash;
  @override
  double get receivables;
  @override
  double get payables;
  @override
  double get netPosition;
  @override
  @JsonKey(ignore: true)
  _$$CashPositionImplCopyWith<_$CashPositionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DailyCashFlow _$DailyCashFlowFromJson(Map<String, dynamic> json) {
  return _DailyCashFlow.fromJson(json);
}

/// @nodoc
mixin _$DailyCashFlow {
  String get date => throw _privateConstructorUsedError;
  double get openingBalance => throw _privateConstructorUsedError;
  double get inflows => throw _privateConstructorUsedError;
  double get outflows => throw _privateConstructorUsedError;
  double get netFlow => throw _privateConstructorUsedError;
  double get closingBalance => throw _privateConstructorUsedError;
  double get confidence => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DailyCashFlowCopyWith<DailyCashFlow> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailyCashFlowCopyWith<$Res> {
  factory $DailyCashFlowCopyWith(
          DailyCashFlow value, $Res Function(DailyCashFlow) then) =
      _$DailyCashFlowCopyWithImpl<$Res, DailyCashFlow>;
  @useResult
  $Res call(
      {String date,
      double openingBalance,
      double inflows,
      double outflows,
      double netFlow,
      double closingBalance,
      double confidence});
}

/// @nodoc
class _$DailyCashFlowCopyWithImpl<$Res, $Val extends DailyCashFlow>
    implements $DailyCashFlowCopyWith<$Res> {
  _$DailyCashFlowCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? openingBalance = null,
    Object? inflows = null,
    Object? outflows = null,
    Object? netFlow = null,
    Object? closingBalance = null,
    Object? confidence = null,
  }) {
    return _then(_value.copyWith(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      openingBalance: null == openingBalance
          ? _value.openingBalance
          : openingBalance // ignore: cast_nullable_to_non_nullable
              as double,
      inflows: null == inflows
          ? _value.inflows
          : inflows // ignore: cast_nullable_to_non_nullable
              as double,
      outflows: null == outflows
          ? _value.outflows
          : outflows // ignore: cast_nullable_to_non_nullable
              as double,
      netFlow: null == netFlow
          ? _value.netFlow
          : netFlow // ignore: cast_nullable_to_non_nullable
              as double,
      closingBalance: null == closingBalance
          ? _value.closingBalance
          : closingBalance // ignore: cast_nullable_to_non_nullable
              as double,
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DailyCashFlowImplCopyWith<$Res>
    implements $DailyCashFlowCopyWith<$Res> {
  factory _$$DailyCashFlowImplCopyWith(
          _$DailyCashFlowImpl value, $Res Function(_$DailyCashFlowImpl) then) =
      __$$DailyCashFlowImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String date,
      double openingBalance,
      double inflows,
      double outflows,
      double netFlow,
      double closingBalance,
      double confidence});
}

/// @nodoc
class __$$DailyCashFlowImplCopyWithImpl<$Res>
    extends _$DailyCashFlowCopyWithImpl<$Res, _$DailyCashFlowImpl>
    implements _$$DailyCashFlowImplCopyWith<$Res> {
  __$$DailyCashFlowImplCopyWithImpl(
      _$DailyCashFlowImpl _value, $Res Function(_$DailyCashFlowImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? openingBalance = null,
    Object? inflows = null,
    Object? outflows = null,
    Object? netFlow = null,
    Object? closingBalance = null,
    Object? confidence = null,
  }) {
    return _then(_$DailyCashFlowImpl(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      openingBalance: null == openingBalance
          ? _value.openingBalance
          : openingBalance // ignore: cast_nullable_to_non_nullable
              as double,
      inflows: null == inflows
          ? _value.inflows
          : inflows // ignore: cast_nullable_to_non_nullable
              as double,
      outflows: null == outflows
          ? _value.outflows
          : outflows // ignore: cast_nullable_to_non_nullable
              as double,
      netFlow: null == netFlow
          ? _value.netFlow
          : netFlow // ignore: cast_nullable_to_non_nullable
              as double,
      closingBalance: null == closingBalance
          ? _value.closingBalance
          : closingBalance // ignore: cast_nullable_to_non_nullable
              as double,
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DailyCashFlowImpl implements _DailyCashFlow {
  const _$DailyCashFlowImpl(
      {required this.date,
      required this.openingBalance,
      required this.inflows,
      required this.outflows,
      required this.netFlow,
      required this.closingBalance,
      required this.confidence});

  factory _$DailyCashFlowImpl.fromJson(Map<String, dynamic> json) =>
      _$$DailyCashFlowImplFromJson(json);

  @override
  final String date;
  @override
  final double openingBalance;
  @override
  final double inflows;
  @override
  final double outflows;
  @override
  final double netFlow;
  @override
  final double closingBalance;
  @override
  final double confidence;

  @override
  String toString() {
    return 'DailyCashFlow(date: $date, openingBalance: $openingBalance, inflows: $inflows, outflows: $outflows, netFlow: $netFlow, closingBalance: $closingBalance, confidence: $confidence)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DailyCashFlowImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.openingBalance, openingBalance) ||
                other.openingBalance == openingBalance) &&
            (identical(other.inflows, inflows) || other.inflows == inflows) &&
            (identical(other.outflows, outflows) ||
                other.outflows == outflows) &&
            (identical(other.netFlow, netFlow) || other.netFlow == netFlow) &&
            (identical(other.closingBalance, closingBalance) ||
                other.closingBalance == closingBalance) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, date, openingBalance, inflows,
      outflows, netFlow, closingBalance, confidence);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DailyCashFlowImplCopyWith<_$DailyCashFlowImpl> get copyWith =>
      __$$DailyCashFlowImplCopyWithImpl<_$DailyCashFlowImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DailyCashFlowImplToJson(
      this,
    );
  }
}

abstract class _DailyCashFlow implements DailyCashFlow {
  const factory _DailyCashFlow(
      {required final String date,
      required final double openingBalance,
      required final double inflows,
      required final double outflows,
      required final double netFlow,
      required final double closingBalance,
      required final double confidence}) = _$DailyCashFlowImpl;

  factory _DailyCashFlow.fromJson(Map<String, dynamic> json) =
      _$DailyCashFlowImpl.fromJson;

  @override
  String get date;
  @override
  double get openingBalance;
  @override
  double get inflows;
  @override
  double get outflows;
  @override
  double get netFlow;
  @override
  double get closingBalance;
  @override
  double get confidence;
  @override
  @JsonKey(ignore: true)
  _$$DailyCashFlowImplCopyWith<_$DailyCashFlowImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CashFlowSummary _$CashFlowSummaryFromJson(Map<String, dynamic> json) {
  return _CashFlowSummary.fromJson(json);
}

/// @nodoc
mixin _$CashFlowSummary {
  double get projectedInflows => throw _privateConstructorUsedError;
  double get projectedOutflows => throw _privateConstructorUsedError;
  double get netCashFlow => throw _privateConstructorUsedError;
  double get minimumBalance => throw _privateConstructorUsedError;
  double get maximumBalance => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CashFlowSummaryCopyWith<CashFlowSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CashFlowSummaryCopyWith<$Res> {
  factory $CashFlowSummaryCopyWith(
          CashFlowSummary value, $Res Function(CashFlowSummary) then) =
      _$CashFlowSummaryCopyWithImpl<$Res, CashFlowSummary>;
  @useResult
  $Res call(
      {double projectedInflows,
      double projectedOutflows,
      double netCashFlow,
      double minimumBalance,
      double maximumBalance});
}

/// @nodoc
class _$CashFlowSummaryCopyWithImpl<$Res, $Val extends CashFlowSummary>
    implements $CashFlowSummaryCopyWith<$Res> {
  _$CashFlowSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? projectedInflows = null,
    Object? projectedOutflows = null,
    Object? netCashFlow = null,
    Object? minimumBalance = null,
    Object? maximumBalance = null,
  }) {
    return _then(_value.copyWith(
      projectedInflows: null == projectedInflows
          ? _value.projectedInflows
          : projectedInflows // ignore: cast_nullable_to_non_nullable
              as double,
      projectedOutflows: null == projectedOutflows
          ? _value.projectedOutflows
          : projectedOutflows // ignore: cast_nullable_to_non_nullable
              as double,
      netCashFlow: null == netCashFlow
          ? _value.netCashFlow
          : netCashFlow // ignore: cast_nullable_to_non_nullable
              as double,
      minimumBalance: null == minimumBalance
          ? _value.minimumBalance
          : minimumBalance // ignore: cast_nullable_to_non_nullable
              as double,
      maximumBalance: null == maximumBalance
          ? _value.maximumBalance
          : maximumBalance // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CashFlowSummaryImplCopyWith<$Res>
    implements $CashFlowSummaryCopyWith<$Res> {
  factory _$$CashFlowSummaryImplCopyWith(_$CashFlowSummaryImpl value,
          $Res Function(_$CashFlowSummaryImpl) then) =
      __$$CashFlowSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double projectedInflows,
      double projectedOutflows,
      double netCashFlow,
      double minimumBalance,
      double maximumBalance});
}

/// @nodoc
class __$$CashFlowSummaryImplCopyWithImpl<$Res>
    extends _$CashFlowSummaryCopyWithImpl<$Res, _$CashFlowSummaryImpl>
    implements _$$CashFlowSummaryImplCopyWith<$Res> {
  __$$CashFlowSummaryImplCopyWithImpl(
      _$CashFlowSummaryImpl _value, $Res Function(_$CashFlowSummaryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? projectedInflows = null,
    Object? projectedOutflows = null,
    Object? netCashFlow = null,
    Object? minimumBalance = null,
    Object? maximumBalance = null,
  }) {
    return _then(_$CashFlowSummaryImpl(
      projectedInflows: null == projectedInflows
          ? _value.projectedInflows
          : projectedInflows // ignore: cast_nullable_to_non_nullable
              as double,
      projectedOutflows: null == projectedOutflows
          ? _value.projectedOutflows
          : projectedOutflows // ignore: cast_nullable_to_non_nullable
              as double,
      netCashFlow: null == netCashFlow
          ? _value.netCashFlow
          : netCashFlow // ignore: cast_nullable_to_non_nullable
              as double,
      minimumBalance: null == minimumBalance
          ? _value.minimumBalance
          : minimumBalance // ignore: cast_nullable_to_non_nullable
              as double,
      maximumBalance: null == maximumBalance
          ? _value.maximumBalance
          : maximumBalance // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CashFlowSummaryImpl implements _CashFlowSummary {
  const _$CashFlowSummaryImpl(
      {required this.projectedInflows,
      required this.projectedOutflows,
      required this.netCashFlow,
      required this.minimumBalance,
      required this.maximumBalance});

  factory _$CashFlowSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$CashFlowSummaryImplFromJson(json);

  @override
  final double projectedInflows;
  @override
  final double projectedOutflows;
  @override
  final double netCashFlow;
  @override
  final double minimumBalance;
  @override
  final double maximumBalance;

  @override
  String toString() {
    return 'CashFlowSummary(projectedInflows: $projectedInflows, projectedOutflows: $projectedOutflows, netCashFlow: $netCashFlow, minimumBalance: $minimumBalance, maximumBalance: $maximumBalance)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CashFlowSummaryImpl &&
            (identical(other.projectedInflows, projectedInflows) ||
                other.projectedInflows == projectedInflows) &&
            (identical(other.projectedOutflows, projectedOutflows) ||
                other.projectedOutflows == projectedOutflows) &&
            (identical(other.netCashFlow, netCashFlow) ||
                other.netCashFlow == netCashFlow) &&
            (identical(other.minimumBalance, minimumBalance) ||
                other.minimumBalance == minimumBalance) &&
            (identical(other.maximumBalance, maximumBalance) ||
                other.maximumBalance == maximumBalance));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, projectedInflows,
      projectedOutflows, netCashFlow, minimumBalance, maximumBalance);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CashFlowSummaryImplCopyWith<_$CashFlowSummaryImpl> get copyWith =>
      __$$CashFlowSummaryImplCopyWithImpl<_$CashFlowSummaryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CashFlowSummaryImplToJson(
      this,
    );
  }
}

abstract class _CashFlowSummary implements CashFlowSummary {
  const factory _CashFlowSummary(
      {required final double projectedInflows,
      required final double projectedOutflows,
      required final double netCashFlow,
      required final double minimumBalance,
      required final double maximumBalance}) = _$CashFlowSummaryImpl;

  factory _CashFlowSummary.fromJson(Map<String, dynamic> json) =
      _$CashFlowSummaryImpl.fromJson;

  @override
  double get projectedInflows;
  @override
  double get projectedOutflows;
  @override
  double get netCashFlow;
  @override
  double get minimumBalance;
  @override
  double get maximumBalance;
  @override
  @JsonKey(ignore: true)
  _$$CashFlowSummaryImplCopyWith<_$CashFlowSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CashFlowRisk _$CashFlowRiskFromJson(Map<String, dynamic> json) {
  return _CashFlowRisk.fromJson(json);
}

/// @nodoc
mixin _$CashFlowRisk {
  String get risk => throw _privateConstructorUsedError;
  String get level => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  double get probability => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CashFlowRiskCopyWith<CashFlowRisk> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CashFlowRiskCopyWith<$Res> {
  factory $CashFlowRiskCopyWith(
          CashFlowRisk value, $Res Function(CashFlowRisk) then) =
      _$CashFlowRiskCopyWithImpl<$Res, CashFlowRisk>;
  @useResult
  $Res call(
      {String risk, String level, String description, double probability});
}

/// @nodoc
class _$CashFlowRiskCopyWithImpl<$Res, $Val extends CashFlowRisk>
    implements $CashFlowRiskCopyWith<$Res> {
  _$CashFlowRiskCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? risk = null,
    Object? level = null,
    Object? description = null,
    Object? probability = null,
  }) {
    return _then(_value.copyWith(
      risk: null == risk
          ? _value.risk
          : risk // ignore: cast_nullable_to_non_nullable
              as String,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      probability: null == probability
          ? _value.probability
          : probability // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CashFlowRiskImplCopyWith<$Res>
    implements $CashFlowRiskCopyWith<$Res> {
  factory _$$CashFlowRiskImplCopyWith(
          _$CashFlowRiskImpl value, $Res Function(_$CashFlowRiskImpl) then) =
      __$$CashFlowRiskImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String risk, String level, String description, double probability});
}

/// @nodoc
class __$$CashFlowRiskImplCopyWithImpl<$Res>
    extends _$CashFlowRiskCopyWithImpl<$Res, _$CashFlowRiskImpl>
    implements _$$CashFlowRiskImplCopyWith<$Res> {
  __$$CashFlowRiskImplCopyWithImpl(
      _$CashFlowRiskImpl _value, $Res Function(_$CashFlowRiskImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? risk = null,
    Object? level = null,
    Object? description = null,
    Object? probability = null,
  }) {
    return _then(_$CashFlowRiskImpl(
      risk: null == risk
          ? _value.risk
          : risk // ignore: cast_nullable_to_non_nullable
              as String,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      probability: null == probability
          ? _value.probability
          : probability // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CashFlowRiskImpl implements _CashFlowRisk {
  const _$CashFlowRiskImpl(
      {required this.risk,
      required this.level,
      required this.description,
      required this.probability});

  factory _$CashFlowRiskImpl.fromJson(Map<String, dynamic> json) =>
      _$$CashFlowRiskImplFromJson(json);

  @override
  final String risk;
  @override
  final String level;
  @override
  final String description;
  @override
  final double probability;

  @override
  String toString() {
    return 'CashFlowRisk(risk: $risk, level: $level, description: $description, probability: $probability)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CashFlowRiskImpl &&
            (identical(other.risk, risk) || other.risk == risk) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.probability, probability) ||
                other.probability == probability));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, risk, level, description, probability);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CashFlowRiskImplCopyWith<_$CashFlowRiskImpl> get copyWith =>
      __$$CashFlowRiskImplCopyWithImpl<_$CashFlowRiskImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CashFlowRiskImplToJson(
      this,
    );
  }
}

abstract class _CashFlowRisk implements CashFlowRisk {
  const factory _CashFlowRisk(
      {required final String risk,
      required final String level,
      required final String description,
      required final double probability}) = _$CashFlowRiskImpl;

  factory _CashFlowRisk.fromJson(Map<String, dynamic> json) =
      _$CashFlowRiskImpl.fromJson;

  @override
  String get risk;
  @override
  String get level;
  @override
  String get description;
  @override
  double get probability;
  @override
  @JsonKey(ignore: true)
  _$$CashFlowRiskImplCopyWith<_$CashFlowRiskImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PaymentPrediction _$PaymentPredictionFromJson(Map<String, dynamic> json) {
  return _PaymentPrediction.fromJson(json);
}

/// @nodoc
mixin _$PaymentPrediction {
  String get invoiceId => throw _privateConstructorUsedError;
  String get clientId => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  String get dueDate => throw _privateConstructorUsedError;
  double get paymentProbability => throw _privateConstructorUsedError;
  String get expectedPaymentDate => throw _privateConstructorUsedError;
  int get expectedDaysLate => throw _privateConstructorUsedError;
  String get latePaymentRisk => throw _privateConstructorUsedError;
  double get badDebtProbability => throw _privateConstructorUsedError;
  List<String> get actions => throw _privateConstructorUsedError;

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
      String clientId,
      double amount,
      String dueDate,
      double paymentProbability,
      String expectedPaymentDate,
      int expectedDaysLate,
      String latePaymentRisk,
      double badDebtProbability,
      List<String> actions});
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
    Object? clientId = null,
    Object? amount = null,
    Object? dueDate = null,
    Object? paymentProbability = null,
    Object? expectedPaymentDate = null,
    Object? expectedDaysLate = null,
    Object? latePaymentRisk = null,
    Object? badDebtProbability = null,
    Object? actions = null,
  }) {
    return _then(_value.copyWith(
      invoiceId: null == invoiceId
          ? _value.invoiceId
          : invoiceId // ignore: cast_nullable_to_non_nullable
              as String,
      clientId: null == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      dueDate: null == dueDate
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as String,
      paymentProbability: null == paymentProbability
          ? _value.paymentProbability
          : paymentProbability // ignore: cast_nullable_to_non_nullable
              as double,
      expectedPaymentDate: null == expectedPaymentDate
          ? _value.expectedPaymentDate
          : expectedPaymentDate // ignore: cast_nullable_to_non_nullable
              as String,
      expectedDaysLate: null == expectedDaysLate
          ? _value.expectedDaysLate
          : expectedDaysLate // ignore: cast_nullable_to_non_nullable
              as int,
      latePaymentRisk: null == latePaymentRisk
          ? _value.latePaymentRisk
          : latePaymentRisk // ignore: cast_nullable_to_non_nullable
              as String,
      badDebtProbability: null == badDebtProbability
          ? _value.badDebtProbability
          : badDebtProbability // ignore: cast_nullable_to_non_nullable
              as double,
      actions: null == actions
          ? _value.actions
          : actions // ignore: cast_nullable_to_non_nullable
              as List<String>,
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
      String clientId,
      double amount,
      String dueDate,
      double paymentProbability,
      String expectedPaymentDate,
      int expectedDaysLate,
      String latePaymentRisk,
      double badDebtProbability,
      List<String> actions});
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
    Object? clientId = null,
    Object? amount = null,
    Object? dueDate = null,
    Object? paymentProbability = null,
    Object? expectedPaymentDate = null,
    Object? expectedDaysLate = null,
    Object? latePaymentRisk = null,
    Object? badDebtProbability = null,
    Object? actions = null,
  }) {
    return _then(_$PaymentPredictionImpl(
      invoiceId: null == invoiceId
          ? _value.invoiceId
          : invoiceId // ignore: cast_nullable_to_non_nullable
              as String,
      clientId: null == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      dueDate: null == dueDate
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as String,
      paymentProbability: null == paymentProbability
          ? _value.paymentProbability
          : paymentProbability // ignore: cast_nullable_to_non_nullable
              as double,
      expectedPaymentDate: null == expectedPaymentDate
          ? _value.expectedPaymentDate
          : expectedPaymentDate // ignore: cast_nullable_to_non_nullable
              as String,
      expectedDaysLate: null == expectedDaysLate
          ? _value.expectedDaysLate
          : expectedDaysLate // ignore: cast_nullable_to_non_nullable
              as int,
      latePaymentRisk: null == latePaymentRisk
          ? _value.latePaymentRisk
          : latePaymentRisk // ignore: cast_nullable_to_non_nullable
              as String,
      badDebtProbability: null == badDebtProbability
          ? _value.badDebtProbability
          : badDebtProbability // ignore: cast_nullable_to_non_nullable
              as double,
      actions: null == actions
          ? _value._actions
          : actions // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PaymentPredictionImpl implements _PaymentPrediction {
  const _$PaymentPredictionImpl(
      {required this.invoiceId,
      required this.clientId,
      required this.amount,
      required this.dueDate,
      required this.paymentProbability,
      required this.expectedPaymentDate,
      required this.expectedDaysLate,
      required this.latePaymentRisk,
      required this.badDebtProbability,
      required final List<String> actions})
      : _actions = actions;

  factory _$PaymentPredictionImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaymentPredictionImplFromJson(json);

  @override
  final String invoiceId;
  @override
  final String clientId;
  @override
  final double amount;
  @override
  final String dueDate;
  @override
  final double paymentProbability;
  @override
  final String expectedPaymentDate;
  @override
  final int expectedDaysLate;
  @override
  final String latePaymentRisk;
  @override
  final double badDebtProbability;
  final List<String> _actions;
  @override
  List<String> get actions {
    if (_actions is EqualUnmodifiableListView) return _actions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_actions);
  }

  @override
  String toString() {
    return 'PaymentPrediction(invoiceId: $invoiceId, clientId: $clientId, amount: $amount, dueDate: $dueDate, paymentProbability: $paymentProbability, expectedPaymentDate: $expectedPaymentDate, expectedDaysLate: $expectedDaysLate, latePaymentRisk: $latePaymentRisk, badDebtProbability: $badDebtProbability, actions: $actions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentPredictionImpl &&
            (identical(other.invoiceId, invoiceId) ||
                other.invoiceId == invoiceId) &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.dueDate, dueDate) || other.dueDate == dueDate) &&
            (identical(other.paymentProbability, paymentProbability) ||
                other.paymentProbability == paymentProbability) &&
            (identical(other.expectedPaymentDate, expectedPaymentDate) ||
                other.expectedPaymentDate == expectedPaymentDate) &&
            (identical(other.expectedDaysLate, expectedDaysLate) ||
                other.expectedDaysLate == expectedDaysLate) &&
            (identical(other.latePaymentRisk, latePaymentRisk) ||
                other.latePaymentRisk == latePaymentRisk) &&
            (identical(other.badDebtProbability, badDebtProbability) ||
                other.badDebtProbability == badDebtProbability) &&
            const DeepCollectionEquality().equals(other._actions, _actions));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      invoiceId,
      clientId,
      amount,
      dueDate,
      paymentProbability,
      expectedPaymentDate,
      expectedDaysLate,
      latePaymentRisk,
      badDebtProbability,
      const DeepCollectionEquality().hash(_actions));

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
      required final String clientId,
      required final double amount,
      required final String dueDate,
      required final double paymentProbability,
      required final String expectedPaymentDate,
      required final int expectedDaysLate,
      required final String latePaymentRisk,
      required final double badDebtProbability,
      required final List<String> actions}) = _$PaymentPredictionImpl;

  factory _PaymentPrediction.fromJson(Map<String, dynamic> json) =
      _$PaymentPredictionImpl.fromJson;

  @override
  String get invoiceId;
  @override
  String get clientId;
  @override
  double get amount;
  @override
  String get dueDate;
  @override
  double get paymentProbability;
  @override
  String get expectedPaymentDate;
  @override
  int get expectedDaysLate;
  @override
  String get latePaymentRisk;
  @override
  double get badDebtProbability;
  @override
  List<String> get actions;
  @override
  @JsonKey(ignore: true)
  _$$PaymentPredictionImplCopyWith<_$PaymentPredictionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FinancialDashboard _$FinancialDashboardFromJson(Map<String, dynamic> json) {
  return _FinancialDashboard.fromJson(json);
}

/// @nodoc
mixin _$FinancialDashboard {
  String get organizationId => throw _privateConstructorUsedError;
  String get period => throw _privateConstructorUsedError;
  String get generatedAt => throw _privateConstructorUsedError;
  Map<String, KPI> get kpis => throw _privateConstructorUsedError;
  List<RevenueByService> get revenueByService =>
      throw _privateConstructorUsedError;
  List<ClientProfitability> get profitabilityByClient =>
      throw _privateConstructorUsedError;
  CostAnalysis get costAnalysis => throw _privateConstructorUsedError;
  List<TrendData> get trends => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FinancialDashboardCopyWith<FinancialDashboard> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FinancialDashboardCopyWith<$Res> {
  factory $FinancialDashboardCopyWith(
          FinancialDashboard value, $Res Function(FinancialDashboard) then) =
      _$FinancialDashboardCopyWithImpl<$Res, FinancialDashboard>;
  @useResult
  $Res call(
      {String organizationId,
      String period,
      String generatedAt,
      Map<String, KPI> kpis,
      List<RevenueByService> revenueByService,
      List<ClientProfitability> profitabilityByClient,
      CostAnalysis costAnalysis,
      List<TrendData> trends});

  $CostAnalysisCopyWith<$Res> get costAnalysis;
}

/// @nodoc
class _$FinancialDashboardCopyWithImpl<$Res, $Val extends FinancialDashboard>
    implements $FinancialDashboardCopyWith<$Res> {
  _$FinancialDashboardCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? organizationId = null,
    Object? period = null,
    Object? generatedAt = null,
    Object? kpis = null,
    Object? revenueByService = null,
    Object? profitabilityByClient = null,
    Object? costAnalysis = null,
    Object? trends = null,
  }) {
    return _then(_value.copyWith(
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      period: null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as String,
      generatedAt: null == generatedAt
          ? _value.generatedAt
          : generatedAt // ignore: cast_nullable_to_non_nullable
              as String,
      kpis: null == kpis
          ? _value.kpis
          : kpis // ignore: cast_nullable_to_non_nullable
              as Map<String, KPI>,
      revenueByService: null == revenueByService
          ? _value.revenueByService
          : revenueByService // ignore: cast_nullable_to_non_nullable
              as List<RevenueByService>,
      profitabilityByClient: null == profitabilityByClient
          ? _value.profitabilityByClient
          : profitabilityByClient // ignore: cast_nullable_to_non_nullable
              as List<ClientProfitability>,
      costAnalysis: null == costAnalysis
          ? _value.costAnalysis
          : costAnalysis // ignore: cast_nullable_to_non_nullable
              as CostAnalysis,
      trends: null == trends
          ? _value.trends
          : trends // ignore: cast_nullable_to_non_nullable
              as List<TrendData>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CostAnalysisCopyWith<$Res> get costAnalysis {
    return $CostAnalysisCopyWith<$Res>(_value.costAnalysis, (value) {
      return _then(_value.copyWith(costAnalysis: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$FinancialDashboardImplCopyWith<$Res>
    implements $FinancialDashboardCopyWith<$Res> {
  factory _$$FinancialDashboardImplCopyWith(_$FinancialDashboardImpl value,
          $Res Function(_$FinancialDashboardImpl) then) =
      __$$FinancialDashboardImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String organizationId,
      String period,
      String generatedAt,
      Map<String, KPI> kpis,
      List<RevenueByService> revenueByService,
      List<ClientProfitability> profitabilityByClient,
      CostAnalysis costAnalysis,
      List<TrendData> trends});

  @override
  $CostAnalysisCopyWith<$Res> get costAnalysis;
}

/// @nodoc
class __$$FinancialDashboardImplCopyWithImpl<$Res>
    extends _$FinancialDashboardCopyWithImpl<$Res, _$FinancialDashboardImpl>
    implements _$$FinancialDashboardImplCopyWith<$Res> {
  __$$FinancialDashboardImplCopyWithImpl(_$FinancialDashboardImpl _value,
      $Res Function(_$FinancialDashboardImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? organizationId = null,
    Object? period = null,
    Object? generatedAt = null,
    Object? kpis = null,
    Object? revenueByService = null,
    Object? profitabilityByClient = null,
    Object? costAnalysis = null,
    Object? trends = null,
  }) {
    return _then(_$FinancialDashboardImpl(
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      period: null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as String,
      generatedAt: null == generatedAt
          ? _value.generatedAt
          : generatedAt // ignore: cast_nullable_to_non_nullable
              as String,
      kpis: null == kpis
          ? _value._kpis
          : kpis // ignore: cast_nullable_to_non_nullable
              as Map<String, KPI>,
      revenueByService: null == revenueByService
          ? _value._revenueByService
          : revenueByService // ignore: cast_nullable_to_non_nullable
              as List<RevenueByService>,
      profitabilityByClient: null == profitabilityByClient
          ? _value._profitabilityByClient
          : profitabilityByClient // ignore: cast_nullable_to_non_nullable
              as List<ClientProfitability>,
      costAnalysis: null == costAnalysis
          ? _value.costAnalysis
          : costAnalysis // ignore: cast_nullable_to_non_nullable
              as CostAnalysis,
      trends: null == trends
          ? _value._trends
          : trends // ignore: cast_nullable_to_non_nullable
              as List<TrendData>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FinancialDashboardImpl implements _FinancialDashboard {
  const _$FinancialDashboardImpl(
      {required this.organizationId,
      required this.period,
      required this.generatedAt,
      required final Map<String, KPI> kpis,
      required final List<RevenueByService> revenueByService,
      required final List<ClientProfitability> profitabilityByClient,
      required this.costAnalysis,
      required final List<TrendData> trends})
      : _kpis = kpis,
        _revenueByService = revenueByService,
        _profitabilityByClient = profitabilityByClient,
        _trends = trends;

  factory _$FinancialDashboardImpl.fromJson(Map<String, dynamic> json) =>
      _$$FinancialDashboardImplFromJson(json);

  @override
  final String organizationId;
  @override
  final String period;
  @override
  final String generatedAt;
  final Map<String, KPI> _kpis;
  @override
  Map<String, KPI> get kpis {
    if (_kpis is EqualUnmodifiableMapView) return _kpis;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_kpis);
  }

  final List<RevenueByService> _revenueByService;
  @override
  List<RevenueByService> get revenueByService {
    if (_revenueByService is EqualUnmodifiableListView)
      return _revenueByService;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_revenueByService);
  }

  final List<ClientProfitability> _profitabilityByClient;
  @override
  List<ClientProfitability> get profitabilityByClient {
    if (_profitabilityByClient is EqualUnmodifiableListView)
      return _profitabilityByClient;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_profitabilityByClient);
  }

  @override
  final CostAnalysis costAnalysis;
  final List<TrendData> _trends;
  @override
  List<TrendData> get trends {
    if (_trends is EqualUnmodifiableListView) return _trends;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_trends);
  }

  @override
  String toString() {
    return 'FinancialDashboard(organizationId: $organizationId, period: $period, generatedAt: $generatedAt, kpis: $kpis, revenueByService: $revenueByService, profitabilityByClient: $profitabilityByClient, costAnalysis: $costAnalysis, trends: $trends)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FinancialDashboardImpl &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.period, period) || other.period == period) &&
            (identical(other.generatedAt, generatedAt) ||
                other.generatedAt == generatedAt) &&
            const DeepCollectionEquality().equals(other._kpis, _kpis) &&
            const DeepCollectionEquality()
                .equals(other._revenueByService, _revenueByService) &&
            const DeepCollectionEquality()
                .equals(other._profitabilityByClient, _profitabilityByClient) &&
            (identical(other.costAnalysis, costAnalysis) ||
                other.costAnalysis == costAnalysis) &&
            const DeepCollectionEquality().equals(other._trends, _trends));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      organizationId,
      period,
      generatedAt,
      const DeepCollectionEquality().hash(_kpis),
      const DeepCollectionEquality().hash(_revenueByService),
      const DeepCollectionEquality().hash(_profitabilityByClient),
      costAnalysis,
      const DeepCollectionEquality().hash(_trends));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FinancialDashboardImplCopyWith<_$FinancialDashboardImpl> get copyWith =>
      __$$FinancialDashboardImplCopyWithImpl<_$FinancialDashboardImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FinancialDashboardImplToJson(
      this,
    );
  }
}

abstract class _FinancialDashboard implements FinancialDashboard {
  const factory _FinancialDashboard(
      {required final String organizationId,
      required final String period,
      required final String generatedAt,
      required final Map<String, KPI> kpis,
      required final List<RevenueByService> revenueByService,
      required final List<ClientProfitability> profitabilityByClient,
      required final CostAnalysis costAnalysis,
      required final List<TrendData> trends}) = _$FinancialDashboardImpl;

  factory _FinancialDashboard.fromJson(Map<String, dynamic> json) =
      _$FinancialDashboardImpl.fromJson;

  @override
  String get organizationId;
  @override
  String get period;
  @override
  String get generatedAt;
  @override
  Map<String, KPI> get kpis;
  @override
  List<RevenueByService> get revenueByService;
  @override
  List<ClientProfitability> get profitabilityByClient;
  @override
  CostAnalysis get costAnalysis;
  @override
  List<TrendData> get trends;
  @override
  @JsonKey(ignore: true)
  _$$FinancialDashboardImplCopyWith<_$FinancialDashboardImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

KPI _$KPIFromJson(Map<String, dynamic> json) {
  return _KPI.fromJson(json);
}

/// @nodoc
mixin _$KPI {
  double get value => throw _privateConstructorUsedError;
  double get change => throw _privateConstructorUsedError;
  String get trend => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $KPICopyWith<KPI> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KPICopyWith<$Res> {
  factory $KPICopyWith(KPI value, $Res Function(KPI) then) =
      _$KPICopyWithImpl<$Res, KPI>;
  @useResult
  $Res call({double value, double change, String trend});
}

/// @nodoc
class _$KPICopyWithImpl<$Res, $Val extends KPI> implements $KPICopyWith<$Res> {
  _$KPICopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
    Object? change = null,
    Object? trend = null,
  }) {
    return _then(_value.copyWith(
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      change: null == change
          ? _value.change
          : change // ignore: cast_nullable_to_non_nullable
              as double,
      trend: null == trend
          ? _value.trend
          : trend // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$KPIImplCopyWith<$Res> implements $KPICopyWith<$Res> {
  factory _$$KPIImplCopyWith(_$KPIImpl value, $Res Function(_$KPIImpl) then) =
      __$$KPIImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double value, double change, String trend});
}

/// @nodoc
class __$$KPIImplCopyWithImpl<$Res> extends _$KPICopyWithImpl<$Res, _$KPIImpl>
    implements _$$KPIImplCopyWith<$Res> {
  __$$KPIImplCopyWithImpl(_$KPIImpl _value, $Res Function(_$KPIImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
    Object? change = null,
    Object? trend = null,
  }) {
    return _then(_$KPIImpl(
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      change: null == change
          ? _value.change
          : change // ignore: cast_nullable_to_non_nullable
              as double,
      trend: null == trend
          ? _value.trend
          : trend // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$KPIImpl implements _KPI {
  const _$KPIImpl(
      {required this.value, required this.change, required this.trend});

  factory _$KPIImpl.fromJson(Map<String, dynamic> json) =>
      _$$KPIImplFromJson(json);

  @override
  final double value;
  @override
  final double change;
  @override
  final String trend;

  @override
  String toString() {
    return 'KPI(value: $value, change: $change, trend: $trend)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KPIImpl &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.change, change) || other.change == change) &&
            (identical(other.trend, trend) || other.trend == trend));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, value, change, trend);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$KPIImplCopyWith<_$KPIImpl> get copyWith =>
      __$$KPIImplCopyWithImpl<_$KPIImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$KPIImplToJson(
      this,
    );
  }
}

abstract class _KPI implements KPI {
  const factory _KPI(
      {required final double value,
      required final double change,
      required final String trend}) = _$KPIImpl;

  factory _KPI.fromJson(Map<String, dynamic> json) = _$KPIImpl.fromJson;

  @override
  double get value;
  @override
  double get change;
  @override
  String get trend;
  @override
  @JsonKey(ignore: true)
  _$$KPIImplCopyWith<_$KPIImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RevenueByService _$RevenueByServiceFromJson(Map<String, dynamic> json) {
  return _RevenueByService.fromJson(json);
}

/// @nodoc
mixin _$RevenueByService {
  String get service => throw _privateConstructorUsedError;
  double get revenue => throw _privateConstructorUsedError;
  double get percentage => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RevenueByServiceCopyWith<RevenueByService> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RevenueByServiceCopyWith<$Res> {
  factory $RevenueByServiceCopyWith(
          RevenueByService value, $Res Function(RevenueByService) then) =
      _$RevenueByServiceCopyWithImpl<$Res, RevenueByService>;
  @useResult
  $Res call({String service, double revenue, double percentage});
}

/// @nodoc
class _$RevenueByServiceCopyWithImpl<$Res, $Val extends RevenueByService>
    implements $RevenueByServiceCopyWith<$Res> {
  _$RevenueByServiceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? service = null,
    Object? revenue = null,
    Object? percentage = null,
  }) {
    return _then(_value.copyWith(
      service: null == service
          ? _value.service
          : service // ignore: cast_nullable_to_non_nullable
              as String,
      revenue: null == revenue
          ? _value.revenue
          : revenue // ignore: cast_nullable_to_non_nullable
              as double,
      percentage: null == percentage
          ? _value.percentage
          : percentage // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RevenueByServiceImplCopyWith<$Res>
    implements $RevenueByServiceCopyWith<$Res> {
  factory _$$RevenueByServiceImplCopyWith(_$RevenueByServiceImpl value,
          $Res Function(_$RevenueByServiceImpl) then) =
      __$$RevenueByServiceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String service, double revenue, double percentage});
}

/// @nodoc
class __$$RevenueByServiceImplCopyWithImpl<$Res>
    extends _$RevenueByServiceCopyWithImpl<$Res, _$RevenueByServiceImpl>
    implements _$$RevenueByServiceImplCopyWith<$Res> {
  __$$RevenueByServiceImplCopyWithImpl(_$RevenueByServiceImpl _value,
      $Res Function(_$RevenueByServiceImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? service = null,
    Object? revenue = null,
    Object? percentage = null,
  }) {
    return _then(_$RevenueByServiceImpl(
      service: null == service
          ? _value.service
          : service // ignore: cast_nullable_to_non_nullable
              as String,
      revenue: null == revenue
          ? _value.revenue
          : revenue // ignore: cast_nullable_to_non_nullable
              as double,
      percentage: null == percentage
          ? _value.percentage
          : percentage // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RevenueByServiceImpl implements _RevenueByService {
  const _$RevenueByServiceImpl(
      {required this.service, required this.revenue, required this.percentage});

  factory _$RevenueByServiceImpl.fromJson(Map<String, dynamic> json) =>
      _$$RevenueByServiceImplFromJson(json);

  @override
  final String service;
  @override
  final double revenue;
  @override
  final double percentage;

  @override
  String toString() {
    return 'RevenueByService(service: $service, revenue: $revenue, percentage: $percentage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RevenueByServiceImpl &&
            (identical(other.service, service) || other.service == service) &&
            (identical(other.revenue, revenue) || other.revenue == revenue) &&
            (identical(other.percentage, percentage) ||
                other.percentage == percentage));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, service, revenue, percentage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RevenueByServiceImplCopyWith<_$RevenueByServiceImpl> get copyWith =>
      __$$RevenueByServiceImplCopyWithImpl<_$RevenueByServiceImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RevenueByServiceImplToJson(
      this,
    );
  }
}

abstract class _RevenueByService implements RevenueByService {
  const factory _RevenueByService(
      {required final String service,
      required final double revenue,
      required final double percentage}) = _$RevenueByServiceImpl;

  factory _RevenueByService.fromJson(Map<String, dynamic> json) =
      _$RevenueByServiceImpl.fromJson;

  @override
  String get service;
  @override
  double get revenue;
  @override
  double get percentage;
  @override
  @JsonKey(ignore: true)
  _$$RevenueByServiceImplCopyWith<_$RevenueByServiceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ClientProfitability _$ClientProfitabilityFromJson(Map<String, dynamic> json) {
  return _ClientProfitability.fromJson(json);
}

/// @nodoc
mixin _$ClientProfitability {
  String get clientId => throw _privateConstructorUsedError;
  double get revenue => throw _privateConstructorUsedError;
  double get cost => throw _privateConstructorUsedError;
  double get profit => throw _privateConstructorUsedError;
  double get margin => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ClientProfitabilityCopyWith<ClientProfitability> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClientProfitabilityCopyWith<$Res> {
  factory $ClientProfitabilityCopyWith(
          ClientProfitability value, $Res Function(ClientProfitability) then) =
      _$ClientProfitabilityCopyWithImpl<$Res, ClientProfitability>;
  @useResult
  $Res call(
      {String clientId,
      double revenue,
      double cost,
      double profit,
      double margin});
}

/// @nodoc
class _$ClientProfitabilityCopyWithImpl<$Res, $Val extends ClientProfitability>
    implements $ClientProfitabilityCopyWith<$Res> {
  _$ClientProfitabilityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clientId = null,
    Object? revenue = null,
    Object? cost = null,
    Object? profit = null,
    Object? margin = null,
  }) {
    return _then(_value.copyWith(
      clientId: null == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ClientProfitabilityImplCopyWith<$Res>
    implements $ClientProfitabilityCopyWith<$Res> {
  factory _$$ClientProfitabilityImplCopyWith(_$ClientProfitabilityImpl value,
          $Res Function(_$ClientProfitabilityImpl) then) =
      __$$ClientProfitabilityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String clientId,
      double revenue,
      double cost,
      double profit,
      double margin});
}

/// @nodoc
class __$$ClientProfitabilityImplCopyWithImpl<$Res>
    extends _$ClientProfitabilityCopyWithImpl<$Res, _$ClientProfitabilityImpl>
    implements _$$ClientProfitabilityImplCopyWith<$Res> {
  __$$ClientProfitabilityImplCopyWithImpl(_$ClientProfitabilityImpl _value,
      $Res Function(_$ClientProfitabilityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clientId = null,
    Object? revenue = null,
    Object? cost = null,
    Object? profit = null,
    Object? margin = null,
  }) {
    return _then(_$ClientProfitabilityImpl(
      clientId: null == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ClientProfitabilityImpl implements _ClientProfitability {
  const _$ClientProfitabilityImpl(
      {required this.clientId,
      required this.revenue,
      required this.cost,
      required this.profit,
      required this.margin});

  factory _$ClientProfitabilityImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClientProfitabilityImplFromJson(json);

  @override
  final String clientId;
  @override
  final double revenue;
  @override
  final double cost;
  @override
  final double profit;
  @override
  final double margin;

  @override
  String toString() {
    return 'ClientProfitability(clientId: $clientId, revenue: $revenue, cost: $cost, profit: $profit, margin: $margin)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClientProfitabilityImpl &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.revenue, revenue) || other.revenue == revenue) &&
            (identical(other.cost, cost) || other.cost == cost) &&
            (identical(other.profit, profit) || other.profit == profit) &&
            (identical(other.margin, margin) || other.margin == margin));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, clientId, revenue, cost, profit, margin);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ClientProfitabilityImplCopyWith<_$ClientProfitabilityImpl> get copyWith =>
      __$$ClientProfitabilityImplCopyWithImpl<_$ClientProfitabilityImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClientProfitabilityImplToJson(
      this,
    );
  }
}

abstract class _ClientProfitability implements ClientProfitability {
  const factory _ClientProfitability(
      {required final String clientId,
      required final double revenue,
      required final double cost,
      required final double profit,
      required final double margin}) = _$ClientProfitabilityImpl;

  factory _ClientProfitability.fromJson(Map<String, dynamic> json) =
      _$ClientProfitabilityImpl.fromJson;

  @override
  String get clientId;
  @override
  double get revenue;
  @override
  double get cost;
  @override
  double get profit;
  @override
  double get margin;
  @override
  @JsonKey(ignore: true)
  _$$ClientProfitabilityImplCopyWith<_$ClientProfitabilityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CostAnalysis _$CostAnalysisFromJson(Map<String, dynamic> json) {
  return _CostAnalysis.fromJson(json);
}

/// @nodoc
mixin _$CostAnalysis {
  CostCategory get labor => throw _privateConstructorUsedError;
  CostCategory get overhead => throw _privateConstructorUsedError;
  CostCategory get materials => throw _privateConstructorUsedError;
  CostCategory get other => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CostAnalysisCopyWith<CostAnalysis> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CostAnalysisCopyWith<$Res> {
  factory $CostAnalysisCopyWith(
          CostAnalysis value, $Res Function(CostAnalysis) then) =
      _$CostAnalysisCopyWithImpl<$Res, CostAnalysis>;
  @useResult
  $Res call(
      {CostCategory labor,
      CostCategory overhead,
      CostCategory materials,
      CostCategory other});

  $CostCategoryCopyWith<$Res> get labor;
  $CostCategoryCopyWith<$Res> get overhead;
  $CostCategoryCopyWith<$Res> get materials;
  $CostCategoryCopyWith<$Res> get other;
}

/// @nodoc
class _$CostAnalysisCopyWithImpl<$Res, $Val extends CostAnalysis>
    implements $CostAnalysisCopyWith<$Res> {
  _$CostAnalysisCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? labor = null,
    Object? overhead = null,
    Object? materials = null,
    Object? other = null,
  }) {
    return _then(_value.copyWith(
      labor: null == labor
          ? _value.labor
          : labor // ignore: cast_nullable_to_non_nullable
              as CostCategory,
      overhead: null == overhead
          ? _value.overhead
          : overhead // ignore: cast_nullable_to_non_nullable
              as CostCategory,
      materials: null == materials
          ? _value.materials
          : materials // ignore: cast_nullable_to_non_nullable
              as CostCategory,
      other: null == other
          ? _value.other
          : other // ignore: cast_nullable_to_non_nullable
              as CostCategory,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CostCategoryCopyWith<$Res> get labor {
    return $CostCategoryCopyWith<$Res>(_value.labor, (value) {
      return _then(_value.copyWith(labor: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CostCategoryCopyWith<$Res> get overhead {
    return $CostCategoryCopyWith<$Res>(_value.overhead, (value) {
      return _then(_value.copyWith(overhead: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CostCategoryCopyWith<$Res> get materials {
    return $CostCategoryCopyWith<$Res>(_value.materials, (value) {
      return _then(_value.copyWith(materials: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CostCategoryCopyWith<$Res> get other {
    return $CostCategoryCopyWith<$Res>(_value.other, (value) {
      return _then(_value.copyWith(other: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CostAnalysisImplCopyWith<$Res>
    implements $CostAnalysisCopyWith<$Res> {
  factory _$$CostAnalysisImplCopyWith(
          _$CostAnalysisImpl value, $Res Function(_$CostAnalysisImpl) then) =
      __$$CostAnalysisImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {CostCategory labor,
      CostCategory overhead,
      CostCategory materials,
      CostCategory other});

  @override
  $CostCategoryCopyWith<$Res> get labor;
  @override
  $CostCategoryCopyWith<$Res> get overhead;
  @override
  $CostCategoryCopyWith<$Res> get materials;
  @override
  $CostCategoryCopyWith<$Res> get other;
}

/// @nodoc
class __$$CostAnalysisImplCopyWithImpl<$Res>
    extends _$CostAnalysisCopyWithImpl<$Res, _$CostAnalysisImpl>
    implements _$$CostAnalysisImplCopyWith<$Res> {
  __$$CostAnalysisImplCopyWithImpl(
      _$CostAnalysisImpl _value, $Res Function(_$CostAnalysisImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? labor = null,
    Object? overhead = null,
    Object? materials = null,
    Object? other = null,
  }) {
    return _then(_$CostAnalysisImpl(
      labor: null == labor
          ? _value.labor
          : labor // ignore: cast_nullable_to_non_nullable
              as CostCategory,
      overhead: null == overhead
          ? _value.overhead
          : overhead // ignore: cast_nullable_to_non_nullable
              as CostCategory,
      materials: null == materials
          ? _value.materials
          : materials // ignore: cast_nullable_to_non_nullable
              as CostCategory,
      other: null == other
          ? _value.other
          : other // ignore: cast_nullable_to_non_nullable
              as CostCategory,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CostAnalysisImpl implements _CostAnalysis {
  const _$CostAnalysisImpl(
      {required this.labor,
      required this.overhead,
      required this.materials,
      required this.other});

  factory _$CostAnalysisImpl.fromJson(Map<String, dynamic> json) =>
      _$$CostAnalysisImplFromJson(json);

  @override
  final CostCategory labor;
  @override
  final CostCategory overhead;
  @override
  final CostCategory materials;
  @override
  final CostCategory other;

  @override
  String toString() {
    return 'CostAnalysis(labor: $labor, overhead: $overhead, materials: $materials, other: $other)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CostAnalysisImpl &&
            (identical(other.labor, labor) || other.labor == labor) &&
            (identical(other.overhead, overhead) ||
                other.overhead == overhead) &&
            (identical(other.materials, materials) ||
                other.materials == materials) &&
            (identical(other.other, this.other) || other.other == this.other));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, labor, overhead, materials, other);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CostAnalysisImplCopyWith<_$CostAnalysisImpl> get copyWith =>
      __$$CostAnalysisImplCopyWithImpl<_$CostAnalysisImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CostAnalysisImplToJson(
      this,
    );
  }
}

abstract class _CostAnalysis implements CostAnalysis {
  const factory _CostAnalysis(
      {required final CostCategory labor,
      required final CostCategory overhead,
      required final CostCategory materials,
      required final CostCategory other}) = _$CostAnalysisImpl;

  factory _CostAnalysis.fromJson(Map<String, dynamic> json) =
      _$CostAnalysisImpl.fromJson;

  @override
  CostCategory get labor;
  @override
  CostCategory get overhead;
  @override
  CostCategory get materials;
  @override
  CostCategory get other;
  @override
  @JsonKey(ignore: true)
  _$$CostAnalysisImplCopyWith<_$CostAnalysisImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CostCategory _$CostCategoryFromJson(Map<String, dynamic> json) {
  return _CostCategory.fromJson(json);
}

/// @nodoc
mixin _$CostCategory {
  double get amount => throw _privateConstructorUsedError;
  double get percentage => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CostCategoryCopyWith<CostCategory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CostCategoryCopyWith<$Res> {
  factory $CostCategoryCopyWith(
          CostCategory value, $Res Function(CostCategory) then) =
      _$CostCategoryCopyWithImpl<$Res, CostCategory>;
  @useResult
  $Res call({double amount, double percentage});
}

/// @nodoc
class _$CostCategoryCopyWithImpl<$Res, $Val extends CostCategory>
    implements $CostCategoryCopyWith<$Res> {
  _$CostCategoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
    Object? percentage = null,
  }) {
    return _then(_value.copyWith(
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      percentage: null == percentage
          ? _value.percentage
          : percentage // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CostCategoryImplCopyWith<$Res>
    implements $CostCategoryCopyWith<$Res> {
  factory _$$CostCategoryImplCopyWith(
          _$CostCategoryImpl value, $Res Function(_$CostCategoryImpl) then) =
      __$$CostCategoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double amount, double percentage});
}

/// @nodoc
class __$$CostCategoryImplCopyWithImpl<$Res>
    extends _$CostCategoryCopyWithImpl<$Res, _$CostCategoryImpl>
    implements _$$CostCategoryImplCopyWith<$Res> {
  __$$CostCategoryImplCopyWithImpl(
      _$CostCategoryImpl _value, $Res Function(_$CostCategoryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
    Object? percentage = null,
  }) {
    return _then(_$CostCategoryImpl(
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      percentage: null == percentage
          ? _value.percentage
          : percentage // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CostCategoryImpl implements _CostCategory {
  const _$CostCategoryImpl({required this.amount, required this.percentage});

  factory _$CostCategoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$CostCategoryImplFromJson(json);

  @override
  final double amount;
  @override
  final double percentage;

  @override
  String toString() {
    return 'CostCategory(amount: $amount, percentage: $percentage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CostCategoryImpl &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.percentage, percentage) ||
                other.percentage == percentage));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, amount, percentage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CostCategoryImplCopyWith<_$CostCategoryImpl> get copyWith =>
      __$$CostCategoryImplCopyWithImpl<_$CostCategoryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CostCategoryImplToJson(
      this,
    );
  }
}

abstract class _CostCategory implements CostCategory {
  const factory _CostCategory(
      {required final double amount,
      required final double percentage}) = _$CostCategoryImpl;

  factory _CostCategory.fromJson(Map<String, dynamic> json) =
      _$CostCategoryImpl.fromJson;

  @override
  double get amount;
  @override
  double get percentage;
  @override
  @JsonKey(ignore: true)
  _$$CostCategoryImplCopyWith<_$CostCategoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TrendData _$TrendDataFromJson(Map<String, dynamic> json) {
  return _TrendData.fromJson(json);
}

/// @nodoc
mixin _$TrendData {
  String get month => throw _privateConstructorUsedError;
  double get revenue => throw _privateConstructorUsedError;
  double get profit => throw _privateConstructorUsedError;

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
  $Res call({String month, double revenue, double profit});
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
    Object? month = null,
    Object? revenue = null,
    Object? profit = null,
  }) {
    return _then(_value.copyWith(
      month: null == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as String,
      revenue: null == revenue
          ? _value.revenue
          : revenue // ignore: cast_nullable_to_non_nullable
              as double,
      profit: null == profit
          ? _value.profit
          : profit // ignore: cast_nullable_to_non_nullable
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
  $Res call({String month, double revenue, double profit});
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
    Object? month = null,
    Object? revenue = null,
    Object? profit = null,
  }) {
    return _then(_$TrendDataImpl(
      month: null == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as String,
      revenue: null == revenue
          ? _value.revenue
          : revenue // ignore: cast_nullable_to_non_nullable
              as double,
      profit: null == profit
          ? _value.profit
          : profit // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TrendDataImpl implements _TrendData {
  const _$TrendDataImpl(
      {required this.month, required this.revenue, required this.profit});

  factory _$TrendDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$TrendDataImplFromJson(json);

  @override
  final String month;
  @override
  final double revenue;
  @override
  final double profit;

  @override
  String toString() {
    return 'TrendData(month: $month, revenue: $revenue, profit: $profit)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TrendDataImpl &&
            (identical(other.month, month) || other.month == month) &&
            (identical(other.revenue, revenue) || other.revenue == revenue) &&
            (identical(other.profit, profit) || other.profit == profit));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, month, revenue, profit);

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
      {required final String month,
      required final double revenue,
      required final double profit}) = _$TrendDataImpl;

  factory _TrendData.fromJson(Map<String, dynamic> json) =
      _$TrendDataImpl.fromJson;

  @override
  String get month;
  @override
  double get revenue;
  @override
  double get profit;
  @override
  @JsonKey(ignore: true)
  _$$TrendDataImplCopyWith<_$TrendDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Budget _$BudgetFromJson(Map<String, dynamic> json) {
  return _Budget.fromJson(json);
}

/// @nodoc
mixin _$Budget {
  String get budgetId => throw _privateConstructorUsedError;
  String get organizationId => throw _privateConstructorUsedError;
  String get period => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;
  BudgetCategory get revenue => throw _privateConstructorUsedError;
  BudgetCategory get expenses => throw _privateConstructorUsedError;
  BudgetCategory get profit => throw _privateConstructorUsedError;
  List<String> get assumptions => throw _privateConstructorUsedError;
  BudgetScenarios get scenarios => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BudgetCopyWith<Budget> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BudgetCopyWith<$Res> {
  factory $BudgetCopyWith(Budget value, $Res Function(Budget) then) =
      _$BudgetCopyWithImpl<$Res, Budget>;
  @useResult
  $Res call(
      {String budgetId,
      String organizationId,
      String period,
      String createdAt,
      BudgetCategory revenue,
      BudgetCategory expenses,
      BudgetCategory profit,
      List<String> assumptions,
      BudgetScenarios scenarios});

  $BudgetCategoryCopyWith<$Res> get revenue;
  $BudgetCategoryCopyWith<$Res> get expenses;
  $BudgetCategoryCopyWith<$Res> get profit;
  $BudgetScenariosCopyWith<$Res> get scenarios;
}

/// @nodoc
class _$BudgetCopyWithImpl<$Res, $Val extends Budget>
    implements $BudgetCopyWith<$Res> {
  _$BudgetCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? budgetId = null,
    Object? organizationId = null,
    Object? period = null,
    Object? createdAt = null,
    Object? revenue = null,
    Object? expenses = null,
    Object? profit = null,
    Object? assumptions = null,
    Object? scenarios = null,
  }) {
    return _then(_value.copyWith(
      budgetId: null == budgetId
          ? _value.budgetId
          : budgetId // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      period: null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      revenue: null == revenue
          ? _value.revenue
          : revenue // ignore: cast_nullable_to_non_nullable
              as BudgetCategory,
      expenses: null == expenses
          ? _value.expenses
          : expenses // ignore: cast_nullable_to_non_nullable
              as BudgetCategory,
      profit: null == profit
          ? _value.profit
          : profit // ignore: cast_nullable_to_non_nullable
              as BudgetCategory,
      assumptions: null == assumptions
          ? _value.assumptions
          : assumptions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      scenarios: null == scenarios
          ? _value.scenarios
          : scenarios // ignore: cast_nullable_to_non_nullable
              as BudgetScenarios,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $BudgetCategoryCopyWith<$Res> get revenue {
    return $BudgetCategoryCopyWith<$Res>(_value.revenue, (value) {
      return _then(_value.copyWith(revenue: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $BudgetCategoryCopyWith<$Res> get expenses {
    return $BudgetCategoryCopyWith<$Res>(_value.expenses, (value) {
      return _then(_value.copyWith(expenses: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $BudgetCategoryCopyWith<$Res> get profit {
    return $BudgetCategoryCopyWith<$Res>(_value.profit, (value) {
      return _then(_value.copyWith(profit: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $BudgetScenariosCopyWith<$Res> get scenarios {
    return $BudgetScenariosCopyWith<$Res>(_value.scenarios, (value) {
      return _then(_value.copyWith(scenarios: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BudgetImplCopyWith<$Res> implements $BudgetCopyWith<$Res> {
  factory _$$BudgetImplCopyWith(
          _$BudgetImpl value, $Res Function(_$BudgetImpl) then) =
      __$$BudgetImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String budgetId,
      String organizationId,
      String period,
      String createdAt,
      BudgetCategory revenue,
      BudgetCategory expenses,
      BudgetCategory profit,
      List<String> assumptions,
      BudgetScenarios scenarios});

  @override
  $BudgetCategoryCopyWith<$Res> get revenue;
  @override
  $BudgetCategoryCopyWith<$Res> get expenses;
  @override
  $BudgetCategoryCopyWith<$Res> get profit;
  @override
  $BudgetScenariosCopyWith<$Res> get scenarios;
}

/// @nodoc
class __$$BudgetImplCopyWithImpl<$Res>
    extends _$BudgetCopyWithImpl<$Res, _$BudgetImpl>
    implements _$$BudgetImplCopyWith<$Res> {
  __$$BudgetImplCopyWithImpl(
      _$BudgetImpl _value, $Res Function(_$BudgetImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? budgetId = null,
    Object? organizationId = null,
    Object? period = null,
    Object? createdAt = null,
    Object? revenue = null,
    Object? expenses = null,
    Object? profit = null,
    Object? assumptions = null,
    Object? scenarios = null,
  }) {
    return _then(_$BudgetImpl(
      budgetId: null == budgetId
          ? _value.budgetId
          : budgetId // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      period: null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      revenue: null == revenue
          ? _value.revenue
          : revenue // ignore: cast_nullable_to_non_nullable
              as BudgetCategory,
      expenses: null == expenses
          ? _value.expenses
          : expenses // ignore: cast_nullable_to_non_nullable
              as BudgetCategory,
      profit: null == profit
          ? _value.profit
          : profit // ignore: cast_nullable_to_non_nullable
              as BudgetCategory,
      assumptions: null == assumptions
          ? _value._assumptions
          : assumptions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      scenarios: null == scenarios
          ? _value.scenarios
          : scenarios // ignore: cast_nullable_to_non_nullable
              as BudgetScenarios,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BudgetImpl implements _Budget {
  const _$BudgetImpl(
      {required this.budgetId,
      required this.organizationId,
      required this.period,
      required this.createdAt,
      required this.revenue,
      required this.expenses,
      required this.profit,
      required final List<String> assumptions,
      required this.scenarios})
      : _assumptions = assumptions;

  factory _$BudgetImpl.fromJson(Map<String, dynamic> json) =>
      _$$BudgetImplFromJson(json);

  @override
  final String budgetId;
  @override
  final String organizationId;
  @override
  final String period;
  @override
  final String createdAt;
  @override
  final BudgetCategory revenue;
  @override
  final BudgetCategory expenses;
  @override
  final BudgetCategory profit;
  final List<String> _assumptions;
  @override
  List<String> get assumptions {
    if (_assumptions is EqualUnmodifiableListView) return _assumptions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_assumptions);
  }

  @override
  final BudgetScenarios scenarios;

  @override
  String toString() {
    return 'Budget(budgetId: $budgetId, organizationId: $organizationId, period: $period, createdAt: $createdAt, revenue: $revenue, expenses: $expenses, profit: $profit, assumptions: $assumptions, scenarios: $scenarios)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BudgetImpl &&
            (identical(other.budgetId, budgetId) ||
                other.budgetId == budgetId) &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.period, period) || other.period == period) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.revenue, revenue) || other.revenue == revenue) &&
            (identical(other.expenses, expenses) ||
                other.expenses == expenses) &&
            (identical(other.profit, profit) || other.profit == profit) &&
            const DeepCollectionEquality()
                .equals(other._assumptions, _assumptions) &&
            (identical(other.scenarios, scenarios) ||
                other.scenarios == scenarios));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      budgetId,
      organizationId,
      period,
      createdAt,
      revenue,
      expenses,
      profit,
      const DeepCollectionEquality().hash(_assumptions),
      scenarios);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BudgetImplCopyWith<_$BudgetImpl> get copyWith =>
      __$$BudgetImplCopyWithImpl<_$BudgetImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BudgetImplToJson(
      this,
    );
  }
}

abstract class _Budget implements Budget {
  const factory _Budget(
      {required final String budgetId,
      required final String organizationId,
      required final String period,
      required final String createdAt,
      required final BudgetCategory revenue,
      required final BudgetCategory expenses,
      required final BudgetCategory profit,
      required final List<String> assumptions,
      required final BudgetScenarios scenarios}) = _$BudgetImpl;

  factory _Budget.fromJson(Map<String, dynamic> json) = _$BudgetImpl.fromJson;

  @override
  String get budgetId;
  @override
  String get organizationId;
  @override
  String get period;
  @override
  String get createdAt;
  @override
  BudgetCategory get revenue;
  @override
  BudgetCategory get expenses;
  @override
  BudgetCategory get profit;
  @override
  List<String> get assumptions;
  @override
  BudgetScenarios get scenarios;
  @override
  @JsonKey(ignore: true)
  _$$BudgetImplCopyWith<_$BudgetImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BudgetCategory _$BudgetCategoryFromJson(Map<String, dynamic> json) {
  return _BudgetCategory.fromJson(json);
}

/// @nodoc
mixin _$BudgetCategory {
  double get total => throw _privateConstructorUsedError;
  Map<String, dynamic>? get breakdown => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BudgetCategoryCopyWith<BudgetCategory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BudgetCategoryCopyWith<$Res> {
  factory $BudgetCategoryCopyWith(
          BudgetCategory value, $Res Function(BudgetCategory) then) =
      _$BudgetCategoryCopyWithImpl<$Res, BudgetCategory>;
  @useResult
  $Res call({double total, Map<String, dynamic>? breakdown});
}

/// @nodoc
class _$BudgetCategoryCopyWithImpl<$Res, $Val extends BudgetCategory>
    implements $BudgetCategoryCopyWith<$Res> {
  _$BudgetCategoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? total = null,
    Object? breakdown = freezed,
  }) {
    return _then(_value.copyWith(
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as double,
      breakdown: freezed == breakdown
          ? _value.breakdown
          : breakdown // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BudgetCategoryImplCopyWith<$Res>
    implements $BudgetCategoryCopyWith<$Res> {
  factory _$$BudgetCategoryImplCopyWith(_$BudgetCategoryImpl value,
          $Res Function(_$BudgetCategoryImpl) then) =
      __$$BudgetCategoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double total, Map<String, dynamic>? breakdown});
}

/// @nodoc
class __$$BudgetCategoryImplCopyWithImpl<$Res>
    extends _$BudgetCategoryCopyWithImpl<$Res, _$BudgetCategoryImpl>
    implements _$$BudgetCategoryImplCopyWith<$Res> {
  __$$BudgetCategoryImplCopyWithImpl(
      _$BudgetCategoryImpl _value, $Res Function(_$BudgetCategoryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? total = null,
    Object? breakdown = freezed,
  }) {
    return _then(_$BudgetCategoryImpl(
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as double,
      breakdown: freezed == breakdown
          ? _value._breakdown
          : breakdown // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BudgetCategoryImpl implements _BudgetCategory {
  const _$BudgetCategoryImpl(
      {required this.total, final Map<String, dynamic>? breakdown})
      : _breakdown = breakdown;

  factory _$BudgetCategoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$BudgetCategoryImplFromJson(json);

  @override
  final double total;
  final Map<String, dynamic>? _breakdown;
  @override
  Map<String, dynamic>? get breakdown {
    final value = _breakdown;
    if (value == null) return null;
    if (_breakdown is EqualUnmodifiableMapView) return _breakdown;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'BudgetCategory(total: $total, breakdown: $breakdown)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BudgetCategoryImpl &&
            (identical(other.total, total) || other.total == total) &&
            const DeepCollectionEquality()
                .equals(other._breakdown, _breakdown));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, total, const DeepCollectionEquality().hash(_breakdown));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BudgetCategoryImplCopyWith<_$BudgetCategoryImpl> get copyWith =>
      __$$BudgetCategoryImplCopyWithImpl<_$BudgetCategoryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BudgetCategoryImplToJson(
      this,
    );
  }
}

abstract class _BudgetCategory implements BudgetCategory {
  const factory _BudgetCategory(
      {required final double total,
      final Map<String, dynamic>? breakdown}) = _$BudgetCategoryImpl;

  factory _BudgetCategory.fromJson(Map<String, dynamic> json) =
      _$BudgetCategoryImpl.fromJson;

  @override
  double get total;
  @override
  Map<String, dynamic>? get breakdown;
  @override
  @JsonKey(ignore: true)
  _$$BudgetCategoryImplCopyWith<_$BudgetCategoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BudgetScenarios _$BudgetScenariosFromJson(Map<String, dynamic> json) {
  return _BudgetScenarios.fromJson(json);
}

/// @nodoc
mixin _$BudgetScenarios {
  BudgetScenario get best => throw _privateConstructorUsedError;
  BudgetScenario get base => throw _privateConstructorUsedError;
  BudgetScenario get worst => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BudgetScenariosCopyWith<BudgetScenarios> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BudgetScenariosCopyWith<$Res> {
  factory $BudgetScenariosCopyWith(
          BudgetScenarios value, $Res Function(BudgetScenarios) then) =
      _$BudgetScenariosCopyWithImpl<$Res, BudgetScenarios>;
  @useResult
  $Res call({BudgetScenario best, BudgetScenario base, BudgetScenario worst});

  $BudgetScenarioCopyWith<$Res> get best;
  $BudgetScenarioCopyWith<$Res> get base;
  $BudgetScenarioCopyWith<$Res> get worst;
}

/// @nodoc
class _$BudgetScenariosCopyWithImpl<$Res, $Val extends BudgetScenarios>
    implements $BudgetScenariosCopyWith<$Res> {
  _$BudgetScenariosCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? best = null,
    Object? base = null,
    Object? worst = null,
  }) {
    return _then(_value.copyWith(
      best: null == best
          ? _value.best
          : best // ignore: cast_nullable_to_non_nullable
              as BudgetScenario,
      base: null == base
          ? _value.base
          : base // ignore: cast_nullable_to_non_nullable
              as BudgetScenario,
      worst: null == worst
          ? _value.worst
          : worst // ignore: cast_nullable_to_non_nullable
              as BudgetScenario,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $BudgetScenarioCopyWith<$Res> get best {
    return $BudgetScenarioCopyWith<$Res>(_value.best, (value) {
      return _then(_value.copyWith(best: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $BudgetScenarioCopyWith<$Res> get base {
    return $BudgetScenarioCopyWith<$Res>(_value.base, (value) {
      return _then(_value.copyWith(base: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $BudgetScenarioCopyWith<$Res> get worst {
    return $BudgetScenarioCopyWith<$Res>(_value.worst, (value) {
      return _then(_value.copyWith(worst: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BudgetScenariosImplCopyWith<$Res>
    implements $BudgetScenariosCopyWith<$Res> {
  factory _$$BudgetScenariosImplCopyWith(_$BudgetScenariosImpl value,
          $Res Function(_$BudgetScenariosImpl) then) =
      __$$BudgetScenariosImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({BudgetScenario best, BudgetScenario base, BudgetScenario worst});

  @override
  $BudgetScenarioCopyWith<$Res> get best;
  @override
  $BudgetScenarioCopyWith<$Res> get base;
  @override
  $BudgetScenarioCopyWith<$Res> get worst;
}

/// @nodoc
class __$$BudgetScenariosImplCopyWithImpl<$Res>
    extends _$BudgetScenariosCopyWithImpl<$Res, _$BudgetScenariosImpl>
    implements _$$BudgetScenariosImplCopyWith<$Res> {
  __$$BudgetScenariosImplCopyWithImpl(
      _$BudgetScenariosImpl _value, $Res Function(_$BudgetScenariosImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? best = null,
    Object? base = null,
    Object? worst = null,
  }) {
    return _then(_$BudgetScenariosImpl(
      best: null == best
          ? _value.best
          : best // ignore: cast_nullable_to_non_nullable
              as BudgetScenario,
      base: null == base
          ? _value.base
          : base // ignore: cast_nullable_to_non_nullable
              as BudgetScenario,
      worst: null == worst
          ? _value.worst
          : worst // ignore: cast_nullable_to_non_nullable
              as BudgetScenario,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BudgetScenariosImpl implements _BudgetScenarios {
  const _$BudgetScenariosImpl(
      {required this.best, required this.base, required this.worst});

  factory _$BudgetScenariosImpl.fromJson(Map<String, dynamic> json) =>
      _$$BudgetScenariosImplFromJson(json);

  @override
  final BudgetScenario best;
  @override
  final BudgetScenario base;
  @override
  final BudgetScenario worst;

  @override
  String toString() {
    return 'BudgetScenarios(best: $best, base: $base, worst: $worst)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BudgetScenariosImpl &&
            (identical(other.best, best) || other.best == best) &&
            (identical(other.base, base) || other.base == base) &&
            (identical(other.worst, worst) || other.worst == worst));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, best, base, worst);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BudgetScenariosImplCopyWith<_$BudgetScenariosImpl> get copyWith =>
      __$$BudgetScenariosImplCopyWithImpl<_$BudgetScenariosImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BudgetScenariosImplToJson(
      this,
    );
  }
}

abstract class _BudgetScenarios implements BudgetScenarios {
  const factory _BudgetScenarios(
      {required final BudgetScenario best,
      required final BudgetScenario base,
      required final BudgetScenario worst}) = _$BudgetScenariosImpl;

  factory _BudgetScenarios.fromJson(Map<String, dynamic> json) =
      _$BudgetScenariosImpl.fromJson;

  @override
  BudgetScenario get best;
  @override
  BudgetScenario get base;
  @override
  BudgetScenario get worst;
  @override
  @JsonKey(ignore: true)
  _$$BudgetScenariosImplCopyWith<_$BudgetScenariosImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BudgetScenario _$BudgetScenarioFromJson(Map<String, dynamic> json) {
  return _BudgetScenario.fromJson(json);
}

/// @nodoc
mixin _$BudgetScenario {
  double get revenue => throw _privateConstructorUsedError;
  double get profit => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BudgetScenarioCopyWith<BudgetScenario> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BudgetScenarioCopyWith<$Res> {
  factory $BudgetScenarioCopyWith(
          BudgetScenario value, $Res Function(BudgetScenario) then) =
      _$BudgetScenarioCopyWithImpl<$Res, BudgetScenario>;
  @useResult
  $Res call({double revenue, double profit});
}

/// @nodoc
class _$BudgetScenarioCopyWithImpl<$Res, $Val extends BudgetScenario>
    implements $BudgetScenarioCopyWith<$Res> {
  _$BudgetScenarioCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? revenue = null,
    Object? profit = null,
  }) {
    return _then(_value.copyWith(
      revenue: null == revenue
          ? _value.revenue
          : revenue // ignore: cast_nullable_to_non_nullable
              as double,
      profit: null == profit
          ? _value.profit
          : profit // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BudgetScenarioImplCopyWith<$Res>
    implements $BudgetScenarioCopyWith<$Res> {
  factory _$$BudgetScenarioImplCopyWith(_$BudgetScenarioImpl value,
          $Res Function(_$BudgetScenarioImpl) then) =
      __$$BudgetScenarioImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double revenue, double profit});
}

/// @nodoc
class __$$BudgetScenarioImplCopyWithImpl<$Res>
    extends _$BudgetScenarioCopyWithImpl<$Res, _$BudgetScenarioImpl>
    implements _$$BudgetScenarioImplCopyWith<$Res> {
  __$$BudgetScenarioImplCopyWithImpl(
      _$BudgetScenarioImpl _value, $Res Function(_$BudgetScenarioImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? revenue = null,
    Object? profit = null,
  }) {
    return _then(_$BudgetScenarioImpl(
      revenue: null == revenue
          ? _value.revenue
          : revenue // ignore: cast_nullable_to_non_nullable
              as double,
      profit: null == profit
          ? _value.profit
          : profit // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BudgetScenarioImpl implements _BudgetScenario {
  const _$BudgetScenarioImpl({required this.revenue, required this.profit});

  factory _$BudgetScenarioImpl.fromJson(Map<String, dynamic> json) =>
      _$$BudgetScenarioImplFromJson(json);

  @override
  final double revenue;
  @override
  final double profit;

  @override
  String toString() {
    return 'BudgetScenario(revenue: $revenue, profit: $profit)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BudgetScenarioImpl &&
            (identical(other.revenue, revenue) || other.revenue == revenue) &&
            (identical(other.profit, profit) || other.profit == profit));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, revenue, profit);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BudgetScenarioImplCopyWith<_$BudgetScenarioImpl> get copyWith =>
      __$$BudgetScenarioImplCopyWithImpl<_$BudgetScenarioImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BudgetScenarioImplToJson(
      this,
    );
  }
}

abstract class _BudgetScenario implements BudgetScenario {
  const factory _BudgetScenario(
      {required final double revenue,
      required final double profit}) = _$BudgetScenarioImpl;

  factory _BudgetScenario.fromJson(Map<String, dynamic> json) =
      _$BudgetScenarioImpl.fromJson;

  @override
  double get revenue;
  @override
  double get profit;
  @override
  @JsonKey(ignore: true)
  _$$BudgetScenarioImplCopyWith<_$BudgetScenarioImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Payment _$PaymentFromJson(Map<String, dynamic> json) {
  return _Payment.fromJson(json);
}

/// @nodoc
mixin _$Payment {
  String get paymentId => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  String get method => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String get processedAt => throw _privateConstructorUsedError;
  PaymentRouting get routing => throw _privateConstructorUsedError;
  PaymentFees get fees => throw _privateConstructorUsedError;
  String get estimatedCompletion => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PaymentCopyWith<Payment> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentCopyWith<$Res> {
  factory $PaymentCopyWith(Payment value, $Res Function(Payment) then) =
      _$PaymentCopyWithImpl<$Res, Payment>;
  @useResult
  $Res call(
      {String paymentId,
      double amount,
      String method,
      String status,
      String processedAt,
      PaymentRouting routing,
      PaymentFees fees,
      String estimatedCompletion});

  $PaymentRoutingCopyWith<$Res> get routing;
  $PaymentFeesCopyWith<$Res> get fees;
}

/// @nodoc
class _$PaymentCopyWithImpl<$Res, $Val extends Payment>
    implements $PaymentCopyWith<$Res> {
  _$PaymentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? paymentId = null,
    Object? amount = null,
    Object? method = null,
    Object? status = null,
    Object? processedAt = null,
    Object? routing = null,
    Object? fees = null,
    Object? estimatedCompletion = null,
  }) {
    return _then(_value.copyWith(
      paymentId: null == paymentId
          ? _value.paymentId
          : paymentId // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      method: null == method
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      processedAt: null == processedAt
          ? _value.processedAt
          : processedAt // ignore: cast_nullable_to_non_nullable
              as String,
      routing: null == routing
          ? _value.routing
          : routing // ignore: cast_nullable_to_non_nullable
              as PaymentRouting,
      fees: null == fees
          ? _value.fees
          : fees // ignore: cast_nullable_to_non_nullable
              as PaymentFees,
      estimatedCompletion: null == estimatedCompletion
          ? _value.estimatedCompletion
          : estimatedCompletion // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PaymentRoutingCopyWith<$Res> get routing {
    return $PaymentRoutingCopyWith<$Res>(_value.routing, (value) {
      return _then(_value.copyWith(routing: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PaymentFeesCopyWith<$Res> get fees {
    return $PaymentFeesCopyWith<$Res>(_value.fees, (value) {
      return _then(_value.copyWith(fees: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PaymentImplCopyWith<$Res> implements $PaymentCopyWith<$Res> {
  factory _$$PaymentImplCopyWith(
          _$PaymentImpl value, $Res Function(_$PaymentImpl) then) =
      __$$PaymentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String paymentId,
      double amount,
      String method,
      String status,
      String processedAt,
      PaymentRouting routing,
      PaymentFees fees,
      String estimatedCompletion});

  @override
  $PaymentRoutingCopyWith<$Res> get routing;
  @override
  $PaymentFeesCopyWith<$Res> get fees;
}

/// @nodoc
class __$$PaymentImplCopyWithImpl<$Res>
    extends _$PaymentCopyWithImpl<$Res, _$PaymentImpl>
    implements _$$PaymentImplCopyWith<$Res> {
  __$$PaymentImplCopyWithImpl(
      _$PaymentImpl _value, $Res Function(_$PaymentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? paymentId = null,
    Object? amount = null,
    Object? method = null,
    Object? status = null,
    Object? processedAt = null,
    Object? routing = null,
    Object? fees = null,
    Object? estimatedCompletion = null,
  }) {
    return _then(_$PaymentImpl(
      paymentId: null == paymentId
          ? _value.paymentId
          : paymentId // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      method: null == method
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      processedAt: null == processedAt
          ? _value.processedAt
          : processedAt // ignore: cast_nullable_to_non_nullable
              as String,
      routing: null == routing
          ? _value.routing
          : routing // ignore: cast_nullable_to_non_nullable
              as PaymentRouting,
      fees: null == fees
          ? _value.fees
          : fees // ignore: cast_nullable_to_non_nullable
              as PaymentFees,
      estimatedCompletion: null == estimatedCompletion
          ? _value.estimatedCompletion
          : estimatedCompletion // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PaymentImpl implements _Payment {
  const _$PaymentImpl(
      {required this.paymentId,
      required this.amount,
      required this.method,
      required this.status,
      required this.processedAt,
      required this.routing,
      required this.fees,
      required this.estimatedCompletion});

  factory _$PaymentImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaymentImplFromJson(json);

  @override
  final String paymentId;
  @override
  final double amount;
  @override
  final String method;
  @override
  final String status;
  @override
  final String processedAt;
  @override
  final PaymentRouting routing;
  @override
  final PaymentFees fees;
  @override
  final String estimatedCompletion;

  @override
  String toString() {
    return 'Payment(paymentId: $paymentId, amount: $amount, method: $method, status: $status, processedAt: $processedAt, routing: $routing, fees: $fees, estimatedCompletion: $estimatedCompletion)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentImpl &&
            (identical(other.paymentId, paymentId) ||
                other.paymentId == paymentId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.method, method) || other.method == method) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.processedAt, processedAt) ||
                other.processedAt == processedAt) &&
            (identical(other.routing, routing) || other.routing == routing) &&
            (identical(other.fees, fees) || other.fees == fees) &&
            (identical(other.estimatedCompletion, estimatedCompletion) ||
                other.estimatedCompletion == estimatedCompletion));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, paymentId, amount, method,
      status, processedAt, routing, fees, estimatedCompletion);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentImplCopyWith<_$PaymentImpl> get copyWith =>
      __$$PaymentImplCopyWithImpl<_$PaymentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PaymentImplToJson(
      this,
    );
  }
}

abstract class _Payment implements Payment {
  const factory _Payment(
      {required final String paymentId,
      required final double amount,
      required final String method,
      required final String status,
      required final String processedAt,
      required final PaymentRouting routing,
      required final PaymentFees fees,
      required final String estimatedCompletion}) = _$PaymentImpl;

  factory _Payment.fromJson(Map<String, dynamic> json) = _$PaymentImpl.fromJson;

  @override
  String get paymentId;
  @override
  double get amount;
  @override
  String get method;
  @override
  String get status;
  @override
  String get processedAt;
  @override
  PaymentRouting get routing;
  @override
  PaymentFees get fees;
  @override
  String get estimatedCompletion;
  @override
  @JsonKey(ignore: true)
  _$$PaymentImplCopyWith<_$PaymentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PaymentRouting _$PaymentRoutingFromJson(Map<String, dynamic> json) {
  return _PaymentRouting.fromJson(json);
}

/// @nodoc
mixin _$PaymentRouting {
  String get processor => throw _privateConstructorUsedError;
  String get gateway => throw _privateConstructorUsedError;
  double get estimatedFee => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PaymentRoutingCopyWith<PaymentRouting> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentRoutingCopyWith<$Res> {
  factory $PaymentRoutingCopyWith(
          PaymentRouting value, $Res Function(PaymentRouting) then) =
      _$PaymentRoutingCopyWithImpl<$Res, PaymentRouting>;
  @useResult
  $Res call({String processor, String gateway, double estimatedFee});
}

/// @nodoc
class _$PaymentRoutingCopyWithImpl<$Res, $Val extends PaymentRouting>
    implements $PaymentRoutingCopyWith<$Res> {
  _$PaymentRoutingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? processor = null,
    Object? gateway = null,
    Object? estimatedFee = null,
  }) {
    return _then(_value.copyWith(
      processor: null == processor
          ? _value.processor
          : processor // ignore: cast_nullable_to_non_nullable
              as String,
      gateway: null == gateway
          ? _value.gateway
          : gateway // ignore: cast_nullable_to_non_nullable
              as String,
      estimatedFee: null == estimatedFee
          ? _value.estimatedFee
          : estimatedFee // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PaymentRoutingImplCopyWith<$Res>
    implements $PaymentRoutingCopyWith<$Res> {
  factory _$$PaymentRoutingImplCopyWith(_$PaymentRoutingImpl value,
          $Res Function(_$PaymentRoutingImpl) then) =
      __$$PaymentRoutingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String processor, String gateway, double estimatedFee});
}

/// @nodoc
class __$$PaymentRoutingImplCopyWithImpl<$Res>
    extends _$PaymentRoutingCopyWithImpl<$Res, _$PaymentRoutingImpl>
    implements _$$PaymentRoutingImplCopyWith<$Res> {
  __$$PaymentRoutingImplCopyWithImpl(
      _$PaymentRoutingImpl _value, $Res Function(_$PaymentRoutingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? processor = null,
    Object? gateway = null,
    Object? estimatedFee = null,
  }) {
    return _then(_$PaymentRoutingImpl(
      processor: null == processor
          ? _value.processor
          : processor // ignore: cast_nullable_to_non_nullable
              as String,
      gateway: null == gateway
          ? _value.gateway
          : gateway // ignore: cast_nullable_to_non_nullable
              as String,
      estimatedFee: null == estimatedFee
          ? _value.estimatedFee
          : estimatedFee // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PaymentRoutingImpl implements _PaymentRouting {
  const _$PaymentRoutingImpl(
      {required this.processor,
      required this.gateway,
      required this.estimatedFee});

  factory _$PaymentRoutingImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaymentRoutingImplFromJson(json);

  @override
  final String processor;
  @override
  final String gateway;
  @override
  final double estimatedFee;

  @override
  String toString() {
    return 'PaymentRouting(processor: $processor, gateway: $gateway, estimatedFee: $estimatedFee)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentRoutingImpl &&
            (identical(other.processor, processor) ||
                other.processor == processor) &&
            (identical(other.gateway, gateway) || other.gateway == gateway) &&
            (identical(other.estimatedFee, estimatedFee) ||
                other.estimatedFee == estimatedFee));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, processor, gateway, estimatedFee);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentRoutingImplCopyWith<_$PaymentRoutingImpl> get copyWith =>
      __$$PaymentRoutingImplCopyWithImpl<_$PaymentRoutingImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PaymentRoutingImplToJson(
      this,
    );
  }
}

abstract class _PaymentRouting implements PaymentRouting {
  const factory _PaymentRouting(
      {required final String processor,
      required final String gateway,
      required final double estimatedFee}) = _$PaymentRoutingImpl;

  factory _PaymentRouting.fromJson(Map<String, dynamic> json) =
      _$PaymentRoutingImpl.fromJson;

  @override
  String get processor;
  @override
  String get gateway;
  @override
  double get estimatedFee;
  @override
  @JsonKey(ignore: true)
  _$$PaymentRoutingImplCopyWith<_$PaymentRoutingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PaymentFees _$PaymentFeesFromJson(Map<String, dynamic> json) {
  return _PaymentFees.fromJson(json);
}

/// @nodoc
mixin _$PaymentFees {
  double get processing => throw _privateConstructorUsedError;
  double get gateway => throw _privateConstructorUsedError;
  double get total => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PaymentFeesCopyWith<PaymentFees> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentFeesCopyWith<$Res> {
  factory $PaymentFeesCopyWith(
          PaymentFees value, $Res Function(PaymentFees) then) =
      _$PaymentFeesCopyWithImpl<$Res, PaymentFees>;
  @useResult
  $Res call({double processing, double gateway, double total});
}

/// @nodoc
class _$PaymentFeesCopyWithImpl<$Res, $Val extends PaymentFees>
    implements $PaymentFeesCopyWith<$Res> {
  _$PaymentFeesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? processing = null,
    Object? gateway = null,
    Object? total = null,
  }) {
    return _then(_value.copyWith(
      processing: null == processing
          ? _value.processing
          : processing // ignore: cast_nullable_to_non_nullable
              as double,
      gateway: null == gateway
          ? _value.gateway
          : gateway // ignore: cast_nullable_to_non_nullable
              as double,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PaymentFeesImplCopyWith<$Res>
    implements $PaymentFeesCopyWith<$Res> {
  factory _$$PaymentFeesImplCopyWith(
          _$PaymentFeesImpl value, $Res Function(_$PaymentFeesImpl) then) =
      __$$PaymentFeesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double processing, double gateway, double total});
}

/// @nodoc
class __$$PaymentFeesImplCopyWithImpl<$Res>
    extends _$PaymentFeesCopyWithImpl<$Res, _$PaymentFeesImpl>
    implements _$$PaymentFeesImplCopyWith<$Res> {
  __$$PaymentFeesImplCopyWithImpl(
      _$PaymentFeesImpl _value, $Res Function(_$PaymentFeesImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? processing = null,
    Object? gateway = null,
    Object? total = null,
  }) {
    return _then(_$PaymentFeesImpl(
      processing: null == processing
          ? _value.processing
          : processing // ignore: cast_nullable_to_non_nullable
              as double,
      gateway: null == gateway
          ? _value.gateway
          : gateway // ignore: cast_nullable_to_non_nullable
              as double,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PaymentFeesImpl implements _PaymentFees {
  const _$PaymentFeesImpl(
      {required this.processing, required this.gateway, required this.total});

  factory _$PaymentFeesImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaymentFeesImplFromJson(json);

  @override
  final double processing;
  @override
  final double gateway;
  @override
  final double total;

  @override
  String toString() {
    return 'PaymentFees(processing: $processing, gateway: $gateway, total: $total)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentFeesImpl &&
            (identical(other.processing, processing) ||
                other.processing == processing) &&
            (identical(other.gateway, gateway) || other.gateway == gateway) &&
            (identical(other.total, total) || other.total == total));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, processing, gateway, total);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentFeesImplCopyWith<_$PaymentFeesImpl> get copyWith =>
      __$$PaymentFeesImplCopyWithImpl<_$PaymentFeesImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PaymentFeesImplToJson(
      this,
    );
  }
}

abstract class _PaymentFees implements PaymentFees {
  const factory _PaymentFees(
      {required final double processing,
      required final double gateway,
      required final double total}) = _$PaymentFeesImpl;

  factory _PaymentFees.fromJson(Map<String, dynamic> json) =
      _$PaymentFeesImpl.fromJson;

  @override
  double get processing;
  @override
  double get gateway;
  @override
  double get total;
  @override
  @JsonKey(ignore: true)
  _$$PaymentFeesImplCopyWith<_$PaymentFeesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ComplianceCheck _$ComplianceCheckFromJson(Map<String, dynamic> json) {
  return _ComplianceCheck.fromJson(json);
}

/// @nodoc
mixin _$ComplianceCheck {
  String get organizationId => throw _privateConstructorUsedError;
  String get checkedAt => throw _privateConstructorUsedError;
  ComplianceArea get ndis => throw _privateConstructorUsedError;
  ComplianceArea get tax => throw _privateConstructorUsedError;
  ComplianceArea get reporting => throw _privateConstructorUsedError;
  String get overallStatus => throw _privateConstructorUsedError;
  double get score => throw _privateConstructorUsedError;
  List<String> get issues => throw _privateConstructorUsedError;
  List<String> get recommendations => throw _privateConstructorUsedError;

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
      {String organizationId,
      String checkedAt,
      ComplianceArea ndis,
      ComplianceArea tax,
      ComplianceArea reporting,
      String overallStatus,
      double score,
      List<String> issues,
      List<String> recommendations});

  $ComplianceAreaCopyWith<$Res> get ndis;
  $ComplianceAreaCopyWith<$Res> get tax;
  $ComplianceAreaCopyWith<$Res> get reporting;
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
    Object? organizationId = null,
    Object? checkedAt = null,
    Object? ndis = null,
    Object? tax = null,
    Object? reporting = null,
    Object? overallStatus = null,
    Object? score = null,
    Object? issues = null,
    Object? recommendations = null,
  }) {
    return _then(_value.copyWith(
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      checkedAt: null == checkedAt
          ? _value.checkedAt
          : checkedAt // ignore: cast_nullable_to_non_nullable
              as String,
      ndis: null == ndis
          ? _value.ndis
          : ndis // ignore: cast_nullable_to_non_nullable
              as ComplianceArea,
      tax: null == tax
          ? _value.tax
          : tax // ignore: cast_nullable_to_non_nullable
              as ComplianceArea,
      reporting: null == reporting
          ? _value.reporting
          : reporting // ignore: cast_nullable_to_non_nullable
              as ComplianceArea,
      overallStatus: null == overallStatus
          ? _value.overallStatus
          : overallStatus // ignore: cast_nullable_to_non_nullable
              as String,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as double,
      issues: null == issues
          ? _value.issues
          : issues // ignore: cast_nullable_to_non_nullable
              as List<String>,
      recommendations: null == recommendations
          ? _value.recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ComplianceAreaCopyWith<$Res> get ndis {
    return $ComplianceAreaCopyWith<$Res>(_value.ndis, (value) {
      return _then(_value.copyWith(ndis: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ComplianceAreaCopyWith<$Res> get tax {
    return $ComplianceAreaCopyWith<$Res>(_value.tax, (value) {
      return _then(_value.copyWith(tax: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ComplianceAreaCopyWith<$Res> get reporting {
    return $ComplianceAreaCopyWith<$Res>(_value.reporting, (value) {
      return _then(_value.copyWith(reporting: value) as $Val);
    });
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
      {String organizationId,
      String checkedAt,
      ComplianceArea ndis,
      ComplianceArea tax,
      ComplianceArea reporting,
      String overallStatus,
      double score,
      List<String> issues,
      List<String> recommendations});

  @override
  $ComplianceAreaCopyWith<$Res> get ndis;
  @override
  $ComplianceAreaCopyWith<$Res> get tax;
  @override
  $ComplianceAreaCopyWith<$Res> get reporting;
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
    Object? organizationId = null,
    Object? checkedAt = null,
    Object? ndis = null,
    Object? tax = null,
    Object? reporting = null,
    Object? overallStatus = null,
    Object? score = null,
    Object? issues = null,
    Object? recommendations = null,
  }) {
    return _then(_$ComplianceCheckImpl(
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      checkedAt: null == checkedAt
          ? _value.checkedAt
          : checkedAt // ignore: cast_nullable_to_non_nullable
              as String,
      ndis: null == ndis
          ? _value.ndis
          : ndis // ignore: cast_nullable_to_non_nullable
              as ComplianceArea,
      tax: null == tax
          ? _value.tax
          : tax // ignore: cast_nullable_to_non_nullable
              as ComplianceArea,
      reporting: null == reporting
          ? _value.reporting
          : reporting // ignore: cast_nullable_to_non_nullable
              as ComplianceArea,
      overallStatus: null == overallStatus
          ? _value.overallStatus
          : overallStatus // ignore: cast_nullable_to_non_nullable
              as String,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as double,
      issues: null == issues
          ? _value._issues
          : issues // ignore: cast_nullable_to_non_nullable
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
class _$ComplianceCheckImpl implements _ComplianceCheck {
  const _$ComplianceCheckImpl(
      {required this.organizationId,
      required this.checkedAt,
      required this.ndis,
      required this.tax,
      required this.reporting,
      required this.overallStatus,
      required this.score,
      required final List<String> issues,
      required final List<String> recommendations})
      : _issues = issues,
        _recommendations = recommendations;

  factory _$ComplianceCheckImpl.fromJson(Map<String, dynamic> json) =>
      _$$ComplianceCheckImplFromJson(json);

  @override
  final String organizationId;
  @override
  final String checkedAt;
  @override
  final ComplianceArea ndis;
  @override
  final ComplianceArea tax;
  @override
  final ComplianceArea reporting;
  @override
  final String overallStatus;
  @override
  final double score;
  final List<String> _issues;
  @override
  List<String> get issues {
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
  String toString() {
    return 'ComplianceCheck(organizationId: $organizationId, checkedAt: $checkedAt, ndis: $ndis, tax: $tax, reporting: $reporting, overallStatus: $overallStatus, score: $score, issues: $issues, recommendations: $recommendations)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ComplianceCheckImpl &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.checkedAt, checkedAt) ||
                other.checkedAt == checkedAt) &&
            (identical(other.ndis, ndis) || other.ndis == ndis) &&
            (identical(other.tax, tax) || other.tax == tax) &&
            (identical(other.reporting, reporting) ||
                other.reporting == reporting) &&
            (identical(other.overallStatus, overallStatus) ||
                other.overallStatus == overallStatus) &&
            (identical(other.score, score) || other.score == score) &&
            const DeepCollectionEquality().equals(other._issues, _issues) &&
            const DeepCollectionEquality()
                .equals(other._recommendations, _recommendations));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      organizationId,
      checkedAt,
      ndis,
      tax,
      reporting,
      overallStatus,
      score,
      const DeepCollectionEquality().hash(_issues),
      const DeepCollectionEquality().hash(_recommendations));

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
      {required final String organizationId,
      required final String checkedAt,
      required final ComplianceArea ndis,
      required final ComplianceArea tax,
      required final ComplianceArea reporting,
      required final String overallStatus,
      required final double score,
      required final List<String> issues,
      required final List<String> recommendations}) = _$ComplianceCheckImpl;

  factory _ComplianceCheck.fromJson(Map<String, dynamic> json) =
      _$ComplianceCheckImpl.fromJson;

  @override
  String get organizationId;
  @override
  String get checkedAt;
  @override
  ComplianceArea get ndis;
  @override
  ComplianceArea get tax;
  @override
  ComplianceArea get reporting;
  @override
  String get overallStatus;
  @override
  double get score;
  @override
  List<String> get issues;
  @override
  List<String> get recommendations;
  @override
  @JsonKey(ignore: true)
  _$$ComplianceCheckImplCopyWith<_$ComplianceCheckImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ComplianceArea _$ComplianceAreaFromJson(Map<String, dynamic> json) {
  return _ComplianceArea.fromJson(json);
}

/// @nodoc
mixin _$ComplianceArea {
  String get status => throw _privateConstructorUsedError;
  List<ComplianceAreaCheck> get checks => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ComplianceAreaCopyWith<ComplianceArea> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ComplianceAreaCopyWith<$Res> {
  factory $ComplianceAreaCopyWith(
          ComplianceArea value, $Res Function(ComplianceArea) then) =
      _$ComplianceAreaCopyWithImpl<$Res, ComplianceArea>;
  @useResult
  $Res call({String status, List<ComplianceAreaCheck> checks});
}

/// @nodoc
class _$ComplianceAreaCopyWithImpl<$Res, $Val extends ComplianceArea>
    implements $ComplianceAreaCopyWith<$Res> {
  _$ComplianceAreaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? checks = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      checks: null == checks
          ? _value.checks
          : checks // ignore: cast_nullable_to_non_nullable
              as List<ComplianceAreaCheck>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ComplianceAreaImplCopyWith<$Res>
    implements $ComplianceAreaCopyWith<$Res> {
  factory _$$ComplianceAreaImplCopyWith(_$ComplianceAreaImpl value,
          $Res Function(_$ComplianceAreaImpl) then) =
      __$$ComplianceAreaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String status, List<ComplianceAreaCheck> checks});
}

/// @nodoc
class __$$ComplianceAreaImplCopyWithImpl<$Res>
    extends _$ComplianceAreaCopyWithImpl<$Res, _$ComplianceAreaImpl>
    implements _$$ComplianceAreaImplCopyWith<$Res> {
  __$$ComplianceAreaImplCopyWithImpl(
      _$ComplianceAreaImpl _value, $Res Function(_$ComplianceAreaImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? checks = null,
  }) {
    return _then(_$ComplianceAreaImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      checks: null == checks
          ? _value._checks
          : checks // ignore: cast_nullable_to_non_nullable
              as List<ComplianceAreaCheck>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ComplianceAreaImpl implements _ComplianceArea {
  const _$ComplianceAreaImpl(
      {required this.status, required final List<ComplianceAreaCheck> checks})
      : _checks = checks;

  factory _$ComplianceAreaImpl.fromJson(Map<String, dynamic> json) =>
      _$$ComplianceAreaImplFromJson(json);

  @override
  final String status;
  final List<ComplianceAreaCheck> _checks;
  @override
  List<ComplianceAreaCheck> get checks {
    if (_checks is EqualUnmodifiableListView) return _checks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_checks);
  }

  @override
  String toString() {
    return 'ComplianceArea(status: $status, checks: $checks)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ComplianceAreaImpl &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._checks, _checks));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, status, const DeepCollectionEquality().hash(_checks));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ComplianceAreaImplCopyWith<_$ComplianceAreaImpl> get copyWith =>
      __$$ComplianceAreaImplCopyWithImpl<_$ComplianceAreaImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ComplianceAreaImplToJson(
      this,
    );
  }
}

abstract class _ComplianceArea implements ComplianceArea {
  const factory _ComplianceArea(
      {required final String status,
      required final List<ComplianceAreaCheck> checks}) = _$ComplianceAreaImpl;

  factory _ComplianceArea.fromJson(Map<String, dynamic> json) =
      _$ComplianceAreaImpl.fromJson;

  @override
  String get status;
  @override
  List<ComplianceAreaCheck> get checks;
  @override
  @JsonKey(ignore: true)
  _$$ComplianceAreaImplCopyWith<_$ComplianceAreaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ComplianceAreaCheck _$ComplianceAreaCheckFromJson(Map<String, dynamic> json) {
  return _ComplianceAreaCheck.fromJson(json);
}

/// @nodoc
mixin _$ComplianceAreaCheck {
  String get check => throw _privateConstructorUsedError;
  bool get passed => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ComplianceAreaCheckCopyWith<ComplianceAreaCheck> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ComplianceAreaCheckCopyWith<$Res> {
  factory $ComplianceAreaCheckCopyWith(
          ComplianceAreaCheck value, $Res Function(ComplianceAreaCheck) then) =
      _$ComplianceAreaCheckCopyWithImpl<$Res, ComplianceAreaCheck>;
  @useResult
  $Res call({String check, bool passed});
}

/// @nodoc
class _$ComplianceAreaCheckCopyWithImpl<$Res, $Val extends ComplianceAreaCheck>
    implements $ComplianceAreaCheckCopyWith<$Res> {
  _$ComplianceAreaCheckCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? check = null,
    Object? passed = null,
  }) {
    return _then(_value.copyWith(
      check: null == check
          ? _value.check
          : check // ignore: cast_nullable_to_non_nullable
              as String,
      passed: null == passed
          ? _value.passed
          : passed // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ComplianceAreaCheckImplCopyWith<$Res>
    implements $ComplianceAreaCheckCopyWith<$Res> {
  factory _$$ComplianceAreaCheckImplCopyWith(_$ComplianceAreaCheckImpl value,
          $Res Function(_$ComplianceAreaCheckImpl) then) =
      __$$ComplianceAreaCheckImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String check, bool passed});
}

/// @nodoc
class __$$ComplianceAreaCheckImplCopyWithImpl<$Res>
    extends _$ComplianceAreaCheckCopyWithImpl<$Res, _$ComplianceAreaCheckImpl>
    implements _$$ComplianceAreaCheckImplCopyWith<$Res> {
  __$$ComplianceAreaCheckImplCopyWithImpl(_$ComplianceAreaCheckImpl _value,
      $Res Function(_$ComplianceAreaCheckImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? check = null,
    Object? passed = null,
  }) {
    return _then(_$ComplianceAreaCheckImpl(
      check: null == check
          ? _value.check
          : check // ignore: cast_nullable_to_non_nullable
              as String,
      passed: null == passed
          ? _value.passed
          : passed // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ComplianceAreaCheckImpl implements _ComplianceAreaCheck {
  const _$ComplianceAreaCheckImpl({required this.check, required this.passed});

  factory _$ComplianceAreaCheckImpl.fromJson(Map<String, dynamic> json) =>
      _$$ComplianceAreaCheckImplFromJson(json);

  @override
  final String check;
  @override
  final bool passed;

  @override
  String toString() {
    return 'ComplianceAreaCheck(check: $check, passed: $passed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ComplianceAreaCheckImpl &&
            (identical(other.check, check) || other.check == check) &&
            (identical(other.passed, passed) || other.passed == passed));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, check, passed);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ComplianceAreaCheckImplCopyWith<_$ComplianceAreaCheckImpl> get copyWith =>
      __$$ComplianceAreaCheckImplCopyWithImpl<_$ComplianceAreaCheckImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ComplianceAreaCheckImplToJson(
      this,
    );
  }
}

abstract class _ComplianceAreaCheck implements ComplianceAreaCheck {
  const factory _ComplianceAreaCheck(
      {required final String check,
      required final bool passed}) = _$ComplianceAreaCheckImpl;

  factory _ComplianceAreaCheck.fromJson(Map<String, dynamic> json) =
      _$ComplianceAreaCheckImpl.fromJson;

  @override
  String get check;
  @override
  bool get passed;
  @override
  @JsonKey(ignore: true)
  _$$ComplianceAreaCheckImplCopyWith<_$ComplianceAreaCheckImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ClientCredit _$ClientCreditFromJson(Map<String, dynamic> json) {
  return _ClientCredit.fromJson(json);
}

/// @nodoc
mixin _$ClientCredit {
  String get clientId => throw _privateConstructorUsedError;
  String get organizationId => throw _privateConstructorUsedError;
  String get analyzedAt => throw _privateConstructorUsedError;
  CreditCurrent get current => throw _privateConstructorUsedError;
  CreditRecommended get recommended => throw _privateConstructorUsedError;
  double get riskScore => throw _privateConstructorUsedError;
  PaymentHistory get paymentHistory => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ClientCreditCopyWith<ClientCredit> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClientCreditCopyWith<$Res> {
  factory $ClientCreditCopyWith(
          ClientCredit value, $Res Function(ClientCredit) then) =
      _$ClientCreditCopyWithImpl<$Res, ClientCredit>;
  @useResult
  $Res call(
      {String clientId,
      String organizationId,
      String analyzedAt,
      CreditCurrent current,
      CreditRecommended recommended,
      double riskScore,
      PaymentHistory paymentHistory});

  $CreditCurrentCopyWith<$Res> get current;
  $CreditRecommendedCopyWith<$Res> get recommended;
  $PaymentHistoryCopyWith<$Res> get paymentHistory;
}

/// @nodoc
class _$ClientCreditCopyWithImpl<$Res, $Val extends ClientCredit>
    implements $ClientCreditCopyWith<$Res> {
  _$ClientCreditCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clientId = null,
    Object? organizationId = null,
    Object? analyzedAt = null,
    Object? current = null,
    Object? recommended = null,
    Object? riskScore = null,
    Object? paymentHistory = null,
  }) {
    return _then(_value.copyWith(
      clientId: null == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      analyzedAt: null == analyzedAt
          ? _value.analyzedAt
          : analyzedAt // ignore: cast_nullable_to_non_nullable
              as String,
      current: null == current
          ? _value.current
          : current // ignore: cast_nullable_to_non_nullable
              as CreditCurrent,
      recommended: null == recommended
          ? _value.recommended
          : recommended // ignore: cast_nullable_to_non_nullable
              as CreditRecommended,
      riskScore: null == riskScore
          ? _value.riskScore
          : riskScore // ignore: cast_nullable_to_non_nullable
              as double,
      paymentHistory: null == paymentHistory
          ? _value.paymentHistory
          : paymentHistory // ignore: cast_nullable_to_non_nullable
              as PaymentHistory,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CreditCurrentCopyWith<$Res> get current {
    return $CreditCurrentCopyWith<$Res>(_value.current, (value) {
      return _then(_value.copyWith(current: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CreditRecommendedCopyWith<$Res> get recommended {
    return $CreditRecommendedCopyWith<$Res>(_value.recommended, (value) {
      return _then(_value.copyWith(recommended: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PaymentHistoryCopyWith<$Res> get paymentHistory {
    return $PaymentHistoryCopyWith<$Res>(_value.paymentHistory, (value) {
      return _then(_value.copyWith(paymentHistory: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ClientCreditImplCopyWith<$Res>
    implements $ClientCreditCopyWith<$Res> {
  factory _$$ClientCreditImplCopyWith(
          _$ClientCreditImpl value, $Res Function(_$ClientCreditImpl) then) =
      __$$ClientCreditImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String clientId,
      String organizationId,
      String analyzedAt,
      CreditCurrent current,
      CreditRecommended recommended,
      double riskScore,
      PaymentHistory paymentHistory});

  @override
  $CreditCurrentCopyWith<$Res> get current;
  @override
  $CreditRecommendedCopyWith<$Res> get recommended;
  @override
  $PaymentHistoryCopyWith<$Res> get paymentHistory;
}

/// @nodoc
class __$$ClientCreditImplCopyWithImpl<$Res>
    extends _$ClientCreditCopyWithImpl<$Res, _$ClientCreditImpl>
    implements _$$ClientCreditImplCopyWith<$Res> {
  __$$ClientCreditImplCopyWithImpl(
      _$ClientCreditImpl _value, $Res Function(_$ClientCreditImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clientId = null,
    Object? organizationId = null,
    Object? analyzedAt = null,
    Object? current = null,
    Object? recommended = null,
    Object? riskScore = null,
    Object? paymentHistory = null,
  }) {
    return _then(_$ClientCreditImpl(
      clientId: null == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      analyzedAt: null == analyzedAt
          ? _value.analyzedAt
          : analyzedAt // ignore: cast_nullable_to_non_nullable
              as String,
      current: null == current
          ? _value.current
          : current // ignore: cast_nullable_to_non_nullable
              as CreditCurrent,
      recommended: null == recommended
          ? _value.recommended
          : recommended // ignore: cast_nullable_to_non_nullable
              as CreditRecommended,
      riskScore: null == riskScore
          ? _value.riskScore
          : riskScore // ignore: cast_nullable_to_non_nullable
              as double,
      paymentHistory: null == paymentHistory
          ? _value.paymentHistory
          : paymentHistory // ignore: cast_nullable_to_non_nullable
              as PaymentHistory,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ClientCreditImpl implements _ClientCredit {
  const _$ClientCreditImpl(
      {required this.clientId,
      required this.organizationId,
      required this.analyzedAt,
      required this.current,
      required this.recommended,
      required this.riskScore,
      required this.paymentHistory});

  factory _$ClientCreditImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClientCreditImplFromJson(json);

  @override
  final String clientId;
  @override
  final String organizationId;
  @override
  final String analyzedAt;
  @override
  final CreditCurrent current;
  @override
  final CreditRecommended recommended;
  @override
  final double riskScore;
  @override
  final PaymentHistory paymentHistory;

  @override
  String toString() {
    return 'ClientCredit(clientId: $clientId, organizationId: $organizationId, analyzedAt: $analyzedAt, current: $current, recommended: $recommended, riskScore: $riskScore, paymentHistory: $paymentHistory)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClientCreditImpl &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.analyzedAt, analyzedAt) ||
                other.analyzedAt == analyzedAt) &&
            (identical(other.current, current) || other.current == current) &&
            (identical(other.recommended, recommended) ||
                other.recommended == recommended) &&
            (identical(other.riskScore, riskScore) ||
                other.riskScore == riskScore) &&
            (identical(other.paymentHistory, paymentHistory) ||
                other.paymentHistory == paymentHistory));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, clientId, organizationId,
      analyzedAt, current, recommended, riskScore, paymentHistory);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ClientCreditImplCopyWith<_$ClientCreditImpl> get copyWith =>
      __$$ClientCreditImplCopyWithImpl<_$ClientCreditImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClientCreditImplToJson(
      this,
    );
  }
}

abstract class _ClientCredit implements ClientCredit {
  const factory _ClientCredit(
      {required final String clientId,
      required final String organizationId,
      required final String analyzedAt,
      required final CreditCurrent current,
      required final CreditRecommended recommended,
      required final double riskScore,
      required final PaymentHistory paymentHistory}) = _$ClientCreditImpl;

  factory _ClientCredit.fromJson(Map<String, dynamic> json) =
      _$ClientCreditImpl.fromJson;

  @override
  String get clientId;
  @override
  String get organizationId;
  @override
  String get analyzedAt;
  @override
  CreditCurrent get current;
  @override
  CreditRecommended get recommended;
  @override
  double get riskScore;
  @override
  PaymentHistory get paymentHistory;
  @override
  @JsonKey(ignore: true)
  _$$ClientCreditImplCopyWith<_$ClientCreditImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CreditCurrent _$CreditCurrentFromJson(Map<String, dynamic> json) {
  return _CreditCurrent.fromJson(json);
}

/// @nodoc
mixin _$CreditCurrent {
  double get limit => throw _privateConstructorUsedError;
  double get utilized => throw _privateConstructorUsedError;
  double get available => throw _privateConstructorUsedError;
  double get utilizationRate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CreditCurrentCopyWith<CreditCurrent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreditCurrentCopyWith<$Res> {
  factory $CreditCurrentCopyWith(
          CreditCurrent value, $Res Function(CreditCurrent) then) =
      _$CreditCurrentCopyWithImpl<$Res, CreditCurrent>;
  @useResult
  $Res call(
      {double limit,
      double utilized,
      double available,
      double utilizationRate});
}

/// @nodoc
class _$CreditCurrentCopyWithImpl<$Res, $Val extends CreditCurrent>
    implements $CreditCurrentCopyWith<$Res> {
  _$CreditCurrentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? limit = null,
    Object? utilized = null,
    Object? available = null,
    Object? utilizationRate = null,
  }) {
    return _then(_value.copyWith(
      limit: null == limit
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as double,
      utilized: null == utilized
          ? _value.utilized
          : utilized // ignore: cast_nullable_to_non_nullable
              as double,
      available: null == available
          ? _value.available
          : available // ignore: cast_nullable_to_non_nullable
              as double,
      utilizationRate: null == utilizationRate
          ? _value.utilizationRate
          : utilizationRate // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreditCurrentImplCopyWith<$Res>
    implements $CreditCurrentCopyWith<$Res> {
  factory _$$CreditCurrentImplCopyWith(
          _$CreditCurrentImpl value, $Res Function(_$CreditCurrentImpl) then) =
      __$$CreditCurrentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double limit,
      double utilized,
      double available,
      double utilizationRate});
}

/// @nodoc
class __$$CreditCurrentImplCopyWithImpl<$Res>
    extends _$CreditCurrentCopyWithImpl<$Res, _$CreditCurrentImpl>
    implements _$$CreditCurrentImplCopyWith<$Res> {
  __$$CreditCurrentImplCopyWithImpl(
      _$CreditCurrentImpl _value, $Res Function(_$CreditCurrentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? limit = null,
    Object? utilized = null,
    Object? available = null,
    Object? utilizationRate = null,
  }) {
    return _then(_$CreditCurrentImpl(
      limit: null == limit
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as double,
      utilized: null == utilized
          ? _value.utilized
          : utilized // ignore: cast_nullable_to_non_nullable
              as double,
      available: null == available
          ? _value.available
          : available // ignore: cast_nullable_to_non_nullable
              as double,
      utilizationRate: null == utilizationRate
          ? _value.utilizationRate
          : utilizationRate // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CreditCurrentImpl implements _CreditCurrent {
  const _$CreditCurrentImpl(
      {required this.limit,
      required this.utilized,
      required this.available,
      required this.utilizationRate});

  factory _$CreditCurrentImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreditCurrentImplFromJson(json);

  @override
  final double limit;
  @override
  final double utilized;
  @override
  final double available;
  @override
  final double utilizationRate;

  @override
  String toString() {
    return 'CreditCurrent(limit: $limit, utilized: $utilized, available: $available, utilizationRate: $utilizationRate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreditCurrentImpl &&
            (identical(other.limit, limit) || other.limit == limit) &&
            (identical(other.utilized, utilized) ||
                other.utilized == utilized) &&
            (identical(other.available, available) ||
                other.available == available) &&
            (identical(other.utilizationRate, utilizationRate) ||
                other.utilizationRate == utilizationRate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, limit, utilized, available, utilizationRate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CreditCurrentImplCopyWith<_$CreditCurrentImpl> get copyWith =>
      __$$CreditCurrentImplCopyWithImpl<_$CreditCurrentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreditCurrentImplToJson(
      this,
    );
  }
}

abstract class _CreditCurrent implements CreditCurrent {
  const factory _CreditCurrent(
      {required final double limit,
      required final double utilized,
      required final double available,
      required final double utilizationRate}) = _$CreditCurrentImpl;

  factory _CreditCurrent.fromJson(Map<String, dynamic> json) =
      _$CreditCurrentImpl.fromJson;

  @override
  double get limit;
  @override
  double get utilized;
  @override
  double get available;
  @override
  double get utilizationRate;
  @override
  @JsonKey(ignore: true)
  _$$CreditCurrentImplCopyWith<_$CreditCurrentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CreditRecommended _$CreditRecommendedFromJson(Map<String, dynamic> json) {
  return _CreditRecommended.fromJson(json);
}

/// @nodoc
mixin _$CreditRecommended {
  double get limit => throw _privateConstructorUsedError;
  String get reasoning => throw _privateConstructorUsedError;
  double get confidence => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CreditRecommendedCopyWith<CreditRecommended> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreditRecommendedCopyWith<$Res> {
  factory $CreditRecommendedCopyWith(
          CreditRecommended value, $Res Function(CreditRecommended) then) =
      _$CreditRecommendedCopyWithImpl<$Res, CreditRecommended>;
  @useResult
  $Res call({double limit, String reasoning, double confidence});
}

/// @nodoc
class _$CreditRecommendedCopyWithImpl<$Res, $Val extends CreditRecommended>
    implements $CreditRecommendedCopyWith<$Res> {
  _$CreditRecommendedCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? limit = null,
    Object? reasoning = null,
    Object? confidence = null,
  }) {
    return _then(_value.copyWith(
      limit: null == limit
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as double,
      reasoning: null == reasoning
          ? _value.reasoning
          : reasoning // ignore: cast_nullable_to_non_nullable
              as String,
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreditRecommendedImplCopyWith<$Res>
    implements $CreditRecommendedCopyWith<$Res> {
  factory _$$CreditRecommendedImplCopyWith(_$CreditRecommendedImpl value,
          $Res Function(_$CreditRecommendedImpl) then) =
      __$$CreditRecommendedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double limit, String reasoning, double confidence});
}

/// @nodoc
class __$$CreditRecommendedImplCopyWithImpl<$Res>
    extends _$CreditRecommendedCopyWithImpl<$Res, _$CreditRecommendedImpl>
    implements _$$CreditRecommendedImplCopyWith<$Res> {
  __$$CreditRecommendedImplCopyWithImpl(_$CreditRecommendedImpl _value,
      $Res Function(_$CreditRecommendedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? limit = null,
    Object? reasoning = null,
    Object? confidence = null,
  }) {
    return _then(_$CreditRecommendedImpl(
      limit: null == limit
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as double,
      reasoning: null == reasoning
          ? _value.reasoning
          : reasoning // ignore: cast_nullable_to_non_nullable
              as String,
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CreditRecommendedImpl implements _CreditRecommended {
  const _$CreditRecommendedImpl(
      {required this.limit, required this.reasoning, required this.confidence});

  factory _$CreditRecommendedImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreditRecommendedImplFromJson(json);

  @override
  final double limit;
  @override
  final String reasoning;
  @override
  final double confidence;

  @override
  String toString() {
    return 'CreditRecommended(limit: $limit, reasoning: $reasoning, confidence: $confidence)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreditRecommendedImpl &&
            (identical(other.limit, limit) || other.limit == limit) &&
            (identical(other.reasoning, reasoning) ||
                other.reasoning == reasoning) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, limit, reasoning, confidence);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CreditRecommendedImplCopyWith<_$CreditRecommendedImpl> get copyWith =>
      __$$CreditRecommendedImplCopyWithImpl<_$CreditRecommendedImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreditRecommendedImplToJson(
      this,
    );
  }
}

abstract class _CreditRecommended implements CreditRecommended {
  const factory _CreditRecommended(
      {required final double limit,
      required final String reasoning,
      required final double confidence}) = _$CreditRecommendedImpl;

  factory _CreditRecommended.fromJson(Map<String, dynamic> json) =
      _$CreditRecommendedImpl.fromJson;

  @override
  double get limit;
  @override
  String get reasoning;
  @override
  double get confidence;
  @override
  @JsonKey(ignore: true)
  _$$CreditRecommendedImplCopyWith<_$CreditRecommendedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PaymentHistory _$PaymentHistoryFromJson(Map<String, dynamic> json) {
  return _PaymentHistory.fromJson(json);
}

/// @nodoc
mixin _$PaymentHistory {
  int get onTime => throw _privateConstructorUsedError;
  int get late => throw _privateConstructorUsedError;
  int get averageDaysLate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PaymentHistoryCopyWith<PaymentHistory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentHistoryCopyWith<$Res> {
  factory $PaymentHistoryCopyWith(
          PaymentHistory value, $Res Function(PaymentHistory) then) =
      _$PaymentHistoryCopyWithImpl<$Res, PaymentHistory>;
  @useResult
  $Res call({int onTime, int late, int averageDaysLate});
}

/// @nodoc
class _$PaymentHistoryCopyWithImpl<$Res, $Val extends PaymentHistory>
    implements $PaymentHistoryCopyWith<$Res> {
  _$PaymentHistoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? onTime = null,
    Object? late = null,
    Object? averageDaysLate = null,
  }) {
    return _then(_value.copyWith(
      onTime: null == onTime
          ? _value.onTime
          : onTime // ignore: cast_nullable_to_non_nullable
              as int,
      late: null == late
          ? _value.late
          : late // ignore: cast_nullable_to_non_nullable
              as int,
      averageDaysLate: null == averageDaysLate
          ? _value.averageDaysLate
          : averageDaysLate // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PaymentHistoryImplCopyWith<$Res>
    implements $PaymentHistoryCopyWith<$Res> {
  factory _$$PaymentHistoryImplCopyWith(_$PaymentHistoryImpl value,
          $Res Function(_$PaymentHistoryImpl) then) =
      __$$PaymentHistoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int onTime, int late, int averageDaysLate});
}

/// @nodoc
class __$$PaymentHistoryImplCopyWithImpl<$Res>
    extends _$PaymentHistoryCopyWithImpl<$Res, _$PaymentHistoryImpl>
    implements _$$PaymentHistoryImplCopyWith<$Res> {
  __$$PaymentHistoryImplCopyWithImpl(
      _$PaymentHistoryImpl _value, $Res Function(_$PaymentHistoryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? onTime = null,
    Object? late = null,
    Object? averageDaysLate = null,
  }) {
    return _then(_$PaymentHistoryImpl(
      onTime: null == onTime
          ? _value.onTime
          : onTime // ignore: cast_nullable_to_non_nullable
              as int,
      late: null == late
          ? _value.late
          : late // ignore: cast_nullable_to_non_nullable
              as int,
      averageDaysLate: null == averageDaysLate
          ? _value.averageDaysLate
          : averageDaysLate // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PaymentHistoryImpl implements _PaymentHistory {
  const _$PaymentHistoryImpl(
      {required this.onTime,
      required this.late,
      required this.averageDaysLate});

  factory _$PaymentHistoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaymentHistoryImplFromJson(json);

  @override
  final int onTime;
  @override
  final int late;
  @override
  final int averageDaysLate;

  @override
  String toString() {
    return 'PaymentHistory(onTime: $onTime, late: $late, averageDaysLate: $averageDaysLate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentHistoryImpl &&
            (identical(other.onTime, onTime) || other.onTime == onTime) &&
            (identical(other.late, late) || other.late == late) &&
            (identical(other.averageDaysLate, averageDaysLate) ||
                other.averageDaysLate == averageDaysLate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, onTime, late, averageDaysLate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentHistoryImplCopyWith<_$PaymentHistoryImpl> get copyWith =>
      __$$PaymentHistoryImplCopyWithImpl<_$PaymentHistoryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PaymentHistoryImplToJson(
      this,
    );
  }
}

abstract class _PaymentHistory implements PaymentHistory {
  const factory _PaymentHistory(
      {required final int onTime,
      required final int late,
      required final int averageDaysLate}) = _$PaymentHistoryImpl;

  factory _PaymentHistory.fromJson(Map<String, dynamic> json) =
      _$PaymentHistoryImpl.fromJson;

  @override
  int get onTime;
  @override
  int get late;
  @override
  int get averageDaysLate;
  @override
  @JsonKey(ignore: true)
  _$$PaymentHistoryImplCopyWith<_$PaymentHistoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ClientLifetimeValue _$ClientLifetimeValueFromJson(Map<String, dynamic> json) {
  return _ClientLifetimeValue.fromJson(json);
}

/// @nodoc
mixin _$ClientLifetimeValue {
  String get clientId => throw _privateConstructorUsedError;
  String get organizationId => throw _privateConstructorUsedError;
  String get calculatedAt => throw _privateConstructorUsedError;
  CLVCurrent get current => throw _privateConstructorUsedError;
  CLVPredicted get predicted => throw _privateConstructorUsedError;
  String get segments => throw _privateConstructorUsedError;
  List<UpsellOpportunity> get opportunities =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ClientLifetimeValueCopyWith<ClientLifetimeValue> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClientLifetimeValueCopyWith<$Res> {
  factory $ClientLifetimeValueCopyWith(
          ClientLifetimeValue value, $Res Function(ClientLifetimeValue) then) =
      _$ClientLifetimeValueCopyWithImpl<$Res, ClientLifetimeValue>;
  @useResult
  $Res call(
      {String clientId,
      String organizationId,
      String calculatedAt,
      CLVCurrent current,
      CLVPredicted predicted,
      String segments,
      List<UpsellOpportunity> opportunities});

  $CLVCurrentCopyWith<$Res> get current;
  $CLVPredictedCopyWith<$Res> get predicted;
}

/// @nodoc
class _$ClientLifetimeValueCopyWithImpl<$Res, $Val extends ClientLifetimeValue>
    implements $ClientLifetimeValueCopyWith<$Res> {
  _$ClientLifetimeValueCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clientId = null,
    Object? organizationId = null,
    Object? calculatedAt = null,
    Object? current = null,
    Object? predicted = null,
    Object? segments = null,
    Object? opportunities = null,
  }) {
    return _then(_value.copyWith(
      clientId: null == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      calculatedAt: null == calculatedAt
          ? _value.calculatedAt
          : calculatedAt // ignore: cast_nullable_to_non_nullable
              as String,
      current: null == current
          ? _value.current
          : current // ignore: cast_nullable_to_non_nullable
              as CLVCurrent,
      predicted: null == predicted
          ? _value.predicted
          : predicted // ignore: cast_nullable_to_non_nullable
              as CLVPredicted,
      segments: null == segments
          ? _value.segments
          : segments // ignore: cast_nullable_to_non_nullable
              as String,
      opportunities: null == opportunities
          ? _value.opportunities
          : opportunities // ignore: cast_nullable_to_non_nullable
              as List<UpsellOpportunity>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CLVCurrentCopyWith<$Res> get current {
    return $CLVCurrentCopyWith<$Res>(_value.current, (value) {
      return _then(_value.copyWith(current: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CLVPredictedCopyWith<$Res> get predicted {
    return $CLVPredictedCopyWith<$Res>(_value.predicted, (value) {
      return _then(_value.copyWith(predicted: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ClientLifetimeValueImplCopyWith<$Res>
    implements $ClientLifetimeValueCopyWith<$Res> {
  factory _$$ClientLifetimeValueImplCopyWith(_$ClientLifetimeValueImpl value,
          $Res Function(_$ClientLifetimeValueImpl) then) =
      __$$ClientLifetimeValueImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String clientId,
      String organizationId,
      String calculatedAt,
      CLVCurrent current,
      CLVPredicted predicted,
      String segments,
      List<UpsellOpportunity> opportunities});

  @override
  $CLVCurrentCopyWith<$Res> get current;
  @override
  $CLVPredictedCopyWith<$Res> get predicted;
}

/// @nodoc
class __$$ClientLifetimeValueImplCopyWithImpl<$Res>
    extends _$ClientLifetimeValueCopyWithImpl<$Res, _$ClientLifetimeValueImpl>
    implements _$$ClientLifetimeValueImplCopyWith<$Res> {
  __$$ClientLifetimeValueImplCopyWithImpl(_$ClientLifetimeValueImpl _value,
      $Res Function(_$ClientLifetimeValueImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clientId = null,
    Object? organizationId = null,
    Object? calculatedAt = null,
    Object? current = null,
    Object? predicted = null,
    Object? segments = null,
    Object? opportunities = null,
  }) {
    return _then(_$ClientLifetimeValueImpl(
      clientId: null == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      calculatedAt: null == calculatedAt
          ? _value.calculatedAt
          : calculatedAt // ignore: cast_nullable_to_non_nullable
              as String,
      current: null == current
          ? _value.current
          : current // ignore: cast_nullable_to_non_nullable
              as CLVCurrent,
      predicted: null == predicted
          ? _value.predicted
          : predicted // ignore: cast_nullable_to_non_nullable
              as CLVPredicted,
      segments: null == segments
          ? _value.segments
          : segments // ignore: cast_nullable_to_non_nullable
              as String,
      opportunities: null == opportunities
          ? _value._opportunities
          : opportunities // ignore: cast_nullable_to_non_nullable
              as List<UpsellOpportunity>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ClientLifetimeValueImpl implements _ClientLifetimeValue {
  const _$ClientLifetimeValueImpl(
      {required this.clientId,
      required this.organizationId,
      required this.calculatedAt,
      required this.current,
      required this.predicted,
      required this.segments,
      required final List<UpsellOpportunity> opportunities})
      : _opportunities = opportunities;

  factory _$ClientLifetimeValueImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClientLifetimeValueImplFromJson(json);

  @override
  final String clientId;
  @override
  final String organizationId;
  @override
  final String calculatedAt;
  @override
  final CLVCurrent current;
  @override
  final CLVPredicted predicted;
  @override
  final String segments;
  final List<UpsellOpportunity> _opportunities;
  @override
  List<UpsellOpportunity> get opportunities {
    if (_opportunities is EqualUnmodifiableListView) return _opportunities;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_opportunities);
  }

  @override
  String toString() {
    return 'ClientLifetimeValue(clientId: $clientId, organizationId: $organizationId, calculatedAt: $calculatedAt, current: $current, predicted: $predicted, segments: $segments, opportunities: $opportunities)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClientLifetimeValueImpl &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.calculatedAt, calculatedAt) ||
                other.calculatedAt == calculatedAt) &&
            (identical(other.current, current) || other.current == current) &&
            (identical(other.predicted, predicted) ||
                other.predicted == predicted) &&
            (identical(other.segments, segments) ||
                other.segments == segments) &&
            const DeepCollectionEquality()
                .equals(other._opportunities, _opportunities));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      clientId,
      organizationId,
      calculatedAt,
      current,
      predicted,
      segments,
      const DeepCollectionEquality().hash(_opportunities));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ClientLifetimeValueImplCopyWith<_$ClientLifetimeValueImpl> get copyWith =>
      __$$ClientLifetimeValueImplCopyWithImpl<_$ClientLifetimeValueImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClientLifetimeValueImplToJson(
      this,
    );
  }
}

abstract class _ClientLifetimeValue implements ClientLifetimeValue {
  const factory _ClientLifetimeValue(
          {required final String clientId,
          required final String organizationId,
          required final String calculatedAt,
          required final CLVCurrent current,
          required final CLVPredicted predicted,
          required final String segments,
          required final List<UpsellOpportunity> opportunities}) =
      _$ClientLifetimeValueImpl;

  factory _ClientLifetimeValue.fromJson(Map<String, dynamic> json) =
      _$ClientLifetimeValueImpl.fromJson;

  @override
  String get clientId;
  @override
  String get organizationId;
  @override
  String get calculatedAt;
  @override
  CLVCurrent get current;
  @override
  CLVPredicted get predicted;
  @override
  String get segments;
  @override
  List<UpsellOpportunity> get opportunities;
  @override
  @JsonKey(ignore: true)
  _$$ClientLifetimeValueImplCopyWith<_$ClientLifetimeValueImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CLVCurrent _$CLVCurrentFromJson(Map<String, dynamic> json) {
  return _CLVCurrent.fromJson(json);
}

/// @nodoc
mixin _$CLVCurrent {
  double get totalRevenue => throw _privateConstructorUsedError;
  double get totalProfit => throw _privateConstructorUsedError;
  int get tenure => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CLVCurrentCopyWith<CLVCurrent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CLVCurrentCopyWith<$Res> {
  factory $CLVCurrentCopyWith(
          CLVCurrent value, $Res Function(CLVCurrent) then) =
      _$CLVCurrentCopyWithImpl<$Res, CLVCurrent>;
  @useResult
  $Res call({double totalRevenue, double totalProfit, int tenure});
}

/// @nodoc
class _$CLVCurrentCopyWithImpl<$Res, $Val extends CLVCurrent>
    implements $CLVCurrentCopyWith<$Res> {
  _$CLVCurrentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalRevenue = null,
    Object? totalProfit = null,
    Object? tenure = null,
  }) {
    return _then(_value.copyWith(
      totalRevenue: null == totalRevenue
          ? _value.totalRevenue
          : totalRevenue // ignore: cast_nullable_to_non_nullable
              as double,
      totalProfit: null == totalProfit
          ? _value.totalProfit
          : totalProfit // ignore: cast_nullable_to_non_nullable
              as double,
      tenure: null == tenure
          ? _value.tenure
          : tenure // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CLVCurrentImplCopyWith<$Res>
    implements $CLVCurrentCopyWith<$Res> {
  factory _$$CLVCurrentImplCopyWith(
          _$CLVCurrentImpl value, $Res Function(_$CLVCurrentImpl) then) =
      __$$CLVCurrentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double totalRevenue, double totalProfit, int tenure});
}

/// @nodoc
class __$$CLVCurrentImplCopyWithImpl<$Res>
    extends _$CLVCurrentCopyWithImpl<$Res, _$CLVCurrentImpl>
    implements _$$CLVCurrentImplCopyWith<$Res> {
  __$$CLVCurrentImplCopyWithImpl(
      _$CLVCurrentImpl _value, $Res Function(_$CLVCurrentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalRevenue = null,
    Object? totalProfit = null,
    Object? tenure = null,
  }) {
    return _then(_$CLVCurrentImpl(
      totalRevenue: null == totalRevenue
          ? _value.totalRevenue
          : totalRevenue // ignore: cast_nullable_to_non_nullable
              as double,
      totalProfit: null == totalProfit
          ? _value.totalProfit
          : totalProfit // ignore: cast_nullable_to_non_nullable
              as double,
      tenure: null == tenure
          ? _value.tenure
          : tenure // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CLVCurrentImpl implements _CLVCurrent {
  const _$CLVCurrentImpl(
      {required this.totalRevenue,
      required this.totalProfit,
      required this.tenure});

  factory _$CLVCurrentImpl.fromJson(Map<String, dynamic> json) =>
      _$$CLVCurrentImplFromJson(json);

  @override
  final double totalRevenue;
  @override
  final double totalProfit;
  @override
  final int tenure;

  @override
  String toString() {
    return 'CLVCurrent(totalRevenue: $totalRevenue, totalProfit: $totalProfit, tenure: $tenure)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CLVCurrentImpl &&
            (identical(other.totalRevenue, totalRevenue) ||
                other.totalRevenue == totalRevenue) &&
            (identical(other.totalProfit, totalProfit) ||
                other.totalProfit == totalProfit) &&
            (identical(other.tenure, tenure) || other.tenure == tenure));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, totalRevenue, totalProfit, tenure);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CLVCurrentImplCopyWith<_$CLVCurrentImpl> get copyWith =>
      __$$CLVCurrentImplCopyWithImpl<_$CLVCurrentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CLVCurrentImplToJson(
      this,
    );
  }
}

abstract class _CLVCurrent implements CLVCurrent {
  const factory _CLVCurrent(
      {required final double totalRevenue,
      required final double totalProfit,
      required final int tenure}) = _$CLVCurrentImpl;

  factory _CLVCurrent.fromJson(Map<String, dynamic> json) =
      _$CLVCurrentImpl.fromJson;

  @override
  double get totalRevenue;
  @override
  double get totalProfit;
  @override
  int get tenure;
  @override
  @JsonKey(ignore: true)
  _$$CLVCurrentImplCopyWith<_$CLVCurrentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CLVPredicted _$CLVPredictedFromJson(Map<String, dynamic> json) {
  return _CLVPredicted.fromJson(json);
}

/// @nodoc
mixin _$CLVPredicted {
  double get lifetimeValue => throw _privateConstructorUsedError;
  double get remainingValue => throw _privateConstructorUsedError;
  double get churnProbability => throw _privateConstructorUsedError;
  int get expectedTenure => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CLVPredictedCopyWith<CLVPredicted> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CLVPredictedCopyWith<$Res> {
  factory $CLVPredictedCopyWith(
          CLVPredicted value, $Res Function(CLVPredicted) then) =
      _$CLVPredictedCopyWithImpl<$Res, CLVPredicted>;
  @useResult
  $Res call(
      {double lifetimeValue,
      double remainingValue,
      double churnProbability,
      int expectedTenure});
}

/// @nodoc
class _$CLVPredictedCopyWithImpl<$Res, $Val extends CLVPredicted>
    implements $CLVPredictedCopyWith<$Res> {
  _$CLVPredictedCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lifetimeValue = null,
    Object? remainingValue = null,
    Object? churnProbability = null,
    Object? expectedTenure = null,
  }) {
    return _then(_value.copyWith(
      lifetimeValue: null == lifetimeValue
          ? _value.lifetimeValue
          : lifetimeValue // ignore: cast_nullable_to_non_nullable
              as double,
      remainingValue: null == remainingValue
          ? _value.remainingValue
          : remainingValue // ignore: cast_nullable_to_non_nullable
              as double,
      churnProbability: null == churnProbability
          ? _value.churnProbability
          : churnProbability // ignore: cast_nullable_to_non_nullable
              as double,
      expectedTenure: null == expectedTenure
          ? _value.expectedTenure
          : expectedTenure // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CLVPredictedImplCopyWith<$Res>
    implements $CLVPredictedCopyWith<$Res> {
  factory _$$CLVPredictedImplCopyWith(
          _$CLVPredictedImpl value, $Res Function(_$CLVPredictedImpl) then) =
      __$$CLVPredictedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double lifetimeValue,
      double remainingValue,
      double churnProbability,
      int expectedTenure});
}

/// @nodoc
class __$$CLVPredictedImplCopyWithImpl<$Res>
    extends _$CLVPredictedCopyWithImpl<$Res, _$CLVPredictedImpl>
    implements _$$CLVPredictedImplCopyWith<$Res> {
  __$$CLVPredictedImplCopyWithImpl(
      _$CLVPredictedImpl _value, $Res Function(_$CLVPredictedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lifetimeValue = null,
    Object? remainingValue = null,
    Object? churnProbability = null,
    Object? expectedTenure = null,
  }) {
    return _then(_$CLVPredictedImpl(
      lifetimeValue: null == lifetimeValue
          ? _value.lifetimeValue
          : lifetimeValue // ignore: cast_nullable_to_non_nullable
              as double,
      remainingValue: null == remainingValue
          ? _value.remainingValue
          : remainingValue // ignore: cast_nullable_to_non_nullable
              as double,
      churnProbability: null == churnProbability
          ? _value.churnProbability
          : churnProbability // ignore: cast_nullable_to_non_nullable
              as double,
      expectedTenure: null == expectedTenure
          ? _value.expectedTenure
          : expectedTenure // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CLVPredictedImpl implements _CLVPredicted {
  const _$CLVPredictedImpl(
      {required this.lifetimeValue,
      required this.remainingValue,
      required this.churnProbability,
      required this.expectedTenure});

  factory _$CLVPredictedImpl.fromJson(Map<String, dynamic> json) =>
      _$$CLVPredictedImplFromJson(json);

  @override
  final double lifetimeValue;
  @override
  final double remainingValue;
  @override
  final double churnProbability;
  @override
  final int expectedTenure;

  @override
  String toString() {
    return 'CLVPredicted(lifetimeValue: $lifetimeValue, remainingValue: $remainingValue, churnProbability: $churnProbability, expectedTenure: $expectedTenure)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CLVPredictedImpl &&
            (identical(other.lifetimeValue, lifetimeValue) ||
                other.lifetimeValue == lifetimeValue) &&
            (identical(other.remainingValue, remainingValue) ||
                other.remainingValue == remainingValue) &&
            (identical(other.churnProbability, churnProbability) ||
                other.churnProbability == churnProbability) &&
            (identical(other.expectedTenure, expectedTenure) ||
                other.expectedTenure == expectedTenure));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, lifetimeValue, remainingValue,
      churnProbability, expectedTenure);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CLVPredictedImplCopyWith<_$CLVPredictedImpl> get copyWith =>
      __$$CLVPredictedImplCopyWithImpl<_$CLVPredictedImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CLVPredictedImplToJson(
      this,
    );
  }
}

abstract class _CLVPredicted implements CLVPredicted {
  const factory _CLVPredicted(
      {required final double lifetimeValue,
      required final double remainingValue,
      required final double churnProbability,
      required final int expectedTenure}) = _$CLVPredictedImpl;

  factory _CLVPredicted.fromJson(Map<String, dynamic> json) =
      _$CLVPredictedImpl.fromJson;

  @override
  double get lifetimeValue;
  @override
  double get remainingValue;
  @override
  double get churnProbability;
  @override
  int get expectedTenure;
  @override
  @JsonKey(ignore: true)
  _$$CLVPredictedImplCopyWith<_$CLVPredictedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UpsellOpportunity _$UpsellOpportunityFromJson(Map<String, dynamic> json) {
  return _UpsellOpportunity.fromJson(json);
}

/// @nodoc
mixin _$UpsellOpportunity {
  String get opportunity => throw _privateConstructorUsedError;
  double get potential => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UpsellOpportunityCopyWith<UpsellOpportunity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpsellOpportunityCopyWith<$Res> {
  factory $UpsellOpportunityCopyWith(
          UpsellOpportunity value, $Res Function(UpsellOpportunity) then) =
      _$UpsellOpportunityCopyWithImpl<$Res, UpsellOpportunity>;
  @useResult
  $Res call({String opportunity, double potential});
}

/// @nodoc
class _$UpsellOpportunityCopyWithImpl<$Res, $Val extends UpsellOpportunity>
    implements $UpsellOpportunityCopyWith<$Res> {
  _$UpsellOpportunityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? opportunity = null,
    Object? potential = null,
  }) {
    return _then(_value.copyWith(
      opportunity: null == opportunity
          ? _value.opportunity
          : opportunity // ignore: cast_nullable_to_non_nullable
              as String,
      potential: null == potential
          ? _value.potential
          : potential // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UpsellOpportunityImplCopyWith<$Res>
    implements $UpsellOpportunityCopyWith<$Res> {
  factory _$$UpsellOpportunityImplCopyWith(_$UpsellOpportunityImpl value,
          $Res Function(_$UpsellOpportunityImpl) then) =
      __$$UpsellOpportunityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String opportunity, double potential});
}

/// @nodoc
class __$$UpsellOpportunityImplCopyWithImpl<$Res>
    extends _$UpsellOpportunityCopyWithImpl<$Res, _$UpsellOpportunityImpl>
    implements _$$UpsellOpportunityImplCopyWith<$Res> {
  __$$UpsellOpportunityImplCopyWithImpl(_$UpsellOpportunityImpl _value,
      $Res Function(_$UpsellOpportunityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? opportunity = null,
    Object? potential = null,
  }) {
    return _then(_$UpsellOpportunityImpl(
      opportunity: null == opportunity
          ? _value.opportunity
          : opportunity // ignore: cast_nullable_to_non_nullable
              as String,
      potential: null == potential
          ? _value.potential
          : potential // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UpsellOpportunityImpl implements _UpsellOpportunity {
  const _$UpsellOpportunityImpl(
      {required this.opportunity, required this.potential});

  factory _$UpsellOpportunityImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpsellOpportunityImplFromJson(json);

  @override
  final String opportunity;
  @override
  final double potential;

  @override
  String toString() {
    return 'UpsellOpportunity(opportunity: $opportunity, potential: $potential)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpsellOpportunityImpl &&
            (identical(other.opportunity, opportunity) ||
                other.opportunity == opportunity) &&
            (identical(other.potential, potential) ||
                other.potential == potential));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, opportunity, potential);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UpsellOpportunityImplCopyWith<_$UpsellOpportunityImpl> get copyWith =>
      __$$UpsellOpportunityImplCopyWithImpl<_$UpsellOpportunityImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UpsellOpportunityImplToJson(
      this,
    );
  }
}

abstract class _UpsellOpportunity implements UpsellOpportunity {
  const factory _UpsellOpportunity(
      {required final String opportunity,
      required final double potential}) = _$UpsellOpportunityImpl;

  factory _UpsellOpportunity.fromJson(Map<String, dynamic> json) =
      _$UpsellOpportunityImpl.fromJson;

  @override
  String get opportunity;
  @override
  double get potential;
  @override
  @JsonKey(ignore: true)
  _$$UpsellOpportunityImplCopyWith<_$UpsellOpportunityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ExecutiveReport _$ExecutiveReportFromJson(Map<String, dynamic> json) {
  return _ExecutiveReport.fromJson(json);
}

/// @nodoc
mixin _$ExecutiveReport {
  String get organizationId => throw _privateConstructorUsedError;
  String get period => throw _privateConstructorUsedError;
  String get generatedAt => throw _privateConstructorUsedError;
  ProfitAndLoss get profitAndLoss => throw _privateConstructorUsedError;
  BalanceSheet get balanceSheet => throw _privateConstructorUsedError;
  CashFlowStatement get cashFlow => throw _privateConstructorUsedError;
  Map<String, double> get keyMetrics => throw _privateConstructorUsedError;
  List<String> get insights => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ExecutiveReportCopyWith<ExecutiveReport> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExecutiveReportCopyWith<$Res> {
  factory $ExecutiveReportCopyWith(
          ExecutiveReport value, $Res Function(ExecutiveReport) then) =
      _$ExecutiveReportCopyWithImpl<$Res, ExecutiveReport>;
  @useResult
  $Res call(
      {String organizationId,
      String period,
      String generatedAt,
      ProfitAndLoss profitAndLoss,
      BalanceSheet balanceSheet,
      CashFlowStatement cashFlow,
      Map<String, double> keyMetrics,
      List<String> insights});

  $ProfitAndLossCopyWith<$Res> get profitAndLoss;
  $BalanceSheetCopyWith<$Res> get balanceSheet;
  $CashFlowStatementCopyWith<$Res> get cashFlow;
}

/// @nodoc
class _$ExecutiveReportCopyWithImpl<$Res, $Val extends ExecutiveReport>
    implements $ExecutiveReportCopyWith<$Res> {
  _$ExecutiveReportCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? organizationId = null,
    Object? period = null,
    Object? generatedAt = null,
    Object? profitAndLoss = null,
    Object? balanceSheet = null,
    Object? cashFlow = null,
    Object? keyMetrics = null,
    Object? insights = null,
  }) {
    return _then(_value.copyWith(
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      period: null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as String,
      generatedAt: null == generatedAt
          ? _value.generatedAt
          : generatedAt // ignore: cast_nullable_to_non_nullable
              as String,
      profitAndLoss: null == profitAndLoss
          ? _value.profitAndLoss
          : profitAndLoss // ignore: cast_nullable_to_non_nullable
              as ProfitAndLoss,
      balanceSheet: null == balanceSheet
          ? _value.balanceSheet
          : balanceSheet // ignore: cast_nullable_to_non_nullable
              as BalanceSheet,
      cashFlow: null == cashFlow
          ? _value.cashFlow
          : cashFlow // ignore: cast_nullable_to_non_nullable
              as CashFlowStatement,
      keyMetrics: null == keyMetrics
          ? _value.keyMetrics
          : keyMetrics // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      insights: null == insights
          ? _value.insights
          : insights // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ProfitAndLossCopyWith<$Res> get profitAndLoss {
    return $ProfitAndLossCopyWith<$Res>(_value.profitAndLoss, (value) {
      return _then(_value.copyWith(profitAndLoss: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $BalanceSheetCopyWith<$Res> get balanceSheet {
    return $BalanceSheetCopyWith<$Res>(_value.balanceSheet, (value) {
      return _then(_value.copyWith(balanceSheet: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CashFlowStatementCopyWith<$Res> get cashFlow {
    return $CashFlowStatementCopyWith<$Res>(_value.cashFlow, (value) {
      return _then(_value.copyWith(cashFlow: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ExecutiveReportImplCopyWith<$Res>
    implements $ExecutiveReportCopyWith<$Res> {
  factory _$$ExecutiveReportImplCopyWith(_$ExecutiveReportImpl value,
          $Res Function(_$ExecutiveReportImpl) then) =
      __$$ExecutiveReportImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String organizationId,
      String period,
      String generatedAt,
      ProfitAndLoss profitAndLoss,
      BalanceSheet balanceSheet,
      CashFlowStatement cashFlow,
      Map<String, double> keyMetrics,
      List<String> insights});

  @override
  $ProfitAndLossCopyWith<$Res> get profitAndLoss;
  @override
  $BalanceSheetCopyWith<$Res> get balanceSheet;
  @override
  $CashFlowStatementCopyWith<$Res> get cashFlow;
}

/// @nodoc
class __$$ExecutiveReportImplCopyWithImpl<$Res>
    extends _$ExecutiveReportCopyWithImpl<$Res, _$ExecutiveReportImpl>
    implements _$$ExecutiveReportImplCopyWith<$Res> {
  __$$ExecutiveReportImplCopyWithImpl(
      _$ExecutiveReportImpl _value, $Res Function(_$ExecutiveReportImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? organizationId = null,
    Object? period = null,
    Object? generatedAt = null,
    Object? profitAndLoss = null,
    Object? balanceSheet = null,
    Object? cashFlow = null,
    Object? keyMetrics = null,
    Object? insights = null,
  }) {
    return _then(_$ExecutiveReportImpl(
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      period: null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as String,
      generatedAt: null == generatedAt
          ? _value.generatedAt
          : generatedAt // ignore: cast_nullable_to_non_nullable
              as String,
      profitAndLoss: null == profitAndLoss
          ? _value.profitAndLoss
          : profitAndLoss // ignore: cast_nullable_to_non_nullable
              as ProfitAndLoss,
      balanceSheet: null == balanceSheet
          ? _value.balanceSheet
          : balanceSheet // ignore: cast_nullable_to_non_nullable
              as BalanceSheet,
      cashFlow: null == cashFlow
          ? _value.cashFlow
          : cashFlow // ignore: cast_nullable_to_non_nullable
              as CashFlowStatement,
      keyMetrics: null == keyMetrics
          ? _value._keyMetrics
          : keyMetrics // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      insights: null == insights
          ? _value._insights
          : insights // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExecutiveReportImpl implements _ExecutiveReport {
  const _$ExecutiveReportImpl(
      {required this.organizationId,
      required this.period,
      required this.generatedAt,
      required this.profitAndLoss,
      required this.balanceSheet,
      required this.cashFlow,
      required final Map<String, double> keyMetrics,
      required final List<String> insights})
      : _keyMetrics = keyMetrics,
        _insights = insights;

  factory _$ExecutiveReportImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExecutiveReportImplFromJson(json);

  @override
  final String organizationId;
  @override
  final String period;
  @override
  final String generatedAt;
  @override
  final ProfitAndLoss profitAndLoss;
  @override
  final BalanceSheet balanceSheet;
  @override
  final CashFlowStatement cashFlow;
  final Map<String, double> _keyMetrics;
  @override
  Map<String, double> get keyMetrics {
    if (_keyMetrics is EqualUnmodifiableMapView) return _keyMetrics;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_keyMetrics);
  }

  final List<String> _insights;
  @override
  List<String> get insights {
    if (_insights is EqualUnmodifiableListView) return _insights;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_insights);
  }

  @override
  String toString() {
    return 'ExecutiveReport(organizationId: $organizationId, period: $period, generatedAt: $generatedAt, profitAndLoss: $profitAndLoss, balanceSheet: $balanceSheet, cashFlow: $cashFlow, keyMetrics: $keyMetrics, insights: $insights)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExecutiveReportImpl &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.period, period) || other.period == period) &&
            (identical(other.generatedAt, generatedAt) ||
                other.generatedAt == generatedAt) &&
            (identical(other.profitAndLoss, profitAndLoss) ||
                other.profitAndLoss == profitAndLoss) &&
            (identical(other.balanceSheet, balanceSheet) ||
                other.balanceSheet == balanceSheet) &&
            (identical(other.cashFlow, cashFlow) ||
                other.cashFlow == cashFlow) &&
            const DeepCollectionEquality()
                .equals(other._keyMetrics, _keyMetrics) &&
            const DeepCollectionEquality().equals(other._insights, _insights));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      organizationId,
      period,
      generatedAt,
      profitAndLoss,
      balanceSheet,
      cashFlow,
      const DeepCollectionEquality().hash(_keyMetrics),
      const DeepCollectionEquality().hash(_insights));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ExecutiveReportImplCopyWith<_$ExecutiveReportImpl> get copyWith =>
      __$$ExecutiveReportImplCopyWithImpl<_$ExecutiveReportImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExecutiveReportImplToJson(
      this,
    );
  }
}

abstract class _ExecutiveReport implements ExecutiveReport {
  const factory _ExecutiveReport(
      {required final String organizationId,
      required final String period,
      required final String generatedAt,
      required final ProfitAndLoss profitAndLoss,
      required final BalanceSheet balanceSheet,
      required final CashFlowStatement cashFlow,
      required final Map<String, double> keyMetrics,
      required final List<String> insights}) = _$ExecutiveReportImpl;

  factory _ExecutiveReport.fromJson(Map<String, dynamic> json) =
      _$ExecutiveReportImpl.fromJson;

  @override
  String get organizationId;
  @override
  String get period;
  @override
  String get generatedAt;
  @override
  ProfitAndLoss get profitAndLoss;
  @override
  BalanceSheet get balanceSheet;
  @override
  CashFlowStatement get cashFlow;
  @override
  Map<String, double> get keyMetrics;
  @override
  List<String> get insights;
  @override
  @JsonKey(ignore: true)
  _$$ExecutiveReportImplCopyWith<_$ExecutiveReportImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ProfitAndLoss _$ProfitAndLossFromJson(Map<String, dynamic> json) {
  return _ProfitAndLoss.fromJson(json);
}

/// @nodoc
mixin _$ProfitAndLoss {
  double get revenue => throw _privateConstructorUsedError;
  double get costOfSales => throw _privateConstructorUsedError;
  double get grossProfit => throw _privateConstructorUsedError;
  double get operatingExpenses => throw _privateConstructorUsedError;
  double get netProfit => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProfitAndLossCopyWith<ProfitAndLoss> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfitAndLossCopyWith<$Res> {
  factory $ProfitAndLossCopyWith(
          ProfitAndLoss value, $Res Function(ProfitAndLoss) then) =
      _$ProfitAndLossCopyWithImpl<$Res, ProfitAndLoss>;
  @useResult
  $Res call(
      {double revenue,
      double costOfSales,
      double grossProfit,
      double operatingExpenses,
      double netProfit});
}

/// @nodoc
class _$ProfitAndLossCopyWithImpl<$Res, $Val extends ProfitAndLoss>
    implements $ProfitAndLossCopyWith<$Res> {
  _$ProfitAndLossCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? revenue = null,
    Object? costOfSales = null,
    Object? grossProfit = null,
    Object? operatingExpenses = null,
    Object? netProfit = null,
  }) {
    return _then(_value.copyWith(
      revenue: null == revenue
          ? _value.revenue
          : revenue // ignore: cast_nullable_to_non_nullable
              as double,
      costOfSales: null == costOfSales
          ? _value.costOfSales
          : costOfSales // ignore: cast_nullable_to_non_nullable
              as double,
      grossProfit: null == grossProfit
          ? _value.grossProfit
          : grossProfit // ignore: cast_nullable_to_non_nullable
              as double,
      operatingExpenses: null == operatingExpenses
          ? _value.operatingExpenses
          : operatingExpenses // ignore: cast_nullable_to_non_nullable
              as double,
      netProfit: null == netProfit
          ? _value.netProfit
          : netProfit // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProfitAndLossImplCopyWith<$Res>
    implements $ProfitAndLossCopyWith<$Res> {
  factory _$$ProfitAndLossImplCopyWith(
          _$ProfitAndLossImpl value, $Res Function(_$ProfitAndLossImpl) then) =
      __$$ProfitAndLossImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double revenue,
      double costOfSales,
      double grossProfit,
      double operatingExpenses,
      double netProfit});
}

/// @nodoc
class __$$ProfitAndLossImplCopyWithImpl<$Res>
    extends _$ProfitAndLossCopyWithImpl<$Res, _$ProfitAndLossImpl>
    implements _$$ProfitAndLossImplCopyWith<$Res> {
  __$$ProfitAndLossImplCopyWithImpl(
      _$ProfitAndLossImpl _value, $Res Function(_$ProfitAndLossImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? revenue = null,
    Object? costOfSales = null,
    Object? grossProfit = null,
    Object? operatingExpenses = null,
    Object? netProfit = null,
  }) {
    return _then(_$ProfitAndLossImpl(
      revenue: null == revenue
          ? _value.revenue
          : revenue // ignore: cast_nullable_to_non_nullable
              as double,
      costOfSales: null == costOfSales
          ? _value.costOfSales
          : costOfSales // ignore: cast_nullable_to_non_nullable
              as double,
      grossProfit: null == grossProfit
          ? _value.grossProfit
          : grossProfit // ignore: cast_nullable_to_non_nullable
              as double,
      operatingExpenses: null == operatingExpenses
          ? _value.operatingExpenses
          : operatingExpenses // ignore: cast_nullable_to_non_nullable
              as double,
      netProfit: null == netProfit
          ? _value.netProfit
          : netProfit // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProfitAndLossImpl implements _ProfitAndLoss {
  const _$ProfitAndLossImpl(
      {required this.revenue,
      required this.costOfSales,
      required this.grossProfit,
      required this.operatingExpenses,
      required this.netProfit});

  factory _$ProfitAndLossImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProfitAndLossImplFromJson(json);

  @override
  final double revenue;
  @override
  final double costOfSales;
  @override
  final double grossProfit;
  @override
  final double operatingExpenses;
  @override
  final double netProfit;

  @override
  String toString() {
    return 'ProfitAndLoss(revenue: $revenue, costOfSales: $costOfSales, grossProfit: $grossProfit, operatingExpenses: $operatingExpenses, netProfit: $netProfit)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfitAndLossImpl &&
            (identical(other.revenue, revenue) || other.revenue == revenue) &&
            (identical(other.costOfSales, costOfSales) ||
                other.costOfSales == costOfSales) &&
            (identical(other.grossProfit, grossProfit) ||
                other.grossProfit == grossProfit) &&
            (identical(other.operatingExpenses, operatingExpenses) ||
                other.operatingExpenses == operatingExpenses) &&
            (identical(other.netProfit, netProfit) ||
                other.netProfit == netProfit));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, revenue, costOfSales,
      grossProfit, operatingExpenses, netProfit);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfitAndLossImplCopyWith<_$ProfitAndLossImpl> get copyWith =>
      __$$ProfitAndLossImplCopyWithImpl<_$ProfitAndLossImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProfitAndLossImplToJson(
      this,
    );
  }
}

abstract class _ProfitAndLoss implements ProfitAndLoss {
  const factory _ProfitAndLoss(
      {required final double revenue,
      required final double costOfSales,
      required final double grossProfit,
      required final double operatingExpenses,
      required final double netProfit}) = _$ProfitAndLossImpl;

  factory _ProfitAndLoss.fromJson(Map<String, dynamic> json) =
      _$ProfitAndLossImpl.fromJson;

  @override
  double get revenue;
  @override
  double get costOfSales;
  @override
  double get grossProfit;
  @override
  double get operatingExpenses;
  @override
  double get netProfit;
  @override
  @JsonKey(ignore: true)
  _$$ProfitAndLossImplCopyWith<_$ProfitAndLossImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BalanceSheet _$BalanceSheetFromJson(Map<String, dynamic> json) {
  return _BalanceSheet.fromJson(json);
}

/// @nodoc
mixin _$BalanceSheet {
  BalanceSheetAssets get assets => throw _privateConstructorUsedError;
  BalanceSheetLiabilities get liabilities => throw _privateConstructorUsedError;
  double get equity => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BalanceSheetCopyWith<BalanceSheet> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BalanceSheetCopyWith<$Res> {
  factory $BalanceSheetCopyWith(
          BalanceSheet value, $Res Function(BalanceSheet) then) =
      _$BalanceSheetCopyWithImpl<$Res, BalanceSheet>;
  @useResult
  $Res call(
      {BalanceSheetAssets assets,
      BalanceSheetLiabilities liabilities,
      double equity});

  $BalanceSheetAssetsCopyWith<$Res> get assets;
  $BalanceSheetLiabilitiesCopyWith<$Res> get liabilities;
}

/// @nodoc
class _$BalanceSheetCopyWithImpl<$Res, $Val extends BalanceSheet>
    implements $BalanceSheetCopyWith<$Res> {
  _$BalanceSheetCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? assets = null,
    Object? liabilities = null,
    Object? equity = null,
  }) {
    return _then(_value.copyWith(
      assets: null == assets
          ? _value.assets
          : assets // ignore: cast_nullable_to_non_nullable
              as BalanceSheetAssets,
      liabilities: null == liabilities
          ? _value.liabilities
          : liabilities // ignore: cast_nullable_to_non_nullable
              as BalanceSheetLiabilities,
      equity: null == equity
          ? _value.equity
          : equity // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $BalanceSheetAssetsCopyWith<$Res> get assets {
    return $BalanceSheetAssetsCopyWith<$Res>(_value.assets, (value) {
      return _then(_value.copyWith(assets: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $BalanceSheetLiabilitiesCopyWith<$Res> get liabilities {
    return $BalanceSheetLiabilitiesCopyWith<$Res>(_value.liabilities, (value) {
      return _then(_value.copyWith(liabilities: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BalanceSheetImplCopyWith<$Res>
    implements $BalanceSheetCopyWith<$Res> {
  factory _$$BalanceSheetImplCopyWith(
          _$BalanceSheetImpl value, $Res Function(_$BalanceSheetImpl) then) =
      __$$BalanceSheetImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {BalanceSheetAssets assets,
      BalanceSheetLiabilities liabilities,
      double equity});

  @override
  $BalanceSheetAssetsCopyWith<$Res> get assets;
  @override
  $BalanceSheetLiabilitiesCopyWith<$Res> get liabilities;
}

/// @nodoc
class __$$BalanceSheetImplCopyWithImpl<$Res>
    extends _$BalanceSheetCopyWithImpl<$Res, _$BalanceSheetImpl>
    implements _$$BalanceSheetImplCopyWith<$Res> {
  __$$BalanceSheetImplCopyWithImpl(
      _$BalanceSheetImpl _value, $Res Function(_$BalanceSheetImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? assets = null,
    Object? liabilities = null,
    Object? equity = null,
  }) {
    return _then(_$BalanceSheetImpl(
      assets: null == assets
          ? _value.assets
          : assets // ignore: cast_nullable_to_non_nullable
              as BalanceSheetAssets,
      liabilities: null == liabilities
          ? _value.liabilities
          : liabilities // ignore: cast_nullable_to_non_nullable
              as BalanceSheetLiabilities,
      equity: null == equity
          ? _value.equity
          : equity // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BalanceSheetImpl implements _BalanceSheet {
  const _$BalanceSheetImpl(
      {required this.assets, required this.liabilities, required this.equity});

  factory _$BalanceSheetImpl.fromJson(Map<String, dynamic> json) =>
      _$$BalanceSheetImplFromJson(json);

  @override
  final BalanceSheetAssets assets;
  @override
  final BalanceSheetLiabilities liabilities;
  @override
  final double equity;

  @override
  String toString() {
    return 'BalanceSheet(assets: $assets, liabilities: $liabilities, equity: $equity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BalanceSheetImpl &&
            (identical(other.assets, assets) || other.assets == assets) &&
            (identical(other.liabilities, liabilities) ||
                other.liabilities == liabilities) &&
            (identical(other.equity, equity) || other.equity == equity));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, assets, liabilities, equity);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BalanceSheetImplCopyWith<_$BalanceSheetImpl> get copyWith =>
      __$$BalanceSheetImplCopyWithImpl<_$BalanceSheetImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BalanceSheetImplToJson(
      this,
    );
  }
}

abstract class _BalanceSheet implements BalanceSheet {
  const factory _BalanceSheet(
      {required final BalanceSheetAssets assets,
      required final BalanceSheetLiabilities liabilities,
      required final double equity}) = _$BalanceSheetImpl;

  factory _BalanceSheet.fromJson(Map<String, dynamic> json) =
      _$BalanceSheetImpl.fromJson;

  @override
  BalanceSheetAssets get assets;
  @override
  BalanceSheetLiabilities get liabilities;
  @override
  double get equity;
  @override
  @JsonKey(ignore: true)
  _$$BalanceSheetImplCopyWith<_$BalanceSheetImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BalanceSheetAssets _$BalanceSheetAssetsFromJson(Map<String, dynamic> json) {
  return _BalanceSheetAssets.fromJson(json);
}

/// @nodoc
mixin _$BalanceSheetAssets {
  double get current => throw _privateConstructorUsedError;
  double get fixed => throw _privateConstructorUsedError;
  double get total => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BalanceSheetAssetsCopyWith<BalanceSheetAssets> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BalanceSheetAssetsCopyWith<$Res> {
  factory $BalanceSheetAssetsCopyWith(
          BalanceSheetAssets value, $Res Function(BalanceSheetAssets) then) =
      _$BalanceSheetAssetsCopyWithImpl<$Res, BalanceSheetAssets>;
  @useResult
  $Res call({double current, double fixed, double total});
}

/// @nodoc
class _$BalanceSheetAssetsCopyWithImpl<$Res, $Val extends BalanceSheetAssets>
    implements $BalanceSheetAssetsCopyWith<$Res> {
  _$BalanceSheetAssetsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? current = null,
    Object? fixed = null,
    Object? total = null,
  }) {
    return _then(_value.copyWith(
      current: null == current
          ? _value.current
          : current // ignore: cast_nullable_to_non_nullable
              as double,
      fixed: null == fixed
          ? _value.fixed
          : fixed // ignore: cast_nullable_to_non_nullable
              as double,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BalanceSheetAssetsImplCopyWith<$Res>
    implements $BalanceSheetAssetsCopyWith<$Res> {
  factory _$$BalanceSheetAssetsImplCopyWith(_$BalanceSheetAssetsImpl value,
          $Res Function(_$BalanceSheetAssetsImpl) then) =
      __$$BalanceSheetAssetsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double current, double fixed, double total});
}

/// @nodoc
class __$$BalanceSheetAssetsImplCopyWithImpl<$Res>
    extends _$BalanceSheetAssetsCopyWithImpl<$Res, _$BalanceSheetAssetsImpl>
    implements _$$BalanceSheetAssetsImplCopyWith<$Res> {
  __$$BalanceSheetAssetsImplCopyWithImpl(_$BalanceSheetAssetsImpl _value,
      $Res Function(_$BalanceSheetAssetsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? current = null,
    Object? fixed = null,
    Object? total = null,
  }) {
    return _then(_$BalanceSheetAssetsImpl(
      current: null == current
          ? _value.current
          : current // ignore: cast_nullable_to_non_nullable
              as double,
      fixed: null == fixed
          ? _value.fixed
          : fixed // ignore: cast_nullable_to_non_nullable
              as double,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BalanceSheetAssetsImpl implements _BalanceSheetAssets {
  const _$BalanceSheetAssetsImpl(
      {required this.current, required this.fixed, required this.total});

  factory _$BalanceSheetAssetsImpl.fromJson(Map<String, dynamic> json) =>
      _$$BalanceSheetAssetsImplFromJson(json);

  @override
  final double current;
  @override
  final double fixed;
  @override
  final double total;

  @override
  String toString() {
    return 'BalanceSheetAssets(current: $current, fixed: $fixed, total: $total)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BalanceSheetAssetsImpl &&
            (identical(other.current, current) || other.current == current) &&
            (identical(other.fixed, fixed) || other.fixed == fixed) &&
            (identical(other.total, total) || other.total == total));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, current, fixed, total);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BalanceSheetAssetsImplCopyWith<_$BalanceSheetAssetsImpl> get copyWith =>
      __$$BalanceSheetAssetsImplCopyWithImpl<_$BalanceSheetAssetsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BalanceSheetAssetsImplToJson(
      this,
    );
  }
}

abstract class _BalanceSheetAssets implements BalanceSheetAssets {
  const factory _BalanceSheetAssets(
      {required final double current,
      required final double fixed,
      required final double total}) = _$BalanceSheetAssetsImpl;

  factory _BalanceSheetAssets.fromJson(Map<String, dynamic> json) =
      _$BalanceSheetAssetsImpl.fromJson;

  @override
  double get current;
  @override
  double get fixed;
  @override
  double get total;
  @override
  @JsonKey(ignore: true)
  _$$BalanceSheetAssetsImplCopyWith<_$BalanceSheetAssetsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BalanceSheetLiabilities _$BalanceSheetLiabilitiesFromJson(
    Map<String, dynamic> json) {
  return _BalanceSheetLiabilities.fromJson(json);
}

/// @nodoc
mixin _$BalanceSheetLiabilities {
  double get current => throw _privateConstructorUsedError;
  double get longTerm => throw _privateConstructorUsedError;
  double get total => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BalanceSheetLiabilitiesCopyWith<BalanceSheetLiabilities> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BalanceSheetLiabilitiesCopyWith<$Res> {
  factory $BalanceSheetLiabilitiesCopyWith(BalanceSheetLiabilities value,
          $Res Function(BalanceSheetLiabilities) then) =
      _$BalanceSheetLiabilitiesCopyWithImpl<$Res, BalanceSheetLiabilities>;
  @useResult
  $Res call({double current, double longTerm, double total});
}

/// @nodoc
class _$BalanceSheetLiabilitiesCopyWithImpl<$Res,
        $Val extends BalanceSheetLiabilities>
    implements $BalanceSheetLiabilitiesCopyWith<$Res> {
  _$BalanceSheetLiabilitiesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? current = null,
    Object? longTerm = null,
    Object? total = null,
  }) {
    return _then(_value.copyWith(
      current: null == current
          ? _value.current
          : current // ignore: cast_nullable_to_non_nullable
              as double,
      longTerm: null == longTerm
          ? _value.longTerm
          : longTerm // ignore: cast_nullable_to_non_nullable
              as double,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BalanceSheetLiabilitiesImplCopyWith<$Res>
    implements $BalanceSheetLiabilitiesCopyWith<$Res> {
  factory _$$BalanceSheetLiabilitiesImplCopyWith(
          _$BalanceSheetLiabilitiesImpl value,
          $Res Function(_$BalanceSheetLiabilitiesImpl) then) =
      __$$BalanceSheetLiabilitiesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double current, double longTerm, double total});
}

/// @nodoc
class __$$BalanceSheetLiabilitiesImplCopyWithImpl<$Res>
    extends _$BalanceSheetLiabilitiesCopyWithImpl<$Res,
        _$BalanceSheetLiabilitiesImpl>
    implements _$$BalanceSheetLiabilitiesImplCopyWith<$Res> {
  __$$BalanceSheetLiabilitiesImplCopyWithImpl(
      _$BalanceSheetLiabilitiesImpl _value,
      $Res Function(_$BalanceSheetLiabilitiesImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? current = null,
    Object? longTerm = null,
    Object? total = null,
  }) {
    return _then(_$BalanceSheetLiabilitiesImpl(
      current: null == current
          ? _value.current
          : current // ignore: cast_nullable_to_non_nullable
              as double,
      longTerm: null == longTerm
          ? _value.longTerm
          : longTerm // ignore: cast_nullable_to_non_nullable
              as double,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BalanceSheetLiabilitiesImpl implements _BalanceSheetLiabilities {
  const _$BalanceSheetLiabilitiesImpl(
      {required this.current, required this.longTerm, required this.total});

  factory _$BalanceSheetLiabilitiesImpl.fromJson(Map<String, dynamic> json) =>
      _$$BalanceSheetLiabilitiesImplFromJson(json);

  @override
  final double current;
  @override
  final double longTerm;
  @override
  final double total;

  @override
  String toString() {
    return 'BalanceSheetLiabilities(current: $current, longTerm: $longTerm, total: $total)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BalanceSheetLiabilitiesImpl &&
            (identical(other.current, current) || other.current == current) &&
            (identical(other.longTerm, longTerm) ||
                other.longTerm == longTerm) &&
            (identical(other.total, total) || other.total == total));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, current, longTerm, total);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BalanceSheetLiabilitiesImplCopyWith<_$BalanceSheetLiabilitiesImpl>
      get copyWith => __$$BalanceSheetLiabilitiesImplCopyWithImpl<
          _$BalanceSheetLiabilitiesImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BalanceSheetLiabilitiesImplToJson(
      this,
    );
  }
}

abstract class _BalanceSheetLiabilities implements BalanceSheetLiabilities {
  const factory _BalanceSheetLiabilities(
      {required final double current,
      required final double longTerm,
      required final double total}) = _$BalanceSheetLiabilitiesImpl;

  factory _BalanceSheetLiabilities.fromJson(Map<String, dynamic> json) =
      _$BalanceSheetLiabilitiesImpl.fromJson;

  @override
  double get current;
  @override
  double get longTerm;
  @override
  double get total;
  @override
  @JsonKey(ignore: true)
  _$$BalanceSheetLiabilitiesImplCopyWith<_$BalanceSheetLiabilitiesImpl>
      get copyWith => throw _privateConstructorUsedError;
}

CashFlowStatement _$CashFlowStatementFromJson(Map<String, dynamic> json) {
  return _CashFlowStatement.fromJson(json);
}

/// @nodoc
mixin _$CashFlowStatement {
  double get operating => throw _privateConstructorUsedError;
  double get investing => throw _privateConstructorUsedError;
  double get financing => throw _privateConstructorUsedError;
  double get netChange => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CashFlowStatementCopyWith<CashFlowStatement> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CashFlowStatementCopyWith<$Res> {
  factory $CashFlowStatementCopyWith(
          CashFlowStatement value, $Res Function(CashFlowStatement) then) =
      _$CashFlowStatementCopyWithImpl<$Res, CashFlowStatement>;
  @useResult
  $Res call(
      {double operating, double investing, double financing, double netChange});
}

/// @nodoc
class _$CashFlowStatementCopyWithImpl<$Res, $Val extends CashFlowStatement>
    implements $CashFlowStatementCopyWith<$Res> {
  _$CashFlowStatementCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? operating = null,
    Object? investing = null,
    Object? financing = null,
    Object? netChange = null,
  }) {
    return _then(_value.copyWith(
      operating: null == operating
          ? _value.operating
          : operating // ignore: cast_nullable_to_non_nullable
              as double,
      investing: null == investing
          ? _value.investing
          : investing // ignore: cast_nullable_to_non_nullable
              as double,
      financing: null == financing
          ? _value.financing
          : financing // ignore: cast_nullable_to_non_nullable
              as double,
      netChange: null == netChange
          ? _value.netChange
          : netChange // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CashFlowStatementImplCopyWith<$Res>
    implements $CashFlowStatementCopyWith<$Res> {
  factory _$$CashFlowStatementImplCopyWith(_$CashFlowStatementImpl value,
          $Res Function(_$CashFlowStatementImpl) then) =
      __$$CashFlowStatementImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double operating, double investing, double financing, double netChange});
}

/// @nodoc
class __$$CashFlowStatementImplCopyWithImpl<$Res>
    extends _$CashFlowStatementCopyWithImpl<$Res, _$CashFlowStatementImpl>
    implements _$$CashFlowStatementImplCopyWith<$Res> {
  __$$CashFlowStatementImplCopyWithImpl(_$CashFlowStatementImpl _value,
      $Res Function(_$CashFlowStatementImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? operating = null,
    Object? investing = null,
    Object? financing = null,
    Object? netChange = null,
  }) {
    return _then(_$CashFlowStatementImpl(
      operating: null == operating
          ? _value.operating
          : operating // ignore: cast_nullable_to_non_nullable
              as double,
      investing: null == investing
          ? _value.investing
          : investing // ignore: cast_nullable_to_non_nullable
              as double,
      financing: null == financing
          ? _value.financing
          : financing // ignore: cast_nullable_to_non_nullable
              as double,
      netChange: null == netChange
          ? _value.netChange
          : netChange // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CashFlowStatementImpl implements _CashFlowStatement {
  const _$CashFlowStatementImpl(
      {required this.operating,
      required this.investing,
      required this.financing,
      required this.netChange});

  factory _$CashFlowStatementImpl.fromJson(Map<String, dynamic> json) =>
      _$$CashFlowStatementImplFromJson(json);

  @override
  final double operating;
  @override
  final double investing;
  @override
  final double financing;
  @override
  final double netChange;

  @override
  String toString() {
    return 'CashFlowStatement(operating: $operating, investing: $investing, financing: $financing, netChange: $netChange)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CashFlowStatementImpl &&
            (identical(other.operating, operating) ||
                other.operating == operating) &&
            (identical(other.investing, investing) ||
                other.investing == investing) &&
            (identical(other.financing, financing) ||
                other.financing == financing) &&
            (identical(other.netChange, netChange) ||
                other.netChange == netChange));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, operating, investing, financing, netChange);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CashFlowStatementImplCopyWith<_$CashFlowStatementImpl> get copyWith =>
      __$$CashFlowStatementImplCopyWithImpl<_$CashFlowStatementImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CashFlowStatementImplToJson(
      this,
    );
  }
}

abstract class _CashFlowStatement implements CashFlowStatement {
  const factory _CashFlowStatement(
      {required final double operating,
      required final double investing,
      required final double financing,
      required final double netChange}) = _$CashFlowStatementImpl;

  factory _CashFlowStatement.fromJson(Map<String, dynamic> json) =
      _$CashFlowStatementImpl.fromJson;

  @override
  double get operating;
  @override
  double get investing;
  @override
  double get financing;
  @override
  double get netChange;
  @override
  @JsonKey(ignore: true)
  _$$CashFlowStatementImplCopyWith<_$CashFlowStatementImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
