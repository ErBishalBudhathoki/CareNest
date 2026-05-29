// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'workforce_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DemandForecast {

 DateTime get date; int get predicted; int get lower; int get upper;
/// Create a copy of DemandForecast
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DemandForecastCopyWith<DemandForecast> get copyWith => _$DemandForecastCopyWithImpl<DemandForecast>(this as DemandForecast, _$identity);

  /// Serializes this DemandForecast to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DemandForecast&&(identical(other.date, date) || other.date == date)&&(identical(other.predicted, predicted) || other.predicted == predicted)&&(identical(other.lower, lower) || other.lower == lower)&&(identical(other.upper, upper) || other.upper == upper));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,predicted,lower,upper);

@override
String toString() {
  return 'DemandForecast(date: $date, predicted: $predicted, lower: $lower, upper: $upper)';
}


}

/// @nodoc
abstract mixin class $DemandForecastCopyWith<$Res>  {
  factory $DemandForecastCopyWith(DemandForecast value, $Res Function(DemandForecast) _then) = _$DemandForecastCopyWithImpl;
@useResult
$Res call({
 DateTime date, int predicted, int lower, int upper
});




}
/// @nodoc
class _$DemandForecastCopyWithImpl<$Res>
    implements $DemandForecastCopyWith<$Res> {
  _$DemandForecastCopyWithImpl(this._self, this._then);

  final DemandForecast _self;
  final $Res Function(DemandForecast) _then;

/// Create a copy of DemandForecast
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? predicted = null,Object? lower = null,Object? upper = null,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,predicted: null == predicted ? _self.predicted : predicted // ignore: cast_nullable_to_non_nullable
as int,lower: null == lower ? _self.lower : lower // ignore: cast_nullable_to_non_nullable
as int,upper: null == upper ? _self.upper : upper // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [DemandForecast].
extension DemandForecastPatterns on DemandForecast {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DemandForecast value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DemandForecast() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DemandForecast value)  $default,){
final _that = this;
switch (_that) {
case _DemandForecast():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DemandForecast value)?  $default,){
final _that = this;
switch (_that) {
case _DemandForecast() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime date,  int predicted,  int lower,  int upper)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DemandForecast() when $default != null:
return $default(_that.date,_that.predicted,_that.lower,_that.upper);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime date,  int predicted,  int lower,  int upper)  $default,) {final _that = this;
switch (_that) {
case _DemandForecast():
return $default(_that.date,_that.predicted,_that.lower,_that.upper);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime date,  int predicted,  int lower,  int upper)?  $default,) {final _that = this;
switch (_that) {
case _DemandForecast() when $default != null:
return $default(_that.date,_that.predicted,_that.lower,_that.upper);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DemandForecast implements DemandForecast {
  const _DemandForecast({required this.date, required this.predicted, required this.lower, required this.upper});
  factory _DemandForecast.fromJson(Map<String, dynamic> json) => _$DemandForecastFromJson(json);

@override final  DateTime date;
@override final  int predicted;
@override final  int lower;
@override final  int upper;

/// Create a copy of DemandForecast
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DemandForecastCopyWith<_DemandForecast> get copyWith => __$DemandForecastCopyWithImpl<_DemandForecast>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DemandForecastToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DemandForecast&&(identical(other.date, date) || other.date == date)&&(identical(other.predicted, predicted) || other.predicted == predicted)&&(identical(other.lower, lower) || other.lower == lower)&&(identical(other.upper, upper) || other.upper == upper));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,predicted,lower,upper);

@override
String toString() {
  return 'DemandForecast(date: $date, predicted: $predicted, lower: $lower, upper: $upper)';
}


}

