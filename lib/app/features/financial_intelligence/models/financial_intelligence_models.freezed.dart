// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'financial_intelligence_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RevenueForecast {

 String get organizationId; String get generatedAt; int get horizon; String get model; double get accuracy; List<DailyPrediction> get predictions; ConfidenceIntervals? get confidenceIntervals; ForecastScenarios? get scenarios; ForecastMetrics get metrics; List<String> get insights;
/// Create a copy of RevenueForecast
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RevenueForecastCopyWith<RevenueForecast> get copyWith => _$RevenueForecastCopyWithImpl<RevenueForecast>(this as RevenueForecast, _$identity);

  /// Serializes this RevenueForecast to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RevenueForecast&&(identical(other.organizationId, organizationId) || other.organizationId == organizationId)&&(identical(other.generatedAt, generatedAt) || other.generatedAt == generatedAt)&&(identical(other.horizon, horizon) || other.horizon == horizon)&&(identical(other.model, model) || other.model == model)&&(identical(other.accuracy, accuracy) || other.accuracy == accuracy)&&const DeepCollectionEquality().equals(other.predictions, predictions)&&(identical(other.confidenceIntervals, confidenceIntervals) || other.confidenceIntervals == confidenceIntervals)&&(identical(other.scenarios, scenarios) || other.scenarios == scenarios)&&(identical(other.metrics, metrics) || other.metrics == metrics)&&const DeepCollectionEquality().equals(other.insights, insights));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,organizationId,generatedAt,horizon,model,accuracy,const DeepCollectionEquality().hash(predictions),confidenceIntervals,scenarios,metrics,const DeepCollectionEquality().hash(insights));

@override
String toString() {
  return 'RevenueForecast(organizationId: $organizationId, generatedAt: $generatedAt, horizon: $horizon, model: $model, accuracy: $accuracy, predictions: $predictions, confidenceIntervals: $confidenceIntervals, scenarios: $scenarios, metrics: $metrics, insights: $insights)';
}


}

/// @nodoc
abstract mixin class $RevenueForecastCopyWith<$Res>  {
  factory $RevenueForecastCopyWith(RevenueForecast value, $Res Function(RevenueForecast) _then) = _$RevenueForecastCopyWithImpl;
@useResult
$Res call({
 String organizationId, String generatedAt, int horizon, String model, double accuracy, List<DailyPrediction> predictions, ConfidenceIntervals? confidenceIntervals, ForecastScenarios? scenarios, ForecastMetrics metrics, List<String> insights
});


$ConfidenceIntervalsCopyWith<$Res>? get confidenceIntervals;$ForecastScenariosCopyWith<$Res>? get scenarios;$ForecastMetricsCopyWith<$Res> get metrics;

}
/// @nodoc
class _$RevenueForecastCopyWithImpl<$Res>
    implements $RevenueForecastCopyWith<$Res> {
  _$RevenueForecastCopyWithImpl(this._self, this._then);

  final RevenueForecast _self;
  final $Res Function(RevenueForecast) _then;

/// Create a copy of RevenueForecast
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? organizationId = null,Object? generatedAt = null,Object? horizon = null,Object? model = null,Object? accuracy = null,Object? predictions = null,Object? confidenceIntervals = freezed,Object? scenarios = freezed,Object? metrics = null,Object? insights = null,}) {
  return _then(_self.copyWith(
organizationId: null == organizationId ? _self.organizationId : organizationId // ignore: cast_nullable_to_non_nullable
as String,generatedAt: null == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as String,horizon: null == horizon ? _self.horizon : horizon // ignore: cast_nullable_to_non_nullable
as int,model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String,accuracy: null == accuracy ? _self.accuracy : accuracy // ignore: cast_nullable_to_non_nullable
as double,predictions: null == predictions ? _self.predictions : predictions // ignore: cast_nullable_to_non_nullable
as List<DailyPrediction>,confidenceIntervals: freezed == confidenceIntervals ? _self.confidenceIntervals : confidenceIntervals // ignore: cast_nullable_to_non_nullable
as ConfidenceIntervals?,scenarios: freezed == scenarios ? _self.scenarios : scenarios // ignore: cast_nullable_to_non_nullable
as ForecastScenarios?,metrics: null == metrics ? _self.metrics : metrics // ignore: cast_nullable_to_non_nullable
as ForecastMetrics,insights: null == insights ? _self.insights : insights // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}
/// Create a copy of RevenueForecast
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ConfidenceIntervalsCopyWith<$Res>? get confidenceIntervals {
    if (_self.confidenceIntervals == null) {
    return null;
  }

  return $ConfidenceIntervalsCopyWith<$Res>(_self.confidenceIntervals!, (value) {
    return _then(_self.copyWith(confidenceIntervals: value));
  });
}/// Create a copy of RevenueForecast
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ForecastScenariosCopyWith<$Res>? get scenarios {
    if (_self.scenarios == null) {
    return null;
  }

  return $ForecastScenariosCopyWith<$Res>(_self.scenarios!, (value) {
    return _then(_self.copyWith(scenarios: value));
  });
}/// Create a copy of RevenueForecast
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ForecastMetricsCopyWith<$Res> get metrics {
  
  return $ForecastMetricsCopyWith<$Res>(_self.metrics, (value) {
    return _then(_self.copyWith(metrics: value));
  });
}
}


/// Adds pattern-matching-related methods to [RevenueForecast].
extension RevenueForecastPatterns on RevenueForecast {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RevenueForecast value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RevenueForecast() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RevenueForecast value)  $default,){
final _that = this;
switch (_that) {
case _RevenueForecast():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RevenueForecast value)?  $default,){
final _that = this;
switch (_that) {
case _RevenueForecast() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String organizationId,  String generatedAt,  int horizon,  String model,  double accuracy,  List<DailyPrediction> predictions,  ConfidenceIntervals? confidenceIntervals,  ForecastScenarios? scenarios,  ForecastMetrics metrics,  List<String> insights)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RevenueForecast() when $default != null:
return $default(_that.organizationId,_that.generatedAt,_that.horizon,_that.model,_that.accuracy,_that.predictions,_that.confidenceIntervals,_that.scenarios,_that.metrics,_that.insights);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String organizationId,  String generatedAt,  int horizon,  String model,  double accuracy,  List<DailyPrediction> predictions,  ConfidenceIntervals? confidenceIntervals,  ForecastScenarios? scenarios,  ForecastMetrics metrics,  List<String> insights)  $default,) {final _that = this;
switch (_that) {
case _RevenueForecast():
return $default(_that.organizationId,_that.generatedAt,_that.horizon,_that.model,_that.accuracy,_that.predictions,_that.confidenceIntervals,_that.scenarios,_that.metrics,_that.insights);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String organizationId,  String generatedAt,  int horizon,  String model,  double accuracy,  List<DailyPrediction> predictions,  ConfidenceIntervals? confidenceIntervals,  ForecastScenarios? scenarios,  ForecastMetrics metrics,  List<String> insights)?  $default,) {final _that = this;
switch (_that) {
case _RevenueForecast() when $default != null:
return $default(_that.organizationId,_that.generatedAt,_that.horizon,_that.model,_that.accuracy,_that.predictions,_that.confidenceIntervals,_that.scenarios,_that.metrics,_that.insights);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RevenueForecast implements RevenueForecast {
  const _RevenueForecast({required this.organizationId, required this.generatedAt, required this.horizon, required this.model, required this.accuracy, required final  List<DailyPrediction> predictions, this.confidenceIntervals, this.scenarios, required this.metrics, required final  List<String> insights}): _predictions = predictions,_insights = insights;
  factory _RevenueForecast.fromJson(Map<String, dynamic> json) => _$RevenueForecastFromJson(json);

@override final  String organizationId;
@override final  String generatedAt;
@override final  int horizon;
@override final  String model;
@override final  double accuracy;
 final  List<DailyPrediction> _predictions;
@override List<DailyPrediction> get predictions {
  if (_predictions is EqualUnmodifiableListView) return _predictions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_predictions);
}

@override final  ConfidenceIntervals? confidenceIntervals;
@override final  ForecastScenarios? scenarios;
@override final  ForecastMetrics metrics;
 final  List<String> _insights;
@override List<String> get insights {
  if (_insights is EqualUnmodifiableListView) return _insights;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_insights);
}


/// Create a copy of RevenueForecast
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RevenueForecastCopyWith<_RevenueForecast> get copyWith => __$RevenueForecastCopyWithImpl<_RevenueForecast>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RevenueForecastToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RevenueForecast&&(identical(other.organizationId, organizationId) || other.organizationId == organizationId)&&(identical(other.generatedAt, generatedAt) || other.generatedAt == generatedAt)&&(identical(other.horizon, horizon) || other.horizon == horizon)&&(identical(other.model, model) || other.model == model)&&(identical(other.accuracy, accuracy) || other.accuracy == accuracy)&&const DeepCollectionEquality().equals(other._predictions, _predictions)&&(identical(other.confidenceIntervals, confidenceIntervals) || other.confidenceIntervals == confidenceIntervals)&&(identical(other.scenarios, scenarios) || other.scenarios == scenarios)&&(identical(other.metrics, metrics) || other.metrics == metrics)&&const DeepCollectionEquality().equals(other._insights, _insights));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,organizationId,generatedAt,horizon,model,accuracy,const DeepCollectionEquality().hash(_predictions),confidenceIntervals,scenarios,metrics,const DeepCollectionEquality().hash(_insights));

@override
String toString() {
  return 'RevenueForecast(organizationId: $organizationId, generatedAt: $generatedAt, horizon: $horizon, model: $model, accuracy: $accuracy, predictions: $predictions, confidenceIntervals: $confidenceIntervals, scenarios: $scenarios, metrics: $metrics, insights: $insights)';
}


}

/// @nodoc
abstract mixin class _$RevenueForecastCopyWith<$Res> implements $RevenueForecastCopyWith<$Res> {
  factory _$RevenueForecastCopyWith(_RevenueForecast value, $Res Function(_RevenueForecast) _then) = __$RevenueForecastCopyWithImpl;
@override @useResult
$Res call({
 String organizationId, String generatedAt, int horizon, String model, double accuracy, List<DailyPrediction> predictions, ConfidenceIntervals? confidenceIntervals, ForecastScenarios? scenarios, ForecastMetrics metrics, List<String> insights
});


@override $ConfidenceIntervalsCopyWith<$Res>? get confidenceIntervals;@override $ForecastScenariosCopyWith<$Res>? get scenarios;@override $ForecastMetricsCopyWith<$Res> get metrics;

}
/// @nodoc
class __$RevenueForecastCopyWithImpl<$Res>
    implements _$RevenueForecastCopyWith<$Res> {
  __$RevenueForecastCopyWithImpl(this._self, this._then);

  final _RevenueForecast _self;
  final $Res Function(_RevenueForecast) _then;

/// Create a copy of RevenueForecast
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? organizationId = null,Object? generatedAt = null,Object? horizon = null,Object? model = null,Object? accuracy = null,Object? predictions = null,Object? confidenceIntervals = freezed,Object? scenarios = freezed,Object? metrics = null,Object? insights = null,}) {
  return _then(_RevenueForecast(
organizationId: null == organizationId ? _self.organizationId : organizationId // ignore: cast_nullable_to_non_nullable
as String,generatedAt: null == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as String,horizon: null == horizon ? _self.horizon : horizon // ignore: cast_nullable_to_non_nullable
as int,model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String,accuracy: null == accuracy ? _self.accuracy : accuracy // ignore: cast_nullable_to_non_nullable
as double,predictions: null == predictions ? _self._predictions : predictions // ignore: cast_nullable_to_non_nullable
as List<DailyPrediction>,confidenceIntervals: freezed == confidenceIntervals ? _self.confidenceIntervals : confidenceIntervals // ignore: cast_nullable_to_non_nullable
as ConfidenceIntervals?,scenarios: freezed == scenarios ? _self.scenarios : scenarios // ignore: cast_nullable_to_non_nullable
as ForecastScenarios?,metrics: null == metrics ? _self.metrics : metrics // ignore: cast_nullable_to_non_nullable
as ForecastMetrics,insights: null == insights ? _self._insights : insights // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

/// Create a copy of RevenueForecast
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ConfidenceIntervalsCopyWith<$Res>? get confidenceIntervals {
    if (_self.confidenceIntervals == null) {
    return null;
  }

  return $ConfidenceIntervalsCopyWith<$Res>(_self.confidenceIntervals!, (value) {
    return _then(_self.copyWith(confidenceIntervals: value));
  });
}/// Create a copy of RevenueForecast
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ForecastScenariosCopyWith<$Res>? get scenarios {
    if (_self.scenarios == null) {
    return null;
  }

  return $ForecastScenariosCopyWith<$Res>(_self.scenarios!, (value) {
    return _then(_self.copyWith(scenarios: value));
  });
}/// Create a copy of RevenueForecast
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ForecastMetricsCopyWith<$Res> get metrics {
  
  return $ForecastMetricsCopyWith<$Res>(_self.metrics, (value) {
    return _then(_self.copyWith(metrics: value));
  });
}
}


/// @nodoc
mixin _$DailyPrediction {

 String get date; double get predicted; double get confidence;
/// Create a copy of DailyPrediction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DailyPredictionCopyWith<DailyPrediction> get copyWith => _$DailyPredictionCopyWithImpl<DailyPrediction>(this as DailyPrediction, _$identity);

  /// Serializes this DailyPrediction to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DailyPrediction&&(identical(other.date, date) || other.date == date)&&(identical(other.predicted, predicted) || other.predicted == predicted)&&(identical(other.confidence, confidence) || other.confidence == confidence));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,predicted,confidence);

@override
String toString() {
  return 'DailyPrediction(date: $date, predicted: $predicted, confidence: $confidence)';
}


}

/// @nodoc
abstract mixin class $DailyPredictionCopyWith<$Res>  {
  factory $DailyPredictionCopyWith(DailyPrediction value, $Res Function(DailyPrediction) _then) = _$DailyPredictionCopyWithImpl;
@useResult
$Res call({
 String date, double predicted, double confidence
});




}
/// @nodoc
class _$DailyPredictionCopyWithImpl<$Res>
    implements $DailyPredictionCopyWith<$Res> {
  _$DailyPredictionCopyWithImpl(this._self, this._then);

  final DailyPrediction _self;
  final $Res Function(DailyPrediction) _then;

/// Create a copy of DailyPrediction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? predicted = null,Object? confidence = null,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,predicted: null == predicted ? _self.predicted : predicted // ignore: cast_nullable_to_non_nullable
as double,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [DailyPrediction].
extension DailyPredictionPatterns on DailyPrediction {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DailyPrediction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DailyPrediction() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DailyPrediction value)  $default,){
final _that = this;
switch (_that) {
case _DailyPrediction():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DailyPrediction value)?  $default,){
final _that = this;
switch (_that) {
case _DailyPrediction() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String date,  double predicted,  double confidence)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DailyPrediction() when $default != null:
return $default(_that.date,_that.predicted,_that.confidence);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String date,  double predicted,  double confidence)  $default,) {final _that = this;
switch (_that) {
case _DailyPrediction():
return $default(_that.date,_that.predicted,_that.confidence);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String date,  double predicted,  double confidence)?  $default,) {final _that = this;
switch (_that) {
case _DailyPrediction() when $default != null:
return $default(_that.date,_that.predicted,_that.confidence);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DailyPrediction implements DailyPrediction {
  const _DailyPrediction({required this.date, required this.predicted, required this.confidence});
  factory _DailyPrediction.fromJson(Map<String, dynamic> json) => _$DailyPredictionFromJson(json);

@override final  String date;
@override final  double predicted;
@override final  double confidence;

/// Create a copy of DailyPrediction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DailyPredictionCopyWith<_DailyPrediction> get copyWith => __$DailyPredictionCopyWithImpl<_DailyPrediction>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DailyPredictionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DailyPrediction&&(identical(other.date, date) || other.date == date)&&(identical(other.predicted, predicted) || other.predicted == predicted)&&(identical(other.confidence, confidence) || other.confidence == confidence));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,predicted,confidence);

@override
String toString() {
  return 'DailyPrediction(date: $date, predicted: $predicted, confidence: $confidence)';
}


}

/// @nodoc
abstract mixin class _$DailyPredictionCopyWith<$Res> implements $DailyPredictionCopyWith<$Res> {
  factory _$DailyPredictionCopyWith(_DailyPrediction value, $Res Function(_DailyPrediction) _then) = __$DailyPredictionCopyWithImpl;
@override @useResult
$Res call({
 String date, double predicted, double confidence
});




}
/// @nodoc
class __$DailyPredictionCopyWithImpl<$Res>
    implements _$DailyPredictionCopyWith<$Res> {
  __$DailyPredictionCopyWithImpl(this._self, this._then);

  final _DailyPrediction _self;
  final $Res Function(_DailyPrediction) _then;

/// Create a copy of DailyPrediction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? predicted = null,Object? confidence = null,}) {
  return _then(_DailyPrediction(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,predicted: null == predicted ? _self.predicted : predicted // ignore: cast_nullable_to_non_nullable
as double,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$ConfidenceIntervals {

 List<ConfidenceInterval> get intervals;
/// Create a copy of ConfidenceIntervals
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConfidenceIntervalsCopyWith<ConfidenceIntervals> get copyWith => _$ConfidenceIntervalsCopyWithImpl<ConfidenceIntervals>(this as ConfidenceIntervals, _$identity);

  /// Serializes this ConfidenceIntervals to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConfidenceIntervals&&const DeepCollectionEquality().equals(other.intervals, intervals));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(intervals));

@override
String toString() {
  return 'ConfidenceIntervals(intervals: $intervals)';
}


}

/// @nodoc
abstract mixin class $ConfidenceIntervalsCopyWith<$Res>  {
  factory $ConfidenceIntervalsCopyWith(ConfidenceIntervals value, $Res Function(ConfidenceIntervals) _then) = _$ConfidenceIntervalsCopyWithImpl;
@useResult
$Res call({
 List<ConfidenceInterval> intervals
});




}
/// @nodoc
class _$ConfidenceIntervalsCopyWithImpl<$Res>
    implements $ConfidenceIntervalsCopyWith<$Res> {
  _$ConfidenceIntervalsCopyWithImpl(this._self, this._then);

  final ConfidenceIntervals _self;
  final $Res Function(ConfidenceIntervals) _then;

/// Create a copy of ConfidenceIntervals
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? intervals = null,}) {
  return _then(_self.copyWith(
intervals: null == intervals ? _self.intervals : intervals // ignore: cast_nullable_to_non_nullable
as List<ConfidenceInterval>,
  ));
}

}


/// Adds pattern-matching-related methods to [ConfidenceIntervals].
extension ConfidenceIntervalsPatterns on ConfidenceIntervals {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ConfidenceIntervals value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ConfidenceIntervals() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ConfidenceIntervals value)  $default,){
final _that = this;
switch (_that) {
case _ConfidenceIntervals():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ConfidenceIntervals value)?  $default,){
final _that = this;
switch (_that) {
case _ConfidenceIntervals() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<ConfidenceInterval> intervals)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ConfidenceIntervals() when $default != null:
return $default(_that.intervals);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<ConfidenceInterval> intervals)  $default,) {final _that = this;
switch (_that) {
case _ConfidenceIntervals():
return $default(_that.intervals);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<ConfidenceInterval> intervals)?  $default,) {final _that = this;
switch (_that) {
case _ConfidenceIntervals() when $default != null:
return $default(_that.intervals);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ConfidenceIntervals implements ConfidenceIntervals {
  const _ConfidenceIntervals({required final  List<ConfidenceInterval> intervals}): _intervals = intervals;
  factory _ConfidenceIntervals.fromJson(Map<String, dynamic> json) => _$ConfidenceIntervalsFromJson(json);

 final  List<ConfidenceInterval> _intervals;
@override List<ConfidenceInterval> get intervals {
  if (_intervals is EqualUnmodifiableListView) return _intervals;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_intervals);
}


/// Create a copy of ConfidenceIntervals
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConfidenceIntervalsCopyWith<_ConfidenceIntervals> get copyWith => __$ConfidenceIntervalsCopyWithImpl<_ConfidenceIntervals>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ConfidenceIntervalsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConfidenceIntervals&&const DeepCollectionEquality().equals(other._intervals, _intervals));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_intervals));

@override
String toString() {
  return 'ConfidenceIntervals(intervals: $intervals)';
}


}

/// @nodoc
abstract mixin class _$ConfidenceIntervalsCopyWith<$Res> implements $ConfidenceIntervalsCopyWith<$Res> {
  factory _$ConfidenceIntervalsCopyWith(_ConfidenceIntervals value, $Res Function(_ConfidenceIntervals) _then) = __$ConfidenceIntervalsCopyWithImpl;
@override @useResult
$Res call({
 List<ConfidenceInterval> intervals
});




}
/// @nodoc
class __$ConfidenceIntervalsCopyWithImpl<$Res>
    implements _$ConfidenceIntervalsCopyWith<$Res> {
  __$ConfidenceIntervalsCopyWithImpl(this._self, this._then);

  final _ConfidenceIntervals _self;
  final $Res Function(_ConfidenceIntervals) _then;

/// Create a copy of ConfidenceIntervals
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? intervals = null,}) {
  return _then(_ConfidenceIntervals(
intervals: null == intervals ? _self._intervals : intervals // ignore: cast_nullable_to_non_nullable
as List<ConfidenceInterval>,
  ));
}


}


/// @nodoc
mixin _$ConfidenceInterval {

 String get date; double get lower; double get upper; double get confidence;
/// Create a copy of ConfidenceInterval
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConfidenceIntervalCopyWith<ConfidenceInterval> get copyWith => _$ConfidenceIntervalCopyWithImpl<ConfidenceInterval>(this as ConfidenceInterval, _$identity);

  /// Serializes this ConfidenceInterval to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConfidenceInterval&&(identical(other.date, date) || other.date == date)&&(identical(other.lower, lower) || other.lower == lower)&&(identical(other.upper, upper) || other.upper == upper)&&(identical(other.confidence, confidence) || other.confidence == confidence));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,lower,upper,confidence);

@override
String toString() {
  return 'ConfidenceInterval(date: $date, lower: $lower, upper: $upper, confidence: $confidence)';
}


}

/// @nodoc
abstract mixin class $ConfidenceIntervalCopyWith<$Res>  {
  factory $ConfidenceIntervalCopyWith(ConfidenceInterval value, $Res Function(ConfidenceInterval) _then) = _$ConfidenceIntervalCopyWithImpl;
@useResult
$Res call({
 String date, double lower, double upper, double confidence
});




}
/// @nodoc
class _$ConfidenceIntervalCopyWithImpl<$Res>
    implements $ConfidenceIntervalCopyWith<$Res> {
  _$ConfidenceIntervalCopyWithImpl(this._self, this._then);

  final ConfidenceInterval _self;
  final $Res Function(ConfidenceInterval) _then;

/// Create a copy of ConfidenceInterval
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? lower = null,Object? upper = null,Object? confidence = null,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,lower: null == lower ? _self.lower : lower // ignore: cast_nullable_to_non_nullable
as double,upper: null == upper ? _self.upper : upper // ignore: cast_nullable_to_non_nullable
as double,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [ConfidenceInterval].
extension ConfidenceIntervalPatterns on ConfidenceInterval {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ConfidenceInterval value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ConfidenceInterval() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ConfidenceInterval value)  $default,){
final _that = this;
switch (_that) {
case _ConfidenceInterval():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ConfidenceInterval value)?  $default,){
final _that = this;
switch (_that) {
case _ConfidenceInterval() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String date,  double lower,  double upper,  double confidence)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ConfidenceInterval() when $default != null:
return $default(_that.date,_that.lower,_that.upper,_that.confidence);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String date,  double lower,  double upper,  double confidence)  $default,) {final _that = this;
switch (_that) {
case _ConfidenceInterval():
return $default(_that.date,_that.lower,_that.upper,_that.confidence);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String date,  double lower,  double upper,  double confidence)?  $default,) {final _that = this;
switch (_that) {
case _ConfidenceInterval() when $default != null:
return $default(_that.date,_that.lower,_that.upper,_that.confidence);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ConfidenceInterval implements ConfidenceInterval {
  const _ConfidenceInterval({required this.date, required this.lower, required this.upper, required this.confidence});
  factory _ConfidenceInterval.fromJson(Map<String, dynamic> json) => _$ConfidenceIntervalFromJson(json);

@override final  String date;
@override final  double lower;
@override final  double upper;
@override final  double confidence;

/// Create a copy of ConfidenceInterval
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConfidenceIntervalCopyWith<_ConfidenceInterval> get copyWith => __$ConfidenceIntervalCopyWithImpl<_ConfidenceInterval>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ConfidenceIntervalToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConfidenceInterval&&(identical(other.date, date) || other.date == date)&&(identical(other.lower, lower) || other.lower == lower)&&(identical(other.upper, upper) || other.upper == upper)&&(identical(other.confidence, confidence) || other.confidence == confidence));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,lower,upper,confidence);

@override
String toString() {
  return 'ConfidenceInterval(date: $date, lower: $lower, upper: $upper, confidence: $confidence)';
}


}

/// @nodoc
abstract mixin class _$ConfidenceIntervalCopyWith<$Res> implements $ConfidenceIntervalCopyWith<$Res> {
  factory _$ConfidenceIntervalCopyWith(_ConfidenceInterval value, $Res Function(_ConfidenceInterval) _then) = __$ConfidenceIntervalCopyWithImpl;
@override @useResult
$Res call({
 String date, double lower, double upper, double confidence
});




}
/// @nodoc
class __$ConfidenceIntervalCopyWithImpl<$Res>
    implements _$ConfidenceIntervalCopyWith<$Res> {
  __$ConfidenceIntervalCopyWithImpl(this._self, this._then);

  final _ConfidenceInterval _self;
  final $Res Function(_ConfidenceInterval) _then;

/// Create a copy of ConfidenceInterval
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? lower = null,Object? upper = null,Object? confidence = null,}) {
  return _then(_ConfidenceInterval(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,lower: null == lower ? _self.lower : lower // ignore: cast_nullable_to_non_nullable
as double,upper: null == upper ? _self.upper : upper // ignore: cast_nullable_to_non_nullable
as double,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$ForecastScenarios {

 double get bestCase; double get mostLikely; double get worstCase;
/// Create a copy of ForecastScenarios
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ForecastScenariosCopyWith<ForecastScenarios> get copyWith => _$ForecastScenariosCopyWithImpl<ForecastScenarios>(this as ForecastScenarios, _$identity);

  /// Serializes this ForecastScenarios to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ForecastScenarios&&(identical(other.bestCase, bestCase) || other.bestCase == bestCase)&&(identical(other.mostLikely, mostLikely) || other.mostLikely == mostLikely)&&(identical(other.worstCase, worstCase) || other.worstCase == worstCase));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,bestCase,mostLikely,worstCase);

@override
String toString() {
  return 'ForecastScenarios(bestCase: $bestCase, mostLikely: $mostLikely, worstCase: $worstCase)';
}


}

/// @nodoc
abstract mixin class $ForecastScenariosCopyWith<$Res>  {
  factory $ForecastScenariosCopyWith(ForecastScenarios value, $Res Function(ForecastScenarios) _then) = _$ForecastScenariosCopyWithImpl;
@useResult
$Res call({
 double bestCase, double mostLikely, double worstCase
});




}
/// @nodoc
class _$ForecastScenariosCopyWithImpl<$Res>
    implements $ForecastScenariosCopyWith<$Res> {
  _$ForecastScenariosCopyWithImpl(this._self, this._then);

  final ForecastScenarios _self;
  final $Res Function(ForecastScenarios) _then;

/// Create a copy of ForecastScenarios
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? bestCase = null,Object? mostLikely = null,Object? worstCase = null,}) {
  return _then(_self.copyWith(
bestCase: null == bestCase ? _self.bestCase : bestCase // ignore: cast_nullable_to_non_nullable
as double,mostLikely: null == mostLikely ? _self.mostLikely : mostLikely // ignore: cast_nullable_to_non_nullable
as double,worstCase: null == worstCase ? _self.worstCase : worstCase // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [ForecastScenarios].
extension ForecastScenariosPatterns on ForecastScenarios {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ForecastScenarios value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ForecastScenarios() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ForecastScenarios value)  $default,){
final _that = this;
switch (_that) {
case _ForecastScenarios():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ForecastScenarios value)?  $default,){
final _that = this;
switch (_that) {
case _ForecastScenarios() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double bestCase,  double mostLikely,  double worstCase)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ForecastScenarios() when $default != null:
return $default(_that.bestCase,_that.mostLikely,_that.worstCase);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double bestCase,  double mostLikely,  double worstCase)  $default,) {final _that = this;
switch (_that) {
case _ForecastScenarios():
return $default(_that.bestCase,_that.mostLikely,_that.worstCase);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double bestCase,  double mostLikely,  double worstCase)?  $default,) {final _that = this;
switch (_that) {
case _ForecastScenarios() when $default != null:
return $default(_that.bestCase,_that.mostLikely,_that.worstCase);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ForecastScenarios implements ForecastScenarios {
  const _ForecastScenarios({required this.bestCase, required this.mostLikely, required this.worstCase});
  factory _ForecastScenarios.fromJson(Map<String, dynamic> json) => _$ForecastScenariosFromJson(json);

@override final  double bestCase;
@override final  double mostLikely;
@override final  double worstCase;

/// Create a copy of ForecastScenarios
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ForecastScenariosCopyWith<_ForecastScenarios> get copyWith => __$ForecastScenariosCopyWithImpl<_ForecastScenarios>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ForecastScenariosToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ForecastScenarios&&(identical(other.bestCase, bestCase) || other.bestCase == bestCase)&&(identical(other.mostLikely, mostLikely) || other.mostLikely == mostLikely)&&(identical(other.worstCase, worstCase) || other.worstCase == worstCase));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,bestCase,mostLikely,worstCase);

@override
String toString() {
  return 'ForecastScenarios(bestCase: $bestCase, mostLikely: $mostLikely, worstCase: $worstCase)';
}


}

/// @nodoc
abstract mixin class _$ForecastScenariosCopyWith<$Res> implements $ForecastScenariosCopyWith<$Res> {
  factory _$ForecastScenariosCopyWith(_ForecastScenarios value, $Res Function(_ForecastScenarios) _then) = __$ForecastScenariosCopyWithImpl;
@override @useResult
$Res call({
 double bestCase, double mostLikely, double worstCase
});




}
/// @nodoc
class __$ForecastScenariosCopyWithImpl<$Res>
    implements _$ForecastScenariosCopyWith<$Res> {
  __$ForecastScenariosCopyWithImpl(this._self, this._then);

  final _ForecastScenarios _self;
  final $Res Function(_ForecastScenarios) _then;

/// Create a copy of ForecastScenarios
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? bestCase = null,Object? mostLikely = null,Object? worstCase = null,}) {
  return _then(_ForecastScenarios(
bestCase: null == bestCase ? _self.bestCase : bestCase // ignore: cast_nullable_to_non_nullable
as double,mostLikely: null == mostLikely ? _self.mostLikely : mostLikely // ignore: cast_nullable_to_non_nullable
as double,worstCase: null == worstCase ? _self.worstCase : worstCase // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$ForecastMetrics {

 double get arimaAccuracy; double get prophetAccuracy; double get lstmAccuracy; double get ensembleAccuracy; double get mae; double get rmse;
/// Create a copy of ForecastMetrics
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ForecastMetricsCopyWith<ForecastMetrics> get copyWith => _$ForecastMetricsCopyWithImpl<ForecastMetrics>(this as ForecastMetrics, _$identity);

  /// Serializes this ForecastMetrics to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ForecastMetrics&&(identical(other.arimaAccuracy, arimaAccuracy) || other.arimaAccuracy == arimaAccuracy)&&(identical(other.prophetAccuracy, prophetAccuracy) || other.prophetAccuracy == prophetAccuracy)&&(identical(other.lstmAccuracy, lstmAccuracy) || other.lstmAccuracy == lstmAccuracy)&&(identical(other.ensembleAccuracy, ensembleAccuracy) || other.ensembleAccuracy == ensembleAccuracy)&&(identical(other.mae, mae) || other.mae == mae)&&(identical(other.rmse, rmse) || other.rmse == rmse));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,arimaAccuracy,prophetAccuracy,lstmAccuracy,ensembleAccuracy,mae,rmse);

@override
String toString() {
  return 'ForecastMetrics(arimaAccuracy: $arimaAccuracy, prophetAccuracy: $prophetAccuracy, lstmAccuracy: $lstmAccuracy, ensembleAccuracy: $ensembleAccuracy, mae: $mae, rmse: $rmse)';
}


}

/// @nodoc
abstract mixin class $ForecastMetricsCopyWith<$Res>  {
  factory $ForecastMetricsCopyWith(ForecastMetrics value, $Res Function(ForecastMetrics) _then) = _$ForecastMetricsCopyWithImpl;
@useResult
$Res call({
 double arimaAccuracy, double prophetAccuracy, double lstmAccuracy, double ensembleAccuracy, double mae, double rmse
});




}
/// @nodoc
class _$ForecastMetricsCopyWithImpl<$Res>
    implements $ForecastMetricsCopyWith<$Res> {
  _$ForecastMetricsCopyWithImpl(this._self, this._then);

  final ForecastMetrics _self;
  final $Res Function(ForecastMetrics) _then;

/// Create a copy of ForecastMetrics
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? arimaAccuracy = null,Object? prophetAccuracy = null,Object? lstmAccuracy = null,Object? ensembleAccuracy = null,Object? mae = null,Object? rmse = null,}) {
  return _then(_self.copyWith(
arimaAccuracy: null == arimaAccuracy ? _self.arimaAccuracy : arimaAccuracy // ignore: cast_nullable_to_non_nullable
as double,prophetAccuracy: null == prophetAccuracy ? _self.prophetAccuracy : prophetAccuracy // ignore: cast_nullable_to_non_nullable
as double,lstmAccuracy: null == lstmAccuracy ? _self.lstmAccuracy : lstmAccuracy // ignore: cast_nullable_to_non_nullable
as double,ensembleAccuracy: null == ensembleAccuracy ? _self.ensembleAccuracy : ensembleAccuracy // ignore: cast_nullable_to_non_nullable
as double,mae: null == mae ? _self.mae : mae // ignore: cast_nullable_to_non_nullable
as double,rmse: null == rmse ? _self.rmse : rmse // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [ForecastMetrics].
extension ForecastMetricsPatterns on ForecastMetrics {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ForecastMetrics value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ForecastMetrics() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ForecastMetrics value)  $default,){
final _that = this;
switch (_that) {
case _ForecastMetrics():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ForecastMetrics value)?  $default,){
final _that = this;
switch (_that) {
case _ForecastMetrics() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double arimaAccuracy,  double prophetAccuracy,  double lstmAccuracy,  double ensembleAccuracy,  double mae,  double rmse)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ForecastMetrics() when $default != null:
return $default(_that.arimaAccuracy,_that.prophetAccuracy,_that.lstmAccuracy,_that.ensembleAccuracy,_that.mae,_that.rmse);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double arimaAccuracy,  double prophetAccuracy,  double lstmAccuracy,  double ensembleAccuracy,  double mae,  double rmse)  $default,) {final _that = this;
switch (_that) {
case _ForecastMetrics():
return $default(_that.arimaAccuracy,_that.prophetAccuracy,_that.lstmAccuracy,_that.ensembleAccuracy,_that.mae,_that.rmse);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double arimaAccuracy,  double prophetAccuracy,  double lstmAccuracy,  double ensembleAccuracy,  double mae,  double rmse)?  $default,) {final _that = this;
switch (_that) {
case _ForecastMetrics() when $default != null:
return $default(_that.arimaAccuracy,_that.prophetAccuracy,_that.lstmAccuracy,_that.ensembleAccuracy,_that.mae,_that.rmse);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ForecastMetrics implements ForecastMetrics {
  const _ForecastMetrics({required this.arimaAccuracy, required this.prophetAccuracy, required this.lstmAccuracy, required this.ensembleAccuracy, required this.mae, required this.rmse});
  factory _ForecastMetrics.fromJson(Map<String, dynamic> json) => _$ForecastMetricsFromJson(json);

@override final  double arimaAccuracy;
@override final  double prophetAccuracy;
@override final  double lstmAccuracy;
@override final  double ensembleAccuracy;
@override final  double mae;
@override final  double rmse;

/// Create a copy of ForecastMetrics
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ForecastMetricsCopyWith<_ForecastMetrics> get copyWith => __$ForecastMetricsCopyWithImpl<_ForecastMetrics>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ForecastMetricsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ForecastMetrics&&(identical(other.arimaAccuracy, arimaAccuracy) || other.arimaAccuracy == arimaAccuracy)&&(identical(other.prophetAccuracy, prophetAccuracy) || other.prophetAccuracy == prophetAccuracy)&&(identical(other.lstmAccuracy, lstmAccuracy) || other.lstmAccuracy == lstmAccuracy)&&(identical(other.ensembleAccuracy, ensembleAccuracy) || other.ensembleAccuracy == ensembleAccuracy)&&(identical(other.mae, mae) || other.mae == mae)&&(identical(other.rmse, rmse) || other.rmse == rmse));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,arimaAccuracy,prophetAccuracy,lstmAccuracy,ensembleAccuracy,mae,rmse);

@override
String toString() {
  return 'ForecastMetrics(arimaAccuracy: $arimaAccuracy, prophetAccuracy: $prophetAccuracy, lstmAccuracy: $lstmAccuracy, ensembleAccuracy: $ensembleAccuracy, mae: $mae, rmse: $rmse)';
}


}

/// @nodoc
abstract mixin class _$ForecastMetricsCopyWith<$Res> implements $ForecastMetricsCopyWith<$Res> {
  factory _$ForecastMetricsCopyWith(_ForecastMetrics value, $Res Function(_ForecastMetrics) _then) = __$ForecastMetricsCopyWithImpl;
@override @useResult
$Res call({
 double arimaAccuracy, double prophetAccuracy, double lstmAccuracy, double ensembleAccuracy, double mae, double rmse
});




}
/// @nodoc
class __$ForecastMetricsCopyWithImpl<$Res>
    implements _$ForecastMetricsCopyWith<$Res> {
  __$ForecastMetricsCopyWithImpl(this._self, this._then);

  final _ForecastMetrics _self;
  final $Res Function(_ForecastMetrics) _then;

/// Create a copy of ForecastMetrics
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? arimaAccuracy = null,Object? prophetAccuracy = null,Object? lstmAccuracy = null,Object? ensembleAccuracy = null,Object? mae = null,Object? rmse = null,}) {
  return _then(_ForecastMetrics(
arimaAccuracy: null == arimaAccuracy ? _self.arimaAccuracy : arimaAccuracy // ignore: cast_nullable_to_non_nullable
as double,prophetAccuracy: null == prophetAccuracy ? _self.prophetAccuracy : prophetAccuracy // ignore: cast_nullable_to_non_nullable
as double,lstmAccuracy: null == lstmAccuracy ? _self.lstmAccuracy : lstmAccuracy // ignore: cast_nullable_to_non_nullable
as double,ensembleAccuracy: null == ensembleAccuracy ? _self.ensembleAccuracy : ensembleAccuracy // ignore: cast_nullable_to_non_nullable
as double,mae: null == mae ? _self.mae : mae // ignore: cast_nullable_to_non_nullable
as double,rmse: null == rmse ? _self.rmse : rmse // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$RevenueDrivers {

 String get organizationId; int get period; String get analyzedAt; List<PrimaryDriver> get primaryDrivers; List<ExternalFactor> get externalFactors; List<String> get recommendations;
/// Create a copy of RevenueDrivers
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RevenueDriversCopyWith<RevenueDrivers> get copyWith => _$RevenueDriversCopyWithImpl<RevenueDrivers>(this as RevenueDrivers, _$identity);

  /// Serializes this RevenueDrivers to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RevenueDrivers&&(identical(other.organizationId, organizationId) || other.organizationId == organizationId)&&(identical(other.period, period) || other.period == period)&&(identical(other.analyzedAt, analyzedAt) || other.analyzedAt == analyzedAt)&&const DeepCollectionEquality().equals(other.primaryDrivers, primaryDrivers)&&const DeepCollectionEquality().equals(other.externalFactors, externalFactors)&&const DeepCollectionEquality().equals(other.recommendations, recommendations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,organizationId,period,analyzedAt,const DeepCollectionEquality().hash(primaryDrivers),const DeepCollectionEquality().hash(externalFactors),const DeepCollectionEquality().hash(recommendations));

@override
String toString() {
  return 'RevenueDrivers(organizationId: $organizationId, period: $period, analyzedAt: $analyzedAt, primaryDrivers: $primaryDrivers, externalFactors: $externalFactors, recommendations: $recommendations)';
}


}

/// @nodoc
abstract mixin class $RevenueDriversCopyWith<$Res>  {
  factory $RevenueDriversCopyWith(RevenueDrivers value, $Res Function(RevenueDrivers) _then) = _$RevenueDriversCopyWithImpl;
@useResult
$Res call({
 String organizationId, int period, String analyzedAt, List<PrimaryDriver> primaryDrivers, List<ExternalFactor> externalFactors, List<String> recommendations
});




}
/// @nodoc
class _$RevenueDriversCopyWithImpl<$Res>
    implements $RevenueDriversCopyWith<$Res> {
  _$RevenueDriversCopyWithImpl(this._self, this._then);

  final RevenueDrivers _self;
  final $Res Function(RevenueDrivers) _then;

/// Create a copy of RevenueDrivers
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? organizationId = null,Object? period = null,Object? analyzedAt = null,Object? primaryDrivers = null,Object? externalFactors = null,Object? recommendations = null,}) {
  return _then(_self.copyWith(
organizationId: null == organizationId ? _self.organizationId : organizationId // ignore: cast_nullable_to_non_nullable
as String,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as int,analyzedAt: null == analyzedAt ? _self.analyzedAt : analyzedAt // ignore: cast_nullable_to_non_nullable
as String,primaryDrivers: null == primaryDrivers ? _self.primaryDrivers : primaryDrivers // ignore: cast_nullable_to_non_nullable
as List<PrimaryDriver>,externalFactors: null == externalFactors ? _self.externalFactors : externalFactors // ignore: cast_nullable_to_non_nullable
as List<ExternalFactor>,recommendations: null == recommendations ? _self.recommendations : recommendations // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [RevenueDrivers].
extension RevenueDriversPatterns on RevenueDrivers {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RevenueDrivers value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RevenueDrivers() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RevenueDrivers value)  $default,){
final _that = this;
switch (_that) {
case _RevenueDrivers():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RevenueDrivers value)?  $default,){
final _that = this;
switch (_that) {
case _RevenueDrivers() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String organizationId,  int period,  String analyzedAt,  List<PrimaryDriver> primaryDrivers,  List<ExternalFactor> externalFactors,  List<String> recommendations)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RevenueDrivers() when $default != null:
return $default(_that.organizationId,_that.period,_that.analyzedAt,_that.primaryDrivers,_that.externalFactors,_that.recommendations);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String organizationId,  int period,  String analyzedAt,  List<PrimaryDriver> primaryDrivers,  List<ExternalFactor> externalFactors,  List<String> recommendations)  $default,) {final _that = this;
switch (_that) {
case _RevenueDrivers():
return $default(_that.organizationId,_that.period,_that.analyzedAt,_that.primaryDrivers,_that.externalFactors,_that.recommendations);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String organizationId,  int period,  String analyzedAt,  List<PrimaryDriver> primaryDrivers,  List<ExternalFactor> externalFactors,  List<String> recommendations)?  $default,) {final _that = this;
switch (_that) {
case _RevenueDrivers() when $default != null:
return $default(_that.organizationId,_that.period,_that.analyzedAt,_that.primaryDrivers,_that.externalFactors,_that.recommendations);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RevenueDrivers implements RevenueDrivers {
  const _RevenueDrivers({required this.organizationId, required this.period, required this.analyzedAt, required final  List<PrimaryDriver> primaryDrivers, required final  List<ExternalFactor> externalFactors, required final  List<String> recommendations}): _primaryDrivers = primaryDrivers,_externalFactors = externalFactors,_recommendations = recommendations;
  factory _RevenueDrivers.fromJson(Map<String, dynamic> json) => _$RevenueDriversFromJson(json);

@override final  String organizationId;
@override final  int period;
@override final  String analyzedAt;
 final  List<PrimaryDriver> _primaryDrivers;
@override List<PrimaryDriver> get primaryDrivers {
  if (_primaryDrivers is EqualUnmodifiableListView) return _primaryDrivers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_primaryDrivers);
}

 final  List<ExternalFactor> _externalFactors;
@override List<ExternalFactor> get externalFactors {
  if (_externalFactors is EqualUnmodifiableListView) return _externalFactors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_externalFactors);
}

 final  List<String> _recommendations;
@override List<String> get recommendations {
  if (_recommendations is EqualUnmodifiableListView) return _recommendations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recommendations);
}


/// Create a copy of RevenueDrivers
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RevenueDriversCopyWith<_RevenueDrivers> get copyWith => __$RevenueDriversCopyWithImpl<_RevenueDrivers>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RevenueDriversToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RevenueDrivers&&(identical(other.organizationId, organizationId) || other.organizationId == organizationId)&&(identical(other.period, period) || other.period == period)&&(identical(other.analyzedAt, analyzedAt) || other.analyzedAt == analyzedAt)&&const DeepCollectionEquality().equals(other._primaryDrivers, _primaryDrivers)&&const DeepCollectionEquality().equals(other._externalFactors, _externalFactors)&&const DeepCollectionEquality().equals(other._recommendations, _recommendations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,organizationId,period,analyzedAt,const DeepCollectionEquality().hash(_primaryDrivers),const DeepCollectionEquality().hash(_externalFactors),const DeepCollectionEquality().hash(_recommendations));

@override
String toString() {
  return 'RevenueDrivers(organizationId: $organizationId, period: $period, analyzedAt: $analyzedAt, primaryDrivers: $primaryDrivers, externalFactors: $externalFactors, recommendations: $recommendations)';
}


}

/// @nodoc
abstract mixin class _$RevenueDriversCopyWith<$Res> implements $RevenueDriversCopyWith<$Res> {
  factory _$RevenueDriversCopyWith(_RevenueDrivers value, $Res Function(_RevenueDrivers) _then) = __$RevenueDriversCopyWithImpl;
@override @useResult
$Res call({
 String organizationId, int period, String analyzedAt, List<PrimaryDriver> primaryDrivers, List<ExternalFactor> externalFactors, List<String> recommendations
});




}
/// @nodoc
class __$RevenueDriversCopyWithImpl<$Res>
    implements _$RevenueDriversCopyWith<$Res> {
  __$RevenueDriversCopyWithImpl(this._self, this._then);

  final _RevenueDrivers _self;
  final $Res Function(_RevenueDrivers) _then;

/// Create a copy of RevenueDrivers
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? organizationId = null,Object? period = null,Object? analyzedAt = null,Object? primaryDrivers = null,Object? externalFactors = null,Object? recommendations = null,}) {
  return _then(_RevenueDrivers(
organizationId: null == organizationId ? _self.organizationId : organizationId // ignore: cast_nullable_to_non_nullable
as String,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as int,analyzedAt: null == analyzedAt ? _self.analyzedAt : analyzedAt // ignore: cast_nullable_to_non_nullable
as String,primaryDrivers: null == primaryDrivers ? _self._primaryDrivers : primaryDrivers // ignore: cast_nullable_to_non_nullable
as List<PrimaryDriver>,externalFactors: null == externalFactors ? _self._externalFactors : externalFactors // ignore: cast_nullable_to_non_nullable
as List<ExternalFactor>,recommendations: null == recommendations ? _self._recommendations : recommendations // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$PrimaryDriver {

 String get driver; double get impact; String get trend; double get correlation; double get elasticity;
/// Create a copy of PrimaryDriver
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PrimaryDriverCopyWith<PrimaryDriver> get copyWith => _$PrimaryDriverCopyWithImpl<PrimaryDriver>(this as PrimaryDriver, _$identity);

  /// Serializes this PrimaryDriver to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PrimaryDriver&&(identical(other.driver, driver) || other.driver == driver)&&(identical(other.impact, impact) || other.impact == impact)&&(identical(other.trend, trend) || other.trend == trend)&&(identical(other.correlation, correlation) || other.correlation == correlation)&&(identical(other.elasticity, elasticity) || other.elasticity == elasticity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,driver,impact,trend,correlation,elasticity);

@override
String toString() {
  return 'PrimaryDriver(driver: $driver, impact: $impact, trend: $trend, correlation: $correlation, elasticity: $elasticity)';
}


}

/// @nodoc
abstract mixin class $PrimaryDriverCopyWith<$Res>  {
  factory $PrimaryDriverCopyWith(PrimaryDriver value, $Res Function(PrimaryDriver) _then) = _$PrimaryDriverCopyWithImpl;
@useResult
$Res call({
 String driver, double impact, String trend, double correlation, double elasticity
});




}
/// @nodoc
class _$PrimaryDriverCopyWithImpl<$Res>
    implements $PrimaryDriverCopyWith<$Res> {
  _$PrimaryDriverCopyWithImpl(this._self, this._then);

  final PrimaryDriver _self;
  final $Res Function(PrimaryDriver) _then;

/// Create a copy of PrimaryDriver
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? driver = null,Object? impact = null,Object? trend = null,Object? correlation = null,Object? elasticity = null,}) {
  return _then(_self.copyWith(
driver: null == driver ? _self.driver : driver // ignore: cast_nullable_to_non_nullable
as String,impact: null == impact ? _self.impact : impact // ignore: cast_nullable_to_non_nullable
as double,trend: null == trend ? _self.trend : trend // ignore: cast_nullable_to_non_nullable
as String,correlation: null == correlation ? _self.correlation : correlation // ignore: cast_nullable_to_non_nullable
as double,elasticity: null == elasticity ? _self.elasticity : elasticity // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [PrimaryDriver].
extension PrimaryDriverPatterns on PrimaryDriver {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PrimaryDriver value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PrimaryDriver() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PrimaryDriver value)  $default,){
final _that = this;
switch (_that) {
case _PrimaryDriver():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PrimaryDriver value)?  $default,){
final _that = this;
switch (_that) {
case _PrimaryDriver() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String driver,  double impact,  String trend,  double correlation,  double elasticity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PrimaryDriver() when $default != null:
return $default(_that.driver,_that.impact,_that.trend,_that.correlation,_that.elasticity);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String driver,  double impact,  String trend,  double correlation,  double elasticity)  $default,) {final _that = this;
switch (_that) {
case _PrimaryDriver():
return $default(_that.driver,_that.impact,_that.trend,_that.correlation,_that.elasticity);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String driver,  double impact,  String trend,  double correlation,  double elasticity)?  $default,) {final _that = this;
switch (_that) {
case _PrimaryDriver() when $default != null:
return $default(_that.driver,_that.impact,_that.trend,_that.correlation,_that.elasticity);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PrimaryDriver implements PrimaryDriver {
  const _PrimaryDriver({required this.driver, required this.impact, required this.trend, required this.correlation, required this.elasticity});
  factory _PrimaryDriver.fromJson(Map<String, dynamic> json) => _$PrimaryDriverFromJson(json);

@override final  String driver;
@override final  double impact;
@override final  String trend;
@override final  double correlation;
@override final  double elasticity;

/// Create a copy of PrimaryDriver
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PrimaryDriverCopyWith<_PrimaryDriver> get copyWith => __$PrimaryDriverCopyWithImpl<_PrimaryDriver>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PrimaryDriverToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PrimaryDriver&&(identical(other.driver, driver) || other.driver == driver)&&(identical(other.impact, impact) || other.impact == impact)&&(identical(other.trend, trend) || other.trend == trend)&&(identical(other.correlation, correlation) || other.correlation == correlation)&&(identical(other.elasticity, elasticity) || other.elasticity == elasticity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,driver,impact,trend,correlation,elasticity);

@override
String toString() {
  return 'PrimaryDriver(driver: $driver, impact: $impact, trend: $trend, correlation: $correlation, elasticity: $elasticity)';
}


}

/// @nodoc
abstract mixin class _$PrimaryDriverCopyWith<$Res> implements $PrimaryDriverCopyWith<$Res> {
  factory _$PrimaryDriverCopyWith(_PrimaryDriver value, $Res Function(_PrimaryDriver) _then) = __$PrimaryDriverCopyWithImpl;
@override @useResult
$Res call({
 String driver, double impact, String trend, double correlation, double elasticity
});




}
/// @nodoc
class __$PrimaryDriverCopyWithImpl<$Res>
    implements _$PrimaryDriverCopyWith<$Res> {
  __$PrimaryDriverCopyWithImpl(this._self, this._then);

  final _PrimaryDriver _self;
  final $Res Function(_PrimaryDriver) _then;

/// Create a copy of PrimaryDriver
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? driver = null,Object? impact = null,Object? trend = null,Object? correlation = null,Object? elasticity = null,}) {
  return _then(_PrimaryDriver(
driver: null == driver ? _self.driver : driver // ignore: cast_nullable_to_non_nullable
as String,impact: null == impact ? _self.impact : impact // ignore: cast_nullable_to_non_nullable
as double,trend: null == trend ? _self.trend : trend // ignore: cast_nullable_to_non_nullable
as String,correlation: null == correlation ? _self.correlation : correlation // ignore: cast_nullable_to_non_nullable
as double,elasticity: null == elasticity ? _self.elasticity : elasticity // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$ExternalFactor {

 String get factor; double get impact; double get probability; String get potentialEffect;
/// Create a copy of ExternalFactor
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExternalFactorCopyWith<ExternalFactor> get copyWith => _$ExternalFactorCopyWithImpl<ExternalFactor>(this as ExternalFactor, _$identity);

  /// Serializes this ExternalFactor to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExternalFactor&&(identical(other.factor, factor) || other.factor == factor)&&(identical(other.impact, impact) || other.impact == impact)&&(identical(other.probability, probability) || other.probability == probability)&&(identical(other.potentialEffect, potentialEffect) || other.potentialEffect == potentialEffect));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,factor,impact,probability,potentialEffect);

@override
String toString() {
  return 'ExternalFactor(factor: $factor, impact: $impact, probability: $probability, potentialEffect: $potentialEffect)';
}


}

/// @nodoc
abstract mixin class $ExternalFactorCopyWith<$Res>  {
  factory $ExternalFactorCopyWith(ExternalFactor value, $Res Function(ExternalFactor) _then) = _$ExternalFactorCopyWithImpl;
@useResult
$Res call({
 String factor, double impact, double probability, String potentialEffect
});




}
/// @nodoc
class _$ExternalFactorCopyWithImpl<$Res>
    implements $ExternalFactorCopyWith<$Res> {
  _$ExternalFactorCopyWithImpl(this._self, this._then);

  final ExternalFactor _self;
  final $Res Function(ExternalFactor) _then;

/// Create a copy of ExternalFactor
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? factor = null,Object? impact = null,Object? probability = null,Object? potentialEffect = null,}) {
  return _then(_self.copyWith(
factor: null == factor ? _self.factor : factor // ignore: cast_nullable_to_non_nullable
as String,impact: null == impact ? _self.impact : impact // ignore: cast_nullable_to_non_nullable
as double,probability: null == probability ? _self.probability : probability // ignore: cast_nullable_to_non_nullable
as double,potentialEffect: null == potentialEffect ? _self.potentialEffect : potentialEffect // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ExternalFactor].
extension ExternalFactorPatterns on ExternalFactor {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExternalFactor value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExternalFactor() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExternalFactor value)  $default,){
final _that = this;
switch (_that) {
case _ExternalFactor():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExternalFactor value)?  $default,){
final _that = this;
switch (_that) {
case _ExternalFactor() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String factor,  double impact,  double probability,  String potentialEffect)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExternalFactor() when $default != null:
return $default(_that.factor,_that.impact,_that.probability,_that.potentialEffect);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String factor,  double impact,  double probability,  String potentialEffect)  $default,) {final _that = this;
switch (_that) {
case _ExternalFactor():
return $default(_that.factor,_that.impact,_that.probability,_that.potentialEffect);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String factor,  double impact,  double probability,  String potentialEffect)?  $default,) {final _that = this;
switch (_that) {
case _ExternalFactor() when $default != null:
return $default(_that.factor,_that.impact,_that.probability,_that.potentialEffect);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExternalFactor implements ExternalFactor {
  const _ExternalFactor({required this.factor, required this.impact, required this.probability, required this.potentialEffect});
  factory _ExternalFactor.fromJson(Map<String, dynamic> json) => _$ExternalFactorFromJson(json);

@override final  String factor;
@override final  double impact;
@override final  double probability;
@override final  String potentialEffect;

/// Create a copy of ExternalFactor
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExternalFactorCopyWith<_ExternalFactor> get copyWith => __$ExternalFactorCopyWithImpl<_ExternalFactor>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExternalFactorToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExternalFactor&&(identical(other.factor, factor) || other.factor == factor)&&(identical(other.impact, impact) || other.impact == impact)&&(identical(other.probability, probability) || other.probability == probability)&&(identical(other.potentialEffect, potentialEffect) || other.potentialEffect == potentialEffect));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,factor,impact,probability,potentialEffect);

@override
String toString() {
  return 'ExternalFactor(factor: $factor, impact: $impact, probability: $probability, potentialEffect: $potentialEffect)';
}


}

/// @nodoc
abstract mixin class _$ExternalFactorCopyWith<$Res> implements $ExternalFactorCopyWith<$Res> {
  factory _$ExternalFactorCopyWith(_ExternalFactor value, $Res Function(_ExternalFactor) _then) = __$ExternalFactorCopyWithImpl;
@override @useResult
$Res call({
 String factor, double impact, double probability, String potentialEffect
});




}
/// @nodoc
class __$ExternalFactorCopyWithImpl<$Res>
    implements _$ExternalFactorCopyWith<$Res> {
  __$ExternalFactorCopyWithImpl(this._self, this._then);

  final _ExternalFactor _self;
  final $Res Function(_ExternalFactor) _then;

/// Create a copy of ExternalFactor
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? factor = null,Object? impact = null,Object? probability = null,Object? potentialEffect = null,}) {
  return _then(_ExternalFactor(
factor: null == factor ? _self.factor : factor // ignore: cast_nullable_to_non_nullable
as String,impact: null == impact ? _self.impact : impact // ignore: cast_nullable_to_non_nullable
as double,probability: null == probability ? _self.probability : probability // ignore: cast_nullable_to_non_nullable
as double,potentialEffect: null == potentialEffect ? _self.potentialEffect : potentialEffect // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$PriceOptimization {

 String get serviceId; String get serviceName; double get currentPrice; double get optimalPrice; double get priceChange; double get percentageChange; PriceImpact get impact; double get confidence; String get recommendation;
/// Create a copy of PriceOptimization
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PriceOptimizationCopyWith<PriceOptimization> get copyWith => _$PriceOptimizationCopyWithImpl<PriceOptimization>(this as PriceOptimization, _$identity);

  /// Serializes this PriceOptimization to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PriceOptimization&&(identical(other.serviceId, serviceId) || other.serviceId == serviceId)&&(identical(other.serviceName, serviceName) || other.serviceName == serviceName)&&(identical(other.currentPrice, currentPrice) || other.currentPrice == currentPrice)&&(identical(other.optimalPrice, optimalPrice) || other.optimalPrice == optimalPrice)&&(identical(other.priceChange, priceChange) || other.priceChange == priceChange)&&(identical(other.percentageChange, percentageChange) || other.percentageChange == percentageChange)&&(identical(other.impact, impact) || other.impact == impact)&&(identical(other.confidence, confidence) || other.confidence == confidence)&&(identical(other.recommendation, recommendation) || other.recommendation == recommendation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,serviceId,serviceName,currentPrice,optimalPrice,priceChange,percentageChange,impact,confidence,recommendation);

@override
String toString() {
  return 'PriceOptimization(serviceId: $serviceId, serviceName: $serviceName, currentPrice: $currentPrice, optimalPrice: $optimalPrice, priceChange: $priceChange, percentageChange: $percentageChange, impact: $impact, confidence: $confidence, recommendation: $recommendation)';
}


}

/// @nodoc
abstract mixin class $PriceOptimizationCopyWith<$Res>  {
  factory $PriceOptimizationCopyWith(PriceOptimization value, $Res Function(PriceOptimization) _then) = _$PriceOptimizationCopyWithImpl;
@useResult
$Res call({
 String serviceId, String serviceName, double currentPrice, double optimalPrice, double priceChange, double percentageChange, PriceImpact impact, double confidence, String recommendation
});


$PriceImpactCopyWith<$Res> get impact;

}
/// @nodoc
class _$PriceOptimizationCopyWithImpl<$Res>
    implements $PriceOptimizationCopyWith<$Res> {
  _$PriceOptimizationCopyWithImpl(this._self, this._then);

  final PriceOptimization _self;
  final $Res Function(PriceOptimization) _then;

/// Create a copy of PriceOptimization
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? serviceId = null,Object? serviceName = null,Object? currentPrice = null,Object? optimalPrice = null,Object? priceChange = null,Object? percentageChange = null,Object? impact = null,Object? confidence = null,Object? recommendation = null,}) {
  return _then(_self.copyWith(
serviceId: null == serviceId ? _self.serviceId : serviceId // ignore: cast_nullable_to_non_nullable
as String,serviceName: null == serviceName ? _self.serviceName : serviceName // ignore: cast_nullable_to_non_nullable
as String,currentPrice: null == currentPrice ? _self.currentPrice : currentPrice // ignore: cast_nullable_to_non_nullable
as double,optimalPrice: null == optimalPrice ? _self.optimalPrice : optimalPrice // ignore: cast_nullable_to_non_nullable
as double,priceChange: null == priceChange ? _self.priceChange : priceChange // ignore: cast_nullable_to_non_nullable
as double,percentageChange: null == percentageChange ? _self.percentageChange : percentageChange // ignore: cast_nullable_to_non_nullable
as double,impact: null == impact ? _self.impact : impact // ignore: cast_nullable_to_non_nullable
as PriceImpact,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as double,recommendation: null == recommendation ? _self.recommendation : recommendation // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of PriceOptimization
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PriceImpactCopyWith<$Res> get impact {
  
  return $PriceImpactCopyWith<$Res>(_self.impact, (value) {
    return _then(_self.copyWith(impact: value));
  });
}
}


/// Adds pattern-matching-related methods to [PriceOptimization].
extension PriceOptimizationPatterns on PriceOptimization {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PriceOptimization value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PriceOptimization() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PriceOptimization value)  $default,){
final _that = this;
switch (_that) {
case _PriceOptimization():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PriceOptimization value)?  $default,){
final _that = this;
switch (_that) {
case _PriceOptimization() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String serviceId,  String serviceName,  double currentPrice,  double optimalPrice,  double priceChange,  double percentageChange,  PriceImpact impact,  double confidence,  String recommendation)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PriceOptimization() when $default != null:
return $default(_that.serviceId,_that.serviceName,_that.currentPrice,_that.optimalPrice,_that.priceChange,_that.percentageChange,_that.impact,_that.confidence,_that.recommendation);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String serviceId,  String serviceName,  double currentPrice,  double optimalPrice,  double priceChange,  double percentageChange,  PriceImpact impact,  double confidence,  String recommendation)  $default,) {final _that = this;
switch (_that) {
case _PriceOptimization():
return $default(_that.serviceId,_that.serviceName,_that.currentPrice,_that.optimalPrice,_that.priceChange,_that.percentageChange,_that.impact,_that.confidence,_that.recommendation);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String serviceId,  String serviceName,  double currentPrice,  double optimalPrice,  double priceChange,  double percentageChange,  PriceImpact impact,  double confidence,  String recommendation)?  $default,) {final _that = this;
switch (_that) {
case _PriceOptimization() when $default != null:
return $default(_that.serviceId,_that.serviceName,_that.currentPrice,_that.optimalPrice,_that.priceChange,_that.percentageChange,_that.impact,_that.confidence,_that.recommendation);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PriceOptimization implements PriceOptimization {
  const _PriceOptimization({required this.serviceId, required this.serviceName, required this.currentPrice, required this.optimalPrice, required this.priceChange, required this.percentageChange, required this.impact, required this.confidence, required this.recommendation});
  factory _PriceOptimization.fromJson(Map<String, dynamic> json) => _$PriceOptimizationFromJson(json);

@override final  String serviceId;
@override final  String serviceName;
@override final  double currentPrice;
@override final  double optimalPrice;
@override final  double priceChange;
@override final  double percentageChange;
@override final  PriceImpact impact;
@override final  double confidence;
@override final  String recommendation;

/// Create a copy of PriceOptimization
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PriceOptimizationCopyWith<_PriceOptimization> get copyWith => __$PriceOptimizationCopyWithImpl<_PriceOptimization>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PriceOptimizationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PriceOptimization&&(identical(other.serviceId, serviceId) || other.serviceId == serviceId)&&(identical(other.serviceName, serviceName) || other.serviceName == serviceName)&&(identical(other.currentPrice, currentPrice) || other.currentPrice == currentPrice)&&(identical(other.optimalPrice, optimalPrice) || other.optimalPrice == optimalPrice)&&(identical(other.priceChange, priceChange) || other.priceChange == priceChange)&&(identical(other.percentageChange, percentageChange) || other.percentageChange == percentageChange)&&(identical(other.impact, impact) || other.impact == impact)&&(identical(other.confidence, confidence) || other.confidence == confidence)&&(identical(other.recommendation, recommendation) || other.recommendation == recommendation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,serviceId,serviceName,currentPrice,optimalPrice,priceChange,percentageChange,impact,confidence,recommendation);

@override
String toString() {
  return 'PriceOptimization(serviceId: $serviceId, serviceName: $serviceName, currentPrice: $currentPrice, optimalPrice: $optimalPrice, priceChange: $priceChange, percentageChange: $percentageChange, impact: $impact, confidence: $confidence, recommendation: $recommendation)';
}


}

/// @nodoc
abstract mixin class _$PriceOptimizationCopyWith<$Res> implements $PriceOptimizationCopyWith<$Res> {
  factory _$PriceOptimizationCopyWith(_PriceOptimization value, $Res Function(_PriceOptimization) _then) = __$PriceOptimizationCopyWithImpl;
@override @useResult
$Res call({
 String serviceId, String serviceName, double currentPrice, double optimalPrice, double priceChange, double percentageChange, PriceImpact impact, double confidence, String recommendation
});


@override $PriceImpactCopyWith<$Res> get impact;

}
/// @nodoc
class __$PriceOptimizationCopyWithImpl<$Res>
    implements _$PriceOptimizationCopyWith<$Res> {
  __$PriceOptimizationCopyWithImpl(this._self, this._then);

  final _PriceOptimization _self;
  final $Res Function(_PriceOptimization) _then;

/// Create a copy of PriceOptimization
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? serviceId = null,Object? serviceName = null,Object? currentPrice = null,Object? optimalPrice = null,Object? priceChange = null,Object? percentageChange = null,Object? impact = null,Object? confidence = null,Object? recommendation = null,}) {
  return _then(_PriceOptimization(
serviceId: null == serviceId ? _self.serviceId : serviceId // ignore: cast_nullable_to_non_nullable
as String,serviceName: null == serviceName ? _self.serviceName : serviceName // ignore: cast_nullable_to_non_nullable
as String,currentPrice: null == currentPrice ? _self.currentPrice : currentPrice // ignore: cast_nullable_to_non_nullable
as double,optimalPrice: null == optimalPrice ? _self.optimalPrice : optimalPrice // ignore: cast_nullable_to_non_nullable
as double,priceChange: null == priceChange ? _self.priceChange : priceChange // ignore: cast_nullable_to_non_nullable
as double,percentageChange: null == percentageChange ? _self.percentageChange : percentageChange // ignore: cast_nullable_to_non_nullable
as double,impact: null == impact ? _self.impact : impact // ignore: cast_nullable_to_non_nullable
as PriceImpact,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as double,recommendation: null == recommendation ? _self.recommendation : recommendation // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of PriceOptimization
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PriceImpactCopyWith<$Res> get impact {
  
  return $PriceImpactCopyWith<$Res>(_self.impact, (value) {
    return _then(_self.copyWith(impact: value));
  });
}
}


/// @nodoc
mixin _$PriceImpact {

 double get demandChange; double get revenueChange; double get marginChange;
/// Create a copy of PriceImpact
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PriceImpactCopyWith<PriceImpact> get copyWith => _$PriceImpactCopyWithImpl<PriceImpact>(this as PriceImpact, _$identity);

  /// Serializes this PriceImpact to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PriceImpact&&(identical(other.demandChange, demandChange) || other.demandChange == demandChange)&&(identical(other.revenueChange, revenueChange) || other.revenueChange == revenueChange)&&(identical(other.marginChange, marginChange) || other.marginChange == marginChange));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,demandChange,revenueChange,marginChange);

@override
String toString() {
  return 'PriceImpact(demandChange: $demandChange, revenueChange: $revenueChange, marginChange: $marginChange)';
}


}

/// @nodoc
abstract mixin class $PriceImpactCopyWith<$Res>  {
  factory $PriceImpactCopyWith(PriceImpact value, $Res Function(PriceImpact) _then) = _$PriceImpactCopyWithImpl;
@useResult
$Res call({
 double demandChange, double revenueChange, double marginChange
});




}
/// @nodoc
class _$PriceImpactCopyWithImpl<$Res>
    implements $PriceImpactCopyWith<$Res> {
  _$PriceImpactCopyWithImpl(this._self, this._then);

  final PriceImpact _self;
  final $Res Function(PriceImpact) _then;

/// Create a copy of PriceImpact
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? demandChange = null,Object? revenueChange = null,Object? marginChange = null,}) {
  return _then(_self.copyWith(
demandChange: null == demandChange ? _self.demandChange : demandChange // ignore: cast_nullable_to_non_nullable
as double,revenueChange: null == revenueChange ? _self.revenueChange : revenueChange // ignore: cast_nullable_to_non_nullable
as double,marginChange: null == marginChange ? _self.marginChange : marginChange // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [PriceImpact].
extension PriceImpactPatterns on PriceImpact {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PriceImpact value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PriceImpact() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PriceImpact value)  $default,){
final _that = this;
switch (_that) {
case _PriceImpact():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PriceImpact value)?  $default,){
final _that = this;
switch (_that) {
case _PriceImpact() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double demandChange,  double revenueChange,  double marginChange)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PriceImpact() when $default != null:
return $default(_that.demandChange,_that.revenueChange,_that.marginChange);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double demandChange,  double revenueChange,  double marginChange)  $default,) {final _that = this;
switch (_that) {
case _PriceImpact():
return $default(_that.demandChange,_that.revenueChange,_that.marginChange);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double demandChange,  double revenueChange,  double marginChange)?  $default,) {final _that = this;
switch (_that) {
case _PriceImpact() when $default != null:
return $default(_that.demandChange,_that.revenueChange,_that.marginChange);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PriceImpact implements PriceImpact {
  const _PriceImpact({required this.demandChange, required this.revenueChange, required this.marginChange});
  factory _PriceImpact.fromJson(Map<String, dynamic> json) => _$PriceImpactFromJson(json);

@override final  double demandChange;
@override final  double revenueChange;
@override final  double marginChange;

/// Create a copy of PriceImpact
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PriceImpactCopyWith<_PriceImpact> get copyWith => __$PriceImpactCopyWithImpl<_PriceImpact>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PriceImpactToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PriceImpact&&(identical(other.demandChange, demandChange) || other.demandChange == demandChange)&&(identical(other.revenueChange, revenueChange) || other.revenueChange == revenueChange)&&(identical(other.marginChange, marginChange) || other.marginChange == marginChange));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,demandChange,revenueChange,marginChange);

@override
String toString() {
  return 'PriceImpact(demandChange: $demandChange, revenueChange: $revenueChange, marginChange: $marginChange)';
}


}

/// @nodoc
abstract mixin class _$PriceImpactCopyWith<$Res> implements $PriceImpactCopyWith<$Res> {
  factory _$PriceImpactCopyWith(_PriceImpact value, $Res Function(_PriceImpact) _then) = __$PriceImpactCopyWithImpl;
@override @useResult
$Res call({
 double demandChange, double revenueChange, double marginChange
});




}
/// @nodoc
class __$PriceImpactCopyWithImpl<$Res>
    implements _$PriceImpactCopyWith<$Res> {
  __$PriceImpactCopyWithImpl(this._self, this._then);

  final _PriceImpact _self;
  final $Res Function(_PriceImpact) _then;

/// Create a copy of PriceImpact
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? demandChange = null,Object? revenueChange = null,Object? marginChange = null,}) {
  return _then(_PriceImpact(
demandChange: null == demandChange ? _self.demandChange : demandChange // ignore: cast_nullable_to_non_nullable
as double,revenueChange: null == revenueChange ? _self.revenueChange : revenueChange // ignore: cast_nullable_to_non_nullable
as double,marginChange: null == marginChange ? _self.marginChange : marginChange // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$ABTest {

 String get testId; String get organizationId; String get status; String get createdAt; Map<String, ABVariant> get variants; int get duration; int get minimumSampleSize; double get significanceLevel; List<String> get successMetrics;
/// Create a copy of ABTest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ABTestCopyWith<ABTest> get copyWith => _$ABTestCopyWithImpl<ABTest>(this as ABTest, _$identity);

  /// Serializes this ABTest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ABTest&&(identical(other.testId, testId) || other.testId == testId)&&(identical(other.organizationId, organizationId) || other.organizationId == organizationId)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other.variants, variants)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.minimumSampleSize, minimumSampleSize) || other.minimumSampleSize == minimumSampleSize)&&(identical(other.significanceLevel, significanceLevel) || other.significanceLevel == significanceLevel)&&const DeepCollectionEquality().equals(other.successMetrics, successMetrics));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,testId,organizationId,status,createdAt,const DeepCollectionEquality().hash(variants),duration,minimumSampleSize,significanceLevel,const DeepCollectionEquality().hash(successMetrics));

@override
String toString() {
  return 'ABTest(testId: $testId, organizationId: $organizationId, status: $status, createdAt: $createdAt, variants: $variants, duration: $duration, minimumSampleSize: $minimumSampleSize, significanceLevel: $significanceLevel, successMetrics: $successMetrics)';
}


}

/// @nodoc
abstract mixin class $ABTestCopyWith<$Res>  {
  factory $ABTestCopyWith(ABTest value, $Res Function(ABTest) _then) = _$ABTestCopyWithImpl;
@useResult
$Res call({
 String testId, String organizationId, String status, String createdAt, Map<String, ABVariant> variants, int duration, int minimumSampleSize, double significanceLevel, List<String> successMetrics
});




}
/// @nodoc
class _$ABTestCopyWithImpl<$Res>
    implements $ABTestCopyWith<$Res> {
  _$ABTestCopyWithImpl(this._self, this._then);

  final ABTest _self;
  final $Res Function(ABTest) _then;

/// Create a copy of ABTest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? testId = null,Object? organizationId = null,Object? status = null,Object? createdAt = null,Object? variants = null,Object? duration = null,Object? minimumSampleSize = null,Object? significanceLevel = null,Object? successMetrics = null,}) {
  return _then(_self.copyWith(
testId: null == testId ? _self.testId : testId // ignore: cast_nullable_to_non_nullable
as String,organizationId: null == organizationId ? _self.organizationId : organizationId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,variants: null == variants ? _self.variants : variants // ignore: cast_nullable_to_non_nullable
as Map<String, ABVariant>,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int,minimumSampleSize: null == minimumSampleSize ? _self.minimumSampleSize : minimumSampleSize // ignore: cast_nullable_to_non_nullable
as int,significanceLevel: null == significanceLevel ? _self.significanceLevel : significanceLevel // ignore: cast_nullable_to_non_nullable
as double,successMetrics: null == successMetrics ? _self.successMetrics : successMetrics // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [ABTest].
extension ABTestPatterns on ABTest {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ABTest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ABTest() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ABTest value)  $default,){
final _that = this;
switch (_that) {
case _ABTest():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ABTest value)?  $default,){
final _that = this;
switch (_that) {
case _ABTest() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String testId,  String organizationId,  String status,  String createdAt,  Map<String, ABVariant> variants,  int duration,  int minimumSampleSize,  double significanceLevel,  List<String> successMetrics)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ABTest() when $default != null:
return $default(_that.testId,_that.organizationId,_that.status,_that.createdAt,_that.variants,_that.duration,_that.minimumSampleSize,_that.significanceLevel,_that.successMetrics);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String testId,  String organizationId,  String status,  String createdAt,  Map<String, ABVariant> variants,  int duration,  int minimumSampleSize,  double significanceLevel,  List<String> successMetrics)  $default,) {final _that = this;
switch (_that) {
case _ABTest():
return $default(_that.testId,_that.organizationId,_that.status,_that.createdAt,_that.variants,_that.duration,_that.minimumSampleSize,_that.significanceLevel,_that.successMetrics);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String testId,  String organizationId,  String status,  String createdAt,  Map<String, ABVariant> variants,  int duration,  int minimumSampleSize,  double significanceLevel,  List<String> successMetrics)?  $default,) {final _that = this;
switch (_that) {
case _ABTest() when $default != null:
return $default(_that.testId,_that.organizationId,_that.status,_that.createdAt,_that.variants,_that.duration,_that.minimumSampleSize,_that.significanceLevel,_that.successMetrics);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ABTest implements ABTest {
  const _ABTest({required this.testId, required this.organizationId, required this.status, required this.createdAt, required final  Map<String, ABVariant> variants, required this.duration, required this.minimumSampleSize, required this.significanceLevel, required final  List<String> successMetrics}): _variants = variants,_successMetrics = successMetrics;
  factory _ABTest.fromJson(Map<String, dynamic> json) => _$ABTestFromJson(json);

@override final  String testId;
@override final  String organizationId;
@override final  String status;
@override final  String createdAt;
 final  Map<String, ABVariant> _variants;
@override Map<String, ABVariant> get variants {
  if (_variants is EqualUnmodifiableMapView) return _variants;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_variants);
}

@override final  int duration;
@override final  int minimumSampleSize;
@override final  double significanceLevel;
 final  List<String> _successMetrics;
@override List<String> get successMetrics {
  if (_successMetrics is EqualUnmodifiableListView) return _successMetrics;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_successMetrics);
}


/// Create a copy of ABTest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ABTestCopyWith<_ABTest> get copyWith => __$ABTestCopyWithImpl<_ABTest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ABTestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ABTest&&(identical(other.testId, testId) || other.testId == testId)&&(identical(other.organizationId, organizationId) || other.organizationId == organizationId)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other._variants, _variants)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.minimumSampleSize, minimumSampleSize) || other.minimumSampleSize == minimumSampleSize)&&(identical(other.significanceLevel, significanceLevel) || other.significanceLevel == significanceLevel)&&const DeepCollectionEquality().equals(other._successMetrics, _successMetrics));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,testId,organizationId,status,createdAt,const DeepCollectionEquality().hash(_variants),duration,minimumSampleSize,significanceLevel,const DeepCollectionEquality().hash(_successMetrics));

@override
String toString() {
  return 'ABTest(testId: $testId, organizationId: $organizationId, status: $status, createdAt: $createdAt, variants: $variants, duration: $duration, minimumSampleSize: $minimumSampleSize, significanceLevel: $significanceLevel, successMetrics: $successMetrics)';
}


}

/// @nodoc
abstract mixin class _$ABTestCopyWith<$Res> implements $ABTestCopyWith<$Res> {
  factory _$ABTestCopyWith(_ABTest value, $Res Function(_ABTest) _then) = __$ABTestCopyWithImpl;
@override @useResult
$Res call({
 String testId, String organizationId, String status, String createdAt, Map<String, ABVariant> variants, int duration, int minimumSampleSize, double significanceLevel, List<String> successMetrics
});




}
/// @nodoc
class __$ABTestCopyWithImpl<$Res>
    implements _$ABTestCopyWith<$Res> {
  __$ABTestCopyWithImpl(this._self, this._then);

  final _ABTest _self;
  final $Res Function(_ABTest) _then;

/// Create a copy of ABTest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? testId = null,Object? organizationId = null,Object? status = null,Object? createdAt = null,Object? variants = null,Object? duration = null,Object? minimumSampleSize = null,Object? significanceLevel = null,Object? successMetrics = null,}) {
  return _then(_ABTest(
testId: null == testId ? _self.testId : testId // ignore: cast_nullable_to_non_nullable
as String,organizationId: null == organizationId ? _self.organizationId : organizationId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,variants: null == variants ? _self._variants : variants // ignore: cast_nullable_to_non_nullable
as Map<String, ABVariant>,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int,minimumSampleSize: null == minimumSampleSize ? _self.minimumSampleSize : minimumSampleSize // ignore: cast_nullable_to_non_nullable
as int,significanceLevel: null == significanceLevel ? _self.significanceLevel : significanceLevel // ignore: cast_nullable_to_non_nullable
as double,successMetrics: null == successMetrics ? _self._successMetrics : successMetrics // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$ABVariant {

 String get name; double get price; double get allocation; ABMetrics get metrics;
/// Create a copy of ABVariant
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ABVariantCopyWith<ABVariant> get copyWith => _$ABVariantCopyWithImpl<ABVariant>(this as ABVariant, _$identity);

  /// Serializes this ABVariant to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ABVariant&&(identical(other.name, name) || other.name == name)&&(identical(other.price, price) || other.price == price)&&(identical(other.allocation, allocation) || other.allocation == allocation)&&(identical(other.metrics, metrics) || other.metrics == metrics));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,price,allocation,metrics);

@override
String toString() {
  return 'ABVariant(name: $name, price: $price, allocation: $allocation, metrics: $metrics)';
}


}

/// @nodoc
abstract mixin class $ABVariantCopyWith<$Res>  {
  factory $ABVariantCopyWith(ABVariant value, $Res Function(ABVariant) _then) = _$ABVariantCopyWithImpl;
@useResult
$Res call({
 String name, double price, double allocation, ABMetrics metrics
});


$ABMetricsCopyWith<$Res> get metrics;

}
/// @nodoc
class _$ABVariantCopyWithImpl<$Res>
    implements $ABVariantCopyWith<$Res> {
  _$ABVariantCopyWithImpl(this._self, this._then);

  final ABVariant _self;
  final $Res Function(ABVariant) _then;

/// Create a copy of ABVariant
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? price = null,Object? allocation = null,Object? metrics = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,allocation: null == allocation ? _self.allocation : allocation // ignore: cast_nullable_to_non_nullable
as double,metrics: null == metrics ? _self.metrics : metrics // ignore: cast_nullable_to_non_nullable
as ABMetrics,
  ));
}
/// Create a copy of ABVariant
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ABMetricsCopyWith<$Res> get metrics {
  
  return $ABMetricsCopyWith<$Res>(_self.metrics, (value) {
    return _then(_self.copyWith(metrics: value));
  });
}
}


/// Adds pattern-matching-related methods to [ABVariant].
extension ABVariantPatterns on ABVariant {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ABVariant value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ABVariant() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ABVariant value)  $default,){
final _that = this;
switch (_that) {
case _ABVariant():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ABVariant value)?  $default,){
final _that = this;
switch (_that) {
case _ABVariant() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  double price,  double allocation,  ABMetrics metrics)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ABVariant() when $default != null:
return $default(_that.name,_that.price,_that.allocation,_that.metrics);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  double price,  double allocation,  ABMetrics metrics)  $default,) {final _that = this;
switch (_that) {
case _ABVariant():
return $default(_that.name,_that.price,_that.allocation,_that.metrics);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  double price,  double allocation,  ABMetrics metrics)?  $default,) {final _that = this;
switch (_that) {
case _ABVariant() when $default != null:
return $default(_that.name,_that.price,_that.allocation,_that.metrics);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ABVariant implements ABVariant {
  const _ABVariant({required this.name, required this.price, required this.allocation, required this.metrics});
  factory _ABVariant.fromJson(Map<String, dynamic> json) => _$ABVariantFromJson(json);

@override final  String name;
@override final  double price;
@override final  double allocation;
@override final  ABMetrics metrics;

/// Create a copy of ABVariant
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ABVariantCopyWith<_ABVariant> get copyWith => __$ABVariantCopyWithImpl<_ABVariant>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ABVariantToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ABVariant&&(identical(other.name, name) || other.name == name)&&(identical(other.price, price) || other.price == price)&&(identical(other.allocation, allocation) || other.allocation == allocation)&&(identical(other.metrics, metrics) || other.metrics == metrics));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,price,allocation,metrics);

@override
String toString() {
  return 'ABVariant(name: $name, price: $price, allocation: $allocation, metrics: $metrics)';
}


}

/// @nodoc
abstract mixin class _$ABVariantCopyWith<$Res> implements $ABVariantCopyWith<$Res> {
  factory _$ABVariantCopyWith(_ABVariant value, $Res Function(_ABVariant) _then) = __$ABVariantCopyWithImpl;
@override @useResult
$Res call({
 String name, double price, double allocation, ABMetrics metrics
});


@override $ABMetricsCopyWith<$Res> get metrics;

}
/// @nodoc
class __$ABVariantCopyWithImpl<$Res>
    implements _$ABVariantCopyWith<$Res> {
  __$ABVariantCopyWithImpl(this._self, this._then);

  final _ABVariant _self;
  final $Res Function(_ABVariant) _then;

/// Create a copy of ABVariant
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? price = null,Object? allocation = null,Object? metrics = null,}) {
  return _then(_ABVariant(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,allocation: null == allocation ? _self.allocation : allocation // ignore: cast_nullable_to_non_nullable
as double,metrics: null == metrics ? _self.metrics : metrics // ignore: cast_nullable_to_non_nullable
as ABMetrics,
  ));
}

/// Create a copy of ABVariant
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ABMetricsCopyWith<$Res> get metrics {
  
  return $ABMetricsCopyWith<$Res>(_self.metrics, (value) {
    return _then(_self.copyWith(metrics: value));
  });
}
}


/// @nodoc
mixin _$ABMetrics {

 int get conversions; double get revenue; int get sampleSize;
/// Create a copy of ABMetrics
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ABMetricsCopyWith<ABMetrics> get copyWith => _$ABMetricsCopyWithImpl<ABMetrics>(this as ABMetrics, _$identity);

  /// Serializes this ABMetrics to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ABMetrics&&(identical(other.conversions, conversions) || other.conversions == conversions)&&(identical(other.revenue, revenue) || other.revenue == revenue)&&(identical(other.sampleSize, sampleSize) || other.sampleSize == sampleSize));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,conversions,revenue,sampleSize);

@override
String toString() {
  return 'ABMetrics(conversions: $conversions, revenue: $revenue, sampleSize: $sampleSize)';
}


}

/// @nodoc
abstract mixin class $ABMetricsCopyWith<$Res>  {
  factory $ABMetricsCopyWith(ABMetrics value, $Res Function(ABMetrics) _then) = _$ABMetricsCopyWithImpl;
@useResult
$Res call({
 int conversions, double revenue, int sampleSize
});




}
/// @nodoc
class _$ABMetricsCopyWithImpl<$Res>
    implements $ABMetricsCopyWith<$Res> {
  _$ABMetricsCopyWithImpl(this._self, this._then);

  final ABMetrics _self;
  final $Res Function(ABMetrics) _then;

/// Create a copy of ABMetrics
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? conversions = null,Object? revenue = null,Object? sampleSize = null,}) {
  return _then(_self.copyWith(
conversions: null == conversions ? _self.conversions : conversions // ignore: cast_nullable_to_non_nullable
as int,revenue: null == revenue ? _self.revenue : revenue // ignore: cast_nullable_to_non_nullable
as double,sampleSize: null == sampleSize ? _self.sampleSize : sampleSize // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ABMetrics].
extension ABMetricsPatterns on ABMetrics {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ABMetrics value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ABMetrics() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ABMetrics value)  $default,){
final _that = this;
switch (_that) {
case _ABMetrics():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ABMetrics value)?  $default,){
final _that = this;
switch (_that) {
case _ABMetrics() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int conversions,  double revenue,  int sampleSize)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ABMetrics() when $default != null:
return $default(_that.conversions,_that.revenue,_that.sampleSize);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int conversions,  double revenue,  int sampleSize)  $default,) {final _that = this;
switch (_that) {
case _ABMetrics():
return $default(_that.conversions,_that.revenue,_that.sampleSize);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int conversions,  double revenue,  int sampleSize)?  $default,) {final _that = this;
switch (_that) {
case _ABMetrics() when $default != null:
return $default(_that.conversions,_that.revenue,_that.sampleSize);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ABMetrics implements ABMetrics {
  const _ABMetrics({required this.conversions, required this.revenue, required this.sampleSize});
  factory _ABMetrics.fromJson(Map<String, dynamic> json) => _$ABMetricsFromJson(json);

@override final  int conversions;
@override final  double revenue;
@override final  int sampleSize;

/// Create a copy of ABMetrics
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ABMetricsCopyWith<_ABMetrics> get copyWith => __$ABMetricsCopyWithImpl<_ABMetrics>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ABMetricsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ABMetrics&&(identical(other.conversions, conversions) || other.conversions == conversions)&&(identical(other.revenue, revenue) || other.revenue == revenue)&&(identical(other.sampleSize, sampleSize) || other.sampleSize == sampleSize));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,conversions,revenue,sampleSize);

@override
String toString() {
  return 'ABMetrics(conversions: $conversions, revenue: $revenue, sampleSize: $sampleSize)';
}


}

/// @nodoc
abstract mixin class _$ABMetricsCopyWith<$Res> implements $ABMetricsCopyWith<$Res> {
  factory _$ABMetricsCopyWith(_ABMetrics value, $Res Function(_ABMetrics) _then) = __$ABMetricsCopyWithImpl;
@override @useResult
$Res call({
 int conversions, double revenue, int sampleSize
});




}
/// @nodoc
class __$ABMetricsCopyWithImpl<$Res>
    implements _$ABMetricsCopyWith<$Res> {
  __$ABMetricsCopyWithImpl(this._self, this._then);

  final _ABMetrics _self;
  final $Res Function(_ABMetrics) _then;

/// Create a copy of ABMetrics
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? conversions = null,Object? revenue = null,Object? sampleSize = null,}) {
  return _then(_ABMetrics(
conversions: null == conversions ? _self.conversions : conversions // ignore: cast_nullable_to_non_nullable
as int,revenue: null == revenue ? _self.revenue : revenue // ignore: cast_nullable_to_non_nullable
as double,sampleSize: null == sampleSize ? _self.sampleSize : sampleSize // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$PricingRecommendations {

 String get serviceId; String get analyzedAt; CurrentPricing get current; List<PricingStrategy> get strategies; MarketInsights get marketInsights; String get topRecommendation; String get reasoning;
/// Create a copy of PricingRecommendations
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PricingRecommendationsCopyWith<PricingRecommendations> get copyWith => _$PricingRecommendationsCopyWithImpl<PricingRecommendations>(this as PricingRecommendations, _$identity);

  /// Serializes this PricingRecommendations to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PricingRecommendations&&(identical(other.serviceId, serviceId) || other.serviceId == serviceId)&&(identical(other.analyzedAt, analyzedAt) || other.analyzedAt == analyzedAt)&&(identical(other.current, current) || other.current == current)&&const DeepCollectionEquality().equals(other.strategies, strategies)&&(identical(other.marketInsights, marketInsights) || other.marketInsights == marketInsights)&&(identical(other.topRecommendation, topRecommendation) || other.topRecommendation == topRecommendation)&&(identical(other.reasoning, reasoning) || other.reasoning == reasoning));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,serviceId,analyzedAt,current,const DeepCollectionEquality().hash(strategies),marketInsights,topRecommendation,reasoning);

@override
String toString() {
  return 'PricingRecommendations(serviceId: $serviceId, analyzedAt: $analyzedAt, current: $current, strategies: $strategies, marketInsights: $marketInsights, topRecommendation: $topRecommendation, reasoning: $reasoning)';
}


}

/// @nodoc
abstract mixin class $PricingRecommendationsCopyWith<$Res>  {
  factory $PricingRecommendationsCopyWith(PricingRecommendations value, $Res Function(PricingRecommendations) _then) = _$PricingRecommendationsCopyWithImpl;
@useResult
$Res call({
 String serviceId, String analyzedAt, CurrentPricing current, List<PricingStrategy> strategies, MarketInsights marketInsights, String topRecommendation, String reasoning
});


$CurrentPricingCopyWith<$Res> get current;$MarketInsightsCopyWith<$Res> get marketInsights;

}
/// @nodoc
class _$PricingRecommendationsCopyWithImpl<$Res>
    implements $PricingRecommendationsCopyWith<$Res> {
  _$PricingRecommendationsCopyWithImpl(this._self, this._then);

  final PricingRecommendations _self;
  final $Res Function(PricingRecommendations) _then;

/// Create a copy of PricingRecommendations
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? serviceId = null,Object? analyzedAt = null,Object? current = null,Object? strategies = null,Object? marketInsights = null,Object? topRecommendation = null,Object? reasoning = null,}) {
  return _then(_self.copyWith(
serviceId: null == serviceId ? _self.serviceId : serviceId // ignore: cast_nullable_to_non_nullable
as String,analyzedAt: null == analyzedAt ? _self.analyzedAt : analyzedAt // ignore: cast_nullable_to_non_nullable
as String,current: null == current ? _self.current : current // ignore: cast_nullable_to_non_nullable
as CurrentPricing,strategies: null == strategies ? _self.strategies : strategies // ignore: cast_nullable_to_non_nullable
as List<PricingStrategy>,marketInsights: null == marketInsights ? _self.marketInsights : marketInsights // ignore: cast_nullable_to_non_nullable
as MarketInsights,topRecommendation: null == topRecommendation ? _self.topRecommendation : topRecommendation // ignore: cast_nullable_to_non_nullable
as String,reasoning: null == reasoning ? _self.reasoning : reasoning // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of PricingRecommendations
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CurrentPricingCopyWith<$Res> get current {
  
  return $CurrentPricingCopyWith<$Res>(_self.current, (value) {
    return _then(_self.copyWith(current: value));
  });
}/// Create a copy of PricingRecommendations
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MarketInsightsCopyWith<$Res> get marketInsights {
  
  return $MarketInsightsCopyWith<$Res>(_self.marketInsights, (value) {
    return _then(_self.copyWith(marketInsights: value));
  });
}
}


/// Adds pattern-matching-related methods to [PricingRecommendations].
extension PricingRecommendationsPatterns on PricingRecommendations {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PricingRecommendations value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PricingRecommendations() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PricingRecommendations value)  $default,){
final _that = this;
switch (_that) {
case _PricingRecommendations():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PricingRecommendations value)?  $default,){
final _that = this;
switch (_that) {
case _PricingRecommendations() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String serviceId,  String analyzedAt,  CurrentPricing current,  List<PricingStrategy> strategies,  MarketInsights marketInsights,  String topRecommendation,  String reasoning)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PricingRecommendations() when $default != null:
return $default(_that.serviceId,_that.analyzedAt,_that.current,_that.strategies,_that.marketInsights,_that.topRecommendation,_that.reasoning);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String serviceId,  String analyzedAt,  CurrentPricing current,  List<PricingStrategy> strategies,  MarketInsights marketInsights,  String topRecommendation,  String reasoning)  $default,) {final _that = this;
switch (_that) {
case _PricingRecommendations():
return $default(_that.serviceId,_that.analyzedAt,_that.current,_that.strategies,_that.marketInsights,_that.topRecommendation,_that.reasoning);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String serviceId,  String analyzedAt,  CurrentPricing current,  List<PricingStrategy> strategies,  MarketInsights marketInsights,  String topRecommendation,  String reasoning)?  $default,) {final _that = this;
switch (_that) {
case _PricingRecommendations() when $default != null:
return $default(_that.serviceId,_that.analyzedAt,_that.current,_that.strategies,_that.marketInsights,_that.topRecommendation,_that.reasoning);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PricingRecommendations implements PricingRecommendations {
  const _PricingRecommendations({required this.serviceId, required this.analyzedAt, required this.current, required final  List<PricingStrategy> strategies, required this.marketInsights, required this.topRecommendation, required this.reasoning}): _strategies = strategies;
  factory _PricingRecommendations.fromJson(Map<String, dynamic> json) => _$PricingRecommendationsFromJson(json);

@override final  String serviceId;
@override final  String analyzedAt;
@override final  CurrentPricing current;
 final  List<PricingStrategy> _strategies;
@override List<PricingStrategy> get strategies {
  if (_strategies is EqualUnmodifiableListView) return _strategies;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_strategies);
}

@override final  MarketInsights marketInsights;
@override final  String topRecommendation;
@override final  String reasoning;

/// Create a copy of PricingRecommendations
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PricingRecommendationsCopyWith<_PricingRecommendations> get copyWith => __$PricingRecommendationsCopyWithImpl<_PricingRecommendations>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PricingRecommendationsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PricingRecommendations&&(identical(other.serviceId, serviceId) || other.serviceId == serviceId)&&(identical(other.analyzedAt, analyzedAt) || other.analyzedAt == analyzedAt)&&(identical(other.current, current) || other.current == current)&&const DeepCollectionEquality().equals(other._strategies, _strategies)&&(identical(other.marketInsights, marketInsights) || other.marketInsights == marketInsights)&&(identical(other.topRecommendation, topRecommendation) || other.topRecommendation == topRecommendation)&&(identical(other.reasoning, reasoning) || other.reasoning == reasoning));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,serviceId,analyzedAt,current,const DeepCollectionEquality().hash(_strategies),marketInsights,topRecommendation,reasoning);

@override
String toString() {
  return 'PricingRecommendations(serviceId: $serviceId, analyzedAt: $analyzedAt, current: $current, strategies: $strategies, marketInsights: $marketInsights, topRecommendation: $topRecommendation, reasoning: $reasoning)';
}


}

/// @nodoc
abstract mixin class _$PricingRecommendationsCopyWith<$Res> implements $PricingRecommendationsCopyWith<$Res> {
  factory _$PricingRecommendationsCopyWith(_PricingRecommendations value, $Res Function(_PricingRecommendations) _then) = __$PricingRecommendationsCopyWithImpl;
@override @useResult
$Res call({
 String serviceId, String analyzedAt, CurrentPricing current, List<PricingStrategy> strategies, MarketInsights marketInsights, String topRecommendation, String reasoning
});


@override $CurrentPricingCopyWith<$Res> get current;@override $MarketInsightsCopyWith<$Res> get marketInsights;

}
/// @nodoc
class __$PricingRecommendationsCopyWithImpl<$Res>
    implements _$PricingRecommendationsCopyWith<$Res> {
  __$PricingRecommendationsCopyWithImpl(this._self, this._then);

  final _PricingRecommendations _self;
  final $Res Function(_PricingRecommendations) _then;

/// Create a copy of PricingRecommendations
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? serviceId = null,Object? analyzedAt = null,Object? current = null,Object? strategies = null,Object? marketInsights = null,Object? topRecommendation = null,Object? reasoning = null,}) {
  return _then(_PricingRecommendations(
serviceId: null == serviceId ? _self.serviceId : serviceId // ignore: cast_nullable_to_non_nullable
as String,analyzedAt: null == analyzedAt ? _self.analyzedAt : analyzedAt // ignore: cast_nullable_to_non_nullable
as String,current: null == current ? _self.current : current // ignore: cast_nullable_to_non_nullable
as CurrentPricing,strategies: null == strategies ? _self._strategies : strategies // ignore: cast_nullable_to_non_nullable
as List<PricingStrategy>,marketInsights: null == marketInsights ? _self.marketInsights : marketInsights // ignore: cast_nullable_to_non_nullable
as MarketInsights,topRecommendation: null == topRecommendation ? _self.topRecommendation : topRecommendation // ignore: cast_nullable_to_non_nullable
as String,reasoning: null == reasoning ? _self.reasoning : reasoning // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of PricingRecommendations
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CurrentPricingCopyWith<$Res> get current {
  
  return $CurrentPricingCopyWith<$Res>(_self.current, (value) {
    return _then(_self.copyWith(current: value));
  });
}/// Create a copy of PricingRecommendations
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MarketInsightsCopyWith<$Res> get marketInsights {
  
  return $MarketInsightsCopyWith<$Res>(_self.marketInsights, (value) {
    return _then(_self.copyWith(marketInsights: value));
  });
}
}


/// @nodoc
mixin _$CurrentPricing {

 double get price; double get demand; double get margin; String get competitiveness;
/// Create a copy of CurrentPricing
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CurrentPricingCopyWith<CurrentPricing> get copyWith => _$CurrentPricingCopyWithImpl<CurrentPricing>(this as CurrentPricing, _$identity);

  /// Serializes this CurrentPricing to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CurrentPricing&&(identical(other.price, price) || other.price == price)&&(identical(other.demand, demand) || other.demand == demand)&&(identical(other.margin, margin) || other.margin == margin)&&(identical(other.competitiveness, competitiveness) || other.competitiveness == competitiveness));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,price,demand,margin,competitiveness);

@override
String toString() {
  return 'CurrentPricing(price: $price, demand: $demand, margin: $margin, competitiveness: $competitiveness)';
}


}

/// @nodoc
abstract mixin class $CurrentPricingCopyWith<$Res>  {
  factory $CurrentPricingCopyWith(CurrentPricing value, $Res Function(CurrentPricing) _then) = _$CurrentPricingCopyWithImpl;
@useResult
$Res call({
 double price, double demand, double margin, String competitiveness
});




}
/// @nodoc
class _$CurrentPricingCopyWithImpl<$Res>
    implements $CurrentPricingCopyWith<$Res> {
  _$CurrentPricingCopyWithImpl(this._self, this._then);

  final CurrentPricing _self;
  final $Res Function(CurrentPricing) _then;

/// Create a copy of CurrentPricing
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? price = null,Object? demand = null,Object? margin = null,Object? competitiveness = null,}) {
  return _then(_self.copyWith(
price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,demand: null == demand ? _self.demand : demand // ignore: cast_nullable_to_non_nullable
as double,margin: null == margin ? _self.margin : margin // ignore: cast_nullable_to_non_nullable
as double,competitiveness: null == competitiveness ? _self.competitiveness : competitiveness // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CurrentPricing].
extension CurrentPricingPatterns on CurrentPricing {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CurrentPricing value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CurrentPricing() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CurrentPricing value)  $default,){
final _that = this;
switch (_that) {
case _CurrentPricing():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CurrentPricing value)?  $default,){
final _that = this;
switch (_that) {
case _CurrentPricing() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double price,  double demand,  double margin,  String competitiveness)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CurrentPricing() when $default != null:
return $default(_that.price,_that.demand,_that.margin,_that.competitiveness);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double price,  double demand,  double margin,  String competitiveness)  $default,) {final _that = this;
switch (_that) {
case _CurrentPricing():
return $default(_that.price,_that.demand,_that.margin,_that.competitiveness);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double price,  double demand,  double margin,  String competitiveness)?  $default,) {final _that = this;
switch (_that) {
case _CurrentPricing() when $default != null:
return $default(_that.price,_that.demand,_that.margin,_that.competitiveness);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CurrentPricing implements CurrentPricing {
  const _CurrentPricing({required this.price, required this.demand, required this.margin, required this.competitiveness});
  factory _CurrentPricing.fromJson(Map<String, dynamic> json) => _$CurrentPricingFromJson(json);

@override final  double price;
@override final  double demand;
@override final  double margin;
@override final  String competitiveness;

/// Create a copy of CurrentPricing
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CurrentPricingCopyWith<_CurrentPricing> get copyWith => __$CurrentPricingCopyWithImpl<_CurrentPricing>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CurrentPricingToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CurrentPricing&&(identical(other.price, price) || other.price == price)&&(identical(other.demand, demand) || other.demand == demand)&&(identical(other.margin, margin) || other.margin == margin)&&(identical(other.competitiveness, competitiveness) || other.competitiveness == competitiveness));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,price,demand,margin,competitiveness);

@override
String toString() {
  return 'CurrentPricing(price: $price, demand: $demand, margin: $margin, competitiveness: $competitiveness)';
}


}

/// @nodoc
abstract mixin class _$CurrentPricingCopyWith<$Res> implements $CurrentPricingCopyWith<$Res> {
  factory _$CurrentPricingCopyWith(_CurrentPricing value, $Res Function(_CurrentPricing) _then) = __$CurrentPricingCopyWithImpl;
@override @useResult
$Res call({
 double price, double demand, double margin, String competitiveness
});




}
/// @nodoc
class __$CurrentPricingCopyWithImpl<$Res>
    implements _$CurrentPricingCopyWith<$Res> {
  __$CurrentPricingCopyWithImpl(this._self, this._then);

  final _CurrentPricing _self;
  final $Res Function(_CurrentPricing) _then;

/// Create a copy of CurrentPricing
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? price = null,Object? demand = null,Object? margin = null,Object? competitiveness = null,}) {
  return _then(_CurrentPricing(
price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,demand: null == demand ? _self.demand : demand // ignore: cast_nullable_to_non_nullable
as double,margin: null == margin ? _self.margin : margin // ignore: cast_nullable_to_non_nullable
as double,competitiveness: null == competitiveness ? _self.competitiveness : competitiveness // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$PricingStrategy {

 String get strategy; double get recommendedPrice; double get expectedRevenue; double get expectedMargin; List<String> get pros; List<String> get cons; double get confidence;
/// Create a copy of PricingStrategy
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PricingStrategyCopyWith<PricingStrategy> get copyWith => _$PricingStrategyCopyWithImpl<PricingStrategy>(this as PricingStrategy, _$identity);

  /// Serializes this PricingStrategy to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PricingStrategy&&(identical(other.strategy, strategy) || other.strategy == strategy)&&(identical(other.recommendedPrice, recommendedPrice) || other.recommendedPrice == recommendedPrice)&&(identical(other.expectedRevenue, expectedRevenue) || other.expectedRevenue == expectedRevenue)&&(identical(other.expectedMargin, expectedMargin) || other.expectedMargin == expectedMargin)&&const DeepCollectionEquality().equals(other.pros, pros)&&const DeepCollectionEquality().equals(other.cons, cons)&&(identical(other.confidence, confidence) || other.confidence == confidence));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,strategy,recommendedPrice,expectedRevenue,expectedMargin,const DeepCollectionEquality().hash(pros),const DeepCollectionEquality().hash(cons),confidence);

@override
String toString() {
  return 'PricingStrategy(strategy: $strategy, recommendedPrice: $recommendedPrice, expectedRevenue: $expectedRevenue, expectedMargin: $expectedMargin, pros: $pros, cons: $cons, confidence: $confidence)';
}


}

/// @nodoc
abstract mixin class $PricingStrategyCopyWith<$Res>  {
  factory $PricingStrategyCopyWith(PricingStrategy value, $Res Function(PricingStrategy) _then) = _$PricingStrategyCopyWithImpl;
@useResult
$Res call({
 String strategy, double recommendedPrice, double expectedRevenue, double expectedMargin, List<String> pros, List<String> cons, double confidence
});




}
/// @nodoc
class _$PricingStrategyCopyWithImpl<$Res>
    implements $PricingStrategyCopyWith<$Res> {
  _$PricingStrategyCopyWithImpl(this._self, this._then);

  final PricingStrategy _self;
  final $Res Function(PricingStrategy) _then;

/// Create a copy of PricingStrategy
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? strategy = null,Object? recommendedPrice = null,Object? expectedRevenue = null,Object? expectedMargin = null,Object? pros = null,Object? cons = null,Object? confidence = null,}) {
  return _then(_self.copyWith(
strategy: null == strategy ? _self.strategy : strategy // ignore: cast_nullable_to_non_nullable
as String,recommendedPrice: null == recommendedPrice ? _self.recommendedPrice : recommendedPrice // ignore: cast_nullable_to_non_nullable
as double,expectedRevenue: null == expectedRevenue ? _self.expectedRevenue : expectedRevenue // ignore: cast_nullable_to_non_nullable
as double,expectedMargin: null == expectedMargin ? _self.expectedMargin : expectedMargin // ignore: cast_nullable_to_non_nullable
as double,pros: null == pros ? _self.pros : pros // ignore: cast_nullable_to_non_nullable
as List<String>,cons: null == cons ? _self.cons : cons // ignore: cast_nullable_to_non_nullable
as List<String>,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [PricingStrategy].
extension PricingStrategyPatterns on PricingStrategy {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PricingStrategy value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PricingStrategy() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PricingStrategy value)  $default,){
final _that = this;
switch (_that) {
case _PricingStrategy():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PricingStrategy value)?  $default,){
final _that = this;
switch (_that) {
case _PricingStrategy() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String strategy,  double recommendedPrice,  double expectedRevenue,  double expectedMargin,  List<String> pros,  List<String> cons,  double confidence)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PricingStrategy() when $default != null:
return $default(_that.strategy,_that.recommendedPrice,_that.expectedRevenue,_that.expectedMargin,_that.pros,_that.cons,_that.confidence);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String strategy,  double recommendedPrice,  double expectedRevenue,  double expectedMargin,  List<String> pros,  List<String> cons,  double confidence)  $default,) {final _that = this;
switch (_that) {
case _PricingStrategy():
return $default(_that.strategy,_that.recommendedPrice,_that.expectedRevenue,_that.expectedMargin,_that.pros,_that.cons,_that.confidence);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String strategy,  double recommendedPrice,  double expectedRevenue,  double expectedMargin,  List<String> pros,  List<String> cons,  double confidence)?  $default,) {final _that = this;
switch (_that) {
case _PricingStrategy() when $default != null:
return $default(_that.strategy,_that.recommendedPrice,_that.expectedRevenue,_that.expectedMargin,_that.pros,_that.cons,_that.confidence);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PricingStrategy implements PricingStrategy {
  const _PricingStrategy({required this.strategy, required this.recommendedPrice, required this.expectedRevenue, required this.expectedMargin, required final  List<String> pros, required final  List<String> cons, required this.confidence}): _pros = pros,_cons = cons;
  factory _PricingStrategy.fromJson(Map<String, dynamic> json) => _$PricingStrategyFromJson(json);

@override final  String strategy;
@override final  double recommendedPrice;
@override final  double expectedRevenue;
@override final  double expectedMargin;
 final  List<String> _pros;
@override List<String> get pros {
  if (_pros is EqualUnmodifiableListView) return _pros;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_pros);
}

 final  List<String> _cons;
@override List<String> get cons {
  if (_cons is EqualUnmodifiableListView) return _cons;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cons);
}

@override final  double confidence;

/// Create a copy of PricingStrategy
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PricingStrategyCopyWith<_PricingStrategy> get copyWith => __$PricingStrategyCopyWithImpl<_PricingStrategy>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PricingStrategyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PricingStrategy&&(identical(other.strategy, strategy) || other.strategy == strategy)&&(identical(other.recommendedPrice, recommendedPrice) || other.recommendedPrice == recommendedPrice)&&(identical(other.expectedRevenue, expectedRevenue) || other.expectedRevenue == expectedRevenue)&&(identical(other.expectedMargin, expectedMargin) || other.expectedMargin == expectedMargin)&&const DeepCollectionEquality().equals(other._pros, _pros)&&const DeepCollectionEquality().equals(other._cons, _cons)&&(identical(other.confidence, confidence) || other.confidence == confidence));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,strategy,recommendedPrice,expectedRevenue,expectedMargin,const DeepCollectionEquality().hash(_pros),const DeepCollectionEquality().hash(_cons),confidence);

@override
String toString() {
  return 'PricingStrategy(strategy: $strategy, recommendedPrice: $recommendedPrice, expectedRevenue: $expectedRevenue, expectedMargin: $expectedMargin, pros: $pros, cons: $cons, confidence: $confidence)';
}


}

/// @nodoc
abstract mixin class _$PricingStrategyCopyWith<$Res> implements $PricingStrategyCopyWith<$Res> {
  factory _$PricingStrategyCopyWith(_PricingStrategy value, $Res Function(_PricingStrategy) _then) = __$PricingStrategyCopyWithImpl;
@override @useResult
$Res call({
 String strategy, double recommendedPrice, double expectedRevenue, double expectedMargin, List<String> pros, List<String> cons, double confidence
});




}
/// @nodoc
class __$PricingStrategyCopyWithImpl<$Res>
    implements _$PricingStrategyCopyWith<$Res> {
  __$PricingStrategyCopyWithImpl(this._self, this._then);

  final _PricingStrategy _self;
  final $Res Function(_PricingStrategy) _then;

/// Create a copy of PricingStrategy
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? strategy = null,Object? recommendedPrice = null,Object? expectedRevenue = null,Object? expectedMargin = null,Object? pros = null,Object? cons = null,Object? confidence = null,}) {
  return _then(_PricingStrategy(
strategy: null == strategy ? _self.strategy : strategy // ignore: cast_nullable_to_non_nullable
as String,recommendedPrice: null == recommendedPrice ? _self.recommendedPrice : recommendedPrice // ignore: cast_nullable_to_non_nullable
as double,expectedRevenue: null == expectedRevenue ? _self.expectedRevenue : expectedRevenue // ignore: cast_nullable_to_non_nullable
as double,expectedMargin: null == expectedMargin ? _self.expectedMargin : expectedMargin // ignore: cast_nullable_to_non_nullable
as double,pros: null == pros ? _self._pros : pros // ignore: cast_nullable_to_non_nullable
as List<String>,cons: null == cons ? _self._cons : cons // ignore: cast_nullable_to_non_nullable
as List<String>,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$MarketInsights {

 CompetitorPricing get competitorPricing; double get demandElasticity; double get priceOptimizationPotential;
/// Create a copy of MarketInsights
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MarketInsightsCopyWith<MarketInsights> get copyWith => _$MarketInsightsCopyWithImpl<MarketInsights>(this as MarketInsights, _$identity);

  /// Serializes this MarketInsights to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MarketInsights&&(identical(other.competitorPricing, competitorPricing) || other.competitorPricing == competitorPricing)&&(identical(other.demandElasticity, demandElasticity) || other.demandElasticity == demandElasticity)&&(identical(other.priceOptimizationPotential, priceOptimizationPotential) || other.priceOptimizationPotential == priceOptimizationPotential));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,competitorPricing,demandElasticity,priceOptimizationPotential);

@override
String toString() {
  return 'MarketInsights(competitorPricing: $competitorPricing, demandElasticity: $demandElasticity, priceOptimizationPotential: $priceOptimizationPotential)';
}


}

/// @nodoc
abstract mixin class $MarketInsightsCopyWith<$Res>  {
  factory $MarketInsightsCopyWith(MarketInsights value, $Res Function(MarketInsights) _then) = _$MarketInsightsCopyWithImpl;
@useResult
$Res call({
 CompetitorPricing competitorPricing, double demandElasticity, double priceOptimizationPotential
});


$CompetitorPricingCopyWith<$Res> get competitorPricing;

}
/// @nodoc
class _$MarketInsightsCopyWithImpl<$Res>
    implements $MarketInsightsCopyWith<$Res> {
  _$MarketInsightsCopyWithImpl(this._self, this._then);

  final MarketInsights _self;
  final $Res Function(MarketInsights) _then;

/// Create a copy of MarketInsights
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? competitorPricing = null,Object? demandElasticity = null,Object? priceOptimizationPotential = null,}) {
  return _then(_self.copyWith(
competitorPricing: null == competitorPricing ? _self.competitorPricing : competitorPricing // ignore: cast_nullable_to_non_nullable
as CompetitorPricing,demandElasticity: null == demandElasticity ? _self.demandElasticity : demandElasticity // ignore: cast_nullable_to_non_nullable
as double,priceOptimizationPotential: null == priceOptimizationPotential ? _self.priceOptimizationPotential : priceOptimizationPotential // ignore: cast_nullable_to_non_nullable
as double,
  ));
}
/// Create a copy of MarketInsights
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CompetitorPricingCopyWith<$Res> get competitorPricing {
  
  return $CompetitorPricingCopyWith<$Res>(_self.competitorPricing, (value) {
    return _then(_self.copyWith(competitorPricing: value));
  });
}
}


/// Adds pattern-matching-related methods to [MarketInsights].
extension MarketInsightsPatterns on MarketInsights {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MarketInsights value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MarketInsights() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MarketInsights value)  $default,){
final _that = this;
switch (_that) {
case _MarketInsights():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MarketInsights value)?  $default,){
final _that = this;
switch (_that) {
case _MarketInsights() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CompetitorPricing competitorPricing,  double demandElasticity,  double priceOptimizationPotential)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MarketInsights() when $default != null:
return $default(_that.competitorPricing,_that.demandElasticity,_that.priceOptimizationPotential);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CompetitorPricing competitorPricing,  double demandElasticity,  double priceOptimizationPotential)  $default,) {final _that = this;
switch (_that) {
case _MarketInsights():
return $default(_that.competitorPricing,_that.demandElasticity,_that.priceOptimizationPotential);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CompetitorPricing competitorPricing,  double demandElasticity,  double priceOptimizationPotential)?  $default,) {final _that = this;
switch (_that) {
case _MarketInsights() when $default != null:
return $default(_that.competitorPricing,_that.demandElasticity,_that.priceOptimizationPotential);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MarketInsights implements MarketInsights {
  const _MarketInsights({required this.competitorPricing, required this.demandElasticity, required this.priceOptimizationPotential});
  factory _MarketInsights.fromJson(Map<String, dynamic> json) => _$MarketInsightsFromJson(json);

@override final  CompetitorPricing competitorPricing;
@override final  double demandElasticity;
@override final  double priceOptimizationPotential;

/// Create a copy of MarketInsights
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MarketInsightsCopyWith<_MarketInsights> get copyWith => __$MarketInsightsCopyWithImpl<_MarketInsights>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MarketInsightsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MarketInsights&&(identical(other.competitorPricing, competitorPricing) || other.competitorPricing == competitorPricing)&&(identical(other.demandElasticity, demandElasticity) || other.demandElasticity == demandElasticity)&&(identical(other.priceOptimizationPotential, priceOptimizationPotential) || other.priceOptimizationPotential == priceOptimizationPotential));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,competitorPricing,demandElasticity,priceOptimizationPotential);

@override
String toString() {
  return 'MarketInsights(competitorPricing: $competitorPricing, demandElasticity: $demandElasticity, priceOptimizationPotential: $priceOptimizationPotential)';
}


}

/// @nodoc
abstract mixin class _$MarketInsightsCopyWith<$Res> implements $MarketInsightsCopyWith<$Res> {
  factory _$MarketInsightsCopyWith(_MarketInsights value, $Res Function(_MarketInsights) _then) = __$MarketInsightsCopyWithImpl;
@override @useResult
$Res call({
 CompetitorPricing competitorPricing, double demandElasticity, double priceOptimizationPotential
});


@override $CompetitorPricingCopyWith<$Res> get competitorPricing;

}
/// @nodoc
class __$MarketInsightsCopyWithImpl<$Res>
    implements _$MarketInsightsCopyWith<$Res> {
  __$MarketInsightsCopyWithImpl(this._self, this._then);

  final _MarketInsights _self;
  final $Res Function(_MarketInsights) _then;

/// Create a copy of MarketInsights
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? competitorPricing = null,Object? demandElasticity = null,Object? priceOptimizationPotential = null,}) {
  return _then(_MarketInsights(
competitorPricing: null == competitorPricing ? _self.competitorPricing : competitorPricing // ignore: cast_nullable_to_non_nullable
as CompetitorPricing,demandElasticity: null == demandElasticity ? _self.demandElasticity : demandElasticity // ignore: cast_nullable_to_non_nullable
as double,priceOptimizationPotential: null == priceOptimizationPotential ? _self.priceOptimizationPotential : priceOptimizationPotential // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

/// Create a copy of MarketInsights
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CompetitorPricingCopyWith<$Res> get competitorPricing {
  
  return $CompetitorPricingCopyWith<$Res>(_self.competitorPricing, (value) {
    return _then(_self.copyWith(competitorPricing: value));
  });
}
}


/// @nodoc
mixin _$CompetitorPricing {

 double get average; List<double> get range; String get position;
/// Create a copy of CompetitorPricing
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompetitorPricingCopyWith<CompetitorPricing> get copyWith => _$CompetitorPricingCopyWithImpl<CompetitorPricing>(this as CompetitorPricing, _$identity);

  /// Serializes this CompetitorPricing to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompetitorPricing&&(identical(other.average, average) || other.average == average)&&const DeepCollectionEquality().equals(other.range, range)&&(identical(other.position, position) || other.position == position));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,average,const DeepCollectionEquality().hash(range),position);

@override
String toString() {
  return 'CompetitorPricing(average: $average, range: $range, position: $position)';
}


}

/// @nodoc
abstract mixin class $CompetitorPricingCopyWith<$Res>  {
  factory $CompetitorPricingCopyWith(CompetitorPricing value, $Res Function(CompetitorPricing) _then) = _$CompetitorPricingCopyWithImpl;
@useResult
$Res call({
 double average, List<double> range, String position
});




}
/// @nodoc
class _$CompetitorPricingCopyWithImpl<$Res>
    implements $CompetitorPricingCopyWith<$Res> {
  _$CompetitorPricingCopyWithImpl(this._self, this._then);

  final CompetitorPricing _self;
  final $Res Function(CompetitorPricing) _then;

/// Create a copy of CompetitorPricing
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? average = null,Object? range = null,Object? position = null,}) {
  return _then(_self.copyWith(
average: null == average ? _self.average : average // ignore: cast_nullable_to_non_nullable
as double,range: null == range ? _self.range : range // ignore: cast_nullable_to_non_nullable
as List<double>,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CompetitorPricing].
extension CompetitorPricingPatterns on CompetitorPricing {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CompetitorPricing value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CompetitorPricing() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CompetitorPricing value)  $default,){
final _that = this;
switch (_that) {
case _CompetitorPricing():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CompetitorPricing value)?  $default,){
final _that = this;
switch (_that) {
case _CompetitorPricing() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double average,  List<double> range,  String position)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CompetitorPricing() when $default != null:
return $default(_that.average,_that.range,_that.position);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double average,  List<double> range,  String position)  $default,) {final _that = this;
switch (_that) {
case _CompetitorPricing():
return $default(_that.average,_that.range,_that.position);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double average,  List<double> range,  String position)?  $default,) {final _that = this;
switch (_that) {
case _CompetitorPricing() when $default != null:
return $default(_that.average,_that.range,_that.position);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CompetitorPricing implements CompetitorPricing {
  const _CompetitorPricing({required this.average, required final  List<double> range, required this.position}): _range = range;
  factory _CompetitorPricing.fromJson(Map<String, dynamic> json) => _$CompetitorPricingFromJson(json);

@override final  double average;
 final  List<double> _range;
@override List<double> get range {
  if (_range is EqualUnmodifiableListView) return _range;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_range);
}

@override final  String position;

/// Create a copy of CompetitorPricing
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CompetitorPricingCopyWith<_CompetitorPricing> get copyWith => __$CompetitorPricingCopyWithImpl<_CompetitorPricing>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CompetitorPricingToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CompetitorPricing&&(identical(other.average, average) || other.average == average)&&const DeepCollectionEquality().equals(other._range, _range)&&(identical(other.position, position) || other.position == position));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,average,const DeepCollectionEquality().hash(_range),position);

@override
String toString() {
  return 'CompetitorPricing(average: $average, range: $range, position: $position)';
}


}

/// @nodoc
abstract mixin class _$CompetitorPricingCopyWith<$Res> implements $CompetitorPricingCopyWith<$Res> {
  factory _$CompetitorPricingCopyWith(_CompetitorPricing value, $Res Function(_CompetitorPricing) _then) = __$CompetitorPricingCopyWithImpl;
@override @useResult
$Res call({
 double average, List<double> range, String position
});




}
/// @nodoc
class __$CompetitorPricingCopyWithImpl<$Res>
    implements _$CompetitorPricingCopyWith<$Res> {
  __$CompetitorPricingCopyWithImpl(this._self, this._then);

  final _CompetitorPricing _self;
  final $Res Function(_CompetitorPricing) _then;

/// Create a copy of CompetitorPricing
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? average = null,Object? range = null,Object? position = null,}) {
  return _then(_CompetitorPricing(
average: null == average ? _self.average : average // ignore: cast_nullable_to_non_nullable
as double,range: null == range ? _self._range : range // ignore: cast_nullable_to_non_nullable
as List<double>,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$Invoice {

 String get invoiceId; String get organizationId; String get clientId; String get period; double get amount; double get gst; double get total; String get status; String get createdAt; List<LineItem> get lineItems; ValidationResult? get validation; List<BillingAnomaly>? get anomalies; String? get approvedAt;
/// Create a copy of Invoice
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InvoiceCopyWith<Invoice> get copyWith => _$InvoiceCopyWithImpl<Invoice>(this as Invoice, _$identity);

  /// Serializes this Invoice to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Invoice&&(identical(other.invoiceId, invoiceId) || other.invoiceId == invoiceId)&&(identical(other.organizationId, organizationId) || other.organizationId == organizationId)&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.period, period) || other.period == period)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.gst, gst) || other.gst == gst)&&(identical(other.total, total) || other.total == total)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other.lineItems, lineItems)&&(identical(other.validation, validation) || other.validation == validation)&&const DeepCollectionEquality().equals(other.anomalies, anomalies)&&(identical(other.approvedAt, approvedAt) || other.approvedAt == approvedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,invoiceId,organizationId,clientId,period,amount,gst,total,status,createdAt,const DeepCollectionEquality().hash(lineItems),validation,const DeepCollectionEquality().hash(anomalies),approvedAt);

@override
String toString() {
  return 'Invoice(invoiceId: $invoiceId, organizationId: $organizationId, clientId: $clientId, period: $period, amount: $amount, gst: $gst, total: $total, status: $status, createdAt: $createdAt, lineItems: $lineItems, validation: $validation, anomalies: $anomalies, approvedAt: $approvedAt)';
}


}

/// @nodoc
abstract mixin class $InvoiceCopyWith<$Res>  {
  factory $InvoiceCopyWith(Invoice value, $Res Function(Invoice) _then) = _$InvoiceCopyWithImpl;
@useResult
$Res call({
 String invoiceId, String organizationId, String clientId, String period, double amount, double gst, double total, String status, String createdAt, List<LineItem> lineItems, ValidationResult? validation, List<BillingAnomaly>? anomalies, String? approvedAt
});


$ValidationResultCopyWith<$Res>? get validation;

}
/// @nodoc
class _$InvoiceCopyWithImpl<$Res>
    implements $InvoiceCopyWith<$Res> {
  _$InvoiceCopyWithImpl(this._self, this._then);

  final Invoice _self;
  final $Res Function(Invoice) _then;

/// Create a copy of Invoice
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? invoiceId = null,Object? organizationId = null,Object? clientId = null,Object? period = null,Object? amount = null,Object? gst = null,Object? total = null,Object? status = null,Object? createdAt = null,Object? lineItems = null,Object? validation = freezed,Object? anomalies = freezed,Object? approvedAt = freezed,}) {
  return _then(_self.copyWith(
invoiceId: null == invoiceId ? _self.invoiceId : invoiceId // ignore: cast_nullable_to_non_nullable
as String,organizationId: null == organizationId ? _self.organizationId : organizationId // ignore: cast_nullable_to_non_nullable
as String,clientId: null == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,gst: null == gst ? _self.gst : gst // ignore: cast_nullable_to_non_nullable
as double,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,lineItems: null == lineItems ? _self.lineItems : lineItems // ignore: cast_nullable_to_non_nullable
as List<LineItem>,validation: freezed == validation ? _self.validation : validation // ignore: cast_nullable_to_non_nullable
as ValidationResult?,anomalies: freezed == anomalies ? _self.anomalies : anomalies // ignore: cast_nullable_to_non_nullable
as List<BillingAnomaly>?,approvedAt: freezed == approvedAt ? _self.approvedAt : approvedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of Invoice
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ValidationResultCopyWith<$Res>? get validation {
    if (_self.validation == null) {
    return null;
  }

  return $ValidationResultCopyWith<$Res>(_self.validation!, (value) {
    return _then(_self.copyWith(validation: value));
  });
}
}


/// Adds pattern-matching-related methods to [Invoice].
extension InvoicePatterns on Invoice {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Invoice value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Invoice() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Invoice value)  $default,){
final _that = this;
switch (_that) {
case _Invoice():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Invoice value)?  $default,){
final _that = this;
switch (_that) {
case _Invoice() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String invoiceId,  String organizationId,  String clientId,  String period,  double amount,  double gst,  double total,  String status,  String createdAt,  List<LineItem> lineItems,  ValidationResult? validation,  List<BillingAnomaly>? anomalies,  String? approvedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Invoice() when $default != null:
return $default(_that.invoiceId,_that.organizationId,_that.clientId,_that.period,_that.amount,_that.gst,_that.total,_that.status,_that.createdAt,_that.lineItems,_that.validation,_that.anomalies,_that.approvedAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String invoiceId,  String organizationId,  String clientId,  String period,  double amount,  double gst,  double total,  String status,  String createdAt,  List<LineItem> lineItems,  ValidationResult? validation,  List<BillingAnomaly>? anomalies,  String? approvedAt)  $default,) {final _that = this;
switch (_that) {
case _Invoice():
return $default(_that.invoiceId,_that.organizationId,_that.clientId,_that.period,_that.amount,_that.gst,_that.total,_that.status,_that.createdAt,_that.lineItems,_that.validation,_that.anomalies,_that.approvedAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String invoiceId,  String organizationId,  String clientId,  String period,  double amount,  double gst,  double total,  String status,  String createdAt,  List<LineItem> lineItems,  ValidationResult? validation,  List<BillingAnomaly>? anomalies,  String? approvedAt)?  $default,) {final _that = this;
switch (_that) {
case _Invoice() when $default != null:
return $default(_that.invoiceId,_that.organizationId,_that.clientId,_that.period,_that.amount,_that.gst,_that.total,_that.status,_that.createdAt,_that.lineItems,_that.validation,_that.anomalies,_that.approvedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Invoice implements Invoice {
  const _Invoice({required this.invoiceId, required this.organizationId, required this.clientId, required this.period, required this.amount, required this.gst, required this.total, required this.status, required this.createdAt, required final  List<LineItem> lineItems, this.validation, final  List<BillingAnomaly>? anomalies, this.approvedAt}): _lineItems = lineItems,_anomalies = anomalies;
  factory _Invoice.fromJson(Map<String, dynamic> json) => _$InvoiceFromJson(json);

@override final  String invoiceId;
@override final  String organizationId;
@override final  String clientId;
@override final  String period;
@override final  double amount;
@override final  double gst;
@override final  double total;
@override final  String status;
@override final  String createdAt;
 final  List<LineItem> _lineItems;
@override List<LineItem> get lineItems {
  if (_lineItems is EqualUnmodifiableListView) return _lineItems;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lineItems);
}

@override final  ValidationResult? validation;
 final  List<BillingAnomaly>? _anomalies;
@override List<BillingAnomaly>? get anomalies {
  final value = _anomalies;
  if (value == null) return null;
  if (_anomalies is EqualUnmodifiableListView) return _anomalies;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  String? approvedAt;

/// Create a copy of Invoice
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InvoiceCopyWith<_Invoice> get copyWith => __$InvoiceCopyWithImpl<_Invoice>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InvoiceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Invoice&&(identical(other.invoiceId, invoiceId) || other.invoiceId == invoiceId)&&(identical(other.organizationId, organizationId) || other.organizationId == organizationId)&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.period, period) || other.period == period)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.gst, gst) || other.gst == gst)&&(identical(other.total, total) || other.total == total)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other._lineItems, _lineItems)&&(identical(other.validation, validation) || other.validation == validation)&&const DeepCollectionEquality().equals(other._anomalies, _anomalies)&&(identical(other.approvedAt, approvedAt) || other.approvedAt == approvedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,invoiceId,organizationId,clientId,period,amount,gst,total,status,createdAt,const DeepCollectionEquality().hash(_lineItems),validation,const DeepCollectionEquality().hash(_anomalies),approvedAt);

@override
String toString() {
  return 'Invoice(invoiceId: $invoiceId, organizationId: $organizationId, clientId: $clientId, period: $period, amount: $amount, gst: $gst, total: $total, status: $status, createdAt: $createdAt, lineItems: $lineItems, validation: $validation, anomalies: $anomalies, approvedAt: $approvedAt)';
}


}

/// @nodoc
abstract mixin class _$InvoiceCopyWith<$Res> implements $InvoiceCopyWith<$Res> {
  factory _$InvoiceCopyWith(_Invoice value, $Res Function(_Invoice) _then) = __$InvoiceCopyWithImpl;
@override @useResult
$Res call({
 String invoiceId, String organizationId, String clientId, String period, double amount, double gst, double total, String status, String createdAt, List<LineItem> lineItems, ValidationResult? validation, List<BillingAnomaly>? anomalies, String? approvedAt
});


@override $ValidationResultCopyWith<$Res>? get validation;

}
/// @nodoc
class __$InvoiceCopyWithImpl<$Res>
    implements _$InvoiceCopyWith<$Res> {
  __$InvoiceCopyWithImpl(this._self, this._then);

  final _Invoice _self;
  final $Res Function(_Invoice) _then;

/// Create a copy of Invoice
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? invoiceId = null,Object? organizationId = null,Object? clientId = null,Object? period = null,Object? amount = null,Object? gst = null,Object? total = null,Object? status = null,Object? createdAt = null,Object? lineItems = null,Object? validation = freezed,Object? anomalies = freezed,Object? approvedAt = freezed,}) {
  return _then(_Invoice(
invoiceId: null == invoiceId ? _self.invoiceId : invoiceId // ignore: cast_nullable_to_non_nullable
as String,organizationId: null == organizationId ? _self.organizationId : organizationId // ignore: cast_nullable_to_non_nullable
as String,clientId: null == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,gst: null == gst ? _self.gst : gst // ignore: cast_nullable_to_non_nullable
as double,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,lineItems: null == lineItems ? _self._lineItems : lineItems // ignore: cast_nullable_to_non_nullable
as List<LineItem>,validation: freezed == validation ? _self.validation : validation // ignore: cast_nullable_to_non_nullable
as ValidationResult?,anomalies: freezed == anomalies ? _self._anomalies : anomalies // ignore: cast_nullable_to_non_nullable
as List<BillingAnomaly>?,approvedAt: freezed == approvedAt ? _self.approvedAt : approvedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of Invoice
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ValidationResultCopyWith<$Res>? get validation {
    if (_self.validation == null) {
    return null;
  }

  return $ValidationResultCopyWith<$Res>(_self.validation!, (value) {
    return _then(_self.copyWith(validation: value));
  });
}
}


/// @nodoc
mixin _$LineItem {

 String get description; int get quantity; double get rate; double get amount;
/// Create a copy of LineItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LineItemCopyWith<LineItem> get copyWith => _$LineItemCopyWithImpl<LineItem>(this as LineItem, _$identity);

  /// Serializes this LineItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LineItem&&(identical(other.description, description) || other.description == description)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.rate, rate) || other.rate == rate)&&(identical(other.amount, amount) || other.amount == amount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,description,quantity,rate,amount);

@override
String toString() {
  return 'LineItem(description: $description, quantity: $quantity, rate: $rate, amount: $amount)';
}


}

/// @nodoc
abstract mixin class $LineItemCopyWith<$Res>  {
  factory $LineItemCopyWith(LineItem value, $Res Function(LineItem) _then) = _$LineItemCopyWithImpl;
@useResult
$Res call({
 String description, int quantity, double rate, double amount
});




}
/// @nodoc
class _$LineItemCopyWithImpl<$Res>
    implements $LineItemCopyWith<$Res> {
  _$LineItemCopyWithImpl(this._self, this._then);

  final LineItem _self;
  final $Res Function(LineItem) _then;

/// Create a copy of LineItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? description = null,Object? quantity = null,Object? rate = null,Object? amount = null,}) {
  return _then(_self.copyWith(
description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,rate: null == rate ? _self.rate : rate // ignore: cast_nullable_to_non_nullable
as double,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [LineItem].
extension LineItemPatterns on LineItem {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LineItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LineItem() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LineItem value)  $default,){
final _that = this;
switch (_that) {
case _LineItem():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LineItem value)?  $default,){
final _that = this;
switch (_that) {
case _LineItem() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String description,  int quantity,  double rate,  double amount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LineItem() when $default != null:
return $default(_that.description,_that.quantity,_that.rate,_that.amount);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String description,  int quantity,  double rate,  double amount)  $default,) {final _that = this;
switch (_that) {
case _LineItem():
return $default(_that.description,_that.quantity,_that.rate,_that.amount);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String description,  int quantity,  double rate,  double amount)?  $default,) {final _that = this;
switch (_that) {
case _LineItem() when $default != null:
return $default(_that.description,_that.quantity,_that.rate,_that.amount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LineItem implements LineItem {
  const _LineItem({required this.description, required this.quantity, required this.rate, required this.amount});
  factory _LineItem.fromJson(Map<String, dynamic> json) => _$LineItemFromJson(json);

@override final  String description;
@override final  int quantity;
@override final  double rate;
@override final  double amount;

/// Create a copy of LineItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LineItemCopyWith<_LineItem> get copyWith => __$LineItemCopyWithImpl<_LineItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LineItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LineItem&&(identical(other.description, description) || other.description == description)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.rate, rate) || other.rate == rate)&&(identical(other.amount, amount) || other.amount == amount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,description,quantity,rate,amount);

@override
String toString() {
  return 'LineItem(description: $description, quantity: $quantity, rate: $rate, amount: $amount)';
}


}

/// @nodoc
abstract mixin class _$LineItemCopyWith<$Res> implements $LineItemCopyWith<$Res> {
  factory _$LineItemCopyWith(_LineItem value, $Res Function(_LineItem) _then) = __$LineItemCopyWithImpl;
@override @useResult
$Res call({
 String description, int quantity, double rate, double amount
});




}
/// @nodoc
class __$LineItemCopyWithImpl<$Res>
    implements _$LineItemCopyWith<$Res> {
  __$LineItemCopyWithImpl(this._self, this._then);

  final _LineItem _self;
  final $Res Function(_LineItem) _then;

/// Create a copy of LineItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? description = null,Object? quantity = null,Object? rate = null,Object? amount = null,}) {
  return _then(_LineItem(
description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,rate: null == rate ? _self.rate : rate // ignore: cast_nullable_to_non_nullable
as double,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$ValidationResult {

 bool get passed; List<String> get errors; List<String> get warnings; List<ValidationCheck> get checks;
/// Create a copy of ValidationResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ValidationResultCopyWith<ValidationResult> get copyWith => _$ValidationResultCopyWithImpl<ValidationResult>(this as ValidationResult, _$identity);

  /// Serializes this ValidationResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ValidationResult&&(identical(other.passed, passed) || other.passed == passed)&&const DeepCollectionEquality().equals(other.errors, errors)&&const DeepCollectionEquality().equals(other.warnings, warnings)&&const DeepCollectionEquality().equals(other.checks, checks));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,passed,const DeepCollectionEquality().hash(errors),const DeepCollectionEquality().hash(warnings),const DeepCollectionEquality().hash(checks));

@override
String toString() {
  return 'ValidationResult(passed: $passed, errors: $errors, warnings: $warnings, checks: $checks)';
}


}

/// @nodoc
abstract mixin class $ValidationResultCopyWith<$Res>  {
  factory $ValidationResultCopyWith(ValidationResult value, $Res Function(ValidationResult) _then) = _$ValidationResultCopyWithImpl;
@useResult
$Res call({
 bool passed, List<String> errors, List<String> warnings, List<ValidationCheck> checks
});




}
/// @nodoc
class _$ValidationResultCopyWithImpl<$Res>
    implements $ValidationResultCopyWith<$Res> {
  _$ValidationResultCopyWithImpl(this._self, this._then);

  final ValidationResult _self;
  final $Res Function(ValidationResult) _then;

/// Create a copy of ValidationResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? passed = null,Object? errors = null,Object? warnings = null,Object? checks = null,}) {
  return _then(_self.copyWith(
passed: null == passed ? _self.passed : passed // ignore: cast_nullable_to_non_nullable
as bool,errors: null == errors ? _self.errors : errors // ignore: cast_nullable_to_non_nullable
as List<String>,warnings: null == warnings ? _self.warnings : warnings // ignore: cast_nullable_to_non_nullable
as List<String>,checks: null == checks ? _self.checks : checks // ignore: cast_nullable_to_non_nullable
as List<ValidationCheck>,
  ));
}

}


/// Adds pattern-matching-related methods to [ValidationResult].
extension ValidationResultPatterns on ValidationResult {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ValidationResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ValidationResult() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ValidationResult value)  $default,){
final _that = this;
switch (_that) {
case _ValidationResult():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ValidationResult value)?  $default,){
final _that = this;
switch (_that) {
case _ValidationResult() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool passed,  List<String> errors,  List<String> warnings,  List<ValidationCheck> checks)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ValidationResult() when $default != null:
return $default(_that.passed,_that.errors,_that.warnings,_that.checks);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool passed,  List<String> errors,  List<String> warnings,  List<ValidationCheck> checks)  $default,) {final _that = this;
switch (_that) {
case _ValidationResult():
return $default(_that.passed,_that.errors,_that.warnings,_that.checks);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool passed,  List<String> errors,  List<String> warnings,  List<ValidationCheck> checks)?  $default,) {final _that = this;
switch (_that) {
case _ValidationResult() when $default != null:
return $default(_that.passed,_that.errors,_that.warnings,_that.checks);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ValidationResult implements ValidationResult {
  const _ValidationResult({required this.passed, required final  List<String> errors, required final  List<String> warnings, required final  List<ValidationCheck> checks}): _errors = errors,_warnings = warnings,_checks = checks;
  factory _ValidationResult.fromJson(Map<String, dynamic> json) => _$ValidationResultFromJson(json);

@override final  bool passed;
 final  List<String> _errors;
@override List<String> get errors {
  if (_errors is EqualUnmodifiableListView) return _errors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_errors);
}

 final  List<String> _warnings;
@override List<String> get warnings {
  if (_warnings is EqualUnmodifiableListView) return _warnings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_warnings);
}

 final  List<ValidationCheck> _checks;
@override List<ValidationCheck> get checks {
  if (_checks is EqualUnmodifiableListView) return _checks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_checks);
}


/// Create a copy of ValidationResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ValidationResultCopyWith<_ValidationResult> get copyWith => __$ValidationResultCopyWithImpl<_ValidationResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ValidationResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ValidationResult&&(identical(other.passed, passed) || other.passed == passed)&&const DeepCollectionEquality().equals(other._errors, _errors)&&const DeepCollectionEquality().equals(other._warnings, _warnings)&&const DeepCollectionEquality().equals(other._checks, _checks));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,passed,const DeepCollectionEquality().hash(_errors),const DeepCollectionEquality().hash(_warnings),const DeepCollectionEquality().hash(_checks));

@override
String toString() {
  return 'ValidationResult(passed: $passed, errors: $errors, warnings: $warnings, checks: $checks)';
}


}

/// @nodoc
abstract mixin class _$ValidationResultCopyWith<$Res> implements $ValidationResultCopyWith<$Res> {
  factory _$ValidationResultCopyWith(_ValidationResult value, $Res Function(_ValidationResult) _then) = __$ValidationResultCopyWithImpl;
@override @useResult
$Res call({
 bool passed, List<String> errors, List<String> warnings, List<ValidationCheck> checks
});




}
/// @nodoc
class __$ValidationResultCopyWithImpl<$Res>
    implements _$ValidationResultCopyWith<$Res> {
  __$ValidationResultCopyWithImpl(this._self, this._then);

  final _ValidationResult _self;
  final $Res Function(_ValidationResult) _then;

/// Create a copy of ValidationResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? passed = null,Object? errors = null,Object? warnings = null,Object? checks = null,}) {
  return _then(_ValidationResult(
passed: null == passed ? _self.passed : passed // ignore: cast_nullable_to_non_nullable
as bool,errors: null == errors ? _self._errors : errors // ignore: cast_nullable_to_non_nullable
as List<String>,warnings: null == warnings ? _self._warnings : warnings // ignore: cast_nullable_to_non_nullable
as List<String>,checks: null == checks ? _self._checks : checks // ignore: cast_nullable_to_non_nullable
as List<ValidationCheck>,
  ));
}


}


/// @nodoc
mixin _$ValidationCheck {

 String get check; bool get passed; List<String> get errors; String get details;
/// Create a copy of ValidationCheck
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ValidationCheckCopyWith<ValidationCheck> get copyWith => _$ValidationCheckCopyWithImpl<ValidationCheck>(this as ValidationCheck, _$identity);

  /// Serializes this ValidationCheck to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ValidationCheck&&(identical(other.check, check) || other.check == check)&&(identical(other.passed, passed) || other.passed == passed)&&const DeepCollectionEquality().equals(other.errors, errors)&&(identical(other.details, details) || other.details == details));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,check,passed,const DeepCollectionEquality().hash(errors),details);

@override
String toString() {
  return 'ValidationCheck(check: $check, passed: $passed, errors: $errors, details: $details)';
}


}

/// @nodoc
abstract mixin class $ValidationCheckCopyWith<$Res>  {
  factory $ValidationCheckCopyWith(ValidationCheck value, $Res Function(ValidationCheck) _then) = _$ValidationCheckCopyWithImpl;
@useResult
$Res call({
 String check, bool passed, List<String> errors, String details
});




}
/// @nodoc
class _$ValidationCheckCopyWithImpl<$Res>
    implements $ValidationCheckCopyWith<$Res> {
  _$ValidationCheckCopyWithImpl(this._self, this._then);

  final ValidationCheck _self;
  final $Res Function(ValidationCheck) _then;

/// Create a copy of ValidationCheck
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? check = null,Object? passed = null,Object? errors = null,Object? details = null,}) {
  return _then(_self.copyWith(
check: null == check ? _self.check : check // ignore: cast_nullable_to_non_nullable
as String,passed: null == passed ? _self.passed : passed // ignore: cast_nullable_to_non_nullable
as bool,errors: null == errors ? _self.errors : errors // ignore: cast_nullable_to_non_nullable
as List<String>,details: null == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ValidationCheck].
extension ValidationCheckPatterns on ValidationCheck {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ValidationCheck value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ValidationCheck() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ValidationCheck value)  $default,){
final _that = this;
switch (_that) {
case _ValidationCheck():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ValidationCheck value)?  $default,){
final _that = this;
switch (_that) {
case _ValidationCheck() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String check,  bool passed,  List<String> errors,  String details)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ValidationCheck() when $default != null:
return $default(_that.check,_that.passed,_that.errors,_that.details);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String check,  bool passed,  List<String> errors,  String details)  $default,) {final _that = this;
switch (_that) {
case _ValidationCheck():
return $default(_that.check,_that.passed,_that.errors,_that.details);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String check,  bool passed,  List<String> errors,  String details)?  $default,) {final _that = this;
switch (_that) {
case _ValidationCheck() when $default != null:
return $default(_that.check,_that.passed,_that.errors,_that.details);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ValidationCheck implements ValidationCheck {
  const _ValidationCheck({required this.check, required this.passed, required final  List<String> errors, required this.details}): _errors = errors;
  factory _ValidationCheck.fromJson(Map<String, dynamic> json) => _$ValidationCheckFromJson(json);

@override final  String check;
@override final  bool passed;
 final  List<String> _errors;
@override List<String> get errors {
  if (_errors is EqualUnmodifiableListView) return _errors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_errors);
}

@override final  String details;

/// Create a copy of ValidationCheck
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ValidationCheckCopyWith<_ValidationCheck> get copyWith => __$ValidationCheckCopyWithImpl<_ValidationCheck>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ValidationCheckToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ValidationCheck&&(identical(other.check, check) || other.check == check)&&(identical(other.passed, passed) || other.passed == passed)&&const DeepCollectionEquality().equals(other._errors, _errors)&&(identical(other.details, details) || other.details == details));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,check,passed,const DeepCollectionEquality().hash(_errors),details);

@override
String toString() {
  return 'ValidationCheck(check: $check, passed: $passed, errors: $errors, details: $details)';
}


}

/// @nodoc
abstract mixin class _$ValidationCheckCopyWith<$Res> implements $ValidationCheckCopyWith<$Res> {
  factory _$ValidationCheckCopyWith(_ValidationCheck value, $Res Function(_ValidationCheck) _then) = __$ValidationCheckCopyWithImpl;
@override @useResult
$Res call({
 String check, bool passed, List<String> errors, String details
});




}
/// @nodoc
class __$ValidationCheckCopyWithImpl<$Res>
    implements _$ValidationCheckCopyWith<$Res> {
  __$ValidationCheckCopyWithImpl(this._self, this._then);

  final _ValidationCheck _self;
  final $Res Function(_ValidationCheck) _then;

/// Create a copy of ValidationCheck
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? check = null,Object? passed = null,Object? errors = null,Object? details = null,}) {
  return _then(_ValidationCheck(
check: null == check ? _self.check : check // ignore: cast_nullable_to_non_nullable
as String,passed: null == passed ? _self.passed : passed // ignore: cast_nullable_to_non_nullable
as bool,errors: null == errors ? _self._errors : errors // ignore: cast_nullable_to_non_nullable
as List<String>,details: null == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$BillingAnomaly {

 String get type; String get severity; String get description; Map<String, dynamic>? get details;
/// Create a copy of BillingAnomaly
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BillingAnomalyCopyWith<BillingAnomaly> get copyWith => _$BillingAnomalyCopyWithImpl<BillingAnomaly>(this as BillingAnomaly, _$identity);

  /// Serializes this BillingAnomaly to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BillingAnomaly&&(identical(other.type, type) || other.type == type)&&(identical(other.severity, severity) || other.severity == severity)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.details, details));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,severity,description,const DeepCollectionEquality().hash(details));

@override
String toString() {
  return 'BillingAnomaly(type: $type, severity: $severity, description: $description, details: $details)';
}


}

/// @nodoc
abstract mixin class $BillingAnomalyCopyWith<$Res>  {
  factory $BillingAnomalyCopyWith(BillingAnomaly value, $Res Function(BillingAnomaly) _then) = _$BillingAnomalyCopyWithImpl;
@useResult
$Res call({
 String type, String severity, String description, Map<String, dynamic>? details
});




}
/// @nodoc
class _$BillingAnomalyCopyWithImpl<$Res>
    implements $BillingAnomalyCopyWith<$Res> {
  _$BillingAnomalyCopyWithImpl(this._self, this._then);

  final BillingAnomaly _self;
  final $Res Function(BillingAnomaly) _then;

/// Create a copy of BillingAnomaly
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? severity = null,Object? description = null,Object? details = freezed,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,severity: null == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,details: freezed == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [BillingAnomaly].
extension BillingAnomalyPatterns on BillingAnomaly {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BillingAnomaly value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BillingAnomaly() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BillingAnomaly value)  $default,){
final _that = this;
switch (_that) {
case _BillingAnomaly():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BillingAnomaly value)?  $default,){
final _that = this;
switch (_that) {
case _BillingAnomaly() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String type,  String severity,  String description,  Map<String, dynamic>? details)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BillingAnomaly() when $default != null:
return $default(_that.type,_that.severity,_that.description,_that.details);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String type,  String severity,  String description,  Map<String, dynamic>? details)  $default,) {final _that = this;
switch (_that) {
case _BillingAnomaly():
return $default(_that.type,_that.severity,_that.description,_that.details);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String type,  String severity,  String description,  Map<String, dynamic>? details)?  $default,) {final _that = this;
switch (_that) {
case _BillingAnomaly() when $default != null:
return $default(_that.type,_that.severity,_that.description,_that.details);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BillingAnomaly implements BillingAnomaly {
  const _BillingAnomaly({required this.type, required this.severity, required this.description, final  Map<String, dynamic>? details}): _details = details;
  factory _BillingAnomaly.fromJson(Map<String, dynamic> json) => _$BillingAnomalyFromJson(json);

@override final  String type;
@override final  String severity;
@override final  String description;
 final  Map<String, dynamic>? _details;
@override Map<String, dynamic>? get details {
  final value = _details;
  if (value == null) return null;
  if (_details is EqualUnmodifiableMapView) return _details;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of BillingAnomaly
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BillingAnomalyCopyWith<_BillingAnomaly> get copyWith => __$BillingAnomalyCopyWithImpl<_BillingAnomaly>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BillingAnomalyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BillingAnomaly&&(identical(other.type, type) || other.type == type)&&(identical(other.severity, severity) || other.severity == severity)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other._details, _details));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,severity,description,const DeepCollectionEquality().hash(_details));

@override
String toString() {
  return 'BillingAnomaly(type: $type, severity: $severity, description: $description, details: $details)';
}


}

/// @nodoc
abstract mixin class _$BillingAnomalyCopyWith<$Res> implements $BillingAnomalyCopyWith<$Res> {
  factory _$BillingAnomalyCopyWith(_BillingAnomaly value, $Res Function(_BillingAnomaly) _then) = __$BillingAnomalyCopyWithImpl;
@override @useResult
$Res call({
 String type, String severity, String description, Map<String, dynamic>? details
});




}
/// @nodoc
class __$BillingAnomalyCopyWithImpl<$Res>
    implements _$BillingAnomalyCopyWith<$Res> {
  __$BillingAnomalyCopyWithImpl(this._self, this._then);

  final _BillingAnomaly _self;
  final $Res Function(_BillingAnomaly) _then;

/// Create a copy of BillingAnomaly
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? severity = null,Object? description = null,Object? details = freezed,}) {
  return _then(_BillingAnomaly(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,severity: null == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,details: freezed == details ? _self._details : details // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}


/// @nodoc
mixin _$CreditNote {

 String get creditNoteId; String get invoiceId; double get amount; String get reason; String get status; String get createdAt; double get gst; double get totalCredit; CreditNoteWorkflow get workflow; List<AuditEntry> get auditTrail; String? get approvedAt;
/// Create a copy of CreditNote
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreditNoteCopyWith<CreditNote> get copyWith => _$CreditNoteCopyWithImpl<CreditNote>(this as CreditNote, _$identity);

  /// Serializes this CreditNote to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreditNote&&(identical(other.creditNoteId, creditNoteId) || other.creditNoteId == creditNoteId)&&(identical(other.invoiceId, invoiceId) || other.invoiceId == invoiceId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.gst, gst) || other.gst == gst)&&(identical(other.totalCredit, totalCredit) || other.totalCredit == totalCredit)&&(identical(other.workflow, workflow) || other.workflow == workflow)&&const DeepCollectionEquality().equals(other.auditTrail, auditTrail)&&(identical(other.approvedAt, approvedAt) || other.approvedAt == approvedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,creditNoteId,invoiceId,amount,reason,status,createdAt,gst,totalCredit,workflow,const DeepCollectionEquality().hash(auditTrail),approvedAt);

@override
String toString() {
  return 'CreditNote(creditNoteId: $creditNoteId, invoiceId: $invoiceId, amount: $amount, reason: $reason, status: $status, createdAt: $createdAt, gst: $gst, totalCredit: $totalCredit, workflow: $workflow, auditTrail: $auditTrail, approvedAt: $approvedAt)';
}


}

/// @nodoc
abstract mixin class $CreditNoteCopyWith<$Res>  {
  factory $CreditNoteCopyWith(CreditNote value, $Res Function(CreditNote) _then) = _$CreditNoteCopyWithImpl;
@useResult
$Res call({
 String creditNoteId, String invoiceId, double amount, String reason, String status, String createdAt, double gst, double totalCredit, CreditNoteWorkflow workflow, List<AuditEntry> auditTrail, String? approvedAt
});


$CreditNoteWorkflowCopyWith<$Res> get workflow;

}
/// @nodoc
class _$CreditNoteCopyWithImpl<$Res>
    implements $CreditNoteCopyWith<$Res> {
  _$CreditNoteCopyWithImpl(this._self, this._then);

  final CreditNote _self;
  final $Res Function(CreditNote) _then;

/// Create a copy of CreditNote
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? creditNoteId = null,Object? invoiceId = null,Object? amount = null,Object? reason = null,Object? status = null,Object? createdAt = null,Object? gst = null,Object? totalCredit = null,Object? workflow = null,Object? auditTrail = null,Object? approvedAt = freezed,}) {
  return _then(_self.copyWith(
creditNoteId: null == creditNoteId ? _self.creditNoteId : creditNoteId // ignore: cast_nullable_to_non_nullable
as String,invoiceId: null == invoiceId ? _self.invoiceId : invoiceId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,gst: null == gst ? _self.gst : gst // ignore: cast_nullable_to_non_nullable
as double,totalCredit: null == totalCredit ? _self.totalCredit : totalCredit // ignore: cast_nullable_to_non_nullable
as double,workflow: null == workflow ? _self.workflow : workflow // ignore: cast_nullable_to_non_nullable
as CreditNoteWorkflow,auditTrail: null == auditTrail ? _self.auditTrail : auditTrail // ignore: cast_nullable_to_non_nullable
as List<AuditEntry>,approvedAt: freezed == approvedAt ? _self.approvedAt : approvedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of CreditNote
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CreditNoteWorkflowCopyWith<$Res> get workflow {
  
  return $CreditNoteWorkflowCopyWith<$Res>(_self.workflow, (value) {
    return _then(_self.copyWith(workflow: value));
  });
}
}


/// Adds pattern-matching-related methods to [CreditNote].
extension CreditNotePatterns on CreditNote {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreditNote value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreditNote() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreditNote value)  $default,){
final _that = this;
switch (_that) {
case _CreditNote():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreditNote value)?  $default,){
final _that = this;
switch (_that) {
case _CreditNote() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String creditNoteId,  String invoiceId,  double amount,  String reason,  String status,  String createdAt,  double gst,  double totalCredit,  CreditNoteWorkflow workflow,  List<AuditEntry> auditTrail,  String? approvedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreditNote() when $default != null:
return $default(_that.creditNoteId,_that.invoiceId,_that.amount,_that.reason,_that.status,_that.createdAt,_that.gst,_that.totalCredit,_that.workflow,_that.auditTrail,_that.approvedAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String creditNoteId,  String invoiceId,  double amount,  String reason,  String status,  String createdAt,  double gst,  double totalCredit,  CreditNoteWorkflow workflow,  List<AuditEntry> auditTrail,  String? approvedAt)  $default,) {final _that = this;
switch (_that) {
case _CreditNote():
return $default(_that.creditNoteId,_that.invoiceId,_that.amount,_that.reason,_that.status,_that.createdAt,_that.gst,_that.totalCredit,_that.workflow,_that.auditTrail,_that.approvedAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String creditNoteId,  String invoiceId,  double amount,  String reason,  String status,  String createdAt,  double gst,  double totalCredit,  CreditNoteWorkflow workflow,  List<AuditEntry> auditTrail,  String? approvedAt)?  $default,) {final _that = this;
switch (_that) {
case _CreditNote() when $default != null:
return $default(_that.creditNoteId,_that.invoiceId,_that.amount,_that.reason,_that.status,_that.createdAt,_that.gst,_that.totalCredit,_that.workflow,_that.auditTrail,_that.approvedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreditNote implements CreditNote {
  const _CreditNote({required this.creditNoteId, required this.invoiceId, required this.amount, required this.reason, required this.status, required this.createdAt, required this.gst, required this.totalCredit, required this.workflow, required final  List<AuditEntry> auditTrail, this.approvedAt}): _auditTrail = auditTrail;
  factory _CreditNote.fromJson(Map<String, dynamic> json) => _$CreditNoteFromJson(json);

@override final  String creditNoteId;
@override final  String invoiceId;
@override final  double amount;
@override final  String reason;
@override final  String status;
@override final  String createdAt;
@override final  double gst;
@override final  double totalCredit;
@override final  CreditNoteWorkflow workflow;
 final  List<AuditEntry> _auditTrail;
@override List<AuditEntry> get auditTrail {
  if (_auditTrail is EqualUnmodifiableListView) return _auditTrail;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_auditTrail);
}

@override final  String? approvedAt;

/// Create a copy of CreditNote
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreditNoteCopyWith<_CreditNote> get copyWith => __$CreditNoteCopyWithImpl<_CreditNote>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreditNoteToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreditNote&&(identical(other.creditNoteId, creditNoteId) || other.creditNoteId == creditNoteId)&&(identical(other.invoiceId, invoiceId) || other.invoiceId == invoiceId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.gst, gst) || other.gst == gst)&&(identical(other.totalCredit, totalCredit) || other.totalCredit == totalCredit)&&(identical(other.workflow, workflow) || other.workflow == workflow)&&const DeepCollectionEquality().equals(other._auditTrail, _auditTrail)&&(identical(other.approvedAt, approvedAt) || other.approvedAt == approvedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,creditNoteId,invoiceId,amount,reason,status,createdAt,gst,totalCredit,workflow,const DeepCollectionEquality().hash(_auditTrail),approvedAt);

@override
String toString() {
  return 'CreditNote(creditNoteId: $creditNoteId, invoiceId: $invoiceId, amount: $amount, reason: $reason, status: $status, createdAt: $createdAt, gst: $gst, totalCredit: $totalCredit, workflow: $workflow, auditTrail: $auditTrail, approvedAt: $approvedAt)';
}


}

/// @nodoc
abstract mixin class _$CreditNoteCopyWith<$Res> implements $CreditNoteCopyWith<$Res> {
  factory _$CreditNoteCopyWith(_CreditNote value, $Res Function(_CreditNote) _then) = __$CreditNoteCopyWithImpl;
@override @useResult
$Res call({
 String creditNoteId, String invoiceId, double amount, String reason, String status, String createdAt, double gst, double totalCredit, CreditNoteWorkflow workflow, List<AuditEntry> auditTrail, String? approvedAt
});


@override $CreditNoteWorkflowCopyWith<$Res> get workflow;

}
/// @nodoc
class __$CreditNoteCopyWithImpl<$Res>
    implements _$CreditNoteCopyWith<$Res> {
  __$CreditNoteCopyWithImpl(this._self, this._then);

  final _CreditNote _self;
  final $Res Function(_CreditNote) _then;

/// Create a copy of CreditNote
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? creditNoteId = null,Object? invoiceId = null,Object? amount = null,Object? reason = null,Object? status = null,Object? createdAt = null,Object? gst = null,Object? totalCredit = null,Object? workflow = null,Object? auditTrail = null,Object? approvedAt = freezed,}) {
  return _then(_CreditNote(
creditNoteId: null == creditNoteId ? _self.creditNoteId : creditNoteId // ignore: cast_nullable_to_non_nullable
as String,invoiceId: null == invoiceId ? _self.invoiceId : invoiceId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,gst: null == gst ? _self.gst : gst // ignore: cast_nullable_to_non_nullable
as double,totalCredit: null == totalCredit ? _self.totalCredit : totalCredit // ignore: cast_nullable_to_non_nullable
as double,workflow: null == workflow ? _self.workflow : workflow // ignore: cast_nullable_to_non_nullable
as CreditNoteWorkflow,auditTrail: null == auditTrail ? _self._auditTrail : auditTrail // ignore: cast_nullable_to_non_nullable
as List<AuditEntry>,approvedAt: freezed == approvedAt ? _self.approvedAt : approvedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of CreditNote
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CreditNoteWorkflowCopyWith<$Res> get workflow {
  
  return $CreditNoteWorkflowCopyWith<$Res>(_self.workflow, (value) {
    return _then(_self.copyWith(workflow: value));
  });
}
}


/// @nodoc
mixin _$CreditNoteWorkflow {

 bool get requiresApproval; String get approvalLevel; bool get autoApprove;
/// Create a copy of CreditNoteWorkflow
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreditNoteWorkflowCopyWith<CreditNoteWorkflow> get copyWith => _$CreditNoteWorkflowCopyWithImpl<CreditNoteWorkflow>(this as CreditNoteWorkflow, _$identity);

  /// Serializes this CreditNoteWorkflow to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreditNoteWorkflow&&(identical(other.requiresApproval, requiresApproval) || other.requiresApproval == requiresApproval)&&(identical(other.approvalLevel, approvalLevel) || other.approvalLevel == approvalLevel)&&(identical(other.autoApprove, autoApprove) || other.autoApprove == autoApprove));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,requiresApproval,approvalLevel,autoApprove);

@override
String toString() {
  return 'CreditNoteWorkflow(requiresApproval: $requiresApproval, approvalLevel: $approvalLevel, autoApprove: $autoApprove)';
}


}

/// @nodoc
abstract mixin class $CreditNoteWorkflowCopyWith<$Res>  {
  factory $CreditNoteWorkflowCopyWith(CreditNoteWorkflow value, $Res Function(CreditNoteWorkflow) _then) = _$CreditNoteWorkflowCopyWithImpl;
@useResult
$Res call({
 bool requiresApproval, String approvalLevel, bool autoApprove
});




}
/// @nodoc
class _$CreditNoteWorkflowCopyWithImpl<$Res>
    implements $CreditNoteWorkflowCopyWith<$Res> {
  _$CreditNoteWorkflowCopyWithImpl(this._self, this._then);

  final CreditNoteWorkflow _self;
  final $Res Function(CreditNoteWorkflow) _then;

/// Create a copy of CreditNoteWorkflow
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? requiresApproval = null,Object? approvalLevel = null,Object? autoApprove = null,}) {
  return _then(_self.copyWith(
requiresApproval: null == requiresApproval ? _self.requiresApproval : requiresApproval // ignore: cast_nullable_to_non_nullable
as bool,approvalLevel: null == approvalLevel ? _self.approvalLevel : approvalLevel // ignore: cast_nullable_to_non_nullable
as String,autoApprove: null == autoApprove ? _self.autoApprove : autoApprove // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CreditNoteWorkflow].
extension CreditNoteWorkflowPatterns on CreditNoteWorkflow {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreditNoteWorkflow value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreditNoteWorkflow() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreditNoteWorkflow value)  $default,){
final _that = this;
switch (_that) {
case _CreditNoteWorkflow():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreditNoteWorkflow value)?  $default,){
final _that = this;
switch (_that) {
case _CreditNoteWorkflow() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool requiresApproval,  String approvalLevel,  bool autoApprove)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreditNoteWorkflow() when $default != null:
return $default(_that.requiresApproval,_that.approvalLevel,_that.autoApprove);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool requiresApproval,  String approvalLevel,  bool autoApprove)  $default,) {final _that = this;
switch (_that) {
case _CreditNoteWorkflow():
return $default(_that.requiresApproval,_that.approvalLevel,_that.autoApprove);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool requiresApproval,  String approvalLevel,  bool autoApprove)?  $default,) {final _that = this;
switch (_that) {
case _CreditNoteWorkflow() when $default != null:
return $default(_that.requiresApproval,_that.approvalLevel,_that.autoApprove);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreditNoteWorkflow implements CreditNoteWorkflow {
  const _CreditNoteWorkflow({required this.requiresApproval, required this.approvalLevel, required this.autoApprove});
  factory _CreditNoteWorkflow.fromJson(Map<String, dynamic> json) => _$CreditNoteWorkflowFromJson(json);

@override final  bool requiresApproval;
@override final  String approvalLevel;
@override final  bool autoApprove;

/// Create a copy of CreditNoteWorkflow
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreditNoteWorkflowCopyWith<_CreditNoteWorkflow> get copyWith => __$CreditNoteWorkflowCopyWithImpl<_CreditNoteWorkflow>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreditNoteWorkflowToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreditNoteWorkflow&&(identical(other.requiresApproval, requiresApproval) || other.requiresApproval == requiresApproval)&&(identical(other.approvalLevel, approvalLevel) || other.approvalLevel == approvalLevel)&&(identical(other.autoApprove, autoApprove) || other.autoApprove == autoApprove));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,requiresApproval,approvalLevel,autoApprove);

@override
String toString() {
  return 'CreditNoteWorkflow(requiresApproval: $requiresApproval, approvalLevel: $approvalLevel, autoApprove: $autoApprove)';
}


}

/// @nodoc
abstract mixin class _$CreditNoteWorkflowCopyWith<$Res> implements $CreditNoteWorkflowCopyWith<$Res> {
  factory _$CreditNoteWorkflowCopyWith(_CreditNoteWorkflow value, $Res Function(_CreditNoteWorkflow) _then) = __$CreditNoteWorkflowCopyWithImpl;
@override @useResult
$Res call({
 bool requiresApproval, String approvalLevel, bool autoApprove
});




}
/// @nodoc
class __$CreditNoteWorkflowCopyWithImpl<$Res>
    implements _$CreditNoteWorkflowCopyWith<$Res> {
  __$CreditNoteWorkflowCopyWithImpl(this._self, this._then);

  final _CreditNoteWorkflow _self;
  final $Res Function(_CreditNoteWorkflow) _then;

/// Create a copy of CreditNoteWorkflow
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? requiresApproval = null,Object? approvalLevel = null,Object? autoApprove = null,}) {
  return _then(_CreditNoteWorkflow(
requiresApproval: null == requiresApproval ? _self.requiresApproval : requiresApproval // ignore: cast_nullable_to_non_nullable
as bool,approvalLevel: null == approvalLevel ? _self.approvalLevel : approvalLevel // ignore: cast_nullable_to_non_nullable
as String,autoApprove: null == autoApprove ? _self.autoApprove : autoApprove // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$AuditEntry {

 String get action; String get timestamp; String get reason;
/// Create a copy of AuditEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuditEntryCopyWith<AuditEntry> get copyWith => _$AuditEntryCopyWithImpl<AuditEntry>(this as AuditEntry, _$identity);

  /// Serializes this AuditEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuditEntry&&(identical(other.action, action) || other.action == action)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.reason, reason) || other.reason == reason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,action,timestamp,reason);

@override
String toString() {
  return 'AuditEntry(action: $action, timestamp: $timestamp, reason: $reason)';
}


}

/// @nodoc
abstract mixin class $AuditEntryCopyWith<$Res>  {
  factory $AuditEntryCopyWith(AuditEntry value, $Res Function(AuditEntry) _then) = _$AuditEntryCopyWithImpl;
@useResult
$Res call({
 String action, String timestamp, String reason
});




}
/// @nodoc
class _$AuditEntryCopyWithImpl<$Res>
    implements $AuditEntryCopyWith<$Res> {
  _$AuditEntryCopyWithImpl(this._self, this._then);

  final AuditEntry _self;
  final $Res Function(AuditEntry) _then;

/// Create a copy of AuditEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? action = null,Object? timestamp = null,Object? reason = null,}) {
  return _then(_self.copyWith(
action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AuditEntry].
extension AuditEntryPatterns on AuditEntry {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuditEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuditEntry() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuditEntry value)  $default,){
final _that = this;
switch (_that) {
case _AuditEntry():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuditEntry value)?  $default,){
final _that = this;
switch (_that) {
case _AuditEntry() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String action,  String timestamp,  String reason)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuditEntry() when $default != null:
return $default(_that.action,_that.timestamp,_that.reason);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String action,  String timestamp,  String reason)  $default,) {final _that = this;
switch (_that) {
case _AuditEntry():
return $default(_that.action,_that.timestamp,_that.reason);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String action,  String timestamp,  String reason)?  $default,) {final _that = this;
switch (_that) {
case _AuditEntry() when $default != null:
return $default(_that.action,_that.timestamp,_that.reason);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AuditEntry implements AuditEntry {
  const _AuditEntry({required this.action, required this.timestamp, required this.reason});
  factory _AuditEntry.fromJson(Map<String, dynamic> json) => _$AuditEntryFromJson(json);

@override final  String action;
@override final  String timestamp;
@override final  String reason;

/// Create a copy of AuditEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuditEntryCopyWith<_AuditEntry> get copyWith => __$AuditEntryCopyWithImpl<_AuditEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AuditEntryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuditEntry&&(identical(other.action, action) || other.action == action)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.reason, reason) || other.reason == reason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,action,timestamp,reason);

@override
String toString() {
  return 'AuditEntry(action: $action, timestamp: $timestamp, reason: $reason)';
}


}

/// @nodoc
abstract mixin class _$AuditEntryCopyWith<$Res> implements $AuditEntryCopyWith<$Res> {
  factory _$AuditEntryCopyWith(_AuditEntry value, $Res Function(_AuditEntry) _then) = __$AuditEntryCopyWithImpl;
@override @useResult
$Res call({
 String action, String timestamp, String reason
});




}
/// @nodoc
class __$AuditEntryCopyWithImpl<$Res>
    implements _$AuditEntryCopyWith<$Res> {
  __$AuditEntryCopyWithImpl(this._self, this._then);

  final _AuditEntry _self;
  final $Res Function(_AuditEntry) _then;

/// Create a copy of AuditEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? action = null,Object? timestamp = null,Object? reason = null,}) {
  return _then(_AuditEntry(
action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$CashFlowForecast {

 String get organizationId; int get horizon; String get generatedAt; CashPosition get currentPosition; List<DailyCashFlow> get dailyForecast; CashFlowSummary get summary; List<CashFlowRisk> get risks; List<String> get recommendations;
/// Create a copy of CashFlowForecast
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CashFlowForecastCopyWith<CashFlowForecast> get copyWith => _$CashFlowForecastCopyWithImpl<CashFlowForecast>(this as CashFlowForecast, _$identity);

  /// Serializes this CashFlowForecast to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CashFlowForecast&&(identical(other.organizationId, organizationId) || other.organizationId == organizationId)&&(identical(other.horizon, horizon) || other.horizon == horizon)&&(identical(other.generatedAt, generatedAt) || other.generatedAt == generatedAt)&&(identical(other.currentPosition, currentPosition) || other.currentPosition == currentPosition)&&const DeepCollectionEquality().equals(other.dailyForecast, dailyForecast)&&(identical(other.summary, summary) || other.summary == summary)&&const DeepCollectionEquality().equals(other.risks, risks)&&const DeepCollectionEquality().equals(other.recommendations, recommendations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,organizationId,horizon,generatedAt,currentPosition,const DeepCollectionEquality().hash(dailyForecast),summary,const DeepCollectionEquality().hash(risks),const DeepCollectionEquality().hash(recommendations));

@override
String toString() {
  return 'CashFlowForecast(organizationId: $organizationId, horizon: $horizon, generatedAt: $generatedAt, currentPosition: $currentPosition, dailyForecast: $dailyForecast, summary: $summary, risks: $risks, recommendations: $recommendations)';
}


}

/// @nodoc
abstract mixin class $CashFlowForecastCopyWith<$Res>  {
  factory $CashFlowForecastCopyWith(CashFlowForecast value, $Res Function(CashFlowForecast) _then) = _$CashFlowForecastCopyWithImpl;
@useResult
$Res call({
 String organizationId, int horizon, String generatedAt, CashPosition currentPosition, List<DailyCashFlow> dailyForecast, CashFlowSummary summary, List<CashFlowRisk> risks, List<String> recommendations
});


$CashPositionCopyWith<$Res> get currentPosition;$CashFlowSummaryCopyWith<$Res> get summary;

}
/// @nodoc
class _$CashFlowForecastCopyWithImpl<$Res>
    implements $CashFlowForecastCopyWith<$Res> {
  _$CashFlowForecastCopyWithImpl(this._self, this._then);

  final CashFlowForecast _self;
  final $Res Function(CashFlowForecast) _then;

/// Create a copy of CashFlowForecast
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? organizationId = null,Object? horizon = null,Object? generatedAt = null,Object? currentPosition = null,Object? dailyForecast = null,Object? summary = null,Object? risks = null,Object? recommendations = null,}) {
  return _then(_self.copyWith(
organizationId: null == organizationId ? _self.organizationId : organizationId // ignore: cast_nullable_to_non_nullable
as String,horizon: null == horizon ? _self.horizon : horizon // ignore: cast_nullable_to_non_nullable
as int,generatedAt: null == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as String,currentPosition: null == currentPosition ? _self.currentPosition : currentPosition // ignore: cast_nullable_to_non_nullable
as CashPosition,dailyForecast: null == dailyForecast ? _self.dailyForecast : dailyForecast // ignore: cast_nullable_to_non_nullable
as List<DailyCashFlow>,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as CashFlowSummary,risks: null == risks ? _self.risks : risks // ignore: cast_nullable_to_non_nullable
as List<CashFlowRisk>,recommendations: null == recommendations ? _self.recommendations : recommendations // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}
/// Create a copy of CashFlowForecast
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CashPositionCopyWith<$Res> get currentPosition {
  
  return $CashPositionCopyWith<$Res>(_self.currentPosition, (value) {
    return _then(_self.copyWith(currentPosition: value));
  });
}/// Create a copy of CashFlowForecast
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CashFlowSummaryCopyWith<$Res> get summary {
  
  return $CashFlowSummaryCopyWith<$Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}
}


/// Adds pattern-matching-related methods to [CashFlowForecast].
extension CashFlowForecastPatterns on CashFlowForecast {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CashFlowForecast value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CashFlowForecast() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CashFlowForecast value)  $default,){
final _that = this;
switch (_that) {
case _CashFlowForecast():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CashFlowForecast value)?  $default,){
final _that = this;
switch (_that) {
case _CashFlowForecast() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String organizationId,  int horizon,  String generatedAt,  CashPosition currentPosition,  List<DailyCashFlow> dailyForecast,  CashFlowSummary summary,  List<CashFlowRisk> risks,  List<String> recommendations)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CashFlowForecast() when $default != null:
return $default(_that.organizationId,_that.horizon,_that.generatedAt,_that.currentPosition,_that.dailyForecast,_that.summary,_that.risks,_that.recommendations);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String organizationId,  int horizon,  String generatedAt,  CashPosition currentPosition,  List<DailyCashFlow> dailyForecast,  CashFlowSummary summary,  List<CashFlowRisk> risks,  List<String> recommendations)  $default,) {final _that = this;
switch (_that) {
case _CashFlowForecast():
return $default(_that.organizationId,_that.horizon,_that.generatedAt,_that.currentPosition,_that.dailyForecast,_that.summary,_that.risks,_that.recommendations);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String organizationId,  int horizon,  String generatedAt,  CashPosition currentPosition,  List<DailyCashFlow> dailyForecast,  CashFlowSummary summary,  List<CashFlowRisk> risks,  List<String> recommendations)?  $default,) {final _that = this;
switch (_that) {
case _CashFlowForecast() when $default != null:
return $default(_that.organizationId,_that.horizon,_that.generatedAt,_that.currentPosition,_that.dailyForecast,_that.summary,_that.risks,_that.recommendations);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CashFlowForecast implements CashFlowForecast {
  const _CashFlowForecast({required this.organizationId, required this.horizon, required this.generatedAt, required this.currentPosition, required final  List<DailyCashFlow> dailyForecast, required this.summary, required final  List<CashFlowRisk> risks, required final  List<String> recommendations}): _dailyForecast = dailyForecast,_risks = risks,_recommendations = recommendations;
  factory _CashFlowForecast.fromJson(Map<String, dynamic> json) => _$CashFlowForecastFromJson(json);

@override final  String organizationId;
@override final  int horizon;
@override final  String generatedAt;
@override final  CashPosition currentPosition;
 final  List<DailyCashFlow> _dailyForecast;
@override List<DailyCashFlow> get dailyForecast {
  if (_dailyForecast is EqualUnmodifiableListView) return _dailyForecast;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_dailyForecast);
}

@override final  CashFlowSummary summary;
 final  List<CashFlowRisk> _risks;
@override List<CashFlowRisk> get risks {
  if (_risks is EqualUnmodifiableListView) return _risks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_risks);
}

 final  List<String> _recommendations;
@override List<String> get recommendations {
  if (_recommendations is EqualUnmodifiableListView) return _recommendations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recommendations);
}


/// Create a copy of CashFlowForecast
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CashFlowForecastCopyWith<_CashFlowForecast> get copyWith => __$CashFlowForecastCopyWithImpl<_CashFlowForecast>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CashFlowForecastToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CashFlowForecast&&(identical(other.organizationId, organizationId) || other.organizationId == organizationId)&&(identical(other.horizon, horizon) || other.horizon == horizon)&&(identical(other.generatedAt, generatedAt) || other.generatedAt == generatedAt)&&(identical(other.currentPosition, currentPosition) || other.currentPosition == currentPosition)&&const DeepCollectionEquality().equals(other._dailyForecast, _dailyForecast)&&(identical(other.summary, summary) || other.summary == summary)&&const DeepCollectionEquality().equals(other._risks, _risks)&&const DeepCollectionEquality().equals(other._recommendations, _recommendations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,organizationId,horizon,generatedAt,currentPosition,const DeepCollectionEquality().hash(_dailyForecast),summary,const DeepCollectionEquality().hash(_risks),const DeepCollectionEquality().hash(_recommendations));

@override
String toString() {
  return 'CashFlowForecast(organizationId: $organizationId, horizon: $horizon, generatedAt: $generatedAt, currentPosition: $currentPosition, dailyForecast: $dailyForecast, summary: $summary, risks: $risks, recommendations: $recommendations)';
}


}

/// @nodoc
abstract mixin class _$CashFlowForecastCopyWith<$Res> implements $CashFlowForecastCopyWith<$Res> {
  factory _$CashFlowForecastCopyWith(_CashFlowForecast value, $Res Function(_CashFlowForecast) _then) = __$CashFlowForecastCopyWithImpl;
@override @useResult
$Res call({
 String organizationId, int horizon, String generatedAt, CashPosition currentPosition, List<DailyCashFlow> dailyForecast, CashFlowSummary summary, List<CashFlowRisk> risks, List<String> recommendations
});


@override $CashPositionCopyWith<$Res> get currentPosition;@override $CashFlowSummaryCopyWith<$Res> get summary;

}
/// @nodoc
class __$CashFlowForecastCopyWithImpl<$Res>
    implements _$CashFlowForecastCopyWith<$Res> {
  __$CashFlowForecastCopyWithImpl(this._self, this._then);

  final _CashFlowForecast _self;
  final $Res Function(_CashFlowForecast) _then;

/// Create a copy of CashFlowForecast
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? organizationId = null,Object? horizon = null,Object? generatedAt = null,Object? currentPosition = null,Object? dailyForecast = null,Object? summary = null,Object? risks = null,Object? recommendations = null,}) {
  return _then(_CashFlowForecast(
organizationId: null == organizationId ? _self.organizationId : organizationId // ignore: cast_nullable_to_non_nullable
as String,horizon: null == horizon ? _self.horizon : horizon // ignore: cast_nullable_to_non_nullable
as int,generatedAt: null == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as String,currentPosition: null == currentPosition ? _self.currentPosition : currentPosition // ignore: cast_nullable_to_non_nullable
as CashPosition,dailyForecast: null == dailyForecast ? _self._dailyForecast : dailyForecast // ignore: cast_nullable_to_non_nullable
as List<DailyCashFlow>,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as CashFlowSummary,risks: null == risks ? _self._risks : risks // ignore: cast_nullable_to_non_nullable
as List<CashFlowRisk>,recommendations: null == recommendations ? _self._recommendations : recommendations // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

/// Create a copy of CashFlowForecast
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CashPositionCopyWith<$Res> get currentPosition {
  
  return $CashPositionCopyWith<$Res>(_self.currentPosition, (value) {
    return _then(_self.copyWith(currentPosition: value));
  });
}/// Create a copy of CashFlowForecast
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CashFlowSummaryCopyWith<$Res> get summary {
  
  return $CashFlowSummaryCopyWith<$Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}
}


/// @nodoc
mixin _$CashPosition {

 double get cash; double get receivables; double get payables; double get netPosition;
/// Create a copy of CashPosition
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CashPositionCopyWith<CashPosition> get copyWith => _$CashPositionCopyWithImpl<CashPosition>(this as CashPosition, _$identity);

  /// Serializes this CashPosition to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CashPosition&&(identical(other.cash, cash) || other.cash == cash)&&(identical(other.receivables, receivables) || other.receivables == receivables)&&(identical(other.payables, payables) || other.payables == payables)&&(identical(other.netPosition, netPosition) || other.netPosition == netPosition));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cash,receivables,payables,netPosition);

@override
String toString() {
  return 'CashPosition(cash: $cash, receivables: $receivables, payables: $payables, netPosition: $netPosition)';
}


}

/// @nodoc
abstract mixin class $CashPositionCopyWith<$Res>  {
  factory $CashPositionCopyWith(CashPosition value, $Res Function(CashPosition) _then) = _$CashPositionCopyWithImpl;
@useResult
$Res call({
 double cash, double receivables, double payables, double netPosition
});




}
/// @nodoc
class _$CashPositionCopyWithImpl<$Res>
    implements $CashPositionCopyWith<$Res> {
  _$CashPositionCopyWithImpl(this._self, this._then);

  final CashPosition _self;
  final $Res Function(CashPosition) _then;

/// Create a copy of CashPosition
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cash = null,Object? receivables = null,Object? payables = null,Object? netPosition = null,}) {
  return _then(_self.copyWith(
cash: null == cash ? _self.cash : cash // ignore: cast_nullable_to_non_nullable
as double,receivables: null == receivables ? _self.receivables : receivables // ignore: cast_nullable_to_non_nullable
as double,payables: null == payables ? _self.payables : payables // ignore: cast_nullable_to_non_nullable
as double,netPosition: null == netPosition ? _self.netPosition : netPosition // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [CashPosition].
extension CashPositionPatterns on CashPosition {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CashPosition value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CashPosition() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CashPosition value)  $default,){
final _that = this;
switch (_that) {
case _CashPosition():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CashPosition value)?  $default,){
final _that = this;
switch (_that) {
case _CashPosition() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double cash,  double receivables,  double payables,  double netPosition)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CashPosition() when $default != null:
return $default(_that.cash,_that.receivables,_that.payables,_that.netPosition);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double cash,  double receivables,  double payables,  double netPosition)  $default,) {final _that = this;
switch (_that) {
case _CashPosition():
return $default(_that.cash,_that.receivables,_that.payables,_that.netPosition);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double cash,  double receivables,  double payables,  double netPosition)?  $default,) {final _that = this;
switch (_that) {
case _CashPosition() when $default != null:
return $default(_that.cash,_that.receivables,_that.payables,_that.netPosition);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CashPosition implements CashPosition {
  const _CashPosition({required this.cash, required this.receivables, required this.payables, required this.netPosition});
  factory _CashPosition.fromJson(Map<String, dynamic> json) => _$CashPositionFromJson(json);

@override final  double cash;
@override final  double receivables;
@override final  double payables;
@override final  double netPosition;

/// Create a copy of CashPosition
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CashPositionCopyWith<_CashPosition> get copyWith => __$CashPositionCopyWithImpl<_CashPosition>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CashPositionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CashPosition&&(identical(other.cash, cash) || other.cash == cash)&&(identical(other.receivables, receivables) || other.receivables == receivables)&&(identical(other.payables, payables) || other.payables == payables)&&(identical(other.netPosition, netPosition) || other.netPosition == netPosition));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cash,receivables,payables,netPosition);

@override
String toString() {
  return 'CashPosition(cash: $cash, receivables: $receivables, payables: $payables, netPosition: $netPosition)';
}


}

/// @nodoc
abstract mixin class _$CashPositionCopyWith<$Res> implements $CashPositionCopyWith<$Res> {
  factory _$CashPositionCopyWith(_CashPosition value, $Res Function(_CashPosition) _then) = __$CashPositionCopyWithImpl;
@override @useResult
$Res call({
 double cash, double receivables, double payables, double netPosition
});




}
/// @nodoc
class __$CashPositionCopyWithImpl<$Res>
    implements _$CashPositionCopyWith<$Res> {
  __$CashPositionCopyWithImpl(this._self, this._then);

  final _CashPosition _self;
  final $Res Function(_CashPosition) _then;

/// Create a copy of CashPosition
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cash = null,Object? receivables = null,Object? payables = null,Object? netPosition = null,}) {
  return _then(_CashPosition(
cash: null == cash ? _self.cash : cash // ignore: cast_nullable_to_non_nullable
as double,receivables: null == receivables ? _self.receivables : receivables // ignore: cast_nullable_to_non_nullable
as double,payables: null == payables ? _self.payables : payables // ignore: cast_nullable_to_non_nullable
as double,netPosition: null == netPosition ? _self.netPosition : netPosition // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$DailyCashFlow {

 String get date; double get openingBalance; double get inflows; double get outflows; double get netFlow; double get closingBalance; double get confidence;
/// Create a copy of DailyCashFlow
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DailyCashFlowCopyWith<DailyCashFlow> get copyWith => _$DailyCashFlowCopyWithImpl<DailyCashFlow>(this as DailyCashFlow, _$identity);

  /// Serializes this DailyCashFlow to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DailyCashFlow&&(identical(other.date, date) || other.date == date)&&(identical(other.openingBalance, openingBalance) || other.openingBalance == openingBalance)&&(identical(other.inflows, inflows) || other.inflows == inflows)&&(identical(other.outflows, outflows) || other.outflows == outflows)&&(identical(other.netFlow, netFlow) || other.netFlow == netFlow)&&(identical(other.closingBalance, closingBalance) || other.closingBalance == closingBalance)&&(identical(other.confidence, confidence) || other.confidence == confidence));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,openingBalance,inflows,outflows,netFlow,closingBalance,confidence);

@override
String toString() {
  return 'DailyCashFlow(date: $date, openingBalance: $openingBalance, inflows: $inflows, outflows: $outflows, netFlow: $netFlow, closingBalance: $closingBalance, confidence: $confidence)';
}


}

/// @nodoc
abstract mixin class $DailyCashFlowCopyWith<$Res>  {
  factory $DailyCashFlowCopyWith(DailyCashFlow value, $Res Function(DailyCashFlow) _then) = _$DailyCashFlowCopyWithImpl;
@useResult
$Res call({
 String date, double openingBalance, double inflows, double outflows, double netFlow, double closingBalance, double confidence
});




}
/// @nodoc
class _$DailyCashFlowCopyWithImpl<$Res>
    implements $DailyCashFlowCopyWith<$Res> {
  _$DailyCashFlowCopyWithImpl(this._self, this._then);

  final DailyCashFlow _self;
  final $Res Function(DailyCashFlow) _then;

/// Create a copy of DailyCashFlow
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? openingBalance = null,Object? inflows = null,Object? outflows = null,Object? netFlow = null,Object? closingBalance = null,Object? confidence = null,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,openingBalance: null == openingBalance ? _self.openingBalance : openingBalance // ignore: cast_nullable_to_non_nullable
as double,inflows: null == inflows ? _self.inflows : inflows // ignore: cast_nullable_to_non_nullable
as double,outflows: null == outflows ? _self.outflows : outflows // ignore: cast_nullable_to_non_nullable
as double,netFlow: null == netFlow ? _self.netFlow : netFlow // ignore: cast_nullable_to_non_nullable
as double,closingBalance: null == closingBalance ? _self.closingBalance : closingBalance // ignore: cast_nullable_to_non_nullable
as double,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [DailyCashFlow].
extension DailyCashFlowPatterns on DailyCashFlow {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DailyCashFlow value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DailyCashFlow() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DailyCashFlow value)  $default,){
final _that = this;
switch (_that) {
case _DailyCashFlow():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DailyCashFlow value)?  $default,){
final _that = this;
switch (_that) {
case _DailyCashFlow() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String date,  double openingBalance,  double inflows,  double outflows,  double netFlow,  double closingBalance,  double confidence)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DailyCashFlow() when $default != null:
return $default(_that.date,_that.openingBalance,_that.inflows,_that.outflows,_that.netFlow,_that.closingBalance,_that.confidence);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String date,  double openingBalance,  double inflows,  double outflows,  double netFlow,  double closingBalance,  double confidence)  $default,) {final _that = this;
switch (_that) {
case _DailyCashFlow():
return $default(_that.date,_that.openingBalance,_that.inflows,_that.outflows,_that.netFlow,_that.closingBalance,_that.confidence);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String date,  double openingBalance,  double inflows,  double outflows,  double netFlow,  double closingBalance,  double confidence)?  $default,) {final _that = this;
switch (_that) {
case _DailyCashFlow() when $default != null:
return $default(_that.date,_that.openingBalance,_that.inflows,_that.outflows,_that.netFlow,_that.closingBalance,_that.confidence);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DailyCashFlow implements DailyCashFlow {
  const _DailyCashFlow({required this.date, required this.openingBalance, required this.inflows, required this.outflows, required this.netFlow, required this.closingBalance, required this.confidence});
  factory _DailyCashFlow.fromJson(Map<String, dynamic> json) => _$DailyCashFlowFromJson(json);

@override final  String date;
@override final  double openingBalance;
@override final  double inflows;
@override final  double outflows;
@override final  double netFlow;
@override final  double closingBalance;
@override final  double confidence;

/// Create a copy of DailyCashFlow
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DailyCashFlowCopyWith<_DailyCashFlow> get copyWith => __$DailyCashFlowCopyWithImpl<_DailyCashFlow>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DailyCashFlowToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DailyCashFlow&&(identical(other.date, date) || other.date == date)&&(identical(other.openingBalance, openingBalance) || other.openingBalance == openingBalance)&&(identical(other.inflows, inflows) || other.inflows == inflows)&&(identical(other.outflows, outflows) || other.outflows == outflows)&&(identical(other.netFlow, netFlow) || other.netFlow == netFlow)&&(identical(other.closingBalance, closingBalance) || other.closingBalance == closingBalance)&&(identical(other.confidence, confidence) || other.confidence == confidence));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,openingBalance,inflows,outflows,netFlow,closingBalance,confidence);

@override
String toString() {
  return 'DailyCashFlow(date: $date, openingBalance: $openingBalance, inflows: $inflows, outflows: $outflows, netFlow: $netFlow, closingBalance: $closingBalance, confidence: $confidence)';
}


}

/// @nodoc
abstract mixin class _$DailyCashFlowCopyWith<$Res> implements $DailyCashFlowCopyWith<$Res> {
  factory _$DailyCashFlowCopyWith(_DailyCashFlow value, $Res Function(_DailyCashFlow) _then) = __$DailyCashFlowCopyWithImpl;
@override @useResult
$Res call({
 String date, double openingBalance, double inflows, double outflows, double netFlow, double closingBalance, double confidence
});




}
/// @nodoc
class __$DailyCashFlowCopyWithImpl<$Res>
    implements _$DailyCashFlowCopyWith<$Res> {
  __$DailyCashFlowCopyWithImpl(this._self, this._then);

  final _DailyCashFlow _self;
  final $Res Function(_DailyCashFlow) _then;

/// Create a copy of DailyCashFlow
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? openingBalance = null,Object? inflows = null,Object? outflows = null,Object? netFlow = null,Object? closingBalance = null,Object? confidence = null,}) {
  return _then(_DailyCashFlow(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,openingBalance: null == openingBalance ? _self.openingBalance : openingBalance // ignore: cast_nullable_to_non_nullable
as double,inflows: null == inflows ? _self.inflows : inflows // ignore: cast_nullable_to_non_nullable
as double,outflows: null == outflows ? _self.outflows : outflows // ignore: cast_nullable_to_non_nullable
as double,netFlow: null == netFlow ? _self.netFlow : netFlow // ignore: cast_nullable_to_non_nullable
as double,closingBalance: null == closingBalance ? _self.closingBalance : closingBalance // ignore: cast_nullable_to_non_nullable
as double,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$CashFlowSummary {

 double get projectedInflows; double get projectedOutflows; double get netCashFlow; double get minimumBalance; double get maximumBalance;
/// Create a copy of CashFlowSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CashFlowSummaryCopyWith<CashFlowSummary> get copyWith => _$CashFlowSummaryCopyWithImpl<CashFlowSummary>(this as CashFlowSummary, _$identity);

  /// Serializes this CashFlowSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CashFlowSummary&&(identical(other.projectedInflows, projectedInflows) || other.projectedInflows == projectedInflows)&&(identical(other.projectedOutflows, projectedOutflows) || other.projectedOutflows == projectedOutflows)&&(identical(other.netCashFlow, netCashFlow) || other.netCashFlow == netCashFlow)&&(identical(other.minimumBalance, minimumBalance) || other.minimumBalance == minimumBalance)&&(identical(other.maximumBalance, maximumBalance) || other.maximumBalance == maximumBalance));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,projectedInflows,projectedOutflows,netCashFlow,minimumBalance,maximumBalance);

@override
String toString() {
  return 'CashFlowSummary(projectedInflows: $projectedInflows, projectedOutflows: $projectedOutflows, netCashFlow: $netCashFlow, minimumBalance: $minimumBalance, maximumBalance: $maximumBalance)';
}


}

/// @nodoc
abstract mixin class $CashFlowSummaryCopyWith<$Res>  {
  factory $CashFlowSummaryCopyWith(CashFlowSummary value, $Res Function(CashFlowSummary) _then) = _$CashFlowSummaryCopyWithImpl;
@useResult
$Res call({
 double projectedInflows, double projectedOutflows, double netCashFlow, double minimumBalance, double maximumBalance
});




}
/// @nodoc
class _$CashFlowSummaryCopyWithImpl<$Res>
    implements $CashFlowSummaryCopyWith<$Res> {
  _$CashFlowSummaryCopyWithImpl(this._self, this._then);

  final CashFlowSummary _self;
  final $Res Function(CashFlowSummary) _then;

/// Create a copy of CashFlowSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? projectedInflows = null,Object? projectedOutflows = null,Object? netCashFlow = null,Object? minimumBalance = null,Object? maximumBalance = null,}) {
  return _then(_self.copyWith(
projectedInflows: null == projectedInflows ? _self.projectedInflows : projectedInflows // ignore: cast_nullable_to_non_nullable
as double,projectedOutflows: null == projectedOutflows ? _self.projectedOutflows : projectedOutflows // ignore: cast_nullable_to_non_nullable
as double,netCashFlow: null == netCashFlow ? _self.netCashFlow : netCashFlow // ignore: cast_nullable_to_non_nullable
as double,minimumBalance: null == minimumBalance ? _self.minimumBalance : minimumBalance // ignore: cast_nullable_to_non_nullable
as double,maximumBalance: null == maximumBalance ? _self.maximumBalance : maximumBalance // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [CashFlowSummary].
extension CashFlowSummaryPatterns on CashFlowSummary {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CashFlowSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CashFlowSummary() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CashFlowSummary value)  $default,){
final _that = this;
switch (_that) {
case _CashFlowSummary():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CashFlowSummary value)?  $default,){
final _that = this;
switch (_that) {
case _CashFlowSummary() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double projectedInflows,  double projectedOutflows,  double netCashFlow,  double minimumBalance,  double maximumBalance)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CashFlowSummary() when $default != null:
return $default(_that.projectedInflows,_that.projectedOutflows,_that.netCashFlow,_that.minimumBalance,_that.maximumBalance);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double projectedInflows,  double projectedOutflows,  double netCashFlow,  double minimumBalance,  double maximumBalance)  $default,) {final _that = this;
switch (_that) {
case _CashFlowSummary():
return $default(_that.projectedInflows,_that.projectedOutflows,_that.netCashFlow,_that.minimumBalance,_that.maximumBalance);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double projectedInflows,  double projectedOutflows,  double netCashFlow,  double minimumBalance,  double maximumBalance)?  $default,) {final _that = this;
switch (_that) {
case _CashFlowSummary() when $default != null:
return $default(_that.projectedInflows,_that.projectedOutflows,_that.netCashFlow,_that.minimumBalance,_that.maximumBalance);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CashFlowSummary implements CashFlowSummary {
  const _CashFlowSummary({required this.projectedInflows, required this.projectedOutflows, required this.netCashFlow, required this.minimumBalance, required this.maximumBalance});
  factory _CashFlowSummary.fromJson(Map<String, dynamic> json) => _$CashFlowSummaryFromJson(json);

@override final  double projectedInflows;
@override final  double projectedOutflows;
@override final  double netCashFlow;
@override final  double minimumBalance;
@override final  double maximumBalance;

/// Create a copy of CashFlowSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CashFlowSummaryCopyWith<_CashFlowSummary> get copyWith => __$CashFlowSummaryCopyWithImpl<_CashFlowSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CashFlowSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CashFlowSummary&&(identical(other.projectedInflows, projectedInflows) || other.projectedInflows == projectedInflows)&&(identical(other.projectedOutflows, projectedOutflows) || other.projectedOutflows == projectedOutflows)&&(identical(other.netCashFlow, netCashFlow) || other.netCashFlow == netCashFlow)&&(identical(other.minimumBalance, minimumBalance) || other.minimumBalance == minimumBalance)&&(identical(other.maximumBalance, maximumBalance) || other.maximumBalance == maximumBalance));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,projectedInflows,projectedOutflows,netCashFlow,minimumBalance,maximumBalance);

@override
String toString() {
  return 'CashFlowSummary(projectedInflows: $projectedInflows, projectedOutflows: $projectedOutflows, netCashFlow: $netCashFlow, minimumBalance: $minimumBalance, maximumBalance: $maximumBalance)';
}


}

/// @nodoc
abstract mixin class _$CashFlowSummaryCopyWith<$Res> implements $CashFlowSummaryCopyWith<$Res> {
  factory _$CashFlowSummaryCopyWith(_CashFlowSummary value, $Res Function(_CashFlowSummary) _then) = __$CashFlowSummaryCopyWithImpl;
@override @useResult
$Res call({
 double projectedInflows, double projectedOutflows, double netCashFlow, double minimumBalance, double maximumBalance
});




}
/// @nodoc
class __$CashFlowSummaryCopyWithImpl<$Res>
    implements _$CashFlowSummaryCopyWith<$Res> {
  __$CashFlowSummaryCopyWithImpl(this._self, this._then);

  final _CashFlowSummary _self;
  final $Res Function(_CashFlowSummary) _then;

/// Create a copy of CashFlowSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? projectedInflows = null,Object? projectedOutflows = null,Object? netCashFlow = null,Object? minimumBalance = null,Object? maximumBalance = null,}) {
  return _then(_CashFlowSummary(
projectedInflows: null == projectedInflows ? _self.projectedInflows : projectedInflows // ignore: cast_nullable_to_non_nullable
as double,projectedOutflows: null == projectedOutflows ? _self.projectedOutflows : projectedOutflows // ignore: cast_nullable_to_non_nullable
as double,netCashFlow: null == netCashFlow ? _self.netCashFlow : netCashFlow // ignore: cast_nullable_to_non_nullable
as double,minimumBalance: null == minimumBalance ? _self.minimumBalance : minimumBalance // ignore: cast_nullable_to_non_nullable
as double,maximumBalance: null == maximumBalance ? _self.maximumBalance : maximumBalance // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$CashFlowRisk {

 String get risk; String get level; String get description; double get probability;
/// Create a copy of CashFlowRisk
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CashFlowRiskCopyWith<CashFlowRisk> get copyWith => _$CashFlowRiskCopyWithImpl<CashFlowRisk>(this as CashFlowRisk, _$identity);

  /// Serializes this CashFlowRisk to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CashFlowRisk&&(identical(other.risk, risk) || other.risk == risk)&&(identical(other.level, level) || other.level == level)&&(identical(other.description, description) || other.description == description)&&(identical(other.probability, probability) || other.probability == probability));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,risk,level,description,probability);

@override
String toString() {
  return 'CashFlowRisk(risk: $risk, level: $level, description: $description, probability: $probability)';
}


}

/// @nodoc
abstract mixin class $CashFlowRiskCopyWith<$Res>  {
  factory $CashFlowRiskCopyWith(CashFlowRisk value, $Res Function(CashFlowRisk) _then) = _$CashFlowRiskCopyWithImpl;
@useResult
$Res call({
 String risk, String level, String description, double probability
});




}
/// @nodoc
class _$CashFlowRiskCopyWithImpl<$Res>
    implements $CashFlowRiskCopyWith<$Res> {
  _$CashFlowRiskCopyWithImpl(this._self, this._then);

  final CashFlowRisk _self;
  final $Res Function(CashFlowRisk) _then;

/// Create a copy of CashFlowRisk
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? risk = null,Object? level = null,Object? description = null,Object? probability = null,}) {
  return _then(_self.copyWith(
risk: null == risk ? _self.risk : risk // ignore: cast_nullable_to_non_nullable
as String,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,probability: null == probability ? _self.probability : probability // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [CashFlowRisk].
extension CashFlowRiskPatterns on CashFlowRisk {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CashFlowRisk value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CashFlowRisk() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CashFlowRisk value)  $default,){
final _that = this;
switch (_that) {
case _CashFlowRisk():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CashFlowRisk value)?  $default,){
final _that = this;
switch (_that) {
case _CashFlowRisk() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String risk,  String level,  String description,  double probability)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CashFlowRisk() when $default != null:
return $default(_that.risk,_that.level,_that.description,_that.probability);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String risk,  String level,  String description,  double probability)  $default,) {final _that = this;
switch (_that) {
case _CashFlowRisk():
return $default(_that.risk,_that.level,_that.description,_that.probability);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String risk,  String level,  String description,  double probability)?  $default,) {final _that = this;
switch (_that) {
case _CashFlowRisk() when $default != null:
return $default(_that.risk,_that.level,_that.description,_that.probability);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CashFlowRisk implements CashFlowRisk {
  const _CashFlowRisk({required this.risk, required this.level, required this.description, required this.probability});
  factory _CashFlowRisk.fromJson(Map<String, dynamic> json) => _$CashFlowRiskFromJson(json);

@override final  String risk;
@override final  String level;
@override final  String description;
@override final  double probability;

/// Create a copy of CashFlowRisk
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CashFlowRiskCopyWith<_CashFlowRisk> get copyWith => __$CashFlowRiskCopyWithImpl<_CashFlowRisk>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CashFlowRiskToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CashFlowRisk&&(identical(other.risk, risk) || other.risk == risk)&&(identical(other.level, level) || other.level == level)&&(identical(other.description, description) || other.description == description)&&(identical(other.probability, probability) || other.probability == probability));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,risk,level,description,probability);

@override
String toString() {
  return 'CashFlowRisk(risk: $risk, level: $level, description: $description, probability: $probability)';
}


}

/// @nodoc
abstract mixin class _$CashFlowRiskCopyWith<$Res> implements $CashFlowRiskCopyWith<$Res> {
  factory _$CashFlowRiskCopyWith(_CashFlowRisk value, $Res Function(_CashFlowRisk) _then) = __$CashFlowRiskCopyWithImpl;
@override @useResult
$Res call({
 String risk, String level, String description, double probability
});




}
/// @nodoc
class __$CashFlowRiskCopyWithImpl<$Res>
    implements _$CashFlowRiskCopyWith<$Res> {
  __$CashFlowRiskCopyWithImpl(this._self, this._then);

  final _CashFlowRisk _self;
  final $Res Function(_CashFlowRisk) _then;

/// Create a copy of CashFlowRisk
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? risk = null,Object? level = null,Object? description = null,Object? probability = null,}) {
  return _then(_CashFlowRisk(
risk: null == risk ? _self.risk : risk // ignore: cast_nullable_to_non_nullable
as String,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,probability: null == probability ? _self.probability : probability // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$PaymentPrediction {

 String get invoiceId; String get clientId; double get amount; String get dueDate; double get paymentProbability; String get expectedPaymentDate; int get expectedDaysLate; String get latePaymentRisk; double get badDebtProbability; List<String> get actions;
/// Create a copy of PaymentPrediction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentPredictionCopyWith<PaymentPrediction> get copyWith => _$PaymentPredictionCopyWithImpl<PaymentPrediction>(this as PaymentPrediction, _$identity);

  /// Serializes this PaymentPrediction to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentPrediction&&(identical(other.invoiceId, invoiceId) || other.invoiceId == invoiceId)&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.paymentProbability, paymentProbability) || other.paymentProbability == paymentProbability)&&(identical(other.expectedPaymentDate, expectedPaymentDate) || other.expectedPaymentDate == expectedPaymentDate)&&(identical(other.expectedDaysLate, expectedDaysLate) || other.expectedDaysLate == expectedDaysLate)&&(identical(other.latePaymentRisk, latePaymentRisk) || other.latePaymentRisk == latePaymentRisk)&&(identical(other.badDebtProbability, badDebtProbability) || other.badDebtProbability == badDebtProbability)&&const DeepCollectionEquality().equals(other.actions, actions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,invoiceId,clientId,amount,dueDate,paymentProbability,expectedPaymentDate,expectedDaysLate,latePaymentRisk,badDebtProbability,const DeepCollectionEquality().hash(actions));

@override
String toString() {
  return 'PaymentPrediction(invoiceId: $invoiceId, clientId: $clientId, amount: $amount, dueDate: $dueDate, paymentProbability: $paymentProbability, expectedPaymentDate: $expectedPaymentDate, expectedDaysLate: $expectedDaysLate, latePaymentRisk: $latePaymentRisk, badDebtProbability: $badDebtProbability, actions: $actions)';
}


}

/// @nodoc
abstract mixin class $PaymentPredictionCopyWith<$Res>  {
  factory $PaymentPredictionCopyWith(PaymentPrediction value, $Res Function(PaymentPrediction) _then) = _$PaymentPredictionCopyWithImpl;
@useResult
$Res call({
 String invoiceId, String clientId, double amount, String dueDate, double paymentProbability, String expectedPaymentDate, int expectedDaysLate, String latePaymentRisk, double badDebtProbability, List<String> actions
});




}
/// @nodoc
class _$PaymentPredictionCopyWithImpl<$Res>
    implements $PaymentPredictionCopyWith<$Res> {
  _$PaymentPredictionCopyWithImpl(this._self, this._then);

  final PaymentPrediction _self;
  final $Res Function(PaymentPrediction) _then;

/// Create a copy of PaymentPrediction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? invoiceId = null,Object? clientId = null,Object? amount = null,Object? dueDate = null,Object? paymentProbability = null,Object? expectedPaymentDate = null,Object? expectedDaysLate = null,Object? latePaymentRisk = null,Object? badDebtProbability = null,Object? actions = null,}) {
  return _then(_self.copyWith(
invoiceId: null == invoiceId ? _self.invoiceId : invoiceId // ignore: cast_nullable_to_non_nullable
as String,clientId: null == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,dueDate: null == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as String,paymentProbability: null == paymentProbability ? _self.paymentProbability : paymentProbability // ignore: cast_nullable_to_non_nullable
as double,expectedPaymentDate: null == expectedPaymentDate ? _self.expectedPaymentDate : expectedPaymentDate // ignore: cast_nullable_to_non_nullable
as String,expectedDaysLate: null == expectedDaysLate ? _self.expectedDaysLate : expectedDaysLate // ignore: cast_nullable_to_non_nullable
as int,latePaymentRisk: null == latePaymentRisk ? _self.latePaymentRisk : latePaymentRisk // ignore: cast_nullable_to_non_nullable
as String,badDebtProbability: null == badDebtProbability ? _self.badDebtProbability : badDebtProbability // ignore: cast_nullable_to_non_nullable
as double,actions: null == actions ? _self.actions : actions // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [PaymentPrediction].
extension PaymentPredictionPatterns on PaymentPrediction {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaymentPrediction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaymentPrediction() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaymentPrediction value)  $default,){
final _that = this;
switch (_that) {
case _PaymentPrediction():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaymentPrediction value)?  $default,){
final _that = this;
switch (_that) {
case _PaymentPrediction() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String invoiceId,  String clientId,  double amount,  String dueDate,  double paymentProbability,  String expectedPaymentDate,  int expectedDaysLate,  String latePaymentRisk,  double badDebtProbability,  List<String> actions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaymentPrediction() when $default != null:
return $default(_that.invoiceId,_that.clientId,_that.amount,_that.dueDate,_that.paymentProbability,_that.expectedPaymentDate,_that.expectedDaysLate,_that.latePaymentRisk,_that.badDebtProbability,_that.actions);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String invoiceId,  String clientId,  double amount,  String dueDate,  double paymentProbability,  String expectedPaymentDate,  int expectedDaysLate,  String latePaymentRisk,  double badDebtProbability,  List<String> actions)  $default,) {final _that = this;
switch (_that) {
case _PaymentPrediction():
return $default(_that.invoiceId,_that.clientId,_that.amount,_that.dueDate,_that.paymentProbability,_that.expectedPaymentDate,_that.expectedDaysLate,_that.latePaymentRisk,_that.badDebtProbability,_that.actions);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String invoiceId,  String clientId,  double amount,  String dueDate,  double paymentProbability,  String expectedPaymentDate,  int expectedDaysLate,  String latePaymentRisk,  double badDebtProbability,  List<String> actions)?  $default,) {final _that = this;
switch (_that) {
case _PaymentPrediction() when $default != null:
return $default(_that.invoiceId,_that.clientId,_that.amount,_that.dueDate,_that.paymentProbability,_that.expectedPaymentDate,_that.expectedDaysLate,_that.latePaymentRisk,_that.badDebtProbability,_that.actions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PaymentPrediction implements PaymentPrediction {
  const _PaymentPrediction({required this.invoiceId, required this.clientId, required this.amount, required this.dueDate, required this.paymentProbability, required this.expectedPaymentDate, required this.expectedDaysLate, required this.latePaymentRisk, required this.badDebtProbability, required final  List<String> actions}): _actions = actions;
  factory _PaymentPrediction.fromJson(Map<String, dynamic> json) => _$PaymentPredictionFromJson(json);

@override final  String invoiceId;
@override final  String clientId;
@override final  double amount;
@override final  String dueDate;
@override final  double paymentProbability;
@override final  String expectedPaymentDate;
@override final  int expectedDaysLate;
@override final  String latePaymentRisk;
@override final  double badDebtProbability;
 final  List<String> _actions;
@override List<String> get actions {
  if (_actions is EqualUnmodifiableListView) return _actions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_actions);
}


/// Create a copy of PaymentPrediction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentPredictionCopyWith<_PaymentPrediction> get copyWith => __$PaymentPredictionCopyWithImpl<_PaymentPrediction>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaymentPredictionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentPrediction&&(identical(other.invoiceId, invoiceId) || other.invoiceId == invoiceId)&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.paymentProbability, paymentProbability) || other.paymentProbability == paymentProbability)&&(identical(other.expectedPaymentDate, expectedPaymentDate) || other.expectedPaymentDate == expectedPaymentDate)&&(identical(other.expectedDaysLate, expectedDaysLate) || other.expectedDaysLate == expectedDaysLate)&&(identical(other.latePaymentRisk, latePaymentRisk) || other.latePaymentRisk == latePaymentRisk)&&(identical(other.badDebtProbability, badDebtProbability) || other.badDebtProbability == badDebtProbability)&&const DeepCollectionEquality().equals(other._actions, _actions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,invoiceId,clientId,amount,dueDate,paymentProbability,expectedPaymentDate,expectedDaysLate,latePaymentRisk,badDebtProbability,const DeepCollectionEquality().hash(_actions));

@override
String toString() {
  return 'PaymentPrediction(invoiceId: $invoiceId, clientId: $clientId, amount: $amount, dueDate: $dueDate, paymentProbability: $paymentProbability, expectedPaymentDate: $expectedPaymentDate, expectedDaysLate: $expectedDaysLate, latePaymentRisk: $latePaymentRisk, badDebtProbability: $badDebtProbability, actions: $actions)';
}


}

/// @nodoc
abstract mixin class _$PaymentPredictionCopyWith<$Res> implements $PaymentPredictionCopyWith<$Res> {
  factory _$PaymentPredictionCopyWith(_PaymentPrediction value, $Res Function(_PaymentPrediction) _then) = __$PaymentPredictionCopyWithImpl;
@override @useResult
$Res call({
 String invoiceId, String clientId, double amount, String dueDate, double paymentProbability, String expectedPaymentDate, int expectedDaysLate, String latePaymentRisk, double badDebtProbability, List<String> actions
});




}
/// @nodoc
class __$PaymentPredictionCopyWithImpl<$Res>
    implements _$PaymentPredictionCopyWith<$Res> {
  __$PaymentPredictionCopyWithImpl(this._self, this._then);

  final _PaymentPrediction _self;
  final $Res Function(_PaymentPrediction) _then;

/// Create a copy of PaymentPrediction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? invoiceId = null,Object? clientId = null,Object? amount = null,Object? dueDate = null,Object? paymentProbability = null,Object? expectedPaymentDate = null,Object? expectedDaysLate = null,Object? latePaymentRisk = null,Object? badDebtProbability = null,Object? actions = null,}) {
  return _then(_PaymentPrediction(
invoiceId: null == invoiceId ? _self.invoiceId : invoiceId // ignore: cast_nullable_to_non_nullable
as String,clientId: null == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,dueDate: null == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as String,paymentProbability: null == paymentProbability ? _self.paymentProbability : paymentProbability // ignore: cast_nullable_to_non_nullable
as double,expectedPaymentDate: null == expectedPaymentDate ? _self.expectedPaymentDate : expectedPaymentDate // ignore: cast_nullable_to_non_nullable
as String,expectedDaysLate: null == expectedDaysLate ? _self.expectedDaysLate : expectedDaysLate // ignore: cast_nullable_to_non_nullable
as int,latePaymentRisk: null == latePaymentRisk ? _self.latePaymentRisk : latePaymentRisk // ignore: cast_nullable_to_non_nullable
as String,badDebtProbability: null == badDebtProbability ? _self.badDebtProbability : badDebtProbability // ignore: cast_nullable_to_non_nullable
as double,actions: null == actions ? _self._actions : actions // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$FinancialDashboard {

 String get organizationId; String get period; String get generatedAt; Map<String, KPI> get kpis; List<RevenueByService> get revenueByService; List<ClientProfitability> get profitabilityByClient; CostAnalysis get costAnalysis; List<TrendData> get trends;
/// Create a copy of FinancialDashboard
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FinancialDashboardCopyWith<FinancialDashboard> get copyWith => _$FinancialDashboardCopyWithImpl<FinancialDashboard>(this as FinancialDashboard, _$identity);

  /// Serializes this FinancialDashboard to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FinancialDashboard&&(identical(other.organizationId, organizationId) || other.organizationId == organizationId)&&(identical(other.period, period) || other.period == period)&&(identical(other.generatedAt, generatedAt) || other.generatedAt == generatedAt)&&const DeepCollectionEquality().equals(other.kpis, kpis)&&const DeepCollectionEquality().equals(other.revenueByService, revenueByService)&&const DeepCollectionEquality().equals(other.profitabilityByClient, profitabilityByClient)&&(identical(other.costAnalysis, costAnalysis) || other.costAnalysis == costAnalysis)&&const DeepCollectionEquality().equals(other.trends, trends));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,organizationId,period,generatedAt,const DeepCollectionEquality().hash(kpis),const DeepCollectionEquality().hash(revenueByService),const DeepCollectionEquality().hash(profitabilityByClient),costAnalysis,const DeepCollectionEquality().hash(trends));

@override
String toString() {
  return 'FinancialDashboard(organizationId: $organizationId, period: $period, generatedAt: $generatedAt, kpis: $kpis, revenueByService: $revenueByService, profitabilityByClient: $profitabilityByClient, costAnalysis: $costAnalysis, trends: $trends)';
}


}

/// @nodoc
abstract mixin class $FinancialDashboardCopyWith<$Res>  {
  factory $FinancialDashboardCopyWith(FinancialDashboard value, $Res Function(FinancialDashboard) _then) = _$FinancialDashboardCopyWithImpl;
@useResult
$Res call({
 String organizationId, String period, String generatedAt, Map<String, KPI> kpis, List<RevenueByService> revenueByService, List<ClientProfitability> profitabilityByClient, CostAnalysis costAnalysis, List<TrendData> trends
});


$CostAnalysisCopyWith<$Res> get costAnalysis;

}
/// @nodoc
class _$FinancialDashboardCopyWithImpl<$Res>
    implements $FinancialDashboardCopyWith<$Res> {
  _$FinancialDashboardCopyWithImpl(this._self, this._then);

  final FinancialDashboard _self;
  final $Res Function(FinancialDashboard) _then;

/// Create a copy of FinancialDashboard
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? organizationId = null,Object? period = null,Object? generatedAt = null,Object? kpis = null,Object? revenueByService = null,Object? profitabilityByClient = null,Object? costAnalysis = null,Object? trends = null,}) {
  return _then(_self.copyWith(
organizationId: null == organizationId ? _self.organizationId : organizationId // ignore: cast_nullable_to_non_nullable
as String,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String,generatedAt: null == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as String,kpis: null == kpis ? _self.kpis : kpis // ignore: cast_nullable_to_non_nullable
as Map<String, KPI>,revenueByService: null == revenueByService ? _self.revenueByService : revenueByService // ignore: cast_nullable_to_non_nullable
as List<RevenueByService>,profitabilityByClient: null == profitabilityByClient ? _self.profitabilityByClient : profitabilityByClient // ignore: cast_nullable_to_non_nullable
as List<ClientProfitability>,costAnalysis: null == costAnalysis ? _self.costAnalysis : costAnalysis // ignore: cast_nullable_to_non_nullable
as CostAnalysis,trends: null == trends ? _self.trends : trends // ignore: cast_nullable_to_non_nullable
as List<TrendData>,
  ));
}
/// Create a copy of FinancialDashboard
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CostAnalysisCopyWith<$Res> get costAnalysis {
  
  return $CostAnalysisCopyWith<$Res>(_self.costAnalysis, (value) {
    return _then(_self.copyWith(costAnalysis: value));
  });
}
}


/// Adds pattern-matching-related methods to [FinancialDashboard].
extension FinancialDashboardPatterns on FinancialDashboard {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FinancialDashboard value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FinancialDashboard() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FinancialDashboard value)  $default,){
final _that = this;
switch (_that) {
case _FinancialDashboard():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FinancialDashboard value)?  $default,){
final _that = this;
switch (_that) {
case _FinancialDashboard() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String organizationId,  String period,  String generatedAt,  Map<String, KPI> kpis,  List<RevenueByService> revenueByService,  List<ClientProfitability> profitabilityByClient,  CostAnalysis costAnalysis,  List<TrendData> trends)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FinancialDashboard() when $default != null:
return $default(_that.organizationId,_that.period,_that.generatedAt,_that.kpis,_that.revenueByService,_that.profitabilityByClient,_that.costAnalysis,_that.trends);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String organizationId,  String period,  String generatedAt,  Map<String, KPI> kpis,  List<RevenueByService> revenueByService,  List<ClientProfitability> profitabilityByClient,  CostAnalysis costAnalysis,  List<TrendData> trends)  $default,) {final _that = this;
switch (_that) {
case _FinancialDashboard():
return $default(_that.organizationId,_that.period,_that.generatedAt,_that.kpis,_that.revenueByService,_that.profitabilityByClient,_that.costAnalysis,_that.trends);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String organizationId,  String period,  String generatedAt,  Map<String, KPI> kpis,  List<RevenueByService> revenueByService,  List<ClientProfitability> profitabilityByClient,  CostAnalysis costAnalysis,  List<TrendData> trends)?  $default,) {final _that = this;
switch (_that) {
case _FinancialDashboard() when $default != null:
return $default(_that.organizationId,_that.period,_that.generatedAt,_that.kpis,_that.revenueByService,_that.profitabilityByClient,_that.costAnalysis,_that.trends);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FinancialDashboard implements FinancialDashboard {
  const _FinancialDashboard({required this.organizationId, required this.period, required this.generatedAt, required final  Map<String, KPI> kpis, required final  List<RevenueByService> revenueByService, required final  List<ClientProfitability> profitabilityByClient, required this.costAnalysis, required final  List<TrendData> trends}): _kpis = kpis,_revenueByService = revenueByService,_profitabilityByClient = profitabilityByClient,_trends = trends;
  factory _FinancialDashboard.fromJson(Map<String, dynamic> json) => _$FinancialDashboardFromJson(json);

@override final  String organizationId;
@override final  String period;
@override final  String generatedAt;
 final  Map<String, KPI> _kpis;
@override Map<String, KPI> get kpis {
  if (_kpis is EqualUnmodifiableMapView) return _kpis;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_kpis);
}

 final  List<RevenueByService> _revenueByService;
@override List<RevenueByService> get revenueByService {
  if (_revenueByService is EqualUnmodifiableListView) return _revenueByService;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_revenueByService);
}

 final  List<ClientProfitability> _profitabilityByClient;
@override List<ClientProfitability> get profitabilityByClient {
  if (_profitabilityByClient is EqualUnmodifiableListView) return _profitabilityByClient;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_profitabilityByClient);
}

@override final  CostAnalysis costAnalysis;
 final  List<TrendData> _trends;
@override List<TrendData> get trends {
  if (_trends is EqualUnmodifiableListView) return _trends;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_trends);
}


/// Create a copy of FinancialDashboard
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FinancialDashboardCopyWith<_FinancialDashboard> get copyWith => __$FinancialDashboardCopyWithImpl<_FinancialDashboard>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FinancialDashboardToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FinancialDashboard&&(identical(other.organizationId, organizationId) || other.organizationId == organizationId)&&(identical(other.period, period) || other.period == period)&&(identical(other.generatedAt, generatedAt) || other.generatedAt == generatedAt)&&const DeepCollectionEquality().equals(other._kpis, _kpis)&&const DeepCollectionEquality().equals(other._revenueByService, _revenueByService)&&const DeepCollectionEquality().equals(other._profitabilityByClient, _profitabilityByClient)&&(identical(other.costAnalysis, costAnalysis) || other.costAnalysis == costAnalysis)&&const DeepCollectionEquality().equals(other._trends, _trends));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,organizationId,period,generatedAt,const DeepCollectionEquality().hash(_kpis),const DeepCollectionEquality().hash(_revenueByService),const DeepCollectionEquality().hash(_profitabilityByClient),costAnalysis,const DeepCollectionEquality().hash(_trends));

@override
String toString() {
  return 'FinancialDashboard(organizationId: $organizationId, period: $period, generatedAt: $generatedAt, kpis: $kpis, revenueByService: $revenueByService, profitabilityByClient: $profitabilityByClient, costAnalysis: $costAnalysis, trends: $trends)';
}


}

/// @nodoc
abstract mixin class _$FinancialDashboardCopyWith<$Res> implements $FinancialDashboardCopyWith<$Res> {
  factory _$FinancialDashboardCopyWith(_FinancialDashboard value, $Res Function(_FinancialDashboard) _then) = __$FinancialDashboardCopyWithImpl;
@override @useResult
$Res call({
 String organizationId, String period, String generatedAt, Map<String, KPI> kpis, List<RevenueByService> revenueByService, List<ClientProfitability> profitabilityByClient, CostAnalysis costAnalysis, List<TrendData> trends
});


@override $CostAnalysisCopyWith<$Res> get costAnalysis;

}
/// @nodoc
class __$FinancialDashboardCopyWithImpl<$Res>
    implements _$FinancialDashboardCopyWith<$Res> {
  __$FinancialDashboardCopyWithImpl(this._self, this._then);

  final _FinancialDashboard _self;
  final $Res Function(_FinancialDashboard) _then;

/// Create a copy of FinancialDashboard
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? organizationId = null,Object? period = null,Object? generatedAt = null,Object? kpis = null,Object? revenueByService = null,Object? profitabilityByClient = null,Object? costAnalysis = null,Object? trends = null,}) {
  return _then(_FinancialDashboard(
organizationId: null == organizationId ? _self.organizationId : organizationId // ignore: cast_nullable_to_non_nullable
as String,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String,generatedAt: null == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as String,kpis: null == kpis ? _self._kpis : kpis // ignore: cast_nullable_to_non_nullable
as Map<String, KPI>,revenueByService: null == revenueByService ? _self._revenueByService : revenueByService // ignore: cast_nullable_to_non_nullable
as List<RevenueByService>,profitabilityByClient: null == profitabilityByClient ? _self._profitabilityByClient : profitabilityByClient // ignore: cast_nullable_to_non_nullable
as List<ClientProfitability>,costAnalysis: null == costAnalysis ? _self.costAnalysis : costAnalysis // ignore: cast_nullable_to_non_nullable
as CostAnalysis,trends: null == trends ? _self._trends : trends // ignore: cast_nullable_to_non_nullable
as List<TrendData>,
  ));
}

/// Create a copy of FinancialDashboard
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CostAnalysisCopyWith<$Res> get costAnalysis {
  
  return $CostAnalysisCopyWith<$Res>(_self.costAnalysis, (value) {
    return _then(_self.copyWith(costAnalysis: value));
  });
}
}


/// @nodoc
mixin _$KPI {

 double get value; double get change; String get trend;
/// Create a copy of KPI
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KPICopyWith<KPI> get copyWith => _$KPICopyWithImpl<KPI>(this as KPI, _$identity);

  /// Serializes this KPI to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KPI&&(identical(other.value, value) || other.value == value)&&(identical(other.change, change) || other.change == change)&&(identical(other.trend, trend) || other.trend == trend));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value,change,trend);

@override
String toString() {
  return 'KPI(value: $value, change: $change, trend: $trend)';
}


}

/// @nodoc
abstract mixin class $KPICopyWith<$Res>  {
  factory $KPICopyWith(KPI value, $Res Function(KPI) _then) = _$KPICopyWithImpl;
@useResult
$Res call({
 double value, double change, String trend
});




}
/// @nodoc
class _$KPICopyWithImpl<$Res>
    implements $KPICopyWith<$Res> {
  _$KPICopyWithImpl(this._self, this._then);

  final KPI _self;
  final $Res Function(KPI) _then;

/// Create a copy of KPI
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? value = null,Object? change = null,Object? trend = null,}) {
  return _then(_self.copyWith(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double,change: null == change ? _self.change : change // ignore: cast_nullable_to_non_nullable
as double,trend: null == trend ? _self.trend : trend // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [KPI].
extension KPIPatterns on KPI {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _KPI value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _KPI() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _KPI value)  $default,){
final _that = this;
switch (_that) {
case _KPI():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _KPI value)?  $default,){
final _that = this;
switch (_that) {
case _KPI() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double value,  double change,  String trend)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _KPI() when $default != null:
return $default(_that.value,_that.change,_that.trend);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double value,  double change,  String trend)  $default,) {final _that = this;
switch (_that) {
case _KPI():
return $default(_that.value,_that.change,_that.trend);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double value,  double change,  String trend)?  $default,) {final _that = this;
switch (_that) {
case _KPI() when $default != null:
return $default(_that.value,_that.change,_that.trend);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _KPI implements KPI {
  const _KPI({required this.value, required this.change, required this.trend});
  factory _KPI.fromJson(Map<String, dynamic> json) => _$KPIFromJson(json);

@override final  double value;
@override final  double change;
@override final  String trend;

/// Create a copy of KPI
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KPICopyWith<_KPI> get copyWith => __$KPICopyWithImpl<_KPI>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$KPIToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _KPI&&(identical(other.value, value) || other.value == value)&&(identical(other.change, change) || other.change == change)&&(identical(other.trend, trend) || other.trend == trend));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value,change,trend);

@override
String toString() {
  return 'KPI(value: $value, change: $change, trend: $trend)';
}


}

/// @nodoc
abstract mixin class _$KPICopyWith<$Res> implements $KPICopyWith<$Res> {
  factory _$KPICopyWith(_KPI value, $Res Function(_KPI) _then) = __$KPICopyWithImpl;
@override @useResult
$Res call({
 double value, double change, String trend
});




}
/// @nodoc
class __$KPICopyWithImpl<$Res>
    implements _$KPICopyWith<$Res> {
  __$KPICopyWithImpl(this._self, this._then);

  final _KPI _self;
  final $Res Function(_KPI) _then;

/// Create a copy of KPI
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = null,Object? change = null,Object? trend = null,}) {
  return _then(_KPI(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double,change: null == change ? _self.change : change // ignore: cast_nullable_to_non_nullable
as double,trend: null == trend ? _self.trend : trend // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$RevenueByService {

 String get service; double get revenue; double get percentage;
/// Create a copy of RevenueByService
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RevenueByServiceCopyWith<RevenueByService> get copyWith => _$RevenueByServiceCopyWithImpl<RevenueByService>(this as RevenueByService, _$identity);

  /// Serializes this RevenueByService to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RevenueByService&&(identical(other.service, service) || other.service == service)&&(identical(other.revenue, revenue) || other.revenue == revenue)&&(identical(other.percentage, percentage) || other.percentage == percentage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,service,revenue,percentage);

@override
String toString() {
  return 'RevenueByService(service: $service, revenue: $revenue, percentage: $percentage)';
}


}

/// @nodoc
abstract mixin class $RevenueByServiceCopyWith<$Res>  {
  factory $RevenueByServiceCopyWith(RevenueByService value, $Res Function(RevenueByService) _then) = _$RevenueByServiceCopyWithImpl;
@useResult
$Res call({
 String service, double revenue, double percentage
});




}
/// @nodoc
class _$RevenueByServiceCopyWithImpl<$Res>
    implements $RevenueByServiceCopyWith<$Res> {
  _$RevenueByServiceCopyWithImpl(this._self, this._then);

  final RevenueByService _self;
  final $Res Function(RevenueByService) _then;

/// Create a copy of RevenueByService
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? service = null,Object? revenue = null,Object? percentage = null,}) {
  return _then(_self.copyWith(
service: null == service ? _self.service : service // ignore: cast_nullable_to_non_nullable
as String,revenue: null == revenue ? _self.revenue : revenue // ignore: cast_nullable_to_non_nullable
as double,percentage: null == percentage ? _self.percentage : percentage // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [RevenueByService].
extension RevenueByServicePatterns on RevenueByService {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RevenueByService value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RevenueByService() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RevenueByService value)  $default,){
final _that = this;
switch (_that) {
case _RevenueByService():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RevenueByService value)?  $default,){
final _that = this;
switch (_that) {
case _RevenueByService() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String service,  double revenue,  double percentage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RevenueByService() when $default != null:
return $default(_that.service,_that.revenue,_that.percentage);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String service,  double revenue,  double percentage)  $default,) {final _that = this;
switch (_that) {
case _RevenueByService():
return $default(_that.service,_that.revenue,_that.percentage);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String service,  double revenue,  double percentage)?  $default,) {final _that = this;
switch (_that) {
case _RevenueByService() when $default != null:
return $default(_that.service,_that.revenue,_that.percentage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RevenueByService implements RevenueByService {
  const _RevenueByService({required this.service, required this.revenue, required this.percentage});
  factory _RevenueByService.fromJson(Map<String, dynamic> json) => _$RevenueByServiceFromJson(json);

@override final  String service;
@override final  double revenue;
@override final  double percentage;

/// Create a copy of RevenueByService
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RevenueByServiceCopyWith<_RevenueByService> get copyWith => __$RevenueByServiceCopyWithImpl<_RevenueByService>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RevenueByServiceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RevenueByService&&(identical(other.service, service) || other.service == service)&&(identical(other.revenue, revenue) || other.revenue == revenue)&&(identical(other.percentage, percentage) || other.percentage == percentage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,service,revenue,percentage);

@override
String toString() {
  return 'RevenueByService(service: $service, revenue: $revenue, percentage: $percentage)';
}


}

/// @nodoc
abstract mixin class _$RevenueByServiceCopyWith<$Res> implements $RevenueByServiceCopyWith<$Res> {
  factory _$RevenueByServiceCopyWith(_RevenueByService value, $Res Function(_RevenueByService) _then) = __$RevenueByServiceCopyWithImpl;
@override @useResult
$Res call({
 String service, double revenue, double percentage
});




}
/// @nodoc
class __$RevenueByServiceCopyWithImpl<$Res>
    implements _$RevenueByServiceCopyWith<$Res> {
  __$RevenueByServiceCopyWithImpl(this._self, this._then);

  final _RevenueByService _self;
  final $Res Function(_RevenueByService) _then;

/// Create a copy of RevenueByService
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? service = null,Object? revenue = null,Object? percentage = null,}) {
  return _then(_RevenueByService(
service: null == service ? _self.service : service // ignore: cast_nullable_to_non_nullable
as String,revenue: null == revenue ? _self.revenue : revenue // ignore: cast_nullable_to_non_nullable
as double,percentage: null == percentage ? _self.percentage : percentage // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$ClientProfitability {

 String get clientId; double get revenue; double get cost; double get profit; double get margin;
/// Create a copy of ClientProfitability
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClientProfitabilityCopyWith<ClientProfitability> get copyWith => _$ClientProfitabilityCopyWithImpl<ClientProfitability>(this as ClientProfitability, _$identity);

  /// Serializes this ClientProfitability to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClientProfitability&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.revenue, revenue) || other.revenue == revenue)&&(identical(other.cost, cost) || other.cost == cost)&&(identical(other.profit, profit) || other.profit == profit)&&(identical(other.margin, margin) || other.margin == margin));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,clientId,revenue,cost,profit,margin);

@override
String toString() {
  return 'ClientProfitability(clientId: $clientId, revenue: $revenue, cost: $cost, profit: $profit, margin: $margin)';
}


}

/// @nodoc
abstract mixin class $ClientProfitabilityCopyWith<$Res>  {
  factory $ClientProfitabilityCopyWith(ClientProfitability value, $Res Function(ClientProfitability) _then) = _$ClientProfitabilityCopyWithImpl;
@useResult
$Res call({
 String clientId, double revenue, double cost, double profit, double margin
});




}
/// @nodoc
class _$ClientProfitabilityCopyWithImpl<$Res>
    implements $ClientProfitabilityCopyWith<$Res> {
  _$ClientProfitabilityCopyWithImpl(this._self, this._then);

  final ClientProfitability _self;
  final $Res Function(ClientProfitability) _then;

/// Create a copy of ClientProfitability
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? clientId = null,Object? revenue = null,Object? cost = null,Object? profit = null,Object? margin = null,}) {
  return _then(_self.copyWith(
clientId: null == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String,revenue: null == revenue ? _self.revenue : revenue // ignore: cast_nullable_to_non_nullable
as double,cost: null == cost ? _self.cost : cost // ignore: cast_nullable_to_non_nullable
as double,profit: null == profit ? _self.profit : profit // ignore: cast_nullable_to_non_nullable
as double,margin: null == margin ? _self.margin : margin // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [ClientProfitability].
extension ClientProfitabilityPatterns on ClientProfitability {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClientProfitability value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClientProfitability() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClientProfitability value)  $default,){
final _that = this;
switch (_that) {
case _ClientProfitability():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClientProfitability value)?  $default,){
final _that = this;
switch (_that) {
case _ClientProfitability() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String clientId,  double revenue,  double cost,  double profit,  double margin)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClientProfitability() when $default != null:
return $default(_that.clientId,_that.revenue,_that.cost,_that.profit,_that.margin);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String clientId,  double revenue,  double cost,  double profit,  double margin)  $default,) {final _that = this;
switch (_that) {
case _ClientProfitability():
return $default(_that.clientId,_that.revenue,_that.cost,_that.profit,_that.margin);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String clientId,  double revenue,  double cost,  double profit,  double margin)?  $default,) {final _that = this;
switch (_that) {
case _ClientProfitability() when $default != null:
return $default(_that.clientId,_that.revenue,_that.cost,_that.profit,_that.margin);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ClientProfitability implements ClientProfitability {
  const _ClientProfitability({required this.clientId, required this.revenue, required this.cost, required this.profit, required this.margin});
  factory _ClientProfitability.fromJson(Map<String, dynamic> json) => _$ClientProfitabilityFromJson(json);

@override final  String clientId;
@override final  double revenue;
@override final  double cost;
@override final  double profit;
@override final  double margin;

/// Create a copy of ClientProfitability
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClientProfitabilityCopyWith<_ClientProfitability> get copyWith => __$ClientProfitabilityCopyWithImpl<_ClientProfitability>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClientProfitabilityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClientProfitability&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.revenue, revenue) || other.revenue == revenue)&&(identical(other.cost, cost) || other.cost == cost)&&(identical(other.profit, profit) || other.profit == profit)&&(identical(other.margin, margin) || other.margin == margin));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,clientId,revenue,cost,profit,margin);

@override
String toString() {
  return 'ClientProfitability(clientId: $clientId, revenue: $revenue, cost: $cost, profit: $profit, margin: $margin)';
}


}

/// @nodoc
abstract mixin class _$ClientProfitabilityCopyWith<$Res> implements $ClientProfitabilityCopyWith<$Res> {
  factory _$ClientProfitabilityCopyWith(_ClientProfitability value, $Res Function(_ClientProfitability) _then) = __$ClientProfitabilityCopyWithImpl;
@override @useResult
$Res call({
 String clientId, double revenue, double cost, double profit, double margin
});




}
/// @nodoc
class __$ClientProfitabilityCopyWithImpl<$Res>
    implements _$ClientProfitabilityCopyWith<$Res> {
  __$ClientProfitabilityCopyWithImpl(this._self, this._then);

  final _ClientProfitability _self;
  final $Res Function(_ClientProfitability) _then;

/// Create a copy of ClientProfitability
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? clientId = null,Object? revenue = null,Object? cost = null,Object? profit = null,Object? margin = null,}) {
  return _then(_ClientProfitability(
clientId: null == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String,revenue: null == revenue ? _self.revenue : revenue // ignore: cast_nullable_to_non_nullable
as double,cost: null == cost ? _self.cost : cost // ignore: cast_nullable_to_non_nullable
as double,profit: null == profit ? _self.profit : profit // ignore: cast_nullable_to_non_nullable
as double,margin: null == margin ? _self.margin : margin // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$CostAnalysis {

 CostCategory get labor; CostCategory get overhead; CostCategory get materials; CostCategory get other;
/// Create a copy of CostAnalysis
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CostAnalysisCopyWith<CostAnalysis> get copyWith => _$CostAnalysisCopyWithImpl<CostAnalysis>(this as CostAnalysis, _$identity);

  /// Serializes this CostAnalysis to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CostAnalysis&&(identical(other.labor, labor) || other.labor == labor)&&(identical(other.overhead, overhead) || other.overhead == overhead)&&(identical(other.materials, materials) || other.materials == materials)&&(identical(other.other, this.other) || other.other == this.other));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,labor,overhead,materials,other);

@override
String toString() {
  return 'CostAnalysis(labor: $labor, overhead: $overhead, materials: $materials, other: $other)';
}


}

/// @nodoc
abstract mixin class $CostAnalysisCopyWith<$Res>  {
  factory $CostAnalysisCopyWith(CostAnalysis value, $Res Function(CostAnalysis) _then) = _$CostAnalysisCopyWithImpl;
@useResult
$Res call({
 CostCategory labor, CostCategory overhead, CostCategory materials, CostCategory other
});


$CostCategoryCopyWith<$Res> get labor;$CostCategoryCopyWith<$Res> get overhead;$CostCategoryCopyWith<$Res> get materials;$CostCategoryCopyWith<$Res> get other;

}
/// @nodoc
class _$CostAnalysisCopyWithImpl<$Res>
    implements $CostAnalysisCopyWith<$Res> {
  _$CostAnalysisCopyWithImpl(this._self, this._then);

  final CostAnalysis _self;
  final $Res Function(CostAnalysis) _then;

/// Create a copy of CostAnalysis
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? labor = null,Object? overhead = null,Object? materials = null,Object? other = null,}) {
  return _then(_self.copyWith(
labor: null == labor ? _self.labor : labor // ignore: cast_nullable_to_non_nullable
as CostCategory,overhead: null == overhead ? _self.overhead : overhead // ignore: cast_nullable_to_non_nullable
as CostCategory,materials: null == materials ? _self.materials : materials // ignore: cast_nullable_to_non_nullable
as CostCategory,other: null == other ? _self.other : other // ignore: cast_nullable_to_non_nullable
as CostCategory,
  ));
}
/// Create a copy of CostAnalysis
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CostCategoryCopyWith<$Res> get labor {
  
  return $CostCategoryCopyWith<$Res>(_self.labor, (value) {
    return _then(_self.copyWith(labor: value));
  });
}/// Create a copy of CostAnalysis
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CostCategoryCopyWith<$Res> get overhead {
  
  return $CostCategoryCopyWith<$Res>(_self.overhead, (value) {
    return _then(_self.copyWith(overhead: value));
  });
}/// Create a copy of CostAnalysis
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CostCategoryCopyWith<$Res> get materials {
  
  return $CostCategoryCopyWith<$Res>(_self.materials, (value) {
    return _then(_self.copyWith(materials: value));
  });
}/// Create a copy of CostAnalysis
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CostCategoryCopyWith<$Res> get other {
  
  return $CostCategoryCopyWith<$Res>(_self.other, (value) {
    return _then(_self.copyWith(other: value));
  });
}
}


/// Adds pattern-matching-related methods to [CostAnalysis].
extension CostAnalysisPatterns on CostAnalysis {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CostAnalysis value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CostAnalysis() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CostAnalysis value)  $default,){
final _that = this;
switch (_that) {
case _CostAnalysis():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CostAnalysis value)?  $default,){
final _that = this;
switch (_that) {
case _CostAnalysis() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CostCategory labor,  CostCategory overhead,  CostCategory materials,  CostCategory other)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CostAnalysis() when $default != null:
return $default(_that.labor,_that.overhead,_that.materials,_that.other);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CostCategory labor,  CostCategory overhead,  CostCategory materials,  CostCategory other)  $default,) {final _that = this;
switch (_that) {
case _CostAnalysis():
return $default(_that.labor,_that.overhead,_that.materials,_that.other);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CostCategory labor,  CostCategory overhead,  CostCategory materials,  CostCategory other)?  $default,) {final _that = this;
switch (_that) {
case _CostAnalysis() when $default != null:
return $default(_that.labor,_that.overhead,_that.materials,_that.other);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CostAnalysis implements CostAnalysis {
  const _CostAnalysis({required this.labor, required this.overhead, required this.materials, required this.other});
  factory _CostAnalysis.fromJson(Map<String, dynamic> json) => _$CostAnalysisFromJson(json);

@override final  CostCategory labor;
@override final  CostCategory overhead;
@override final  CostCategory materials;
@override final  CostCategory other;

/// Create a copy of CostAnalysis
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CostAnalysisCopyWith<_CostAnalysis> get copyWith => __$CostAnalysisCopyWithImpl<_CostAnalysis>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CostAnalysisToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CostAnalysis&&(identical(other.labor, labor) || other.labor == labor)&&(identical(other.overhead, overhead) || other.overhead == overhead)&&(identical(other.materials, materials) || other.materials == materials)&&(identical(other.other, this.other) || other.other == this.other));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,labor,overhead,materials,other);

@override
String toString() {
  return 'CostAnalysis(labor: $labor, overhead: $overhead, materials: $materials, other: $other)';
}


}

/// @nodoc
abstract mixin class _$CostAnalysisCopyWith<$Res> implements $CostAnalysisCopyWith<$Res> {
  factory _$CostAnalysisCopyWith(_CostAnalysis value, $Res Function(_CostAnalysis) _then) = __$CostAnalysisCopyWithImpl;
@override @useResult
$Res call({
 CostCategory labor, CostCategory overhead, CostCategory materials, CostCategory other
});


@override $CostCategoryCopyWith<$Res> get labor;@override $CostCategoryCopyWith<$Res> get overhead;@override $CostCategoryCopyWith<$Res> get materials;@override $CostCategoryCopyWith<$Res> get other;

}
/// @nodoc
class __$CostAnalysisCopyWithImpl<$Res>
    implements _$CostAnalysisCopyWith<$Res> {
  __$CostAnalysisCopyWithImpl(this._self, this._then);

  final _CostAnalysis _self;
  final $Res Function(_CostAnalysis) _then;

/// Create a copy of CostAnalysis
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? labor = null,Object? overhead = null,Object? materials = null,Object? other = null,}) {
  return _then(_CostAnalysis(
labor: null == labor ? _self.labor : labor // ignore: cast_nullable_to_non_nullable
as CostCategory,overhead: null == overhead ? _self.overhead : overhead // ignore: cast_nullable_to_non_nullable
as CostCategory,materials: null == materials ? _self.materials : materials // ignore: cast_nullable_to_non_nullable
as CostCategory,other: null == other ? _self.other : other // ignore: cast_nullable_to_non_nullable
as CostCategory,
  ));
}

/// Create a copy of CostAnalysis
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CostCategoryCopyWith<$Res> get labor {
  
  return $CostCategoryCopyWith<$Res>(_self.labor, (value) {
    return _then(_self.copyWith(labor: value));
  });
}/// Create a copy of CostAnalysis
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CostCategoryCopyWith<$Res> get overhead {
  
  return $CostCategoryCopyWith<$Res>(_self.overhead, (value) {
    return _then(_self.copyWith(overhead: value));
  });
}/// Create a copy of CostAnalysis
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CostCategoryCopyWith<$Res> get materials {
  
  return $CostCategoryCopyWith<$Res>(_self.materials, (value) {
    return _then(_self.copyWith(materials: value));
  });
}/// Create a copy of CostAnalysis
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CostCategoryCopyWith<$Res> get other {
  
  return $CostCategoryCopyWith<$Res>(_self.other, (value) {
    return _then(_self.copyWith(other: value));
  });
}
}


/// @nodoc
mixin _$CostCategory {

 double get amount; double get percentage;
/// Create a copy of CostCategory
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CostCategoryCopyWith<CostCategory> get copyWith => _$CostCategoryCopyWithImpl<CostCategory>(this as CostCategory, _$identity);

  /// Serializes this CostCategory to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CostCategory&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.percentage, percentage) || other.percentage == percentage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,amount,percentage);

@override
String toString() {
  return 'CostCategory(amount: $amount, percentage: $percentage)';
}


}

/// @nodoc
abstract mixin class $CostCategoryCopyWith<$Res>  {
  factory $CostCategoryCopyWith(CostCategory value, $Res Function(CostCategory) _then) = _$CostCategoryCopyWithImpl;
@useResult
$Res call({
 double amount, double percentage
});




}
/// @nodoc
class _$CostCategoryCopyWithImpl<$Res>
    implements $CostCategoryCopyWith<$Res> {
  _$CostCategoryCopyWithImpl(this._self, this._then);

  final CostCategory _self;
  final $Res Function(CostCategory) _then;

/// Create a copy of CostCategory
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? amount = null,Object? percentage = null,}) {
  return _then(_self.copyWith(
amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,percentage: null == percentage ? _self.percentage : percentage // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [CostCategory].
extension CostCategoryPatterns on CostCategory {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CostCategory value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CostCategory() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CostCategory value)  $default,){
final _that = this;
switch (_that) {
case _CostCategory():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CostCategory value)?  $default,){
final _that = this;
switch (_that) {
case _CostCategory() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double amount,  double percentage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CostCategory() when $default != null:
return $default(_that.amount,_that.percentage);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double amount,  double percentage)  $default,) {final _that = this;
switch (_that) {
case _CostCategory():
return $default(_that.amount,_that.percentage);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double amount,  double percentage)?  $default,) {final _that = this;
switch (_that) {
case _CostCategory() when $default != null:
return $default(_that.amount,_that.percentage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CostCategory implements CostCategory {
  const _CostCategory({required this.amount, required this.percentage});
  factory _CostCategory.fromJson(Map<String, dynamic> json) => _$CostCategoryFromJson(json);

@override final  double amount;
@override final  double percentage;

/// Create a copy of CostCategory
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CostCategoryCopyWith<_CostCategory> get copyWith => __$CostCategoryCopyWithImpl<_CostCategory>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CostCategoryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CostCategory&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.percentage, percentage) || other.percentage == percentage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,amount,percentage);

@override
String toString() {
  return 'CostCategory(amount: $amount, percentage: $percentage)';
}


}

/// @nodoc
abstract mixin class _$CostCategoryCopyWith<$Res> implements $CostCategoryCopyWith<$Res> {
  factory _$CostCategoryCopyWith(_CostCategory value, $Res Function(_CostCategory) _then) = __$CostCategoryCopyWithImpl;
@override @useResult
$Res call({
 double amount, double percentage
});




}
/// @nodoc
class __$CostCategoryCopyWithImpl<$Res>
    implements _$CostCategoryCopyWith<$Res> {
  __$CostCategoryCopyWithImpl(this._self, this._then);

  final _CostCategory _self;
  final $Res Function(_CostCategory) _then;

/// Create a copy of CostCategory
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? amount = null,Object? percentage = null,}) {
  return _then(_CostCategory(
amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,percentage: null == percentage ? _self.percentage : percentage // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$TrendData {

 String get month; double get revenue; double get profit;
/// Create a copy of TrendData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrendDataCopyWith<TrendData> get copyWith => _$TrendDataCopyWithImpl<TrendData>(this as TrendData, _$identity);

  /// Serializes this TrendData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TrendData&&(identical(other.month, month) || other.month == month)&&(identical(other.revenue, revenue) || other.revenue == revenue)&&(identical(other.profit, profit) || other.profit == profit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,month,revenue,profit);

@override
String toString() {
  return 'TrendData(month: $month, revenue: $revenue, profit: $profit)';
}


}

/// @nodoc
abstract mixin class $TrendDataCopyWith<$Res>  {
  factory $TrendDataCopyWith(TrendData value, $Res Function(TrendData) _then) = _$TrendDataCopyWithImpl;
@useResult
$Res call({
 String month, double revenue, double profit
});




}
/// @nodoc
class _$TrendDataCopyWithImpl<$Res>
    implements $TrendDataCopyWith<$Res> {
  _$TrendDataCopyWithImpl(this._self, this._then);

  final TrendData _self;
  final $Res Function(TrendData) _then;

/// Create a copy of TrendData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? month = null,Object? revenue = null,Object? profit = null,}) {
  return _then(_self.copyWith(
month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as String,revenue: null == revenue ? _self.revenue : revenue // ignore: cast_nullable_to_non_nullable
as double,profit: null == profit ? _self.profit : profit // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [TrendData].
extension TrendDataPatterns on TrendData {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TrendData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TrendData() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TrendData value)  $default,){
final _that = this;
switch (_that) {
case _TrendData():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TrendData value)?  $default,){
final _that = this;
switch (_that) {
case _TrendData() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String month,  double revenue,  double profit)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TrendData() when $default != null:
return $default(_that.month,_that.revenue,_that.profit);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String month,  double revenue,  double profit)  $default,) {final _that = this;
switch (_that) {
case _TrendData():
return $default(_that.month,_that.revenue,_that.profit);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String month,  double revenue,  double profit)?  $default,) {final _that = this;
switch (_that) {
case _TrendData() when $default != null:
return $default(_that.month,_that.revenue,_that.profit);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TrendData implements TrendData {
  const _TrendData({required this.month, required this.revenue, required this.profit});
  factory _TrendData.fromJson(Map<String, dynamic> json) => _$TrendDataFromJson(json);

@override final  String month;
@override final  double revenue;
@override final  double profit;

/// Create a copy of TrendData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TrendDataCopyWith<_TrendData> get copyWith => __$TrendDataCopyWithImpl<_TrendData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TrendDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TrendData&&(identical(other.month, month) || other.month == month)&&(identical(other.revenue, revenue) || other.revenue == revenue)&&(identical(other.profit, profit) || other.profit == profit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,month,revenue,profit);

@override
String toString() {
  return 'TrendData(month: $month, revenue: $revenue, profit: $profit)';
}


}

/// @nodoc
abstract mixin class _$TrendDataCopyWith<$Res> implements $TrendDataCopyWith<$Res> {
  factory _$TrendDataCopyWith(_TrendData value, $Res Function(_TrendData) _then) = __$TrendDataCopyWithImpl;
@override @useResult
$Res call({
 String month, double revenue, double profit
});




}
/// @nodoc
class __$TrendDataCopyWithImpl<$Res>
    implements _$TrendDataCopyWith<$Res> {
  __$TrendDataCopyWithImpl(this._self, this._then);

  final _TrendData _self;
  final $Res Function(_TrendData) _then;

/// Create a copy of TrendData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? month = null,Object? revenue = null,Object? profit = null,}) {
  return _then(_TrendData(
month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as String,revenue: null == revenue ? _self.revenue : revenue // ignore: cast_nullable_to_non_nullable
as double,profit: null == profit ? _self.profit : profit // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$Budget {

 String get budgetId; String get organizationId; String get period; String get createdAt; BudgetCategory get revenue; BudgetCategory get expenses; BudgetCategory get profit; List<String> get assumptions; BudgetScenarios get scenarios;
/// Create a copy of Budget
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BudgetCopyWith<Budget> get copyWith => _$BudgetCopyWithImpl<Budget>(this as Budget, _$identity);

  /// Serializes this Budget to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Budget&&(identical(other.budgetId, budgetId) || other.budgetId == budgetId)&&(identical(other.organizationId, organizationId) || other.organizationId == organizationId)&&(identical(other.period, period) || other.period == period)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.revenue, revenue) || other.revenue == revenue)&&(identical(other.expenses, expenses) || other.expenses == expenses)&&(identical(other.profit, profit) || other.profit == profit)&&const DeepCollectionEquality().equals(other.assumptions, assumptions)&&(identical(other.scenarios, scenarios) || other.scenarios == scenarios));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,budgetId,organizationId,period,createdAt,revenue,expenses,profit,const DeepCollectionEquality().hash(assumptions),scenarios);

@override
String toString() {
  return 'Budget(budgetId: $budgetId, organizationId: $organizationId, period: $period, createdAt: $createdAt, revenue: $revenue, expenses: $expenses, profit: $profit, assumptions: $assumptions, scenarios: $scenarios)';
}


}

/// @nodoc
abstract mixin class $BudgetCopyWith<$Res>  {
  factory $BudgetCopyWith(Budget value, $Res Function(Budget) _then) = _$BudgetCopyWithImpl;
@useResult
$Res call({
 String budgetId, String organizationId, String period, String createdAt, BudgetCategory revenue, BudgetCategory expenses, BudgetCategory profit, List<String> assumptions, BudgetScenarios scenarios
});


$BudgetCategoryCopyWith<$Res> get revenue;$BudgetCategoryCopyWith<$Res> get expenses;$BudgetCategoryCopyWith<$Res> get profit;$BudgetScenariosCopyWith<$Res> get scenarios;

}
/// @nodoc
class _$BudgetCopyWithImpl<$Res>
    implements $BudgetCopyWith<$Res> {
  _$BudgetCopyWithImpl(this._self, this._then);

  final Budget _self;
  final $Res Function(Budget) _then;

/// Create a copy of Budget
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? budgetId = null,Object? organizationId = null,Object? period = null,Object? createdAt = null,Object? revenue = null,Object? expenses = null,Object? profit = null,Object? assumptions = null,Object? scenarios = null,}) {
  return _then(_self.copyWith(
budgetId: null == budgetId ? _self.budgetId : budgetId // ignore: cast_nullable_to_non_nullable
as String,organizationId: null == organizationId ? _self.organizationId : organizationId // ignore: cast_nullable_to_non_nullable
as String,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,revenue: null == revenue ? _self.revenue : revenue // ignore: cast_nullable_to_non_nullable
as BudgetCategory,expenses: null == expenses ? _self.expenses : expenses // ignore: cast_nullable_to_non_nullable
as BudgetCategory,profit: null == profit ? _self.profit : profit // ignore: cast_nullable_to_non_nullable
as BudgetCategory,assumptions: null == assumptions ? _self.assumptions : assumptions // ignore: cast_nullable_to_non_nullable
as List<String>,scenarios: null == scenarios ? _self.scenarios : scenarios // ignore: cast_nullable_to_non_nullable
as BudgetScenarios,
  ));
}
/// Create a copy of Budget
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BudgetCategoryCopyWith<$Res> get revenue {
  
  return $BudgetCategoryCopyWith<$Res>(_self.revenue, (value) {
    return _then(_self.copyWith(revenue: value));
  });
}/// Create a copy of Budget
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BudgetCategoryCopyWith<$Res> get expenses {
  
  return $BudgetCategoryCopyWith<$Res>(_self.expenses, (value) {
    return _then(_self.copyWith(expenses: value));
  });
}/// Create a copy of Budget
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BudgetCategoryCopyWith<$Res> get profit {
  
  return $BudgetCategoryCopyWith<$Res>(_self.profit, (value) {
    return _then(_self.copyWith(profit: value));
  });
}/// Create a copy of Budget
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BudgetScenariosCopyWith<$Res> get scenarios {
  
  return $BudgetScenariosCopyWith<$Res>(_self.scenarios, (value) {
    return _then(_self.copyWith(scenarios: value));
  });
}
}


/// Adds pattern-matching-related methods to [Budget].
extension BudgetPatterns on Budget {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Budget value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Budget() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Budget value)  $default,){
final _that = this;
switch (_that) {
case _Budget():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Budget value)?  $default,){
final _that = this;
switch (_that) {
case _Budget() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String budgetId,  String organizationId,  String period,  String createdAt,  BudgetCategory revenue,  BudgetCategory expenses,  BudgetCategory profit,  List<String> assumptions,  BudgetScenarios scenarios)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Budget() when $default != null:
return $default(_that.budgetId,_that.organizationId,_that.period,_that.createdAt,_that.revenue,_that.expenses,_that.profit,_that.assumptions,_that.scenarios);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String budgetId,  String organizationId,  String period,  String createdAt,  BudgetCategory revenue,  BudgetCategory expenses,  BudgetCategory profit,  List<String> assumptions,  BudgetScenarios scenarios)  $default,) {final _that = this;
switch (_that) {
case _Budget():
return $default(_that.budgetId,_that.organizationId,_that.period,_that.createdAt,_that.revenue,_that.expenses,_that.profit,_that.assumptions,_that.scenarios);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String budgetId,  String organizationId,  String period,  String createdAt,  BudgetCategory revenue,  BudgetCategory expenses,  BudgetCategory profit,  List<String> assumptions,  BudgetScenarios scenarios)?  $default,) {final _that = this;
switch (_that) {
case _Budget() when $default != null:
return $default(_that.budgetId,_that.organizationId,_that.period,_that.createdAt,_that.revenue,_that.expenses,_that.profit,_that.assumptions,_that.scenarios);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Budget implements Budget {
  const _Budget({required this.budgetId, required this.organizationId, required this.period, required this.createdAt, required this.revenue, required this.expenses, required this.profit, required final  List<String> assumptions, required this.scenarios}): _assumptions = assumptions;
  factory _Budget.fromJson(Map<String, dynamic> json) => _$BudgetFromJson(json);

@override final  String budgetId;
@override final  String organizationId;
@override final  String period;
@override final  String createdAt;
@override final  BudgetCategory revenue;
@override final  BudgetCategory expenses;
@override final  BudgetCategory profit;
 final  List<String> _assumptions;
@override List<String> get assumptions {
  if (_assumptions is EqualUnmodifiableListView) return _assumptions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_assumptions);
}

@override final  BudgetScenarios scenarios;

/// Create a copy of Budget
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BudgetCopyWith<_Budget> get copyWith => __$BudgetCopyWithImpl<_Budget>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BudgetToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Budget&&(identical(other.budgetId, budgetId) || other.budgetId == budgetId)&&(identical(other.organizationId, organizationId) || other.organizationId == organizationId)&&(identical(other.period, period) || other.period == period)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.revenue, revenue) || other.revenue == revenue)&&(identical(other.expenses, expenses) || other.expenses == expenses)&&(identical(other.profit, profit) || other.profit == profit)&&const DeepCollectionEquality().equals(other._assumptions, _assumptions)&&(identical(other.scenarios, scenarios) || other.scenarios == scenarios));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,budgetId,organizationId,period,createdAt,revenue,expenses,profit,const DeepCollectionEquality().hash(_assumptions),scenarios);

@override
String toString() {
  return 'Budget(budgetId: $budgetId, organizationId: $organizationId, period: $period, createdAt: $createdAt, revenue: $revenue, expenses: $expenses, profit: $profit, assumptions: $assumptions, scenarios: $scenarios)';
}


}

/// @nodoc
abstract mixin class _$BudgetCopyWith<$Res> implements $BudgetCopyWith<$Res> {
  factory _$BudgetCopyWith(_Budget value, $Res Function(_Budget) _then) = __$BudgetCopyWithImpl;
@override @useResult
$Res call({
 String budgetId, String organizationId, String period, String createdAt, BudgetCategory revenue, BudgetCategory expenses, BudgetCategory profit, List<String> assumptions, BudgetScenarios scenarios
});


@override $BudgetCategoryCopyWith<$Res> get revenue;@override $BudgetCategoryCopyWith<$Res> get expenses;@override $BudgetCategoryCopyWith<$Res> get profit;@override $BudgetScenariosCopyWith<$Res> get scenarios;

}
/// @nodoc
class __$BudgetCopyWithImpl<$Res>
    implements _$BudgetCopyWith<$Res> {
  __$BudgetCopyWithImpl(this._self, this._then);

  final _Budget _self;
  final $Res Function(_Budget) _then;

/// Create a copy of Budget
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? budgetId = null,Object? organizationId = null,Object? period = null,Object? createdAt = null,Object? revenue = null,Object? expenses = null,Object? profit = null,Object? assumptions = null,Object? scenarios = null,}) {
  return _then(_Budget(
budgetId: null == budgetId ? _self.budgetId : budgetId // ignore: cast_nullable_to_non_nullable
as String,organizationId: null == organizationId ? _self.organizationId : organizationId // ignore: cast_nullable_to_non_nullable
as String,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,revenue: null == revenue ? _self.revenue : revenue // ignore: cast_nullable_to_non_nullable
as BudgetCategory,expenses: null == expenses ? _self.expenses : expenses // ignore: cast_nullable_to_non_nullable
as BudgetCategory,profit: null == profit ? _self.profit : profit // ignore: cast_nullable_to_non_nullable
as BudgetCategory,assumptions: null == assumptions ? _self._assumptions : assumptions // ignore: cast_nullable_to_non_nullable
as List<String>,scenarios: null == scenarios ? _self.scenarios : scenarios // ignore: cast_nullable_to_non_nullable
as BudgetScenarios,
  ));
}

/// Create a copy of Budget
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BudgetCategoryCopyWith<$Res> get revenue {
  
  return $BudgetCategoryCopyWith<$Res>(_self.revenue, (value) {
    return _then(_self.copyWith(revenue: value));
  });
}/// Create a copy of Budget
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BudgetCategoryCopyWith<$Res> get expenses {
  
  return $BudgetCategoryCopyWith<$Res>(_self.expenses, (value) {
    return _then(_self.copyWith(expenses: value));
  });
}/// Create a copy of Budget
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BudgetCategoryCopyWith<$Res> get profit {
  
  return $BudgetCategoryCopyWith<$Res>(_self.profit, (value) {
    return _then(_self.copyWith(profit: value));
  });
}/// Create a copy of Budget
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BudgetScenariosCopyWith<$Res> get scenarios {
  
  return $BudgetScenariosCopyWith<$Res>(_self.scenarios, (value) {
    return _then(_self.copyWith(scenarios: value));
  });
}
}


/// @nodoc
mixin _$BudgetCategory {

 double get total; Map<String, dynamic>? get breakdown;
/// Create a copy of BudgetCategory
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BudgetCategoryCopyWith<BudgetCategory> get copyWith => _$BudgetCategoryCopyWithImpl<BudgetCategory>(this as BudgetCategory, _$identity);

  /// Serializes this BudgetCategory to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BudgetCategory&&(identical(other.total, total) || other.total == total)&&const DeepCollectionEquality().equals(other.breakdown, breakdown));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,total,const DeepCollectionEquality().hash(breakdown));

@override
String toString() {
  return 'BudgetCategory(total: $total, breakdown: $breakdown)';
}


}

/// @nodoc
abstract mixin class $BudgetCategoryCopyWith<$Res>  {
  factory $BudgetCategoryCopyWith(BudgetCategory value, $Res Function(BudgetCategory) _then) = _$BudgetCategoryCopyWithImpl;
@useResult
$Res call({
 double total, Map<String, dynamic>? breakdown
});




}
/// @nodoc
class _$BudgetCategoryCopyWithImpl<$Res>
    implements $BudgetCategoryCopyWith<$Res> {
  _$BudgetCategoryCopyWithImpl(this._self, this._then);

  final BudgetCategory _self;
  final $Res Function(BudgetCategory) _then;

/// Create a copy of BudgetCategory
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? total = null,Object? breakdown = freezed,}) {
  return _then(_self.copyWith(
total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,breakdown: freezed == breakdown ? _self.breakdown : breakdown // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [BudgetCategory].
extension BudgetCategoryPatterns on BudgetCategory {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BudgetCategory value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BudgetCategory() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BudgetCategory value)  $default,){
final _that = this;
switch (_that) {
case _BudgetCategory():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BudgetCategory value)?  $default,){
final _that = this;
switch (_that) {
case _BudgetCategory() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double total,  Map<String, dynamic>? breakdown)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BudgetCategory() when $default != null:
return $default(_that.total,_that.breakdown);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double total,  Map<String, dynamic>? breakdown)  $default,) {final _that = this;
switch (_that) {
case _BudgetCategory():
return $default(_that.total,_that.breakdown);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double total,  Map<String, dynamic>? breakdown)?  $default,) {final _that = this;
switch (_that) {
case _BudgetCategory() when $default != null:
return $default(_that.total,_that.breakdown);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BudgetCategory implements BudgetCategory {
  const _BudgetCategory({required this.total, final  Map<String, dynamic>? breakdown}): _breakdown = breakdown;
  factory _BudgetCategory.fromJson(Map<String, dynamic> json) => _$BudgetCategoryFromJson(json);

@override final  double total;
 final  Map<String, dynamic>? _breakdown;
@override Map<String, dynamic>? get breakdown {
  final value = _breakdown;
  if (value == null) return null;
  if (_breakdown is EqualUnmodifiableMapView) return _breakdown;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of BudgetCategory
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BudgetCategoryCopyWith<_BudgetCategory> get copyWith => __$BudgetCategoryCopyWithImpl<_BudgetCategory>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BudgetCategoryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BudgetCategory&&(identical(other.total, total) || other.total == total)&&const DeepCollectionEquality().equals(other._breakdown, _breakdown));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,total,const DeepCollectionEquality().hash(_breakdown));

@override
String toString() {
  return 'BudgetCategory(total: $total, breakdown: $breakdown)';
}


}

/// @nodoc
abstract mixin class _$BudgetCategoryCopyWith<$Res> implements $BudgetCategoryCopyWith<$Res> {
  factory _$BudgetCategoryCopyWith(_BudgetCategory value, $Res Function(_BudgetCategory) _then) = __$BudgetCategoryCopyWithImpl;
@override @useResult
$Res call({
 double total, Map<String, dynamic>? breakdown
});




}
/// @nodoc
class __$BudgetCategoryCopyWithImpl<$Res>
    implements _$BudgetCategoryCopyWith<$Res> {
  __$BudgetCategoryCopyWithImpl(this._self, this._then);

  final _BudgetCategory _self;
  final $Res Function(_BudgetCategory) _then;

/// Create a copy of BudgetCategory
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? total = null,Object? breakdown = freezed,}) {
  return _then(_BudgetCategory(
total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,breakdown: freezed == breakdown ? _self._breakdown : breakdown // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}


/// @nodoc
mixin _$BudgetScenarios {

 BudgetScenario get best; BudgetScenario get base; BudgetScenario get worst;
/// Create a copy of BudgetScenarios
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BudgetScenariosCopyWith<BudgetScenarios> get copyWith => _$BudgetScenariosCopyWithImpl<BudgetScenarios>(this as BudgetScenarios, _$identity);

  /// Serializes this BudgetScenarios to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BudgetScenarios&&(identical(other.best, best) || other.best == best)&&(identical(other.base, base) || other.base == base)&&(identical(other.worst, worst) || other.worst == worst));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,best,base,worst);

@override
String toString() {
  return 'BudgetScenarios(best: $best, base: $base, worst: $worst)';
}


}

/// @nodoc
abstract mixin class $BudgetScenariosCopyWith<$Res>  {
  factory $BudgetScenariosCopyWith(BudgetScenarios value, $Res Function(BudgetScenarios) _then) = _$BudgetScenariosCopyWithImpl;
@useResult
$Res call({
 BudgetScenario best, BudgetScenario base, BudgetScenario worst
});


$BudgetScenarioCopyWith<$Res> get best;$BudgetScenarioCopyWith<$Res> get base;$BudgetScenarioCopyWith<$Res> get worst;

}
/// @nodoc
class _$BudgetScenariosCopyWithImpl<$Res>
    implements $BudgetScenariosCopyWith<$Res> {
  _$BudgetScenariosCopyWithImpl(this._self, this._then);

  final BudgetScenarios _self;
  final $Res Function(BudgetScenarios) _then;

/// Create a copy of BudgetScenarios
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? best = null,Object? base = null,Object? worst = null,}) {
  return _then(_self.copyWith(
best: null == best ? _self.best : best // ignore: cast_nullable_to_non_nullable
as BudgetScenario,base: null == base ? _self.base : base // ignore: cast_nullable_to_non_nullable
as BudgetScenario,worst: null == worst ? _self.worst : worst // ignore: cast_nullable_to_non_nullable
as BudgetScenario,
  ));
}
/// Create a copy of BudgetScenarios
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BudgetScenarioCopyWith<$Res> get best {
  
  return $BudgetScenarioCopyWith<$Res>(_self.best, (value) {
    return _then(_self.copyWith(best: value));
  });
}/// Create a copy of BudgetScenarios
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BudgetScenarioCopyWith<$Res> get base {
  
  return $BudgetScenarioCopyWith<$Res>(_self.base, (value) {
    return _then(_self.copyWith(base: value));
  });
}/// Create a copy of BudgetScenarios
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BudgetScenarioCopyWith<$Res> get worst {
  
  return $BudgetScenarioCopyWith<$Res>(_self.worst, (value) {
    return _then(_self.copyWith(worst: value));
  });
}
}


/// Adds pattern-matching-related methods to [BudgetScenarios].
extension BudgetScenariosPatterns on BudgetScenarios {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BudgetScenarios value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BudgetScenarios() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BudgetScenarios value)  $default,){
final _that = this;
switch (_that) {
case _BudgetScenarios():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BudgetScenarios value)?  $default,){
final _that = this;
switch (_that) {
case _BudgetScenarios() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( BudgetScenario best,  BudgetScenario base,  BudgetScenario worst)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BudgetScenarios() when $default != null:
return $default(_that.best,_that.base,_that.worst);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( BudgetScenario best,  BudgetScenario base,  BudgetScenario worst)  $default,) {final _that = this;
switch (_that) {
case _BudgetScenarios():
return $default(_that.best,_that.base,_that.worst);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( BudgetScenario best,  BudgetScenario base,  BudgetScenario worst)?  $default,) {final _that = this;
switch (_that) {
case _BudgetScenarios() when $default != null:
return $default(_that.best,_that.base,_that.worst);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BudgetScenarios implements BudgetScenarios {
  const _BudgetScenarios({required this.best, required this.base, required this.worst});
  factory _BudgetScenarios.fromJson(Map<String, dynamic> json) => _$BudgetScenariosFromJson(json);

@override final  BudgetScenario best;
@override final  BudgetScenario base;
@override final  BudgetScenario worst;

/// Create a copy of BudgetScenarios
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BudgetScenariosCopyWith<_BudgetScenarios> get copyWith => __$BudgetScenariosCopyWithImpl<_BudgetScenarios>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BudgetScenariosToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BudgetScenarios&&(identical(other.best, best) || other.best == best)&&(identical(other.base, base) || other.base == base)&&(identical(other.worst, worst) || other.worst == worst));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,best,base,worst);

@override
String toString() {
  return 'BudgetScenarios(best: $best, base: $base, worst: $worst)';
}


}

/// @nodoc
abstract mixin class _$BudgetScenariosCopyWith<$Res> implements $BudgetScenariosCopyWith<$Res> {
  factory _$BudgetScenariosCopyWith(_BudgetScenarios value, $Res Function(_BudgetScenarios) _then) = __$BudgetScenariosCopyWithImpl;
@override @useResult
$Res call({
 BudgetScenario best, BudgetScenario base, BudgetScenario worst
});


@override $BudgetScenarioCopyWith<$Res> get best;@override $BudgetScenarioCopyWith<$Res> get base;@override $BudgetScenarioCopyWith<$Res> get worst;

}
/// @nodoc
class __$BudgetScenariosCopyWithImpl<$Res>
    implements _$BudgetScenariosCopyWith<$Res> {
  __$BudgetScenariosCopyWithImpl(this._self, this._then);

  final _BudgetScenarios _self;
  final $Res Function(_BudgetScenarios) _then;

/// Create a copy of BudgetScenarios
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? best = null,Object? base = null,Object? worst = null,}) {
  return _then(_BudgetScenarios(
best: null == best ? _self.best : best // ignore: cast_nullable_to_non_nullable
as BudgetScenario,base: null == base ? _self.base : base // ignore: cast_nullable_to_non_nullable
as BudgetScenario,worst: null == worst ? _self.worst : worst // ignore: cast_nullable_to_non_nullable
as BudgetScenario,
  ));
}

/// Create a copy of BudgetScenarios
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BudgetScenarioCopyWith<$Res> get best {
  
  return $BudgetScenarioCopyWith<$Res>(_self.best, (value) {
    return _then(_self.copyWith(best: value));
  });
}/// Create a copy of BudgetScenarios
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BudgetScenarioCopyWith<$Res> get base {
  
  return $BudgetScenarioCopyWith<$Res>(_self.base, (value) {
    return _then(_self.copyWith(base: value));
  });
}/// Create a copy of BudgetScenarios
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BudgetScenarioCopyWith<$Res> get worst {
  
  return $BudgetScenarioCopyWith<$Res>(_self.worst, (value) {
    return _then(_self.copyWith(worst: value));
  });
}
}


/// @nodoc
mixin _$BudgetScenario {

 double get revenue; double get profit;
/// Create a copy of BudgetScenario
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BudgetScenarioCopyWith<BudgetScenario> get copyWith => _$BudgetScenarioCopyWithImpl<BudgetScenario>(this as BudgetScenario, _$identity);

  /// Serializes this BudgetScenario to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BudgetScenario&&(identical(other.revenue, revenue) || other.revenue == revenue)&&(identical(other.profit, profit) || other.profit == profit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,revenue,profit);

@override
String toString() {
  return 'BudgetScenario(revenue: $revenue, profit: $profit)';
}


}

/// @nodoc
abstract mixin class $BudgetScenarioCopyWith<$Res>  {
  factory $BudgetScenarioCopyWith(BudgetScenario value, $Res Function(BudgetScenario) _then) = _$BudgetScenarioCopyWithImpl;
@useResult
$Res call({
 double revenue, double profit
});




}
/// @nodoc
class _$BudgetScenarioCopyWithImpl<$Res>
    implements $BudgetScenarioCopyWith<$Res> {
  _$BudgetScenarioCopyWithImpl(this._self, this._then);

  final BudgetScenario _self;
  final $Res Function(BudgetScenario) _then;

/// Create a copy of BudgetScenario
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? revenue = null,Object? profit = null,}) {
  return _then(_self.copyWith(
revenue: null == revenue ? _self.revenue : revenue // ignore: cast_nullable_to_non_nullable
as double,profit: null == profit ? _self.profit : profit // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [BudgetScenario].
extension BudgetScenarioPatterns on BudgetScenario {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BudgetScenario value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BudgetScenario() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BudgetScenario value)  $default,){
final _that = this;
switch (_that) {
case _BudgetScenario():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BudgetScenario value)?  $default,){
final _that = this;
switch (_that) {
case _BudgetScenario() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double revenue,  double profit)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BudgetScenario() when $default != null:
return $default(_that.revenue,_that.profit);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double revenue,  double profit)  $default,) {final _that = this;
switch (_that) {
case _BudgetScenario():
return $default(_that.revenue,_that.profit);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double revenue,  double profit)?  $default,) {final _that = this;
switch (_that) {
case _BudgetScenario() when $default != null:
return $default(_that.revenue,_that.profit);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BudgetScenario implements BudgetScenario {
  const _BudgetScenario({required this.revenue, required this.profit});
  factory _BudgetScenario.fromJson(Map<String, dynamic> json) => _$BudgetScenarioFromJson(json);

@override final  double revenue;
@override final  double profit;

/// Create a copy of BudgetScenario
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BudgetScenarioCopyWith<_BudgetScenario> get copyWith => __$BudgetScenarioCopyWithImpl<_BudgetScenario>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BudgetScenarioToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BudgetScenario&&(identical(other.revenue, revenue) || other.revenue == revenue)&&(identical(other.profit, profit) || other.profit == profit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,revenue,profit);

@override
String toString() {
  return 'BudgetScenario(revenue: $revenue, profit: $profit)';
}


}

/// @nodoc
abstract mixin class _$BudgetScenarioCopyWith<$Res> implements $BudgetScenarioCopyWith<$Res> {
  factory _$BudgetScenarioCopyWith(_BudgetScenario value, $Res Function(_BudgetScenario) _then) = __$BudgetScenarioCopyWithImpl;
@override @useResult
$Res call({
 double revenue, double profit
});




}
/// @nodoc
class __$BudgetScenarioCopyWithImpl<$Res>
    implements _$BudgetScenarioCopyWith<$Res> {
  __$BudgetScenarioCopyWithImpl(this._self, this._then);

  final _BudgetScenario _self;
  final $Res Function(_BudgetScenario) _then;

/// Create a copy of BudgetScenario
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? revenue = null,Object? profit = null,}) {
  return _then(_BudgetScenario(
revenue: null == revenue ? _self.revenue : revenue // ignore: cast_nullable_to_non_nullable
as double,profit: null == profit ? _self.profit : profit // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$Payment {

 String get paymentId; double get amount; String get method; String get status; String get processedAt; PaymentRouting get routing; PaymentFees get fees; String get estimatedCompletion;
/// Create a copy of Payment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentCopyWith<Payment> get copyWith => _$PaymentCopyWithImpl<Payment>(this as Payment, _$identity);

  /// Serializes this Payment to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Payment&&(identical(other.paymentId, paymentId) || other.paymentId == paymentId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.method, method) || other.method == method)&&(identical(other.status, status) || other.status == status)&&(identical(other.processedAt, processedAt) || other.processedAt == processedAt)&&(identical(other.routing, routing) || other.routing == routing)&&(identical(other.fees, fees) || other.fees == fees)&&(identical(other.estimatedCompletion, estimatedCompletion) || other.estimatedCompletion == estimatedCompletion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,paymentId,amount,method,status,processedAt,routing,fees,estimatedCompletion);

@override
String toString() {
  return 'Payment(paymentId: $paymentId, amount: $amount, method: $method, status: $status, processedAt: $processedAt, routing: $routing, fees: $fees, estimatedCompletion: $estimatedCompletion)';
}


}

/// @nodoc
abstract mixin class $PaymentCopyWith<$Res>  {
  factory $PaymentCopyWith(Payment value, $Res Function(Payment) _then) = _$PaymentCopyWithImpl;
@useResult
$Res call({
 String paymentId, double amount, String method, String status, String processedAt, PaymentRouting routing, PaymentFees fees, String estimatedCompletion
});


$PaymentRoutingCopyWith<$Res> get routing;$PaymentFeesCopyWith<$Res> get fees;

}
/// @nodoc
class _$PaymentCopyWithImpl<$Res>
    implements $PaymentCopyWith<$Res> {
  _$PaymentCopyWithImpl(this._self, this._then);

  final Payment _self;
  final $Res Function(Payment) _then;

/// Create a copy of Payment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? paymentId = null,Object? amount = null,Object? method = null,Object? status = null,Object? processedAt = null,Object? routing = null,Object? fees = null,Object? estimatedCompletion = null,}) {
  return _then(_self.copyWith(
paymentId: null == paymentId ? _self.paymentId : paymentId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,method: null == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,processedAt: null == processedAt ? _self.processedAt : processedAt // ignore: cast_nullable_to_non_nullable
as String,routing: null == routing ? _self.routing : routing // ignore: cast_nullable_to_non_nullable
as PaymentRouting,fees: null == fees ? _self.fees : fees // ignore: cast_nullable_to_non_nullable
as PaymentFees,estimatedCompletion: null == estimatedCompletion ? _self.estimatedCompletion : estimatedCompletion // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of Payment
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaymentRoutingCopyWith<$Res> get routing {
  
  return $PaymentRoutingCopyWith<$Res>(_self.routing, (value) {
    return _then(_self.copyWith(routing: value));
  });
}/// Create a copy of Payment
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaymentFeesCopyWith<$Res> get fees {
  
  return $PaymentFeesCopyWith<$Res>(_self.fees, (value) {
    return _then(_self.copyWith(fees: value));
  });
}
}


/// Adds pattern-matching-related methods to [Payment].
extension PaymentPatterns on Payment {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Payment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Payment() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Payment value)  $default,){
final _that = this;
switch (_that) {
case _Payment():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Payment value)?  $default,){
final _that = this;
switch (_that) {
case _Payment() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String paymentId,  double amount,  String method,  String status,  String processedAt,  PaymentRouting routing,  PaymentFees fees,  String estimatedCompletion)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Payment() when $default != null:
return $default(_that.paymentId,_that.amount,_that.method,_that.status,_that.processedAt,_that.routing,_that.fees,_that.estimatedCompletion);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String paymentId,  double amount,  String method,  String status,  String processedAt,  PaymentRouting routing,  PaymentFees fees,  String estimatedCompletion)  $default,) {final _that = this;
switch (_that) {
case _Payment():
return $default(_that.paymentId,_that.amount,_that.method,_that.status,_that.processedAt,_that.routing,_that.fees,_that.estimatedCompletion);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String paymentId,  double amount,  String method,  String status,  String processedAt,  PaymentRouting routing,  PaymentFees fees,  String estimatedCompletion)?  $default,) {final _that = this;
switch (_that) {
case _Payment() when $default != null:
return $default(_that.paymentId,_that.amount,_that.method,_that.status,_that.processedAt,_that.routing,_that.fees,_that.estimatedCompletion);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Payment implements Payment {
  const _Payment({required this.paymentId, required this.amount, required this.method, required this.status, required this.processedAt, required this.routing, required this.fees, required this.estimatedCompletion});
  factory _Payment.fromJson(Map<String, dynamic> json) => _$PaymentFromJson(json);

@override final  String paymentId;
@override final  double amount;
@override final  String method;
@override final  String status;
@override final  String processedAt;
@override final  PaymentRouting routing;
@override final  PaymentFees fees;
@override final  String estimatedCompletion;

/// Create a copy of Payment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentCopyWith<_Payment> get copyWith => __$PaymentCopyWithImpl<_Payment>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaymentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Payment&&(identical(other.paymentId, paymentId) || other.paymentId == paymentId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.method, method) || other.method == method)&&(identical(other.status, status) || other.status == status)&&(identical(other.processedAt, processedAt) || other.processedAt == processedAt)&&(identical(other.routing, routing) || other.routing == routing)&&(identical(other.fees, fees) || other.fees == fees)&&(identical(other.estimatedCompletion, estimatedCompletion) || other.estimatedCompletion == estimatedCompletion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,paymentId,amount,method,status,processedAt,routing,fees,estimatedCompletion);

@override
String toString() {
  return 'Payment(paymentId: $paymentId, amount: $amount, method: $method, status: $status, processedAt: $processedAt, routing: $routing, fees: $fees, estimatedCompletion: $estimatedCompletion)';
}


}

/// @nodoc
abstract mixin class _$PaymentCopyWith<$Res> implements $PaymentCopyWith<$Res> {
  factory _$PaymentCopyWith(_Payment value, $Res Function(_Payment) _then) = __$PaymentCopyWithImpl;
@override @useResult
$Res call({
 String paymentId, double amount, String method, String status, String processedAt, PaymentRouting routing, PaymentFees fees, String estimatedCompletion
});


@override $PaymentRoutingCopyWith<$Res> get routing;@override $PaymentFeesCopyWith<$Res> get fees;

}
/// @nodoc
class __$PaymentCopyWithImpl<$Res>
    implements _$PaymentCopyWith<$Res> {
  __$PaymentCopyWithImpl(this._self, this._then);

  final _Payment _self;
  final $Res Function(_Payment) _then;

/// Create a copy of Payment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? paymentId = null,Object? amount = null,Object? method = null,Object? status = null,Object? processedAt = null,Object? routing = null,Object? fees = null,Object? estimatedCompletion = null,}) {
  return _then(_Payment(
paymentId: null == paymentId ? _self.paymentId : paymentId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,method: null == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,processedAt: null == processedAt ? _self.processedAt : processedAt // ignore: cast_nullable_to_non_nullable
as String,routing: null == routing ? _self.routing : routing // ignore: cast_nullable_to_non_nullable
as PaymentRouting,fees: null == fees ? _self.fees : fees // ignore: cast_nullable_to_non_nullable
as PaymentFees,estimatedCompletion: null == estimatedCompletion ? _self.estimatedCompletion : estimatedCompletion // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of Payment
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaymentRoutingCopyWith<$Res> get routing {
  
  return $PaymentRoutingCopyWith<$Res>(_self.routing, (value) {
    return _then(_self.copyWith(routing: value));
  });
}/// Create a copy of Payment
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaymentFeesCopyWith<$Res> get fees {
  
  return $PaymentFeesCopyWith<$Res>(_self.fees, (value) {
    return _then(_self.copyWith(fees: value));
  });
}
}


/// @nodoc
mixin _$PaymentRouting {

 String get processor; String get gateway; double get estimatedFee;
/// Create a copy of PaymentRouting
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentRoutingCopyWith<PaymentRouting> get copyWith => _$PaymentRoutingCopyWithImpl<PaymentRouting>(this as PaymentRouting, _$identity);

  /// Serializes this PaymentRouting to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentRouting&&(identical(other.processor, processor) || other.processor == processor)&&(identical(other.gateway, gateway) || other.gateway == gateway)&&(identical(other.estimatedFee, estimatedFee) || other.estimatedFee == estimatedFee));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,processor,gateway,estimatedFee);

@override
String toString() {
  return 'PaymentRouting(processor: $processor, gateway: $gateway, estimatedFee: $estimatedFee)';
}


}

/// @nodoc
abstract mixin class $PaymentRoutingCopyWith<$Res>  {
  factory $PaymentRoutingCopyWith(PaymentRouting value, $Res Function(PaymentRouting) _then) = _$PaymentRoutingCopyWithImpl;
@useResult
$Res call({
 String processor, String gateway, double estimatedFee
});




}
/// @nodoc
class _$PaymentRoutingCopyWithImpl<$Res>
    implements $PaymentRoutingCopyWith<$Res> {
  _$PaymentRoutingCopyWithImpl(this._self, this._then);

  final PaymentRouting _self;
  final $Res Function(PaymentRouting) _then;

/// Create a copy of PaymentRouting
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? processor = null,Object? gateway = null,Object? estimatedFee = null,}) {
  return _then(_self.copyWith(
processor: null == processor ? _self.processor : processor // ignore: cast_nullable_to_non_nullable
as String,gateway: null == gateway ? _self.gateway : gateway // ignore: cast_nullable_to_non_nullable
as String,estimatedFee: null == estimatedFee ? _self.estimatedFee : estimatedFee // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [PaymentRouting].
extension PaymentRoutingPatterns on PaymentRouting {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaymentRouting value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaymentRouting() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaymentRouting value)  $default,){
final _that = this;
switch (_that) {
case _PaymentRouting():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaymentRouting value)?  $default,){
final _that = this;
switch (_that) {
case _PaymentRouting() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String processor,  String gateway,  double estimatedFee)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaymentRouting() when $default != null:
return $default(_that.processor,_that.gateway,_that.estimatedFee);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String processor,  String gateway,  double estimatedFee)  $default,) {final _that = this;
switch (_that) {
case _PaymentRouting():
return $default(_that.processor,_that.gateway,_that.estimatedFee);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String processor,  String gateway,  double estimatedFee)?  $default,) {final _that = this;
switch (_that) {
case _PaymentRouting() when $default != null:
return $default(_that.processor,_that.gateway,_that.estimatedFee);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PaymentRouting implements PaymentRouting {
  const _PaymentRouting({required this.processor, required this.gateway, required this.estimatedFee});
  factory _PaymentRouting.fromJson(Map<String, dynamic> json) => _$PaymentRoutingFromJson(json);

@override final  String processor;
@override final  String gateway;
@override final  double estimatedFee;

/// Create a copy of PaymentRouting
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentRoutingCopyWith<_PaymentRouting> get copyWith => __$PaymentRoutingCopyWithImpl<_PaymentRouting>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaymentRoutingToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentRouting&&(identical(other.processor, processor) || other.processor == processor)&&(identical(other.gateway, gateway) || other.gateway == gateway)&&(identical(other.estimatedFee, estimatedFee) || other.estimatedFee == estimatedFee));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,processor,gateway,estimatedFee);

@override
String toString() {
  return 'PaymentRouting(processor: $processor, gateway: $gateway, estimatedFee: $estimatedFee)';
}


}

/// @nodoc
abstract mixin class _$PaymentRoutingCopyWith<$Res> implements $PaymentRoutingCopyWith<$Res> {
  factory _$PaymentRoutingCopyWith(_PaymentRouting value, $Res Function(_PaymentRouting) _then) = __$PaymentRoutingCopyWithImpl;
@override @useResult
$Res call({
 String processor, String gateway, double estimatedFee
});




}
/// @nodoc
class __$PaymentRoutingCopyWithImpl<$Res>
    implements _$PaymentRoutingCopyWith<$Res> {
  __$PaymentRoutingCopyWithImpl(this._self, this._then);

  final _PaymentRouting _self;
  final $Res Function(_PaymentRouting) _then;

/// Create a copy of PaymentRouting
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? processor = null,Object? gateway = null,Object? estimatedFee = null,}) {
  return _then(_PaymentRouting(
processor: null == processor ? _self.processor : processor // ignore: cast_nullable_to_non_nullable
as String,gateway: null == gateway ? _self.gateway : gateway // ignore: cast_nullable_to_non_nullable
as String,estimatedFee: null == estimatedFee ? _self.estimatedFee : estimatedFee // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$PaymentFees {

 double get processing; double get gateway; double get total;
/// Create a copy of PaymentFees
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentFeesCopyWith<PaymentFees> get copyWith => _$PaymentFeesCopyWithImpl<PaymentFees>(this as PaymentFees, _$identity);

  /// Serializes this PaymentFees to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentFees&&(identical(other.processing, processing) || other.processing == processing)&&(identical(other.gateway, gateway) || other.gateway == gateway)&&(identical(other.total, total) || other.total == total));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,processing,gateway,total);

@override
String toString() {
  return 'PaymentFees(processing: $processing, gateway: $gateway, total: $total)';
}


}

/// @nodoc
abstract mixin class $PaymentFeesCopyWith<$Res>  {
  factory $PaymentFeesCopyWith(PaymentFees value, $Res Function(PaymentFees) _then) = _$PaymentFeesCopyWithImpl;
@useResult
$Res call({
 double processing, double gateway, double total
});




}
/// @nodoc
class _$PaymentFeesCopyWithImpl<$Res>
    implements $PaymentFeesCopyWith<$Res> {
  _$PaymentFeesCopyWithImpl(this._self, this._then);

  final PaymentFees _self;
  final $Res Function(PaymentFees) _then;

/// Create a copy of PaymentFees
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? processing = null,Object? gateway = null,Object? total = null,}) {
  return _then(_self.copyWith(
processing: null == processing ? _self.processing : processing // ignore: cast_nullable_to_non_nullable
as double,gateway: null == gateway ? _self.gateway : gateway // ignore: cast_nullable_to_non_nullable
as double,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [PaymentFees].
extension PaymentFeesPatterns on PaymentFees {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaymentFees value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaymentFees() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaymentFees value)  $default,){
final _that = this;
switch (_that) {
case _PaymentFees():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaymentFees value)?  $default,){
final _that = this;
switch (_that) {
case _PaymentFees() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double processing,  double gateway,  double total)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaymentFees() when $default != null:
return $default(_that.processing,_that.gateway,_that.total);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double processing,  double gateway,  double total)  $default,) {final _that = this;
switch (_that) {
case _PaymentFees():
return $default(_that.processing,_that.gateway,_that.total);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double processing,  double gateway,  double total)?  $default,) {final _that = this;
switch (_that) {
case _PaymentFees() when $default != null:
return $default(_that.processing,_that.gateway,_that.total);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PaymentFees implements PaymentFees {
  const _PaymentFees({required this.processing, required this.gateway, required this.total});
  factory _PaymentFees.fromJson(Map<String, dynamic> json) => _$PaymentFeesFromJson(json);

@override final  double processing;
@override final  double gateway;
@override final  double total;

/// Create a copy of PaymentFees
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentFeesCopyWith<_PaymentFees> get copyWith => __$PaymentFeesCopyWithImpl<_PaymentFees>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaymentFeesToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentFees&&(identical(other.processing, processing) || other.processing == processing)&&(identical(other.gateway, gateway) || other.gateway == gateway)&&(identical(other.total, total) || other.total == total));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,processing,gateway,total);

@override
String toString() {
  return 'PaymentFees(processing: $processing, gateway: $gateway, total: $total)';
}


}

/// @nodoc
abstract mixin class _$PaymentFeesCopyWith<$Res> implements $PaymentFeesCopyWith<$Res> {
  factory _$PaymentFeesCopyWith(_PaymentFees value, $Res Function(_PaymentFees) _then) = __$PaymentFeesCopyWithImpl;
@override @useResult
$Res call({
 double processing, double gateway, double total
});




}
/// @nodoc
class __$PaymentFeesCopyWithImpl<$Res>
    implements _$PaymentFeesCopyWith<$Res> {
  __$PaymentFeesCopyWithImpl(this._self, this._then);

  final _PaymentFees _self;
  final $Res Function(_PaymentFees) _then;

/// Create a copy of PaymentFees
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? processing = null,Object? gateway = null,Object? total = null,}) {
  return _then(_PaymentFees(
processing: null == processing ? _self.processing : processing // ignore: cast_nullable_to_non_nullable
as double,gateway: null == gateway ? _self.gateway : gateway // ignore: cast_nullable_to_non_nullable
as double,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$ComplianceCheck {

 String get organizationId; String get checkedAt; ComplianceArea get ndis; ComplianceArea get tax; ComplianceArea get reporting; String get overallStatus; double get score; List<String> get issues; List<String> get recommendations;
/// Create a copy of ComplianceCheck
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ComplianceCheckCopyWith<ComplianceCheck> get copyWith => _$ComplianceCheckCopyWithImpl<ComplianceCheck>(this as ComplianceCheck, _$identity);

  /// Serializes this ComplianceCheck to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ComplianceCheck&&(identical(other.organizationId, organizationId) || other.organizationId == organizationId)&&(identical(other.checkedAt, checkedAt) || other.checkedAt == checkedAt)&&(identical(other.ndis, ndis) || other.ndis == ndis)&&(identical(other.tax, tax) || other.tax == tax)&&(identical(other.reporting, reporting) || other.reporting == reporting)&&(identical(other.overallStatus, overallStatus) || other.overallStatus == overallStatus)&&(identical(other.score, score) || other.score == score)&&const DeepCollectionEquality().equals(other.issues, issues)&&const DeepCollectionEquality().equals(other.recommendations, recommendations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,organizationId,checkedAt,ndis,tax,reporting,overallStatus,score,const DeepCollectionEquality().hash(issues),const DeepCollectionEquality().hash(recommendations));

@override
String toString() {
  return 'ComplianceCheck(organizationId: $organizationId, checkedAt: $checkedAt, ndis: $ndis, tax: $tax, reporting: $reporting, overallStatus: $overallStatus, score: $score, issues: $issues, recommendations: $recommendations)';
}


}

/// @nodoc
abstract mixin class $ComplianceCheckCopyWith<$Res>  {
  factory $ComplianceCheckCopyWith(ComplianceCheck value, $Res Function(ComplianceCheck) _then) = _$ComplianceCheckCopyWithImpl;
@useResult
$Res call({
 String organizationId, String checkedAt, ComplianceArea ndis, ComplianceArea tax, ComplianceArea reporting, String overallStatus, double score, List<String> issues, List<String> recommendations
});


$ComplianceAreaCopyWith<$Res> get ndis;$ComplianceAreaCopyWith<$Res> get tax;$ComplianceAreaCopyWith<$Res> get reporting;

}
/// @nodoc
class _$ComplianceCheckCopyWithImpl<$Res>
    implements $ComplianceCheckCopyWith<$Res> {
  _$ComplianceCheckCopyWithImpl(this._self, this._then);

  final ComplianceCheck _self;
  final $Res Function(ComplianceCheck) _then;

/// Create a copy of ComplianceCheck
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? organizationId = null,Object? checkedAt = null,Object? ndis = null,Object? tax = null,Object? reporting = null,Object? overallStatus = null,Object? score = null,Object? issues = null,Object? recommendations = null,}) {
  return _then(_self.copyWith(
organizationId: null == organizationId ? _self.organizationId : organizationId // ignore: cast_nullable_to_non_nullable
as String,checkedAt: null == checkedAt ? _self.checkedAt : checkedAt // ignore: cast_nullable_to_non_nullable
as String,ndis: null == ndis ? _self.ndis : ndis // ignore: cast_nullable_to_non_nullable
as ComplianceArea,tax: null == tax ? _self.tax : tax // ignore: cast_nullable_to_non_nullable
as ComplianceArea,reporting: null == reporting ? _self.reporting : reporting // ignore: cast_nullable_to_non_nullable
as ComplianceArea,overallStatus: null == overallStatus ? _self.overallStatus : overallStatus // ignore: cast_nullable_to_non_nullable
as String,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as double,issues: null == issues ? _self.issues : issues // ignore: cast_nullable_to_non_nullable
as List<String>,recommendations: null == recommendations ? _self.recommendations : recommendations // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}
/// Create a copy of ComplianceCheck
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ComplianceAreaCopyWith<$Res> get ndis {
  
  return $ComplianceAreaCopyWith<$Res>(_self.ndis, (value) {
    return _then(_self.copyWith(ndis: value));
  });
}/// Create a copy of ComplianceCheck
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ComplianceAreaCopyWith<$Res> get tax {
  
  return $ComplianceAreaCopyWith<$Res>(_self.tax, (value) {
    return _then(_self.copyWith(tax: value));
  });
}/// Create a copy of ComplianceCheck
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ComplianceAreaCopyWith<$Res> get reporting {
  
  return $ComplianceAreaCopyWith<$Res>(_self.reporting, (value) {
    return _then(_self.copyWith(reporting: value));
  });
}
}


/// Adds pattern-matching-related methods to [ComplianceCheck].
extension ComplianceCheckPatterns on ComplianceCheck {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ComplianceCheck value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ComplianceCheck() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ComplianceCheck value)  $default,){
final _that = this;
switch (_that) {
case _ComplianceCheck():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ComplianceCheck value)?  $default,){
final _that = this;
switch (_that) {
case _ComplianceCheck() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String organizationId,  String checkedAt,  ComplianceArea ndis,  ComplianceArea tax,  ComplianceArea reporting,  String overallStatus,  double score,  List<String> issues,  List<String> recommendations)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ComplianceCheck() when $default != null:
return $default(_that.organizationId,_that.checkedAt,_that.ndis,_that.tax,_that.reporting,_that.overallStatus,_that.score,_that.issues,_that.recommendations);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String organizationId,  String checkedAt,  ComplianceArea ndis,  ComplianceArea tax,  ComplianceArea reporting,  String overallStatus,  double score,  List<String> issues,  List<String> recommendations)  $default,) {final _that = this;
switch (_that) {
case _ComplianceCheck():
return $default(_that.organizationId,_that.checkedAt,_that.ndis,_that.tax,_that.reporting,_that.overallStatus,_that.score,_that.issues,_that.recommendations);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String organizationId,  String checkedAt,  ComplianceArea ndis,  ComplianceArea tax,  ComplianceArea reporting,  String overallStatus,  double score,  List<String> issues,  List<String> recommendations)?  $default,) {final _that = this;
switch (_that) {
case _ComplianceCheck() when $default != null:
return $default(_that.organizationId,_that.checkedAt,_that.ndis,_that.tax,_that.reporting,_that.overallStatus,_that.score,_that.issues,_that.recommendations);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ComplianceCheck implements ComplianceCheck {
  const _ComplianceCheck({required this.organizationId, required this.checkedAt, required this.ndis, required this.tax, required this.reporting, required this.overallStatus, required this.score, required final  List<String> issues, required final  List<String> recommendations}): _issues = issues,_recommendations = recommendations;
  factory _ComplianceCheck.fromJson(Map<String, dynamic> json) => _$ComplianceCheckFromJson(json);

@override final  String organizationId;
@override final  String checkedAt;
@override final  ComplianceArea ndis;
@override final  ComplianceArea tax;
@override final  ComplianceArea reporting;
@override final  String overallStatus;
@override final  double score;
 final  List<String> _issues;
@override List<String> get issues {
  if (_issues is EqualUnmodifiableListView) return _issues;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_issues);
}

 final  List<String> _recommendations;
@override List<String> get recommendations {
  if (_recommendations is EqualUnmodifiableListView) return _recommendations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recommendations);
}


/// Create a copy of ComplianceCheck
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ComplianceCheckCopyWith<_ComplianceCheck> get copyWith => __$ComplianceCheckCopyWithImpl<_ComplianceCheck>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ComplianceCheckToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ComplianceCheck&&(identical(other.organizationId, organizationId) || other.organizationId == organizationId)&&(identical(other.checkedAt, checkedAt) || other.checkedAt == checkedAt)&&(identical(other.ndis, ndis) || other.ndis == ndis)&&(identical(other.tax, tax) || other.tax == tax)&&(identical(other.reporting, reporting) || other.reporting == reporting)&&(identical(other.overallStatus, overallStatus) || other.overallStatus == overallStatus)&&(identical(other.score, score) || other.score == score)&&const DeepCollectionEquality().equals(other._issues, _issues)&&const DeepCollectionEquality().equals(other._recommendations, _recommendations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,organizationId,checkedAt,ndis,tax,reporting,overallStatus,score,const DeepCollectionEquality().hash(_issues),const DeepCollectionEquality().hash(_recommendations));

@override
String toString() {
  return 'ComplianceCheck(organizationId: $organizationId, checkedAt: $checkedAt, ndis: $ndis, tax: $tax, reporting: $reporting, overallStatus: $overallStatus, score: $score, issues: $issues, recommendations: $recommendations)';
}


}

/// @nodoc
abstract mixin class _$ComplianceCheckCopyWith<$Res> implements $ComplianceCheckCopyWith<$Res> {
  factory _$ComplianceCheckCopyWith(_ComplianceCheck value, $Res Function(_ComplianceCheck) _then) = __$ComplianceCheckCopyWithImpl;
@override @useResult
$Res call({
 String organizationId, String checkedAt, ComplianceArea ndis, ComplianceArea tax, ComplianceArea reporting, String overallStatus, double score, List<String> issues, List<String> recommendations
});


@override $ComplianceAreaCopyWith<$Res> get ndis;@override $ComplianceAreaCopyWith<$Res> get tax;@override $ComplianceAreaCopyWith<$Res> get reporting;

}
/// @nodoc
class __$ComplianceCheckCopyWithImpl<$Res>
    implements _$ComplianceCheckCopyWith<$Res> {
  __$ComplianceCheckCopyWithImpl(this._self, this._then);

  final _ComplianceCheck _self;
  final $Res Function(_ComplianceCheck) _then;

/// Create a copy of ComplianceCheck
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? organizationId = null,Object? checkedAt = null,Object? ndis = null,Object? tax = null,Object? reporting = null,Object? overallStatus = null,Object? score = null,Object? issues = null,Object? recommendations = null,}) {
  return _then(_ComplianceCheck(
organizationId: null == organizationId ? _self.organizationId : organizationId // ignore: cast_nullable_to_non_nullable
as String,checkedAt: null == checkedAt ? _self.checkedAt : checkedAt // ignore: cast_nullable_to_non_nullable
as String,ndis: null == ndis ? _self.ndis : ndis // ignore: cast_nullable_to_non_nullable
as ComplianceArea,tax: null == tax ? _self.tax : tax // ignore: cast_nullable_to_non_nullable
as ComplianceArea,reporting: null == reporting ? _self.reporting : reporting // ignore: cast_nullable_to_non_nullable
as ComplianceArea,overallStatus: null == overallStatus ? _self.overallStatus : overallStatus // ignore: cast_nullable_to_non_nullable
as String,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as double,issues: null == issues ? _self._issues : issues // ignore: cast_nullable_to_non_nullable
as List<String>,recommendations: null == recommendations ? _self._recommendations : recommendations // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

/// Create a copy of ComplianceCheck
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ComplianceAreaCopyWith<$Res> get ndis {
  
  return $ComplianceAreaCopyWith<$Res>(_self.ndis, (value) {
    return _then(_self.copyWith(ndis: value));
  });
}/// Create a copy of ComplianceCheck
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ComplianceAreaCopyWith<$Res> get tax {
  
  return $ComplianceAreaCopyWith<$Res>(_self.tax, (value) {
    return _then(_self.copyWith(tax: value));
  });
}/// Create a copy of ComplianceCheck
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ComplianceAreaCopyWith<$Res> get reporting {
  
  return $ComplianceAreaCopyWith<$Res>(_self.reporting, (value) {
    return _then(_self.copyWith(reporting: value));
  });
}
}


/// @nodoc
mixin _$ComplianceArea {

 String get status; List<ComplianceAreaCheck> get checks;
/// Create a copy of ComplianceArea
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ComplianceAreaCopyWith<ComplianceArea> get copyWith => _$ComplianceAreaCopyWithImpl<ComplianceArea>(this as ComplianceArea, _$identity);

  /// Serializes this ComplianceArea to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ComplianceArea&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.checks, checks));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(checks));

@override
String toString() {
  return 'ComplianceArea(status: $status, checks: $checks)';
}


}

/// @nodoc
abstract mixin class $ComplianceAreaCopyWith<$Res>  {
  factory $ComplianceAreaCopyWith(ComplianceArea value, $Res Function(ComplianceArea) _then) = _$ComplianceAreaCopyWithImpl;
@useResult
$Res call({
 String status, List<ComplianceAreaCheck> checks
});




}
/// @nodoc
class _$ComplianceAreaCopyWithImpl<$Res>
    implements $ComplianceAreaCopyWith<$Res> {
  _$ComplianceAreaCopyWithImpl(this._self, this._then);

  final ComplianceArea _self;
  final $Res Function(ComplianceArea) _then;

/// Create a copy of ComplianceArea
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? checks = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,checks: null == checks ? _self.checks : checks // ignore: cast_nullable_to_non_nullable
as List<ComplianceAreaCheck>,
  ));
}

}


/// Adds pattern-matching-related methods to [ComplianceArea].
extension ComplianceAreaPatterns on ComplianceArea {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ComplianceArea value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ComplianceArea() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ComplianceArea value)  $default,){
final _that = this;
switch (_that) {
case _ComplianceArea():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ComplianceArea value)?  $default,){
final _that = this;
switch (_that) {
case _ComplianceArea() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String status,  List<ComplianceAreaCheck> checks)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ComplianceArea() when $default != null:
return $default(_that.status,_that.checks);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String status,  List<ComplianceAreaCheck> checks)  $default,) {final _that = this;
switch (_that) {
case _ComplianceArea():
return $default(_that.status,_that.checks);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String status,  List<ComplianceAreaCheck> checks)?  $default,) {final _that = this;
switch (_that) {
case _ComplianceArea() when $default != null:
return $default(_that.status,_that.checks);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ComplianceArea implements ComplianceArea {
  const _ComplianceArea({required this.status, required final  List<ComplianceAreaCheck> checks}): _checks = checks;
  factory _ComplianceArea.fromJson(Map<String, dynamic> json) => _$ComplianceAreaFromJson(json);

@override final  String status;
 final  List<ComplianceAreaCheck> _checks;
@override List<ComplianceAreaCheck> get checks {
  if (_checks is EqualUnmodifiableListView) return _checks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_checks);
}


/// Create a copy of ComplianceArea
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ComplianceAreaCopyWith<_ComplianceArea> get copyWith => __$ComplianceAreaCopyWithImpl<_ComplianceArea>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ComplianceAreaToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ComplianceArea&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._checks, _checks));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_checks));

@override
String toString() {
  return 'ComplianceArea(status: $status, checks: $checks)';
}


}

/// @nodoc
abstract mixin class _$ComplianceAreaCopyWith<$Res> implements $ComplianceAreaCopyWith<$Res> {
  factory _$ComplianceAreaCopyWith(_ComplianceArea value, $Res Function(_ComplianceArea) _then) = __$ComplianceAreaCopyWithImpl;
@override @useResult
$Res call({
 String status, List<ComplianceAreaCheck> checks
});




}
/// @nodoc
class __$ComplianceAreaCopyWithImpl<$Res>
    implements _$ComplianceAreaCopyWith<$Res> {
  __$ComplianceAreaCopyWithImpl(this._self, this._then);

  final _ComplianceArea _self;
  final $Res Function(_ComplianceArea) _then;

/// Create a copy of ComplianceArea
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? checks = null,}) {
  return _then(_ComplianceArea(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,checks: null == checks ? _self._checks : checks // ignore: cast_nullable_to_non_nullable
as List<ComplianceAreaCheck>,
  ));
}


}


/// @nodoc
mixin _$ComplianceAreaCheck {

 String get check; bool get passed;
/// Create a copy of ComplianceAreaCheck
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ComplianceAreaCheckCopyWith<ComplianceAreaCheck> get copyWith => _$ComplianceAreaCheckCopyWithImpl<ComplianceAreaCheck>(this as ComplianceAreaCheck, _$identity);

  /// Serializes this ComplianceAreaCheck to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ComplianceAreaCheck&&(identical(other.check, check) || other.check == check)&&(identical(other.passed, passed) || other.passed == passed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,check,passed);

@override
String toString() {
  return 'ComplianceAreaCheck(check: $check, passed: $passed)';
}


}

/// @nodoc
abstract mixin class $ComplianceAreaCheckCopyWith<$Res>  {
  factory $ComplianceAreaCheckCopyWith(ComplianceAreaCheck value, $Res Function(ComplianceAreaCheck) _then) = _$ComplianceAreaCheckCopyWithImpl;
@useResult
$Res call({
 String check, bool passed
});




}
/// @nodoc
class _$ComplianceAreaCheckCopyWithImpl<$Res>
    implements $ComplianceAreaCheckCopyWith<$Res> {
  _$ComplianceAreaCheckCopyWithImpl(this._self, this._then);

  final ComplianceAreaCheck _self;
  final $Res Function(ComplianceAreaCheck) _then;

/// Create a copy of ComplianceAreaCheck
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? check = null,Object? passed = null,}) {
  return _then(_self.copyWith(
check: null == check ? _self.check : check // ignore: cast_nullable_to_non_nullable
as String,passed: null == passed ? _self.passed : passed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ComplianceAreaCheck].
extension ComplianceAreaCheckPatterns on ComplianceAreaCheck {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ComplianceAreaCheck value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ComplianceAreaCheck() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ComplianceAreaCheck value)  $default,){
final _that = this;
switch (_that) {
case _ComplianceAreaCheck():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ComplianceAreaCheck value)?  $default,){
final _that = this;
switch (_that) {
case _ComplianceAreaCheck() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String check,  bool passed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ComplianceAreaCheck() when $default != null:
return $default(_that.check,_that.passed);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String check,  bool passed)  $default,) {final _that = this;
switch (_that) {
case _ComplianceAreaCheck():
return $default(_that.check,_that.passed);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String check,  bool passed)?  $default,) {final _that = this;
switch (_that) {
case _ComplianceAreaCheck() when $default != null:
return $default(_that.check,_that.passed);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ComplianceAreaCheck implements ComplianceAreaCheck {
  const _ComplianceAreaCheck({required this.check, required this.passed});
  factory _ComplianceAreaCheck.fromJson(Map<String, dynamic> json) => _$ComplianceAreaCheckFromJson(json);

@override final  String check;
@override final  bool passed;

/// Create a copy of ComplianceAreaCheck
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ComplianceAreaCheckCopyWith<_ComplianceAreaCheck> get copyWith => __$ComplianceAreaCheckCopyWithImpl<_ComplianceAreaCheck>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ComplianceAreaCheckToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ComplianceAreaCheck&&(identical(other.check, check) || other.check == check)&&(identical(other.passed, passed) || other.passed == passed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,check,passed);

@override
String toString() {
  return 'ComplianceAreaCheck(check: $check, passed: $passed)';
}


}

/// @nodoc
abstract mixin class _$ComplianceAreaCheckCopyWith<$Res> implements $ComplianceAreaCheckCopyWith<$Res> {
  factory _$ComplianceAreaCheckCopyWith(_ComplianceAreaCheck value, $Res Function(_ComplianceAreaCheck) _then) = __$ComplianceAreaCheckCopyWithImpl;
@override @useResult
$Res call({
 String check, bool passed
});




}
/// @nodoc
class __$ComplianceAreaCheckCopyWithImpl<$Res>
    implements _$ComplianceAreaCheckCopyWith<$Res> {
  __$ComplianceAreaCheckCopyWithImpl(this._self, this._then);

  final _ComplianceAreaCheck _self;
  final $Res Function(_ComplianceAreaCheck) _then;

/// Create a copy of ComplianceAreaCheck
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? check = null,Object? passed = null,}) {
  return _then(_ComplianceAreaCheck(
check: null == check ? _self.check : check // ignore: cast_nullable_to_non_nullable
as String,passed: null == passed ? _self.passed : passed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$ClientCredit {

 String get clientId; String get organizationId; String get analyzedAt; CreditCurrent get current; CreditRecommended get recommended; double get riskScore; PaymentHistory get paymentHistory;
/// Create a copy of ClientCredit
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClientCreditCopyWith<ClientCredit> get copyWith => _$ClientCreditCopyWithImpl<ClientCredit>(this as ClientCredit, _$identity);

  /// Serializes this ClientCredit to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClientCredit&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.organizationId, organizationId) || other.organizationId == organizationId)&&(identical(other.analyzedAt, analyzedAt) || other.analyzedAt == analyzedAt)&&(identical(other.current, current) || other.current == current)&&(identical(other.recommended, recommended) || other.recommended == recommended)&&(identical(other.riskScore, riskScore) || other.riskScore == riskScore)&&(identical(other.paymentHistory, paymentHistory) || other.paymentHistory == paymentHistory));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,clientId,organizationId,analyzedAt,current,recommended,riskScore,paymentHistory);

@override
String toString() {
  return 'ClientCredit(clientId: $clientId, organizationId: $organizationId, analyzedAt: $analyzedAt, current: $current, recommended: $recommended, riskScore: $riskScore, paymentHistory: $paymentHistory)';
}


}

/// @nodoc
abstract mixin class $ClientCreditCopyWith<$Res>  {
  factory $ClientCreditCopyWith(ClientCredit value, $Res Function(ClientCredit) _then) = _$ClientCreditCopyWithImpl;
@useResult
$Res call({
 String clientId, String organizationId, String analyzedAt, CreditCurrent current, CreditRecommended recommended, double riskScore, PaymentHistory paymentHistory
});


$CreditCurrentCopyWith<$Res> get current;$CreditRecommendedCopyWith<$Res> get recommended;$PaymentHistoryCopyWith<$Res> get paymentHistory;

}
/// @nodoc
class _$ClientCreditCopyWithImpl<$Res>
    implements $ClientCreditCopyWith<$Res> {
  _$ClientCreditCopyWithImpl(this._self, this._then);

  final ClientCredit _self;
  final $Res Function(ClientCredit) _then;

/// Create a copy of ClientCredit
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? clientId = null,Object? organizationId = null,Object? analyzedAt = null,Object? current = null,Object? recommended = null,Object? riskScore = null,Object? paymentHistory = null,}) {
  return _then(_self.copyWith(
clientId: null == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String,organizationId: null == organizationId ? _self.organizationId : organizationId // ignore: cast_nullable_to_non_nullable
as String,analyzedAt: null == analyzedAt ? _self.analyzedAt : analyzedAt // ignore: cast_nullable_to_non_nullable
as String,current: null == current ? _self.current : current // ignore: cast_nullable_to_non_nullable
as CreditCurrent,recommended: null == recommended ? _self.recommended : recommended // ignore: cast_nullable_to_non_nullable
as CreditRecommended,riskScore: null == riskScore ? _self.riskScore : riskScore // ignore: cast_nullable_to_non_nullable
as double,paymentHistory: null == paymentHistory ? _self.paymentHistory : paymentHistory // ignore: cast_nullable_to_non_nullable
as PaymentHistory,
  ));
}
/// Create a copy of ClientCredit
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CreditCurrentCopyWith<$Res> get current {
  
  return $CreditCurrentCopyWith<$Res>(_self.current, (value) {
    return _then(_self.copyWith(current: value));
  });
}/// Create a copy of ClientCredit
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CreditRecommendedCopyWith<$Res> get recommended {
  
  return $CreditRecommendedCopyWith<$Res>(_self.recommended, (value) {
    return _then(_self.copyWith(recommended: value));
  });
}/// Create a copy of ClientCredit
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaymentHistoryCopyWith<$Res> get paymentHistory {
  
  return $PaymentHistoryCopyWith<$Res>(_self.paymentHistory, (value) {
    return _then(_self.copyWith(paymentHistory: value));
  });
}
}


/// Adds pattern-matching-related methods to [ClientCredit].
extension ClientCreditPatterns on ClientCredit {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClientCredit value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClientCredit() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClientCredit value)  $default,){
final _that = this;
switch (_that) {
case _ClientCredit():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClientCredit value)?  $default,){
final _that = this;
switch (_that) {
case _ClientCredit() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String clientId,  String organizationId,  String analyzedAt,  CreditCurrent current,  CreditRecommended recommended,  double riskScore,  PaymentHistory paymentHistory)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClientCredit() when $default != null:
return $default(_that.clientId,_that.organizationId,_that.analyzedAt,_that.current,_that.recommended,_that.riskScore,_that.paymentHistory);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String clientId,  String organizationId,  String analyzedAt,  CreditCurrent current,  CreditRecommended recommended,  double riskScore,  PaymentHistory paymentHistory)  $default,) {final _that = this;
switch (_that) {
case _ClientCredit():
return $default(_that.clientId,_that.organizationId,_that.analyzedAt,_that.current,_that.recommended,_that.riskScore,_that.paymentHistory);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String clientId,  String organizationId,  String analyzedAt,  CreditCurrent current,  CreditRecommended recommended,  double riskScore,  PaymentHistory paymentHistory)?  $default,) {final _that = this;
switch (_that) {
case _ClientCredit() when $default != null:
return $default(_that.clientId,_that.organizationId,_that.analyzedAt,_that.current,_that.recommended,_that.riskScore,_that.paymentHistory);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ClientCredit implements ClientCredit {
  const _ClientCredit({required this.clientId, required this.organizationId, required this.analyzedAt, required this.current, required this.recommended, required this.riskScore, required this.paymentHistory});
  factory _ClientCredit.fromJson(Map<String, dynamic> json) => _$ClientCreditFromJson(json);

@override final  String clientId;
@override final  String organizationId;
@override final  String analyzedAt;
@override final  CreditCurrent current;
@override final  CreditRecommended recommended;
@override final  double riskScore;
@override final  PaymentHistory paymentHistory;

/// Create a copy of ClientCredit
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClientCreditCopyWith<_ClientCredit> get copyWith => __$ClientCreditCopyWithImpl<_ClientCredit>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClientCreditToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClientCredit&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.organizationId, organizationId) || other.organizationId == organizationId)&&(identical(other.analyzedAt, analyzedAt) || other.analyzedAt == analyzedAt)&&(identical(other.current, current) || other.current == current)&&(identical(other.recommended, recommended) || other.recommended == recommended)&&(identical(other.riskScore, riskScore) || other.riskScore == riskScore)&&(identical(other.paymentHistory, paymentHistory) || other.paymentHistory == paymentHistory));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,clientId,organizationId,analyzedAt,current,recommended,riskScore,paymentHistory);

@override
String toString() {
  return 'ClientCredit(clientId: $clientId, organizationId: $organizationId, analyzedAt: $analyzedAt, current: $current, recommended: $recommended, riskScore: $riskScore, paymentHistory: $paymentHistory)';
}


}

/// @nodoc
abstract mixin class _$ClientCreditCopyWith<$Res> implements $ClientCreditCopyWith<$Res> {
  factory _$ClientCreditCopyWith(_ClientCredit value, $Res Function(_ClientCredit) _then) = __$ClientCreditCopyWithImpl;
@override @useResult
$Res call({
 String clientId, String organizationId, String analyzedAt, CreditCurrent current, CreditRecommended recommended, double riskScore, PaymentHistory paymentHistory
});


@override $CreditCurrentCopyWith<$Res> get current;@override $CreditRecommendedCopyWith<$Res> get recommended;@override $PaymentHistoryCopyWith<$Res> get paymentHistory;

}
/// @nodoc
class __$ClientCreditCopyWithImpl<$Res>
    implements _$ClientCreditCopyWith<$Res> {
  __$ClientCreditCopyWithImpl(this._self, this._then);

  final _ClientCredit _self;
  final $Res Function(_ClientCredit) _then;

/// Create a copy of ClientCredit
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? clientId = null,Object? organizationId = null,Object? analyzedAt = null,Object? current = null,Object? recommended = null,Object? riskScore = null,Object? paymentHistory = null,}) {
  return _then(_ClientCredit(
clientId: null == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String,organizationId: null == organizationId ? _self.organizationId : organizationId // ignore: cast_nullable_to_non_nullable
as String,analyzedAt: null == analyzedAt ? _self.analyzedAt : analyzedAt // ignore: cast_nullable_to_non_nullable
as String,current: null == current ? _self.current : current // ignore: cast_nullable_to_non_nullable
as CreditCurrent,recommended: null == recommended ? _self.recommended : recommended // ignore: cast_nullable_to_non_nullable
as CreditRecommended,riskScore: null == riskScore ? _self.riskScore : riskScore // ignore: cast_nullable_to_non_nullable
as double,paymentHistory: null == paymentHistory ? _self.paymentHistory : paymentHistory // ignore: cast_nullable_to_non_nullable
as PaymentHistory,
  ));
}

/// Create a copy of ClientCredit
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CreditCurrentCopyWith<$Res> get current {
  
  return $CreditCurrentCopyWith<$Res>(_self.current, (value) {
    return _then(_self.copyWith(current: value));
  });
}/// Create a copy of ClientCredit
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CreditRecommendedCopyWith<$Res> get recommended {
  
  return $CreditRecommendedCopyWith<$Res>(_self.recommended, (value) {
    return _then(_self.copyWith(recommended: value));
  });
}/// Create a copy of ClientCredit
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaymentHistoryCopyWith<$Res> get paymentHistory {
  
  return $PaymentHistoryCopyWith<$Res>(_self.paymentHistory, (value) {
    return _then(_self.copyWith(paymentHistory: value));
  });
}
}


/// @nodoc
mixin _$CreditCurrent {

 double get limit; double get utilized; double get available; double get utilizationRate;
/// Create a copy of CreditCurrent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreditCurrentCopyWith<CreditCurrent> get copyWith => _$CreditCurrentCopyWithImpl<CreditCurrent>(this as CreditCurrent, _$identity);

  /// Serializes this CreditCurrent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreditCurrent&&(identical(other.limit, limit) || other.limit == limit)&&(identical(other.utilized, utilized) || other.utilized == utilized)&&(identical(other.available, available) || other.available == available)&&(identical(other.utilizationRate, utilizationRate) || other.utilizationRate == utilizationRate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,limit,utilized,available,utilizationRate);

@override
String toString() {
  return 'CreditCurrent(limit: $limit, utilized: $utilized, available: $available, utilizationRate: $utilizationRate)';
}


}

/// @nodoc
abstract mixin class $CreditCurrentCopyWith<$Res>  {
  factory $CreditCurrentCopyWith(CreditCurrent value, $Res Function(CreditCurrent) _then) = _$CreditCurrentCopyWithImpl;
@useResult
$Res call({
 double limit, double utilized, double available, double utilizationRate
});




}
/// @nodoc
class _$CreditCurrentCopyWithImpl<$Res>
    implements $CreditCurrentCopyWith<$Res> {
  _$CreditCurrentCopyWithImpl(this._self, this._then);

  final CreditCurrent _self;
  final $Res Function(CreditCurrent) _then;

/// Create a copy of CreditCurrent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? limit = null,Object? utilized = null,Object? available = null,Object? utilizationRate = null,}) {
  return _then(_self.copyWith(
limit: null == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as double,utilized: null == utilized ? _self.utilized : utilized // ignore: cast_nullable_to_non_nullable
as double,available: null == available ? _self.available : available // ignore: cast_nullable_to_non_nullable
as double,utilizationRate: null == utilizationRate ? _self.utilizationRate : utilizationRate // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [CreditCurrent].
extension CreditCurrentPatterns on CreditCurrent {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreditCurrent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreditCurrent() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreditCurrent value)  $default,){
final _that = this;
switch (_that) {
case _CreditCurrent():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreditCurrent value)?  $default,){
final _that = this;
switch (_that) {
case _CreditCurrent() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double limit,  double utilized,  double available,  double utilizationRate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreditCurrent() when $default != null:
return $default(_that.limit,_that.utilized,_that.available,_that.utilizationRate);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double limit,  double utilized,  double available,  double utilizationRate)  $default,) {final _that = this;
switch (_that) {
case _CreditCurrent():
return $default(_that.limit,_that.utilized,_that.available,_that.utilizationRate);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double limit,  double utilized,  double available,  double utilizationRate)?  $default,) {final _that = this;
switch (_that) {
case _CreditCurrent() when $default != null:
return $default(_that.limit,_that.utilized,_that.available,_that.utilizationRate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreditCurrent implements CreditCurrent {
  const _CreditCurrent({required this.limit, required this.utilized, required this.available, required this.utilizationRate});
  factory _CreditCurrent.fromJson(Map<String, dynamic> json) => _$CreditCurrentFromJson(json);

@override final  double limit;
@override final  double utilized;
@override final  double available;
@override final  double utilizationRate;

/// Create a copy of CreditCurrent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreditCurrentCopyWith<_CreditCurrent> get copyWith => __$CreditCurrentCopyWithImpl<_CreditCurrent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreditCurrentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreditCurrent&&(identical(other.limit, limit) || other.limit == limit)&&(identical(other.utilized, utilized) || other.utilized == utilized)&&(identical(other.available, available) || other.available == available)&&(identical(other.utilizationRate, utilizationRate) || other.utilizationRate == utilizationRate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,limit,utilized,available,utilizationRate);

@override
String toString() {
  return 'CreditCurrent(limit: $limit, utilized: $utilized, available: $available, utilizationRate: $utilizationRate)';
}


}

/// @nodoc
abstract mixin class _$CreditCurrentCopyWith<$Res> implements $CreditCurrentCopyWith<$Res> {
  factory _$CreditCurrentCopyWith(_CreditCurrent value, $Res Function(_CreditCurrent) _then) = __$CreditCurrentCopyWithImpl;
@override @useResult
$Res call({
 double limit, double utilized, double available, double utilizationRate
});




}
/// @nodoc
class __$CreditCurrentCopyWithImpl<$Res>
    implements _$CreditCurrentCopyWith<$Res> {
  __$CreditCurrentCopyWithImpl(this._self, this._then);

  final _CreditCurrent _self;
  final $Res Function(_CreditCurrent) _then;

/// Create a copy of CreditCurrent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? limit = null,Object? utilized = null,Object? available = null,Object? utilizationRate = null,}) {
  return _then(_CreditCurrent(
limit: null == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as double,utilized: null == utilized ? _self.utilized : utilized // ignore: cast_nullable_to_non_nullable
as double,available: null == available ? _self.available : available // ignore: cast_nullable_to_non_nullable
as double,utilizationRate: null == utilizationRate ? _self.utilizationRate : utilizationRate // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$CreditRecommended {

 double get limit; String get reasoning; double get confidence;
/// Create a copy of CreditRecommended
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreditRecommendedCopyWith<CreditRecommended> get copyWith => _$CreditRecommendedCopyWithImpl<CreditRecommended>(this as CreditRecommended, _$identity);

  /// Serializes this CreditRecommended to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreditRecommended&&(identical(other.limit, limit) || other.limit == limit)&&(identical(other.reasoning, reasoning) || other.reasoning == reasoning)&&(identical(other.confidence, confidence) || other.confidence == confidence));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,limit,reasoning,confidence);

@override
String toString() {
  return 'CreditRecommended(limit: $limit, reasoning: $reasoning, confidence: $confidence)';
}


}

/// @nodoc
abstract mixin class $CreditRecommendedCopyWith<$Res>  {
  factory $CreditRecommendedCopyWith(CreditRecommended value, $Res Function(CreditRecommended) _then) = _$CreditRecommendedCopyWithImpl;
@useResult
$Res call({
 double limit, String reasoning, double confidence
});




}
/// @nodoc
class _$CreditRecommendedCopyWithImpl<$Res>
    implements $CreditRecommendedCopyWith<$Res> {
  _$CreditRecommendedCopyWithImpl(this._self, this._then);

  final CreditRecommended _self;
  final $Res Function(CreditRecommended) _then;

/// Create a copy of CreditRecommended
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? limit = null,Object? reasoning = null,Object? confidence = null,}) {
  return _then(_self.copyWith(
limit: null == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as double,reasoning: null == reasoning ? _self.reasoning : reasoning // ignore: cast_nullable_to_non_nullable
as String,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [CreditRecommended].
extension CreditRecommendedPatterns on CreditRecommended {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreditRecommended value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreditRecommended() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreditRecommended value)  $default,){
final _that = this;
switch (_that) {
case _CreditRecommended():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreditRecommended value)?  $default,){
final _that = this;
switch (_that) {
case _CreditRecommended() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double limit,  String reasoning,  double confidence)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreditRecommended() when $default != null:
return $default(_that.limit,_that.reasoning,_that.confidence);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double limit,  String reasoning,  double confidence)  $default,) {final _that = this;
switch (_that) {
case _CreditRecommended():
return $default(_that.limit,_that.reasoning,_that.confidence);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double limit,  String reasoning,  double confidence)?  $default,) {final _that = this;
switch (_that) {
case _CreditRecommended() when $default != null:
return $default(_that.limit,_that.reasoning,_that.confidence);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreditRecommended implements CreditRecommended {
  const _CreditRecommended({required this.limit, required this.reasoning, required this.confidence});
  factory _CreditRecommended.fromJson(Map<String, dynamic> json) => _$CreditRecommendedFromJson(json);

@override final  double limit;
@override final  String reasoning;
@override final  double confidence;

/// Create a copy of CreditRecommended
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreditRecommendedCopyWith<_CreditRecommended> get copyWith => __$CreditRecommendedCopyWithImpl<_CreditRecommended>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreditRecommendedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreditRecommended&&(identical(other.limit, limit) || other.limit == limit)&&(identical(other.reasoning, reasoning) || other.reasoning == reasoning)&&(identical(other.confidence, confidence) || other.confidence == confidence));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,limit,reasoning,confidence);

@override
String toString() {
  return 'CreditRecommended(limit: $limit, reasoning: $reasoning, confidence: $confidence)';
}


}

/// @nodoc
abstract mixin class _$CreditRecommendedCopyWith<$Res> implements $CreditRecommendedCopyWith<$Res> {
  factory _$CreditRecommendedCopyWith(_CreditRecommended value, $Res Function(_CreditRecommended) _then) = __$CreditRecommendedCopyWithImpl;
@override @useResult
$Res call({
 double limit, String reasoning, double confidence
});




}
/// @nodoc
class __$CreditRecommendedCopyWithImpl<$Res>
    implements _$CreditRecommendedCopyWith<$Res> {
  __$CreditRecommendedCopyWithImpl(this._self, this._then);

  final _CreditRecommended _self;
  final $Res Function(_CreditRecommended) _then;

/// Create a copy of CreditRecommended
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? limit = null,Object? reasoning = null,Object? confidence = null,}) {
  return _then(_CreditRecommended(
limit: null == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as double,reasoning: null == reasoning ? _self.reasoning : reasoning // ignore: cast_nullable_to_non_nullable
as String,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$PaymentHistory {

 int get onTime; int get late; int get averageDaysLate;
/// Create a copy of PaymentHistory
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentHistoryCopyWith<PaymentHistory> get copyWith => _$PaymentHistoryCopyWithImpl<PaymentHistory>(this as PaymentHistory, _$identity);

  /// Serializes this PaymentHistory to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentHistory&&(identical(other.onTime, onTime) || other.onTime == onTime)&&(identical(other.late, late) || other.late == late)&&(identical(other.averageDaysLate, averageDaysLate) || other.averageDaysLate == averageDaysLate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,onTime,late,averageDaysLate);

@override
String toString() {
  return 'PaymentHistory(onTime: $onTime, late: $late, averageDaysLate: $averageDaysLate)';
}


}

/// @nodoc
abstract mixin class $PaymentHistoryCopyWith<$Res>  {
  factory $PaymentHistoryCopyWith(PaymentHistory value, $Res Function(PaymentHistory) _then) = _$PaymentHistoryCopyWithImpl;
@useResult
$Res call({
 int onTime, int late, int averageDaysLate
});




}
/// @nodoc
class _$PaymentHistoryCopyWithImpl<$Res>
    implements $PaymentHistoryCopyWith<$Res> {
  _$PaymentHistoryCopyWithImpl(this._self, this._then);

  final PaymentHistory _self;
  final $Res Function(PaymentHistory) _then;

/// Create a copy of PaymentHistory
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? onTime = null,Object? late = null,Object? averageDaysLate = null,}) {
  return _then(_self.copyWith(
onTime: null == onTime ? _self.onTime : onTime // ignore: cast_nullable_to_non_nullable
as int,late: null == late ? _self.late : late // ignore: cast_nullable_to_non_nullable
as int,averageDaysLate: null == averageDaysLate ? _self.averageDaysLate : averageDaysLate // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PaymentHistory].
extension PaymentHistoryPatterns on PaymentHistory {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaymentHistory value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaymentHistory() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaymentHistory value)  $default,){
final _that = this;
switch (_that) {
case _PaymentHistory():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaymentHistory value)?  $default,){
final _that = this;
switch (_that) {
case _PaymentHistory() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int onTime,  int late,  int averageDaysLate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaymentHistory() when $default != null:
return $default(_that.onTime,_that.late,_that.averageDaysLate);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int onTime,  int late,  int averageDaysLate)  $default,) {final _that = this;
switch (_that) {
case _PaymentHistory():
return $default(_that.onTime,_that.late,_that.averageDaysLate);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int onTime,  int late,  int averageDaysLate)?  $default,) {final _that = this;
switch (_that) {
case _PaymentHistory() when $default != null:
return $default(_that.onTime,_that.late,_that.averageDaysLate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PaymentHistory implements PaymentHistory {
  const _PaymentHistory({required this.onTime, required this.late, required this.averageDaysLate});
  factory _PaymentHistory.fromJson(Map<String, dynamic> json) => _$PaymentHistoryFromJson(json);

@override final  int onTime;
@override final  int late;
@override final  int averageDaysLate;

/// Create a copy of PaymentHistory
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentHistoryCopyWith<_PaymentHistory> get copyWith => __$PaymentHistoryCopyWithImpl<_PaymentHistory>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaymentHistoryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentHistory&&(identical(other.onTime, onTime) || other.onTime == onTime)&&(identical(other.late, late) || other.late == late)&&(identical(other.averageDaysLate, averageDaysLate) || other.averageDaysLate == averageDaysLate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,onTime,late,averageDaysLate);

@override
String toString() {
  return 'PaymentHistory(onTime: $onTime, late: $late, averageDaysLate: $averageDaysLate)';
}


}

/// @nodoc
abstract mixin class _$PaymentHistoryCopyWith<$Res> implements $PaymentHistoryCopyWith<$Res> {
  factory _$PaymentHistoryCopyWith(_PaymentHistory value, $Res Function(_PaymentHistory) _then) = __$PaymentHistoryCopyWithImpl;
@override @useResult
$Res call({
 int onTime, int late, int averageDaysLate
});




}
/// @nodoc
class __$PaymentHistoryCopyWithImpl<$Res>
    implements _$PaymentHistoryCopyWith<$Res> {
  __$PaymentHistoryCopyWithImpl(this._self, this._then);

  final _PaymentHistory _self;
  final $Res Function(_PaymentHistory) _then;

/// Create a copy of PaymentHistory
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? onTime = null,Object? late = null,Object? averageDaysLate = null,}) {
  return _then(_PaymentHistory(
onTime: null == onTime ? _self.onTime : onTime // ignore: cast_nullable_to_non_nullable
as int,late: null == late ? _self.late : late // ignore: cast_nullable_to_non_nullable
as int,averageDaysLate: null == averageDaysLate ? _self.averageDaysLate : averageDaysLate // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$ClientLifetimeValue {

 String get clientId; String get organizationId; String get calculatedAt; CLVCurrent get current; CLVPredicted get predicted; String get segments; List<UpsellOpportunity> get opportunities;
/// Create a copy of ClientLifetimeValue
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClientLifetimeValueCopyWith<ClientLifetimeValue> get copyWith => _$ClientLifetimeValueCopyWithImpl<ClientLifetimeValue>(this as ClientLifetimeValue, _$identity);

  /// Serializes this ClientLifetimeValue to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClientLifetimeValue&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.organizationId, organizationId) || other.organizationId == organizationId)&&(identical(other.calculatedAt, calculatedAt) || other.calculatedAt == calculatedAt)&&(identical(other.current, current) || other.current == current)&&(identical(other.predicted, predicted) || other.predicted == predicted)&&(identical(other.segments, segments) || other.segments == segments)&&const DeepCollectionEquality().equals(other.opportunities, opportunities));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,clientId,organizationId,calculatedAt,current,predicted,segments,const DeepCollectionEquality().hash(opportunities));

@override
String toString() {
  return 'ClientLifetimeValue(clientId: $clientId, organizationId: $organizationId, calculatedAt: $calculatedAt, current: $current, predicted: $predicted, segments: $segments, opportunities: $opportunities)';
}


}

/// @nodoc
abstract mixin class $ClientLifetimeValueCopyWith<$Res>  {
  factory $ClientLifetimeValueCopyWith(ClientLifetimeValue value, $Res Function(ClientLifetimeValue) _then) = _$ClientLifetimeValueCopyWithImpl;
@useResult
$Res call({
 String clientId, String organizationId, String calculatedAt, CLVCurrent current, CLVPredicted predicted, String segments, List<UpsellOpportunity> opportunities
});


$CLVCurrentCopyWith<$Res> get current;$CLVPredictedCopyWith<$Res> get predicted;

}
/// @nodoc
class _$ClientLifetimeValueCopyWithImpl<$Res>
    implements $ClientLifetimeValueCopyWith<$Res> {
  _$ClientLifetimeValueCopyWithImpl(this._self, this._then);

  final ClientLifetimeValue _self;
  final $Res Function(ClientLifetimeValue) _then;

/// Create a copy of ClientLifetimeValue
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? clientId = null,Object? organizationId = null,Object? calculatedAt = null,Object? current = null,Object? predicted = null,Object? segments = null,Object? opportunities = null,}) {
  return _then(_self.copyWith(
clientId: null == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String,organizationId: null == organizationId ? _self.organizationId : organizationId // ignore: cast_nullable_to_non_nullable
as String,calculatedAt: null == calculatedAt ? _self.calculatedAt : calculatedAt // ignore: cast_nullable_to_non_nullable
as String,current: null == current ? _self.current : current // ignore: cast_nullable_to_non_nullable
as CLVCurrent,predicted: null == predicted ? _self.predicted : predicted // ignore: cast_nullable_to_non_nullable
as CLVPredicted,segments: null == segments ? _self.segments : segments // ignore: cast_nullable_to_non_nullable
as String,opportunities: null == opportunities ? _self.opportunities : opportunities // ignore: cast_nullable_to_non_nullable
as List<UpsellOpportunity>,
  ));
}
/// Create a copy of ClientLifetimeValue
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CLVCurrentCopyWith<$Res> get current {
  
  return $CLVCurrentCopyWith<$Res>(_self.current, (value) {
    return _then(_self.copyWith(current: value));
  });
}/// Create a copy of ClientLifetimeValue
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CLVPredictedCopyWith<$Res> get predicted {
  
  return $CLVPredictedCopyWith<$Res>(_self.predicted, (value) {
    return _then(_self.copyWith(predicted: value));
  });
}
}


/// Adds pattern-matching-related methods to [ClientLifetimeValue].
extension ClientLifetimeValuePatterns on ClientLifetimeValue {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClientLifetimeValue value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClientLifetimeValue() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClientLifetimeValue value)  $default,){
final _that = this;
switch (_that) {
case _ClientLifetimeValue():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClientLifetimeValue value)?  $default,){
final _that = this;
switch (_that) {
case _ClientLifetimeValue() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String clientId,  String organizationId,  String calculatedAt,  CLVCurrent current,  CLVPredicted predicted,  String segments,  List<UpsellOpportunity> opportunities)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClientLifetimeValue() when $default != null:
return $default(_that.clientId,_that.organizationId,_that.calculatedAt,_that.current,_that.predicted,_that.segments,_that.opportunities);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String clientId,  String organizationId,  String calculatedAt,  CLVCurrent current,  CLVPredicted predicted,  String segments,  List<UpsellOpportunity> opportunities)  $default,) {final _that = this;
switch (_that) {
case _ClientLifetimeValue():
return $default(_that.clientId,_that.organizationId,_that.calculatedAt,_that.current,_that.predicted,_that.segments,_that.opportunities);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String clientId,  String organizationId,  String calculatedAt,  CLVCurrent current,  CLVPredicted predicted,  String segments,  List<UpsellOpportunity> opportunities)?  $default,) {final _that = this;
switch (_that) {
case _ClientLifetimeValue() when $default != null:
return $default(_that.clientId,_that.organizationId,_that.calculatedAt,_that.current,_that.predicted,_that.segments,_that.opportunities);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ClientLifetimeValue implements ClientLifetimeValue {
  const _ClientLifetimeValue({required this.clientId, required this.organizationId, required this.calculatedAt, required this.current, required this.predicted, required this.segments, required final  List<UpsellOpportunity> opportunities}): _opportunities = opportunities;
  factory _ClientLifetimeValue.fromJson(Map<String, dynamic> json) => _$ClientLifetimeValueFromJson(json);

@override final  String clientId;
@override final  String organizationId;
@override final  String calculatedAt;
@override final  CLVCurrent current;
@override final  CLVPredicted predicted;
@override final  String segments;
 final  List<UpsellOpportunity> _opportunities;
@override List<UpsellOpportunity> get opportunities {
  if (_opportunities is EqualUnmodifiableListView) return _opportunities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_opportunities);
}


/// Create a copy of ClientLifetimeValue
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClientLifetimeValueCopyWith<_ClientLifetimeValue> get copyWith => __$ClientLifetimeValueCopyWithImpl<_ClientLifetimeValue>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClientLifetimeValueToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClientLifetimeValue&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.organizationId, organizationId) || other.organizationId == organizationId)&&(identical(other.calculatedAt, calculatedAt) || other.calculatedAt == calculatedAt)&&(identical(other.current, current) || other.current == current)&&(identical(other.predicted, predicted) || other.predicted == predicted)&&(identical(other.segments, segments) || other.segments == segments)&&const DeepCollectionEquality().equals(other._opportunities, _opportunities));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,clientId,organizationId,calculatedAt,current,predicted,segments,const DeepCollectionEquality().hash(_opportunities));

@override
String toString() {
  return 'ClientLifetimeValue(clientId: $clientId, organizationId: $organizationId, calculatedAt: $calculatedAt, current: $current, predicted: $predicted, segments: $segments, opportunities: $opportunities)';
}


}

/// @nodoc
abstract mixin class _$ClientLifetimeValueCopyWith<$Res> implements $ClientLifetimeValueCopyWith<$Res> {
  factory _$ClientLifetimeValueCopyWith(_ClientLifetimeValue value, $Res Function(_ClientLifetimeValue) _then) = __$ClientLifetimeValueCopyWithImpl;
@override @useResult
$Res call({
 String clientId, String organizationId, String calculatedAt, CLVCurrent current, CLVPredicted predicted, String segments, List<UpsellOpportunity> opportunities
});


@override $CLVCurrentCopyWith<$Res> get current;@override $CLVPredictedCopyWith<$Res> get predicted;

}
/// @nodoc
class __$ClientLifetimeValueCopyWithImpl<$Res>
    implements _$ClientLifetimeValueCopyWith<$Res> {
  __$ClientLifetimeValueCopyWithImpl(this._self, this._then);

  final _ClientLifetimeValue _self;
  final $Res Function(_ClientLifetimeValue) _then;

/// Create a copy of ClientLifetimeValue
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? clientId = null,Object? organizationId = null,Object? calculatedAt = null,Object? current = null,Object? predicted = null,Object? segments = null,Object? opportunities = null,}) {
  return _then(_ClientLifetimeValue(
clientId: null == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String,organizationId: null == organizationId ? _self.organizationId : organizationId // ignore: cast_nullable_to_non_nullable
as String,calculatedAt: null == calculatedAt ? _self.calculatedAt : calculatedAt // ignore: cast_nullable_to_non_nullable
as String,current: null == current ? _self.current : current // ignore: cast_nullable_to_non_nullable
as CLVCurrent,predicted: null == predicted ? _self.predicted : predicted // ignore: cast_nullable_to_non_nullable
as CLVPredicted,segments: null == segments ? _self.segments : segments // ignore: cast_nullable_to_non_nullable
as String,opportunities: null == opportunities ? _self._opportunities : opportunities // ignore: cast_nullable_to_non_nullable
as List<UpsellOpportunity>,
  ));
}

/// Create a copy of ClientLifetimeValue
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CLVCurrentCopyWith<$Res> get current {
  
  return $CLVCurrentCopyWith<$Res>(_self.current, (value) {
    return _then(_self.copyWith(current: value));
  });
}/// Create a copy of ClientLifetimeValue
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CLVPredictedCopyWith<$Res> get predicted {
  
  return $CLVPredictedCopyWith<$Res>(_self.predicted, (value) {
    return _then(_self.copyWith(predicted: value));
  });
}
}


/// @nodoc
mixin _$CLVCurrent {

 double get totalRevenue; double get totalProfit; int get tenure;
/// Create a copy of CLVCurrent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CLVCurrentCopyWith<CLVCurrent> get copyWith => _$CLVCurrentCopyWithImpl<CLVCurrent>(this as CLVCurrent, _$identity);

  /// Serializes this CLVCurrent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CLVCurrent&&(identical(other.totalRevenue, totalRevenue) || other.totalRevenue == totalRevenue)&&(identical(other.totalProfit, totalProfit) || other.totalProfit == totalProfit)&&(identical(other.tenure, tenure) || other.tenure == tenure));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalRevenue,totalProfit,tenure);

@override
String toString() {
  return 'CLVCurrent(totalRevenue: $totalRevenue, totalProfit: $totalProfit, tenure: $tenure)';
}


}

/// @nodoc
abstract mixin class $CLVCurrentCopyWith<$Res>  {
  factory $CLVCurrentCopyWith(CLVCurrent value, $Res Function(CLVCurrent) _then) = _$CLVCurrentCopyWithImpl;
@useResult
$Res call({
 double totalRevenue, double totalProfit, int tenure
});




}
/// @nodoc
class _$CLVCurrentCopyWithImpl<$Res>
    implements $CLVCurrentCopyWith<$Res> {
  _$CLVCurrentCopyWithImpl(this._self, this._then);

  final CLVCurrent _self;
  final $Res Function(CLVCurrent) _then;

/// Create a copy of CLVCurrent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalRevenue = null,Object? totalProfit = null,Object? tenure = null,}) {
  return _then(_self.copyWith(
totalRevenue: null == totalRevenue ? _self.totalRevenue : totalRevenue // ignore: cast_nullable_to_non_nullable
as double,totalProfit: null == totalProfit ? _self.totalProfit : totalProfit // ignore: cast_nullable_to_non_nullable
as double,tenure: null == tenure ? _self.tenure : tenure // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CLVCurrent].
extension CLVCurrentPatterns on CLVCurrent {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CLVCurrent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CLVCurrent() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CLVCurrent value)  $default,){
final _that = this;
switch (_that) {
case _CLVCurrent():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CLVCurrent value)?  $default,){
final _that = this;
switch (_that) {
case _CLVCurrent() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double totalRevenue,  double totalProfit,  int tenure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CLVCurrent() when $default != null:
return $default(_that.totalRevenue,_that.totalProfit,_that.tenure);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double totalRevenue,  double totalProfit,  int tenure)  $default,) {final _that = this;
switch (_that) {
case _CLVCurrent():
return $default(_that.totalRevenue,_that.totalProfit,_that.tenure);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double totalRevenue,  double totalProfit,  int tenure)?  $default,) {final _that = this;
switch (_that) {
case _CLVCurrent() when $default != null:
return $default(_that.totalRevenue,_that.totalProfit,_that.tenure);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CLVCurrent implements CLVCurrent {
  const _CLVCurrent({required this.totalRevenue, required this.totalProfit, required this.tenure});
  factory _CLVCurrent.fromJson(Map<String, dynamic> json) => _$CLVCurrentFromJson(json);

@override final  double totalRevenue;
@override final  double totalProfit;
@override final  int tenure;

/// Create a copy of CLVCurrent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CLVCurrentCopyWith<_CLVCurrent> get copyWith => __$CLVCurrentCopyWithImpl<_CLVCurrent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CLVCurrentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CLVCurrent&&(identical(other.totalRevenue, totalRevenue) || other.totalRevenue == totalRevenue)&&(identical(other.totalProfit, totalProfit) || other.totalProfit == totalProfit)&&(identical(other.tenure, tenure) || other.tenure == tenure));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalRevenue,totalProfit,tenure);

@override
String toString() {
  return 'CLVCurrent(totalRevenue: $totalRevenue, totalProfit: $totalProfit, tenure: $tenure)';
}


}

/// @nodoc
abstract mixin class _$CLVCurrentCopyWith<$Res> implements $CLVCurrentCopyWith<$Res> {
  factory _$CLVCurrentCopyWith(_CLVCurrent value, $Res Function(_CLVCurrent) _then) = __$CLVCurrentCopyWithImpl;
@override @useResult
$Res call({
 double totalRevenue, double totalProfit, int tenure
});




}
/// @nodoc
class __$CLVCurrentCopyWithImpl<$Res>
    implements _$CLVCurrentCopyWith<$Res> {
  __$CLVCurrentCopyWithImpl(this._self, this._then);

  final _CLVCurrent _self;
  final $Res Function(_CLVCurrent) _then;

/// Create a copy of CLVCurrent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalRevenue = null,Object? totalProfit = null,Object? tenure = null,}) {
  return _then(_CLVCurrent(
totalRevenue: null == totalRevenue ? _self.totalRevenue : totalRevenue // ignore: cast_nullable_to_non_nullable
as double,totalProfit: null == totalProfit ? _self.totalProfit : totalProfit // ignore: cast_nullable_to_non_nullable
as double,tenure: null == tenure ? _self.tenure : tenure // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$CLVPredicted {

 double get lifetimeValue; double get remainingValue; double get churnProbability; int get expectedTenure;
/// Create a copy of CLVPredicted
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CLVPredictedCopyWith<CLVPredicted> get copyWith => _$CLVPredictedCopyWithImpl<CLVPredicted>(this as CLVPredicted, _$identity);

  /// Serializes this CLVPredicted to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CLVPredicted&&(identical(other.lifetimeValue, lifetimeValue) || other.lifetimeValue == lifetimeValue)&&(identical(other.remainingValue, remainingValue) || other.remainingValue == remainingValue)&&(identical(other.churnProbability, churnProbability) || other.churnProbability == churnProbability)&&(identical(other.expectedTenure, expectedTenure) || other.expectedTenure == expectedTenure));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,lifetimeValue,remainingValue,churnProbability,expectedTenure);

@override
String toString() {
  return 'CLVPredicted(lifetimeValue: $lifetimeValue, remainingValue: $remainingValue, churnProbability: $churnProbability, expectedTenure: $expectedTenure)';
}


}

/// @nodoc
abstract mixin class $CLVPredictedCopyWith<$Res>  {
  factory $CLVPredictedCopyWith(CLVPredicted value, $Res Function(CLVPredicted) _then) = _$CLVPredictedCopyWithImpl;
@useResult
$Res call({
 double lifetimeValue, double remainingValue, double churnProbability, int expectedTenure
});




}
/// @nodoc
class _$CLVPredictedCopyWithImpl<$Res>
    implements $CLVPredictedCopyWith<$Res> {
  _$CLVPredictedCopyWithImpl(this._self, this._then);

  final CLVPredicted _self;
  final $Res Function(CLVPredicted) _then;

/// Create a copy of CLVPredicted
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? lifetimeValue = null,Object? remainingValue = null,Object? churnProbability = null,Object? expectedTenure = null,}) {
  return _then(_self.copyWith(
lifetimeValue: null == lifetimeValue ? _self.lifetimeValue : lifetimeValue // ignore: cast_nullable_to_non_nullable
as double,remainingValue: null == remainingValue ? _self.remainingValue : remainingValue // ignore: cast_nullable_to_non_nullable
as double,churnProbability: null == churnProbability ? _self.churnProbability : churnProbability // ignore: cast_nullable_to_non_nullable
as double,expectedTenure: null == expectedTenure ? _self.expectedTenure : expectedTenure // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CLVPredicted].
extension CLVPredictedPatterns on CLVPredicted {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CLVPredicted value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CLVPredicted() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CLVPredicted value)  $default,){
final _that = this;
switch (_that) {
case _CLVPredicted():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CLVPredicted value)?  $default,){
final _that = this;
switch (_that) {
case _CLVPredicted() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double lifetimeValue,  double remainingValue,  double churnProbability,  int expectedTenure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CLVPredicted() when $default != null:
return $default(_that.lifetimeValue,_that.remainingValue,_that.churnProbability,_that.expectedTenure);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double lifetimeValue,  double remainingValue,  double churnProbability,  int expectedTenure)  $default,) {final _that = this;
switch (_that) {
case _CLVPredicted():
return $default(_that.lifetimeValue,_that.remainingValue,_that.churnProbability,_that.expectedTenure);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double lifetimeValue,  double remainingValue,  double churnProbability,  int expectedTenure)?  $default,) {final _that = this;
switch (_that) {
case _CLVPredicted() when $default != null:
return $default(_that.lifetimeValue,_that.remainingValue,_that.churnProbability,_that.expectedTenure);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CLVPredicted implements CLVPredicted {
  const _CLVPredicted({required this.lifetimeValue, required this.remainingValue, required this.churnProbability, required this.expectedTenure});
  factory _CLVPredicted.fromJson(Map<String, dynamic> json) => _$CLVPredictedFromJson(json);

@override final  double lifetimeValue;
@override final  double remainingValue;
@override final  double churnProbability;
@override final  int expectedTenure;

/// Create a copy of CLVPredicted
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CLVPredictedCopyWith<_CLVPredicted> get copyWith => __$CLVPredictedCopyWithImpl<_CLVPredicted>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CLVPredictedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CLVPredicted&&(identical(other.lifetimeValue, lifetimeValue) || other.lifetimeValue == lifetimeValue)&&(identical(other.remainingValue, remainingValue) || other.remainingValue == remainingValue)&&(identical(other.churnProbability, churnProbability) || other.churnProbability == churnProbability)&&(identical(other.expectedTenure, expectedTenure) || other.expectedTenure == expectedTenure));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,lifetimeValue,remainingValue,churnProbability,expectedTenure);

@override
String toString() {
  return 'CLVPredicted(lifetimeValue: $lifetimeValue, remainingValue: $remainingValue, churnProbability: $churnProbability, expectedTenure: $expectedTenure)';
}


}

/// @nodoc
abstract mixin class _$CLVPredictedCopyWith<$Res> implements $CLVPredictedCopyWith<$Res> {
  factory _$CLVPredictedCopyWith(_CLVPredicted value, $Res Function(_CLVPredicted) _then) = __$CLVPredictedCopyWithImpl;
@override @useResult
$Res call({
 double lifetimeValue, double remainingValue, double churnProbability, int expectedTenure
});




}
/// @nodoc
class __$CLVPredictedCopyWithImpl<$Res>
    implements _$CLVPredictedCopyWith<$Res> {
  __$CLVPredictedCopyWithImpl(this._self, this._then);

  final _CLVPredicted _self;
  final $Res Function(_CLVPredicted) _then;

/// Create a copy of CLVPredicted
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? lifetimeValue = null,Object? remainingValue = null,Object? churnProbability = null,Object? expectedTenure = null,}) {
  return _then(_CLVPredicted(
lifetimeValue: null == lifetimeValue ? _self.lifetimeValue : lifetimeValue // ignore: cast_nullable_to_non_nullable
as double,remainingValue: null == remainingValue ? _self.remainingValue : remainingValue // ignore: cast_nullable_to_non_nullable
as double,churnProbability: null == churnProbability ? _self.churnProbability : churnProbability // ignore: cast_nullable_to_non_nullable
as double,expectedTenure: null == expectedTenure ? _self.expectedTenure : expectedTenure // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$UpsellOpportunity {

 String get opportunity; double get potential;
/// Create a copy of UpsellOpportunity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpsellOpportunityCopyWith<UpsellOpportunity> get copyWith => _$UpsellOpportunityCopyWithImpl<UpsellOpportunity>(this as UpsellOpportunity, _$identity);

  /// Serializes this UpsellOpportunity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpsellOpportunity&&(identical(other.opportunity, opportunity) || other.opportunity == opportunity)&&(identical(other.potential, potential) || other.potential == potential));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,opportunity,potential);

@override
String toString() {
  return 'UpsellOpportunity(opportunity: $opportunity, potential: $potential)';
}


}

/// @nodoc
abstract mixin class $UpsellOpportunityCopyWith<$Res>  {
  factory $UpsellOpportunityCopyWith(UpsellOpportunity value, $Res Function(UpsellOpportunity) _then) = _$UpsellOpportunityCopyWithImpl;
@useResult
$Res call({
 String opportunity, double potential
});




}
/// @nodoc
class _$UpsellOpportunityCopyWithImpl<$Res>
    implements $UpsellOpportunityCopyWith<$Res> {
  _$UpsellOpportunityCopyWithImpl(this._self, this._then);

  final UpsellOpportunity _self;
  final $Res Function(UpsellOpportunity) _then;

/// Create a copy of UpsellOpportunity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? opportunity = null,Object? potential = null,}) {
  return _then(_self.copyWith(
opportunity: null == opportunity ? _self.opportunity : opportunity // ignore: cast_nullable_to_non_nullable
as String,potential: null == potential ? _self.potential : potential // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [UpsellOpportunity].
extension UpsellOpportunityPatterns on UpsellOpportunity {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UpsellOpportunity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UpsellOpportunity() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UpsellOpportunity value)  $default,){
final _that = this;
switch (_that) {
case _UpsellOpportunity():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UpsellOpportunity value)?  $default,){
final _that = this;
switch (_that) {
case _UpsellOpportunity() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String opportunity,  double potential)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UpsellOpportunity() when $default != null:
return $default(_that.opportunity,_that.potential);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String opportunity,  double potential)  $default,) {final _that = this;
switch (_that) {
case _UpsellOpportunity():
return $default(_that.opportunity,_that.potential);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String opportunity,  double potential)?  $default,) {final _that = this;
switch (_that) {
case _UpsellOpportunity() when $default != null:
return $default(_that.opportunity,_that.potential);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UpsellOpportunity implements UpsellOpportunity {
  const _UpsellOpportunity({required this.opportunity, required this.potential});
  factory _UpsellOpportunity.fromJson(Map<String, dynamic> json) => _$UpsellOpportunityFromJson(json);

@override final  String opportunity;
@override final  double potential;

/// Create a copy of UpsellOpportunity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpsellOpportunityCopyWith<_UpsellOpportunity> get copyWith => __$UpsellOpportunityCopyWithImpl<_UpsellOpportunity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UpsellOpportunityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpsellOpportunity&&(identical(other.opportunity, opportunity) || other.opportunity == opportunity)&&(identical(other.potential, potential) || other.potential == potential));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,opportunity,potential);

@override
String toString() {
  return 'UpsellOpportunity(opportunity: $opportunity, potential: $potential)';
}


}

/// @nodoc
abstract mixin class _$UpsellOpportunityCopyWith<$Res> implements $UpsellOpportunityCopyWith<$Res> {
  factory _$UpsellOpportunityCopyWith(_UpsellOpportunity value, $Res Function(_UpsellOpportunity) _then) = __$UpsellOpportunityCopyWithImpl;
@override @useResult
$Res call({
 String opportunity, double potential
});




}
/// @nodoc
class __$UpsellOpportunityCopyWithImpl<$Res>
    implements _$UpsellOpportunityCopyWith<$Res> {
  __$UpsellOpportunityCopyWithImpl(this._self, this._then);

  final _UpsellOpportunity _self;
  final $Res Function(_UpsellOpportunity) _then;

/// Create a copy of UpsellOpportunity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? opportunity = null,Object? potential = null,}) {
  return _then(_UpsellOpportunity(
opportunity: null == opportunity ? _self.opportunity : opportunity // ignore: cast_nullable_to_non_nullable
as String,potential: null == potential ? _self.potential : potential // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$ExecutiveReport {

 String get organizationId; String get period; String get generatedAt; ProfitAndLoss get profitAndLoss; BalanceSheet get balanceSheet; CashFlowStatement get cashFlow; Map<String, double> get keyMetrics; List<String> get insights;
/// Create a copy of ExecutiveReport
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExecutiveReportCopyWith<ExecutiveReport> get copyWith => _$ExecutiveReportCopyWithImpl<ExecutiveReport>(this as ExecutiveReport, _$identity);

  /// Serializes this ExecutiveReport to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExecutiveReport&&(identical(other.organizationId, organizationId) || other.organizationId == organizationId)&&(identical(other.period, period) || other.period == period)&&(identical(other.generatedAt, generatedAt) || other.generatedAt == generatedAt)&&(identical(other.profitAndLoss, profitAndLoss) || other.profitAndLoss == profitAndLoss)&&(identical(other.balanceSheet, balanceSheet) || other.balanceSheet == balanceSheet)&&(identical(other.cashFlow, cashFlow) || other.cashFlow == cashFlow)&&const DeepCollectionEquality().equals(other.keyMetrics, keyMetrics)&&const DeepCollectionEquality().equals(other.insights, insights));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,organizationId,period,generatedAt,profitAndLoss,balanceSheet,cashFlow,const DeepCollectionEquality().hash(keyMetrics),const DeepCollectionEquality().hash(insights));

@override
String toString() {
  return 'ExecutiveReport(organizationId: $organizationId, period: $period, generatedAt: $generatedAt, profitAndLoss: $profitAndLoss, balanceSheet: $balanceSheet, cashFlow: $cashFlow, keyMetrics: $keyMetrics, insights: $insights)';
}


}

/// @nodoc
abstract mixin class $ExecutiveReportCopyWith<$Res>  {
  factory $ExecutiveReportCopyWith(ExecutiveReport value, $Res Function(ExecutiveReport) _then) = _$ExecutiveReportCopyWithImpl;
@useResult
$Res call({
 String organizationId, String period, String generatedAt, ProfitAndLoss profitAndLoss, BalanceSheet balanceSheet, CashFlowStatement cashFlow, Map<String, double> keyMetrics, List<String> insights
});


$ProfitAndLossCopyWith<$Res> get profitAndLoss;$BalanceSheetCopyWith<$Res> get balanceSheet;$CashFlowStatementCopyWith<$Res> get cashFlow;

}
/// @nodoc
class _$ExecutiveReportCopyWithImpl<$Res>
    implements $ExecutiveReportCopyWith<$Res> {
  _$ExecutiveReportCopyWithImpl(this._self, this._then);

  final ExecutiveReport _self;
  final $Res Function(ExecutiveReport) _then;

/// Create a copy of ExecutiveReport
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? organizationId = null,Object? period = null,Object? generatedAt = null,Object? profitAndLoss = null,Object? balanceSheet = null,Object? cashFlow = null,Object? keyMetrics = null,Object? insights = null,}) {
  return _then(_self.copyWith(
organizationId: null == organizationId ? _self.organizationId : organizationId // ignore: cast_nullable_to_non_nullable
as String,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String,generatedAt: null == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as String,profitAndLoss: null == profitAndLoss ? _self.profitAndLoss : profitAndLoss // ignore: cast_nullable_to_non_nullable
as ProfitAndLoss,balanceSheet: null == balanceSheet ? _self.balanceSheet : balanceSheet // ignore: cast_nullable_to_non_nullable
as BalanceSheet,cashFlow: null == cashFlow ? _self.cashFlow : cashFlow // ignore: cast_nullable_to_non_nullable
as CashFlowStatement,keyMetrics: null == keyMetrics ? _self.keyMetrics : keyMetrics // ignore: cast_nullable_to_non_nullable
as Map<String, double>,insights: null == insights ? _self.insights : insights // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}
/// Create a copy of ExecutiveReport
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProfitAndLossCopyWith<$Res> get profitAndLoss {
  
  return $ProfitAndLossCopyWith<$Res>(_self.profitAndLoss, (value) {
    return _then(_self.copyWith(profitAndLoss: value));
  });
}/// Create a copy of ExecutiveReport
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BalanceSheetCopyWith<$Res> get balanceSheet {
  
  return $BalanceSheetCopyWith<$Res>(_self.balanceSheet, (value) {
    return _then(_self.copyWith(balanceSheet: value));
  });
}/// Create a copy of ExecutiveReport
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CashFlowStatementCopyWith<$Res> get cashFlow {
  
  return $CashFlowStatementCopyWith<$Res>(_self.cashFlow, (value) {
    return _then(_self.copyWith(cashFlow: value));
  });
}
}


/// Adds pattern-matching-related methods to [ExecutiveReport].
extension ExecutiveReportPatterns on ExecutiveReport {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExecutiveReport value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExecutiveReport() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExecutiveReport value)  $default,){
final _that = this;
switch (_that) {
case _ExecutiveReport():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExecutiveReport value)?  $default,){
final _that = this;
switch (_that) {
case _ExecutiveReport() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String organizationId,  String period,  String generatedAt,  ProfitAndLoss profitAndLoss,  BalanceSheet balanceSheet,  CashFlowStatement cashFlow,  Map<String, double> keyMetrics,  List<String> insights)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExecutiveReport() when $default != null:
return $default(_that.organizationId,_that.period,_that.generatedAt,_that.profitAndLoss,_that.balanceSheet,_that.cashFlow,_that.keyMetrics,_that.insights);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String organizationId,  String period,  String generatedAt,  ProfitAndLoss profitAndLoss,  BalanceSheet balanceSheet,  CashFlowStatement cashFlow,  Map<String, double> keyMetrics,  List<String> insights)  $default,) {final _that = this;
switch (_that) {
case _ExecutiveReport():
return $default(_that.organizationId,_that.period,_that.generatedAt,_that.profitAndLoss,_that.balanceSheet,_that.cashFlow,_that.keyMetrics,_that.insights);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String organizationId,  String period,  String generatedAt,  ProfitAndLoss profitAndLoss,  BalanceSheet balanceSheet,  CashFlowStatement cashFlow,  Map<String, double> keyMetrics,  List<String> insights)?  $default,) {final _that = this;
switch (_that) {
case _ExecutiveReport() when $default != null:
return $default(_that.organizationId,_that.period,_that.generatedAt,_that.profitAndLoss,_that.balanceSheet,_that.cashFlow,_that.keyMetrics,_that.insights);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExecutiveReport implements ExecutiveReport {
  const _ExecutiveReport({required this.organizationId, required this.period, required this.generatedAt, required this.profitAndLoss, required this.balanceSheet, required this.cashFlow, required final  Map<String, double> keyMetrics, required final  List<String> insights}): _keyMetrics = keyMetrics,_insights = insights;
  factory _ExecutiveReport.fromJson(Map<String, dynamic> json) => _$ExecutiveReportFromJson(json);

@override final  String organizationId;
@override final  String period;
@override final  String generatedAt;
@override final  ProfitAndLoss profitAndLoss;
@override final  BalanceSheet balanceSheet;
@override final  CashFlowStatement cashFlow;
 final  Map<String, double> _keyMetrics;
@override Map<String, double> get keyMetrics {
  if (_keyMetrics is EqualUnmodifiableMapView) return _keyMetrics;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_keyMetrics);
}

 final  List<String> _insights;
@override List<String> get insights {
  if (_insights is EqualUnmodifiableListView) return _insights;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_insights);
}


/// Create a copy of ExecutiveReport
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExecutiveReportCopyWith<_ExecutiveReport> get copyWith => __$ExecutiveReportCopyWithImpl<_ExecutiveReport>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExecutiveReportToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExecutiveReport&&(identical(other.organizationId, organizationId) || other.organizationId == organizationId)&&(identical(other.period, period) || other.period == period)&&(identical(other.generatedAt, generatedAt) || other.generatedAt == generatedAt)&&(identical(other.profitAndLoss, profitAndLoss) || other.profitAndLoss == profitAndLoss)&&(identical(other.balanceSheet, balanceSheet) || other.balanceSheet == balanceSheet)&&(identical(other.cashFlow, cashFlow) || other.cashFlow == cashFlow)&&const DeepCollectionEquality().equals(other._keyMetrics, _keyMetrics)&&const DeepCollectionEquality().equals(other._insights, _insights));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,organizationId,period,generatedAt,profitAndLoss,balanceSheet,cashFlow,const DeepCollectionEquality().hash(_keyMetrics),const DeepCollectionEquality().hash(_insights));

@override
String toString() {
  return 'ExecutiveReport(organizationId: $organizationId, period: $period, generatedAt: $generatedAt, profitAndLoss: $profitAndLoss, balanceSheet: $balanceSheet, cashFlow: $cashFlow, keyMetrics: $keyMetrics, insights: $insights)';
}


}

/// @nodoc
abstract mixin class _$ExecutiveReportCopyWith<$Res> implements $ExecutiveReportCopyWith<$Res> {
  factory _$ExecutiveReportCopyWith(_ExecutiveReport value, $Res Function(_ExecutiveReport) _then) = __$ExecutiveReportCopyWithImpl;
@override @useResult
$Res call({
 String organizationId, String period, String generatedAt, ProfitAndLoss profitAndLoss, BalanceSheet balanceSheet, CashFlowStatement cashFlow, Map<String, double> keyMetrics, List<String> insights
});


@override $ProfitAndLossCopyWith<$Res> get profitAndLoss;@override $BalanceSheetCopyWith<$Res> get balanceSheet;@override $CashFlowStatementCopyWith<$Res> get cashFlow;

}
/// @nodoc
class __$ExecutiveReportCopyWithImpl<$Res>
    implements _$ExecutiveReportCopyWith<$Res> {
  __$ExecutiveReportCopyWithImpl(this._self, this._then);

  final _ExecutiveReport _self;
  final $Res Function(_ExecutiveReport) _then;

/// Create a copy of ExecutiveReport
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? organizationId = null,Object? period = null,Object? generatedAt = null,Object? profitAndLoss = null,Object? balanceSheet = null,Object? cashFlow = null,Object? keyMetrics = null,Object? insights = null,}) {
  return _then(_ExecutiveReport(
organizationId: null == organizationId ? _self.organizationId : organizationId // ignore: cast_nullable_to_non_nullable
as String,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String,generatedAt: null == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as String,profitAndLoss: null == profitAndLoss ? _self.profitAndLoss : profitAndLoss // ignore: cast_nullable_to_non_nullable
as ProfitAndLoss,balanceSheet: null == balanceSheet ? _self.balanceSheet : balanceSheet // ignore: cast_nullable_to_non_nullable
as BalanceSheet,cashFlow: null == cashFlow ? _self.cashFlow : cashFlow // ignore: cast_nullable_to_non_nullable
as CashFlowStatement,keyMetrics: null == keyMetrics ? _self._keyMetrics : keyMetrics // ignore: cast_nullable_to_non_nullable
as Map<String, double>,insights: null == insights ? _self._insights : insights // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

/// Create a copy of ExecutiveReport
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProfitAndLossCopyWith<$Res> get profitAndLoss {
  
  return $ProfitAndLossCopyWith<$Res>(_self.profitAndLoss, (value) {
    return _then(_self.copyWith(profitAndLoss: value));
  });
}/// Create a copy of ExecutiveReport
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BalanceSheetCopyWith<$Res> get balanceSheet {
  
  return $BalanceSheetCopyWith<$Res>(_self.balanceSheet, (value) {
    return _then(_self.copyWith(balanceSheet: value));
  });
}/// Create a copy of ExecutiveReport
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CashFlowStatementCopyWith<$Res> get cashFlow {
  
  return $CashFlowStatementCopyWith<$Res>(_self.cashFlow, (value) {
    return _then(_self.copyWith(cashFlow: value));
  });
}
}


/// @nodoc
mixin _$ProfitAndLoss {

 double get revenue; double get costOfSales; double get grossProfit; double get operatingExpenses; double get netProfit;
/// Create a copy of ProfitAndLoss
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfitAndLossCopyWith<ProfitAndLoss> get copyWith => _$ProfitAndLossCopyWithImpl<ProfitAndLoss>(this as ProfitAndLoss, _$identity);

  /// Serializes this ProfitAndLoss to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfitAndLoss&&(identical(other.revenue, revenue) || other.revenue == revenue)&&(identical(other.costOfSales, costOfSales) || other.costOfSales == costOfSales)&&(identical(other.grossProfit, grossProfit) || other.grossProfit == grossProfit)&&(identical(other.operatingExpenses, operatingExpenses) || other.operatingExpenses == operatingExpenses)&&(identical(other.netProfit, netProfit) || other.netProfit == netProfit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,revenue,costOfSales,grossProfit,operatingExpenses,netProfit);

@override
String toString() {
  return 'ProfitAndLoss(revenue: $revenue, costOfSales: $costOfSales, grossProfit: $grossProfit, operatingExpenses: $operatingExpenses, netProfit: $netProfit)';
}


}

/// @nodoc
abstract mixin class $ProfitAndLossCopyWith<$Res>  {
  factory $ProfitAndLossCopyWith(ProfitAndLoss value, $Res Function(ProfitAndLoss) _then) = _$ProfitAndLossCopyWithImpl;
@useResult
$Res call({
 double revenue, double costOfSales, double grossProfit, double operatingExpenses, double netProfit
});




}
/// @nodoc
class _$ProfitAndLossCopyWithImpl<$Res>
    implements $ProfitAndLossCopyWith<$Res> {
  _$ProfitAndLossCopyWithImpl(this._self, this._then);

  final ProfitAndLoss _self;
  final $Res Function(ProfitAndLoss) _then;

/// Create a copy of ProfitAndLoss
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? revenue = null,Object? costOfSales = null,Object? grossProfit = null,Object? operatingExpenses = null,Object? netProfit = null,}) {
  return _then(_self.copyWith(
revenue: null == revenue ? _self.revenue : revenue // ignore: cast_nullable_to_non_nullable
as double,costOfSales: null == costOfSales ? _self.costOfSales : costOfSales // ignore: cast_nullable_to_non_nullable
as double,grossProfit: null == grossProfit ? _self.grossProfit : grossProfit // ignore: cast_nullable_to_non_nullable
as double,operatingExpenses: null == operatingExpenses ? _self.operatingExpenses : operatingExpenses // ignore: cast_nullable_to_non_nullable
as double,netProfit: null == netProfit ? _self.netProfit : netProfit // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [ProfitAndLoss].
extension ProfitAndLossPatterns on ProfitAndLoss {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfitAndLoss value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfitAndLoss() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfitAndLoss value)  $default,){
final _that = this;
switch (_that) {
case _ProfitAndLoss():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfitAndLoss value)?  $default,){
final _that = this;
switch (_that) {
case _ProfitAndLoss() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double revenue,  double costOfSales,  double grossProfit,  double operatingExpenses,  double netProfit)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfitAndLoss() when $default != null:
return $default(_that.revenue,_that.costOfSales,_that.grossProfit,_that.operatingExpenses,_that.netProfit);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double revenue,  double costOfSales,  double grossProfit,  double operatingExpenses,  double netProfit)  $default,) {final _that = this;
switch (_that) {
case _ProfitAndLoss():
return $default(_that.revenue,_that.costOfSales,_that.grossProfit,_that.operatingExpenses,_that.netProfit);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double revenue,  double costOfSales,  double grossProfit,  double operatingExpenses,  double netProfit)?  $default,) {final _that = this;
switch (_that) {
case _ProfitAndLoss() when $default != null:
return $default(_that.revenue,_that.costOfSales,_that.grossProfit,_that.operatingExpenses,_that.netProfit);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProfitAndLoss implements ProfitAndLoss {
  const _ProfitAndLoss({required this.revenue, required this.costOfSales, required this.grossProfit, required this.operatingExpenses, required this.netProfit});
  factory _ProfitAndLoss.fromJson(Map<String, dynamic> json) => _$ProfitAndLossFromJson(json);

@override final  double revenue;
@override final  double costOfSales;
@override final  double grossProfit;
@override final  double operatingExpenses;
@override final  double netProfit;

/// Create a copy of ProfitAndLoss
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfitAndLossCopyWith<_ProfitAndLoss> get copyWith => __$ProfitAndLossCopyWithImpl<_ProfitAndLoss>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProfitAndLossToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfitAndLoss&&(identical(other.revenue, revenue) || other.revenue == revenue)&&(identical(other.costOfSales, costOfSales) || other.costOfSales == costOfSales)&&(identical(other.grossProfit, grossProfit) || other.grossProfit == grossProfit)&&(identical(other.operatingExpenses, operatingExpenses) || other.operatingExpenses == operatingExpenses)&&(identical(other.netProfit, netProfit) || other.netProfit == netProfit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,revenue,costOfSales,grossProfit,operatingExpenses,netProfit);

@override
String toString() {
  return 'ProfitAndLoss(revenue: $revenue, costOfSales: $costOfSales, grossProfit: $grossProfit, operatingExpenses: $operatingExpenses, netProfit: $netProfit)';
}


}

/// @nodoc
abstract mixin class _$ProfitAndLossCopyWith<$Res> implements $ProfitAndLossCopyWith<$Res> {
  factory _$ProfitAndLossCopyWith(_ProfitAndLoss value, $Res Function(_ProfitAndLoss) _then) = __$ProfitAndLossCopyWithImpl;
@override @useResult
$Res call({
 double revenue, double costOfSales, double grossProfit, double operatingExpenses, double netProfit
});




}
/// @nodoc
class __$ProfitAndLossCopyWithImpl<$Res>
    implements _$ProfitAndLossCopyWith<$Res> {
  __$ProfitAndLossCopyWithImpl(this._self, this._then);

  final _ProfitAndLoss _self;
  final $Res Function(_ProfitAndLoss) _then;

/// Create a copy of ProfitAndLoss
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? revenue = null,Object? costOfSales = null,Object? grossProfit = null,Object? operatingExpenses = null,Object? netProfit = null,}) {
  return _then(_ProfitAndLoss(
revenue: null == revenue ? _self.revenue : revenue // ignore: cast_nullable_to_non_nullable
as double,costOfSales: null == costOfSales ? _self.costOfSales : costOfSales // ignore: cast_nullable_to_non_nullable
as double,grossProfit: null == grossProfit ? _self.grossProfit : grossProfit // ignore: cast_nullable_to_non_nullable
as double,operatingExpenses: null == operatingExpenses ? _self.operatingExpenses : operatingExpenses // ignore: cast_nullable_to_non_nullable
as double,netProfit: null == netProfit ? _self.netProfit : netProfit // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$BalanceSheet {

 BalanceSheetAssets get assets; BalanceSheetLiabilities get liabilities; double get equity;
/// Create a copy of BalanceSheet
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BalanceSheetCopyWith<BalanceSheet> get copyWith => _$BalanceSheetCopyWithImpl<BalanceSheet>(this as BalanceSheet, _$identity);

  /// Serializes this BalanceSheet to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BalanceSheet&&(identical(other.assets, assets) || other.assets == assets)&&(identical(other.liabilities, liabilities) || other.liabilities == liabilities)&&(identical(other.equity, equity) || other.equity == equity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,assets,liabilities,equity);

@override
String toString() {
  return 'BalanceSheet(assets: $assets, liabilities: $liabilities, equity: $equity)';
}


}

/// @nodoc
abstract mixin class $BalanceSheetCopyWith<$Res>  {
  factory $BalanceSheetCopyWith(BalanceSheet value, $Res Function(BalanceSheet) _then) = _$BalanceSheetCopyWithImpl;
@useResult
$Res call({
 BalanceSheetAssets assets, BalanceSheetLiabilities liabilities, double equity
});


$BalanceSheetAssetsCopyWith<$Res> get assets;$BalanceSheetLiabilitiesCopyWith<$Res> get liabilities;

}
/// @nodoc
class _$BalanceSheetCopyWithImpl<$Res>
    implements $BalanceSheetCopyWith<$Res> {
  _$BalanceSheetCopyWithImpl(this._self, this._then);

  final BalanceSheet _self;
  final $Res Function(BalanceSheet) _then;

/// Create a copy of BalanceSheet
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? assets = null,Object? liabilities = null,Object? equity = null,}) {
  return _then(_self.copyWith(
assets: null == assets ? _self.assets : assets // ignore: cast_nullable_to_non_nullable
as BalanceSheetAssets,liabilities: null == liabilities ? _self.liabilities : liabilities // ignore: cast_nullable_to_non_nullable
as BalanceSheetLiabilities,equity: null == equity ? _self.equity : equity // ignore: cast_nullable_to_non_nullable
as double,
  ));
}
/// Create a copy of BalanceSheet
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BalanceSheetAssetsCopyWith<$Res> get assets {
  
  return $BalanceSheetAssetsCopyWith<$Res>(_self.assets, (value) {
    return _then(_self.copyWith(assets: value));
  });
}/// Create a copy of BalanceSheet
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BalanceSheetLiabilitiesCopyWith<$Res> get liabilities {
  
  return $BalanceSheetLiabilitiesCopyWith<$Res>(_self.liabilities, (value) {
    return _then(_self.copyWith(liabilities: value));
  });
}
}


/// Adds pattern-matching-related methods to [BalanceSheet].
extension BalanceSheetPatterns on BalanceSheet {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BalanceSheet value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BalanceSheet() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BalanceSheet value)  $default,){
final _that = this;
switch (_that) {
case _BalanceSheet():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BalanceSheet value)?  $default,){
final _that = this;
switch (_that) {
case _BalanceSheet() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( BalanceSheetAssets assets,  BalanceSheetLiabilities liabilities,  double equity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BalanceSheet() when $default != null:
return $default(_that.assets,_that.liabilities,_that.equity);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( BalanceSheetAssets assets,  BalanceSheetLiabilities liabilities,  double equity)  $default,) {final _that = this;
switch (_that) {
case _BalanceSheet():
return $default(_that.assets,_that.liabilities,_that.equity);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( BalanceSheetAssets assets,  BalanceSheetLiabilities liabilities,  double equity)?  $default,) {final _that = this;
switch (_that) {
case _BalanceSheet() when $default != null:
return $default(_that.assets,_that.liabilities,_that.equity);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BalanceSheet implements BalanceSheet {
  const _BalanceSheet({required this.assets, required this.liabilities, required this.equity});
  factory _BalanceSheet.fromJson(Map<String, dynamic> json) => _$BalanceSheetFromJson(json);

@override final  BalanceSheetAssets assets;
@override final  BalanceSheetLiabilities liabilities;
@override final  double equity;

/// Create a copy of BalanceSheet
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BalanceSheetCopyWith<_BalanceSheet> get copyWith => __$BalanceSheetCopyWithImpl<_BalanceSheet>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BalanceSheetToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BalanceSheet&&(identical(other.assets, assets) || other.assets == assets)&&(identical(other.liabilities, liabilities) || other.liabilities == liabilities)&&(identical(other.equity, equity) || other.equity == equity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,assets,liabilities,equity);

@override
String toString() {
  return 'BalanceSheet(assets: $assets, liabilities: $liabilities, equity: $equity)';
}


}

/// @nodoc
abstract mixin class _$BalanceSheetCopyWith<$Res> implements $BalanceSheetCopyWith<$Res> {
  factory _$BalanceSheetCopyWith(_BalanceSheet value, $Res Function(_BalanceSheet) _then) = __$BalanceSheetCopyWithImpl;
@override @useResult
$Res call({
 BalanceSheetAssets assets, BalanceSheetLiabilities liabilities, double equity
});


@override $BalanceSheetAssetsCopyWith<$Res> get assets;@override $BalanceSheetLiabilitiesCopyWith<$Res> get liabilities;

}
/// @nodoc
class __$BalanceSheetCopyWithImpl<$Res>
    implements _$BalanceSheetCopyWith<$Res> {
  __$BalanceSheetCopyWithImpl(this._self, this._then);

  final _BalanceSheet _self;
  final $Res Function(_BalanceSheet) _then;

/// Create a copy of BalanceSheet
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? assets = null,Object? liabilities = null,Object? equity = null,}) {
  return _then(_BalanceSheet(
assets: null == assets ? _self.assets : assets // ignore: cast_nullable_to_non_nullable
as BalanceSheetAssets,liabilities: null == liabilities ? _self.liabilities : liabilities // ignore: cast_nullable_to_non_nullable
as BalanceSheetLiabilities,equity: null == equity ? _self.equity : equity // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

/// Create a copy of BalanceSheet
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BalanceSheetAssetsCopyWith<$Res> get assets {
  
  return $BalanceSheetAssetsCopyWith<$Res>(_self.assets, (value) {
    return _then(_self.copyWith(assets: value));
  });
}/// Create a copy of BalanceSheet
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BalanceSheetLiabilitiesCopyWith<$Res> get liabilities {
  
  return $BalanceSheetLiabilitiesCopyWith<$Res>(_self.liabilities, (value) {
    return _then(_self.copyWith(liabilities: value));
  });
}
}


/// @nodoc
mixin _$BalanceSheetAssets {

 double get current; double get fixed; double get total;
/// Create a copy of BalanceSheetAssets
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BalanceSheetAssetsCopyWith<BalanceSheetAssets> get copyWith => _$BalanceSheetAssetsCopyWithImpl<BalanceSheetAssets>(this as BalanceSheetAssets, _$identity);

  /// Serializes this BalanceSheetAssets to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BalanceSheetAssets&&(identical(other.current, current) || other.current == current)&&(identical(other.fixed, fixed) || other.fixed == fixed)&&(identical(other.total, total) || other.total == total));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,current,fixed,total);

@override
String toString() {
  return 'BalanceSheetAssets(current: $current, fixed: $fixed, total: $total)';
}


}

/// @nodoc
abstract mixin class $BalanceSheetAssetsCopyWith<$Res>  {
  factory $BalanceSheetAssetsCopyWith(BalanceSheetAssets value, $Res Function(BalanceSheetAssets) _then) = _$BalanceSheetAssetsCopyWithImpl;
@useResult
$Res call({
 double current, double fixed, double total
});




}
/// @nodoc
class _$BalanceSheetAssetsCopyWithImpl<$Res>
    implements $BalanceSheetAssetsCopyWith<$Res> {
  _$BalanceSheetAssetsCopyWithImpl(this._self, this._then);

  final BalanceSheetAssets _self;
  final $Res Function(BalanceSheetAssets) _then;

/// Create a copy of BalanceSheetAssets
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? current = null,Object? fixed = null,Object? total = null,}) {
  return _then(_self.copyWith(
current: null == current ? _self.current : current // ignore: cast_nullable_to_non_nullable
as double,fixed: null == fixed ? _self.fixed : fixed // ignore: cast_nullable_to_non_nullable
as double,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [BalanceSheetAssets].
extension BalanceSheetAssetsPatterns on BalanceSheetAssets {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BalanceSheetAssets value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BalanceSheetAssets() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BalanceSheetAssets value)  $default,){
final _that = this;
switch (_that) {
case _BalanceSheetAssets():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BalanceSheetAssets value)?  $default,){
final _that = this;
switch (_that) {
case _BalanceSheetAssets() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double current,  double fixed,  double total)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BalanceSheetAssets() when $default != null:
return $default(_that.current,_that.fixed,_that.total);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double current,  double fixed,  double total)  $default,) {final _that = this;
switch (_that) {
case _BalanceSheetAssets():
return $default(_that.current,_that.fixed,_that.total);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double current,  double fixed,  double total)?  $default,) {final _that = this;
switch (_that) {
case _BalanceSheetAssets() when $default != null:
return $default(_that.current,_that.fixed,_that.total);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BalanceSheetAssets implements BalanceSheetAssets {
  const _BalanceSheetAssets({required this.current, required this.fixed, required this.total});
  factory _BalanceSheetAssets.fromJson(Map<String, dynamic> json) => _$BalanceSheetAssetsFromJson(json);

@override final  double current;
@override final  double fixed;
@override final  double total;

/// Create a copy of BalanceSheetAssets
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BalanceSheetAssetsCopyWith<_BalanceSheetAssets> get copyWith => __$BalanceSheetAssetsCopyWithImpl<_BalanceSheetAssets>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BalanceSheetAssetsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BalanceSheetAssets&&(identical(other.current, current) || other.current == current)&&(identical(other.fixed, fixed) || other.fixed == fixed)&&(identical(other.total, total) || other.total == total));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,current,fixed,total);

@override
String toString() {
  return 'BalanceSheetAssets(current: $current, fixed: $fixed, total: $total)';
}


}

/// @nodoc
abstract mixin class _$BalanceSheetAssetsCopyWith<$Res> implements $BalanceSheetAssetsCopyWith<$Res> {
  factory _$BalanceSheetAssetsCopyWith(_BalanceSheetAssets value, $Res Function(_BalanceSheetAssets) _then) = __$BalanceSheetAssetsCopyWithImpl;
@override @useResult
$Res call({
 double current, double fixed, double total
});




}
/// @nodoc
class __$BalanceSheetAssetsCopyWithImpl<$Res>
    implements _$BalanceSheetAssetsCopyWith<$Res> {
  __$BalanceSheetAssetsCopyWithImpl(this._self, this._then);

  final _BalanceSheetAssets _self;
  final $Res Function(_BalanceSheetAssets) _then;

/// Create a copy of BalanceSheetAssets
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? current = null,Object? fixed = null,Object? total = null,}) {
  return _then(_BalanceSheetAssets(
current: null == current ? _self.current : current // ignore: cast_nullable_to_non_nullable
as double,fixed: null == fixed ? _self.fixed : fixed // ignore: cast_nullable_to_non_nullable
as double,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$BalanceSheetLiabilities {

 double get current; double get longTerm; double get total;
/// Create a copy of BalanceSheetLiabilities
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BalanceSheetLiabilitiesCopyWith<BalanceSheetLiabilities> get copyWith => _$BalanceSheetLiabilitiesCopyWithImpl<BalanceSheetLiabilities>(this as BalanceSheetLiabilities, _$identity);

  /// Serializes this BalanceSheetLiabilities to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BalanceSheetLiabilities&&(identical(other.current, current) || other.current == current)&&(identical(other.longTerm, longTerm) || other.longTerm == longTerm)&&(identical(other.total, total) || other.total == total));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,current,longTerm,total);

@override
String toString() {
  return 'BalanceSheetLiabilities(current: $current, longTerm: $longTerm, total: $total)';
}


}

/// @nodoc
abstract mixin class $BalanceSheetLiabilitiesCopyWith<$Res>  {
  factory $BalanceSheetLiabilitiesCopyWith(BalanceSheetLiabilities value, $Res Function(BalanceSheetLiabilities) _then) = _$BalanceSheetLiabilitiesCopyWithImpl;
@useResult
$Res call({
 double current, double longTerm, double total
});




}
/// @nodoc
class _$BalanceSheetLiabilitiesCopyWithImpl<$Res>
    implements $BalanceSheetLiabilitiesCopyWith<$Res> {
  _$BalanceSheetLiabilitiesCopyWithImpl(this._self, this._then);

  final BalanceSheetLiabilities _self;
  final $Res Function(BalanceSheetLiabilities) _then;

/// Create a copy of BalanceSheetLiabilities
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? current = null,Object? longTerm = null,Object? total = null,}) {
  return _then(_self.copyWith(
current: null == current ? _self.current : current // ignore: cast_nullable_to_non_nullable
as double,longTerm: null == longTerm ? _self.longTerm : longTerm // ignore: cast_nullable_to_non_nullable
as double,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [BalanceSheetLiabilities].
extension BalanceSheetLiabilitiesPatterns on BalanceSheetLiabilities {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BalanceSheetLiabilities value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BalanceSheetLiabilities() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BalanceSheetLiabilities value)  $default,){
final _that = this;
switch (_that) {
case _BalanceSheetLiabilities():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BalanceSheetLiabilities value)?  $default,){
final _that = this;
switch (_that) {
case _BalanceSheetLiabilities() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double current,  double longTerm,  double total)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BalanceSheetLiabilities() when $default != null:
return $default(_that.current,_that.longTerm,_that.total);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double current,  double longTerm,  double total)  $default,) {final _that = this;
switch (_that) {
case _BalanceSheetLiabilities():
return $default(_that.current,_that.longTerm,_that.total);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double current,  double longTerm,  double total)?  $default,) {final _that = this;
switch (_that) {
case _BalanceSheetLiabilities() when $default != null:
return $default(_that.current,_that.longTerm,_that.total);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BalanceSheetLiabilities implements BalanceSheetLiabilities {
  const _BalanceSheetLiabilities({required this.current, required this.longTerm, required this.total});
  factory _BalanceSheetLiabilities.fromJson(Map<String, dynamic> json) => _$BalanceSheetLiabilitiesFromJson(json);

@override final  double current;
@override final  double longTerm;
@override final  double total;

/// Create a copy of BalanceSheetLiabilities
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BalanceSheetLiabilitiesCopyWith<_BalanceSheetLiabilities> get copyWith => __$BalanceSheetLiabilitiesCopyWithImpl<_BalanceSheetLiabilities>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BalanceSheetLiabilitiesToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BalanceSheetLiabilities&&(identical(other.current, current) || other.current == current)&&(identical(other.longTerm, longTerm) || other.longTerm == longTerm)&&(identical(other.total, total) || other.total == total));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,current,longTerm,total);

@override
String toString() {
  return 'BalanceSheetLiabilities(current: $current, longTerm: $longTerm, total: $total)';
}


}

/// @nodoc
abstract mixin class _$BalanceSheetLiabilitiesCopyWith<$Res> implements $BalanceSheetLiabilitiesCopyWith<$Res> {
  factory _$BalanceSheetLiabilitiesCopyWith(_BalanceSheetLiabilities value, $Res Function(_BalanceSheetLiabilities) _then) = __$BalanceSheetLiabilitiesCopyWithImpl;
@override @useResult
$Res call({
 double current, double longTerm, double total
});




}
/// @nodoc
class __$BalanceSheetLiabilitiesCopyWithImpl<$Res>
    implements _$BalanceSheetLiabilitiesCopyWith<$Res> {
  __$BalanceSheetLiabilitiesCopyWithImpl(this._self, this._then);

  final _BalanceSheetLiabilities _self;
  final $Res Function(_BalanceSheetLiabilities) _then;

/// Create a copy of BalanceSheetLiabilities
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? current = null,Object? longTerm = null,Object? total = null,}) {
  return _then(_BalanceSheetLiabilities(
current: null == current ? _self.current : current // ignore: cast_nullable_to_non_nullable
as double,longTerm: null == longTerm ? _self.longTerm : longTerm // ignore: cast_nullable_to_non_nullable
as double,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$CashFlowStatement {

 double get operating; double get investing; double get financing; double get netChange;
/// Create a copy of CashFlowStatement
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CashFlowStatementCopyWith<CashFlowStatement> get copyWith => _$CashFlowStatementCopyWithImpl<CashFlowStatement>(this as CashFlowStatement, _$identity);

  /// Serializes this CashFlowStatement to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CashFlowStatement&&(identical(other.operating, operating) || other.operating == operating)&&(identical(other.investing, investing) || other.investing == investing)&&(identical(other.financing, financing) || other.financing == financing)&&(identical(other.netChange, netChange) || other.netChange == netChange));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,operating,investing,financing,netChange);

@override
String toString() {
  return 'CashFlowStatement(operating: $operating, investing: $investing, financing: $financing, netChange: $netChange)';
}


}

/// @nodoc
abstract mixin class $CashFlowStatementCopyWith<$Res>  {
  factory $CashFlowStatementCopyWith(CashFlowStatement value, $Res Function(CashFlowStatement) _then) = _$CashFlowStatementCopyWithImpl;
@useResult
$Res call({
 double operating, double investing, double financing, double netChange
});




}
/// @nodoc
class _$CashFlowStatementCopyWithImpl<$Res>
    implements $CashFlowStatementCopyWith<$Res> {
  _$CashFlowStatementCopyWithImpl(this._self, this._then);

  final CashFlowStatement _self;
  final $Res Function(CashFlowStatement) _then;

/// Create a copy of CashFlowStatement
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? operating = null,Object? investing = null,Object? financing = null,Object? netChange = null,}) {
  return _then(_self.copyWith(
operating: null == operating ? _self.operating : operating // ignore: cast_nullable_to_non_nullable
as double,investing: null == investing ? _self.investing : investing // ignore: cast_nullable_to_non_nullable
as double,financing: null == financing ? _self.financing : financing // ignore: cast_nullable_to_non_nullable
as double,netChange: null == netChange ? _self.netChange : netChange // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [CashFlowStatement].
extension CashFlowStatementPatterns on CashFlowStatement {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CashFlowStatement value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CashFlowStatement() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CashFlowStatement value)  $default,){
final _that = this;
switch (_that) {
case _CashFlowStatement():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CashFlowStatement value)?  $default,){
final _that = this;
switch (_that) {
case _CashFlowStatement() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double operating,  double investing,  double financing,  double netChange)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CashFlowStatement() when $default != null:
return $default(_that.operating,_that.investing,_that.financing,_that.netChange);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double operating,  double investing,  double financing,  double netChange)  $default,) {final _that = this;
switch (_that) {
case _CashFlowStatement():
return $default(_that.operating,_that.investing,_that.financing,_that.netChange);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double operating,  double investing,  double financing,  double netChange)?  $default,) {final _that = this;
switch (_that) {
case _CashFlowStatement() when $default != null:
return $default(_that.operating,_that.investing,_that.financing,_that.netChange);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CashFlowStatement implements CashFlowStatement {
  const _CashFlowStatement({required this.operating, required this.investing, required this.financing, required this.netChange});
  factory _CashFlowStatement.fromJson(Map<String, dynamic> json) => _$CashFlowStatementFromJson(json);

@override final  double operating;
@override final  double investing;
@override final  double financing;
@override final  double netChange;

/// Create a copy of CashFlowStatement
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CashFlowStatementCopyWith<_CashFlowStatement> get copyWith => __$CashFlowStatementCopyWithImpl<_CashFlowStatement>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CashFlowStatementToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CashFlowStatement&&(identical(other.operating, operating) || other.operating == operating)&&(identical(other.investing, investing) || other.investing == investing)&&(identical(other.financing, financing) || other.financing == financing)&&(identical(other.netChange, netChange) || other.netChange == netChange));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,operating,investing,financing,netChange);

@override
String toString() {
  return 'CashFlowStatement(operating: $operating, investing: $investing, financing: $financing, netChange: $netChange)';
}


}

/// @nodoc
abstract mixin class _$CashFlowStatementCopyWith<$Res> implements $CashFlowStatementCopyWith<$Res> {
  factory _$CashFlowStatementCopyWith(_CashFlowStatement value, $Res Function(_CashFlowStatement) _then) = __$CashFlowStatementCopyWithImpl;
@override @useResult
$Res call({
 double operating, double investing, double financing, double netChange
});




}
/// @nodoc
class __$CashFlowStatementCopyWithImpl<$Res>
    implements _$CashFlowStatementCopyWith<$Res> {
  __$CashFlowStatementCopyWithImpl(this._self, this._then);

  final _CashFlowStatement _self;
  final $Res Function(_CashFlowStatement) _then;

/// Create a copy of CashFlowStatement
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? operating = null,Object? investing = null,Object? financing = null,Object? netChange = null,}) {
  return _then(_CashFlowStatement(
operating: null == operating ? _self.operating : operating // ignore: cast_nullable_to_non_nullable
as double,investing: null == investing ? _self.investing : investing // ignore: cast_nullable_to_non_nullable
as double,financing: null == financing ? _self.financing : financing // ignore: cast_nullable_to_non_nullable
as double,netChange: null == netChange ? _self.netChange : netChange // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