/// @nodoc
abstract mixin class _$DemandForecastCopyWith<$Res> implements $DemandForecastCopyWith<$Res> {
  factory _$DemandForecastCopyWith(_DemandForecast value, $Res Function(_DemandForecast) _then) = __$DemandForecastCopyWithImpl;
@override @useResult
$Res call({
 DateTime date, int predicted, int lower, int upper
});




}
/// @nodoc
class __$DemandForecastCopyWithImpl<$Res>
    implements _$DemandForecastCopyWith<$Res> {
  __$DemandForecastCopyWithImpl(this._self, this._then);

  final _DemandForecast _self;
  final $Res Function(_DemandForecast) _then;

/// Create a copy of DemandForecast
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? predicted = null,Object? lower = null,Object? upper = null,}) {
  return _then(_DemandForecast(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,predicted: null == predicted ? _self.predicted : predicted // ignore: cast_nullable_to_non_nullable
as int,lower: null == lower ? _self.lower : lower // ignore: cast_nullable_to_non_nullable
as int,upper: null == upper ? _self.upper : upper // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$SeasonalPattern {

 int get day; double get average; double get variance;
/// Create a copy of SeasonalPattern
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SeasonalPatternCopyWith<SeasonalPattern> get copyWith => _$SeasonalPatternCopyWithImpl<SeasonalPattern>(this as SeasonalPattern, _$identity);

  /// Serializes this SeasonalPattern to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SeasonalPattern&&(identical(other.day, day) || other.day == day)&&(identical(other.average, average) || other.average == average)&&(identical(other.variance, variance) || other.variance == variance));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,day,average,variance);

@override
String toString() {
  return 'SeasonalPattern(day: $day, average: $average, variance: $variance)';
}


}

/// @nodoc
abstract mixin class $SeasonalPatternCopyWith<$Res>  {
  factory $SeasonalPatternCopyWith(SeasonalPattern value, $Res Function(SeasonalPattern) _then) = _$SeasonalPatternCopyWithImpl;
@useResult
$Res call({
 int day, double average, double variance
});




}
/// @nodoc
class _$SeasonalPatternCopyWithImpl<$Res>
    implements $SeasonalPatternCopyWith<$Res> {
  _$SeasonalPatternCopyWithImpl(this._self, this._then);

  final SeasonalPattern _self;
  final $Res Function(SeasonalPattern) _then;

/// Create a copy of SeasonalPattern
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? day = null,Object? average = null,Object? variance = null,}) {
  return _then(_self.copyWith(
day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as int,average: null == average ? _self.average : average // ignore: cast_nullable_to_non_nullable
as double,variance: null == variance ? _self.variance : variance // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [SeasonalPattern].
extension SeasonalPatternPatterns on SeasonalPattern {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SeasonalPattern value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SeasonalPattern() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SeasonalPattern value)  $default,){
final _that = this;
switch (_that) {
case _SeasonalPattern():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SeasonalPattern value)?  $default,){
final _that = this;
switch (_that) {
case _SeasonalPattern() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int day,  double average,  double variance)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SeasonalPattern() when $default != null:
return $default(_that.day,_that.average,_that.variance);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int day,  double average,  double variance)  $default,) {final _that = this;
switch (_that) {
case _SeasonalPattern():
return $default(_that.day,_that.average,_that.variance);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int day,  double average,  double variance)?  $default,) {final _that = this;
switch (_that) {
case _SeasonalPattern() when $default != null:
return $default(_that.day,_that.average,_that.variance);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SeasonalPattern implements SeasonalPattern {
  const _SeasonalPattern({required this.day, required this.average, required this.variance});
  factory _SeasonalPattern.fromJson(Map<String, dynamic> json) => _$SeasonalPatternFromJson(json);

@override final  int day;
@override final  double average;
@override final  double variance;

/// Create a copy of SeasonalPattern
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SeasonalPatternCopyWith<_SeasonalPattern> get copyWith => __$SeasonalPatternCopyWithImpl<_SeasonalPattern>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SeasonalPatternToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SeasonalPattern&&(identical(other.day, day) || other.day == day)&&(identical(other.average, average) || other.average == average)&&(identical(other.variance, variance) || other.variance == variance));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,day,average,variance);

@override
String toString() {
  return 'SeasonalPattern(day: $day, average: $average, variance: $variance)';
}


}

/// @nodoc
abstract mixin class _$SeasonalPatternCopyWith<$Res> implements $SeasonalPatternCopyWith<$Res> {
  factory _$SeasonalPatternCopyWith(_SeasonalPattern value, $Res Function(_SeasonalPattern) _then) = __$SeasonalPatternCopyWithImpl;
@override @useResult
$Res call({
 int day, double average, double variance
});




}
/// @nodoc
class __$SeasonalPatternCopyWithImpl<$Res>
    implements _$SeasonalPatternCopyWith<$Res> {
  __$SeasonalPatternCopyWithImpl(this._self, this._then);

  final _SeasonalPattern _self;
  final $Res Function(_SeasonalPattern) _then;

/// Create a copy of SeasonalPattern
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? day = null,Object? average = null,Object? variance = null,}) {
  return _then(_SeasonalPattern(
day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as int,average: null == average ? _self.average : average // ignore: cast_nullable_to_non_nullable
as double,variance: null == variance ? _self.variance : variance // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$ForecastConfidence {

 double get mae; double get rmse; double get accuracy;
/// Create a copy of ForecastConfidence
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ForecastConfidenceCopyWith<ForecastConfidence> get copyWith => _$ForecastConfidenceCopyWithImpl<ForecastConfidence>(this as ForecastConfidence, _$identity);

  /// Serializes this ForecastConfidence to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ForecastConfidence&&(identical(other.mae, mae) || other.mae == mae)&&(identical(other.rmse, rmse) || other.rmse == rmse)&&(identical(other.accuracy, accuracy) || other.accuracy == accuracy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mae,rmse,accuracy);

@override
String toString() {
  return 'ForecastConfidence(mae: $mae, rmse: $rmse, accuracy: $accuracy)';
}


}

/// @nodoc
abstract mixin class $ForecastConfidenceCopyWith<$Res>  {
  factory $ForecastConfidenceCopyWith(ForecastConfidence value, $Res Function(ForecastConfidence) _then) = _$ForecastConfidenceCopyWithImpl;
@useResult
$Res call({
 double mae, double rmse, double accuracy
});




}
/// @nodoc
class _$ForecastConfidenceCopyWithImpl<$Res>
    implements $ForecastConfidenceCopyWith<$Res> {
  _$ForecastConfidenceCopyWithImpl(this._self, this._then);

  final ForecastConfidence _self;
  final $Res Function(ForecastConfidence) _then;

/// Create a copy of ForecastConfidence
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mae = null,Object? rmse = null,Object? accuracy = null,}) {
  return _then(_self.copyWith(
mae: null == mae ? _self.mae : mae // ignore: cast_nullable_to_non_nullable
as double,rmse: null == rmse ? _self.rmse : rmse // ignore: cast_nullable_to_non_nullable
as double,accuracy: null == accuracy ? _self.accuracy : accuracy // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [ForecastConfidence].
extension ForecastConfidencePatterns on ForecastConfidence {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ForecastConfidence value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ForecastConfidence() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ForecastConfidence value)  $default,){
final _that = this;
switch (_that) {
case _ForecastConfidence():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ForecastConfidence value)?  $default,){
final _that = this;
switch (_that) {
case _ForecastConfidence() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double mae,  double rmse,  double accuracy)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ForecastConfidence() when $default != null:
return $default(_that.mae,_that.rmse,_that.accuracy);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double mae,  double rmse,  double accuracy)  $default,) {final _that = this;
switch (_that) {
case _ForecastConfidence():
return $default(_that.mae,_that.rmse,_that.accuracy);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double mae,  double rmse,  double accuracy)?  $default,) {final _that = this;
switch (_that) {
case _ForecastConfidence() when $default != null:
return $default(_that.mae,_that.rmse,_that.accuracy);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ForecastConfidence implements ForecastConfidence {
  const _ForecastConfidence({required this.mae, required this.rmse, required this.accuracy});
  factory _ForecastConfidence.fromJson(Map<String, dynamic> json) => _$ForecastConfidenceFromJson(json);

@override final  double mae;
@override final  double rmse;
@override final  double accuracy;

/// Create a copy of ForecastConfidence
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ForecastConfidenceCopyWith<_ForecastConfidence> get copyWith => __$ForecastConfidenceCopyWithImpl<_ForecastConfidence>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ForecastConfidenceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ForecastConfidence&&(identical(other.mae, mae) || other.mae == mae)&&(identical(other.rmse, rmse) || other.rmse == rmse)&&(identical(other.accuracy, accuracy) || other.accuracy == accuracy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mae,rmse,accuracy);

@override
String toString() {
  return 'ForecastConfidence(mae: $mae, rmse: $rmse, accuracy: $accuracy)';
}


}

/// @nodoc
abstract mixin class _$ForecastConfidenceCopyWith<$Res> implements $ForecastConfidenceCopyWith<$Res> {
  factory _$ForecastConfidenceCopyWith(_ForecastConfidence value, $Res Function(_ForecastConfidence) _then) = __$ForecastConfidenceCopyWithImpl;
@override @useResult
$Res call({
 double mae, double rmse, double accuracy
});




}
/// @nodoc
class __$ForecastConfidenceCopyWithImpl<$Res>
    implements _$ForecastConfidenceCopyWith<$Res> {
  __$ForecastConfidenceCopyWithImpl(this._self, this._then);

  final _ForecastConfidence _self;
  final $Res Function(_ForecastConfidence) _then;

/// Create a copy of ForecastConfidence
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mae = null,Object? rmse = null,Object? accuracy = null,}) {
  return _then(_ForecastConfidence(
mae: null == mae ? _self.mae : mae // ignore: cast_nullable_to_non_nullable
as double,rmse: null == rmse ? _self.rmse : rmse // ignore: cast_nullable_to_non_nullable
as double,accuracy: null == accuracy ? _self.accuracy : accuracy // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$WorkforcePlan {

 int get currentCapacity; int get requiredCapacity; int get surplus; double get utilizationRate; String get recommendation;
/// Create a copy of WorkforcePlan
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WorkforcePlanCopyWith<WorkforcePlan> get copyWith => _$WorkforcePlanCopyWithImpl<WorkforcePlan>(this as WorkforcePlan, _$identity);

  /// Serializes this WorkforcePlan to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WorkforcePlan&&(identical(other.currentCapacity, currentCapacity) || other.currentCapacity == currentCapacity)&&(identical(other.requiredCapacity, requiredCapacity) || other.requiredCapacity == requiredCapacity)&&(identical(other.surplus, surplus) || other.surplus == surplus)&&(identical(other.utilizationRate, utilizationRate) || other.utilizationRate == utilizationRate)&&(identical(other.recommendation, recommendation) || other.recommendation == recommendation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,currentCapacity,requiredCapacity,surplus,utilizationRate,recommendation);

@override
String toString() {
  return 'WorkforcePlan(currentCapacity: $currentCapacity, requiredCapacity: $requiredCapacity, surplus: $surplus, utilizationRate: $utilizationRate, recommendation: $recommendation)';
}


}

/// @nodoc
abstract mixin class $WorkforcePlanCopyWith<$Res>  {
  factory $WorkforcePlanCopyWith(WorkforcePlan value, $Res Function(WorkforcePlan) _then) = _$WorkforcePlanCopyWithImpl;
@useResult
$Res call({
 int currentCapacity, int requiredCapacity, int surplus, double utilizationRate, String recommendation
});




}
/// @nodoc
class _$WorkforcePlanCopyWithImpl<$Res>
    implements $WorkforcePlanCopyWith<$Res> {
  _$WorkforcePlanCopyWithImpl(this._self, this._then);

  final WorkforcePlan _self;
  final $Res Function(WorkforcePlan) _then;

/// Create a copy of WorkforcePlan
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currentCapacity = null,Object? requiredCapacity = null,Object? surplus = null,Object? utilizationRate = null,Object? recommendation = null,}) {
  return _then(_self.copyWith(
currentCapacity: null == currentCapacity ? _self.currentCapacity : currentCapacity // ignore: cast_nullable_to_non_nullable
as int,requiredCapacity: null == requiredCapacity ? _self.requiredCapacity : requiredCapacity // ignore: cast_nullable_to_non_nullable
as int,surplus: null == surplus ? _self.surplus : surplus // ignore: cast_nullable_to_non_nullable
as int,utilizationRate: null == utilizationRate ? _self.utilizationRate : utilizationRate // ignore: cast_nullable_to_non_nullable
as double,recommendation: null == recommendation ? _self.recommendation : recommendation // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [WorkforcePlan].
extension WorkforcePlanPatterns on WorkforcePlan {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WorkforcePlan value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WorkforcePlan() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WorkforcePlan value)  $default,){
final _that = this;
switch (_that) {
case _WorkforcePlan():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WorkforcePlan value)?  $default,){
final _that = this;
switch (_that) {
case _WorkforcePlan() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int currentCapacity,  int requiredCapacity,  int surplus,  double utilizationRate,  String recommendation)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WorkforcePlan() when $default != null:
return $default(_that.currentCapacity,_that.requiredCapacity,_that.surplus,_that.utilizationRate,_that.recommendation);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int currentCapacity,  int requiredCapacity,  int surplus,  double utilizationRate,  String recommendation)  $default,) {final _that = this;
switch (_that) {
case _WorkforcePlan():
return $default(_that.currentCapacity,_that.requiredCapacity,_that.surplus,_that.utilizationRate,_that.recommendation);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int currentCapacity,  int requiredCapacity,  int surplus,  double utilizationRate,  String recommendation)?  $default,) {final _that = this;
switch (_that) {
case _WorkforcePlan() when $default != null:
return $default(_that.currentCapacity,_that.requiredCapacity,_that.surplus,_that.utilizationRate,_that.recommendation);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WorkforcePlan implements WorkforcePlan {
  const _WorkforcePlan({required this.currentCapacity, required this.requiredCapacity, required this.surplus, required this.utilizationRate, required this.recommendation});
  factory _WorkforcePlan.fromJson(Map<String, dynamic> json) => _$WorkforcePlanFromJson(json);

@override final  int currentCapacity;
@override final  int requiredCapacity;
@override final  int surplus;
@override final  double utilizationRate;
@override final  String recommendation;

/// Create a copy of WorkforcePlan
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WorkforcePlanCopyWith<_WorkforcePlan> get copyWith => __$WorkforcePlanCopyWithImpl<_WorkforcePlan>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WorkforcePlanToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WorkforcePlan&&(identical(other.currentCapacity, currentCapacity) || other.currentCapacity == currentCapacity)&&(identical(other.requiredCapacity, requiredCapacity) || other.requiredCapacity == requiredCapacity)&&(identical(other.surplus, surplus) || other.surplus == surplus)&&(identical(other.utilizationRate, utilizationRate) || other.utilizationRate == utilizationRate)&&(identical(other.recommendation, recommendation) || other.recommendation == recommendation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,currentCapacity,requiredCapacity,surplus,utilizationRate,recommendation);

@override
String toString() {
  return 'WorkforcePlan(currentCapacity: $currentCapacity, requiredCapacity: $requiredCapacity, surplus: $surplus, utilizationRate: $utilizationRate, recommendation: $recommendation)';
}


}

/// @nodoc
abstract mixin class _$WorkforcePlanCopyWith<$Res> implements $WorkforcePlanCopyWith<$Res> {
  factory _$WorkforcePlanCopyWith(_WorkforcePlan value, $Res Function(_WorkforcePlan) _then) = __$WorkforcePlanCopyWithImpl;
@override @useResult
$Res call({
 int currentCapacity, int requiredCapacity, int surplus, double utilizationRate, String recommendation
});




}
/// @nodoc
class __$WorkforcePlanCopyWithImpl<$Res>
    implements _$WorkforcePlanCopyWith<$Res> {
  __$WorkforcePlanCopyWithImpl(this._self, this._then);

  final _WorkforcePlan _self;
  final $Res Function(_WorkforcePlan) _then;

/// Create a copy of WorkforcePlan
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currentCapacity = null,Object? requiredCapacity = null,Object? surplus = null,Object? utilizationRate = null,Object? recommendation = null,}) {
  return _then(_WorkforcePlan(
currentCapacity: null == currentCapacity ? _self.currentCapacity : currentCapacity // ignore: cast_nullable_to_non_nullable
as int,requiredCapacity: null == requiredCapacity ? _self.requiredCapacity : requiredCapacity // ignore: cast_nullable_to_non_nullable
as int,surplus: null == surplus ? _self.surplus : surplus // ignore: cast_nullable_to_non_nullable
as int,utilizationRate: null == utilizationRate ? _self.utilizationRate : utilizationRate // ignore: cast_nullable_to_non_nullable
as double,recommendation: null == recommendation ? _self.recommendation : recommendation // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$SkillGap {

 String get skill; int get current; int get required; int get gap;
/// Create a copy of SkillGap
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SkillGapCopyWith<SkillGap> get copyWith => _$SkillGapCopyWithImpl<SkillGap>(this as SkillGap, _$identity);

  /// Serializes this SkillGap to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SkillGap&&(identical(other.skill, skill) || other.skill == skill)&&(identical(other.current, current) || other.current == current)&&(identical(other.required, required) || other.required == required)&&(identical(other.gap, gap) || other.gap == gap));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,skill,current,required,gap);

@override
String toString() {
  return 'SkillGap(skill: $skill, current: $current, required: $required, gap: $gap)';
}


}

/// @nodoc
abstract mixin class $SkillGapCopyWith<$Res>  {
  factory $SkillGapCopyWith(SkillGap value, $Res Function(SkillGap) _then) = _$SkillGapCopyWithImpl;
@useResult
$Res call({
 String skill, int current, int required, int gap
});




}
/// @nodoc
class _$SkillGapCopyWithImpl<$Res>
    implements $SkillGapCopyWith<$Res> {
  _$SkillGapCopyWithImpl(this._self, this._then);

  final SkillGap _self;
  final $Res Function(SkillGap) _then;

/// Create a copy of SkillGap
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? skill = null,Object? current = null,Object? required = null,Object? gap = null,}) {
  return _then(_self.copyWith(
skill: null == skill ? _self.skill : skill // ignore: cast_nullable_to_non_nullable
as String,current: null == current ? _self.current : current // ignore: cast_nullable_to_non_nullable
as int,required: null == required ? _self.required : required // ignore: cast_nullable_to_non_nullable
as int,gap: null == gap ? _self.gap : gap // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SkillGap].
extension SkillGapPatterns on SkillGap {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SkillGap value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SkillGap() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SkillGap value)  $default,){
final _that = this;
switch (_that) {
case _SkillGap():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SkillGap value)?  $default,){
final _that = this;
switch (_that) {
case _SkillGap() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String skill,  int current,  int required,  int gap)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SkillGap() when $default != null:
return $default(_that.skill,_that.current,_that.required,_that.gap);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String skill,  int current,  int required,  int gap)  $default,) {final _that = this;
switch (_that) {
case _SkillGap():
return $default(_that.skill,_that.current,_that.required,_that.gap);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String skill,  int current,  int required,  int gap)?  $default,) {final _that = this;
switch (_that) {
case _SkillGap() when $default != null:
return $default(_that.skill,_that.current,_that.required,_that.gap);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SkillGap implements SkillGap {
  const _SkillGap({required this.skill, required this.current, required this.required, required this.gap});
  factory _SkillGap.fromJson(Map<String, dynamic> json) => _$SkillGapFromJson(json);

@override final  String skill;
@override final  int current;
@override final  int required;
@override final  int gap;

/// Create a copy of SkillGap
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SkillGapCopyWith<_SkillGap> get copyWith => __$SkillGapCopyWithImpl<_SkillGap>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SkillGapToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SkillGap&&(identical(other.skill, skill) || other.skill == skill)&&(identical(other.current, current) || other.current == current)&&(identical(other.required, required) || other.required == required)&&(identical(other.gap, gap) || other.gap == gap));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,skill,current,required,gap);

@override
String toString() {
  return 'SkillGap(skill: $skill, current: $current, required: $required, gap: $gap)';
}


}

/// @nodoc
abstract mixin class _$SkillGapCopyWith<$Res> implements $SkillGapCopyWith<$Res> {
  factory _$SkillGapCopyWith(_SkillGap value, $Res Function(_SkillGap) _then) = __$SkillGapCopyWithImpl;
@override @useResult
$Res call({
 String skill, int current, int required, int gap
});




}
/// @nodoc
class __$SkillGapCopyWithImpl<$Res>
    implements _$SkillGapCopyWith<$Res> {
  __$SkillGapCopyWithImpl(this._self, this._then);

  final _SkillGap _self;
  final $Res Function(_SkillGap) _then;

/// Create a copy of SkillGap
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? skill = null,Object? current = null,Object? required = null,Object? gap = null,}) {
  return _then(_SkillGap(
skill: null == skill ? _self.skill : skill // ignore: cast_nullable_to_non_nullable
as String,current: null == current ? _self.current : current // ignore: cast_nullable_to_non_nullable
as int,required: null == required ? _self.required : required // ignore: cast_nullable_to_non_nullable
as int,gap: null == gap ? _self.gap : gap // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$TurnoverPrediction {

 String get employeeId; double get riskScore; String get riskLevel; List<String> get factors; List<String> get recommendations;
/// Create a copy of TurnoverPrediction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TurnoverPredictionCopyWith<TurnoverPrediction> get copyWith => _$TurnoverPredictionCopyWithImpl<TurnoverPrediction>(this as TurnoverPrediction, _$identity);

  /// Serializes this TurnoverPrediction to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TurnoverPrediction&&(identical(other.employeeId, employeeId) || other.employeeId == employeeId)&&(identical(other.riskScore, riskScore) || other.riskScore == riskScore)&&(identical(other.riskLevel, riskLevel) || other.riskLevel == riskLevel)&&const DeepCollectionEquality().equals(other.factors, factors)&&const DeepCollectionEquality().equals(other.recommendations, recommendations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,employeeId,riskScore,riskLevel,const DeepCollectionEquality().hash(factors),const DeepCollectionEquality().hash(recommendations));

@override
String toString() {
  return 'TurnoverPrediction(employeeId: $employeeId, riskScore: $riskScore, riskLevel: $riskLevel, factors: $factors, recommendations: $recommendations)';
}


}

/// @nodoc
abstract mixin class $TurnoverPredictionCopyWith<$Res>  {
  factory $TurnoverPredictionCopyWith(TurnoverPrediction value, $Res Function(TurnoverPrediction) _then) = _$TurnoverPredictionCopyWithImpl;
@useResult
$Res call({
 String employeeId, double riskScore, String riskLevel, List<String> factors, List<String> recommendations
});




}
/// @nodoc
class _$TurnoverPredictionCopyWithImpl<$Res>
    implements $TurnoverPredictionCopyWith<$Res> {
  _$TurnoverPredictionCopyWithImpl(this._self, this._then);

  final TurnoverPrediction _self;
  final $Res Function(TurnoverPrediction) _then;

/// Create a copy of TurnoverPrediction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? employeeId = null,Object? riskScore = null,Object? riskLevel = null,Object? factors = null,Object? recommendations = null,}) {
  return _then(_self.copyWith(
employeeId: null == employeeId ? _self.employeeId : employeeId // ignore: cast_nullable_to_non_nullable
as String,riskScore: null == riskScore ? _self.riskScore : riskScore // ignore: cast_nullable_to_non_nullable
as double,riskLevel: null == riskLevel ? _self.riskLevel : riskLevel // ignore: cast_nullable_to_non_nullable
as String,factors: null == factors ? _self.factors : factors // ignore: cast_nullable_to_non_nullable
as List<String>,recommendations: null == recommendations ? _self.recommendations : recommendations // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [TurnoverPrediction].
extension TurnoverPredictionPatterns on TurnoverPrediction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TurnoverPrediction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TurnoverPrediction() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TurnoverPrediction value)  $default,){
final _that = this;
switch (_that) {
case _TurnoverPrediction():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TurnoverPrediction value)?  $default,){
final _that = this;
switch (_that) {
case _TurnoverPrediction() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String employeeId,  double riskScore,  String riskLevel,  List<String> factors,  List<String> recommendations)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TurnoverPrediction() when $default != null:
return $default(_that.employeeId,_that.riskScore,_that.riskLevel,_that.factors,_that.recommendations);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String employeeId,  double riskScore,  String riskLevel,  List<String> factors,  List<String> recommendations)  $default,) {final _that = this;
switch (_that) {
case _TurnoverPrediction():
return $default(_that.employeeId,_that.riskScore,_that.riskLevel,_that.factors,_that.recommendations);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String employeeId,  double riskScore,  String riskLevel,  List<String> factors,  List<String> recommendations)?  $default,) {final _that = this;
switch (_that) {
case _TurnoverPrediction() when $default != null:
return $default(_that.employeeId,_that.riskScore,_that.riskLevel,_that.factors,_that.recommendations);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TurnoverPrediction implements TurnoverPrediction {
  const _TurnoverPrediction({required this.employeeId, required this.riskScore, required this.riskLevel, required final  List<String> factors, required final  List<String> recommendations}): _factors = factors,_recommendations = recommendations;
  factory _TurnoverPrediction.fromJson(Map<String, dynamic> json) => _$TurnoverPredictionFromJson(json);

@override final  String employeeId;
@override final  double riskScore;
@override final  String riskLevel;
 final  List<String> _factors;
@override List<String> get factors {
  if (_factors is EqualUnmodifiableListView) return _factors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_factors);
}

 final  List<String> _recommendations;
@override List<String> get recommendations {
  if (_recommendations is EqualUnmodifiableListView) return _recommendations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recommendations);
}


/// Create a copy of TurnoverPrediction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TurnoverPredictionCopyWith<_TurnoverPrediction> get copyWith => __$TurnoverPredictionCopyWithImpl<_TurnoverPrediction>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TurnoverPredictionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TurnoverPrediction&&(identical(other.employeeId, employeeId) || other.employeeId == employeeId)&&(identical(other.riskScore, riskScore) || other.riskScore == riskScore)&&(identical(other.riskLevel, riskLevel) || other.riskLevel == riskLevel)&&const DeepCollectionEquality().equals(other._factors, _factors)&&const DeepCollectionEquality().equals(other._recommendations, _recommendations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,employeeId,riskScore,riskLevel,const DeepCollectionEquality().hash(_factors),const DeepCollectionEquality().hash(_recommendations));

@override
String toString() {
  return 'TurnoverPrediction(employeeId: $employeeId, riskScore: $riskScore, riskLevel: $riskLevel, factors: $factors, recommendations: $recommendations)';
}


}

/// @nodoc
abstract mixin class _$TurnoverPredictionCopyWith<$Res> implements $TurnoverPredictionCopyWith<$Res> {
  factory _$TurnoverPredictionCopyWith(_TurnoverPrediction value, $Res Function(_TurnoverPrediction) _then) = __$TurnoverPredictionCopyWithImpl;
@override @useResult
$Res call({
 String employeeId, double riskScore, String riskLevel, List<String> factors, List<String> recommendations
});




}
/// @nodoc
class __$TurnoverPredictionCopyWithImpl<$Res>
    implements _$TurnoverPredictionCopyWith<$Res> {
  __$TurnoverPredictionCopyWithImpl(this._self, this._then);

  final _TurnoverPrediction _self;
  final $Res Function(_TurnoverPrediction) _then;

/// Create a copy of TurnoverPrediction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? employeeId = null,Object? riskScore = null,Object? riskLevel = null,Object? factors = null,Object? recommendations = null,}) {
  return _then(_TurnoverPrediction(
employeeId: null == employeeId ? _self.employeeId : employeeId // ignore: cast_nullable_to_non_nullable
as String,riskScore: null == riskScore ? _self.riskScore : riskScore // ignore: cast_nullable_to_non_nullable
as double,riskLevel: null == riskLevel ? _self.riskLevel : riskLevel // ignore: cast_nullable_to_non_nullable
as String,factors: null == factors ? _self._factors : factors // ignore: cast_nullable_to_non_nullable
as List<String>,recommendations: null == recommendations ? _self._recommendations : recommendations // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$ScenarioAnalysis {

 String get name; double get projectedRevenue; double get projectedCost; double get netBenefit; String get feasibility; double get roi;
/// Create a copy of ScenarioAnalysis
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScenarioAnalysisCopyWith<ScenarioAnalysis> get copyWith => _$ScenarioAnalysisCopyWithImpl<ScenarioAnalysis>(this as ScenarioAnalysis, _$identity);

  /// Serializes this ScenarioAnalysis to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScenarioAnalysis&&(identical(other.name, name) || other.name == name)&&(identical(other.projectedRevenue, projectedRevenue) || other.projectedRevenue == projectedRevenue)&&(identical(other.projectedCost, projectedCost) || other.projectedCost == projectedCost)&&(identical(other.netBenefit, netBenefit) || other.netBenefit == netBenefit)&&(identical(other.feasibility, feasibility) || other.feasibility == feasibility)&&(identical(other.roi, roi) || other.roi == roi));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,projectedRevenue,projectedCost,netBenefit,feasibility,roi);

@override
String toString() {
  return 'ScenarioAnalysis(name: $name, projectedRevenue: $projectedRevenue, projectedCost: $projectedCost, netBenefit: $netBenefit, feasibility: $feasibility, roi: $roi)';
}


}

/// @nodoc
abstract mixin class $ScenarioAnalysisCopyWith<$Res>  {
  factory $ScenarioAnalysisCopyWith(ScenarioAnalysis value, $Res Function(ScenarioAnalysis) _then) = _$ScenarioAnalysisCopyWithImpl;
@useResult
$Res call({
 String name, double projectedRevenue, double projectedCost, double netBenefit, String feasibility, double roi
});




}
/// @nodoc
class _$ScenarioAnalysisCopyWithImpl<$Res>
    implements $ScenarioAnalysisCopyWith<$Res> {
  _$ScenarioAnalysisCopyWithImpl(this._self, this._then);

  final ScenarioAnalysis _self;
  final $Res Function(ScenarioAnalysis) _then;

/// Create a copy of ScenarioAnalysis
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? projectedRevenue = null,Object? projectedCost = null,Object? netBenefit = null,Object? feasibility = null,Object? roi = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,projectedRevenue: null == projectedRevenue ? _self.projectedRevenue : projectedRevenue // ignore: cast_nullable_to_non_nullable
as double,projectedCost: null == projectedCost ? _self.projectedCost : projectedCost // ignore: cast_nullable_to_non_nullable
as double,netBenefit: null == netBenefit ? _self.netBenefit : netBenefit // ignore: cast_nullable_to_non_nullable
as double,feasibility: null == feasibility ? _self.feasibility : feasibility // ignore: cast_nullable_to_non_nullable
as String,roi: null == roi ? _self.roi : roi // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [ScenarioAnalysis].
extension ScenarioAnalysisPatterns on ScenarioAnalysis {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScenarioAnalysis value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScenarioAnalysis() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScenarioAnalysis value)  $default,){
final _that = this;
switch (_that) {
case _ScenarioAnalysis():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScenarioAnalysis value)?  $default,){
final _that = this;
switch (_that) {
case _ScenarioAnalysis() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  double projectedRevenue,  double projectedCost,  double netBenefit,  String feasibility,  double roi)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScenarioAnalysis() when $default != null:
return $default(_that.name,_that.projectedRevenue,_that.projectedCost,_that.netBenefit,_that.feasibility,_that.roi);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  double projectedRevenue,  double projectedCost,  double netBenefit,  String feasibility,  double roi)  $default,) {final _that = this;
switch (_that) {
case _ScenarioAnalysis():
return $default(_that.name,_that.projectedRevenue,_that.projectedCost,_that.netBenefit,_that.feasibility,_that.roi);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  double projectedRevenue,  double projectedCost,  double netBenefit,  String feasibility,  double roi)?  $default,) {final _that = this;
switch (_that) {
case _ScenarioAnalysis() when $default != null:
return $default(_that.name,_that.projectedRevenue,_that.projectedCost,_that.netBenefit,_that.feasibility,_that.roi);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ScenarioAnalysis implements ScenarioAnalysis {
  const _ScenarioAnalysis({required this.name, required this.projectedRevenue, required this.projectedCost, required this.netBenefit, required this.feasibility, required this.roi});
  factory _ScenarioAnalysis.fromJson(Map<String, dynamic> json) => _$ScenarioAnalysisFromJson(json);

@override final  String name;
@override final  double projectedRevenue;
@override final  double projectedCost;
@override final  double netBenefit;
@override final  String feasibility;
@override final  double roi;

/// Create a copy of ScenarioAnalysis
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScenarioAnalysisCopyWith<_ScenarioAnalysis> get copyWith => __$ScenarioAnalysisCopyWithImpl<_ScenarioAnalysis>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ScenarioAnalysisToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScenarioAnalysis&&(identical(other.name, name) || other.name == name)&&(identical(other.projectedRevenue, projectedRevenue) || other.projectedRevenue == projectedRevenue)&&(identical(other.projectedCost, projectedCost) || other.projectedCost == projectedCost)&&(identical(other.netBenefit, netBenefit) || other.netBenefit == netBenefit)&&(identical(other.feasibility, feasibility) || other.feasibility == feasibility)&&(identical(other.roi, roi) || other.roi == roi));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,projectedRevenue,projectedCost,netBenefit,feasibility,roi);

@override
String toString() {
  return 'ScenarioAnalysis(name: $name, projectedRevenue: $projectedRevenue, projectedCost: $projectedCost, netBenefit: $netBenefit, feasibility: $feasibility, roi: $roi)';
}


}

/// @nodoc
abstract mixin class _$ScenarioAnalysisCopyWith<$Res> implements $ScenarioAnalysisCopyWith<$Res> {
  factory _$ScenarioAnalysisCopyWith(_ScenarioAnalysis value, $Res Function(_ScenarioAnalysis) _then) = __$ScenarioAnalysisCopyWithImpl;
@override @useResult
$Res call({
 String name, double projectedRevenue, double projectedCost, double netBenefit, String feasibility, double roi
});




}
/// @nodoc
class __$ScenarioAnalysisCopyWithImpl<$Res>
    implements _$ScenarioAnalysisCopyWith<$Res> {
  __$ScenarioAnalysisCopyWithImpl(this._self, this._then);

  final _ScenarioAnalysis _self;
  final $Res Function(_ScenarioAnalysis) _then;

/// Create a copy of ScenarioAnalysis
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? projectedRevenue = null,Object? projectedCost = null,Object? netBenefit = null,Object? feasibility = null,Object? roi = null,}) {
  return _then(_ScenarioAnalysis(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,projectedRevenue: null == projectedRevenue ? _self.projectedRevenue : projectedRevenue // ignore: cast_nullable_to_non_nullable
as double,projectedCost: null == projectedCost ? _self.projectedCost : projectedCost // ignore: cast_nullable_to_non_nullable
as double,netBenefit: null == netBenefit ? _self.netBenefit : netBenefit // ignore: cast_nullable_to_non_nullable
as double,feasibility: null == feasibility ? _self.feasibility : feasibility // ignore: cast_nullable_to_non_nullable
as String,roi: null == roi ? _self.roi : roi // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$ResourceAllocation {

 String get appointmentId; String get workerId; double get score; double get cost;
/// Create a copy of ResourceAllocation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResourceAllocationCopyWith<ResourceAllocation> get copyWith => _$ResourceAllocationCopyWithImpl<ResourceAllocation>(this as ResourceAllocation, _$identity);

  /// Serializes this ResourceAllocation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResourceAllocation&&(identical(other.appointmentId, appointmentId) || other.appointmentId == appointmentId)&&(identical(other.workerId, workerId) || other.workerId == workerId)&&(identical(other.score, score) || other.score == score)&&(identical(other.cost, cost) || other.cost == cost));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,appointmentId,workerId,score,cost);

@override
String toString() {
  return 'ResourceAllocation(appointmentId: $appointmentId, workerId: $workerId, score: $score, cost: $cost)';
}


}

/// @nodoc
abstract mixin class $ResourceAllocationCopyWith<$Res>  {
  factory $ResourceAllocationCopyWith(ResourceAllocation value, $Res Function(ResourceAllocation) _then) = _$ResourceAllocationCopyWithImpl;
@useResult
$Res call({
 String appointmentId, String workerId, double score, double cost
});




}
/// @nodoc
class _$ResourceAllocationCopyWithImpl<$Res>
    implements $ResourceAllocationCopyWith<$Res> {
  _$ResourceAllocationCopyWithImpl(this._self, this._then);

  final ResourceAllocation _self;
  final $Res Function(ResourceAllocation) _then;

/// Create a copy of ResourceAllocation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? appointmentId = null,Object? workerId = null,Object? score = null,Object? cost = null,}) {
  return _then(_self.copyWith(
appointmentId: null == appointmentId ? _self.appointmentId : appointmentId // ignore: cast_nullable_to_non_nullable
as String,workerId: null == workerId ? _self.workerId : workerId // ignore: cast_nullable_to_non_nullable
as String,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as double,cost: null == cost ? _self.cost : cost // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [ResourceAllocation].
extension ResourceAllocationPatterns on ResourceAllocation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ResourceAllocation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ResourceAllocation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ResourceAllocation value)  $default,){
final _that = this;
switch (_that) {
case _ResourceAllocation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ResourceAllocation value)?  $default,){
final _that = this;
switch (_that) {
case _ResourceAllocation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String appointmentId,  String workerId,  double score,  double cost)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ResourceAllocation() when $default != null:
return $default(_that.appointmentId,_that.workerId,_that.score,_that.cost);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String appointmentId,  String workerId,  double score,  double cost)  $default,) {final _that = this;
switch (_that) {
case _ResourceAllocation():
return $default(_that.appointmentId,_that.workerId,_that.score,_that.cost);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String appointmentId,  String workerId,  double score,  double cost)?  $default,) {final _that = this;
switch (_that) {
case _ResourceAllocation() when $default != null:
return $default(_that.appointmentId,_that.workerId,_that.score,_that.cost);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ResourceAllocation implements ResourceAllocation {
  const _ResourceAllocation({required this.appointmentId, required this.workerId, required this.score, required this.cost});
  factory _ResourceAllocation.fromJson(Map<String, dynamic> json) => _$ResourceAllocationFromJson(json);

@override final  String appointmentId;
@override final  String workerId;
@override final  double score;
@override final  double cost;

/// Create a copy of ResourceAllocation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ResourceAllocationCopyWith<_ResourceAllocation> get copyWith => __$ResourceAllocationCopyWithImpl<_ResourceAllocation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ResourceAllocationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResourceAllocation&&(identical(other.appointmentId, appointmentId) || other.appointmentId == appointmentId)&&(identical(other.workerId, workerId) || other.workerId == workerId)&&(identical(other.score, score) || other.score == score)&&(identical(other.cost, cost) || other.cost == cost));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,appointmentId,workerId,score,cost);

@override
String toString() {
  return 'ResourceAllocation(appointmentId: $appointmentId, workerId: $workerId, score: $score, cost: $cost)';
}


}

/// @nodoc
abstract mixin class _$ResourceAllocationCopyWith<$Res> implements $ResourceAllocationCopyWith<$Res> {
  factory _$ResourceAllocationCopyWith(_ResourceAllocation value, $Res Function(_ResourceAllocation) _then) = __$ResourceAllocationCopyWithImpl;
@override @useResult
$Res call({
 String appointmentId, String workerId, double score, double cost
});




}
/// @nodoc
class __$ResourceAllocationCopyWithImpl<$Res>
    implements _$ResourceAllocationCopyWith<$Res> {
  __$ResourceAllocationCopyWithImpl(this._self, this._then);

  final _ResourceAllocation _self;
  final $Res Function(_ResourceAllocation) _then;

/// Create a copy of ResourceAllocation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? appointmentId = null,Object? workerId = null,Object? score = null,Object? cost = null,}) {
  return _then(_ResourceAllocation(
appointmentId: null == appointmentId ? _self.appointmentId : appointmentId // ignore: cast_nullable_to_non_nullable
as String,workerId: null == workerId ? _self.workerId : workerId // ignore: cast_nullable_to_non_nullable
as String,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as double,cost: null == cost ? _self.cost : cost // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$AllocationMetrics {

 int get totalAllocations; double get averageScore; double get totalCost; double get utilizationRate; int get unassignedCount; int get conflictCount;
/// Create a copy of AllocationMetrics
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AllocationMetricsCopyWith<AllocationMetrics> get copyWith => _$AllocationMetricsCopyWithImpl<AllocationMetrics>(this as AllocationMetrics, _$identity);

  /// Serializes this AllocationMetrics to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AllocationMetrics&&(identical(other.totalAllocations, totalAllocations) || other.totalAllocations == totalAllocations)&&(identical(other.averageScore, averageScore) || other.averageScore == averageScore)&&(identical(other.totalCost, totalCost) || other.totalCost == totalCost)&&(identical(other.utilizationRate, utilizationRate) || other.utilizationRate == utilizationRate)&&(identical(other.unassignedCount, unassignedCount) || other.unassignedCount == unassignedCount)&&(identical(other.conflictCount, conflictCount) || other.conflictCount == conflictCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalAllocations,averageScore,totalCost,utilizationRate,unassignedCount,conflictCount);

@override
String toString() {
  return 'AllocationMetrics(totalAllocations: $totalAllocations, averageScore: $averageScore, totalCost: $totalCost, utilizationRate: $utilizationRate, unassignedCount: $unassignedCount, conflictCount: $conflictCount)';
}


}

/// @nodoc
abstract mixin class $AllocationMetricsCopyWith<$Res>  {
  factory $AllocationMetricsCopyWith(AllocationMetrics value, $Res Function(AllocationMetrics) _then) = _$AllocationMetricsCopyWithImpl;
@useResult
$Res call({
 int totalAllocations, double averageScore, double totalCost, double utilizationRate, int unassignedCount, int conflictCount
});




}
/// @nodoc
class _$AllocationMetricsCopyWithImpl<$Res>
    implements $AllocationMetricsCopyWith<$Res> {
  _$AllocationMetricsCopyWithImpl(this._self, this._then);

  final AllocationMetrics _self;
  final $Res Function(AllocationMetrics) _then;

/// Create a copy of AllocationMetrics
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalAllocations = null,Object? averageScore = null,Object? totalCost = null,Object? utilizationRate = null,Object? unassignedCount = null,Object? conflictCount = null,}) {
  return _then(_self.copyWith(
totalAllocations: null == totalAllocations ? _self.totalAllocations : totalAllocations // ignore: cast_nullable_to_non_nullable
as int,averageScore: null == averageScore ? _self.averageScore : averageScore // ignore: cast_nullable_to_non_nullable
as double,totalCost: null == totalCost ? _self.totalCost : totalCost // ignore: cast_nullable_to_non_nullable
as double,utilizationRate: null == utilizationRate ? _self.utilizationRate : utilizationRate // ignore: cast_nullable_to_non_nullable
as double,unassignedCount: null == unassignedCount ? _self.unassignedCount : unassignedCount // ignore: cast_nullable_to_non_nullable
as int,conflictCount: null == conflictCount ? _self.conflictCount : conflictCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [AllocationMetrics].
extension AllocationMetricsPatterns on AllocationMetrics {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AllocationMetrics value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AllocationMetrics() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AllocationMetrics value)  $default,){
final _that = this;
switch (_that) {
case _AllocationMetrics():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AllocationMetrics value)?  $default,){
final _that = this;
switch (_that) {
case _AllocationMetrics() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int totalAllocations,  double averageScore,  double totalCost,  double utilizationRate,  int unassignedCount,  int conflictCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AllocationMetrics() when $default != null:
return $default(_that.totalAllocations,_that.averageScore,_that.totalCost,_that.utilizationRate,_that.unassignedCount,_that.conflictCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int totalAllocations,  double averageScore,  double totalCost,  double utilizationRate,  int unassignedCount,  int conflictCount)  $default,) {final _that = this;
switch (_that) {
case _AllocationMetrics():
return $default(_that.totalAllocations,_that.averageScore,_that.totalCost,_that.utilizationRate,_that.unassignedCount,_that.conflictCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int totalAllocations,  double averageScore,  double totalCost,  double utilizationRate,  int unassignedCount,  int conflictCount)?  $default,) {final _that = this;
switch (_that) {
case _AllocationMetrics() when $default != null:
return $default(_that.totalAllocations,_that.averageScore,_that.totalCost,_that.utilizationRate,_that.unassignedCount,_that.conflictCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AllocationMetrics implements AllocationMetrics {
  const _AllocationMetrics({required this.totalAllocations, required this.averageScore, required this.totalCost, required this.utilizationRate, required this.unassignedCount, required this.conflictCount});
  factory _AllocationMetrics.fromJson(Map<String, dynamic> json) => _$AllocationMetricsFromJson(json);

@override final  int totalAllocations;
@override final  double averageScore;
@override final  double totalCost;
@override final  double utilizationRate;
@override final  int unassignedCount;
@override final  int conflictCount;

/// Create a copy of AllocationMetrics
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AllocationMetricsCopyWith<_AllocationMetrics> get copyWith => __$AllocationMetricsCopyWithImpl<_AllocationMetrics>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AllocationMetricsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AllocationMetrics&&(identical(other.totalAllocations, totalAllocations) || other.totalAllocations == totalAllocations)&&(identical(other.averageScore, averageScore) || other.averageScore == averageScore)&&(identical(other.totalCost, totalCost) || other.totalCost == totalCost)&&(identical(other.utilizationRate, utilizationRate) || other.utilizationRate == utilizationRate)&&(identical(other.unassignedCount, unassignedCount) || other.unassignedCount == unassignedCount)&&(identical(other.conflictCount, conflictCount) || other.conflictCount == conflictCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalAllocations,averageScore,totalCost,utilizationRate,unassignedCount,conflictCount);

@override
String toString() {
  return 'AllocationMetrics(totalAllocations: $totalAllocations, averageScore: $averageScore, totalCost: $totalCost, utilizationRate: $utilizationRate, unassignedCount: $unassignedCount, conflictCount: $conflictCount)';
}


}

/// @nodoc
abstract mixin class _$AllocationMetricsCopyWith<$Res> implements $AllocationMetricsCopyWith<$Res> {
  factory _$AllocationMetricsCopyWith(_AllocationMetrics value, $Res Function(_AllocationMetrics) _then) = __$AllocationMetricsCopyWithImpl;
@override @useResult
$Res call({
 int totalAllocations, double averageScore, double totalCost, double utilizationRate, int unassignedCount, int conflictCount
});




}
/// @nodoc
class __$AllocationMetricsCopyWithImpl<$Res>
    implements _$AllocationMetricsCopyWith<$Res> {
  __$AllocationMetricsCopyWithImpl(this._self, this._then);

  final _AllocationMetrics _self;
  final $Res Function(_AllocationMetrics) _then;

/// Create a copy of AllocationMetrics
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalAllocations = null,Object? averageScore = null,Object? totalCost = null,Object? utilizationRate = null,Object? unassignedCount = null,Object? conflictCount = null,}) {
  return _then(_AllocationMetrics(
totalAllocations: null == totalAllocations ? _self.totalAllocations : totalAllocations // ignore: cast_nullable_to_non_nullable
as int,averageScore: null == averageScore ? _self.averageScore : averageScore // ignore: cast_nullable_to_non_nullable
as double,totalCost: null == totalCost ? _self.totalCost : totalCost // ignore: cast_nullable_to_non_nullable
as double,utilizationRate: null == utilizationRate ? _self.utilizationRate : utilizationRate // ignore: cast_nullable_to_non_nullable
as double,unassignedCount: null == unassignedCount ? _self.unassignedCount : unassignedCount // ignore: cast_nullable_to_non_nullable
as int,conflictCount: null == conflictCount ? _self.conflictCount : conflictCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$WorkerRecommendation {

 String get workerId; String get workerName; double get score; Map<String, dynamic> get factors; bool get availability;
/// Create a copy of WorkerRecommendation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WorkerRecommendationCopyWith<WorkerRecommendation> get copyWith => _$WorkerRecommendationCopyWithImpl<WorkerRecommendation>(this as WorkerRecommendation, _$identity);

  /// Serializes this WorkerRecommendation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WorkerRecommendation&&(identical(other.workerId, workerId) || other.workerId == workerId)&&(identical(other.workerName, workerName) || other.workerName == workerName)&&(identical(other.score, score) || other.score == score)&&const DeepCollectionEquality().equals(other.factors, factors)&&(identical(other.availability, availability) || other.availability == availability));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,workerId,workerName,score,const DeepCollectionEquality().hash(factors),availability);

@override
String toString() {
  return 'WorkerRecommendation(workerId: $workerId, workerName: $workerName, score: $score, factors: $factors, availability: $availability)';
}


}

/// @nodoc
abstract mixin class $WorkerRecommendationCopyWith<$Res>  {
  factory $WorkerRecommendationCopyWith(WorkerRecommendation value, $Res Function(WorkerRecommendation) _then) = _$WorkerRecommendationCopyWithImpl;
@useResult
$Res call({
 String workerId, String workerName, double score, Map<String, dynamic> factors, bool availability
});




}
/// @nodoc
class _$WorkerRecommendationCopyWithImpl<$Res>
    implements $WorkerRecommendationCopyWith<$Res> {
  _$WorkerRecommendationCopyWithImpl(this._self, this._then);

  final WorkerRecommendation _self;
  final $Res Function(WorkerRecommendation) _then;

/// Create a copy of WorkerRecommendation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? workerId = null,Object? workerName = null,Object? score = null,Object? factors = null,Object? availability = null,}) {
  return _then(_self.copyWith(
workerId: null == workerId ? _self.workerId : workerId // ignore: cast_nullable_to_non_nullable
as String,workerName: null == workerName ? _self.workerName : workerName // ignore: cast_nullable_to_non_nullable
as String,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as double,factors: null == factors ? _self.factors : factors // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,availability: null == availability ? _self.availability : availability // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [WorkerRecommendation].
extension WorkerRecommendationPatterns on WorkerRecommendation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WorkerRecommendation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WorkerRecommendation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WorkerRecommendation value)  $default,){
final _that = this;
switch (_that) {
case _WorkerRecommendation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WorkerRecommendation value)?  $default,){
final _that = this;
switch (_that) {
case _WorkerRecommendation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String workerId,  String workerName,  double score,  Map<String, dynamic> factors,  bool availability)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WorkerRecommendation() when $default != null:
return $default(_that.workerId,_that.workerName,_that.score,_that.factors,_that.availability);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String workerId,  String workerName,  double score,  Map<String, dynamic> factors,  bool availability)  $default,) {final _that = this;
switch (_that) {
case _WorkerRecommendation():
return $default(_that.workerId,_that.workerName,_that.score,_that.factors,_that.availability);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String workerId,  String workerName,  double score,  Map<String, dynamic> factors,  bool availability)?  $default,) {final _that = this;
switch (_that) {
case _WorkerRecommendation() when $default != null:
return $default(_that.workerId,_that.workerName,_that.score,_that.factors,_that.availability);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WorkerRecommendation implements WorkerRecommendation {
  const _WorkerRecommendation({required this.workerId, required this.workerName, required this.score, required final  Map<String, dynamic> factors, required this.availability}): _factors = factors;
  factory _WorkerRecommendation.fromJson(Map<String, dynamic> json) => _$WorkerRecommendationFromJson(json);

@override final  String workerId;
@override final  String workerName;
@override final  double score;
 final  Map<String, dynamic> _factors;
@override Map<String, dynamic> get factors {
  if (_factors is EqualUnmodifiableMapView) return _factors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_factors);
}

@override final  bool availability;

/// Create a copy of WorkerRecommendation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WorkerRecommendationCopyWith<_WorkerRecommendation> get copyWith => __$WorkerRecommendationCopyWithImpl<_WorkerRecommendation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WorkerRecommendationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WorkerRecommendation&&(identical(other.workerId, workerId) || other.workerId == workerId)&&(identical(other.workerName, workerName) || other.workerName == workerName)&&(identical(other.score, score) || other.score == score)&&const DeepCollectionEquality().equals(other._factors, _factors)&&(identical(other.availability, availability) || other.availability == availability));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,workerId,workerName,score,const DeepCollectionEquality().hash(_factors),availability);

@override
String toString() {
  return 'WorkerRecommendation(workerId: $workerId, workerName: $workerName, score: $score, factors: $factors, availability: $availability)';
}


}

/// @nodoc
abstract mixin class _$WorkerRecommendationCopyWith<$Res> implements $WorkerRecommendationCopyWith<$Res> {
  factory _$WorkerRecommendationCopyWith(_WorkerRecommendation value, $Res Function(_WorkerRecommendation) _then) = __$WorkerRecommendationCopyWithImpl;
@override @useResult
$Res call({
 String workerId, String workerName, double score, Map<String, dynamic> factors, bool availability
});




}
/// @nodoc
class __$WorkerRecommendationCopyWithImpl<$Res>
    implements _$WorkerRecommendationCopyWith<$Res> {
  __$WorkerRecommendationCopyWithImpl(this._self, this._then);

  final _WorkerRecommendation _self;
  final $Res Function(_WorkerRecommendation) _then;

/// Create a copy of WorkerRecommendation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? workerId = null,Object? workerName = null,Object? score = null,Object? factors = null,Object? availability = null,}) {
  return _then(_WorkerRecommendation(
workerId: null == workerId ? _self.workerId : workerId // ignore: cast_nullable_to_non_nullable
as String,workerName: null == workerName ? _self.workerName : workerName // ignore: cast_nullable_to_non_nullable
as String,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as double,factors: null == factors ? _self._factors : factors // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,availability: null == availability ? _self.availability : availability // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$WorkloadAnalysis {

 String get workerId; String get workerName; int get appointments; double get hours; double get utilization;
/// Create a copy of WorkloadAnalysis
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WorkloadAnalysisCopyWith<WorkloadAnalysis> get copyWith => _$WorkloadAnalysisCopyWithImpl<WorkloadAnalysis>(this as WorkloadAnalysis, _$identity);

  /// Serializes this WorkloadAnalysis to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WorkloadAnalysis&&(identical(other.workerId, workerId) || other.workerId == workerId)&&(identical(other.workerName, workerName) || other.workerName == workerName)&&(identical(other.appointments, appointments) || other.appointments == appointments)&&(identical(other.hours, hours) || other.hours == hours)&&(identical(other.utilization, utilization) || other.utilization == utilization));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,workerId,workerName,appointments,hours,utilization);

@override
String toString() {
  return 'WorkloadAnalysis(workerId: $workerId, workerName: $workerName, appointments: $appointments, hours: $hours, utilization: $utilization)';
}


}

/// @nodoc
abstract mixin class $WorkloadAnalysisCopyWith<$Res>  {
  factory $WorkloadAnalysisCopyWith(WorkloadAnalysis value, $Res Function(WorkloadAnalysis) _then) = _$WorkloadAnalysisCopyWithImpl;
@useResult
$Res call({
 String workerId, String workerName, int appointments, double hours, double utilization
});




}
/// @nodoc
class _$WorkloadAnalysisCopyWithImpl<$Res>
    implements $WorkloadAnalysisCopyWith<$Res> {
  _$WorkloadAnalysisCopyWithImpl(this._self, this._then);

  final WorkloadAnalysis _self;
  final $Res Function(WorkloadAnalysis) _then;

/// Create a copy of WorkloadAnalysis
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? workerId = null,Object? workerName = null,Object? appointments = null,Object? hours = null,Object? utilization = null,}) {
  return _then(_self.copyWith(
workerId: null == workerId ? _self.workerId : workerId // ignore: cast_nullable_to_non_nullable
as String,workerName: null == workerName ? _self.workerName : workerName // ignore: cast_nullable_to_non_nullable
as String,appointments: null == appointments ? _self.appointments : appointments // ignore: cast_nullable_to_non_nullable
as int,hours: null == hours ? _self.hours : hours // ignore: cast_nullable_to_non_nullable
as double,utilization: null == utilization ? _self.utilization : utilization // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [WorkloadAnalysis].
extension WorkloadAnalysisPatterns on WorkloadAnalysis {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WorkloadAnalysis value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WorkloadAnalysis() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WorkloadAnalysis value)  $default,){
final _that = this;
switch (_that) {
case _WorkloadAnalysis():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WorkloadAnalysis value)?  $default,){
final _that = this;
switch (_that) {
case _WorkloadAnalysis() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String workerId,  String workerName,  int appointments,  double hours,  double utilization)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WorkloadAnalysis() when $default != null:
return $default(_that.workerId,_that.workerName,_that.appointments,_that.hours,_that.utilization);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String workerId,  String workerName,  int appointments,  double hours,  double utilization)  $default,) {final _that = this;
switch (_that) {
case _WorkloadAnalysis():
return $default(_that.workerId,_that.workerName,_that.appointments,_that.hours,_that.utilization);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String workerId,  String workerName,  int appointments,  double hours,  double utilization)?  $default,) {final _that = this;
switch (_that) {
case _WorkloadAnalysis() when $default != null:
return $default(_that.workerId,_that.workerName,_that.appointments,_that.hours,_that.utilization);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WorkloadAnalysis implements WorkloadAnalysis {
  const _WorkloadAnalysis({required this.workerId, required this.workerName, required this.appointments, required this.hours, required this.utilization});
  factory _WorkloadAnalysis.fromJson(Map<String, dynamic> json) => _$WorkloadAnalysisFromJson(json);

@override final  String workerId;
@override final  String workerName;
@override final  int appointments;
@override final  double hours;
@override final  double utilization;

/// Create a copy of WorkloadAnalysis
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WorkloadAnalysisCopyWith<_WorkloadAnalysis> get copyWith => __$WorkloadAnalysisCopyWithImpl<_WorkloadAnalysis>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WorkloadAnalysisToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WorkloadAnalysis&&(identical(other.workerId, workerId) || other.workerId == workerId)&&(identical(other.workerName, workerName) || other.workerName == workerName)&&(identical(other.appointments, appointments) || other.appointments == appointments)&&(identical(other.hours, hours) || other.hours == hours)&&(identical(other.utilization, utilization) || other.utilization == utilization));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,workerId,workerName,appointments,hours,utilization);

@override
String toString() {
  return 'WorkloadAnalysis(workerId: $workerId, workerName: $workerName, appointments: $appointments, hours: $hours, utilization: $utilization)';
}


}

/// @nodoc
abstract mixin class _$WorkloadAnalysisCopyWith<$Res> implements $WorkloadAnalysisCopyWith<$Res> {
  factory _$WorkloadAnalysisCopyWith(_WorkloadAnalysis value, $Res Function(_WorkloadAnalysis) _then) = __$WorkloadAnalysisCopyWithImpl;
@override @useResult
$Res call({
 String workerId, String workerName, int appointments, double hours, double utilization
});




}
/// @nodoc
class __$WorkloadAnalysisCopyWithImpl<$Res>
    implements _$WorkloadAnalysisCopyWith<$Res> {
  __$WorkloadAnalysisCopyWithImpl(this._self, this._then);

  final _WorkloadAnalysis _self;
  final $Res Function(_WorkloadAnalysis) _then;

/// Create a copy of WorkloadAnalysis
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? workerId = null,Object? workerName = null,Object? appointments = null,Object? hours = null,Object? utilization = null,}) {
  return _then(_WorkloadAnalysis(
workerId: null == workerId ? _self.workerId : workerId // ignore: cast_nullable_to_non_nullable
as String,workerName: null == workerName ? _self.workerName : workerName // ignore: cast_nullable_to_non_nullable
as String,appointments: null == appointments ? _self.appointments : appointments // ignore: cast_nullable_to_non_nullable
as int,hours: null == hours ? _self.hours : hours // ignore: cast_nullable_to_non_nullable
as double,utilization: null == utilization ? _self.utilization : utilization // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$PerformanceMetrics {

 int get totalAppointments; double get avgRating; double get completionRate; double get revenue; double get revenuePerAppointment; double get punctualityScore; double get qualityScore;
/// Create a copy of PerformanceMetrics
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PerformanceMetricsCopyWith<PerformanceMetrics> get copyWith => _$PerformanceMetricsCopyWithImpl<PerformanceMetrics>(this as PerformanceMetrics, _$identity);

  /// Serializes this PerformanceMetrics to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PerformanceMetrics&&(identical(other.totalAppointments, totalAppointments) || other.totalAppointments == totalAppointments)&&(identical(other.avgRating, avgRating) || other.avgRating == avgRating)&&(identical(other.completionRate, completionRate) || other.completionRate == completionRate)&&(identical(other.revenue, revenue) || other.revenue == revenue)&&(identical(other.revenuePerAppointment, revenuePerAppointment) || other.revenuePerAppointment == revenuePerAppointment)&&(identical(other.punctualityScore, punctualityScore) || other.punctualityScore == punctualityScore)&&(identical(other.qualityScore, qualityScore) || other.qualityScore == qualityScore));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalAppointments,avgRating,completionRate,revenue,revenuePerAppointment,punctualityScore,qualityScore);

@override
String toString() {
  return 'PerformanceMetrics(totalAppointments: $totalAppointments, avgRating: $avgRating, completionRate: $completionRate, revenue: $revenue, revenuePerAppointment: $revenuePerAppointment, punctualityScore: $punctualityScore, qualityScore: $qualityScore)';
}


}

/// @nodoc
abstract mixin class $PerformanceMetricsCopyWith<$Res>  {
  factory $PerformanceMetricsCopyWith(PerformanceMetrics value, $Res Function(PerformanceMetrics) _then) = _$PerformanceMetricsCopyWithImpl;
@useResult
$Res call({
 int totalAppointments, double avgRating, double completionRate, double revenue, double revenuePerAppointment, double punctualityScore, double qualityScore
});




}
/// @nodoc
class _$PerformanceMetricsCopyWithImpl<$Res>
    implements $PerformanceMetricsCopyWith<$Res> {
  _$PerformanceMetricsCopyWithImpl(this._self, this._then);

  final PerformanceMetrics _self;
  final $Res Function(PerformanceMetrics) _then;

/// Create a copy of PerformanceMetrics
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalAppointments = null,Object? avgRating = null,Object? completionRate = null,Object? revenue = null,Object? revenuePerAppointment = null,Object? punctualityScore = null,Object? qualityScore = null,}) {
  return _then(_self.copyWith(
totalAppointments: null == totalAppointments ? _self.totalAppointments : totalAppointments // ignore: cast_nullable_to_non_nullable
as int,avgRating: null == avgRating ? _self.avgRating : avgRating // ignore: cast_nullable_to_non_nullable
as double,completionRate: null == completionRate ? _self.completionRate : completionRate // ignore: cast_nullable_to_non_nullable
as double,revenue: null == revenue ? _self.revenue : revenue // ignore: cast_nullable_to_non_nullable
as double,revenuePerAppointment: null == revenuePerAppointment ? _self.revenuePerAppointment : revenuePerAppointment // ignore: cast_nullable_to_non_nullable
as double,punctualityScore: null == punctualityScore ? _self.punctualityScore : punctualityScore // ignore: cast_nullable_to_non_nullable
as double,qualityScore: null == qualityScore ? _self.qualityScore : qualityScore // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [PerformanceMetrics].
extension PerformanceMetricsPatterns on PerformanceMetrics {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PerformanceMetrics value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PerformanceMetrics() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PerformanceMetrics value)  $default,){
final _that = this;
switch (_that) {
case _PerformanceMetrics():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PerformanceMetrics value)?  $default,){
final _that = this;
switch (_that) {
case _PerformanceMetrics() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int totalAppointments,  double avgRating,  double completionRate,  double revenue,  double revenuePerAppointment,  double punctualityScore,  double qualityScore)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PerformanceMetrics() when $default != null:
return $default(_that.totalAppointments,_that.avgRating,_that.completionRate,_that.revenue,_that.revenuePerAppointment,_that.punctualityScore,_that.qualityScore);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int totalAppointments,  double avgRating,  double completionRate,  double revenue,  double revenuePerAppointment,  double punctualityScore,  double qualityScore)  $default,) {final _that = this;
switch (_that) {
case _PerformanceMetrics():
return $default(_that.totalAppointments,_that.avgRating,_that.completionRate,_that.revenue,_that.revenuePerAppointment,_that.punctualityScore,_that.qualityScore);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int totalAppointments,  double avgRating,  double completionRate,  double revenue,  double revenuePerAppointment,  double punctualityScore,  double qualityScore)?  $default,) {final _that = this;
switch (_that) {
case _PerformanceMetrics() when $default != null:
return $default(_that.totalAppointments,_that.avgRating,_that.completionRate,_that.revenue,_that.revenuePerAppointment,_that.punctualityScore,_that.qualityScore);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PerformanceMetrics implements PerformanceMetrics {
  const _PerformanceMetrics({required this.totalAppointments, required this.avgRating, required this.completionRate, required this.revenue, required this.revenuePerAppointment, required this.punctualityScore, required this.qualityScore});
  factory _PerformanceMetrics.fromJson(Map<String, dynamic> json) => _$PerformanceMetricsFromJson(json);

@override final  int totalAppointments;
@override final  double avgRating;
@override final  double completionRate;
@override final  double revenue;
@override final  double revenuePerAppointment;
@override final  double punctualityScore;
@override final  double qualityScore;

/// Create a copy of PerformanceMetrics
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PerformanceMetricsCopyWith<_PerformanceMetrics> get copyWith => __$PerformanceMetricsCopyWithImpl<_PerformanceMetrics>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PerformanceMetricsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PerformanceMetrics&&(identical(other.totalAppointments, totalAppointments) || other.totalAppointments == totalAppointments)&&(identical(other.avgRating, avgRating) || other.avgRating == avgRating)&&(identical(other.completionRate, completionRate) || other.completionRate == completionRate)&&(identical(other.revenue, revenue) || other.revenue == revenue)&&(identical(other.revenuePerAppointment, revenuePerAppointment) || other.revenuePerAppointment == revenuePerAppointment)&&(identical(other.punctualityScore, punctualityScore) || other.punctualityScore == punctualityScore)&&(identical(other.qualityScore, qualityScore) || other.qualityScore == qualityScore));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalAppointments,avgRating,completionRate,revenue,revenuePerAppointment,punctualityScore,qualityScore);

@override
String toString() {
  return 'PerformanceMetrics(totalAppointments: $totalAppointments, avgRating: $avgRating, completionRate: $completionRate, revenue: $revenue, revenuePerAppointment: $revenuePerAppointment, punctualityScore: $punctualityScore, qualityScore: $qualityScore)';
}


}

/// @nodoc
abstract mixin class _$PerformanceMetricsCopyWith<$Res> implements $PerformanceMetricsCopyWith<$Res> {
  factory _$PerformanceMetricsCopyWith(_PerformanceMetrics value, $Res Function(_PerformanceMetrics) _then) = __$PerformanceMetricsCopyWithImpl;
@override @useResult
$Res call({
 int totalAppointments, double avgRating, double completionRate, double revenue, double revenuePerAppointment, double punctualityScore, double qualityScore
});




}
/// @nodoc
class __$PerformanceMetricsCopyWithImpl<$Res>
    implements _$PerformanceMetricsCopyWith<$Res> {
  __$PerformanceMetricsCopyWithImpl(this._self, this._then);

  final _PerformanceMetrics _self;
  final $Res Function(_PerformanceMetrics) _then;

/// Create a copy of PerformanceMetrics
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalAppointments = null,Object? avgRating = null,Object? completionRate = null,Object? revenue = null,Object? revenuePerAppointment = null,Object? punctualityScore = null,Object? qualityScore = null,}) {
  return _then(_PerformanceMetrics(
totalAppointments: null == totalAppointments ? _self.totalAppointments : totalAppointments // ignore: cast_nullable_to_non_nullable
as int,avgRating: null == avgRating ? _self.avgRating : avgRating // ignore: cast_nullable_to_non_nullable
as double,completionRate: null == completionRate ? _self.completionRate : completionRate // ignore: cast_nullable_to_non_nullable
as double,revenue: null == revenue ? _self.revenue : revenue // ignore: cast_nullable_to_non_nullable
as double,revenuePerAppointment: null == revenuePerAppointment ? _self.revenuePerAppointment : revenuePerAppointment // ignore: cast_nullable_to_non_nullable
as double,punctualityScore: null == punctualityScore ? _self.punctualityScore : punctualityScore // ignore: cast_nullable_to_non_nullable
as double,qualityScore: null == qualityScore ? _self.qualityScore : qualityScore // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$PerformanceAnalytics {

 String get employeeId; String get employeeName; PerformanceMetrics get metrics; PerformanceTrend get trends; PeerComparison get comparison; double get score;
/// Create a copy of PerformanceAnalytics
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PerformanceAnalyticsCopyWith<PerformanceAnalytics> get copyWith => _$PerformanceAnalyticsCopyWithImpl<PerformanceAnalytics>(this as PerformanceAnalytics, _$identity);

  /// Serializes this PerformanceAnalytics to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PerformanceAnalytics&&(identical(other.employeeId, employeeId) || other.employeeId == employeeId)&&(identical(other.employeeName, employeeName) || other.employeeName == employeeName)&&(identical(other.metrics, metrics) || other.metrics == metrics)&&(identical(other.trends, trends) || other.trends == trends)&&(identical(other.comparison, comparison) || other.comparison == comparison)&&(identical(other.score, score) || other.score == score));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,employeeId,employeeName,metrics,trends,comparison,score);

@override
String toString() {
  return 'PerformanceAnalytics(employeeId: $employeeId, employeeName: $employeeName, metrics: $metrics, trends: $trends, comparison: $comparison, score: $score)';
}


}

/// @nodoc
abstract mixin class $PerformanceAnalyticsCopyWith<$Res>  {
  factory $PerformanceAnalyticsCopyWith(PerformanceAnalytics value, $Res Function(PerformanceAnalytics) _then) = _$PerformanceAnalyticsCopyWithImpl;
@useResult
$Res call({
 String employeeId, String employeeName, PerformanceMetrics metrics, PerformanceTrend trends, PeerComparison comparison, double score
});


$PerformanceMetricsCopyWith<$Res> get metrics;$PerformanceTrendCopyWith<$Res> get trends;$PeerComparisonCopyWith<$Res> get comparison;

}
/// @nodoc
class _$PerformanceAnalyticsCopyWithImpl<$Res>
    implements $PerformanceAnalyticsCopyWith<$Res> {
  _$PerformanceAnalyticsCopyWithImpl(this._self, this._then);

  final PerformanceAnalytics _self;
  final $Res Function(PerformanceAnalytics) _then;

/// Create a copy of PerformanceAnalytics
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? employeeId = null,Object? employeeName = null,Object? metrics = null,Object? trends = null,Object? comparison = null,Object? score = null,}) {
  return _then(_self.copyWith(
employeeId: null == employeeId ? _self.employeeId : employeeId // ignore: cast_nullable_to_non_nullable
as String,employeeName: null == employeeName ? _self.employeeName : employeeName // ignore: cast_nullable_to_non_nullable
as String,metrics: null == metrics ? _self.metrics : metrics // ignore: cast_nullable_to_non_nullable
as PerformanceMetrics,trends: null == trends ? _self.trends : trends // ignore: cast_nullable_to_non_nullable
as PerformanceTrend,comparison: null == comparison ? _self.comparison : comparison // ignore: cast_nullable_to_non_nullable
as PeerComparison,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as double,
  ));
}
/// Create a copy of PerformanceAnalytics
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PerformanceMetricsCopyWith<$Res> get metrics {
  
  return $PerformanceMetricsCopyWith<$Res>(_self.metrics, (value) {
    return _then(_self.copyWith(metrics: value));
  });
}/// Create a copy of PerformanceAnalytics
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PerformanceTrendCopyWith<$Res> get trends {
  
  return $PerformanceTrendCopyWith<$Res>(_self.trends, (value) {
    return _then(_self.copyWith(trends: value));
  });
}/// Create a copy of PerformanceAnalytics
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PeerComparisonCopyWith<$Res> get comparison {
  
  return $PeerComparisonCopyWith<$Res>(_self.comparison, (value) {
    return _then(_self.copyWith(comparison: value));
  });
}
}


/// Adds pattern-matching-related methods to [PerformanceAnalytics].
extension PerformanceAnalyticsPatterns on PerformanceAnalytics {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PerformanceAnalytics value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PerformanceAnalytics() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PerformanceAnalytics value)  $default,){
final _that = this;
switch (_that) {
case _PerformanceAnalytics():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PerformanceAnalytics value)?  $default,){
final _that = this;
switch (_that) {
case _PerformanceAnalytics() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String employeeId,  String employeeName,  PerformanceMetrics metrics,  PerformanceTrend trends,  PeerComparison comparison,  double score)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PerformanceAnalytics() when $default != null:
return $default(_that.employeeId,_that.employeeName,_that.metrics,_that.trends,_that.comparison,_that.score);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String employeeId,  String employeeName,  PerformanceMetrics metrics,  PerformanceTrend trends,  PeerComparison comparison,  double score)  $default,) {final _that = this;
switch (_that) {
case _PerformanceAnalytics():
return $default(_that.employeeId,_that.employeeName,_that.metrics,_that.trends,_that.comparison,_that.score);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String employeeId,  String employeeName,  PerformanceMetrics metrics,  PerformanceTrend trends,  PeerComparison comparison,  double score)?  $default,) {final _that = this;
switch (_that) {
case _PerformanceAnalytics() when $default != null:
return $default(_that.employeeId,_that.employeeName,_that.metrics,_that.trends,_that.comparison,_that.score);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PerformanceAnalytics implements PerformanceAnalytics {
  const _PerformanceAnalytics({required this.employeeId, required this.employeeName, required this.metrics, required this.trends, required this.comparison, required this.score});
  factory _PerformanceAnalytics.fromJson(Map<String, dynamic> json) => _$PerformanceAnalyticsFromJson(json);

@override final  String employeeId;
@override final  String employeeName;
@override final  PerformanceMetrics metrics;
@override final  PerformanceTrend trends;
@override final  PeerComparison comparison;
@override final  double score;

/// Create a copy of PerformanceAnalytics
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PerformanceAnalyticsCopyWith<_PerformanceAnalytics> get copyWith => __$PerformanceAnalyticsCopyWithImpl<_PerformanceAnalytics>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PerformanceAnalyticsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PerformanceAnalytics&&(identical(other.employeeId, employeeId) || other.employeeId == employeeId)&&(identical(other.employeeName, employeeName) || other.employeeName == employeeName)&&(identical(other.metrics, metrics) || other.metrics == metrics)&&(identical(other.trends, trends) || other.trends == trends)&&(identical(other.comparison, comparison) || other.comparison == comparison)&&(identical(other.score, score) || other.score == score));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,employeeId,employeeName,metrics,trends,comparison,score);

@override
String toString() {
  return 'PerformanceAnalytics(employeeId: $employeeId, employeeName: $employeeName, metrics: $metrics, trends: $trends, comparison: $comparison, score: $score)';
}


}

/// @nodoc
abstract mixin class _$PerformanceAnalyticsCopyWith<$Res> implements $PerformanceAnalyticsCopyWith<$Res> {
  factory _$PerformanceAnalyticsCopyWith(_PerformanceAnalytics value, $Res Function(_PerformanceAnalytics) _then) = __$PerformanceAnalyticsCopyWithImpl;
@override @useResult
$Res call({
 String employeeId, String employeeName, PerformanceMetrics metrics, PerformanceTrend trends, PeerComparison comparison, double score
});


@override $PerformanceMetricsCopyWith<$Res> get metrics;@override $PerformanceTrendCopyWith<$Res> get trends;@override $PeerComparisonCopyWith<$Res> get comparison;

}
/// @nodoc
class __$PerformanceAnalyticsCopyWithImpl<$Res>
    implements _$PerformanceAnalyticsCopyWith<$Res> {
  __$PerformanceAnalyticsCopyWithImpl(this._self, this._then);

  final _PerformanceAnalytics _self;
  final $Res Function(_PerformanceAnalytics) _then;

/// Create a copy of PerformanceAnalytics
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? employeeId = null,Object? employeeName = null,Object? metrics = null,Object? trends = null,Object? comparison = null,Object? score = null,}) {
  return _then(_PerformanceAnalytics(
employeeId: null == employeeId ? _self.employeeId : employeeId // ignore: cast_nullable_to_non_nullable
as String,employeeName: null == employeeName ? _self.employeeName : employeeName // ignore: cast_nullable_to_non_nullable
as String,metrics: null == metrics ? _self.metrics : metrics // ignore: cast_nullable_to_non_nullable
as PerformanceMetrics,trends: null == trends ? _self.trends : trends // ignore: cast_nullable_to_non_nullable
as PerformanceTrend,comparison: null == comparison ? _self.comparison : comparison // ignore: cast_nullable_to_non_nullable
as PeerComparison,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

/// Create a copy of PerformanceAnalytics
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PerformanceMetricsCopyWith<$Res> get metrics {
  
  return $PerformanceMetricsCopyWith<$Res>(_self.metrics, (value) {
    return _then(_self.copyWith(metrics: value));
  });
}/// Create a copy of PerformanceAnalytics
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PerformanceTrendCopyWith<$Res> get trends {
  
  return $PerformanceTrendCopyWith<$Res>(_self.trends, (value) {
    return _then(_self.copyWith(trends: value));
  });
}/// Create a copy of PerformanceAnalytics
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PeerComparisonCopyWith<$Res> get comparison {
  
  return $PeerComparisonCopyWith<$Res>(_self.comparison, (value) {
    return _then(_self.copyWith(comparison: value));
  });
}
}


/// @nodoc
mixin _$PerformanceTrend {

 String get direction; double get growth; double get volatility;
/// Create a copy of PerformanceTrend
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PerformanceTrendCopyWith<PerformanceTrend> get copyWith => _$PerformanceTrendCopyWithImpl<PerformanceTrend>(this as PerformanceTrend, _$identity);

  /// Serializes this PerformanceTrend to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PerformanceTrend&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.growth, growth) || other.growth == growth)&&(identical(other.volatility, volatility) || other.volatility == volatility));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,direction,growth,volatility);

@override
String toString() {
  return 'PerformanceTrend(direction: $direction, growth: $growth, volatility: $volatility)';
}


}

/// @nodoc
abstract mixin class $PerformanceTrendCopyWith<$Res>  {
  factory $PerformanceTrendCopyWith(PerformanceTrend value, $Res Function(PerformanceTrend) _then) = _$PerformanceTrendCopyWithImpl;
@useResult
$Res call({
 String direction, double growth, double volatility
});




}
/// @nodoc
class _$PerformanceTrendCopyWithImpl<$Res>
    implements $PerformanceTrendCopyWith<$Res> {
  _$PerformanceTrendCopyWithImpl(this._self, this._then);

  final PerformanceTrend _self;
  final $Res Function(PerformanceTrend) _then;

/// Create a copy of PerformanceTrend
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? direction = null,Object? growth = null,Object? volatility = null,}) {
  return _then(_self.copyWith(
direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as String,growth: null == growth ? _self.growth : growth // ignore: cast_nullable_to_non_nullable
as double,volatility: null == volatility ? _self.volatility : volatility // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [PerformanceTrend].
extension PerformanceTrendPatterns on PerformanceTrend {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PerformanceTrend value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PerformanceTrend() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PerformanceTrend value)  $default,){
final _that = this;
switch (_that) {
case _PerformanceTrend():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PerformanceTrend value)?  $default,){
final _that = this;
switch (_that) {
case _PerformanceTrend() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String direction,  double growth,  double volatility)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PerformanceTrend() when $default != null:
return $default(_that.direction,_that.growth,_that.volatility);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String direction,  double growth,  double volatility)  $default,) {final _that = this;
switch (_that) {
case _PerformanceTrend():
return $default(_that.direction,_that.growth,_that.volatility);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String direction,  double growth,  double volatility)?  $default,) {final _that = this;
switch (_that) {
case _PerformanceTrend() when $default != null:
return $default(_that.direction,_that.growth,_that.volatility);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PerformanceTrend implements PerformanceTrend {
  const _PerformanceTrend({required this.direction, required this.growth, required this.volatility});
  factory _PerformanceTrend.fromJson(Map<String, dynamic> json) => _$PerformanceTrendFromJson(json);

@override final  String direction;
@override final  double growth;
@override final  double volatility;

/// Create a copy of PerformanceTrend
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PerformanceTrendCopyWith<_PerformanceTrend> get copyWith => __$PerformanceTrendCopyWithImpl<_PerformanceTrend>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PerformanceTrendToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PerformanceTrend&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.growth, growth) || other.growth == growth)&&(identical(other.volatility, volatility) || other.volatility == volatility));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,direction,growth,volatility);

@override
String toString() {
  return 'PerformanceTrend(direction: $direction, growth: $growth, volatility: $volatility)';
}


}

/// @nodoc
abstract mixin class _$PerformanceTrendCopyWith<$Res> implements $PerformanceTrendCopyWith<$Res> {
  factory _$PerformanceTrendCopyWith(_PerformanceTrend value, $Res Function(_PerformanceTrend) _then) = __$PerformanceTrendCopyWithImpl;
@override @useResult
$Res call({
 String direction, double growth, double volatility
});




}
/// @nodoc
class __$PerformanceTrendCopyWithImpl<$Res>
    implements _$PerformanceTrendCopyWith<$Res> {
  __$PerformanceTrendCopyWithImpl(this._self, this._then);

  final _PerformanceTrend _self;
  final $Res Function(_PerformanceTrend) _then;

/// Create a copy of PerformanceTrend
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? direction = null,Object? growth = null,Object? volatility = null,}) {
  return _then(_PerformanceTrend(
direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as String,growth: null == growth ? _self.growth : growth // ignore: cast_nullable_to_non_nullable
as double,volatility: null == volatility ? _self.volatility : volatility // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$PeerComparison {

 double get avgPeerScore; double get percentile; String get ranking;
/// Create a copy of PeerComparison
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PeerComparisonCopyWith<PeerComparison> get copyWith => _$PeerComparisonCopyWithImpl<PeerComparison>(this as PeerComparison, _$identity);

  /// Serializes this PeerComparison to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PeerComparison&&(identical(other.avgPeerScore, avgPeerScore) || other.avgPeerScore == avgPeerScore)&&(identical(other.percentile, percentile) || other.percentile == percentile)&&(identical(other.ranking, ranking) || other.ranking == ranking));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,avgPeerScore,percentile,ranking);

@override
String toString() {
  return 'PeerComparison(avgPeerScore: $avgPeerScore, percentile: $percentile, ranking: $ranking)';
}


}

/// @nodoc
abstract mixin class $PeerComparisonCopyWith<$Res>  {
  factory $PeerComparisonCopyWith(PeerComparison value, $Res Function(PeerComparison) _then) = _$PeerComparisonCopyWithImpl;
@useResult
$Res call({
 double avgPeerScore, double percentile, String ranking
});




}
/// @nodoc
class _$PeerComparisonCopyWithImpl<$Res>
    implements $PeerComparisonCopyWith<$Res> {
  _$PeerComparisonCopyWithImpl(this._self, this._then);

  final PeerComparison _self;
  final $Res Function(PeerComparison) _then;

/// Create a copy of PeerComparison
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? avgPeerScore = null,Object? percentile = null,Object? ranking = null,}) {
  return _then(_self.copyWith(
avgPeerScore: null == avgPeerScore ? _self.avgPeerScore : avgPeerScore // ignore: cast_nullable_to_non_nullable
as double,percentile: null == percentile ? _self.percentile : percentile // ignore: cast_nullable_to_non_nullable
as double,ranking: null == ranking ? _self.ranking : ranking // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PeerComparison].
extension PeerComparisonPatterns on PeerComparison {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PeerComparison value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PeerComparison() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PeerComparison value)  $default,){
final _that = this;
switch (_that) {
case _PeerComparison():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PeerComparison value)?  $default,){
final _that = this;
switch (_that) {
case _PeerComparison() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double avgPeerScore,  double percentile,  String ranking)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PeerComparison() when $default != null:
return $default(_that.avgPeerScore,_that.percentile,_that.ranking);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double avgPeerScore,  double percentile,  String ranking)  $default,) {final _that = this;
switch (_that) {
case _PeerComparison():
return $default(_that.avgPeerScore,_that.percentile,_that.ranking);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double avgPeerScore,  double percentile,  String ranking)?  $default,) {final _that = this;
switch (_that) {
case _PeerComparison() when $default != null:
return $default(_that.avgPeerScore,_that.percentile,_that.ranking);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PeerComparison implements PeerComparison {
  const _PeerComparison({required this.avgPeerScore, required this.percentile, required this.ranking});
  factory _PeerComparison.fromJson(Map<String, dynamic> json) => _$PeerComparisonFromJson(json);

@override final  double avgPeerScore;
@override final  double percentile;
@override final  String ranking;

/// Create a copy of PeerComparison
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PeerComparisonCopyWith<_PeerComparison> get copyWith => __$PeerComparisonCopyWithImpl<_PeerComparison>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PeerComparisonToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PeerComparison&&(identical(other.avgPeerScore, avgPeerScore) || other.avgPeerScore == avgPeerScore)&&(identical(other.percentile, percentile) || other.percentile == percentile)&&(identical(other.ranking, ranking) || other.ranking == ranking));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,avgPeerScore,percentile,ranking);

@override
String toString() {
  return 'PeerComparison(avgPeerScore: $avgPeerScore, percentile: $percentile, ranking: $ranking)';
}


}

/// @nodoc
abstract mixin class _$PeerComparisonCopyWith<$Res> implements $PeerComparisonCopyWith<$Res> {
  factory _$PeerComparisonCopyWith(_PeerComparison value, $Res Function(_PeerComparison) _then) = __$PeerComparisonCopyWithImpl;
@override @useResult
$Res call({
 double avgPeerScore, double percentile, String ranking
});




}
/// @nodoc
class __$PeerComparisonCopyWithImpl<$Res>
    implements _$PeerComparisonCopyWith<$Res> {
  __$PeerComparisonCopyWithImpl(this._self, this._then);

  final _PeerComparison _self;
  final $Res Function(_PeerComparison) _then;

/// Create a copy of PeerComparison
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? avgPeerScore = null,Object? percentile = null,Object? ranking = null,}) {
  return _then(_PeerComparison(
avgPeerScore: null == avgPeerScore ? _self.avgPeerScore : avgPeerScore // ignore: cast_nullable_to_non_nullable
as double,percentile: null == percentile ? _self.percentile : percentile // ignore: cast_nullable_to_non_nullable
as double,ranking: null == ranking ? _self.ranking : ranking // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$SkillProficiency {

 String get skill; String get level; List<String> get certifications; DateTime get lastAssessed; double get growthRate; String get recommendation;
/// Create a copy of SkillProficiency
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SkillProficiencyCopyWith<SkillProficiency> get copyWith => _$SkillProficiencyCopyWithImpl<SkillProficiency>(this as SkillProficiency, _$identity);

  /// Serializes this SkillProficiency to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SkillProficiency&&(identical(other.skill, skill) || other.skill == skill)&&(identical(other.level, level) || other.level == level)&&const DeepCollectionEquality().equals(other.certifications, certifications)&&(identical(other.lastAssessed, lastAssessed) || other.lastAssessed == lastAssessed)&&(identical(other.growthRate, growthRate) || other.growthRate == growthRate)&&(identical(other.recommendation, recommendation) || other.recommendation == recommendation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,skill,level,const DeepCollectionEquality().hash(certifications),lastAssessed,growthRate,recommendation);

@override
String toString() {
  return 'SkillProficiency(skill: $skill, level: $level, certifications: $certifications, lastAssessed: $lastAssessed, growthRate: $growthRate, recommendation: $recommendation)';
}


}

/// @nodoc
abstract mixin class $SkillProficiencyCopyWith<$Res>  {
  factory $SkillProficiencyCopyWith(SkillProficiency value, $Res Function(SkillProficiency) _then) = _$SkillProficiencyCopyWithImpl;
@useResult
$Res call({
 String skill, String level, List<String> certifications, DateTime lastAssessed, double growthRate, String recommendation
});




}
/// @nodoc
class _$SkillProficiencyCopyWithImpl<$Res>
    implements $SkillProficiencyCopyWith<$Res> {
  _$SkillProficiencyCopyWithImpl(this._self, this._then);

  final SkillProficiency _self;
  final $Res Function(SkillProficiency) _then;

/// Create a copy of SkillProficiency
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? skill = null,Object? level = null,Object? certifications = null,Object? lastAssessed = null,Object? growthRate = null,Object? recommendation = null,}) {
  return _then(_self.copyWith(
skill: null == skill ? _self.skill : skill // ignore: cast_nullable_to_non_nullable
as String,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as String,certifications: null == certifications ? _self.certifications : certifications // ignore: cast_nullable_to_non_nullable
as List<String>,lastAssessed: null == lastAssessed ? _self.lastAssessed : lastAssessed // ignore: cast_nullable_to_non_nullable
as DateTime,growthRate: null == growthRate ? _self.growthRate : growthRate // ignore: cast_nullable_to_non_nullable
as double,recommendation: null == recommendation ? _self.recommendation : recommendation // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SkillProficiency].
extension SkillProficiencyPatterns on SkillProficiency {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SkillProficiency value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SkillProficiency() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SkillProficiency value)  $default,){
final _that = this;
switch (_that) {
case _SkillProficiency():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SkillProficiency value)?  $default,){
final _that = this;
switch (_that) {
case _SkillProficiency() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String skill,  String level,  List<String> certifications,  DateTime lastAssessed,  double growthRate,  String recommendation)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SkillProficiency() when $default != null:
return $default(_that.skill,_that.level,_that.certifications,_that.lastAssessed,_that.growthRate,_that.recommendation);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String skill,  String level,  List<String> certifications,  DateTime lastAssessed,  double growthRate,  String recommendation)  $default,) {final _that = this;
switch (_that) {
case _SkillProficiency():
return $default(_that.skill,_that.level,_that.certifications,_that.lastAssessed,_that.growthRate,_that.recommendation);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String skill,  String level,  List<String> certifications,  DateTime lastAssessed,  double growthRate,  String recommendation)?  $default,) {final _that = this;
switch (_that) {
case _SkillProficiency() when $default != null:
return $default(_that.skill,_that.level,_that.certifications,_that.lastAssessed,_that.growthRate,_that.recommendation);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SkillProficiency implements SkillProficiency {
  const _SkillProficiency({required this.skill, required this.level, required final  List<String> certifications, required this.lastAssessed, required this.growthRate, required this.recommendation}): _certifications = certifications;
  factory _SkillProficiency.fromJson(Map<String, dynamic> json) => _$SkillProficiencyFromJson(json);

@override final  String skill;
@override final  String level;
 final  List<String> _certifications;
@override List<String> get certifications {
  if (_certifications is EqualUnmodifiableListView) return _certifications;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_certifications);
}

@override final  DateTime lastAssessed;
@override final  double growthRate;
@override final  String recommendation;

/// Create a copy of SkillProficiency
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SkillProficiencyCopyWith<_SkillProficiency> get copyWith => __$SkillProficiencyCopyWithImpl<_SkillProficiency>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SkillProficiencyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SkillProficiency&&(identical(other.skill, skill) || other.skill == skill)&&(identical(other.level, level) || other.level == level)&&const DeepCollectionEquality().equals(other._certifications, _certifications)&&(identical(other.lastAssessed, lastAssessed) || other.lastAssessed == lastAssessed)&&(identical(other.growthRate, growthRate) || other.growthRate == growthRate)&&(identical(other.recommendation, recommendation) || other.recommendation == recommendation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,skill,level,const DeepCollectionEquality().hash(_certifications),lastAssessed,growthRate,recommendation);

@override
String toString() {
  return 'SkillProficiency(skill: $skill, level: $level, certifications: $certifications, lastAssessed: $lastAssessed, growthRate: $growthRate, recommendation: $recommendation)';
}


}

/// @nodoc
abstract mixin class _$SkillProficiencyCopyWith<$Res> implements $SkillProficiencyCopyWith<$Res> {
  factory _$SkillProficiencyCopyWith(_SkillProficiency value, $Res Function(_SkillProficiency) _then) = __$SkillProficiencyCopyWithImpl;
@override @useResult
$Res call({
 String skill, String level, List<String> certifications, DateTime lastAssessed, double growthRate, String recommendation
});




}
/// @nodoc
class __$SkillProficiencyCopyWithImpl<$Res>
    implements _$SkillProficiencyCopyWith<$Res> {
  __$SkillProficiencyCopyWithImpl(this._self, this._then);

  final _SkillProficiency _self;
  final $Res Function(_SkillProficiency) _then;

/// Create a copy of SkillProficiency
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? skill = null,Object? level = null,Object? certifications = null,Object? lastAssessed = null,Object? growthRate = null,Object? recommendation = null,}) {
  return _then(_SkillProficiency(
skill: null == skill ? _self.skill : skill // ignore: cast_nullable_to_non_nullable
as String,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as String,certifications: null == certifications ? _self._certifications : certifications // ignore: cast_nullable_to_non_nullable
as List<String>,lastAssessed: null == lastAssessed ? _self.lastAssessed : lastAssessed // ignore: cast_nullable_to_non_nullable
as DateTime,growthRate: null == growthRate ? _self.growthRate : growthRate // ignore: cast_nullable_to_non_nullable
as double,recommendation: null == recommendation ? _self.recommendation : recommendation // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$QualityScore {

 String get appointmentId; double get overallScore; QualityFactors get factors; String get grade; List<QualityIssue> get issues; List<String> get recommendations; DateTime get assessedAt;
/// Create a copy of QualityScore
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QualityScoreCopyWith<QualityScore> get copyWith => _$QualityScoreCopyWithImpl<QualityScore>(this as QualityScore, _$identity);

  /// Serializes this QualityScore to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QualityScore&&(identical(other.appointmentId, appointmentId) || other.appointmentId == appointmentId)&&(identical(other.overallScore, overallScore) || other.overallScore == overallScore)&&(identical(other.factors, factors) || other.factors == factors)&&(identical(other.grade, grade) || other.grade == grade)&&const DeepCollectionEquality().equals(other.issues, issues)&&const DeepCollectionEquality().equals(other.recommendations, recommendations)&&(identical(other.assessedAt, assessedAt) || other.assessedAt == assessedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,appointmentId,overallScore,factors,grade,const DeepCollectionEquality().hash(issues),const DeepCollectionEquality().hash(recommendations),assessedAt);

@override
String toString() {
  return 'QualityScore(appointmentId: $appointmentId, overallScore: $overallScore, factors: $factors, grade: $grade, issues: $issues, recommendations: $recommendations, assessedAt: $assessedAt)';
}


}

/// @nodoc
abstract mixin class $QualityScoreCopyWith<$Res>  {
  factory $QualityScoreCopyWith(QualityScore value, $Res Function(QualityScore) _then) = _$QualityScoreCopyWithImpl;
@useResult
$Res call({
 String appointmentId, double overallScore, QualityFactors factors, String grade, List<QualityIssue> issues, List<String> recommendations, DateTime assessedAt
});


$QualityFactorsCopyWith<$Res> get factors;

}
/// @nodoc
class _$QualityScoreCopyWithImpl<$Res>
    implements $QualityScoreCopyWith<$Res> {
  _$QualityScoreCopyWithImpl(this._self, this._then);

  final QualityScore _self;
  final $Res Function(QualityScore) _then;

/// Create a copy of QualityScore
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? appointmentId = null,Object? overallScore = null,Object? factors = null,Object? grade = null,Object? issues = null,Object? recommendations = null,Object? assessedAt = null,}) {
  return _then(_self.copyWith(
appointmentId: null == appointmentId ? _self.appointmentId : appointmentId // ignore: cast_nullable_to_non_nullable
as String,overallScore: null == overallScore ? _self.overallScore : overallScore // ignore: cast_nullable_to_non_nullable
as double,factors: null == factors ? _self.factors : factors // ignore: cast_nullable_to_non_nullable
as QualityFactors,grade: null == grade ? _self.grade : grade // ignore: cast_nullable_to_non_nullable
as String,issues: null == issues ? _self.issues : issues // ignore: cast_nullable_to_non_nullable
as List<QualityIssue>,recommendations: null == recommendations ? _self.recommendations : recommendations // ignore: cast_nullable_to_non_nullable
as List<String>,assessedAt: null == assessedAt ? _self.assessedAt : assessedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}
/// Create a copy of QualityScore
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QualityFactorsCopyWith<$Res> get factors {
  
  return $QualityFactorsCopyWith<$Res>(_self.factors, (value) {
    return _then(_self.copyWith(factors: value));
  });
}
}


/// Adds pattern-matching-related methods to [QualityScore].
extension QualityScorePatterns on QualityScore {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QualityScore value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QualityScore() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QualityScore value)  $default,){
final _that = this;
switch (_that) {
case _QualityScore():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QualityScore value)?  $default,){
final _that = this;
switch (_that) {
case _QualityScore() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String appointmentId,  double overallScore,  QualityFactors factors,  String grade,  List<QualityIssue> issues,  List<String> recommendations,  DateTime assessedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QualityScore() when $default != null:
return $default(_that.appointmentId,_that.overallScore,_that.factors,_that.grade,_that.issues,_that.recommendations,_that.assessedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String appointmentId,  double overallScore,  QualityFactors factors,  String grade,  List<QualityIssue> issues,  List<String> recommendations,  DateTime assessedAt)  $default,) {final _that = this;
switch (_that) {
case _QualityScore():
return $default(_that.appointmentId,_that.overallScore,_that.factors,_that.grade,_that.issues,_that.recommendations,_that.assessedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String appointmentId,  double overallScore,  QualityFactors factors,  String grade,  List<QualityIssue> issues,  List<String> recommendations,  DateTime assessedAt)?  $default,) {final _that = this;
switch (_that) {
case _QualityScore() when $default != null:
return $default(_that.appointmentId,_that.overallScore,_that.factors,_that.grade,_that.issues,_that.recommendations,_that.assessedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QualityScore implements QualityScore {
  const _QualityScore({required this.appointmentId, required this.overallScore, required this.factors, required this.grade, required final  List<QualityIssue> issues, required final  List<String> recommendations, required this.assessedAt}): _issues = issues,_recommendations = recommendations;
  factory _QualityScore.fromJson(Map<String, dynamic> json) => _$QualityScoreFromJson(json);

@override final  String appointmentId;
@override final  double overallScore;
@override final  QualityFactors factors;
@override final  String grade;
 final  List<QualityIssue> _issues;
@override List<QualityIssue> get issues {
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

@override final  DateTime assessedAt;

/// Create a copy of QualityScore
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QualityScoreCopyWith<_QualityScore> get copyWith => __$QualityScoreCopyWithImpl<_QualityScore>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QualityScoreToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QualityScore&&(identical(other.appointmentId, appointmentId) || other.appointmentId == appointmentId)&&(identical(other.overallScore, overallScore) || other.overallScore == overallScore)&&(identical(other.factors, factors) || other.factors == factors)&&(identical(other.grade, grade) || other.grade == grade)&&const DeepCollectionEquality().equals(other._issues, _issues)&&const DeepCollectionEquality().equals(other._recommendations, _recommendations)&&(identical(other.assessedAt, assessedAt) || other.assessedAt == assessedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,appointmentId,overallScore,factors,grade,const DeepCollectionEquality().hash(_issues),const DeepCollectionEquality().hash(_recommendations),assessedAt);

@override
String toString() {
  return 'QualityScore(appointmentId: $appointmentId, overallScore: $overallScore, factors: $factors, grade: $grade, issues: $issues, recommendations: $recommendations, assessedAt: $assessedAt)';
}


}

/// @nodoc
abstract mixin class _$QualityScoreCopyWith<$Res> implements $QualityScoreCopyWith<$Res> {
  factory _$QualityScoreCopyWith(_QualityScore value, $Res Function(_QualityScore) _then) = __$QualityScoreCopyWithImpl;
@override @useResult
$Res call({
 String appointmentId, double overallScore, QualityFactors factors, String grade, List<QualityIssue> issues, List<String> recommendations, DateTime assessedAt
});


@override $QualityFactorsCopyWith<$Res> get factors;

}
/// @nodoc
class __$QualityScoreCopyWithImpl<$Res>
    implements _$QualityScoreCopyWith<$Res> {
  __$QualityScoreCopyWithImpl(this._self, this._then);

  final _QualityScore _self;
  final $Res Function(_QualityScore) _then;

/// Create a copy of QualityScore
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? appointmentId = null,Object? overallScore = null,Object? factors = null,Object? grade = null,Object? issues = null,Object? recommendations = null,Object? assessedAt = null,}) {
  return _then(_QualityScore(
appointmentId: null == appointmentId ? _self.appointmentId : appointmentId // ignore: cast_nullable_to_non_nullable
as String,overallScore: null == overallScore ? _self.overallScore : overallScore // ignore: cast_nullable_to_non_nullable
as double,factors: null == factors ? _self.factors : factors // ignore: cast_nullable_to_non_nullable
as QualityFactors,grade: null == grade ? _self.grade : grade // ignore: cast_nullable_to_non_nullable
as String,issues: null == issues ? _self._issues : issues // ignore: cast_nullable_to_non_nullable
as List<QualityIssue>,recommendations: null == recommendations ? _self._recommendations : recommendations // ignore: cast_nullable_to_non_nullable
as List<String>,assessedAt: null == assessedAt ? _self.assessedAt : assessedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

/// Create a copy of QualityScore
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QualityFactorsCopyWith<$Res> get factors {
  
  return $QualityFactorsCopyWith<$Res>(_self.factors, (value) {
    return _then(_self.copyWith(factors: value));
  });
}
}


/// @nodoc
mixin _$QualityFactors {

 double get punctuality; double get completion; double get clientSatisfaction; double get documentation; double get compliance;
/// Create a copy of QualityFactors
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QualityFactorsCopyWith<QualityFactors> get copyWith => _$QualityFactorsCopyWithImpl<QualityFactors>(this as QualityFactors, _$identity);

  /// Serializes this QualityFactors to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QualityFactors&&(identical(other.punctuality, punctuality) || other.punctuality == punctuality)&&(identical(other.completion, completion) || other.completion == completion)&&(identical(other.clientSatisfaction, clientSatisfaction) || other.clientSatisfaction == clientSatisfaction)&&(identical(other.documentation, documentation) || other.documentation == documentation)&&(identical(other.compliance, compliance) || other.compliance == compliance));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,punctuality,completion,clientSatisfaction,documentation,compliance);

@override
String toString() {
  return 'QualityFactors(punctuality: $punctuality, completion: $completion, clientSatisfaction: $clientSatisfaction, documentation: $documentation, compliance: $compliance)';
}


}

/// @nodoc
abstract mixin class $QualityFactorsCopyWith<$Res>  {
  factory $QualityFactorsCopyWith(QualityFactors value, $Res Function(QualityFactors) _then) = _$QualityFactorsCopyWithImpl;
@useResult
$Res call({
 double punctuality, double completion, double clientSatisfaction, double documentation, double compliance
});




}
/// @nodoc
class _$QualityFactorsCopyWithImpl<$Res>
    implements $QualityFactorsCopyWith<$Res> {
  _$QualityFactorsCopyWithImpl(this._self, this._then);

  final QualityFactors _self;
  final $Res Function(QualityFactors) _then;

/// Create a copy of QualityFactors
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? punctuality = null,Object? completion = null,Object? clientSatisfaction = null,Object? documentation = null,Object? compliance = null,}) {
  return _then(_self.copyWith(
punctuality: null == punctuality ? _self.punctuality : punctuality // ignore: cast_nullable_to_non_nullable
as double,completion: null == completion ? _self.completion : completion // ignore: cast_nullable_to_non_nullable
as double,clientSatisfaction: null == clientSatisfaction ? _self.clientSatisfaction : clientSatisfaction // ignore: cast_nullable_to_non_nullable
as double,documentation: null == documentation ? _self.documentation : documentation // ignore: cast_nullable_to_non_nullable
as double,compliance: null == compliance ? _self.compliance : compliance // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [QualityFactors].
extension QualityFactorsPatterns on QualityFactors {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QualityFactors value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QualityFactors() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QualityFactors value)  $default,){
final _that = this;
switch (_that) {
case _QualityFactors():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QualityFactors value)?  $default,){
final _that = this;
switch (_that) {
case _QualityFactors() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double punctuality,  double completion,  double clientSatisfaction,  double documentation,  double compliance)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QualityFactors() when $default != null:
return $default(_that.punctuality,_that.completion,_that.clientSatisfaction,_that.documentation,_that.compliance);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double punctuality,  double completion,  double clientSatisfaction,  double documentation,  double compliance)  $default,) {final _that = this;
switch (_that) {
case _QualityFactors():
return $default(_that.punctuality,_that.completion,_that.clientSatisfaction,_that.documentation,_that.compliance);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double punctuality,  double completion,  double clientSatisfaction,  double documentation,  double compliance)?  $default,) {final _that = this;
switch (_that) {
case _QualityFactors() when $default != null:
return $default(_that.punctuality,_that.completion,_that.clientSatisfaction,_that.documentation,_that.compliance);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QualityFactors implements QualityFactors {
  const _QualityFactors({required this.punctuality, required this.completion, required this.clientSatisfaction, required this.documentation, required this.compliance});
  factory _QualityFactors.fromJson(Map<String, dynamic> json) => _$QualityFactorsFromJson(json);

@override final  double punctuality;
@override final  double completion;
@override final  double clientSatisfaction;
@override final  double documentation;
@override final  double compliance;

/// Create a copy of QualityFactors
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QualityFactorsCopyWith<_QualityFactors> get copyWith => __$QualityFactorsCopyWithImpl<_QualityFactors>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QualityFactorsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QualityFactors&&(identical(other.punctuality, punctuality) || other.punctuality == punctuality)&&(identical(other.completion, completion) || other.completion == completion)&&(identical(other.clientSatisfaction, clientSatisfaction) || other.clientSatisfaction == clientSatisfaction)&&(identical(other.documentation, documentation) || other.documentation == documentation)&&(identical(other.compliance, compliance) || other.compliance == compliance));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,punctuality,completion,clientSatisfaction,documentation,compliance);

@override
String toString() {
  return 'QualityFactors(punctuality: $punctuality, completion: $completion, clientSatisfaction: $clientSatisfaction, documentation: $documentation, compliance: $compliance)';
}


}

/// @nodoc
abstract mixin class _$QualityFactorsCopyWith<$Res> implements $QualityFactorsCopyWith<$Res> {
  factory _$QualityFactorsCopyWith(_QualityFactors value, $Res Function(_QualityFactors) _then) = __$QualityFactorsCopyWithImpl;
@override @useResult
$Res call({
 double punctuality, double completion, double clientSatisfaction, double documentation, double compliance
});




}
/// @nodoc
class __$QualityFactorsCopyWithImpl<$Res>
    implements _$QualityFactorsCopyWith<$Res> {
  __$QualityFactorsCopyWithImpl(this._self, this._then);

  final _QualityFactors _self;
  final $Res Function(_QualityFactors) _then;

/// Create a copy of QualityFactors
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? punctuality = null,Object? completion = null,Object? clientSatisfaction = null,Object? documentation = null,Object? compliance = null,}) {
  return _then(_QualityFactors(
punctuality: null == punctuality ? _self.punctuality : punctuality // ignore: cast_nullable_to_non_nullable
as double,completion: null == completion ? _self.completion : completion // ignore: cast_nullable_to_non_nullable
as double,clientSatisfaction: null == clientSatisfaction ? _self.clientSatisfaction : clientSatisfaction // ignore: cast_nullable_to_non_nullable
as double,documentation: null == documentation ? _self.documentation : documentation // ignore: cast_nullable_to_non_nullable
as double,compliance: null == compliance ? _self.compliance : compliance // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$QualityIssue {

 String get type; String get severity; String get message;
/// Create a copy of QualityIssue
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QualityIssueCopyWith<QualityIssue> get copyWith => _$QualityIssueCopyWithImpl<QualityIssue>(this as QualityIssue, _$identity);

  /// Serializes this QualityIssue to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QualityIssue&&(identical(other.type, type) || other.type == type)&&(identical(other.severity, severity) || other.severity == severity)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,severity,message);

@override
String toString() {
  return 'QualityIssue(type: $type, severity: $severity, message: $message)';
}


}

/// @nodoc
abstract mixin class $QualityIssueCopyWith<$Res>  {
  factory $QualityIssueCopyWith(QualityIssue value, $Res Function(QualityIssue) _then) = _$QualityIssueCopyWithImpl;
@useResult
$Res call({
 String type, String severity, String message
});




}
/// @nodoc
class _$QualityIssueCopyWithImpl<$Res>
    implements $QualityIssueCopyWith<$Res> {
  _$QualityIssueCopyWithImpl(this._self, this._then);

  final QualityIssue _self;
  final $Res Function(QualityIssue) _then;

/// Create a copy of QualityIssue
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? severity = null,Object? message = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,severity: null == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [QualityIssue].
extension QualityIssuePatterns on QualityIssue {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QualityIssue value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QualityIssue() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QualityIssue value)  $default,){
final _that = this;
switch (_that) {
case _QualityIssue():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QualityIssue value)?  $default,){
final _that = this;
switch (_that) {
case _QualityIssue() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String type,  String severity,  String message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QualityIssue() when $default != null:
return $default(_that.type,_that.severity,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String type,  String severity,  String message)  $default,) {final _that = this;
switch (_that) {
case _QualityIssue():
return $default(_that.type,_that.severity,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String type,  String severity,  String message)?  $default,) {final _that = this;
switch (_that) {
case _QualityIssue() when $default != null:
return $default(_that.type,_that.severity,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QualityIssue implements QualityIssue {
  const _QualityIssue({required this.type, required this.severity, required this.message});
  factory _QualityIssue.fromJson(Map<String, dynamic> json) => _$QualityIssueFromJson(json);

@override final  String type;
@override final  String severity;
@override final  String message;

/// Create a copy of QualityIssue
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QualityIssueCopyWith<_QualityIssue> get copyWith => __$QualityIssueCopyWithImpl<_QualityIssue>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QualityIssueToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QualityIssue&&(identical(other.type, type) || other.type == type)&&(identical(other.severity, severity) || other.severity == severity)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,severity,message);

@override
String toString() {
  return 'QualityIssue(type: $type, severity: $severity, message: $message)';
}


}

/// @nodoc
abstract mixin class _$QualityIssueCopyWith<$Res> implements $QualityIssueCopyWith<$Res> {
  factory _$QualityIssueCopyWith(_QualityIssue value, $Res Function(_QualityIssue) _then) = __$QualityIssueCopyWithImpl;
@override @useResult
$Res call({
 String type, String severity, String message
});




}
/// @nodoc
class __$QualityIssueCopyWithImpl<$Res>
    implements _$QualityIssueCopyWith<$Res> {
  __$QualityIssueCopyWithImpl(this._self, this._then);

  final _QualityIssue _self;
  final $Res Function(_QualityIssue) _then;

/// Create a copy of QualityIssue
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? severity = null,Object? message = null,}) {
  return _then(_QualityIssue(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,severity: null == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ComplianceCheck {

 String get appointmentId; Map<String, ComplianceResult> get checks; bool get compliant; List<ComplianceViolation> get violations; String get riskLevel;
/// Create a copy of ComplianceCheck
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ComplianceCheckCopyWith<ComplianceCheck> get copyWith => _$ComplianceCheckCopyWithImpl<ComplianceCheck>(this as ComplianceCheck, _$identity);

  /// Serializes this ComplianceCheck to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ComplianceCheck&&(identical(other.appointmentId, appointmentId) || other.appointmentId == appointmentId)&&const DeepCollectionEquality().equals(other.checks, checks)&&(identical(other.compliant, compliant) || other.compliant == compliant)&&const DeepCollectionEquality().equals(other.violations, violations)&&(identical(other.riskLevel, riskLevel) || other.riskLevel == riskLevel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,appointmentId,const DeepCollectionEquality().hash(checks),compliant,const DeepCollectionEquality().hash(violations),riskLevel);

@override
String toString() {
  return 'ComplianceCheck(appointmentId: $appointmentId, checks: $checks, compliant: $compliant, violations: $violations, riskLevel: $riskLevel)';
}


}

/// @nodoc
abstract mixin class $ComplianceCheckCopyWith<$Res>  {
  factory $ComplianceCheckCopyWith(ComplianceCheck value, $Res Function(ComplianceCheck) _then) = _$ComplianceCheckCopyWithImpl;
@useResult
$Res call({
 String appointmentId, Map<String, ComplianceResult> checks, bool compliant, List<ComplianceViolation> violations, String riskLevel
});




}
/// @nodoc
class _$ComplianceCheckCopyWithImpl<$Res>
    implements $ComplianceCheckCopyWith<$Res> {
  _$ComplianceCheckCopyWithImpl(this._self, this._then);

  final ComplianceCheck _self;
  final $Res Function(ComplianceCheck) _then;

/// Create a copy of ComplianceCheck
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? appointmentId = null,Object? checks = null,Object? compliant = null,Object? violations = null,Object? riskLevel = null,}) {
  return _then(_self.copyWith(
appointmentId: null == appointmentId ? _self.appointmentId : appointmentId // ignore: cast_nullable_to_non_nullable
as String,checks: null == checks ? _self.checks : checks // ignore: cast_nullable_to_non_nullable
as Map<String, ComplianceResult>,compliant: null == compliant ? _self.compliant : compliant // ignore: cast_nullable_to_non_nullable
as bool,violations: null == violations ? _self.violations : violations // ignore: cast_nullable_to_non_nullable
as List<ComplianceViolation>,riskLevel: null == riskLevel ? _self.riskLevel : riskLevel // ignore: cast_nullable_to_non_nullable
as String,
  ));
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String appointmentId,  Map<String, ComplianceResult> checks,  bool compliant,  List<ComplianceViolation> violations,  String riskLevel)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ComplianceCheck() when $default != null:
return $default(_that.appointmentId,_that.checks,_that.compliant,_that.violations,_that.riskLevel);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String appointmentId,  Map<String, ComplianceResult> checks,  bool compliant,  List<ComplianceViolation> violations,  String riskLevel)  $default,) {final _that = this;
switch (_that) {
case _ComplianceCheck():
return $default(_that.appointmentId,_that.checks,_that.compliant,_that.violations,_that.riskLevel);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String appointmentId,  Map<String, ComplianceResult> checks,  bool compliant,  List<ComplianceViolation> violations,  String riskLevel)?  $default,) {final _that = this;
switch (_that) {
case _ComplianceCheck() when $default != null:
return $default(_that.appointmentId,_that.checks,_that.compliant,_that.violations,_that.riskLevel);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ComplianceCheck implements ComplianceCheck {
  const _ComplianceCheck({required this.appointmentId, required final  Map<String, ComplianceResult> checks, required this.compliant, required final  List<ComplianceViolation> violations, required this.riskLevel}): _checks = checks,_violations = violations;
  factory _ComplianceCheck.fromJson(Map<String, dynamic> json) => _$ComplianceCheckFromJson(json);

@override final  String appointmentId;
 final  Map<String, ComplianceResult> _checks;
@override Map<String, ComplianceResult> get checks {
  if (_checks is EqualUnmodifiableMapView) return _checks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_checks);
}

@override final  bool compliant;
 final  List<ComplianceViolation> _violations;
@override List<ComplianceViolation> get violations {
  if (_violations is EqualUnmodifiableListView) return _violations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_violations);
}

@override final  String riskLevel;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ComplianceCheck&&(identical(other.appointmentId, appointmentId) || other.appointmentId == appointmentId)&&const DeepCollectionEquality().equals(other._checks, _checks)&&(identical(other.compliant, compliant) || other.compliant == compliant)&&const DeepCollectionEquality().equals(other._violations, _violations)&&(identical(other.riskLevel, riskLevel) || other.riskLevel == riskLevel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,appointmentId,const DeepCollectionEquality().hash(_checks),compliant,const DeepCollectionEquality().hash(_violations),riskLevel);

@override
String toString() {
  return 'ComplianceCheck(appointmentId: $appointmentId, checks: $checks, compliant: $compliant, violations: $violations, riskLevel: $riskLevel)';
}


}

/// @nodoc
abstract mixin class _$ComplianceCheckCopyWith<$Res> implements $ComplianceCheckCopyWith<$Res> {
  factory _$ComplianceCheckCopyWith(_ComplianceCheck value, $Res Function(_ComplianceCheck) _then) = __$ComplianceCheckCopyWithImpl;
@override @useResult
$Res call({
 String appointmentId, Map<String, ComplianceResult> checks, bool compliant, List<ComplianceViolation> violations, String riskLevel
});




}
/// @nodoc
class __$ComplianceCheckCopyWithImpl<$Res>
    implements _$ComplianceCheckCopyWith<$Res> {
  __$ComplianceCheckCopyWithImpl(this._self, this._then);

  final _ComplianceCheck _self;
  final $Res Function(_ComplianceCheck) _then;

/// Create a copy of ComplianceCheck
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? appointmentId = null,Object? checks = null,Object? compliant = null,Object? violations = null,Object? riskLevel = null,}) {
  return _then(_ComplianceCheck(
appointmentId: null == appointmentId ? _self.appointmentId : appointmentId // ignore: cast_nullable_to_non_nullable
as String,checks: null == checks ? _self._checks : checks // ignore: cast_nullable_to_non_nullable
as Map<String, ComplianceResult>,compliant: null == compliant ? _self.compliant : compliant // ignore: cast_nullable_to_non_nullable
as bool,violations: null == violations ? _self._violations : violations // ignore: cast_nullable_to_non_nullable
as List<ComplianceViolation>,riskLevel: null == riskLevel ? _self.riskLevel : riskLevel // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ComplianceResult {

 bool get passed; String? get reason;
/// Create a copy of ComplianceResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ComplianceResultCopyWith<ComplianceResult> get copyWith => _$ComplianceResultCopyWithImpl<ComplianceResult>(this as ComplianceResult, _$identity);

  /// Serializes this ComplianceResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ComplianceResult&&(identical(other.passed, passed) || other.passed == passed)&&(identical(other.reason, reason) || other.reason == reason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,passed,reason);

@override
String toString() {
  return 'ComplianceResult(passed: $passed, reason: $reason)';
}


}

/// @nodoc
abstract mixin class $ComplianceResultCopyWith<$Res>  {
  factory $ComplianceResultCopyWith(ComplianceResult value, $Res Function(ComplianceResult) _then) = _$ComplianceResultCopyWithImpl;
@useResult
$Res call({
 bool passed, String? reason
});




}
/// @nodoc
class _$ComplianceResultCopyWithImpl<$Res>
    implements $ComplianceResultCopyWith<$Res> {
  _$ComplianceResultCopyWithImpl(this._self, this._then);

  final ComplianceResult _self;
  final $Res Function(ComplianceResult) _then;

/// Create a copy of ComplianceResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? passed = null,Object? reason = freezed,}) {
  return _then(_self.copyWith(
passed: null == passed ? _self.passed : passed // ignore: cast_nullable_to_non_nullable
as bool,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ComplianceResult].
extension ComplianceResultPatterns on ComplianceResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ComplianceResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ComplianceResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ComplianceResult value)  $default,){
final _that = this;
switch (_that) {
case _ComplianceResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ComplianceResult value)?  $default,){
final _that = this;
switch (_that) {
case _ComplianceResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool passed,  String? reason)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ComplianceResult() when $default != null:
return $default(_that.passed,_that.reason);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool passed,  String? reason)  $default,) {final _that = this;
switch (_that) {
case _ComplianceResult():
return $default(_that.passed,_that.reason);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool passed,  String? reason)?  $default,) {final _that = this;
switch (_that) {
case _ComplianceResult() when $default != null:
return $default(_that.passed,_that.reason);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ComplianceResult implements ComplianceResult {
  const _ComplianceResult({required this.passed, this.reason});
  factory _ComplianceResult.fromJson(Map<String, dynamic> json) => _$ComplianceResultFromJson(json);

@override final  bool passed;
@override final  String? reason;

/// Create a copy of ComplianceResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ComplianceResultCopyWith<_ComplianceResult> get copyWith => __$ComplianceResultCopyWithImpl<_ComplianceResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ComplianceResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ComplianceResult&&(identical(other.passed, passed) || other.passed == passed)&&(identical(other.reason, reason) || other.reason == reason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,passed,reason);

@override
String toString() {
  return 'ComplianceResult(passed: $passed, reason: $reason)';
}


}

/// @nodoc
abstract mixin class _$ComplianceResultCopyWith<$Res> implements $ComplianceResultCopyWith<$Res> {
  factory _$ComplianceResultCopyWith(_ComplianceResult value, $Res Function(_ComplianceResult) _then) = __$ComplianceResultCopyWithImpl;
@override @useResult
$Res call({
 bool passed, String? reason
});




}
/// @nodoc
class __$ComplianceResultCopyWithImpl<$Res>
    implements _$ComplianceResultCopyWith<$Res> {
  __$ComplianceResultCopyWithImpl(this._self, this._then);

  final _ComplianceResult _self;
  final $Res Function(_ComplianceResult) _then;

/// Create a copy of ComplianceResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? passed = null,Object? reason = freezed,}) {
  return _then(_ComplianceResult(
passed: null == passed ? _self.passed : passed // ignore: cast_nullable_to_non_nullable
as bool,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ComplianceViolation {

 String get check; String get reason;
/// Create a copy of ComplianceViolation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ComplianceViolationCopyWith<ComplianceViolation> get copyWith => _$ComplianceViolationCopyWithImpl<ComplianceViolation>(this as ComplianceViolation, _$identity);

  /// Serializes this ComplianceViolation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ComplianceViolation&&(identical(other.check, check) || other.check == check)&&(identical(other.reason, reason) || other.reason == reason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,check,reason);

@override
String toString() {
  return 'ComplianceViolation(check: $check, reason: $reason)';
}


}

/// @nodoc
abstract mixin class $ComplianceViolationCopyWith<$Res>  {
  factory $ComplianceViolationCopyWith(ComplianceViolation value, $Res Function(ComplianceViolation) _then) = _$ComplianceViolationCopyWithImpl;
@useResult
$Res call({
 String check, String reason
});




}
/// @nodoc
class _$ComplianceViolationCopyWithImpl<$Res>
    implements $ComplianceViolationCopyWith<$Res> {
  _$ComplianceViolationCopyWithImpl(this._self, this._then);

  final ComplianceViolation _self;
  final $Res Function(ComplianceViolation) _then;

/// Create a copy of ComplianceViolation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? check = null,Object? reason = null,}) {
  return _then(_self.copyWith(
check: null == check ? _self.check : check // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ComplianceViolation].
extension ComplianceViolationPatterns on ComplianceViolation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ComplianceViolation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ComplianceViolation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ComplianceViolation value)  $default,){
final _that = this;
switch (_that) {
case _ComplianceViolation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ComplianceViolation value)?  $default,){
final _that = this;
switch (_that) {
case _ComplianceViolation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String check,  String reason)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ComplianceViolation() when $default != null:
return $default(_that.check,_that.reason);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String check,  String reason)  $default,) {final _that = this;
switch (_that) {
case _ComplianceViolation():
return $default(_that.check,_that.reason);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String check,  String reason)?  $default,) {final _that = this;
switch (_that) {
case _ComplianceViolation() when $default != null:
return $default(_that.check,_that.reason);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ComplianceViolation implements ComplianceViolation {
  const _ComplianceViolation({required this.check, required this.reason});
  factory _ComplianceViolation.fromJson(Map<String, dynamic> json) => _$ComplianceViolationFromJson(json);

@override final  String check;
@override final  String reason;

/// Create a copy of ComplianceViolation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ComplianceViolationCopyWith<_ComplianceViolation> get copyWith => __$ComplianceViolationCopyWithImpl<_ComplianceViolation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ComplianceViolationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ComplianceViolation&&(identical(other.check, check) || other.check == check)&&(identical(other.reason, reason) || other.reason == reason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,check,reason);

@override
String toString() {
  return 'ComplianceViolation(check: $check, reason: $reason)';
}


}

/// @nodoc
abstract mixin class _$ComplianceViolationCopyWith<$Res> implements $ComplianceViolationCopyWith<$Res> {
  factory _$ComplianceViolationCopyWith(_ComplianceViolation value, $Res Function(_ComplianceViolation) _then) = __$ComplianceViolationCopyWithImpl;
@override @useResult
$Res call({
 String check, String reason
});




}
/// @nodoc
class __$ComplianceViolationCopyWithImpl<$Res>
    implements _$ComplianceViolationCopyWith<$Res> {
  __$ComplianceViolationCopyWithImpl(this._self, this._then);

  final _ComplianceViolation _self;
  final $Res Function(_ComplianceViolation) _then;

/// Create a copy of ComplianceViolation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? check = null,Object? reason = null,}) {
  return _then(_ComplianceViolation(
check: null == check ? _self.check : check // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$SentimentAnalysis {

 String get appointmentId; String get feedback; String get sentiment; double get score; double get confidence; List<String> get keywords; List<String> get topics; double get rating;
/// Create a copy of SentimentAnalysis
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SentimentAnalysisCopyWith<SentimentAnalysis> get copyWith => _$SentimentAnalysisCopyWithImpl<SentimentAnalysis>(this as SentimentAnalysis, _$identity);

  /// Serializes this SentimentAnalysis to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SentimentAnalysis&&(identical(other.appointmentId, appointmentId) || other.appointmentId == appointmentId)&&(identical(other.feedback, feedback) || other.feedback == feedback)&&(identical(other.sentiment, sentiment) || other.sentiment == sentiment)&&(identical(other.score, score) || other.score == score)&&(identical(other.confidence, confidence) || other.confidence == confidence)&&const DeepCollectionEquality().equals(other.keywords, keywords)&&const DeepCollectionEquality().equals(other.topics, topics)&&(identical(other.rating, rating) || other.rating == rating));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,appointmentId,feedback,sentiment,score,confidence,const DeepCollectionEquality().hash(keywords),const DeepCollectionEquality().hash(topics),rating);

@override
String toString() {
  return 'SentimentAnalysis(appointmentId: $appointmentId, feedback: $feedback, sentiment: $sentiment, score: $score, confidence: $confidence, keywords: $keywords, topics: $topics, rating: $rating)';
}


}

/// @nodoc
abstract mixin class $SentimentAnalysisCopyWith<$Res>  {
  factory $SentimentAnalysisCopyWith(SentimentAnalysis value, $Res Function(SentimentAnalysis) _then) = _$SentimentAnalysisCopyWithImpl;
@useResult
$Res call({
 String appointmentId, String feedback, String sentiment, double score, double confidence, List<String> keywords, List<String> topics, double rating
});




}
/// @nodoc
class _$SentimentAnalysisCopyWithImpl<$Res>
    implements $SentimentAnalysisCopyWith<$Res> {
  _$SentimentAnalysisCopyWithImpl(this._self, this._then);

  final SentimentAnalysis _self;
  final $Res Function(SentimentAnalysis) _then;

/// Create a copy of SentimentAnalysis
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? appointmentId = null,Object? feedback = null,Object? sentiment = null,Object? score = null,Object? confidence = null,Object? keywords = null,Object? topics = null,Object? rating = null,}) {
  return _then(_self.copyWith(
appointmentId: null == appointmentId ? _self.appointmentId : appointmentId // ignore: cast_nullable_to_non_nullable
as String,feedback: null == feedback ? _self.feedback : feedback // ignore: cast_nullable_to_non_nullable
as String,sentiment: null == sentiment ? _self.sentiment : sentiment // ignore: cast_nullable_to_non_nullable
as String,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as double,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as double,keywords: null == keywords ? _self.keywords : keywords // ignore: cast_nullable_to_non_nullable
as List<String>,topics: null == topics ? _self.topics : topics // ignore: cast_nullable_to_non_nullable
as List<String>,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [SentimentAnalysis].
extension SentimentAnalysisPatterns on SentimentAnalysis {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SentimentAnalysis value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SentimentAnalysis() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SentimentAnalysis value)  $default,){
final _that = this;
switch (_that) {
case _SentimentAnalysis():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SentimentAnalysis value)?  $default,){
final _that = this;
switch (_that) {
case _SentimentAnalysis() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String appointmentId,  String feedback,  String sentiment,  double score,  double confidence,  List<String> keywords,  List<String> topics,  double rating)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SentimentAnalysis() when $default != null:
return $default(_that.appointmentId,_that.feedback,_that.sentiment,_that.score,_that.confidence,_that.keywords,_that.topics,_that.rating);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String appointmentId,  String feedback,  String sentiment,  double score,  double confidence,  List<String> keywords,  List<String> topics,  double rating)  $default,) {final _that = this;
switch (_that) {
case _SentimentAnalysis():
return $default(_that.appointmentId,_that.feedback,_that.sentiment,_that.score,_that.confidence,_that.keywords,_that.topics,_that.rating);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String appointmentId,  String feedback,  String sentiment,  double score,  double confidence,  List<String> keywords,  List<String> topics,  double rating)?  $default,) {final _that = this;
switch (_that) {
case _SentimentAnalysis() when $default != null:
return $default(_that.appointmentId,_that.feedback,_that.sentiment,_that.score,_that.confidence,_that.keywords,_that.topics,_that.rating);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SentimentAnalysis implements SentimentAnalysis {
  const _SentimentAnalysis({required this.appointmentId, required this.feedback, required this.sentiment, required this.score, required this.confidence, required final  List<String> keywords, required final  List<String> topics, required this.rating}): _keywords = keywords,_topics = topics;
  factory _SentimentAnalysis.fromJson(Map<String, dynamic> json) => _$SentimentAnalysisFromJson(json);

@override final  String appointmentId;
@override final  String feedback;
@override final  String sentiment;
@override final  double score;
@override final  double confidence;
 final  List<String> _keywords;
@override List<String> get keywords {
  if (_keywords is EqualUnmodifiableListView) return _keywords;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_keywords);
}

 final  List<String> _topics;
@override List<String> get topics {
  if (_topics is EqualUnmodifiableListView) return _topics;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_topics);
}

@override final  double rating;

/// Create a copy of SentimentAnalysis
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SentimentAnalysisCopyWith<_SentimentAnalysis> get copyWith => __$SentimentAnalysisCopyWithImpl<_SentimentAnalysis>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SentimentAnalysisToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SentimentAnalysis&&(identical(other.appointmentId, appointmentId) || other.appointmentId == appointmentId)&&(identical(other.feedback, feedback) || other.feedback == feedback)&&(identical(other.sentiment, sentiment) || other.sentiment == sentiment)&&(identical(other.score, score) || other.score == score)&&(identical(other.confidence, confidence) || other.confidence == confidence)&&const DeepCollectionEquality().equals(other._keywords, _keywords)&&const DeepCollectionEquality().equals(other._topics, _topics)&&(identical(other.rating, rating) || other.rating == rating));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,appointmentId,feedback,sentiment,score,confidence,const DeepCollectionEquality().hash(_keywords),const DeepCollectionEquality().hash(_topics),rating);

@override
String toString() {
  return 'SentimentAnalysis(appointmentId: $appointmentId, feedback: $feedback, sentiment: $sentiment, score: $score, confidence: $confidence, keywords: $keywords, topics: $topics, rating: $rating)';
}


}

/// @nodoc
abstract mixin class _$SentimentAnalysisCopyWith<$Res> implements $SentimentAnalysisCopyWith<$Res> {
  factory _$SentimentAnalysisCopyWith(_SentimentAnalysis value, $Res Function(_SentimentAnalysis) _then) = __$SentimentAnalysisCopyWithImpl;
@override @useResult
$Res call({
 String appointmentId, String feedback, String sentiment, double score, double confidence, List<String> keywords, List<String> topics, double rating
});




}
/// @nodoc
class __$SentimentAnalysisCopyWithImpl<$Res>
    implements _$SentimentAnalysisCopyWith<$Res> {
  __$SentimentAnalysisCopyWithImpl(this._self, this._then);

  final _SentimentAnalysis _self;
  final $Res Function(_SentimentAnalysis) _then;

/// Create a copy of SentimentAnalysis
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? appointmentId = null,Object? feedback = null,Object? sentiment = null,Object? score = null,Object? confidence = null,Object? keywords = null,Object? topics = null,Object? rating = null,}) {
  return _then(_SentimentAnalysis(
appointmentId: null == appointmentId ? _self.appointmentId : appointmentId // ignore: cast_nullable_to_non_nullable
as String,feedback: null == feedback ? _self.feedback : feedback // ignore: cast_nullable_to_non_nullable
as String,sentiment: null == sentiment ? _self.sentiment : sentiment // ignore: cast_nullable_to_non_nullable
as String,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as double,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as double,keywords: null == keywords ? _self._keywords : keywords // ignore: cast_nullable_to_non_nullable
as List<String>,topics: null == topics ? _self._topics : topics // ignore: cast_nullable_to_non_nullable
as List<String>,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$RiskAssessment {

 String get appointmentId; double get riskScore; String get riskLevel; RiskFactors get factors; List<String> get mitigations; bool get requiresApproval;
/// Create a copy of RiskAssessment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RiskAssessmentCopyWith<RiskAssessment> get copyWith => _$RiskAssessmentCopyWithImpl<RiskAssessment>(this as RiskAssessment, _$identity);

  /// Serializes this RiskAssessment to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RiskAssessment&&(identical(other.appointmentId, appointmentId) || other.appointmentId == appointmentId)&&(identical(other.riskScore, riskScore) || other.riskScore == riskScore)&&(identical(other.riskLevel, riskLevel) || other.riskLevel == riskLevel)&&(identical(other.factors, factors) || other.factors == factors)&&const DeepCollectionEquality().equals(other.mitigations, mitigations)&&(identical(other.requiresApproval, requiresApproval) || other.requiresApproval == requiresApproval));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,appointmentId,riskScore,riskLevel,factors,const DeepCollectionEquality().hash(mitigations),requiresApproval);

@override
String toString() {
  return 'RiskAssessment(appointmentId: $appointmentId, riskScore: $riskScore, riskLevel: $riskLevel, factors: $factors, mitigations: $mitigations, requiresApproval: $requiresApproval)';
}


}

/// @nodoc
abstract mixin class $RiskAssessmentCopyWith<$Res>  {
  factory $RiskAssessmentCopyWith(RiskAssessment value, $Res Function(RiskAssessment) _then) = _$RiskAssessmentCopyWithImpl;
@useResult
$Res call({
 String appointmentId, double riskScore, String riskLevel, RiskFactors factors, List<String> mitigations, bool requiresApproval
});


$RiskFactorsCopyWith<$Res> get factors;

}
/// @nodoc
class _$RiskAssessmentCopyWithImpl<$Res>
    implements $RiskAssessmentCopyWith<$Res> {
  _$RiskAssessmentCopyWithImpl(this._self, this._then);

  final RiskAssessment _self;
  final $Res Function(RiskAssessment) _then;

/// Create a copy of RiskAssessment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? appointmentId = null,Object? riskScore = null,Object? riskLevel = null,Object? factors = null,Object? mitigations = null,Object? requiresApproval = null,}) {
  return _then(_self.copyWith(
appointmentId: null == appointmentId ? _self.appointmentId : appointmentId // ignore: cast_nullable_to_non_nullable
as String,riskScore: null == riskScore ? _self.riskScore : riskScore // ignore: cast_nullable_to_non_nullable
as double,riskLevel: null == riskLevel ? _self.riskLevel : riskLevel // ignore: cast_nullable_to_non_nullable
as String,factors: null == factors ? _self.factors : factors // ignore: cast_nullable_to_non_nullable
as RiskFactors,mitigations: null == mitigations ? _self.mitigations : mitigations // ignore: cast_nullable_to_non_nullable
as List<String>,requiresApproval: null == requiresApproval ? _self.requiresApproval : requiresApproval // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of RiskAssessment
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RiskFactorsCopyWith<$Res> get factors {
  
  return $RiskFactorsCopyWith<$Res>(_self.factors, (value) {
    return _then(_self.copyWith(factors: value));
  });
}
}


/// Adds pattern-matching-related methods to [RiskAssessment].
extension RiskAssessmentPatterns on RiskAssessment {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RiskAssessment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RiskAssessment() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RiskAssessment value)  $default,){
final _that = this;
switch (_that) {
case _RiskAssessment():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RiskAssessment value)?  $default,){
final _that = this;
switch (_that) {
case _RiskAssessment() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String appointmentId,  double riskScore,  String riskLevel,  RiskFactors factors,  List<String> mitigations,  bool requiresApproval)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RiskAssessment() when $default != null:
return $default(_that.appointmentId,_that.riskScore,_that.riskLevel,_that.factors,_that.mitigations,_that.requiresApproval);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String appointmentId,  double riskScore,  String riskLevel,  RiskFactors factors,  List<String> mitigations,  bool requiresApproval)  $default,) {final _that = this;
switch (_that) {
case _RiskAssessment():
return $default(_that.appointmentId,_that.riskScore,_that.riskLevel,_that.factors,_that.mitigations,_that.requiresApproval);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String appointmentId,  double riskScore,  String riskLevel,  RiskFactors factors,  List<String> mitigations,  bool requiresApproval)?  $default,) {final _that = this;
switch (_that) {
case _RiskAssessment() when $default != null:
return $default(_that.appointmentId,_that.riskScore,_that.riskLevel,_that.factors,_that.mitigations,_that.requiresApproval);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RiskAssessment implements RiskAssessment {
  const _RiskAssessment({required this.appointmentId, required this.riskScore, required this.riskLevel, required this.factors, required final  List<String> mitigations, required this.requiresApproval}): _mitigations = mitigations;
  factory _RiskAssessment.fromJson(Map<String, dynamic> json) => _$RiskAssessmentFromJson(json);

@override final  String appointmentId;
@override final  double riskScore;
@override final  String riskLevel;
@override final  RiskFactors factors;
 final  List<String> _mitigations;
@override List<String> get mitigations {
  if (_mitigations is EqualUnmodifiableListView) return _mitigations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_mitigations);
}

@override final  bool requiresApproval;

/// Create a copy of RiskAssessment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RiskAssessmentCopyWith<_RiskAssessment> get copyWith => __$RiskAssessmentCopyWithImpl<_RiskAssessment>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RiskAssessmentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RiskAssessment&&(identical(other.appointmentId, appointmentId) || other.appointmentId == appointmentId)&&(identical(other.riskScore, riskScore) || other.riskScore == riskScore)&&(identical(other.riskLevel, riskLevel) || other.riskLevel == riskLevel)&&(identical(other.factors, factors) || other.factors == factors)&&const DeepCollectionEquality().equals(other._mitigations, _mitigations)&&(identical(other.requiresApproval, requiresApproval) || other.requiresApproval == requiresApproval));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,appointmentId,riskScore,riskLevel,factors,const DeepCollectionEquality().hash(_mitigations),requiresApproval);

@override
String toString() {
  return 'RiskAssessment(appointmentId: $appointmentId, riskScore: $riskScore, riskLevel: $riskLevel, factors: $factors, mitigations: $mitigations, requiresApproval: $requiresApproval)';
}


}

/// @nodoc
abstract mixin class _$RiskAssessmentCopyWith<$Res> implements $RiskAssessmentCopyWith<$Res> {
  factory _$RiskAssessmentCopyWith(_RiskAssessment value, $Res Function(_RiskAssessment) _then) = __$RiskAssessmentCopyWithImpl;
@override @useResult
$Res call({
 String appointmentId, double riskScore, String riskLevel, RiskFactors factors, List<String> mitigations, bool requiresApproval
});


@override $RiskFactorsCopyWith<$Res> get factors;

}
/// @nodoc
class __$RiskAssessmentCopyWithImpl<$Res>
    implements _$RiskAssessmentCopyWith<$Res> {
  __$RiskAssessmentCopyWithImpl(this._self, this._then);

  final _RiskAssessment _self;
  final $Res Function(_RiskAssessment) _then;

/// Create a copy of RiskAssessment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? appointmentId = null,Object? riskScore = null,Object? riskLevel = null,Object? factors = null,Object? mitigations = null,Object? requiresApproval = null,}) {
  return _then(_RiskAssessment(
appointmentId: null == appointmentId ? _self.appointmentId : appointmentId // ignore: cast_nullable_to_non_nullable
as String,riskScore: null == riskScore ? _self.riskScore : riskScore // ignore: cast_nullable_to_non_nullable
as double,riskLevel: null == riskLevel ? _self.riskLevel : riskLevel // ignore: cast_nullable_to_non_nullable
as String,factors: null == factors ? _self.factors : factors // ignore: cast_nullable_to_non_nullable
as RiskFactors,mitigations: null == mitigations ? _self._mitigations : mitigations // ignore: cast_nullable_to_non_nullable
as List<String>,requiresApproval: null == requiresApproval ? _self.requiresApproval : requiresApproval // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of RiskAssessment
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RiskFactorsCopyWith<$Res> get factors {
  
  return $RiskFactorsCopyWith<$Res>(_self.factors, (value) {
    return _then(_self.copyWith(factors: value));
  });
}
}


/// @nodoc
mixin _$RiskFactors {

 double get workerExperience; double get clientComplexity; double get serviceType; double get location; double get timeOfDay;
/// Create a copy of RiskFactors
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RiskFactorsCopyWith<RiskFactors> get copyWith => _$RiskFactorsCopyWithImpl<RiskFactors>(this as RiskFactors, _$identity);

  /// Serializes this RiskFactors to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RiskFactors&&(identical(other.workerExperience, workerExperience) || other.workerExperience == workerExperience)&&(identical(other.clientComplexity, clientComplexity) || other.clientComplexity == clientComplexity)&&(identical(other.serviceType, serviceType) || other.serviceType == serviceType)&&(identical(other.location, location) || other.location == location)&&(identical(other.timeOfDay, timeOfDay) || other.timeOfDay == timeOfDay));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,workerExperience,clientComplexity,serviceType,location,timeOfDay);

@override
String toString() {
  return 'RiskFactors(workerExperience: $workerExperience, clientComplexity: $clientComplexity, serviceType: $serviceType, location: $location, timeOfDay: $timeOfDay)';
}


}

/// @nodoc
abstract mixin class $RiskFactorsCopyWith<$Res>  {
  factory $RiskFactorsCopyWith(RiskFactors value, $Res Function(RiskFactors) _then) = _$RiskFactorsCopyWithImpl;
@useResult
$Res call({
 double workerExperience, double clientComplexity, double serviceType, double location, double timeOfDay
});




}
/// @nodoc
class _$RiskFactorsCopyWithImpl<$Res>
    implements $RiskFactorsCopyWith<$Res> {
  _$RiskFactorsCopyWithImpl(this._self, this._then);

  final RiskFactors _self;
  final $Res Function(RiskFactors) _then;

/// Create a copy of RiskFactors
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? workerExperience = null,Object? clientComplexity = null,Object? serviceType = null,Object? location = null,Object? timeOfDay = null,}) {
  return _then(_self.copyWith(
workerExperience: null == workerExperience ? _self.workerExperience : workerExperience // ignore: cast_nullable_to_non_nullable
as double,clientComplexity: null == clientComplexity ? _self.clientComplexity : clientComplexity // ignore: cast_nullable_to_non_nullable
as double,serviceType: null == serviceType ? _self.serviceType : serviceType // ignore: cast_nullable_to_non_nullable
as double,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as double,timeOfDay: null == timeOfDay ? _self.timeOfDay : timeOfDay // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [RiskFactors].
extension RiskFactorsPatterns on RiskFactors {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RiskFactors value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RiskFactors() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RiskFactors value)  $default,){
final _that = this;
switch (_that) {
case _RiskFactors():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RiskFactors value)?  $default,){
final _that = this;
switch (_that) {
case _RiskFactors() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double workerExperience,  double clientComplexity,  double serviceType,  double location,  double timeOfDay)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RiskFactors() when $default != null:
return $default(_that.workerExperience,_that.clientComplexity,_that.serviceType,_that.location,_that.timeOfDay);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double workerExperience,  double clientComplexity,  double serviceType,  double location,  double timeOfDay)  $default,) {final _that = this;
switch (_that) {
case _RiskFactors():
return $default(_that.workerExperience,_that.clientComplexity,_that.serviceType,_that.location,_that.timeOfDay);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double workerExperience,  double clientComplexity,  double serviceType,  double location,  double timeOfDay)?  $default,) {final _that = this;
switch (_that) {
case _RiskFactors() when $default != null:
return $default(_that.workerExperience,_that.clientComplexity,_that.serviceType,_that.location,_that.timeOfDay);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RiskFactors implements RiskFactors {
  const _RiskFactors({required this.workerExperience, required this.clientComplexity, required this.serviceType, required this.location, required this.timeOfDay});
  factory _RiskFactors.fromJson(Map<String, dynamic> json) => _$RiskFactorsFromJson(json);

@override final  double workerExperience;
@override final  double clientComplexity;
@override final  double serviceType;
@override final  double location;
@override final  double timeOfDay;

/// Create a copy of RiskFactors
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RiskFactorsCopyWith<_RiskFactors> get copyWith => __$RiskFactorsCopyWithImpl<_RiskFactors>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RiskFactorsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RiskFactors&&(identical(other.workerExperience, workerExperience) || other.workerExperience == workerExperience)&&(identical(other.clientComplexity, clientComplexity) || other.clientComplexity == clientComplexity)&&(identical(other.serviceType, serviceType) || other.serviceType == serviceType)&&(identical(other.location, location) || other.location == location)&&(identical(other.timeOfDay, timeOfDay) || other.timeOfDay == timeOfDay));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,workerExperience,clientComplexity,serviceType,location,timeOfDay);

@override
String toString() {
  return 'RiskFactors(workerExperience: $workerExperience, clientComplexity: $clientComplexity, serviceType: $serviceType, location: $location, timeOfDay: $timeOfDay)';
}


}

/// @nodoc
abstract mixin class _$RiskFactorsCopyWith<$Res> implements $RiskFactorsCopyWith<$Res> {
  factory _$RiskFactorsCopyWith(_RiskFactors value, $Res Function(_RiskFactors) _then) = __$RiskFactorsCopyWithImpl;
@override @useResult
$Res call({
 double workerExperience, double clientComplexity, double serviceType, double location, double timeOfDay
});




}
/// @nodoc
class __$RiskFactorsCopyWithImpl<$Res>
    implements _$RiskFactorsCopyWith<$Res> {
  __$RiskFactorsCopyWithImpl(this._self, this._then);

  final _RiskFactors _self;
  final $Res Function(_RiskFactors) _then;

/// Create a copy of RiskFactors
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? workerExperience = null,Object? clientComplexity = null,Object? serviceType = null,Object? location = null,Object? timeOfDay = null,}) {
  return _then(_RiskFactors(
workerExperience: null == workerExperience ? _self.workerExperience : workerExperience // ignore: cast_nullable_to_non_nullable
as double,clientComplexity: null == clientComplexity ? _self.clientComplexity : clientComplexity // ignore: cast_nullable_to_non_nullable
as double,serviceType: null == serviceType ? _self.serviceType : serviceType // ignore: cast_nullable_to_non_nullable
as double,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as double,timeOfDay: null == timeOfDay ? _self.timeOfDay : timeOfDay // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$IncidentPattern {

 int get totalIncidents; Map<String, dynamic> get patterns; List<RecurringIssue> get recurringIssues; List<PreventiveAction> get preventiveActions;
/// Create a copy of IncidentPattern
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IncidentPatternCopyWith<IncidentPattern> get copyWith => _$IncidentPatternCopyWithImpl<IncidentPattern>(this as IncidentPattern, _$identity);

  /// Serializes this IncidentPattern to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IncidentPattern&&(identical(other.totalIncidents, totalIncidents) || other.totalIncidents == totalIncidents)&&const DeepCollectionEquality().equals(other.patterns, patterns)&&const DeepCollectionEquality().equals(other.recurringIssues, recurringIssues)&&const DeepCollectionEquality().equals(other.preventiveActions, preventiveActions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalIncidents,const DeepCollectionEquality().hash(patterns),const DeepCollectionEquality().hash(recurringIssues),const DeepCollectionEquality().hash(preventiveActions));

@override
String toString() {
  return 'IncidentPattern(totalIncidents: $totalIncidents, patterns: $patterns, recurringIssues: $recurringIssues, preventiveActions: $preventiveActions)';
}


}

/// @nodoc
abstract mixin class $IncidentPatternCopyWith<$Res>  {
  factory $IncidentPatternCopyWith(IncidentPattern value, $Res Function(IncidentPattern) _then) = _$IncidentPatternCopyWithImpl;
@useResult
$Res call({
 int totalIncidents, Map<String, dynamic> patterns, List<RecurringIssue> recurringIssues, List<PreventiveAction> preventiveActions
});




}
/// @nodoc
class _$IncidentPatternCopyWithImpl<$Res>
    implements $IncidentPatternCopyWith<$Res> {
  _$IncidentPatternCopyWithImpl(this._self, this._then);

  final IncidentPattern _self;
  final $Res Function(IncidentPattern) _then;

/// Create a copy of IncidentPattern
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalIncidents = null,Object? patterns = null,Object? recurringIssues = null,Object? preventiveActions = null,}) {
  return _then(_self.copyWith(
totalIncidents: null == totalIncidents ? _self.totalIncidents : totalIncidents // ignore: cast_nullable_to_non_nullable
as int,patterns: null == patterns ? _self.patterns : patterns // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,recurringIssues: null == recurringIssues ? _self.recurringIssues : recurringIssues // ignore: cast_nullable_to_non_nullable
as List<RecurringIssue>,preventiveActions: null == preventiveActions ? _self.preventiveActions : preventiveActions // ignore: cast_nullable_to_non_nullable
as List<PreventiveAction>,
  ));
}

}


/// Adds pattern-matching-related methods to [IncidentPattern].
extension IncidentPatternPatterns on IncidentPattern {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IncidentPattern value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IncidentPattern() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IncidentPattern value)  $default,){
final _that = this;
switch (_that) {
case _IncidentPattern():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IncidentPattern value)?  $default,){
final _that = this;
switch (_that) {
case _IncidentPattern() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int totalIncidents,  Map<String, dynamic> patterns,  List<RecurringIssue> recurringIssues,  List<PreventiveAction> preventiveActions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IncidentPattern() when $default != null:
return $default(_that.totalIncidents,_that.patterns,_that.recurringIssues,_that.preventiveActions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int totalIncidents,  Map<String, dynamic> patterns,  List<RecurringIssue> recurringIssues,  List<PreventiveAction> preventiveActions)  $default,) {final _that = this;
switch (_that) {
case _IncidentPattern():
return $default(_that.totalIncidents,_that.patterns,_that.recurringIssues,_that.preventiveActions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int totalIncidents,  Map<String, dynamic> patterns,  List<RecurringIssue> recurringIssues,  List<PreventiveAction> preventiveActions)?  $default,) {final _that = this;
switch (_that) {
case _IncidentPattern() when $default != null:
return $default(_that.totalIncidents,_that.patterns,_that.recurringIssues,_that.preventiveActions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _IncidentPattern implements IncidentPattern {
  const _IncidentPattern({required this.totalIncidents, required final  Map<String, dynamic> patterns, required final  List<RecurringIssue> recurringIssues, required final  List<PreventiveAction> preventiveActions}): _patterns = patterns,_recurringIssues = recurringIssues,_preventiveActions = preventiveActions;
  factory _IncidentPattern.fromJson(Map<String, dynamic> json) => _$IncidentPatternFromJson(json);

@override final  int totalIncidents;
 final  Map<String, dynamic> _patterns;
@override Map<String, dynamic> get patterns {
  if (_patterns is EqualUnmodifiableMapView) return _patterns;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_patterns);
}

 final  List<RecurringIssue> _recurringIssues;
@override List<RecurringIssue> get recurringIssues {
  if (_recurringIssues is EqualUnmodifiableListView) return _recurringIssues;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recurringIssues);
}

 final  List<PreventiveAction> _preventiveActions;
@override List<PreventiveAction> get preventiveActions {
  if (_preventiveActions is EqualUnmodifiableListView) return _preventiveActions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_preventiveActions);
}


/// Create a copy of IncidentPattern
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IncidentPatternCopyWith<_IncidentPattern> get copyWith => __$IncidentPatternCopyWithImpl<_IncidentPattern>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IncidentPatternToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IncidentPattern&&(identical(other.totalIncidents, totalIncidents) || other.totalIncidents == totalIncidents)&&const DeepCollectionEquality().equals(other._patterns, _patterns)&&const DeepCollectionEquality().equals(other._recurringIssues, _recurringIssues)&&const DeepCollectionEquality().equals(other._preventiveActions, _preventiveActions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalIncidents,const DeepCollectionEquality().hash(_patterns),const DeepCollectionEquality().hash(_recurringIssues),const DeepCollectionEquality().hash(_preventiveActions));

@override
String toString() {
  return 'IncidentPattern(totalIncidents: $totalIncidents, patterns: $patterns, recurringIssues: $recurringIssues, preventiveActions: $preventiveActions)';
}


}

/// @nodoc
abstract mixin class _$IncidentPatternCopyWith<$Res> implements $IncidentPatternCopyWith<$Res> {
  factory _$IncidentPatternCopyWith(_IncidentPattern value, $Res Function(_IncidentPattern) _then) = __$IncidentPatternCopyWithImpl;
@override @useResult
$Res call({
 int totalIncidents, Map<String, dynamic> patterns, List<RecurringIssue> recurringIssues, List<PreventiveAction> preventiveActions
});




}
/// @nodoc
class __$IncidentPatternCopyWithImpl<$Res>
    implements _$IncidentPatternCopyWith<$Res> {
  __$IncidentPatternCopyWithImpl(this._self, this._then);

  final _IncidentPattern _self;
  final $Res Function(_IncidentPattern) _then;

/// Create a copy of IncidentPattern
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalIncidents = null,Object? patterns = null,Object? recurringIssues = null,Object? preventiveActions = null,}) {
  return _then(_IncidentPattern(
totalIncidents: null == totalIncidents ? _self.totalIncidents : totalIncidents // ignore: cast_nullable_to_non_nullable
as int,patterns: null == patterns ? _self._patterns : patterns // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,recurringIssues: null == recurringIssues ? _self._recurringIssues : recurringIssues // ignore: cast_nullable_to_non_nullable
as List<RecurringIssue>,preventiveActions: null == preventiveActions ? _self._preventiveActions : preventiveActions // ignore: cast_nullable_to_non_nullable
as List<PreventiveAction>,
  ));
}


}


/// @nodoc
mixin _$RecurringIssue {

 String get type; String get description; String get severity;
/// Create a copy of RecurringIssue
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecurringIssueCopyWith<RecurringIssue> get copyWith => _$RecurringIssueCopyWithImpl<RecurringIssue>(this as RecurringIssue, _$identity);

  /// Serializes this RecurringIssue to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecurringIssue&&(identical(other.type, type) || other.type == type)&&(identical(other.description, description) || other.description == description)&&(identical(other.severity, severity) || other.severity == severity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,description,severity);

@override
String toString() {
  return 'RecurringIssue(type: $type, description: $description, severity: $severity)';
}


}

/// @nodoc
abstract mixin class $RecurringIssueCopyWith<$Res>  {
  factory $RecurringIssueCopyWith(RecurringIssue value, $Res Function(RecurringIssue) _then) = _$RecurringIssueCopyWithImpl;
@useResult
$Res call({
 String type, String description, String severity
});




}
/// @nodoc
class _$RecurringIssueCopyWithImpl<$Res>
    implements $RecurringIssueCopyWith<$Res> {
  _$RecurringIssueCopyWithImpl(this._self, this._then);

  final RecurringIssue _self;
  final $Res Function(RecurringIssue) _then;

/// Create a copy of RecurringIssue
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? description = null,Object? severity = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,severity: null == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [RecurringIssue].
extension RecurringIssuePatterns on RecurringIssue {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RecurringIssue value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RecurringIssue() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RecurringIssue value)  $default,){
final _that = this;
switch (_that) {
case _RecurringIssue():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RecurringIssue value)?  $default,){
final _that = this;
switch (_that) {
case _RecurringIssue() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String type,  String description,  String severity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RecurringIssue() when $default != null:
return $default(_that.type,_that.description,_that.severity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String type,  String description,  String severity)  $default,) {final _that = this;
switch (_that) {
case _RecurringIssue():
return $default(_that.type,_that.description,_that.severity);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String type,  String description,  String severity)?  $default,) {final _that = this;
switch (_that) {
case _RecurringIssue() when $default != null:
return $default(_that.type,_that.description,_that.severity);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RecurringIssue implements RecurringIssue {
  const _RecurringIssue({required this.type, required this.description, required this.severity});
  factory _RecurringIssue.fromJson(Map<String, dynamic> json) => _$RecurringIssueFromJson(json);

@override final  String type;
@override final  String description;
@override final  String severity;

/// Create a copy of RecurringIssue
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecurringIssueCopyWith<_RecurringIssue> get copyWith => __$RecurringIssueCopyWithImpl<_RecurringIssue>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RecurringIssueToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecurringIssue&&(identical(other.type, type) || other.type == type)&&(identical(other.description, description) || other.description == description)&&(identical(other.severity, severity) || other.severity == severity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,description,severity);

@override
String toString() {
  return 'RecurringIssue(type: $type, description: $description, severity: $severity)';
}


}

/// @nodoc
abstract mixin class _$RecurringIssueCopyWith<$Res> implements $RecurringIssueCopyWith<$Res> {
  factory _$RecurringIssueCopyWith(_RecurringIssue value, $Res Function(_RecurringIssue) _then) = __$RecurringIssueCopyWithImpl;
@override @useResult
$Res call({
 String type, String description, String severity
});




}
/// @nodoc
class __$RecurringIssueCopyWithImpl<$Res>
    implements _$RecurringIssueCopyWith<$Res> {
  __$RecurringIssueCopyWithImpl(this._self, this._then);

  final _RecurringIssue _self;
  final $Res Function(_RecurringIssue) _then;

/// Create a copy of RecurringIssue
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? description = null,Object? severity = null,}) {
  return _then(_RecurringIssue(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,severity: null == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$PreventiveAction {

 String get action; String get priority; String get expectedImpact;
/// Create a copy of PreventiveAction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PreventiveActionCopyWith<PreventiveAction> get copyWith => _$PreventiveActionCopyWithImpl<PreventiveAction>(this as PreventiveAction, _$identity);

  /// Serializes this PreventiveAction to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PreventiveAction&&(identical(other.action, action) || other.action == action)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.expectedImpact, expectedImpact) || other.expectedImpact == expectedImpact));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,action,priority,expectedImpact);

@override
String toString() {
  return 'PreventiveAction(action: $action, priority: $priority, expectedImpact: $expectedImpact)';
}


}

/// @nodoc
abstract mixin class $PreventiveActionCopyWith<$Res>  {
  factory $PreventiveActionCopyWith(PreventiveAction value, $Res Function(PreventiveAction) _then) = _$PreventiveActionCopyWithImpl;
@useResult
$Res call({
 String action, String priority, String expectedImpact
});




}
/// @nodoc
class _$PreventiveActionCopyWithImpl<$Res>
    implements $PreventiveActionCopyWith<$Res> {
  _$PreventiveActionCopyWithImpl(this._self, this._then);

  final PreventiveAction _self;
  final $Res Function(PreventiveAction) _then;

/// Create a copy of PreventiveAction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? action = null,Object? priority = null,Object? expectedImpact = null,}) {
  return _then(_self.copyWith(
action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as String,expectedImpact: null == expectedImpact ? _self.expectedImpact : expectedImpact // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PreventiveAction].
extension PreventiveActionPatterns on PreventiveAction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PreventiveAction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PreventiveAction() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PreventiveAction value)  $default,){
final _that = this;
switch (_that) {
case _PreventiveAction():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PreventiveAction value)?  $default,){
final _that = this;
switch (_that) {
case _PreventiveAction() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String action,  String priority,  String expectedImpact)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PreventiveAction() when $default != null:
return $default(_that.action,_that.priority,_that.expectedImpact);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String action,  String priority,  String expectedImpact)  $default,) {final _that = this;
switch (_that) {
case _PreventiveAction():
return $default(_that.action,_that.priority,_that.expectedImpact);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String action,  String priority,  String expectedImpact)?  $default,) {final _that = this;
switch (_that) {
case _PreventiveAction() when $default != null:
return $default(_that.action,_that.priority,_that.expectedImpact);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PreventiveAction implements PreventiveAction {
  const _PreventiveAction({required this.action, required this.priority, required this.expectedImpact});
  factory _PreventiveAction.fromJson(Map<String, dynamic> json) => _$PreventiveActionFromJson(json);

@override final  String action;
@override final  String priority;
@override final  String expectedImpact;

/// Create a copy of PreventiveAction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PreventiveActionCopyWith<_PreventiveAction> get copyWith => __$PreventiveActionCopyWithImpl<_PreventiveAction>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PreventiveActionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PreventiveAction&&(identical(other.action, action) || other.action == action)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.expectedImpact, expectedImpact) || other.expectedImpact == expectedImpact));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,action,priority,expectedImpact);

@override
String toString() {
  return 'PreventiveAction(action: $action, priority: $priority, expectedImpact: $expectedImpact)';
}


}

/// @nodoc
abstract mixin class _$PreventiveActionCopyWith<$Res> implements $PreventiveActionCopyWith<$Res> {
  factory _$PreventiveActionCopyWith(_PreventiveAction value, $Res Function(_PreventiveAction) _then) = __$PreventiveActionCopyWithImpl;
@override @useResult
$Res call({
 String action, String priority, String expectedImpact
});




}
/// @nodoc
class __$PreventiveActionCopyWithImpl<$Res>
    implements _$PreventiveActionCopyWith<$Res> {
  __$PreventiveActionCopyWithImpl(this._self, this._then);

  final _PreventiveAction _self;
  final $Res Function(_PreventiveAction) _then;

/// Create a copy of PreventiveAction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? action = null,Object? priority = null,Object? expectedImpact = null,}) {
  return _then(_PreventiveAction(
action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as String,expectedImpact: null == expectedImpact ? _self.expectedImpact : expectedImpact // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ExecutiveDashboard {

 DashboardKPIs get kpis; RevenueMetrics get revenue; OperationalMetrics get operations; ClientMetrics get clients; WorkforceMetrics get workforce; Map<String, TrendData> get trends; String get period; DateTime get generatedAt;
/// Create a copy of ExecutiveDashboard
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExecutiveDashboardCopyWith<ExecutiveDashboard> get copyWith => _$ExecutiveDashboardCopyWithImpl<ExecutiveDashboard>(this as ExecutiveDashboard, _$identity);

  /// Serializes this ExecutiveDashboard to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExecutiveDashboard&&(identical(other.kpis, kpis) || other.kpis == kpis)&&(identical(other.revenue, revenue) || other.revenue == revenue)&&(identical(other.operations, operations) || other.operations == operations)&&(identical(other.clients, clients) || other.clients == clients)&&(identical(other.workforce, workforce) || other.workforce == workforce)&&const DeepCollectionEquality().equals(other.trends, trends)&&(identical(other.period, period) || other.period == period)&&(identical(other.generatedAt, generatedAt) || other.generatedAt == generatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,kpis,revenue,operations,clients,workforce,const DeepCollectionEquality().hash(trends),period,generatedAt);

@override
String toString() {
  return 'ExecutiveDashboard(kpis: $kpis, revenue: $revenue, operations: $operations, clients: $clients, workforce: $workforce, trends: $trends, period: $period, generatedAt: $generatedAt)';
}


}

/// @nodoc
abstract mixin class $ExecutiveDashboardCopyWith<$Res>  {
  factory $ExecutiveDashboardCopyWith(ExecutiveDashboard value, $Res Function(ExecutiveDashboard) _then) = _$ExecutiveDashboardCopyWithImpl;
@useResult
$Res call({
 DashboardKPIs kpis, RevenueMetrics revenue, OperationalMetrics operations, ClientMetrics clients, WorkforceMetrics workforce, Map<String, TrendData> trends, String period, DateTime generatedAt
});


$DashboardKPIsCopyWith<$Res> get kpis;$RevenueMetricsCopyWith<$Res> get revenue;$OperationalMetricsCopyWith<$Res> get operations;$ClientMetricsCopyWith<$Res> get clients;$WorkforceMetricsCopyWith<$Res> get workforce;

}
/// @nodoc
class _$ExecutiveDashboardCopyWithImpl<$Res>
    implements $ExecutiveDashboardCopyWith<$Res> {
  _$ExecutiveDashboardCopyWithImpl(this._self, this._then);

  final ExecutiveDashboard _self;
  final $Res Function(ExecutiveDashboard) _then;

/// Create a copy of ExecutiveDashboard
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? kpis = null,Object? revenue = null,Object? operations = null,Object? clients = null,Object? workforce = null,Object? trends = null,Object? period = null,Object? generatedAt = null,}) {
  return _then(_self.copyWith(
kpis: null == kpis ? _self.kpis : kpis // ignore: cast_nullable_to_non_nullable
as DashboardKPIs,revenue: null == revenue ? _self.revenue : revenue // ignore: cast_nullable_to_non_nullable
as RevenueMetrics,operations: null == operations ? _self.operations : operations // ignore: cast_nullable_to_non_nullable
as OperationalMetrics,clients: null == clients ? _self.clients : clients // ignore: cast_nullable_to_non_nullable
as ClientMetrics,workforce: null == workforce ? _self.workforce : workforce // ignore: cast_nullable_to_non_nullable
as WorkforceMetrics,trends: null == trends ? _self.trends : trends // ignore: cast_nullable_to_non_nullable
as Map<String, TrendData>,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String,generatedAt: null == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}
/// Create a copy of ExecutiveDashboard
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DashboardKPIsCopyWith<$Res> get kpis {
  
  return $DashboardKPIsCopyWith<$Res>(_self.kpis, (value) {
    return _then(_self.copyWith(kpis: value));
  });
}/// Create a copy of ExecutiveDashboard
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RevenueMetricsCopyWith<$Res> get revenue {
  
  return $RevenueMetricsCopyWith<$Res>(_self.revenue, (value) {
    return _then(_self.copyWith(revenue: value));
  });
}/// Create a copy of ExecutiveDashboard
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OperationalMetricsCopyWith<$Res> get operations {
  
  return $OperationalMetricsCopyWith<$Res>(_self.operations, (value) {
    return _then(_self.copyWith(operations: value));
  });
}/// Create a copy of ExecutiveDashboard
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClientMetricsCopyWith<$Res> get clients {
  
  return $ClientMetricsCopyWith<$Res>(_self.clients, (value) {
    return _then(_self.copyWith(clients: value));
  });
}/// Create a copy of ExecutiveDashboard
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WorkforceMetricsCopyWith<$Res> get workforce {
  
  return $WorkforceMetricsCopyWith<$Res>(_self.workforce, (value) {
    return _then(_self.copyWith(workforce: value));
  });
}
}


/// Adds pattern-matching-related methods to [ExecutiveDashboard].
extension ExecutiveDashboardPatterns on ExecutiveDashboard {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExecutiveDashboard value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExecutiveDashboard() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExecutiveDashboard value)  $default,){
final _that = this;
switch (_that) {
case _ExecutiveDashboard():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExecutiveDashboard value)?  $default,){
final _that = this;
switch (_that) {
case _ExecutiveDashboard() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DashboardKPIs kpis,  RevenueMetrics revenue,  OperationalMetrics operations,  ClientMetrics clients,  WorkforceMetrics workforce,  Map<String, TrendData> trends,  String period,  DateTime generatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExecutiveDashboard() when $default != null:
return $default(_that.kpis,_that.revenue,_that.operations,_that.clients,_that.workforce,_that.trends,_that.period,_that.generatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DashboardKPIs kpis,  RevenueMetrics revenue,  OperationalMetrics operations,  ClientMetrics clients,  WorkforceMetrics workforce,  Map<String, TrendData> trends,  String period,  DateTime generatedAt)  $default,) {final _that = this;
switch (_that) {
case _ExecutiveDashboard():
return $default(_that.kpis,_that.revenue,_that.operations,_that.clients,_that.workforce,_that.trends,_that.period,_that.generatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DashboardKPIs kpis,  RevenueMetrics revenue,  OperationalMetrics operations,  ClientMetrics clients,  WorkforceMetrics workforce,  Map<String, TrendData> trends,  String period,  DateTime generatedAt)?  $default,) {final _that = this;
switch (_that) {
case _ExecutiveDashboard() when $default != null:
return $default(_that.kpis,_that.revenue,_that.operations,_that.clients,_that.workforce,_that.trends,_that.period,_that.generatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExecutiveDashboard implements ExecutiveDashboard {
  const _ExecutiveDashboard({required this.kpis, required this.revenue, required this.operations, required this.clients, required this.workforce, required final  Map<String, TrendData> trends, required this.period, required this.generatedAt}): _trends = trends;
  factory _ExecutiveDashboard.fromJson(Map<String, dynamic> json) => _$ExecutiveDashboardFromJson(json);

@override final  DashboardKPIs kpis;
@override final  RevenueMetrics revenue;
@override final  OperationalMetrics operations;
@override final  ClientMetrics clients;
@override final  WorkforceMetrics workforce;
 final  Map<String, TrendData> _trends;
@override Map<String, TrendData> get trends {
  if (_trends is EqualUnmodifiableMapView) return _trends;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_trends);
}

@override final  String period;
@override final  DateTime generatedAt;

/// Create a copy of ExecutiveDashboard
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExecutiveDashboardCopyWith<_ExecutiveDashboard> get copyWith => __$ExecutiveDashboardCopyWithImpl<_ExecutiveDashboard>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExecutiveDashboardToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExecutiveDashboard&&(identical(other.kpis, kpis) || other.kpis == kpis)&&(identical(other.revenue, revenue) || other.revenue == revenue)&&(identical(other.operations, operations) || other.operations == operations)&&(identical(other.clients, clients) || other.clients == clients)&&(identical(other.workforce, workforce) || other.workforce == workforce)&&const DeepCollectionEquality().equals(other._trends, _trends)&&(identical(other.period, period) || other.period == period)&&(identical(other.generatedAt, generatedAt) || other.generatedAt == generatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,kpis,revenue,operations,clients,workforce,const DeepCollectionEquality().hash(_trends),period,generatedAt);

@override
String toString() {
  return 'ExecutiveDashboard(kpis: $kpis, revenue: $revenue, operations: $operations, clients: $clients, workforce: $workforce, trends: $trends, period: $period, generatedAt: $generatedAt)';
}


}

/// @nodoc
abstract mixin class _$ExecutiveDashboardCopyWith<$Res> implements $ExecutiveDashboardCopyWith<$Res> {
  factory _$ExecutiveDashboardCopyWith(_ExecutiveDashboard value, $Res Function(_ExecutiveDashboard) _then) = __$ExecutiveDashboardCopyWithImpl;
@override @useResult
$Res call({
 DashboardKPIs kpis, RevenueMetrics revenue, OperationalMetrics operations, ClientMetrics clients, WorkforceMetrics workforce, Map<String, TrendData> trends, String period, DateTime generatedAt
});


@override $DashboardKPIsCopyWith<$Res> get kpis;@override $RevenueMetricsCopyWith<$Res> get revenue;@override $OperationalMetricsCopyWith<$Res> get operations;@override $ClientMetricsCopyWith<$Res> get clients;@override $WorkforceMetricsCopyWith<$Res> get workforce;

}
/// @nodoc
class __$ExecutiveDashboardCopyWithImpl<$Res>
    implements _$ExecutiveDashboardCopyWith<$Res> {
  __$ExecutiveDashboardCopyWithImpl(this._self, this._then);

  final _ExecutiveDashboard _self;
  final $Res Function(_ExecutiveDashboard) _then;

/// Create a copy of ExecutiveDashboard
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? kpis = null,Object? revenue = null,Object? operations = null,Object? clients = null,Object? workforce = null,Object? trends = null,Object? period = null,Object? generatedAt = null,}) {
  return _then(_ExecutiveDashboard(
kpis: null == kpis ? _self.kpis : kpis // ignore: cast_nullable_to_non_nullable
as DashboardKPIs,revenue: null == revenue ? _self.revenue : revenue // ignore: cast_nullable_to_non_nullable
as RevenueMetrics,operations: null == operations ? _self.operations : operations // ignore: cast_nullable_to_non_nullable
as OperationalMetrics,clients: null == clients ? _self.clients : clients // ignore: cast_nullable_to_non_nullable
as ClientMetrics,workforce: null == workforce ? _self.workforce : workforce // ignore: cast_nullable_to_non_nullable
as WorkforceMetrics,trends: null == trends ? _self._trends : trends // ignore: cast_nullable_to_non_nullable
as Map<String, TrendData>,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String,generatedAt: null == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

/// Create a copy of ExecutiveDashboard
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DashboardKPIsCopyWith<$Res> get kpis {
  
  return $DashboardKPIsCopyWith<$Res>(_self.kpis, (value) {
    return _then(_self.copyWith(kpis: value));
  });
}/// Create a copy of ExecutiveDashboard
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RevenueMetricsCopyWith<$Res> get revenue {
  
  return $RevenueMetricsCopyWith<$Res>(_self.revenue, (value) {
    return _then(_self.copyWith(revenue: value));
  });
}/// Create a copy of ExecutiveDashboard
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OperationalMetricsCopyWith<$Res> get operations {
  
  return $OperationalMetricsCopyWith<$Res>(_self.operations, (value) {
    return _then(_self.copyWith(operations: value));
  });
}/// Create a copy of ExecutiveDashboard
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClientMetricsCopyWith<$Res> get clients {
  
  return $ClientMetricsCopyWith<$Res>(_self.clients, (value) {
    return _then(_self.copyWith(clients: value));
  });
}/// Create a copy of ExecutiveDashboard
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WorkforceMetricsCopyWith<$Res> get workforce {
  
  return $WorkforceMetricsCopyWith<$Res>(_self.workforce, (value) {
    return _then(_self.copyWith(workforce: value));
  });
}
}


/// @nodoc
mixin _$DashboardKPIs {

 double get totalRevenue; int get totalAppointments; int get completedAppointments; double get completionRate; double get avgRevenuePerAppointment; double get growth;
/// Create a copy of DashboardKPIs
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DashboardKPIsCopyWith<DashboardKPIs> get copyWith => _$DashboardKPIsCopyWithImpl<DashboardKPIs>(this as DashboardKPIs, _$identity);

  /// Serializes this DashboardKPIs to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DashboardKPIs&&(identical(other.totalRevenue, totalRevenue) || other.totalRevenue == totalRevenue)&&(identical(other.totalAppointments, totalAppointments) || other.totalAppointments == totalAppointments)&&(identical(other.completedAppointments, completedAppointments) || other.completedAppointments == completedAppointments)&&(identical(other.completionRate, completionRate) || other.completionRate == completionRate)&&(identical(other.avgRevenuePerAppointment, avgRevenuePerAppointment) || other.avgRevenuePerAppointment == avgRevenuePerAppointment)&&(identical(other.growth, growth) || other.growth == growth));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalRevenue,totalAppointments,completedAppointments,completionRate,avgRevenuePerAppointment,growth);

@override
String toString() {
  return 'DashboardKPIs(totalRevenue: $totalRevenue, totalAppointments: $totalAppointments, completedAppointments: $completedAppointments, completionRate: $completionRate, avgRevenuePerAppointment: $avgRevenuePerAppointment, growth: $growth)';
}


}

/// @nodoc
abstract mixin class $DashboardKPIsCopyWith<$Res>  {
  factory $DashboardKPIsCopyWith(DashboardKPIs value, $Res Function(DashboardKPIs) _then) = _$DashboardKPIsCopyWithImpl;
@useResult
$Res call({
 double totalRevenue, int totalAppointments, int completedAppointments, double completionRate, double avgRevenuePerAppointment, double growth
});




}
/// @nodoc
class _$DashboardKPIsCopyWithImpl<$Res>
    implements $DashboardKPIsCopyWith<$Res> {
  _$DashboardKPIsCopyWithImpl(this._self, this._then);

  final DashboardKPIs _self;
  final $Res Function(DashboardKPIs) _then;

/// Create a copy of DashboardKPIs
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalRevenue = null,Object? totalAppointments = null,Object? completedAppointments = null,Object? completionRate = null,Object? avgRevenuePerAppointment = null,Object? growth = null,}) {
  return _then(_self.copyWith(
totalRevenue: null == totalRevenue ? _self.totalRevenue : totalRevenue // ignore: cast_nullable_to_non_nullable
as double,totalAppointments: null == totalAppointments ? _self.totalAppointments : totalAppointments // ignore: cast_nullable_to_non_nullable
as int,completedAppointments: null == completedAppointments ? _self.completedAppointments : completedAppointments // ignore: cast_nullable_to_non_nullable
as int,completionRate: null == completionRate ? _self.completionRate : completionRate // ignore: cast_nullable_to_non_nullable
as double,avgRevenuePerAppointment: null == avgRevenuePerAppointment ? _self.avgRevenuePerAppointment : avgRevenuePerAppointment // ignore: cast_nullable_to_non_nullable
as double,growth: null == growth ? _self.growth : growth // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [DashboardKPIs].
extension DashboardKPIsPatterns on DashboardKPIs {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DashboardKPIs value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DashboardKPIs() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DashboardKPIs value)  $default,){
final _that = this;
switch (_that) {
case _DashboardKPIs():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DashboardKPIs value)?  $default,){
final _that = this;
switch (_that) {
case _DashboardKPIs() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double totalRevenue,  int totalAppointments,  int completedAppointments,  double completionRate,  double avgRevenuePerAppointment,  double growth)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DashboardKPIs() when $default != null:
return $default(_that.totalRevenue,_that.totalAppointments,_that.completedAppointments,_that.completionRate,_that.avgRevenuePerAppointment,_that.growth);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double totalRevenue,  int totalAppointments,  int completedAppointments,  double completionRate,  double avgRevenuePerAppointment,  double growth)  $default,) {final _that = this;
switch (_that) {
case _DashboardKPIs():
return $default(_that.totalRevenue,_that.totalAppointments,_that.completedAppointments,_that.completionRate,_that.avgRevenuePerAppointment,_that.growth);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double totalRevenue,  int totalAppointments,  int completedAppointments,  double completionRate,  double avgRevenuePerAppointment,  double growth)?  $default,) {final _that = this;
switch (_that) {
case _DashboardKPIs() when $default != null:
return $default(_that.totalRevenue,_that.totalAppointments,_that.completedAppointments,_that.completionRate,_that.avgRevenuePerAppointment,_that.growth);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DashboardKPIs implements DashboardKPIs {
  const _DashboardKPIs({required this.totalRevenue, required this.totalAppointments, required this.completedAppointments, required this.completionRate, required this.avgRevenuePerAppointment, required this.growth});
  factory _DashboardKPIs.fromJson(Map<String, dynamic> json) => _$DashboardKPIsFromJson(json);

@override final  double totalRevenue;
@override final  int totalAppointments;
@override final  int completedAppointments;
@override final  double completionRate;
@override final  double avgRevenuePerAppointment;
@override final  double growth;

/// Create a copy of DashboardKPIs
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DashboardKPIsCopyWith<_DashboardKPIs> get copyWith => __$DashboardKPIsCopyWithImpl<_DashboardKPIs>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DashboardKPIsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DashboardKPIs&&(identical(other.totalRevenue, totalRevenue) || other.totalRevenue == totalRevenue)&&(identical(other.totalAppointments, totalAppointments) || other.totalAppointments == totalAppointments)&&(identical(other.completedAppointments, completedAppointments) || other.completedAppointments == completedAppointments)&&(identical(other.completionRate, completionRate) || other.completionRate == completionRate)&&(identical(other.avgRevenuePerAppointment, avgRevenuePerAppointment) || other.avgRevenuePerAppointment == avgRevenuePerAppointment)&&(identical(other.growth, growth) || other.growth == growth));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalRevenue,totalAppointments,completedAppointments,completionRate,avgRevenuePerAppointment,growth);

@override
String toString() {
  return 'DashboardKPIs(totalRevenue: $totalRevenue, totalAppointments: $totalAppointments, completedAppointments: $completedAppointments, completionRate: $completionRate, avgRevenuePerAppointment: $avgRevenuePerAppointment, growth: $growth)';
}


}

/// @nodoc
abstract mixin class _$DashboardKPIsCopyWith<$Res> implements $DashboardKPIsCopyWith<$Res> {
  factory _$DashboardKPIsCopyWith(_DashboardKPIs value, $Res Function(_DashboardKPIs) _then) = __$DashboardKPIsCopyWithImpl;
@override @useResult
$Res call({
 double totalRevenue, int totalAppointments, int completedAppointments, double completionRate, double avgRevenuePerAppointment, double growth
});




}
/// @nodoc
class __$DashboardKPIsCopyWithImpl<$Res>
    implements _$DashboardKPIsCopyWith<$Res> {
  __$DashboardKPIsCopyWithImpl(this._self, this._then);

  final _DashboardKPIs _self;
  final $Res Function(_DashboardKPIs) _then;

/// Create a copy of DashboardKPIs
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalRevenue = null,Object? totalAppointments = null,Object? completedAppointments = null,Object? completionRate = null,Object? avgRevenuePerAppointment = null,Object? growth = null,}) {
  return _then(_DashboardKPIs(
totalRevenue: null == totalRevenue ? _self.totalRevenue : totalRevenue // ignore: cast_nullable_to_non_nullable
as double,totalAppointments: null == totalAppointments ? _self.totalAppointments : totalAppointments // ignore: cast_nullable_to_non_nullable
as int,completedAppointments: null == completedAppointments ? _self.completedAppointments : completedAppointments // ignore: cast_nullable_to_non_nullable
as int,completionRate: null == completionRate ? _self.completionRate : completionRate // ignore: cast_nullable_to_non_nullable
as double,avgRevenuePerAppointment: null == avgRevenuePerAppointment ? _self.avgRevenuePerAppointment : avgRevenuePerAppointment // ignore: cast_nullable_to_non_nullable
as double,growth: null == growth ? _self.growth : growth // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$RevenueMetrics {

 double get total; int get count; double get avg;
/// Create a copy of RevenueMetrics
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RevenueMetricsCopyWith<RevenueMetrics> get copyWith => _$RevenueMetricsCopyWithImpl<RevenueMetrics>(this as RevenueMetrics, _$identity);

  /// Serializes this RevenueMetrics to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RevenueMetrics&&(identical(other.total, total) || other.total == total)&&(identical(other.count, count) || other.count == count)&&(identical(other.avg, avg) || other.avg == avg));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,total,count,avg);

@override
String toString() {
  return 'RevenueMetrics(total: $total, count: $count, avg: $avg)';
}


}

/// @nodoc
abstract mixin class $RevenueMetricsCopyWith<$Res>  {
  factory $RevenueMetricsCopyWith(RevenueMetrics value, $Res Function(RevenueMetrics) _then) = _$RevenueMetricsCopyWithImpl;
@useResult
$Res call({
 double total, int count, double avg
});




}
/// @nodoc
class _$RevenueMetricsCopyWithImpl<$Res>
    implements $RevenueMetricsCopyWith<$Res> {
  _$RevenueMetricsCopyWithImpl(this._self, this._then);

  final RevenueMetrics _self;
  final $Res Function(RevenueMetrics) _then;

/// Create a copy of RevenueMetrics
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? total = null,Object? count = null,Object? avg = null,}) {
  return _then(_self.copyWith(
total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,avg: null == avg ? _self.avg : avg // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [RevenueMetrics].
extension RevenueMetricsPatterns on RevenueMetrics {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RevenueMetrics value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RevenueMetrics() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RevenueMetrics value)  $default,){
final _that = this;
switch (_that) {
case _RevenueMetrics():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RevenueMetrics value)?  $default,){
final _that = this;
switch (_that) {
case _RevenueMetrics() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double total,  int count,  double avg)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RevenueMetrics() when $default != null:
return $default(_that.total,_that.count,_that.avg);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double total,  int count,  double avg)  $default,) {final _that = this;
switch (_that) {
case _RevenueMetrics():
return $default(_that.total,_that.count,_that.avg);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double total,  int count,  double avg)?  $default,) {final _that = this;
switch (_that) {
case _RevenueMetrics() when $default != null:
return $default(_that.total,_that.count,_that.avg);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RevenueMetrics implements RevenueMetrics {
  const _RevenueMetrics({required this.total, required this.count, required this.avg});
  factory _RevenueMetrics.fromJson(Map<String, dynamic> json) => _$RevenueMetricsFromJson(json);

@override final  double total;
@override final  int count;
@override final  double avg;

/// Create a copy of RevenueMetrics
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RevenueMetricsCopyWith<_RevenueMetrics> get copyWith => __$RevenueMetricsCopyWithImpl<_RevenueMetrics>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RevenueMetricsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RevenueMetrics&&(identical(other.total, total) || other.total == total)&&(identical(other.count, count) || other.count == count)&&(identical(other.avg, avg) || other.avg == avg));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,total,count,avg);

@override
String toString() {
  return 'RevenueMetrics(total: $total, count: $count, avg: $avg)';
}


}

/// @nodoc
abstract mixin class _$RevenueMetricsCopyWith<$Res> implements $RevenueMetricsCopyWith<$Res> {
  factory _$RevenueMetricsCopyWith(_RevenueMetrics value, $Res Function(_RevenueMetrics) _then) = __$RevenueMetricsCopyWithImpl;
@override @useResult
$Res call({
 double total, int count, double avg
});




}
/// @nodoc
class __$RevenueMetricsCopyWithImpl<$Res>
    implements _$RevenueMetricsCopyWith<$Res> {
  __$RevenueMetricsCopyWithImpl(this._self, this._then);

  final _RevenueMetrics _self;
  final $Res Function(_RevenueMetrics) _then;

/// Create a copy of RevenueMetrics
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? total = null,Object? count = null,Object? avg = null,}) {
  return _then(_RevenueMetrics(
total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,avg: null == avg ? _self.avg : avg // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$OperationalMetrics {

 double get utilization; double get efficiency; double get onTimeRate; double get cancellationRate;
/// Create a copy of OperationalMetrics
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OperationalMetricsCopyWith<OperationalMetrics> get copyWith => _$OperationalMetricsCopyWithImpl<OperationalMetrics>(this as OperationalMetrics, _$identity);

  /// Serializes this OperationalMetrics to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OperationalMetrics&&(identical(other.utilization, utilization) || other.utilization == utilization)&&(identical(other.efficiency, efficiency) || other.efficiency == efficiency)&&(identical(other.onTimeRate, onTimeRate) || other.onTimeRate == onTimeRate)&&(identical(other.cancellationRate, cancellationRate) || other.cancellationRate == cancellationRate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,utilization,efficiency,onTimeRate,cancellationRate);

@override
String toString() {
  return 'OperationalMetrics(utilization: $utilization, efficiency: $efficiency, onTimeRate: $onTimeRate, cancellationRate: $cancellationRate)';
}


}

/// @nodoc
abstract mixin class $OperationalMetricsCopyWith<$Res>  {
  factory $OperationalMetricsCopyWith(OperationalMetrics value, $Res Function(OperationalMetrics) _then) = _$OperationalMetricsCopyWithImpl;
@useResult
$Res call({
 double utilization, double efficiency, double onTimeRate, double cancellationRate
});




}
/// @nodoc
class _$OperationalMetricsCopyWithImpl<$Res>
    implements $OperationalMetricsCopyWith<$Res> {
  _$OperationalMetricsCopyWithImpl(this._self, this._then);

  final OperationalMetrics _self;
  final $Res Function(OperationalMetrics) _then;

/// Create a copy of OperationalMetrics
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? utilization = null,Object? efficiency = null,Object? onTimeRate = null,Object? cancellationRate = null,}) {
  return _then(_self.copyWith(
utilization: null == utilization ? _self.utilization : utilization // ignore: cast_nullable_to_non_nullable
as double,efficiency: null == efficiency ? _self.efficiency : efficiency // ignore: cast_nullable_to_non_nullable
as double,onTimeRate: null == onTimeRate ? _self.onTimeRate : onTimeRate // ignore: cast_nullable_to_non_nullable
as double,cancellationRate: null == cancellationRate ? _self.cancellationRate : cancellationRate // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [OperationalMetrics].
extension OperationalMetricsPatterns on OperationalMetrics {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OperationalMetrics value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OperationalMetrics() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OperationalMetrics value)  $default,){
final _that = this;
switch (_that) {
case _OperationalMetrics():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OperationalMetrics value)?  $default,){
final _that = this;
switch (_that) {
case _OperationalMetrics() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double utilization,  double efficiency,  double onTimeRate,  double cancellationRate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OperationalMetrics() when $default != null:
return $default(_that.utilization,_that.efficiency,_that.onTimeRate,_that.cancellationRate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double utilization,  double efficiency,  double onTimeRate,  double cancellationRate)  $default,) {final _that = this;
switch (_that) {
case _OperationalMetrics():
return $default(_that.utilization,_that.efficiency,_that.onTimeRate,_that.cancellationRate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double utilization,  double efficiency,  double onTimeRate,  double cancellationRate)?  $default,) {final _that = this;
switch (_that) {
case _OperationalMetrics() when $default != null:
return $default(_that.utilization,_that.efficiency,_that.onTimeRate,_that.cancellationRate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OperationalMetrics implements OperationalMetrics {
  const _OperationalMetrics({required this.utilization, required this.efficiency, required this.onTimeRate, required this.cancellationRate});
  factory _OperationalMetrics.fromJson(Map<String, dynamic> json) => _$OperationalMetricsFromJson(json);

@override final  double utilization;
@override final  double efficiency;
@override final  double onTimeRate;
@override final  double cancellationRate;

/// Create a copy of OperationalMetrics
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OperationalMetricsCopyWith<_OperationalMetrics> get copyWith => __$OperationalMetricsCopyWithImpl<_OperationalMetrics>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OperationalMetricsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OperationalMetrics&&(identical(other.utilization, utilization) || other.utilization == utilization)&&(identical(other.efficiency, efficiency) || other.efficiency == efficiency)&&(identical(other.onTimeRate, onTimeRate) || other.onTimeRate == onTimeRate)&&(identical(other.cancellationRate, cancellationRate) || other.cancellationRate == cancellationRate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,utilization,efficiency,onTimeRate,cancellationRate);

@override
String toString() {
  return 'OperationalMetrics(utilization: $utilization, efficiency: $efficiency, onTimeRate: $onTimeRate, cancellationRate: $cancellationRate)';
}


}

/// @nodoc
abstract mixin class _$OperationalMetricsCopyWith<$Res> implements $OperationalMetricsCopyWith<$Res> {
  factory _$OperationalMetricsCopyWith(_OperationalMetrics value, $Res Function(_OperationalMetrics) _then) = __$OperationalMetricsCopyWithImpl;
@override @useResult
$Res call({
 double utilization, double efficiency, double onTimeRate, double cancellationRate
});




}
/// @nodoc
class __$OperationalMetricsCopyWithImpl<$Res>
    implements _$OperationalMetricsCopyWith<$Res> {
  __$OperationalMetricsCopyWithImpl(this._self, this._then);

  final _OperationalMetrics _self;
  final $Res Function(_OperationalMetrics) _then;

/// Create a copy of OperationalMetrics
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? utilization = null,Object? efficiency = null,Object? onTimeRate = null,Object? cancellationRate = null,}) {
  return _then(_OperationalMetrics(
utilization: null == utilization ? _self.utilization : utilization // ignore: cast_nullable_to_non_nullable
as double,efficiency: null == efficiency ? _self.efficiency : efficiency // ignore: cast_nullable_to_non_nullable
as double,onTimeRate: null == onTimeRate ? _self.onTimeRate : onTimeRate // ignore: cast_nullable_to_non_nullable
as double,cancellationRate: null == cancellationRate ? _self.cancellationRate : cancellationRate // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$ClientMetrics {

 int get total; int get active; double get retention; double get satisfaction; int get nps;
/// Create a copy of ClientMetrics
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClientMetricsCopyWith<ClientMetrics> get copyWith => _$ClientMetricsCopyWithImpl<ClientMetrics>(this as ClientMetrics, _$identity);

  /// Serializes this ClientMetrics to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClientMetrics&&(identical(other.total, total) || other.total == total)&&(identical(other.active, active) || other.active == active)&&(identical(other.retention, retention) || other.retention == retention)&&(identical(other.satisfaction, satisfaction) || other.satisfaction == satisfaction)&&(identical(other.nps, nps) || other.nps == nps));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,total,active,retention,satisfaction,nps);

@override
String toString() {
  return 'ClientMetrics(total: $total, active: $active, retention: $retention, satisfaction: $satisfaction, nps: $nps)';
}


}

/// @nodoc
abstract mixin class $ClientMetricsCopyWith<$Res>  {
  factory $ClientMetricsCopyWith(ClientMetrics value, $Res Function(ClientMetrics) _then) = _$ClientMetricsCopyWithImpl;
@useResult
$Res call({
 int total, int active, double retention, double satisfaction, int nps
});




}
/// @nodoc
class _$ClientMetricsCopyWithImpl<$Res>
    implements $ClientMetricsCopyWith<$Res> {
  _$ClientMetricsCopyWithImpl(this._self, this._then);

  final ClientMetrics _self;
  final $Res Function(ClientMetrics) _then;

/// Create a copy of ClientMetrics
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? total = null,Object? active = null,Object? retention = null,Object? satisfaction = null,Object? nps = null,}) {
  return _then(_self.copyWith(
total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as int,retention: null == retention ? _self.retention : retention // ignore: cast_nullable_to_non_nullable
as double,satisfaction: null == satisfaction ? _self.satisfaction : satisfaction // ignore: cast_nullable_to_non_nullable
as double,nps: null == nps ? _self.nps : nps // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ClientMetrics].
extension ClientMetricsPatterns on ClientMetrics {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClientMetrics value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClientMetrics() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClientMetrics value)  $default,){
final _that = this;
switch (_that) {
case _ClientMetrics():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClientMetrics value)?  $default,){
final _that = this;
switch (_that) {
case _ClientMetrics() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int total,  int active,  double retention,  double satisfaction,  int nps)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClientMetrics() when $default != null:
return $default(_that.total,_that.active,_that.retention,_that.satisfaction,_that.nps);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int total,  int active,  double retention,  double satisfaction,  int nps)  $default,) {final _that = this;
switch (_that) {
case _ClientMetrics():
return $default(_that.total,_that.active,_that.retention,_that.satisfaction,_that.nps);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int total,  int active,  double retention,  double satisfaction,  int nps)?  $default,) {final _that = this;
switch (_that) {
case _ClientMetrics() when $default != null:
return $default(_that.total,_that.active,_that.retention,_that.satisfaction,_that.nps);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ClientMetrics implements ClientMetrics {
  const _ClientMetrics({required this.total, required this.active, required this.retention, required this.satisfaction, required this.nps});
  factory _ClientMetrics.fromJson(Map<String, dynamic> json) => _$ClientMetricsFromJson(json);

@override final  int total;
@override final  int active;
@override final  double retention;
@override final  double satisfaction;
@override final  int nps;

/// Create a copy of ClientMetrics
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClientMetricsCopyWith<_ClientMetrics> get copyWith => __$ClientMetricsCopyWithImpl<_ClientMetrics>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClientMetricsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClientMetrics&&(identical(other.total, total) || other.total == total)&&(identical(other.active, active) || other.active == active)&&(identical(other.retention, retention) || other.retention == retention)&&(identical(other.satisfaction, satisfaction) || other.satisfaction == satisfaction)&&(identical(other.nps, nps) || other.nps == nps));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,total,active,retention,satisfaction,nps);

@override
String toString() {
  return 'ClientMetrics(total: $total, active: $active, retention: $retention, satisfaction: $satisfaction, nps: $nps)';
}


}

/// @nodoc
abstract mixin class _$ClientMetricsCopyWith<$Res> implements $ClientMetricsCopyWith<$Res> {
  factory _$ClientMetricsCopyWith(_ClientMetrics value, $Res Function(_ClientMetrics) _then) = __$ClientMetricsCopyWithImpl;
@override @useResult
$Res call({
 int total, int active, double retention, double satisfaction, int nps
});




}
/// @nodoc
class __$ClientMetricsCopyWithImpl<$Res>
    implements _$ClientMetricsCopyWith<$Res> {
  __$ClientMetricsCopyWithImpl(this._self, this._then);

  final _ClientMetrics _self;
  final $Res Function(_ClientMetrics) _then;

/// Create a copy of ClientMetrics
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? total = null,Object? active = null,Object? retention = null,Object? satisfaction = null,Object? nps = null,}) {
  return _then(_ClientMetrics(
total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as int,retention: null == retention ? _self.retention : retention // ignore: cast_nullable_to_non_nullable
as double,satisfaction: null == satisfaction ? _self.satisfaction : satisfaction // ignore: cast_nullable_to_non_nullable
as double,nps: null == nps ? _self.nps : nps // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$WorkforceMetrics {

 int get total; double get utilization; double get productivity; double get satisfaction; double get turnover;
/// Create a copy of WorkforceMetrics
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WorkforceMetricsCopyWith<WorkforceMetrics> get copyWith => _$WorkforceMetricsCopyWithImpl<WorkforceMetrics>(this as WorkforceMetrics, _$identity);

  /// Serializes this WorkforceMetrics to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WorkforceMetrics&&(identical(other.total, total) || other.total == total)&&(identical(other.utilization, utilization) || other.utilization == utilization)&&(identical(other.productivity, productivity) || other.productivity == productivity)&&(identical(other.satisfaction, satisfaction) || other.satisfaction == satisfaction)&&(identical(other.turnover, turnover) || other.turnover == turnover));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,total,utilization,productivity,satisfaction,turnover);

@override
String toString() {
  return 'WorkforceMetrics(total: $total, utilization: $utilization, productivity: $productivity, satisfaction: $satisfaction, turnover: $turnover)';
}


}

/// @nodoc
abstract mixin class $WorkforceMetricsCopyWith<$Res>  {
  factory $WorkforceMetricsCopyWith(WorkforceMetrics value, $Res Function(WorkforceMetrics) _then) = _$WorkforceMetricsCopyWithImpl;
@useResult
$Res call({
 int total, double utilization, double productivity, double satisfaction, double turnover
});




}
/// @nodoc
class _$WorkforceMetricsCopyWithImpl<$Res>
    implements $WorkforceMetricsCopyWith<$Res> {
  _$WorkforceMetricsCopyWithImpl(this._self, this._then);

  final WorkforceMetrics _self;
  final $Res Function(WorkforceMetrics) _then;

/// Create a copy of WorkforceMetrics
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? total = null,Object? utilization = null,Object? productivity = null,Object? satisfaction = null,Object? turnover = null,}) {
  return _then(_self.copyWith(
total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,utilization: null == utilization ? _self.utilization : utilization // ignore: cast_nullable_to_non_nullable
as double,productivity: null == productivity ? _self.productivity : productivity // ignore: cast_nullable_to_non_nullable
as double,satisfaction: null == satisfaction ? _self.satisfaction : satisfaction // ignore: cast_nullable_to_non_nullable
as double,turnover: null == turnover ? _self.turnover : turnover // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [WorkforceMetrics].
extension WorkforceMetricsPatterns on WorkforceMetrics {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WorkforceMetrics value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WorkforceMetrics() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WorkforceMetrics value)  $default,){
final _that = this;
switch (_that) {
case _WorkforceMetrics():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WorkforceMetrics value)?  $default,){
final _that = this;
switch (_that) {
case _WorkforceMetrics() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int total,  double utilization,  double productivity,  double satisfaction,  double turnover)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WorkforceMetrics() when $default != null:
return $default(_that.total,_that.utilization,_that.productivity,_that.satisfaction,_that.turnover);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int total,  double utilization,  double productivity,  double satisfaction,  double turnover)  $default,) {final _that = this;
switch (_that) {
case _WorkforceMetrics():
return $default(_that.total,_that.utilization,_that.productivity,_that.satisfaction,_that.turnover);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int total,  double utilization,  double productivity,  double satisfaction,  double turnover)?  $default,) {final _that = this;
switch (_that) {
case _WorkforceMetrics() when $default != null:
return $default(_that.total,_that.utilization,_that.productivity,_that.satisfaction,_that.turnover);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WorkforceMetrics implements WorkforceMetrics {
  const _WorkforceMetrics({required this.total, required this.utilization, required this.productivity, required this.satisfaction, required this.turnover});
  factory _WorkforceMetrics.fromJson(Map<String, dynamic> json) => _$WorkforceMetricsFromJson(json);

@override final  int total;
@override final  double utilization;
@override final  double productivity;
@override final  double satisfaction;
@override final  double turnover;

/// Create a copy of WorkforceMetrics
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WorkforceMetricsCopyWith<_WorkforceMetrics> get copyWith => __$WorkforceMetricsCopyWithImpl<_WorkforceMetrics>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WorkforceMetricsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WorkforceMetrics&&(identical(other.total, total) || other.total == total)&&(identical(other.utilization, utilization) || other.utilization == utilization)&&(identical(other.productivity, productivity) || other.productivity == productivity)&&(identical(other.satisfaction, satisfaction) || other.satisfaction == satisfaction)&&(identical(other.turnover, turnover) || other.turnover == turnover));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,total,utilization,productivity,satisfaction,turnover);

@override
String toString() {
  return 'WorkforceMetrics(total: $total, utilization: $utilization, productivity: $productivity, satisfaction: $satisfaction, turnover: $turnover)';
}


}

/// @nodoc
abstract mixin class _$WorkforceMetricsCopyWith<$Res> implements $WorkforceMetricsCopyWith<$Res> {
  factory _$WorkforceMetricsCopyWith(_WorkforceMetrics value, $Res Function(_WorkforceMetrics) _then) = __$WorkforceMetricsCopyWithImpl;
@override @useResult
$Res call({
 int total, double utilization, double productivity, double satisfaction, double turnover
});




}
/// @nodoc
class __$WorkforceMetricsCopyWithImpl<$Res>
    implements _$WorkforceMetricsCopyWith<$Res> {
  __$WorkforceMetricsCopyWithImpl(this._self, this._then);

  final _WorkforceMetrics _self;
  final $Res Function(_WorkforceMetrics) _then;

/// Create a copy of WorkforceMetrics
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? total = null,Object? utilization = null,Object? productivity = null,Object? satisfaction = null,Object? turnover = null,}) {
  return _then(_WorkforceMetrics(
total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,utilization: null == utilization ? _self.utilization : utilization // ignore: cast_nullable_to_non_nullable
as double,productivity: null == productivity ? _self.productivity : productivity // ignore: cast_nullable_to_non_nullable
as double,satisfaction: null == satisfaction ? _self.satisfaction : satisfaction // ignore: cast_nullable_to_non_nullable
as double,turnover: null == turnover ? _self.turnover : turnover // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$TrendData {

 String get direction; double get change;
/// Create a copy of TrendData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrendDataCopyWith<TrendData> get copyWith => _$TrendDataCopyWithImpl<TrendData>(this as TrendData, _$identity);

  /// Serializes this TrendData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TrendData&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.change, change) || other.change == change));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,direction,change);

@override
String toString() {
  return 'TrendData(direction: $direction, change: $change)';
}


}

/// @nodoc
abstract mixin class $TrendDataCopyWith<$Res>  {
  factory $TrendDataCopyWith(TrendData value, $Res Function(TrendData) _then) = _$TrendDataCopyWithImpl;
@useResult
$Res call({
 String direction, double change
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
@pragma('vm:prefer-inline') @override $Res call({Object? direction = null,Object? change = null,}) {
  return _then(_self.copyWith(
direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as String,change: null == change ? _self.change : change // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String direction,  double change)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TrendData() when $default != null:
return $default(_that.direction,_that.change);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String direction,  double change)  $default,) {final _that = this;
switch (_that) {
case _TrendData():
return $default(_that.direction,_that.change);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String direction,  double change)?  $default,) {final _that = this;
switch (_that) {
case _TrendData() when $default != null:
return $default(_that.direction,_that.change);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TrendData implements TrendData {
  const _TrendData({required this.direction, required this.change});
  factory _TrendData.fromJson(Map<String, dynamic> json) => _$TrendDataFromJson(json);

@override final  String direction;
@override final  double change;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TrendData&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.change, change) || other.change == change));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,direction,change);

@override
String toString() {
  return 'TrendData(direction: $direction, change: $change)';
}


}

/// @nodoc
abstract mixin class _$TrendDataCopyWith<$Res> implements $TrendDataCopyWith<$Res> {
  factory _$TrendDataCopyWith(_TrendData value, $Res Function(_TrendData) _then) = __$TrendDataCopyWithImpl;
@override @useResult
$Res call({
 String direction, double change
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
@override @pragma('vm:prefer-inline') $Res call({Object? direction = null,Object? change = null,}) {
  return _then(_TrendData(
direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as String,change: null == change ? _self.change : change // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$RevenueForecast {

 int get period; double get predicted; double get lower; double get upper;
/// Create a copy of RevenueForecast
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RevenueForecastCopyWith<RevenueForecast> get copyWith => _$RevenueForecastCopyWithImpl<RevenueForecast>(this as RevenueForecast, _$identity);

  /// Serializes this RevenueForecast to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RevenueForecast&&(identical(other.period, period) || other.period == period)&&(identical(other.predicted, predicted) || other.predicted == predicted)&&(identical(other.lower, lower) || other.lower == lower)&&(identical(other.upper, upper) || other.upper == upper));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,period,predicted,lower,upper);

@override
String toString() {
  return 'RevenueForecast(period: $period, predicted: $predicted, lower: $lower, upper: $upper)';
}


}

/// @nodoc
abstract mixin class $RevenueForecastCopyWith<$Res>  {
  factory $RevenueForecastCopyWith(RevenueForecast value, $Res Function(RevenueForecast) _then) = _$RevenueForecastCopyWithImpl;
@useResult
$Res call({
 int period, double predicted, double lower, double upper
});




}
/// @nodoc
class _$RevenueForecastCopyWithImpl<$Res>
    implements $RevenueForecastCopyWith<$Res> {
  _$RevenueForecastCopyWithImpl(this._self, this._then);

  final RevenueForecast _self;
  final $Res Function(RevenueForecast) _then;

/// Create a copy of RevenueForecast
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? period = null,Object? predicted = null,Object? lower = null,Object? upper = null,}) {
  return _then(_self.copyWith(
period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as int,predicted: null == predicted ? _self.predicted : predicted // ignore: cast_nullable_to_non_nullable
as double,lower: null == lower ? _self.lower : lower // ignore: cast_nullable_to_non_nullable
as double,upper: null == upper ? _self.upper : upper // ignore: cast_nullable_to_non_nullable
as double,
  ));
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int period,  double predicted,  double lower,  double upper)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RevenueForecast() when $default != null:
return $default(_that.period,_that.predicted,_that.lower,_that.upper);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int period,  double predicted,  double lower,  double upper)  $default,) {final _that = this;
switch (_that) {
case _RevenueForecast():
return $default(_that.period,_that.predicted,_that.lower,_that.upper);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int period,  double predicted,  double lower,  double upper)?  $default,) {final _that = this;
switch (_that) {
case _RevenueForecast() when $default != null:
return $default(_that.period,_that.predicted,_that.lower,_that.upper);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RevenueForecast implements RevenueForecast {
  const _RevenueForecast({required this.period, required this.predicted, required this.lower, required this.upper});
  factory _RevenueForecast.fromJson(Map<String, dynamic> json) => _$RevenueForecastFromJson(json);

@override final  int period;
@override final  double predicted;
@override final  double lower;
@override final  double upper;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RevenueForecast&&(identical(other.period, period) || other.period == period)&&(identical(other.predicted, predicted) || other.predicted == predicted)&&(identical(other.lower, lower) || other.lower == lower)&&(identical(other.upper, upper) || other.upper == upper));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,period,predicted,lower,upper);

@override
String toString() {
  return 'RevenueForecast(period: $period, predicted: $predicted, lower: $lower, upper: $upper)';
}


}

/// @nodoc
abstract mixin class _$RevenueForecastCopyWith<$Res> implements $RevenueForecastCopyWith<$Res> {
  factory _$RevenueForecastCopyWith(_RevenueForecast value, $Res Function(_RevenueForecast) _then) = __$RevenueForecastCopyWithImpl;
@override @useResult
$Res call({
 int period, double predicted, double lower, double upper
});




}
/// @nodoc
class __$RevenueForecastCopyWithImpl<$Res>
    implements _$RevenueForecastCopyWith<$Res> {
  __$RevenueForecastCopyWithImpl(this._self, this._then);

  final _RevenueForecast _self;
  final $Res Function(_RevenueForecast) _then;

/// Create a copy of RevenueForecast
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? period = null,Object? predicted = null,Object? lower = null,Object? upper = null,}) {
  return _then(_RevenueForecast(
period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as int,predicted: null == predicted ? _self.predicted : predicted // ignore: cast_nullable_to_non_nullable
as double,lower: null == lower ? _self.lower : lower // ignore: cast_nullable_to_non_nullable
as double,upper: null == upper ? _self.upper : upper // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$ChurnPrediction {

 String get clientId; String get clientName; double get churnScore; String get churnRisk; ChurnFactors get factors; List<ChurnIntervention> get interventions; double get lifetimeValue;
/// Create a copy of ChurnPrediction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChurnPredictionCopyWith<ChurnPrediction> get copyWith => _$ChurnPredictionCopyWithImpl<ChurnPrediction>(this as ChurnPrediction, _$identity);

  /// Serializes this ChurnPrediction to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChurnPrediction&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.clientName, clientName) || other.clientName == clientName)&&(identical(other.churnScore, churnScore) || other.churnScore == churnScore)&&(identical(other.churnRisk, churnRisk) || other.churnRisk == churnRisk)&&(identical(other.factors, factors) || other.factors == factors)&&const DeepCollectionEquality().equals(other.interventions, interventions)&&(identical(other.lifetimeValue, lifetimeValue) || other.lifetimeValue == lifetimeValue));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,clientId,clientName,churnScore,churnRisk,factors,const DeepCollectionEquality().hash(interventions),lifetimeValue);

@override
String toString() {
  return 'ChurnPrediction(clientId: $clientId, clientName: $clientName, churnScore: $churnScore, churnRisk: $churnRisk, factors: $factors, interventions: $interventions, lifetimeValue: $lifetimeValue)';
}


}

/// @nodoc
abstract mixin class $ChurnPredictionCopyWith<$Res>  {
  factory $ChurnPredictionCopyWith(ChurnPrediction value, $Res Function(ChurnPrediction) _then) = _$ChurnPredictionCopyWithImpl;
@useResult
$Res call({
 String clientId, String clientName, double churnScore, String churnRisk, ChurnFactors factors, List<ChurnIntervention> interventions, double lifetimeValue
});


$ChurnFactorsCopyWith<$Res> get factors;

}
/// @nodoc
class _$ChurnPredictionCopyWithImpl<$Res>
    implements $ChurnPredictionCopyWith<$Res> {
  _$ChurnPredictionCopyWithImpl(this._self, this._then);

  final ChurnPrediction _self;
  final $Res Function(ChurnPrediction) _then;

/// Create a copy of ChurnPrediction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? clientId = null,Object? clientName = null,Object? churnScore = null,Object? churnRisk = null,Object? factors = null,Object? interventions = null,Object? lifetimeValue = null,}) {
  return _then(_self.copyWith(
clientId: null == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String,clientName: null == clientName ? _self.clientName : clientName // ignore: cast_nullable_to_non_nullable
as String,churnScore: null == churnScore ? _self.churnScore : churnScore // ignore: cast_nullable_to_non_nullable
as double,churnRisk: null == churnRisk ? _self.churnRisk : churnRisk // ignore: cast_nullable_to_non_nullable
as String,factors: null == factors ? _self.factors : factors // ignore: cast_nullable_to_non_nullable
as ChurnFactors,interventions: null == interventions ? _self.interventions : interventions // ignore: cast_nullable_to_non_nullable
as List<ChurnIntervention>,lifetimeValue: null == lifetimeValue ? _self.lifetimeValue : lifetimeValue // ignore: cast_nullable_to_non_nullable
as double,
  ));
}
/// Create a copy of ChurnPrediction
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChurnFactorsCopyWith<$Res> get factors {
  
  return $ChurnFactorsCopyWith<$Res>(_self.factors, (value) {
    return _then(_self.copyWith(factors: value));
  });
}
}


/// Adds pattern-matching-related methods to [ChurnPrediction].
extension ChurnPredictionPatterns on ChurnPrediction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChurnPrediction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChurnPrediction() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChurnPrediction value)  $default,){
final _that = this;
switch (_that) {
case _ChurnPrediction():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChurnPrediction value)?  $default,){
final _that = this;
switch (_that) {
case _ChurnPrediction() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String clientId,  String clientName,  double churnScore,  String churnRisk,  ChurnFactors factors,  List<ChurnIntervention> interventions,  double lifetimeValue)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChurnPrediction() when $default != null:
return $default(_that.clientId,_that.clientName,_that.churnScore,_that.churnRisk,_that.factors,_that.interventions,_that.lifetimeValue);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String clientId,  String clientName,  double churnScore,  String churnRisk,  ChurnFactors factors,  List<ChurnIntervention> interventions,  double lifetimeValue)  $default,) {final _that = this;
switch (_that) {
case _ChurnPrediction():
return $default(_that.clientId,_that.clientName,_that.churnScore,_that.churnRisk,_that.factors,_that.interventions,_that.lifetimeValue);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String clientId,  String clientName,  double churnScore,  String churnRisk,  ChurnFactors factors,  List<ChurnIntervention> interventions,  double lifetimeValue)?  $default,) {final _that = this;
switch (_that) {
case _ChurnPrediction() when $default != null:
return $default(_that.clientId,_that.clientName,_that.churnScore,_that.churnRisk,_that.factors,_that.interventions,_that.lifetimeValue);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChurnPrediction implements ChurnPrediction {
  const _ChurnPrediction({required this.clientId, required this.clientName, required this.churnScore, required this.churnRisk, required this.factors, required final  List<ChurnIntervention> interventions, required this.lifetimeValue}): _interventions = interventions;
  factory _ChurnPrediction.fromJson(Map<String, dynamic> json) => _$ChurnPredictionFromJson(json);

@override final  String clientId;
@override final  String clientName;
@override final  double churnScore;
@override final  String churnRisk;
@override final  ChurnFactors factors;
 final  List<ChurnIntervention> _interventions;
@override List<ChurnIntervention> get interventions {
  if (_interventions is EqualUnmodifiableListView) return _interventions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_interventions);
}

@override final  double lifetimeValue;

/// Create a copy of ChurnPrediction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChurnPredictionCopyWith<_ChurnPrediction> get copyWith => __$ChurnPredictionCopyWithImpl<_ChurnPrediction>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChurnPredictionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChurnPrediction&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.clientName, clientName) || other.clientName == clientName)&&(identical(other.churnScore, churnScore) || other.churnScore == churnScore)&&(identical(other.churnRisk, churnRisk) || other.churnRisk == churnRisk)&&(identical(other.factors, factors) || other.factors == factors)&&const DeepCollectionEquality().equals(other._interventions, _interventions)&&(identical(other.lifetimeValue, lifetimeValue) || other.lifetimeValue == lifetimeValue));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,clientId,clientName,churnScore,churnRisk,factors,const DeepCollectionEquality().hash(_interventions),lifetimeValue);

@override
String toString() {
  return 'ChurnPrediction(clientId: $clientId, clientName: $clientName, churnScore: $churnScore, churnRisk: $churnRisk, factors: $factors, interventions: $interventions, lifetimeValue: $lifetimeValue)';
}


}

/// @nodoc
abstract mixin class _$ChurnPredictionCopyWith<$Res> implements $ChurnPredictionCopyWith<$Res> {
  factory _$ChurnPredictionCopyWith(_ChurnPrediction value, $Res Function(_ChurnPrediction) _then) = __$ChurnPredictionCopyWithImpl;
@override @useResult
$Res call({
 String clientId, String clientName, double churnScore, String churnRisk, ChurnFactors factors, List<ChurnIntervention> interventions, double lifetimeValue
});


@override $ChurnFactorsCopyWith<$Res> get factors;

}
/// @nodoc
class __$ChurnPredictionCopyWithImpl<$Res>
    implements _$ChurnPredictionCopyWith<$Res> {
  __$ChurnPredictionCopyWithImpl(this._self, this._then);

  final _ChurnPrediction _self;
  final $Res Function(_ChurnPrediction) _then;

/// Create a copy of ChurnPrediction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? clientId = null,Object? clientName = null,Object? churnScore = null,Object? churnRisk = null,Object? factors = null,Object? interventions = null,Object? lifetimeValue = null,}) {
  return _then(_ChurnPrediction(
clientId: null == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String,clientName: null == clientName ? _self.clientName : clientName // ignore: cast_nullable_to_non_nullable
as String,churnScore: null == churnScore ? _self.churnScore : churnScore // ignore: cast_nullable_to_non_nullable
as double,churnRisk: null == churnRisk ? _self.churnRisk : churnRisk // ignore: cast_nullable_to_non_nullable
as String,factors: null == factors ? _self.factors : factors // ignore: cast_nullable_to_non_nullable
as ChurnFactors,interventions: null == interventions ? _self._interventions : interventions // ignore: cast_nullable_to_non_nullable
as List<ChurnIntervention>,lifetimeValue: null == lifetimeValue ? _self.lifetimeValue : lifetimeValue // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

/// Create a copy of ChurnPrediction
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChurnFactorsCopyWith<$Res> get factors {
  
  return $ChurnFactorsCopyWith<$Res>(_self.factors, (value) {
    return _then(_self.copyWith(factors: value));
  });
}
}


/// @nodoc
mixin _$ChurnFactors {

 double get recency; double get frequency; double get monetary; double get satisfaction; double get engagement;
/// Create a copy of ChurnFactors
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChurnFactorsCopyWith<ChurnFactors> get copyWith => _$ChurnFactorsCopyWithImpl<ChurnFactors>(this as ChurnFactors, _$identity);

  /// Serializes this ChurnFactors to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChurnFactors&&(identical(other.recency, recency) || other.recency == recency)&&(identical(other.frequency, frequency) || other.frequency == frequency)&&(identical(other.monetary, monetary) || other.monetary == monetary)&&(identical(other.satisfaction, satisfaction) || other.satisfaction == satisfaction)&&(identical(other.engagement, engagement) || other.engagement == engagement));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,recency,frequency,monetary,satisfaction,engagement);

@override
String toString() {
  return 'ChurnFactors(recency: $recency, frequency: $frequency, monetary: $monetary, satisfaction: $satisfaction, engagement: $engagement)';
}


}

/// @nodoc
abstract mixin class $ChurnFactorsCopyWith<$Res>  {
  factory $ChurnFactorsCopyWith(ChurnFactors value, $Res Function(ChurnFactors) _then) = _$ChurnFactorsCopyWithImpl;
@useResult
$Res call({
 double recency, double frequency, double monetary, double satisfaction, double engagement
});




}
/// @nodoc
class _$ChurnFactorsCopyWithImpl<$Res>
    implements $ChurnFactorsCopyWith<$Res> {
  _$ChurnFactorsCopyWithImpl(this._self, this._then);

  final ChurnFactors _self;
  final $Res Function(ChurnFactors) _then;

/// Create a copy of ChurnFactors
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? recency = null,Object? frequency = null,Object? monetary = null,Object? satisfaction = null,Object? engagement = null,}) {
  return _then(_self.copyWith(
recency: null == recency ? _self.recency : recency // ignore: cast_nullable_to_non_nullable
as double,frequency: null == frequency ? _self.frequency : frequency // ignore: cast_nullable_to_non_nullable
as double,monetary: null == monetary ? _self.monetary : monetary // ignore: cast_nullable_to_non_nullable
as double,satisfaction: null == satisfaction ? _self.satisfaction : satisfaction // ignore: cast_nullable_to_non_nullable
as double,engagement: null == engagement ? _self.engagement : engagement // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [ChurnFactors].
extension ChurnFactorsPatterns on ChurnFactors {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChurnFactors value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChurnFactors() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChurnFactors value)  $default,){
final _that = this;
switch (_that) {
case _ChurnFactors():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChurnFactors value)?  $default,){
final _that = this;
switch (_that) {
case _ChurnFactors() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double recency,  double frequency,  double monetary,  double satisfaction,  double engagement)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChurnFactors() when $default != null:
return $default(_that.recency,_that.frequency,_that.monetary,_that.satisfaction,_that.engagement);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double recency,  double frequency,  double monetary,  double satisfaction,  double engagement)  $default,) {final _that = this;
switch (_that) {
case _ChurnFactors():
return $default(_that.recency,_that.frequency,_that.monetary,_that.satisfaction,_that.engagement);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double recency,  double frequency,  double monetary,  double satisfaction,  double engagement)?  $default,) {final _that = this;
switch (_that) {
case _ChurnFactors() when $default != null:
return $default(_that.recency,_that.frequency,_that.monetary,_that.satisfaction,_that.engagement);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChurnFactors implements ChurnFactors {
  const _ChurnFactors({required this.recency, required this.frequency, required this.monetary, required this.satisfaction, required this.engagement});
  factory _ChurnFactors.fromJson(Map<String, dynamic> json) => _$ChurnFactorsFromJson(json);

@override final  double recency;
@override final  double frequency;
@override final  double monetary;
@override final  double satisfaction;
@override final  double engagement;

/// Create a copy of ChurnFactors
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChurnFactorsCopyWith<_ChurnFactors> get copyWith => __$ChurnFactorsCopyWithImpl<_ChurnFactors>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChurnFactorsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChurnFactors&&(identical(other.recency, recency) || other.recency == recency)&&(identical(other.frequency, frequency) || other.frequency == frequency)&&(identical(other.monetary, monetary) || other.monetary == monetary)&&(identical(other.satisfaction, satisfaction) || other.satisfaction == satisfaction)&&(identical(other.engagement, engagement) || other.engagement == engagement));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,recency,frequency,monetary,satisfaction,engagement);

@override
String toString() {
  return 'ChurnFactors(recency: $recency, frequency: $frequency, monetary: $monetary, satisfaction: $satisfaction, engagement: $engagement)';
}


}

/// @nodoc
abstract mixin class _$ChurnFactorsCopyWith<$Res> implements $ChurnFactorsCopyWith<$Res> {
  factory _$ChurnFactorsCopyWith(_ChurnFactors value, $Res Function(_ChurnFactors) _then) = __$ChurnFactorsCopyWithImpl;
@override @useResult
$Res call({
 double recency, double frequency, double monetary, double satisfaction, double engagement
});




}
/// @nodoc
class __$ChurnFactorsCopyWithImpl<$Res>
    implements _$ChurnFactorsCopyWith<$Res> {
  __$ChurnFactorsCopyWithImpl(this._self, this._then);

  final _ChurnFactors _self;
  final $Res Function(_ChurnFactors) _then;

/// Create a copy of ChurnFactors
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? recency = null,Object? frequency = null,Object? monetary = null,Object? satisfaction = null,Object? engagement = null,}) {
  return _then(_ChurnFactors(
recency: null == recency ? _self.recency : recency // ignore: cast_nullable_to_non_nullable
as double,frequency: null == frequency ? _self.frequency : frequency // ignore: cast_nullable_to_non_nullable
as double,monetary: null == monetary ? _self.monetary : monetary // ignore: cast_nullable_to_non_nullable
as double,satisfaction: null == satisfaction ? _self.satisfaction : satisfaction // ignore: cast_nullable_to_non_nullable
as double,engagement: null == engagement ? _self.engagement : engagement // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$ChurnIntervention {

 String get action; String get priority; String get expectedImpact;
/// Create a copy of ChurnIntervention
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChurnInterventionCopyWith<ChurnIntervention> get copyWith => _$ChurnInterventionCopyWithImpl<ChurnIntervention>(this as ChurnIntervention, _$identity);

  /// Serializes this ChurnIntervention to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChurnIntervention&&(identical(other.action, action) || other.action == action)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.expectedImpact, expectedImpact) || other.expectedImpact == expectedImpact));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,action,priority,expectedImpact);

@override
String toString() {
  return 'ChurnIntervention(action: $action, priority: $priority, expectedImpact: $expectedImpact)';
}


}

/// @nodoc
abstract mixin class $ChurnInterventionCopyWith<$Res>  {
  factory $ChurnInterventionCopyWith(ChurnIntervention value, $Res Function(ChurnIntervention) _then) = _$ChurnInterventionCopyWithImpl;
@useResult
$Res call({
 String action, String priority, String expectedImpact
});




}
/// @nodoc
class _$ChurnInterventionCopyWithImpl<$Res>
    implements $ChurnInterventionCopyWith<$Res> {
  _$ChurnInterventionCopyWithImpl(this._self, this._then);

  final ChurnIntervention _self;
  final $Res Function(ChurnIntervention) _then;

/// Create a copy of ChurnIntervention
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? action = null,Object? priority = null,Object? expectedImpact = null,}) {
  return _then(_self.copyWith(
action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as String,expectedImpact: null == expectedImpact ? _self.expectedImpact : expectedImpact // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ChurnIntervention].
extension ChurnInterventionPatterns on ChurnIntervention {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChurnIntervention value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChurnIntervention() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChurnIntervention value)  $default,){
final _that = this;
switch (_that) {
case _ChurnIntervention():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChurnIntervention value)?  $default,){
final _that = this;
switch (_that) {
case _ChurnIntervention() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String action,  String priority,  String expectedImpact)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChurnIntervention() when $default != null:
return $default(_that.action,_that.priority,_that.expectedImpact);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String action,  String priority,  String expectedImpact)  $default,) {final _that = this;
switch (_that) {
case _ChurnIntervention():
return $default(_that.action,_that.priority,_that.expectedImpact);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String action,  String priority,  String expectedImpact)?  $default,) {final _that = this;
switch (_that) {
case _ChurnIntervention() when $default != null:
return $default(_that.action,_that.priority,_that.expectedImpact);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChurnIntervention implements ChurnIntervention {
  const _ChurnIntervention({required this.action, required this.priority, required this.expectedImpact});
  factory _ChurnIntervention.fromJson(Map<String, dynamic> json) => _$ChurnInterventionFromJson(json);

@override final  String action;
@override final  String priority;
@override final  String expectedImpact;

/// Create a copy of ChurnIntervention
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChurnInterventionCopyWith<_ChurnIntervention> get copyWith => __$ChurnInterventionCopyWithImpl<_ChurnIntervention>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChurnInterventionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChurnIntervention&&(identical(other.action, action) || other.action == action)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.expectedImpact, expectedImpact) || other.expectedImpact == expectedImpact));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,action,priority,expectedImpact);

@override
String toString() {
  return 'ChurnIntervention(action: $action, priority: $priority, expectedImpact: $expectedImpact)';
}


}

/// @nodoc
abstract mixin class _$ChurnInterventionCopyWith<$Res> implements $ChurnInterventionCopyWith<$Res> {
  factory _$ChurnInterventionCopyWith(_ChurnIntervention value, $Res Function(_ChurnIntervention) _then) = __$ChurnInterventionCopyWithImpl;
@override @useResult
$Res call({
 String action, String priority, String expectedImpact
});




}
/// @nodoc
class __$ChurnInterventionCopyWithImpl<$Res>
    implements _$ChurnInterventionCopyWith<$Res> {
  __$ChurnInterventionCopyWithImpl(this._self, this._then);

  final _ChurnIntervention _self;
  final $Res Function(_ChurnIntervention) _then;

/// Create a copy of ChurnIntervention
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? action = null,Object? priority = null,Object? expectedImpact = null,}) {
  return _then(_ChurnIntervention(
action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as String,expectedImpact: null == expectedImpact ? _self.expectedImpact : expectedImpact // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ProfitabilityAnalysis {

 String get dimension; double get revenue; double get cost; double get profit; double get margin; int get count;
/// Create a copy of ProfitabilityAnalysis
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfitabilityAnalysisCopyWith<ProfitabilityAnalysis> get copyWith => _$ProfitabilityAnalysisCopyWithImpl<ProfitabilityAnalysis>(this as ProfitabilityAnalysis, _$identity);

  /// Serializes this ProfitabilityAnalysis to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfitabilityAnalysis&&(identical(other.dimension, dimension) || other.dimension == dimension)&&(identical(other.revenue, revenue) || other.revenue == revenue)&&(identical(other.cost, cost) || other.cost == cost)&&(identical(other.profit, profit) || other.profit == profit)&&(identical(other.margin, margin) || other.margin == margin)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,dimension,revenue,cost,profit,margin,count);

@override
String toString() {
  return 'ProfitabilityAnalysis(dimension: $dimension, revenue: $revenue, cost: $cost, profit: $profit, margin: $margin, count: $count)';
}


}

/// @nodoc
abstract mixin class $ProfitabilityAnalysisCopyWith<$Res>  {
  factory $ProfitabilityAnalysisCopyWith(ProfitabilityAnalysis value, $Res Function(ProfitabilityAnalysis) _then) = _$ProfitabilityAnalysisCopyWithImpl;
@useResult
$Res call({
 String dimension, double revenue, double cost, double profit, double margin, int count
});




}
/// @nodoc
class _$ProfitabilityAnalysisCopyWithImpl<$Res>
    implements $ProfitabilityAnalysisCopyWith<$Res> {
  _$ProfitabilityAnalysisCopyWithImpl(this._self, this._then);

  final ProfitabilityAnalysis _self;
  final $Res Function(ProfitabilityAnalysis) _then;

/// Create a copy of ProfitabilityAnalysis
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? dimension = null,Object? revenue = null,Object? cost = null,Object? profit = null,Object? margin = null,Object? count = null,}) {
  return _then(_self.copyWith(
dimension: null == dimension ? _self.dimension : dimension // ignore: cast_nullable_to_non_nullable
as String,revenue: null == revenue ? _self.revenue : revenue // ignore: cast_nullable_to_non_nullable
as double,cost: null == cost ? _self.cost : cost // ignore: cast_nullable_to_non_nullable
as double,profit: null == profit ? _self.profit : profit // ignore: cast_nullable_to_non_nullable
as double,margin: null == margin ? _self.margin : margin // ignore: cast_nullable_to_non_nullable
as double,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ProfitabilityAnalysis].
extension ProfitabilityAnalysisPatterns on ProfitabilityAnalysis {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfitabilityAnalysis value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfitabilityAnalysis() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfitabilityAnalysis value)  $default,){
final _that = this;
switch (_that) {
case _ProfitabilityAnalysis():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfitabilityAnalysis value)?  $default,){
final _that = this;
switch (_that) {
case _ProfitabilityAnalysis() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String dimension,  double revenue,  double cost,  double profit,  double margin,  int count)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfitabilityAnalysis() when $default != null:
return $default(_that.dimension,_that.revenue,_that.cost,_that.profit,_that.margin,_that.count);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String dimension,  double revenue,  double cost,  double profit,  double margin,  int count)  $default,) {final _that = this;
switch (_that) {
case _ProfitabilityAnalysis():
return $default(_that.dimension,_that.revenue,_that.cost,_that.profit,_that.margin,_that.count);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String dimension,  double revenue,  double cost,  double profit,  double margin,  int count)?  $default,) {final _that = this;
switch (_that) {
case _ProfitabilityAnalysis() when $default != null:
return $default(_that.dimension,_that.revenue,_that.cost,_that.profit,_that.margin,_that.count);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProfitabilityAnalysis implements ProfitabilityAnalysis {
  const _ProfitabilityAnalysis({required this.dimension, required this.revenue, required this.cost, required this.profit, required this.margin, required this.count});
  factory _ProfitabilityAnalysis.fromJson(Map<String, dynamic> json) => _$ProfitabilityAnalysisFromJson(json);

@override final  String dimension;
@override final  double revenue;
@override final  double cost;
@override final  double profit;
@override final  double margin;
@override final  int count;

/// Create a copy of ProfitabilityAnalysis
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfitabilityAnalysisCopyWith<_ProfitabilityAnalysis> get copyWith => __$ProfitabilityAnalysisCopyWithImpl<_ProfitabilityAnalysis>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProfitabilityAnalysisToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfitabilityAnalysis&&(identical(other.dimension, dimension) || other.dimension == dimension)&&(identical(other.revenue, revenue) || other.revenue == revenue)&&(identical(other.cost, cost) || other.cost == cost)&&(identical(other.profit, profit) || other.profit == profit)&&(identical(other.margin, margin) || other.margin == margin)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,dimension,revenue,cost,profit,margin,count);

@override
String toString() {
  return 'ProfitabilityAnalysis(dimension: $dimension, revenue: $revenue, cost: $cost, profit: $profit, margin: $margin, count: $count)';
}


}

/// @nodoc
abstract mixin class _$ProfitabilityAnalysisCopyWith<$Res> implements $ProfitabilityAnalysisCopyWith<$Res> {
  factory _$ProfitabilityAnalysisCopyWith(_ProfitabilityAnalysis value, $Res Function(_ProfitabilityAnalysis) _then) = __$ProfitabilityAnalysisCopyWithImpl;
@override @useResult
$Res call({
 String dimension, double revenue, double cost, double profit, double margin, int count
});




}
/// @nodoc
class __$ProfitabilityAnalysisCopyWithImpl<$Res>
    implements _$ProfitabilityAnalysisCopyWith<$Res> {
  __$ProfitabilityAnalysisCopyWithImpl(this._self, this._then);

  final _ProfitabilityAnalysis _self;
  final $Res Function(_ProfitabilityAnalysis) _then;

/// Create a copy of ProfitabilityAnalysis
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? dimension = null,Object? revenue = null,Object? cost = null,Object? profit = null,Object? margin = null,Object? count = null,}) {
  return _then(_ProfitabilityAnalysis(
dimension: null == dimension ? _self.dimension : dimension // ignore: cast_nullable_to_non_nullable
as String,revenue: null == revenue ? _self.revenue : revenue // ignore: cast_nullable_to_non_nullable
as double,cost: null == cost ? _self.cost : cost // ignore: cast_nullable_to_non_nullable
as double,profit: null == profit ? _self.profit : profit // ignore: cast_nullable_to_non_nullable
as double,margin: null == margin ? _self.margin : margin // ignore: cast_nullable_to_non_nullable
as double,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$WhatIfScenario {

 String get name; ScenarioMetrics get baseline; ScenarioMetrics get projected; ScenarioImpact get impact; ScenarioFeasibility get feasibility; ScenarioRecommendation get recommendation;
/// Create a copy of WhatIfScenario
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WhatIfScenarioCopyWith<WhatIfScenario> get copyWith => _$WhatIfScenarioCopyWithImpl<WhatIfScenario>(this as WhatIfScenario, _$identity);

  /// Serializes this WhatIfScenario to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WhatIfScenario&&(identical(other.name, name) || other.name == name)&&(identical(other.baseline, baseline) || other.baseline == baseline)&&(identical(other.projected, projected) || other.projected == projected)&&(identical(other.impact, impact) || other.impact == impact)&&(identical(other.feasibility, feasibility) || other.feasibility == feasibility)&&(identical(other.recommendation, recommendation) || other.recommendation == recommendation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,baseline,projected,impact,feasibility,recommendation);

@override
String toString() {
  return 'WhatIfScenario(name: $name, baseline: $baseline, projected: $projected, impact: $impact, feasibility: $feasibility, recommendation: $recommendation)';
}


}

/// @nodoc
abstract mixin class $WhatIfScenarioCopyWith<$Res>  {
  factory $WhatIfScenarioCopyWith(WhatIfScenario value, $Res Function(WhatIfScenario) _then) = _$WhatIfScenarioCopyWithImpl;
@useResult
$Res call({
 String name, ScenarioMetrics baseline, ScenarioMetrics projected, ScenarioImpact impact, ScenarioFeasibility feasibility, ScenarioRecommendation recommendation
});


$ScenarioMetricsCopyWith<$Res> get baseline;$ScenarioMetricsCopyWith<$Res> get projected;$ScenarioImpactCopyWith<$Res> get impact;$ScenarioFeasibilityCopyWith<$Res> get feasibility;$ScenarioRecommendationCopyWith<$Res> get recommendation;

}
/// @nodoc
class _$WhatIfScenarioCopyWithImpl<$Res>
    implements $WhatIfScenarioCopyWith<$Res> {
  _$WhatIfScenarioCopyWithImpl(this._self, this._then);

  final WhatIfScenario _self;
  final $Res Function(WhatIfScenario) _then;

/// Create a copy of WhatIfScenario
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? baseline = null,Object? projected = null,Object? impact = null,Object? feasibility = null,Object? recommendation = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,baseline: null == baseline ? _self.baseline : baseline // ignore: cast_nullable_to_non_nullable
as ScenarioMetrics,projected: null == projected ? _self.projected : projected // ignore: cast_nullable_to_non_nullable
as ScenarioMetrics,impact: null == impact ? _self.impact : impact // ignore: cast_nullable_to_non_nullable
as ScenarioImpact,feasibility: null == feasibility ? _self.feasibility : feasibility // ignore: cast_nullable_to_non_nullable
as ScenarioFeasibility,recommendation: null == recommendation ? _self.recommendation : recommendation // ignore: cast_nullable_to_non_nullable
as ScenarioRecommendation,
  ));
}
/// Create a copy of WhatIfScenario
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ScenarioMetricsCopyWith<$Res> get baseline {
  
  return $ScenarioMetricsCopyWith<$Res>(_self.baseline, (value) {
    return _then(_self.copyWith(baseline: value));
  });
}/// Create a copy of WhatIfScenario
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ScenarioMetricsCopyWith<$Res> get projected {
  
  return $ScenarioMetricsCopyWith<$Res>(_self.projected, (value) {
    return _then(_self.copyWith(projected: value));
  });
}/// Create a copy of WhatIfScenario
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ScenarioImpactCopyWith<$Res> get impact {
  
  return $ScenarioImpactCopyWith<$Res>(_self.impact, (value) {
    return _then(_self.copyWith(impact: value));
  });
}/// Create a copy of WhatIfScenario
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ScenarioFeasibilityCopyWith<$Res> get feasibility {
  
  return $ScenarioFeasibilityCopyWith<$Res>(_self.feasibility, (value) {
    return _then(_self.copyWith(feasibility: value));
  });
}/// Create a copy of WhatIfScenario
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ScenarioRecommendationCopyWith<$Res> get recommendation {
  
  return $ScenarioRecommendationCopyWith<$Res>(_self.recommendation, (value) {
    return _then(_self.copyWith(recommendation: value));
  });
}
}


/// Adds pattern-matching-related methods to [WhatIfScenario].
extension WhatIfScenarioPatterns on WhatIfScenario {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WhatIfScenario value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WhatIfScenario() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WhatIfScenario value)  $default,){
final _that = this;
switch (_that) {
case _WhatIfScenario():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WhatIfScenario value)?  $default,){
final _that = this;
switch (_that) {
case _WhatIfScenario() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  ScenarioMetrics baseline,  ScenarioMetrics projected,  ScenarioImpact impact,  ScenarioFeasibility feasibility,  ScenarioRecommendation recommendation)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WhatIfScenario() when $default != null:
return $default(_that.name,_that.baseline,_that.projected,_that.impact,_that.feasibility,_that.recommendation);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  ScenarioMetrics baseline,  ScenarioMetrics projected,  ScenarioImpact impact,  ScenarioFeasibility feasibility,  ScenarioRecommendation recommendation)  $default,) {final _that = this;
switch (_that) {
case _WhatIfScenario():
return $default(_that.name,_that.baseline,_that.projected,_that.impact,_that.feasibility,_that.recommendation);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  ScenarioMetrics baseline,  ScenarioMetrics projected,  ScenarioImpact impact,  ScenarioFeasibility feasibility,  ScenarioRecommendation recommendation)?  $default,) {final _that = this;
switch (_that) {
case _WhatIfScenario() when $default != null:
return $default(_that.name,_that.baseline,_that.projected,_that.impact,_that.feasibility,_that.recommendation);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WhatIfScenario implements WhatIfScenario {
  const _WhatIfScenario({required this.name, required this.baseline, required this.projected, required this.impact, required this.feasibility, required this.recommendation});
  factory _WhatIfScenario.fromJson(Map<String, dynamic> json) => _$WhatIfScenarioFromJson(json);

@override final  String name;
@override final  ScenarioMetrics baseline;
@override final  ScenarioMetrics projected;
@override final  ScenarioImpact impact;
@override final  ScenarioFeasibility feasibility;
@override final  ScenarioRecommendation recommendation;

/// Create a copy of WhatIfScenario
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WhatIfScenarioCopyWith<_WhatIfScenario> get copyWith => __$WhatIfScenarioCopyWithImpl<_WhatIfScenario>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WhatIfScenarioToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WhatIfScenario&&(identical(other.name, name) || other.name == name)&&(identical(other.baseline, baseline) || other.baseline == baseline)&&(identical(other.projected, projected) || other.projected == projected)&&(identical(other.impact, impact) || other.impact == impact)&&(identical(other.feasibility, feasibility) || other.feasibility == feasibility)&&(identical(other.recommendation, recommendation) || other.recommendation == recommendation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,baseline,projected,impact,feasibility,recommendation);

@override
String toString() {
  return 'WhatIfScenario(name: $name, baseline: $baseline, projected: $projected, impact: $impact, feasibility: $feasibility, recommendation: $recommendation)';
}


}

/// @nodoc
abstract mixin class _$WhatIfScenarioCopyWith<$Res> implements $WhatIfScenarioCopyWith<$Res> {
  factory _$WhatIfScenarioCopyWith(_WhatIfScenario value, $Res Function(_WhatIfScenario) _then) = __$WhatIfScenarioCopyWithImpl;
@override @useResult
$Res call({
 String name, ScenarioMetrics baseline, ScenarioMetrics projected, ScenarioImpact impact, ScenarioFeasibility feasibility, ScenarioRecommendation recommendation
});


@override $ScenarioMetricsCopyWith<$Res> get baseline;@override $ScenarioMetricsCopyWith<$Res> get projected;@override $ScenarioImpactCopyWith<$Res> get impact;@override $ScenarioFeasibilityCopyWith<$Res> get feasibility;@override $ScenarioRecommendationCopyWith<$Res> get recommendation;

}
/// @nodoc
class __$WhatIfScenarioCopyWithImpl<$Res>
    implements _$WhatIfScenarioCopyWith<$Res> {
  __$WhatIfScenarioCopyWithImpl(this._self, this._then);

  final _WhatIfScenario _self;
  final $Res Function(_WhatIfScenario) _then;

/// Create a copy of WhatIfScenario
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? baseline = null,Object? projected = null,Object? impact = null,Object? feasibility = null,Object? recommendation = null,}) {
  return _then(_WhatIfScenario(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,baseline: null == baseline ? _self.baseline : baseline // ignore: cast_nullable_to_non_nullable
as ScenarioMetrics,projected: null == projected ? _self.projected : projected // ignore: cast_nullable_to_non_nullable
as ScenarioMetrics,impact: null == impact ? _self.impact : impact // ignore: cast_nullable_to_non_nullable
as ScenarioImpact,feasibility: null == feasibility ? _self.feasibility : feasibility // ignore: cast_nullable_to_non_nullable
as ScenarioFeasibility,recommendation: null == recommendation ? _self.recommendation : recommendation // ignore: cast_nullable_to_non_nullable
as ScenarioRecommendation,
  ));
}

/// Create a copy of WhatIfScenario
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ScenarioMetricsCopyWith<$Res> get baseline {
  
  return $ScenarioMetricsCopyWith<$Res>(_self.baseline, (value) {
    return _then(_self.copyWith(baseline: value));
  });
}/// Create a copy of WhatIfScenario
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ScenarioMetricsCopyWith<$Res> get projected {
  
  return $ScenarioMetricsCopyWith<$Res>(_self.projected, (value) {
    return _then(_self.copyWith(projected: value));
  });
}/// Create a copy of WhatIfScenario
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ScenarioImpactCopyWith<$Res> get impact {
  
  return $ScenarioImpactCopyWith<$Res>(_self.impact, (value) {
    return _then(_self.copyWith(impact: value));
  });
}/// Create a copy of WhatIfScenario
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ScenarioFeasibilityCopyWith<$Res> get feasibility {
  
  return $ScenarioFeasibilityCopyWith<$Res>(_self.feasibility, (value) {
    return _then(_self.copyWith(feasibility: value));
  });
}/// Create a copy of WhatIfScenario
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ScenarioRecommendationCopyWith<$Res> get recommendation {
  
  return $ScenarioRecommendationCopyWith<$Res>(_self.recommendation, (value) {
    return _then(_self.copyWith(recommendation: value));
  });
}
}


/// @nodoc
mixin _$ScenarioMetrics {

 int get appointments; int get workers; double get revenue; double get avgRevenuePerWorker;
/// Create a copy of ScenarioMetrics
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScenarioMetricsCopyWith<ScenarioMetrics> get copyWith => _$ScenarioMetricsCopyWithImpl<ScenarioMetrics>(this as ScenarioMetrics, _$identity);

  /// Serializes this ScenarioMetrics to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScenarioMetrics&&(identical(other.appointments, appointments) || other.appointments == appointments)&&(identical(other.workers, workers) || other.workers == workers)&&(identical(other.revenue, revenue) || other.revenue == revenue)&&(identical(other.avgRevenuePerWorker, avgRevenuePerWorker) || other.avgRevenuePerWorker == avgRevenuePerWorker));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,appointments,workers,revenue,avgRevenuePerWorker);

@override
String toString() {
  return 'ScenarioMetrics(appointments: $appointments, workers: $workers, revenue: $revenue, avgRevenuePerWorker: $avgRevenuePerWorker)';
}


}

/// @nodoc
abstract mixin class $ScenarioMetricsCopyWith<$Res>  {
  factory $ScenarioMetricsCopyWith(ScenarioMetrics value, $Res Function(ScenarioMetrics) _then) = _$ScenarioMetricsCopyWithImpl;
@useResult
$Res call({
 int appointments, int workers, double revenue, double avgRevenuePerWorker
});




}
/// @nodoc
class _$ScenarioMetricsCopyWithImpl<$Res>
    implements $ScenarioMetricsCopyWith<$Res> {
  _$ScenarioMetricsCopyWithImpl(this._self, this._then);

  final ScenarioMetrics _self;
  final $Res Function(ScenarioMetrics) _then;

/// Create a copy of ScenarioMetrics
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? appointments = null,Object? workers = null,Object? revenue = null,Object? avgRevenuePerWorker = null,}) {
  return _then(_self.copyWith(
appointments: null == appointments ? _self.appointments : appointments // ignore: cast_nullable_to_non_nullable
as int,workers: null == workers ? _self.workers : workers // ignore: cast_nullable_to_non_nullable
as int,revenue: null == revenue ? _self.revenue : revenue // ignore: cast_nullable_to_non_nullable
as double,avgRevenuePerWorker: null == avgRevenuePerWorker ? _self.avgRevenuePerWorker : avgRevenuePerWorker // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [ScenarioMetrics].
extension ScenarioMetricsPatterns on ScenarioMetrics {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScenarioMetrics value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScenarioMetrics() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScenarioMetrics value)  $default,){
final _that = this;
switch (_that) {
case _ScenarioMetrics():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScenarioMetrics value)?  $default,){
final _that = this;
switch (_that) {
case _ScenarioMetrics() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int appointments,  int workers,  double revenue,  double avgRevenuePerWorker)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScenarioMetrics() when $default != null:
return $default(_that.appointments,_that.workers,_that.revenue,_that.avgRevenuePerWorker);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int appointments,  int workers,  double revenue,  double avgRevenuePerWorker)  $default,) {final _that = this;
switch (_that) {
case _ScenarioMetrics():
return $default(_that.appointments,_that.workers,_that.revenue,_that.avgRevenuePerWorker);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int appointments,  int workers,  double revenue,  double avgRevenuePerWorker)?  $default,) {final _that = this;
switch (_that) {
case _ScenarioMetrics() when $default != null:
return $default(_that.appointments,_that.workers,_that.revenue,_that.avgRevenuePerWorker);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ScenarioMetrics implements ScenarioMetrics {
  const _ScenarioMetrics({required this.appointments, required this.workers, required this.revenue, required this.avgRevenuePerWorker});
  factory _ScenarioMetrics.fromJson(Map<String, dynamic> json) => _$ScenarioMetricsFromJson(json);

@override final  int appointments;
@override final  int workers;
@override final  double revenue;
@override final  double avgRevenuePerWorker;

/// Create a copy of ScenarioMetrics
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScenarioMetricsCopyWith<_ScenarioMetrics> get copyWith => __$ScenarioMetricsCopyWithImpl<_ScenarioMetrics>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ScenarioMetricsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScenarioMetrics&&(identical(other.appointments, appointments) || other.appointments == appointments)&&(identical(other.workers, workers) || other.workers == workers)&&(identical(other.revenue, revenue) || other.revenue == revenue)&&(identical(other.avgRevenuePerWorker, avgRevenuePerWorker) || other.avgRevenuePerWorker == avgRevenuePerWorker));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,appointments,workers,revenue,avgRevenuePerWorker);

@override
String toString() {
  return 'ScenarioMetrics(appointments: $appointments, workers: $workers, revenue: $revenue, avgRevenuePerWorker: $avgRevenuePerWorker)';
}


}

/// @nodoc
abstract mixin class _$ScenarioMetricsCopyWith<$Res> implements $ScenarioMetricsCopyWith<$Res> {
  factory _$ScenarioMetricsCopyWith(_ScenarioMetrics value, $Res Function(_ScenarioMetrics) _then) = __$ScenarioMetricsCopyWithImpl;
@override @useResult
$Res call({
 int appointments, int workers, double revenue, double avgRevenuePerWorker
});




}
/// @nodoc
class __$ScenarioMetricsCopyWithImpl<$Res>
    implements _$ScenarioMetricsCopyWith<$Res> {
  __$ScenarioMetricsCopyWithImpl(this._self, this._then);

  final _ScenarioMetrics _self;
  final $Res Function(_ScenarioMetrics) _then;

/// Create a copy of ScenarioMetrics
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? appointments = null,Object? workers = null,Object? revenue = null,Object? avgRevenuePerWorker = null,}) {
  return _then(_ScenarioMetrics(
appointments: null == appointments ? _self.appointments : appointments // ignore: cast_nullable_to_non_nullable
as int,workers: null == workers ? _self.workers : workers // ignore: cast_nullable_to_non_nullable
as int,revenue: null == revenue ? _self.revenue : revenue // ignore: cast_nullable_to_non_nullable
as double,avgRevenuePerWorker: null == avgRevenuePerWorker ? _self.avgRevenuePerWorker : avgRevenuePerWorker // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$ScenarioImpact {

 double get revenueChange; String get revenueChangePercent; int get appointmentChange; int get workerChange; double get productivityChange;
/// Create a copy of ScenarioImpact
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScenarioImpactCopyWith<ScenarioImpact> get copyWith => _$ScenarioImpactCopyWithImpl<ScenarioImpact>(this as ScenarioImpact, _$identity);

  /// Serializes this ScenarioImpact to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScenarioImpact&&(identical(other.revenueChange, revenueChange) || other.revenueChange == revenueChange)&&(identical(other.revenueChangePercent, revenueChangePercent) || other.revenueChangePercent == revenueChangePercent)&&(identical(other.appointmentChange, appointmentChange) || other.appointmentChange == appointmentChange)&&(identical(other.workerChange, workerChange) || other.workerChange == workerChange)&&(identical(other.productivityChange, productivityChange) || other.productivityChange == productivityChange));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,revenueChange,revenueChangePercent,appointmentChange,workerChange,productivityChange);

@override
String toString() {
  return 'ScenarioImpact(revenueChange: $revenueChange, revenueChangePercent: $revenueChangePercent, appointmentChange: $appointmentChange, workerChange: $workerChange, productivityChange: $productivityChange)';
}


}

/// @nodoc
abstract mixin class $ScenarioImpactCopyWith<$Res>  {
  factory $ScenarioImpactCopyWith(ScenarioImpact value, $Res Function(ScenarioImpact) _then) = _$ScenarioImpactCopyWithImpl;
@useResult
$Res call({
 double revenueChange, String revenueChangePercent, int appointmentChange, int workerChange, double productivityChange
});




}
/// @nodoc
class _$ScenarioImpactCopyWithImpl<$Res>
    implements $ScenarioImpactCopyWith<$Res> {
  _$ScenarioImpactCopyWithImpl(this._self, this._then);

  final ScenarioImpact _self;
  final $Res Function(ScenarioImpact) _then;

/// Create a copy of ScenarioImpact
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? revenueChange = null,Object? revenueChangePercent = null,Object? appointmentChange = null,Object? workerChange = null,Object? productivityChange = null,}) {
  return _then(_self.copyWith(
revenueChange: null == revenueChange ? _self.revenueChange : revenueChange // ignore: cast_nullable_to_non_nullable
as double,revenueChangePercent: null == revenueChangePercent ? _self.revenueChangePercent : revenueChangePercent // ignore: cast_nullable_to_non_nullable
as String,appointmentChange: null == appointmentChange ? _self.appointmentChange : appointmentChange // ignore: cast_nullable_to_non_nullable
as int,workerChange: null == workerChange ? _self.workerChange : workerChange // ignore: cast_nullable_to_non_nullable
as int,productivityChange: null == productivityChange ? _self.productivityChange : productivityChange // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [ScenarioImpact].
extension ScenarioImpactPatterns on ScenarioImpact {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScenarioImpact value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScenarioImpact() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScenarioImpact value)  $default,){
final _that = this;
switch (_that) {
case _ScenarioImpact():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScenarioImpact value)?  $default,){
final _that = this;
switch (_that) {
case _ScenarioImpact() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double revenueChange,  String revenueChangePercent,  int appointmentChange,  int workerChange,  double productivityChange)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScenarioImpact() when $default != null:
return $default(_that.revenueChange,_that.revenueChangePercent,_that.appointmentChange,_that.workerChange,_that.productivityChange);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double revenueChange,  String revenueChangePercent,  int appointmentChange,  int workerChange,  double productivityChange)  $default,) {final _that = this;
switch (_that) {
case _ScenarioImpact():
return $default(_that.revenueChange,_that.revenueChangePercent,_that.appointmentChange,_that.workerChange,_that.productivityChange);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double revenueChange,  String revenueChangePercent,  int appointmentChange,  int workerChange,  double productivityChange)?  $default,) {final _that = this;
switch (_that) {
case _ScenarioImpact() when $default != null:
return $default(_that.revenueChange,_that.revenueChangePercent,_that.appointmentChange,_that.workerChange,_that.productivityChange);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ScenarioImpact implements ScenarioImpact {
  const _ScenarioImpact({required this.revenueChange, required this.revenueChangePercent, required this.appointmentChange, required this.workerChange, required this.productivityChange});
  factory _ScenarioImpact.fromJson(Map<String, dynamic> json) => _$ScenarioImpactFromJson(json);

@override final  double revenueChange;
@override final  String revenueChangePercent;
@override final  int appointmentChange;
@override final  int workerChange;
@override final  double productivityChange;

/// Create a copy of ScenarioImpact
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScenarioImpactCopyWith<_ScenarioImpact> get copyWith => __$ScenarioImpactCopyWithImpl<_ScenarioImpact>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ScenarioImpactToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScenarioImpact&&(identical(other.revenueChange, revenueChange) || other.revenueChange == revenueChange)&&(identical(other.revenueChangePercent, revenueChangePercent) || other.revenueChangePercent == revenueChangePercent)&&(identical(other.appointmentChange, appointmentChange) || other.appointmentChange == appointmentChange)&&(identical(other.workerChange, workerChange) || other.workerChange == workerChange)&&(identical(other.productivityChange, productivityChange) || other.productivityChange == productivityChange));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,revenueChange,revenueChangePercent,appointmentChange,workerChange,productivityChange);

@override
String toString() {
  return 'ScenarioImpact(revenueChange: $revenueChange, revenueChangePercent: $revenueChangePercent, appointmentChange: $appointmentChange, workerChange: $workerChange, productivityChange: $productivityChange)';
}


}

/// @nodoc
abstract mixin class _$ScenarioImpactCopyWith<$Res> implements $ScenarioImpactCopyWith<$Res> {
  factory _$ScenarioImpactCopyWith(_ScenarioImpact value, $Res Function(_ScenarioImpact) _then) = __$ScenarioImpactCopyWithImpl;
@override @useResult
$Res call({
 double revenueChange, String revenueChangePercent, int appointmentChange, int workerChange, double productivityChange
});




}
/// @nodoc
class __$ScenarioImpactCopyWithImpl<$Res>
    implements _$ScenarioImpactCopyWith<$Res> {
  __$ScenarioImpactCopyWithImpl(this._self, this._then);

  final _ScenarioImpact _self;
  final $Res Function(_ScenarioImpact) _then;

/// Create a copy of ScenarioImpact
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? revenueChange = null,Object? revenueChangePercent = null,Object? appointmentChange = null,Object? workerChange = null,Object? productivityChange = null,}) {
  return _then(_ScenarioImpact(
revenueChange: null == revenueChange ? _self.revenueChange : revenueChange // ignore: cast_nullable_to_non_nullable
as double,revenueChangePercent: null == revenueChangePercent ? _self.revenueChangePercent : revenueChangePercent // ignore: cast_nullable_to_non_nullable
as String,appointmentChange: null == appointmentChange ? _self.appointmentChange : appointmentChange // ignore: cast_nullable_to_non_nullable
as int,workerChange: null == workerChange ? _self.workerChange : workerChange // ignore: cast_nullable_to_non_nullable
as int,productivityChange: null == productivityChange ? _self.productivityChange : productivityChange // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$ScenarioFeasibility {

 Map<String, double> get scores; double get overall; String get rating;
/// Create a copy of ScenarioFeasibility
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScenarioFeasibilityCopyWith<ScenarioFeasibility> get copyWith => _$ScenarioFeasibilityCopyWithImpl<ScenarioFeasibility>(this as ScenarioFeasibility, _$identity);

  /// Serializes this ScenarioFeasibility to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScenarioFeasibility&&const DeepCollectionEquality().equals(other.scores, scores)&&(identical(other.overall, overall) || other.overall == overall)&&(identical(other.rating, rating) || other.rating == rating));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(scores),overall,rating);

@override
String toString() {
  return 'ScenarioFeasibility(scores: $scores, overall: $overall, rating: $rating)';
}


}

/// @nodoc
abstract mixin class $ScenarioFeasibilityCopyWith<$Res>  {
  factory $ScenarioFeasibilityCopyWith(ScenarioFeasibility value, $Res Function(ScenarioFeasibility) _then) = _$ScenarioFeasibilityCopyWithImpl;
@useResult
$Res call({
 Map<String, double> scores, double overall, String rating
});




}
/// @nodoc
class _$ScenarioFeasibilityCopyWithImpl<$Res>
    implements $ScenarioFeasibilityCopyWith<$Res> {
  _$ScenarioFeasibilityCopyWithImpl(this._self, this._then);

  final ScenarioFeasibility _self;
  final $Res Function(ScenarioFeasibility) _then;

/// Create a copy of ScenarioFeasibility
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? scores = null,Object? overall = null,Object? rating = null,}) {
  return _then(_self.copyWith(
scores: null == scores ? _self.scores : scores // ignore: cast_nullable_to_non_nullable
as Map<String, double>,overall: null == overall ? _self.overall : overall // ignore: cast_nullable_to_non_nullable
as double,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ScenarioFeasibility].
extension ScenarioFeasibilityPatterns on ScenarioFeasibility {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScenarioFeasibility value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScenarioFeasibility() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScenarioFeasibility value)  $default,){
final _that = this;
switch (_that) {
case _ScenarioFeasibility():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScenarioFeasibility value)?  $default,){
final _that = this;
switch (_that) {
case _ScenarioFeasibility() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Map<String, double> scores,  double overall,  String rating)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScenarioFeasibility() when $default != null:
return $default(_that.scores,_that.overall,_that.rating);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Map<String, double> scores,  double overall,  String rating)  $default,) {final _that = this;
switch (_that) {
case _ScenarioFeasibility():
return $default(_that.scores,_that.overall,_that.rating);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Map<String, double> scores,  double overall,  String rating)?  $default,) {final _that = this;
switch (_that) {
case _ScenarioFeasibility() when $default != null:
return $default(_that.scores,_that.overall,_that.rating);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ScenarioFeasibility implements ScenarioFeasibility {
  const _ScenarioFeasibility({required final  Map<String, double> scores, required this.overall, required this.rating}): _scores = scores;
  factory _ScenarioFeasibility.fromJson(Map<String, dynamic> json) => _$ScenarioFeasibilityFromJson(json);

 final  Map<String, double> _scores;
@override Map<String, double> get scores {
  if (_scores is EqualUnmodifiableMapView) return _scores;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_scores);
}

@override final  double overall;
@override final  String rating;

/// Create a copy of ScenarioFeasibility
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScenarioFeasibilityCopyWith<_ScenarioFeasibility> get copyWith => __$ScenarioFeasibilityCopyWithImpl<_ScenarioFeasibility>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ScenarioFeasibilityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScenarioFeasibility&&const DeepCollectionEquality().equals(other._scores, _scores)&&(identical(other.overall, overall) || other.overall == overall)&&(identical(other.rating, rating) || other.rating == rating));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_scores),overall,rating);

@override
String toString() {
  return 'ScenarioFeasibility(scores: $scores, overall: $overall, rating: $rating)';
}


}

/// @nodoc
abstract mixin class _$ScenarioFeasibilityCopyWith<$Res> implements $ScenarioFeasibilityCopyWith<$Res> {
  factory _$ScenarioFeasibilityCopyWith(_ScenarioFeasibility value, $Res Function(_ScenarioFeasibility) _then) = __$ScenarioFeasibilityCopyWithImpl;
@override @useResult
$Res call({
 Map<String, double> scores, double overall, String rating
});




}
/// @nodoc
class __$ScenarioFeasibilityCopyWithImpl<$Res>
    implements _$ScenarioFeasibilityCopyWith<$Res> {
  __$ScenarioFeasibilityCopyWithImpl(this._self, this._then);

  final _ScenarioFeasibility _self;
  final $Res Function(_ScenarioFeasibility) _then;

/// Create a copy of ScenarioFeasibility
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? scores = null,Object? overall = null,Object? rating = null,}) {
  return _then(_ScenarioFeasibility(
scores: null == scores ? _self._scores : scores // ignore: cast_nullable_to_non_nullable
as Map<String, double>,overall: null == overall ? _self.overall : overall // ignore: cast_nullable_to_non_nullable
as double,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ScenarioRecommendation {

 String get decision; String get confidence; String get reasoning;
/// Create a copy of ScenarioRecommendation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScenarioRecommendationCopyWith<ScenarioRecommendation> get copyWith => _$ScenarioRecommendationCopyWithImpl<ScenarioRecommendation>(this as ScenarioRecommendation, _$identity);

  /// Serializes this ScenarioRecommendation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScenarioRecommendation&&(identical(other.decision, decision) || other.decision == decision)&&(identical(other.confidence, confidence) || other.confidence == confidence)&&(identical(other.reasoning, reasoning) || other.reasoning == reasoning));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,decision,confidence,reasoning);

@override
String toString() {
  return 'ScenarioRecommendation(decision: $decision, confidence: $confidence, reasoning: $reasoning)';
}


}

/// @nodoc
abstract mixin class $ScenarioRecommendationCopyWith<$Res>  {
  factory $ScenarioRecommendationCopyWith(ScenarioRecommendation value, $Res Function(ScenarioRecommendation) _then) = _$ScenarioRecommendationCopyWithImpl;
@useResult
$Res call({
 String decision, String confidence, String reasoning
});




}
/// @nodoc
class _$ScenarioRecommendationCopyWithImpl<$Res>
    implements $ScenarioRecommendationCopyWith<$Res> {
  _$ScenarioRecommendationCopyWithImpl(this._self, this._then);

  final ScenarioRecommendation _self;
  final $Res Function(ScenarioRecommendation) _then;

/// Create a copy of ScenarioRecommendation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? decision = null,Object? confidence = null,Object? reasoning = null,}) {
  return _then(_self.copyWith(
decision: null == decision ? _self.decision : decision // ignore: cast_nullable_to_non_nullable
as String,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as String,reasoning: null == reasoning ? _self.reasoning : reasoning // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ScenarioRecommendation].
extension ScenarioRecommendationPatterns on ScenarioRecommendation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScenarioRecommendation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScenarioRecommendation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScenarioRecommendation value)  $default,){
final _that = this;
switch (_that) {
case _ScenarioRecommendation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScenarioRecommendation value)?  $default,){
final _that = this;
switch (_that) {
case _ScenarioRecommendation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String decision,  String confidence,  String reasoning)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScenarioRecommendation() when $default != null:
return $default(_that.decision,_that.confidence,_that.reasoning);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String decision,  String confidence,  String reasoning)  $default,) {final _that = this;
switch (_that) {
case _ScenarioRecommendation():
return $default(_that.decision,_that.confidence,_that.reasoning);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String decision,  String confidence,  String reasoning)?  $default,) {final _that = this;
switch (_that) {
case _ScenarioRecommendation() when $default != null:
return $default(_that.decision,_that.confidence,_that.reasoning);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ScenarioRecommendation implements ScenarioRecommendation {
  const _ScenarioRecommendation({required this.decision, required this.confidence, required this.reasoning});
  factory _ScenarioRecommendation.fromJson(Map<String, dynamic> json) => _$ScenarioRecommendationFromJson(json);

@override final  String decision;
@override final  String confidence;
@override final  String reasoning;

/// Create a copy of ScenarioRecommendation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScenarioRecommendationCopyWith<_ScenarioRecommendation> get copyWith => __$ScenarioRecommendationCopyWithImpl<_ScenarioRecommendation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ScenarioRecommendationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScenarioRecommendation&&(identical(other.decision, decision) || other.decision == decision)&&(identical(other.confidence, confidence) || other.confidence == confidence)&&(identical(other.reasoning, reasoning) || other.reasoning == reasoning));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,decision,confidence,reasoning);

@override
String toString() {
  return 'ScenarioRecommendation(decision: $decision, confidence: $confidence, reasoning: $reasoning)';
}


}

/// @nodoc
abstract mixin class _$ScenarioRecommendationCopyWith<$Res> implements $ScenarioRecommendationCopyWith<$Res> {
  factory _$ScenarioRecommendationCopyWith(_ScenarioRecommendation value, $Res Function(_ScenarioRecommendation) _then) = __$ScenarioRecommendationCopyWithImpl;
@override @useResult
$Res call({
 String decision, String confidence, String reasoning
});




}
/// @nodoc
class __$ScenarioRecommendationCopyWithImpl<$Res>
    implements _$ScenarioRecommendationCopyWith<$Res> {
  __$ScenarioRecommendationCopyWithImpl(this._self, this._then);

  final _ScenarioRecommendation _self;
  final $Res Function(_ScenarioRecommendation) _then;

/// Create a copy of ScenarioRecommendation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? decision = null,Object? confidence = null,Object? reasoning = null,}) {
  return _then(_ScenarioRecommendation(
decision: null == decision ? _self.decision : decision // ignore: cast_nullable_to_non_nullable
as String,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as String,reasoning: null == reasoning ? _self.reasoning : reasoning // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$CustomerLifetimeValue {

 String get clientId; String get clientName; double get clv; String get segment; CLVMetrics get metrics; List<String> get recommendations;
/// Create a copy of CustomerLifetimeValue
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CustomerLifetimeValueCopyWith<CustomerLifetimeValue> get copyWith => _$CustomerLifetimeValueCopyWithImpl<CustomerLifetimeValue>(this as CustomerLifetimeValue, _$identity);

  /// Serializes this CustomerLifetimeValue to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CustomerLifetimeValue&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.clientName, clientName) || other.clientName == clientName)&&(identical(other.clv, clv) || other.clv == clv)&&(identical(other.segment, segment) || other.segment == segment)&&(identical(other.metrics, metrics) || other.metrics == metrics)&&const DeepCollectionEquality().equals(other.recommendations, recommendations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,clientId,clientName,clv,segment,metrics,const DeepCollectionEquality().hash(recommendations));

@override
String toString() {
  return 'CustomerLifetimeValue(clientId: $clientId, clientName: $clientName, clv: $clv, segment: $segment, metrics: $metrics, recommendations: $recommendations)';
}


}

/// @nodoc
abstract mixin class $CustomerLifetimeValueCopyWith<$Res>  {
  factory $CustomerLifetimeValueCopyWith(CustomerLifetimeValue value, $Res Function(CustomerLifetimeValue) _then) = _$CustomerLifetimeValueCopyWithImpl;
@useResult
$Res call({
 String clientId, String clientName, double clv, String segment, CLVMetrics metrics, List<String> recommendations
});


$CLVMetricsCopyWith<$Res> get metrics;

}
/// @nodoc
class _$CustomerLifetimeValueCopyWithImpl<$Res>
    implements $CustomerLifetimeValueCopyWith<$Res> {
  _$CustomerLifetimeValueCopyWithImpl(this._self, this._then);

  final CustomerLifetimeValue _self;
  final $Res Function(CustomerLifetimeValue) _then;

/// Create a copy of CustomerLifetimeValue
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? clientId = null,Object? clientName = null,Object? clv = null,Object? segment = null,Object? metrics = null,Object? recommendations = null,}) {
  return _then(_self.copyWith(
clientId: null == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String,clientName: null == clientName ? _self.clientName : clientName // ignore: cast_nullable_to_non_nullable
as String,clv: null == clv ? _self.clv : clv // ignore: cast_nullable_to_non_nullable
as double,segment: null == segment ? _self.segment : segment // ignore: cast_nullable_to_non_nullable
as String,metrics: null == metrics ? _self.metrics : metrics // ignore: cast_nullable_to_non_nullable
as CLVMetrics,recommendations: null == recommendations ? _self.recommendations : recommendations // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}
/// Create a copy of CustomerLifetimeValue
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CLVMetricsCopyWith<$Res> get metrics {
  
  return $CLVMetricsCopyWith<$Res>(_self.metrics, (value) {
    return _then(_self.copyWith(metrics: value));
  });
}
}


/// Adds pattern-matching-related methods to [CustomerLifetimeValue].
extension CustomerLifetimeValuePatterns on CustomerLifetimeValue {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CustomerLifetimeValue value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CustomerLifetimeValue() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CustomerLifetimeValue value)  $default,){
final _that = this;
switch (_that) {
case _CustomerLifetimeValue():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CustomerLifetimeValue value)?  $default,){
final _that = this;
switch (_that) {
case _CustomerLifetimeValue() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String clientId,  String clientName,  double clv,  String segment,  CLVMetrics metrics,  List<String> recommendations)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CustomerLifetimeValue() when $default != null:
return $default(_that.clientId,_that.clientName,_that.clv,_that.segment,_that.metrics,_that.recommendations);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String clientId,  String clientName,  double clv,  String segment,  CLVMetrics metrics,  List<String> recommendations)  $default,) {final _that = this;
switch (_that) {
case _CustomerLifetimeValue():
return $default(_that.clientId,_that.clientName,_that.clv,_that.segment,_that.metrics,_that.recommendations);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String clientId,  String clientName,  double clv,  String segment,  CLVMetrics metrics,  List<String> recommendations)?  $default,) {final _that = this;
switch (_that) {
case _CustomerLifetimeValue() when $default != null:
return $default(_that.clientId,_that.clientName,_that.clv,_that.segment,_that.metrics,_that.recommendations);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CustomerLifetimeValue implements CustomerLifetimeValue {
  const _CustomerLifetimeValue({required this.clientId, required this.clientName, required this.clv, required this.segment, required this.metrics, required final  List<String> recommendations}): _recommendations = recommendations;
  factory _CustomerLifetimeValue.fromJson(Map<String, dynamic> json) => _$CustomerLifetimeValueFromJson(json);

@override final  String clientId;
@override final  String clientName;
@override final  double clv;
@override final  String segment;
@override final  CLVMetrics metrics;
 final  List<String> _recommendations;
@override List<String> get recommendations {
  if (_recommendations is EqualUnmodifiableListView) return _recommendations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recommendations);
}


/// Create a copy of CustomerLifetimeValue
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CustomerLifetimeValueCopyWith<_CustomerLifetimeValue> get copyWith => __$CustomerLifetimeValueCopyWithImpl<_CustomerLifetimeValue>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CustomerLifetimeValueToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CustomerLifetimeValue&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.clientName, clientName) || other.clientName == clientName)&&(identical(other.clv, clv) || other.clv == clv)&&(identical(other.segment, segment) || other.segment == segment)&&(identical(other.metrics, metrics) || other.metrics == metrics)&&const DeepCollectionEquality().equals(other._recommendations, _recommendations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,clientId,clientName,clv,segment,metrics,const DeepCollectionEquality().hash(_recommendations));

@override
String toString() {
  return 'CustomerLifetimeValue(clientId: $clientId, clientName: $clientName, clv: $clv, segment: $segment, metrics: $metrics, recommendations: $recommendations)';
}


}

/// @nodoc
abstract mixin class _$CustomerLifetimeValueCopyWith<$Res> implements $CustomerLifetimeValueCopyWith<$Res> {
  factory _$CustomerLifetimeValueCopyWith(_CustomerLifetimeValue value, $Res Function(_CustomerLifetimeValue) _then) = __$CustomerLifetimeValueCopyWithImpl;
@override @useResult
$Res call({
 String clientId, String clientName, double clv, String segment, CLVMetrics metrics, List<String> recommendations
});


@override $CLVMetricsCopyWith<$Res> get metrics;

}
/// @nodoc
class __$CustomerLifetimeValueCopyWithImpl<$Res>
    implements _$CustomerLifetimeValueCopyWith<$Res> {
  __$CustomerLifetimeValueCopyWithImpl(this._self, this._then);

  final _CustomerLifetimeValue _self;
  final $Res Function(_CustomerLifetimeValue) _then;

/// Create a copy of CustomerLifetimeValue
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? clientId = null,Object? clientName = null,Object? clv = null,Object? segment = null,Object? metrics = null,Object? recommendations = null,}) {
  return _then(_CustomerLifetimeValue(
clientId: null == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String,clientName: null == clientName ? _self.clientName : clientName // ignore: cast_nullable_to_non_nullable
as String,clv: null == clv ? _self.clv : clv // ignore: cast_nullable_to_non_nullable
as double,segment: null == segment ? _self.segment : segment // ignore: cast_nullable_to_non_nullable
as String,metrics: null == metrics ? _self.metrics : metrics // ignore: cast_nullable_to_non_nullable
as CLVMetrics,recommendations: null == recommendations ? _self._recommendations : recommendations // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

/// Create a copy of CustomerLifetimeValue
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CLVMetricsCopyWith<$Res> get metrics {
  
  return $CLVMetricsCopyWith<$Res>(_self.metrics, (value) {
    return _then(_self.copyWith(metrics: value));
  });
}
}


/// @nodoc
mixin _$CLVMetrics {

 double get totalRevenue; int get appointmentCount; double get avgOrderValue; double get frequency; double get tenure; double get churnProbability;
/// Create a copy of CLVMetrics
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CLVMetricsCopyWith<CLVMetrics> get copyWith => _$CLVMetricsCopyWithImpl<CLVMetrics>(this as CLVMetrics, _$identity);

  /// Serializes this CLVMetrics to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CLVMetrics&&(identical(other.totalRevenue, totalRevenue) || other.totalRevenue == totalRevenue)&&(identical(other.appointmentCount, appointmentCount) || other.appointmentCount == appointmentCount)&&(identical(other.avgOrderValue, avgOrderValue) || other.avgOrderValue == avgOrderValue)&&(identical(other.frequency, frequency) || other.frequency == frequency)&&(identical(other.tenure, tenure) || other.tenure == tenure)&&(identical(other.churnProbability, churnProbability) || other.churnProbability == churnProbability));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalRevenue,appointmentCount,avgOrderValue,frequency,tenure,churnProbability);

@override
String toString() {
  return 'CLVMetrics(totalRevenue: $totalRevenue, appointmentCount: $appointmentCount, avgOrderValue: $avgOrderValue, frequency: $frequency, tenure: $tenure, churnProbability: $churnProbability)';
}


}

/// @nodoc
abstract mixin class $CLVMetricsCopyWith<$Res>  {
  factory $CLVMetricsCopyWith(CLVMetrics value, $Res Function(CLVMetrics) _then) = _$CLVMetricsCopyWithImpl;
@useResult
$Res call({
 double totalRevenue, int appointmentCount, double avgOrderValue, double frequency, double tenure, double churnProbability
});




}
/// @nodoc
class _$CLVMetricsCopyWithImpl<$Res>
    implements $CLVMetricsCopyWith<$Res> {
  _$CLVMetricsCopyWithImpl(this._self, this._then);

  final CLVMetrics _self;
  final $Res Function(CLVMetrics) _then;

/// Create a copy of CLVMetrics
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalRevenue = null,Object? appointmentCount = null,Object? avgOrderValue = null,Object? frequency = null,Object? tenure = null,Object? churnProbability = null,}) {
  return _then(_self.copyWith(
totalRevenue: null == totalRevenue ? _self.totalRevenue : totalRevenue // ignore: cast_nullable_to_non_nullable
as double,appointmentCount: null == appointmentCount ? _self.appointmentCount : appointmentCount // ignore: cast_nullable_to_non_nullable
as int,avgOrderValue: null == avgOrderValue ? _self.avgOrderValue : avgOrderValue // ignore: cast_nullable_to_non_nullable
as double,frequency: null == frequency ? _self.frequency : frequency // ignore: cast_nullable_to_non_nullable
as double,tenure: null == tenure ? _self.tenure : tenure // ignore: cast_nullable_to_non_nullable
as double,churnProbability: null == churnProbability ? _self.churnProbability : churnProbability // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [CLVMetrics].
extension CLVMetricsPatterns on CLVMetrics {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CLVMetrics value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CLVMetrics() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CLVMetrics value)  $default,){
final _that = this;
switch (_that) {
case _CLVMetrics():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CLVMetrics value)?  $default,){
final _that = this;
switch (_that) {
case _CLVMetrics() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double totalRevenue,  int appointmentCount,  double avgOrderValue,  double frequency,  double tenure,  double churnProbability)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CLVMetrics() when $default != null:
return $default(_that.totalRevenue,_that.appointmentCount,_that.avgOrderValue,_that.frequency,_that.tenure,_that.churnProbability);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double totalRevenue,  int appointmentCount,  double avgOrderValue,  double frequency,  double tenure,  double churnProbability)  $default,) {final _that = this;
switch (_that) {
case _CLVMetrics():
return $default(_that.totalRevenue,_that.appointmentCount,_that.avgOrderValue,_that.frequency,_that.tenure,_that.churnProbability);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double totalRevenue,  int appointmentCount,  double avgOrderValue,  double frequency,  double tenure,  double churnProbability)?  $default,) {final _that = this;
switch (_that) {
case _CLVMetrics() when $default != null:
return $default(_that.totalRevenue,_that.appointmentCount,_that.avgOrderValue,_that.frequency,_that.tenure,_that.churnProbability);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CLVMetrics implements CLVMetrics {
  const _CLVMetrics({required this.totalRevenue, required this.appointmentCount, required this.avgOrderValue, required this.frequency, required this.tenure, required this.churnProbability});
  factory _CLVMetrics.fromJson(Map<String, dynamic> json) => _$CLVMetricsFromJson(json);

@override final  double totalRevenue;
@override final  int appointmentCount;
@override final  double avgOrderValue;
@override final  double frequency;
@override final  double tenure;
@override final  double churnProbability;

/// Create a copy of CLVMetrics
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CLVMetricsCopyWith<_CLVMetrics> get copyWith => __$CLVMetricsCopyWithImpl<_CLVMetrics>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CLVMetricsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CLVMetrics&&(identical(other.totalRevenue, totalRevenue) || other.totalRevenue == totalRevenue)&&(identical(other.appointmentCount, appointmentCount) || other.appointmentCount == appointmentCount)&&(identical(other.avgOrderValue, avgOrderValue) || other.avgOrderValue == avgOrderValue)&&(identical(other.frequency, frequency) || other.frequency == frequency)&&(identical(other.tenure, tenure) || other.tenure == tenure)&&(identical(other.churnProbability, churnProbability) || other.churnProbability == churnProbability));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalRevenue,appointmentCount,avgOrderValue,frequency,tenure,churnProbability);

@override
String toString() {
  return 'CLVMetrics(totalRevenue: $totalRevenue, appointmentCount: $appointmentCount, avgOrderValue: $avgOrderValue, frequency: $frequency, tenure: $tenure, churnProbability: $churnProbability)';
}


}

/// @nodoc
abstract mixin class _$CLVMetricsCopyWith<$Res> implements $CLVMetricsCopyWith<$Res> {
  factory _$CLVMetricsCopyWith(_CLVMetrics value, $Res Function(_CLVMetrics) _then) = __$CLVMetricsCopyWithImpl;
@override @useResult
$Res call({
 double totalRevenue, int appointmentCount, double avgOrderValue, double frequency, double tenure, double churnProbability
});




}
/// @nodoc
class __$CLVMetricsCopyWithImpl<$Res>
    implements _$CLVMetricsCopyWith<$Res> {
  __$CLVMetricsCopyWithImpl(this._self, this._then);

  final _CLVMetrics _self;
  final $Res Function(_CLVMetrics) _then;

/// Create a copy of CLVMetrics
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalRevenue = null,Object? appointmentCount = null,Object? avgOrderValue = null,Object? frequency = null,Object? tenure = null,Object? churnProbability = null,}) {
  return _then(_CLVMetrics(
totalRevenue: null == totalRevenue ? _self.totalRevenue : totalRevenue // ignore: cast_nullable_to_non_nullable
as double,appointmentCount: null == appointmentCount ? _self.appointmentCount : appointmentCount // ignore: cast_nullable_to_non_nullable
as int,avgOrderValue: null == avgOrderValue ? _self.avgOrderValue : avgOrderValue // ignore: cast_nullable_to_non_nullable
as double,frequency: null == frequency ? _self.frequency : frequency // ignore: cast_nullable_to_non_nullable
as double,tenure: null == tenure ? _self.tenure : tenure // ignore: cast_nullable_to_non_nullable
as double,churnProbability: null == churnProbability ? _self.churnProbability : churnProbability // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$MLModel {

 String get id; String get name; String get type; String get version; String get status; DateTime get trainedAt; MLMetrics get metrics; List<String> get features; Map<String, dynamic> get hyperparameters;
/// Create a copy of MLModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MLModelCopyWith<MLModel> get copyWith => _$MLModelCopyWithImpl<MLModel>(this as MLModel, _$identity);

  /// Serializes this MLModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MLModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.version, version) || other.version == version)&&(identical(other.status, status) || other.status == status)&&(identical(other.trainedAt, trainedAt) || other.trainedAt == trainedAt)&&(identical(other.metrics, metrics) || other.metrics == metrics)&&const DeepCollectionEquality().equals(other.features, features)&&const DeepCollectionEquality().equals(other.hyperparameters, hyperparameters));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,type,version,status,trainedAt,metrics,const DeepCollectionEquality().hash(features),const DeepCollectionEquality().hash(hyperparameters));

@override
String toString() {
  return 'MLModel(id: $id, name: $name, type: $type, version: $version, status: $status, trainedAt: $trainedAt, metrics: $metrics, features: $features, hyperparameters: $hyperparameters)';
}


}

/// @nodoc
abstract mixin class $MLModelCopyWith<$Res>  {
  factory $MLModelCopyWith(MLModel value, $Res Function(MLModel) _then) = _$MLModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, String type, String version, String status, DateTime trainedAt, MLMetrics metrics, List<String> features, Map<String, dynamic> hyperparameters
});


$MLMetricsCopyWith<$Res> get metrics;

}
/// @nodoc
class _$MLModelCopyWithImpl<$Res>
    implements $MLModelCopyWith<$Res> {
  _$MLModelCopyWithImpl(this._self, this._then);

  final MLModel _self;
  final $Res Function(MLModel) _then;

/// Create a copy of MLModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? type = null,Object? version = null,Object? status = null,Object? trainedAt = null,Object? metrics = null,Object? features = null,Object? hyperparameters = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,trainedAt: null == trainedAt ? _self.trainedAt : trainedAt // ignore: cast_nullable_to_non_nullable
as DateTime,metrics: null == metrics ? _self.metrics : metrics // ignore: cast_nullable_to_non_nullable
as MLMetrics,features: null == features ? _self.features : features // ignore: cast_nullable_to_non_nullable
as List<String>,hyperparameters: null == hyperparameters ? _self.hyperparameters : hyperparameters // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}
/// Create a copy of MLModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MLMetricsCopyWith<$Res> get metrics {
  
  return $MLMetricsCopyWith<$Res>(_self.metrics, (value) {
    return _then(_self.copyWith(metrics: value));
  });
}
}


/// Adds pattern-matching-related methods to [MLModel].
extension MLModelPatterns on MLModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MLModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MLModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MLModel value)  $default,){
final _that = this;
switch (_that) {
case _MLModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MLModel value)?  $default,){
final _that = this;
switch (_that) {
case _MLModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String type,  String version,  String status,  DateTime trainedAt,  MLMetrics metrics,  List<String> features,  Map<String, dynamic> hyperparameters)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MLModel() when $default != null:
return $default(_that.id,_that.name,_that.type,_that.version,_that.status,_that.trainedAt,_that.metrics,_that.features,_that.hyperparameters);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String type,  String version,  String status,  DateTime trainedAt,  MLMetrics metrics,  List<String> features,  Map<String, dynamic> hyperparameters)  $default,) {final _that = this;
switch (_that) {
case _MLModel():
return $default(_that.id,_that.name,_that.type,_that.version,_that.status,_that.trainedAt,_that.metrics,_that.features,_that.hyperparameters);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String type,  String version,  String status,  DateTime trainedAt,  MLMetrics metrics,  List<String> features,  Map<String, dynamic> hyperparameters)?  $default,) {final _that = this;
switch (_that) {
case _MLModel() when $default != null:
return $default(_that.id,_that.name,_that.type,_that.version,_that.status,_that.trainedAt,_that.metrics,_that.features,_that.hyperparameters);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MLModel implements MLModel {
  const _MLModel({required this.id, required this.name, required this.type, required this.version, required this.status, required this.trainedAt, required this.metrics, required final  List<String> features, required final  Map<String, dynamic> hyperparameters}): _features = features,_hyperparameters = hyperparameters;
  factory _MLModel.fromJson(Map<String, dynamic> json) => _$MLModelFromJson(json);

@override final  String id;
@override final  String name;
@override final  String type;
@override final  String version;
@override final  String status;
@override final  DateTime trainedAt;
@override final  MLMetrics metrics;
 final  List<String> _features;
@override List<String> get features {
  if (_features is EqualUnmodifiableListView) return _features;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_features);
}

 final  Map<String, dynamic> _hyperparameters;
@override Map<String, dynamic> get hyperparameters {
  if (_hyperparameters is EqualUnmodifiableMapView) return _hyperparameters;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_hyperparameters);
}


/// Create a copy of MLModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MLModelCopyWith<_MLModel> get copyWith => __$MLModelCopyWithImpl<_MLModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MLModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MLModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.version, version) || other.version == version)&&(identical(other.status, status) || other.status == status)&&(identical(other.trainedAt, trainedAt) || other.trainedAt == trainedAt)&&(identical(other.metrics, metrics) || other.metrics == metrics)&&const DeepCollectionEquality().equals(other._features, _features)&&const DeepCollectionEquality().equals(other._hyperparameters, _hyperparameters));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,type,version,status,trainedAt,metrics,const DeepCollectionEquality().hash(_features),const DeepCollectionEquality().hash(_hyperparameters));

@override
String toString() {
  return 'MLModel(id: $id, name: $name, type: $type, version: $version, status: $status, trainedAt: $trainedAt, metrics: $metrics, features: $features, hyperparameters: $hyperparameters)';
}


}

/// @nodoc
abstract mixin class _$MLModelCopyWith<$Res> implements $MLModelCopyWith<$Res> {
  factory _$MLModelCopyWith(_MLModel value, $Res Function(_MLModel) _then) = __$MLModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String type, String version, String status, DateTime trainedAt, MLMetrics metrics, List<String> features, Map<String, dynamic> hyperparameters
});


@override $MLMetricsCopyWith<$Res> get metrics;

}
/// @nodoc
class __$MLModelCopyWithImpl<$Res>
    implements _$MLModelCopyWith<$Res> {
  __$MLModelCopyWithImpl(this._self, this._then);

  final _MLModel _self;
  final $Res Function(_MLModel) _then;

/// Create a copy of MLModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? type = null,Object? version = null,Object? status = null,Object? trainedAt = null,Object? metrics = null,Object? features = null,Object? hyperparameters = null,}) {
  return _then(_MLModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,trainedAt: null == trainedAt ? _self.trainedAt : trainedAt // ignore: cast_nullable_to_non_nullable
as DateTime,metrics: null == metrics ? _self.metrics : metrics // ignore: cast_nullable_to_non_nullable
as MLMetrics,features: null == features ? _self._features : features // ignore: cast_nullable_to_non_nullable
as List<String>,hyperparameters: null == hyperparameters ? _self._hyperparameters : hyperparameters // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

/// Create a copy of MLModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MLMetricsCopyWith<$Res> get metrics {
  
  return $MLMetricsCopyWith<$Res>(_self.metrics, (value) {
    return _then(_self.copyWith(metrics: value));
  });
}
}


/// @nodoc
mixin _$MLMetrics {

 double get accuracy; double get precision; double get recall; double get f1Score;
/// Create a copy of MLMetrics
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MLMetricsCopyWith<MLMetrics> get copyWith => _$MLMetricsCopyWithImpl<MLMetrics>(this as MLMetrics, _$identity);

  /// Serializes this MLMetrics to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MLMetrics&&(identical(other.accuracy, accuracy) || other.accuracy == accuracy)&&(identical(other.precision, precision) || other.precision == precision)&&(identical(other.recall, recall) || other.recall == recall)&&(identical(other.f1Score, f1Score) || other.f1Score == f1Score));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,accuracy,precision,recall,f1Score);

@override
String toString() {
  return 'MLMetrics(accuracy: $accuracy, precision: $precision, recall: $recall, f1Score: $f1Score)';
}


}

/// @nodoc
abstract mixin class $MLMetricsCopyWith<$Res>  {
  factory $MLMetricsCopyWith(MLMetrics value, $Res Function(MLMetrics) _then) = _$MLMetricsCopyWithImpl;
@useResult
$Res call({
 double accuracy, double precision, double recall, double f1Score
});




}
/// @nodoc
class _$MLMetricsCopyWithImpl<$Res>
    implements $MLMetricsCopyWith<$Res> {
  _$MLMetricsCopyWithImpl(this._self, this._then);

  final MLMetrics _self;
  final $Res Function(MLMetrics) _then;

/// Create a copy of MLMetrics
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? accuracy = null,Object? precision = null,Object? recall = null,Object? f1Score = null,}) {
  return _then(_self.copyWith(
accuracy: null == accuracy ? _self.accuracy : accuracy // ignore: cast_nullable_to_non_nullable
as double,precision: null == precision ? _self.precision : precision // ignore: cast_nullable_to_non_nullable
as double,recall: null == recall ? _self.recall : recall // ignore: cast_nullable_to_non_nullable
as double,f1Score: null == f1Score ? _self.f1Score : f1Score // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [MLMetrics].
extension MLMetricsPatterns on MLMetrics {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MLMetrics value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MLMetrics() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MLMetrics value)  $default,){
final _that = this;
switch (_that) {
case _MLMetrics():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MLMetrics value)?  $default,){
final _that = this;
switch (_that) {
case _MLMetrics() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double accuracy,  double precision,  double recall,  double f1Score)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MLMetrics() when $default != null:
return $default(_that.accuracy,_that.precision,_that.recall,_that.f1Score);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double accuracy,  double precision,  double recall,  double f1Score)  $default,) {final _that = this;
switch (_that) {
case _MLMetrics():
return $default(_that.accuracy,_that.precision,_that.recall,_that.f1Score);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double accuracy,  double precision,  double recall,  double f1Score)?  $default,) {final _that = this;
switch (_that) {
case _MLMetrics() when $default != null:
return $default(_that.accuracy,_that.precision,_that.recall,_that.f1Score);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MLMetrics implements MLMetrics {
  const _MLMetrics({required this.accuracy, required this.precision, required this.recall, required this.f1Score});
  factory _MLMetrics.fromJson(Map<String, dynamic> json) => _$MLMetricsFromJson(json);

@override final  double accuracy;
@override final  double precision;
@override final  double recall;
@override final  double f1Score;

/// Create a copy of MLMetrics
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MLMetricsCopyWith<_MLMetrics> get copyWith => __$MLMetricsCopyWithImpl<_MLMetrics>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MLMetricsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MLMetrics&&(identical(other.accuracy, accuracy) || other.accuracy == accuracy)&&(identical(other.precision, precision) || other.precision == precision)&&(identical(other.recall, recall) || other.recall == recall)&&(identical(other.f1Score, f1Score) || other.f1Score == f1Score));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,accuracy,precision,recall,f1Score);

@override
String toString() {
  return 'MLMetrics(accuracy: $accuracy, precision: $precision, recall: $recall, f1Score: $f1Score)';
}


}

/// @nodoc
abstract mixin class _$MLMetricsCopyWith<$Res> implements $MLMetricsCopyWith<$Res> {
  factory _$MLMetricsCopyWith(_MLMetrics value, $Res Function(_MLMetrics) _then) = __$MLMetricsCopyWithImpl;
@override @useResult
$Res call({
 double accuracy, double precision, double recall, double f1Score
});




}
/// @nodoc
class __$MLMetricsCopyWithImpl<$Res>
    implements _$MLMetricsCopyWith<$Res> {
  __$MLMetricsCopyWithImpl(this._self, this._then);

  final _MLMetrics _self;
  final $Res Function(_MLMetrics) _then;

/// Create a copy of MLMetrics
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? accuracy = null,Object? precision = null,Object? recall = null,Object? f1Score = null,}) {
  return _then(_MLMetrics(
accuracy: null == accuracy ? _self.accuracy : accuracy // ignore: cast_nullable_to_non_nullable
as double,precision: null == precision ? _self.precision : precision // ignore: cast_nullable_to_non_nullable
as double,recall: null == recall ? _self.recall : recall // ignore: cast_nullable_to_non_nullable
as double,f1Score: null == f1Score ? _self.f1Score : f1Score // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$MLPrediction {

 String get modelId; PredictionResult get prediction; double get confidence; Map<String, dynamic> get features; DateTime get timestamp;
/// Create a copy of MLPrediction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MLPredictionCopyWith<MLPrediction> get copyWith => _$MLPredictionCopyWithImpl<MLPrediction>(this as MLPrediction, _$identity);

  /// Serializes this MLPrediction to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MLPrediction&&(identical(other.modelId, modelId) || other.modelId == modelId)&&(identical(other.prediction, prediction) || other.prediction == prediction)&&(identical(other.confidence, confidence) || other.confidence == confidence)&&const DeepCollectionEquality().equals(other.features, features)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,modelId,prediction,confidence,const DeepCollectionEquality().hash(features),timestamp);

@override
String toString() {
  return 'MLPrediction(modelId: $modelId, prediction: $prediction, confidence: $confidence, features: $features, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class $MLPredictionCopyWith<$Res>  {
  factory $MLPredictionCopyWith(MLPrediction value, $Res Function(MLPrediction) _then) = _$MLPredictionCopyWithImpl;
@useResult
$Res call({
 String modelId, PredictionResult prediction, double confidence, Map<String, dynamic> features, DateTime timestamp
});


$PredictionResultCopyWith<$Res> get prediction;

}
/// @nodoc
class _$MLPredictionCopyWithImpl<$Res>
    implements $MLPredictionCopyWith<$Res> {
  _$MLPredictionCopyWithImpl(this._self, this._then);

  final MLPrediction _self;
  final $Res Function(MLPrediction) _then;

/// Create a copy of MLPrediction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? modelId = null,Object? prediction = null,Object? confidence = null,Object? features = null,Object? timestamp = null,}) {
  return _then(_self.copyWith(
modelId: null == modelId ? _self.modelId : modelId // ignore: cast_nullable_to_non_nullable
as String,prediction: null == prediction ? _self.prediction : prediction // ignore: cast_nullable_to_non_nullable
as PredictionResult,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as double,features: null == features ? _self.features : features // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}
/// Create a copy of MLPrediction
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PredictionResultCopyWith<$Res> get prediction {
  
  return $PredictionResultCopyWith<$Res>(_self.prediction, (value) {
    return _then(_self.copyWith(prediction: value));
  });
}
}


/// Adds pattern-matching-related methods to [MLPrediction].
extension MLPredictionPatterns on MLPrediction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MLPrediction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MLPrediction() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MLPrediction value)  $default,){
final _that = this;
switch (_that) {
case _MLPrediction():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MLPrediction value)?  $default,){
final _that = this;
switch (_that) {
case _MLPrediction() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String modelId,  PredictionResult prediction,  double confidence,  Map<String, dynamic> features,  DateTime timestamp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MLPrediction() when $default != null:
return $default(_that.modelId,_that.prediction,_that.confidence,_that.features,_that.timestamp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String modelId,  PredictionResult prediction,  double confidence,  Map<String, dynamic> features,  DateTime timestamp)  $default,) {final _that = this;
switch (_that) {
case _MLPrediction():
return $default(_that.modelId,_that.prediction,_that.confidence,_that.features,_that.timestamp);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String modelId,  PredictionResult prediction,  double confidence,  Map<String, dynamic> features,  DateTime timestamp)?  $default,) {final _that = this;
switch (_that) {
case _MLPrediction() when $default != null:
return $default(_that.modelId,_that.prediction,_that.confidence,_that.features,_that.timestamp);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MLPrediction implements MLPrediction {
  const _MLPrediction({required this.modelId, required this.prediction, required this.confidence, required final  Map<String, dynamic> features, required this.timestamp}): _features = features;
  factory _MLPrediction.fromJson(Map<String, dynamic> json) => _$MLPredictionFromJson(json);

@override final  String modelId;
@override final  PredictionResult prediction;
@override final  double confidence;
 final  Map<String, dynamic> _features;
@override Map<String, dynamic> get features {
  if (_features is EqualUnmodifiableMapView) return _features;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_features);
}

@override final  DateTime timestamp;

/// Create a copy of MLPrediction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MLPredictionCopyWith<_MLPrediction> get copyWith => __$MLPredictionCopyWithImpl<_MLPrediction>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MLPredictionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MLPrediction&&(identical(other.modelId, modelId) || other.modelId == modelId)&&(identical(other.prediction, prediction) || other.prediction == prediction)&&(identical(other.confidence, confidence) || other.confidence == confidence)&&const DeepCollectionEquality().equals(other._features, _features)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,modelId,prediction,confidence,const DeepCollectionEquality().hash(_features),timestamp);

@override
String toString() {
  return 'MLPrediction(modelId: $modelId, prediction: $prediction, confidence: $confidence, features: $features, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class _$MLPredictionCopyWith<$Res> implements $MLPredictionCopyWith<$Res> {
  factory _$MLPredictionCopyWith(_MLPrediction value, $Res Function(_MLPrediction) _then) = __$MLPredictionCopyWithImpl;
@override @useResult
$Res call({
 String modelId, PredictionResult prediction, double confidence, Map<String, dynamic> features, DateTime timestamp
});


@override $PredictionResultCopyWith<$Res> get prediction;

}
/// @nodoc
class __$MLPredictionCopyWithImpl<$Res>
    implements _$MLPredictionCopyWith<$Res> {
  __$MLPredictionCopyWithImpl(this._self, this._then);

  final _MLPrediction _self;
  final $Res Function(_MLPrediction) _then;

/// Create a copy of MLPrediction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? modelId = null,Object? prediction = null,Object? confidence = null,Object? features = null,Object? timestamp = null,}) {
  return _then(_MLPrediction(
modelId: null == modelId ? _self.modelId : modelId // ignore: cast_nullable_to_non_nullable
as String,prediction: null == prediction ? _self.prediction : prediction // ignore: cast_nullable_to_non_nullable
as PredictionResult,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as double,features: null == features ? _self._features : features // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

/// Create a copy of MLPrediction
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PredictionResultCopyWith<$Res> get prediction {
  
  return $PredictionResultCopyWith<$Res>(_self.prediction, (value) {
    return _then(_self.copyWith(prediction: value));
  });
}
}


/// @nodoc
mixin _$PredictionResult {

 String get predictedClass; double get score; Map<String, double> get probabilities;
/// Create a copy of PredictionResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PredictionResultCopyWith<PredictionResult> get copyWith => _$PredictionResultCopyWithImpl<PredictionResult>(this as PredictionResult, _$identity);

  /// Serializes this PredictionResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PredictionResult&&(identical(other.predictedClass, predictedClass) || other.predictedClass == predictedClass)&&(identical(other.score, score) || other.score == score)&&const DeepCollectionEquality().equals(other.probabilities, probabilities));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,predictedClass,score,const DeepCollectionEquality().hash(probabilities));

@override
String toString() {
  return 'PredictionResult(predictedClass: $predictedClass, score: $score, probabilities: $probabilities)';
}


}

/// @nodoc
abstract mixin class $PredictionResultCopyWith<$Res>  {
  factory $PredictionResultCopyWith(PredictionResult value, $Res Function(PredictionResult) _then) = _$PredictionResultCopyWithImpl;
@useResult
$Res call({
 String predictedClass, double score, Map<String, double> probabilities
});




}
/// @nodoc
class _$PredictionResultCopyWithImpl<$Res>
    implements $PredictionResultCopyWith<$Res> {
  _$PredictionResultCopyWithImpl(this._self, this._then);

  final PredictionResult _self;
  final $Res Function(PredictionResult) _then;

/// Create a copy of PredictionResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? predictedClass = null,Object? score = null,Object? probabilities = null,}) {
  return _then(_self.copyWith(
predictedClass: null == predictedClass ? _self.predictedClass : predictedClass // ignore: cast_nullable_to_non_nullable
as String,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as double,probabilities: null == probabilities ? _self.probabilities : probabilities // ignore: cast_nullable_to_non_nullable
as Map<String, double>,
  ));
}

}


/// Adds pattern-matching-related methods to [PredictionResult].
extension PredictionResultPatterns on PredictionResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PredictionResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PredictionResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PredictionResult value)  $default,){
final _that = this;
switch (_that) {
case _PredictionResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PredictionResult value)?  $default,){
final _that = this;
switch (_that) {
case _PredictionResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String predictedClass,  double score,  Map<String, double> probabilities)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PredictionResult() when $default != null:
return $default(_that.predictedClass,_that.score,_that.probabilities);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String predictedClass,  double score,  Map<String, double> probabilities)  $default,) {final _that = this;
switch (_that) {
case _PredictionResult():
return $default(_that.predictedClass,_that.score,_that.probabilities);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String predictedClass,  double score,  Map<String, double> probabilities)?  $default,) {final _that = this;
switch (_that) {
case _PredictionResult() when $default != null:
return $default(_that.predictedClass,_that.score,_that.probabilities);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PredictionResult implements PredictionResult {
  const _PredictionResult({required this.predictedClass, required this.score, required final  Map<String, double> probabilities}): _probabilities = probabilities;
  factory _PredictionResult.fromJson(Map<String, dynamic> json) => _$PredictionResultFromJson(json);

@override final  String predictedClass;
@override final  double score;
 final  Map<String, double> _probabilities;
@override Map<String, double> get probabilities {
  if (_probabilities is EqualUnmodifiableMapView) return _probabilities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_probabilities);
}


/// Create a copy of PredictionResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PredictionResultCopyWith<_PredictionResult> get copyWith => __$PredictionResultCopyWithImpl<_PredictionResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PredictionResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PredictionResult&&(identical(other.predictedClass, predictedClass) || other.predictedClass == predictedClass)&&(identical(other.score, score) || other.score == score)&&const DeepCollectionEquality().equals(other._probabilities, _probabilities));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,predictedClass,score,const DeepCollectionEquality().hash(_probabilities));

@override
String toString() {
  return 'PredictionResult(predictedClass: $predictedClass, score: $score, probabilities: $probabilities)';
}


}

/// @nodoc
abstract mixin class _$PredictionResultCopyWith<$Res> implements $PredictionResultCopyWith<$Res> {
  factory _$PredictionResultCopyWith(_PredictionResult value, $Res Function(_PredictionResult) _then) = __$PredictionResultCopyWithImpl;
@override @useResult
$Res call({
 String predictedClass, double score, Map<String, double> probabilities
});




}
/// @nodoc
class __$PredictionResultCopyWithImpl<$Res>
    implements _$PredictionResultCopyWith<$Res> {
  __$PredictionResultCopyWithImpl(this._self, this._then);

  final _PredictionResult _self;
  final $Res Function(_PredictionResult) _then;

/// Create a copy of PredictionResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? predictedClass = null,Object? score = null,Object? probabilities = null,}) {
  return _then(_PredictionResult(
predictedClass: null == predictedClass ? _self.predictedClass : predictedClass // ignore: cast_nullable_to_non_nullable
as String,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as double,probabilities: null == probabilities ? _self._probabilities : probabilities // ignore: cast_nullable_to_non_nullable
as Map<String, double>,
  ));
}


}

// dart format on
