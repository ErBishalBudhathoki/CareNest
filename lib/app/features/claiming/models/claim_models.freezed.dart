// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'claim_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ClaimPeriod {

 String? get from; String? get to;
/// Create a copy of ClaimPeriod
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClaimPeriodCopyWith<ClaimPeriod> get copyWith => _$ClaimPeriodCopyWithImpl<ClaimPeriod>(this as ClaimPeriod, _$identity);

  /// Serializes this ClaimPeriod to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClaimPeriod&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,from,to);

@override
String toString() {
  return 'ClaimPeriod(from: $from, to: $to)';
}


}

/// @nodoc
abstract mixin class $ClaimPeriodCopyWith<$Res>  {
  factory $ClaimPeriodCopyWith(ClaimPeriod value, $Res Function(ClaimPeriod) _then) = _$ClaimPeriodCopyWithImpl;
@useResult
$Res call({
 String? from, String? to
});




}
/// @nodoc
class _$ClaimPeriodCopyWithImpl<$Res>
    implements $ClaimPeriodCopyWith<$Res> {
  _$ClaimPeriodCopyWithImpl(this._self, this._then);

  final ClaimPeriod _self;
  final $Res Function(ClaimPeriod) _then;

/// Create a copy of ClaimPeriod
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? from = freezed,Object? to = freezed,}) {
  return _then(_self.copyWith(
from: freezed == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as String?,to: freezed == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ClaimPeriod].
extension ClaimPeriodPatterns on ClaimPeriod {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClaimPeriod value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClaimPeriod() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClaimPeriod value)  $default,){
final _that = this;
switch (_that) {
case _ClaimPeriod():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClaimPeriod value)?  $default,){
final _that = this;
switch (_that) {
case _ClaimPeriod() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? from,  String? to)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClaimPeriod() when $default != null:
return $default(_that.from,_that.to);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? from,  String? to)  $default,) {final _that = this;
switch (_that) {
case _ClaimPeriod():
return $default(_that.from,_that.to);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? from,  String? to)?  $default,) {final _that = this;
switch (_that) {
case _ClaimPeriod() when $default != null:
return $default(_that.from,_that.to);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ClaimPeriod implements ClaimPeriod {
  const _ClaimPeriod({this.from, this.to});
  factory _ClaimPeriod.fromJson(Map<String, dynamic> json) => _$ClaimPeriodFromJson(json);

@override final  String? from;
@override final  String? to;

/// Create a copy of ClaimPeriod
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClaimPeriodCopyWith<_ClaimPeriod> get copyWith => __$ClaimPeriodCopyWithImpl<_ClaimPeriod>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClaimPeriodToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClaimPeriod&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,from,to);

@override
String toString() {
  return 'ClaimPeriod(from: $from, to: $to)';
}


}

/// @nodoc
abstract mixin class _$ClaimPeriodCopyWith<$Res> implements $ClaimPeriodCopyWith<$Res> {
  factory _$ClaimPeriodCopyWith(_ClaimPeriod value, $Res Function(_ClaimPeriod) _then) = __$ClaimPeriodCopyWithImpl;
@override @useResult
$Res call({
 String? from, String? to
});




}
/// @nodoc
class __$ClaimPeriodCopyWithImpl<$Res>
    implements _$ClaimPeriodCopyWith<$Res> {
  __$ClaimPeriodCopyWithImpl(this._self, this._then);

  final _ClaimPeriod _self;
  final $Res Function(_ClaimPeriod) _then;

/// Create a copy of ClaimPeriod
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? from = freezed,Object? to = freezed,}) {
  return _then(_ClaimPeriod(
from: freezed == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as String?,to: freezed == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ClaimTotals {

 int get lines; double get amount;
/// Create a copy of ClaimTotals
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClaimTotalsCopyWith<ClaimTotals> get copyWith => _$ClaimTotalsCopyWithImpl<ClaimTotals>(this as ClaimTotals, _$identity);

  /// Serializes this ClaimTotals to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClaimTotals&&(identical(other.lines, lines) || other.lines == lines)&&(identical(other.amount, amount) || other.amount == amount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,lines,amount);

@override
String toString() {
  return 'ClaimTotals(lines: $lines, amount: $amount)';
}


}

/// @nodoc
abstract mixin class $ClaimTotalsCopyWith<$Res>  {
  factory $ClaimTotalsCopyWith(ClaimTotals value, $Res Function(ClaimTotals) _then) = _$ClaimTotalsCopyWithImpl;
@useResult
$Res call({
 int lines, double amount
});




}
/// @nodoc
class _$ClaimTotalsCopyWithImpl<$Res>
    implements $ClaimTotalsCopyWith<$Res> {
  _$ClaimTotalsCopyWithImpl(this._self, this._then);

  final ClaimTotals _self;
  final $Res Function(ClaimTotals) _then;

/// Create a copy of ClaimTotals
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? lines = null,Object? amount = null,}) {
  return _then(_self.copyWith(
lines: null == lines ? _self.lines : lines // ignore: cast_nullable_to_non_nullable
as int,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [ClaimTotals].
extension ClaimTotalsPatterns on ClaimTotals {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClaimTotals value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClaimTotals() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClaimTotals value)  $default,){
final _that = this;
switch (_that) {
case _ClaimTotals():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClaimTotals value)?  $default,){
final _that = this;
switch (_that) {
case _ClaimTotals() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int lines,  double amount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClaimTotals() when $default != null:
return $default(_that.lines,_that.amount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int lines,  double amount)  $default,) {final _that = this;
switch (_that) {
case _ClaimTotals():
return $default(_that.lines,_that.amount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int lines,  double amount)?  $default,) {final _that = this;
switch (_that) {
case _ClaimTotals() when $default != null:
return $default(_that.lines,_that.amount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ClaimTotals implements ClaimTotals {
  const _ClaimTotals({this.lines = 0, this.amount = 0});
  factory _ClaimTotals.fromJson(Map<String, dynamic> json) => _$ClaimTotalsFromJson(json);

@override@JsonKey() final  int lines;
@override@JsonKey() final  double amount;

/// Create a copy of ClaimTotals
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClaimTotalsCopyWith<_ClaimTotals> get copyWith => __$ClaimTotalsCopyWithImpl<_ClaimTotals>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClaimTotalsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClaimTotals&&(identical(other.lines, lines) || other.lines == lines)&&(identical(other.amount, amount) || other.amount == amount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,lines,amount);

@override
String toString() {
  return 'ClaimTotals(lines: $lines, amount: $amount)';
}


}

/// @nodoc
abstract mixin class _$ClaimTotalsCopyWith<$Res> implements $ClaimTotalsCopyWith<$Res> {
  factory _$ClaimTotalsCopyWith(_ClaimTotals value, $Res Function(_ClaimTotals) _then) = __$ClaimTotalsCopyWithImpl;
@override @useResult
$Res call({
 int lines, double amount
});




}
/// @nodoc
class __$ClaimTotalsCopyWithImpl<$Res>
    implements _$ClaimTotalsCopyWith<$Res> {
  __$ClaimTotalsCopyWithImpl(this._self, this._then);

  final _ClaimTotals _self;
  final $Res Function(_ClaimTotals) _then;

/// Create a copy of ClaimTotals
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? lines = null,Object? amount = null,}) {
  return _then(_ClaimTotals(
lines: null == lines ? _self.lines : lines // ignore: cast_nullable_to_non_nullable
as int,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$ClaimBatch {

 String get id; String get status; String get fundingType; String get registrationNumber; String get abn; ClaimPeriod? get period; ClaimTotals get totals; String? get generatedAt; String? get reconciledAt;
/// Create a copy of ClaimBatch
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClaimBatchCopyWith<ClaimBatch> get copyWith => _$ClaimBatchCopyWithImpl<ClaimBatch>(this as ClaimBatch, _$identity);

  /// Serializes this ClaimBatch to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClaimBatch&&(identical(other.id, id) || other.id == id)&&(identical(other.status, status) || other.status == status)&&(identical(other.fundingType, fundingType) || other.fundingType == fundingType)&&(identical(other.registrationNumber, registrationNumber) || other.registrationNumber == registrationNumber)&&(identical(other.abn, abn) || other.abn == abn)&&(identical(other.period, period) || other.period == period)&&(identical(other.totals, totals) || other.totals == totals)&&(identical(other.generatedAt, generatedAt) || other.generatedAt == generatedAt)&&(identical(other.reconciledAt, reconciledAt) || other.reconciledAt == reconciledAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,status,fundingType,registrationNumber,abn,period,totals,generatedAt,reconciledAt);

@override
String toString() {
  return 'ClaimBatch(id: $id, status: $status, fundingType: $fundingType, registrationNumber: $registrationNumber, abn: $abn, period: $period, totals: $totals, generatedAt: $generatedAt, reconciledAt: $reconciledAt)';
}


}

/// @nodoc
abstract mixin class $ClaimBatchCopyWith<$Res>  {
  factory $ClaimBatchCopyWith(ClaimBatch value, $Res Function(ClaimBatch) _then) = _$ClaimBatchCopyWithImpl;
@useResult
$Res call({
 String id, String status, String fundingType, String registrationNumber, String abn, ClaimPeriod? period, ClaimTotals totals, String? generatedAt, String? reconciledAt
});


$ClaimPeriodCopyWith<$Res>? get period;$ClaimTotalsCopyWith<$Res> get totals;

}
/// @nodoc
class _$ClaimBatchCopyWithImpl<$Res>
    implements $ClaimBatchCopyWith<$Res> {
  _$ClaimBatchCopyWithImpl(this._self, this._then);

  final ClaimBatch _self;
  final $Res Function(ClaimBatch) _then;

/// Create a copy of ClaimBatch
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? status = null,Object? fundingType = null,Object? registrationNumber = null,Object? abn = null,Object? period = freezed,Object? totals = null,Object? generatedAt = freezed,Object? reconciledAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,fundingType: null == fundingType ? _self.fundingType : fundingType // ignore: cast_nullable_to_non_nullable
as String,registrationNumber: null == registrationNumber ? _self.registrationNumber : registrationNumber // ignore: cast_nullable_to_non_nullable
as String,abn: null == abn ? _self.abn : abn // ignore: cast_nullable_to_non_nullable
as String,period: freezed == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as ClaimPeriod?,totals: null == totals ? _self.totals : totals // ignore: cast_nullable_to_non_nullable
as ClaimTotals,generatedAt: freezed == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as String?,reconciledAt: freezed == reconciledAt ? _self.reconciledAt : reconciledAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of ClaimBatch
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClaimPeriodCopyWith<$Res>? get period {
    if (_self.period == null) {
    return null;
  }

  return $ClaimPeriodCopyWith<$Res>(_self.period!, (value) {
    return _then(_self.copyWith(period: value));
  });
}/// Create a copy of ClaimBatch
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClaimTotalsCopyWith<$Res> get totals {
  
  return $ClaimTotalsCopyWith<$Res>(_self.totals, (value) {
    return _then(_self.copyWith(totals: value));
  });
}
}


/// Adds pattern-matching-related methods to [ClaimBatch].
extension ClaimBatchPatterns on ClaimBatch {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClaimBatch value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClaimBatch() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClaimBatch value)  $default,){
final _that = this;
switch (_that) {
case _ClaimBatch():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClaimBatch value)?  $default,){
final _that = this;
switch (_that) {
case _ClaimBatch() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String status,  String fundingType,  String registrationNumber,  String abn,  ClaimPeriod? period,  ClaimTotals totals,  String? generatedAt,  String? reconciledAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClaimBatch() when $default != null:
return $default(_that.id,_that.status,_that.fundingType,_that.registrationNumber,_that.abn,_that.period,_that.totals,_that.generatedAt,_that.reconciledAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String status,  String fundingType,  String registrationNumber,  String abn,  ClaimPeriod? period,  ClaimTotals totals,  String? generatedAt,  String? reconciledAt)  $default,) {final _that = this;
switch (_that) {
case _ClaimBatch():
return $default(_that.id,_that.status,_that.fundingType,_that.registrationNumber,_that.abn,_that.period,_that.totals,_that.generatedAt,_that.reconciledAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String status,  String fundingType,  String registrationNumber,  String abn,  ClaimPeriod? period,  ClaimTotals totals,  String? generatedAt,  String? reconciledAt)?  $default,) {final _that = this;
switch (_that) {
case _ClaimBatch() when $default != null:
return $default(_that.id,_that.status,_that.fundingType,_that.registrationNumber,_that.abn,_that.period,_that.totals,_that.generatedAt,_that.reconciledAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ClaimBatch implements ClaimBatch {
  const _ClaimBatch({required this.id, this.status = 'draft', this.fundingType = 'ndia_managed', this.registrationNumber = '', this.abn = '', this.period, this.totals = const ClaimTotals(), this.generatedAt, this.reconciledAt});
  factory _ClaimBatch.fromJson(Map<String, dynamic> json) => _$ClaimBatchFromJson(json);

@override final  String id;
@override@JsonKey() final  String status;
@override@JsonKey() final  String fundingType;
@override@JsonKey() final  String registrationNumber;
@override@JsonKey() final  String abn;
@override final  ClaimPeriod? period;
@override@JsonKey() final  ClaimTotals totals;
@override final  String? generatedAt;
@override final  String? reconciledAt;

/// Create a copy of ClaimBatch
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClaimBatchCopyWith<_ClaimBatch> get copyWith => __$ClaimBatchCopyWithImpl<_ClaimBatch>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClaimBatchToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClaimBatch&&(identical(other.id, id) || other.id == id)&&(identical(other.status, status) || other.status == status)&&(identical(other.fundingType, fundingType) || other.fundingType == fundingType)&&(identical(other.registrationNumber, registrationNumber) || other.registrationNumber == registrationNumber)&&(identical(other.abn, abn) || other.abn == abn)&&(identical(other.period, period) || other.period == period)&&(identical(other.totals, totals) || other.totals == totals)&&(identical(other.generatedAt, generatedAt) || other.generatedAt == generatedAt)&&(identical(other.reconciledAt, reconciledAt) || other.reconciledAt == reconciledAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,status,fundingType,registrationNumber,abn,period,totals,generatedAt,reconciledAt);

@override
String toString() {
  return 'ClaimBatch(id: $id, status: $status, fundingType: $fundingType, registrationNumber: $registrationNumber, abn: $abn, period: $period, totals: $totals, generatedAt: $generatedAt, reconciledAt: $reconciledAt)';
}


}

/// @nodoc
abstract mixin class _$ClaimBatchCopyWith<$Res> implements $ClaimBatchCopyWith<$Res> {
  factory _$ClaimBatchCopyWith(_ClaimBatch value, $Res Function(_ClaimBatch) _then) = __$ClaimBatchCopyWithImpl;
@override @useResult
$Res call({
 String id, String status, String fundingType, String registrationNumber, String abn, ClaimPeriod? period, ClaimTotals totals, String? generatedAt, String? reconciledAt
});


@override $ClaimPeriodCopyWith<$Res>? get period;@override $ClaimTotalsCopyWith<$Res> get totals;

}
/// @nodoc
class __$ClaimBatchCopyWithImpl<$Res>
    implements _$ClaimBatchCopyWith<$Res> {
  __$ClaimBatchCopyWithImpl(this._self, this._then);

  final _ClaimBatch _self;
  final $Res Function(_ClaimBatch) _then;

/// Create a copy of ClaimBatch
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? status = null,Object? fundingType = null,Object? registrationNumber = null,Object? abn = null,Object? period = freezed,Object? totals = null,Object? generatedAt = freezed,Object? reconciledAt = freezed,}) {
  return _then(_ClaimBatch(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,fundingType: null == fundingType ? _self.fundingType : fundingType // ignore: cast_nullable_to_non_nullable
as String,registrationNumber: null == registrationNumber ? _self.registrationNumber : registrationNumber // ignore: cast_nullable_to_non_nullable
as String,abn: null == abn ? _self.abn : abn // ignore: cast_nullable_to_non_nullable
as String,period: freezed == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as ClaimPeriod?,totals: null == totals ? _self.totals : totals // ignore: cast_nullable_to_non_nullable
as ClaimTotals,generatedAt: freezed == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as String?,reconciledAt: freezed == reconciledAt ? _self.reconciledAt : reconciledAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of ClaimBatch
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClaimPeriodCopyWith<$Res>? get period {
    if (_self.period == null) {
    return null;
  }

  return $ClaimPeriodCopyWith<$Res>(_self.period!, (value) {
    return _then(_self.copyWith(period: value));
  });
}/// Create a copy of ClaimBatch
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClaimTotalsCopyWith<$Res> get totals {
  
  return $ClaimTotalsCopyWith<$Res>(_self.totals, (value) {
    return _then(_self.copyWith(totals: value));
  });
}
}


/// @nodoc
mixin _$ClaimLine {

 String get id; String get ndisNumber; String get supportNumber; String get claimReference; double get quantity; double get unitPrice; double get requestedAmount; String get gstCode; String get claimType; String get status; String get rejectionReason; String? get serviceDate;
/// Create a copy of ClaimLine
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClaimLineCopyWith<ClaimLine> get copyWith => _$ClaimLineCopyWithImpl<ClaimLine>(this as ClaimLine, _$identity);

  /// Serializes this ClaimLine to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClaimLine&&(identical(other.id, id) || other.id == id)&&(identical(other.ndisNumber, ndisNumber) || other.ndisNumber == ndisNumber)&&(identical(other.supportNumber, supportNumber) || other.supportNumber == supportNumber)&&(identical(other.claimReference, claimReference) || other.claimReference == claimReference)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.unitPrice, unitPrice) || other.unitPrice == unitPrice)&&(identical(other.requestedAmount, requestedAmount) || other.requestedAmount == requestedAmount)&&(identical(other.gstCode, gstCode) || other.gstCode == gstCode)&&(identical(other.claimType, claimType) || other.claimType == claimType)&&(identical(other.status, status) || other.status == status)&&(identical(other.rejectionReason, rejectionReason) || other.rejectionReason == rejectionReason)&&(identical(other.serviceDate, serviceDate) || other.serviceDate == serviceDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,ndisNumber,supportNumber,claimReference,quantity,unitPrice,requestedAmount,gstCode,claimType,status,rejectionReason,serviceDate);

@override
String toString() {
  return 'ClaimLine(id: $id, ndisNumber: $ndisNumber, supportNumber: $supportNumber, claimReference: $claimReference, quantity: $quantity, unitPrice: $unitPrice, requestedAmount: $requestedAmount, gstCode: $gstCode, claimType: $claimType, status: $status, rejectionReason: $rejectionReason, serviceDate: $serviceDate)';
}


}

/// @nodoc
abstract mixin class $ClaimLineCopyWith<$Res>  {
  factory $ClaimLineCopyWith(ClaimLine value, $Res Function(ClaimLine) _then) = _$ClaimLineCopyWithImpl;
@useResult
$Res call({
 String id, String ndisNumber, String supportNumber, String claimReference, double quantity, double unitPrice, double requestedAmount, String gstCode, String claimType, String status, String rejectionReason, String? serviceDate
});




}
/// @nodoc
class _$ClaimLineCopyWithImpl<$Res>
    implements $ClaimLineCopyWith<$Res> {
  _$ClaimLineCopyWithImpl(this._self, this._then);

  final ClaimLine _self;
  final $Res Function(ClaimLine) _then;

/// Create a copy of ClaimLine
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? ndisNumber = null,Object? supportNumber = null,Object? claimReference = null,Object? quantity = null,Object? unitPrice = null,Object? requestedAmount = null,Object? gstCode = null,Object? claimType = null,Object? status = null,Object? rejectionReason = null,Object? serviceDate = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,ndisNumber: null == ndisNumber ? _self.ndisNumber : ndisNumber // ignore: cast_nullable_to_non_nullable
as String,supportNumber: null == supportNumber ? _self.supportNumber : supportNumber // ignore: cast_nullable_to_non_nullable
as String,claimReference: null == claimReference ? _self.claimReference : claimReference // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as double,unitPrice: null == unitPrice ? _self.unitPrice : unitPrice // ignore: cast_nullable_to_non_nullable
as double,requestedAmount: null == requestedAmount ? _self.requestedAmount : requestedAmount // ignore: cast_nullable_to_non_nullable
as double,gstCode: null == gstCode ? _self.gstCode : gstCode // ignore: cast_nullable_to_non_nullable
as String,claimType: null == claimType ? _self.claimType : claimType // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,rejectionReason: null == rejectionReason ? _self.rejectionReason : rejectionReason // ignore: cast_nullable_to_non_nullable
as String,serviceDate: freezed == serviceDate ? _self.serviceDate : serviceDate // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ClaimLine].
extension ClaimLinePatterns on ClaimLine {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClaimLine value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClaimLine() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClaimLine value)  $default,){
final _that = this;
switch (_that) {
case _ClaimLine():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClaimLine value)?  $default,){
final _that = this;
switch (_that) {
case _ClaimLine() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String ndisNumber,  String supportNumber,  String claimReference,  double quantity,  double unitPrice,  double requestedAmount,  String gstCode,  String claimType,  String status,  String rejectionReason,  String? serviceDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClaimLine() when $default != null:
return $default(_that.id,_that.ndisNumber,_that.supportNumber,_that.claimReference,_that.quantity,_that.unitPrice,_that.requestedAmount,_that.gstCode,_that.claimType,_that.status,_that.rejectionReason,_that.serviceDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String ndisNumber,  String supportNumber,  String claimReference,  double quantity,  double unitPrice,  double requestedAmount,  String gstCode,  String claimType,  String status,  String rejectionReason,  String? serviceDate)  $default,) {final _that = this;
switch (_that) {
case _ClaimLine():
return $default(_that.id,_that.ndisNumber,_that.supportNumber,_that.claimReference,_that.quantity,_that.unitPrice,_that.requestedAmount,_that.gstCode,_that.claimType,_that.status,_that.rejectionReason,_that.serviceDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String ndisNumber,  String supportNumber,  String claimReference,  double quantity,  double unitPrice,  double requestedAmount,  String gstCode,  String claimType,  String status,  String rejectionReason,  String? serviceDate)?  $default,) {final _that = this;
switch (_that) {
case _ClaimLine() when $default != null:
return $default(_that.id,_that.ndisNumber,_that.supportNumber,_that.claimReference,_that.quantity,_that.unitPrice,_that.requestedAmount,_that.gstCode,_that.claimType,_that.status,_that.rejectionReason,_that.serviceDate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ClaimLine implements ClaimLine {
  const _ClaimLine({required this.id, this.ndisNumber = '', this.supportNumber = '', this.claimReference = '', this.quantity = 0, this.unitPrice = 0, this.requestedAmount = 0, this.gstCode = 'P2', this.claimType = 'DIRECT_SERVICE', this.status = 'pending', this.rejectionReason = '', this.serviceDate});
  factory _ClaimLine.fromJson(Map<String, dynamic> json) => _$ClaimLineFromJson(json);

@override final  String id;
@override@JsonKey() final  String ndisNumber;
@override@JsonKey() final  String supportNumber;
@override@JsonKey() final  String claimReference;
@override@JsonKey() final  double quantity;
@override@JsonKey() final  double unitPrice;
@override@JsonKey() final  double requestedAmount;
@override@JsonKey() final  String gstCode;
@override@JsonKey() final  String claimType;
@override@JsonKey() final  String status;
@override@JsonKey() final  String rejectionReason;
@override final  String? serviceDate;

/// Create a copy of ClaimLine
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClaimLineCopyWith<_ClaimLine> get copyWith => __$ClaimLineCopyWithImpl<_ClaimLine>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClaimLineToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClaimLine&&(identical(other.id, id) || other.id == id)&&(identical(other.ndisNumber, ndisNumber) || other.ndisNumber == ndisNumber)&&(identical(other.supportNumber, supportNumber) || other.supportNumber == supportNumber)&&(identical(other.claimReference, claimReference) || other.claimReference == claimReference)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.unitPrice, unitPrice) || other.unitPrice == unitPrice)&&(identical(other.requestedAmount, requestedAmount) || other.requestedAmount == requestedAmount)&&(identical(other.gstCode, gstCode) || other.gstCode == gstCode)&&(identical(other.claimType, claimType) || other.claimType == claimType)&&(identical(other.status, status) || other.status == status)&&(identical(other.rejectionReason, rejectionReason) || other.rejectionReason == rejectionReason)&&(identical(other.serviceDate, serviceDate) || other.serviceDate == serviceDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,ndisNumber,supportNumber,claimReference,quantity,unitPrice,requestedAmount,gstCode,claimType,status,rejectionReason,serviceDate);

@override
String toString() {
  return 'ClaimLine(id: $id, ndisNumber: $ndisNumber, supportNumber: $supportNumber, claimReference: $claimReference, quantity: $quantity, unitPrice: $unitPrice, requestedAmount: $requestedAmount, gstCode: $gstCode, claimType: $claimType, status: $status, rejectionReason: $rejectionReason, serviceDate: $serviceDate)';
}


}

/// @nodoc
abstract mixin class _$ClaimLineCopyWith<$Res> implements $ClaimLineCopyWith<$Res> {
  factory _$ClaimLineCopyWith(_ClaimLine value, $Res Function(_ClaimLine) _then) = __$ClaimLineCopyWithImpl;
@override @useResult
$Res call({
 String id, String ndisNumber, String supportNumber, String claimReference, double quantity, double unitPrice, double requestedAmount, String gstCode, String claimType, String status, String rejectionReason, String? serviceDate
});




}
/// @nodoc
class __$ClaimLineCopyWithImpl<$Res>
    implements _$ClaimLineCopyWith<$Res> {
  __$ClaimLineCopyWithImpl(this._self, this._then);

  final _ClaimLine _self;
  final $Res Function(_ClaimLine) _then;

/// Create a copy of ClaimLine
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? ndisNumber = null,Object? supportNumber = null,Object? claimReference = null,Object? quantity = null,Object? unitPrice = null,Object? requestedAmount = null,Object? gstCode = null,Object? claimType = null,Object? status = null,Object? rejectionReason = null,Object? serviceDate = freezed,}) {
  return _then(_ClaimLine(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,ndisNumber: null == ndisNumber ? _self.ndisNumber : ndisNumber // ignore: cast_nullable_to_non_nullable
as String,supportNumber: null == supportNumber ? _self.supportNumber : supportNumber // ignore: cast_nullable_to_non_nullable
as String,claimReference: null == claimReference ? _self.claimReference : claimReference // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as double,unitPrice: null == unitPrice ? _self.unitPrice : unitPrice // ignore: cast_nullable_to_non_nullable
as double,requestedAmount: null == requestedAmount ? _self.requestedAmount : requestedAmount // ignore: cast_nullable_to_non_nullable
as double,gstCode: null == gstCode ? _self.gstCode : gstCode // ignore: cast_nullable_to_non_nullable
as String,claimType: null == claimType ? _self.claimType : claimType // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,rejectionReason: null == rejectionReason ? _self.rejectionReason : rejectionReason // ignore: cast_nullable_to_non_nullable
as String,serviceDate: freezed == serviceDate ? _self.serviceDate : serviceDate // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ClaimValidationError {

 String get claimReference; String get field; String get message;
/// Create a copy of ClaimValidationError
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClaimValidationErrorCopyWith<ClaimValidationError> get copyWith => _$ClaimValidationErrorCopyWithImpl<ClaimValidationError>(this as ClaimValidationError, _$identity);

  /// Serializes this ClaimValidationError to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClaimValidationError&&(identical(other.claimReference, claimReference) || other.claimReference == claimReference)&&(identical(other.field, field) || other.field == field)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,claimReference,field,message);

@override
String toString() {
  return 'ClaimValidationError(claimReference: $claimReference, field: $field, message: $message)';
}


}

/// @nodoc
abstract mixin class $ClaimValidationErrorCopyWith<$Res>  {
  factory $ClaimValidationErrorCopyWith(ClaimValidationError value, $Res Function(ClaimValidationError) _then) = _$ClaimValidationErrorCopyWithImpl;
@useResult
$Res call({
 String claimReference, String field, String message
});




}
/// @nodoc
class _$ClaimValidationErrorCopyWithImpl<$Res>
    implements $ClaimValidationErrorCopyWith<$Res> {
  _$ClaimValidationErrorCopyWithImpl(this._self, this._then);

  final ClaimValidationError _self;
  final $Res Function(ClaimValidationError) _then;

/// Create a copy of ClaimValidationError
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? claimReference = null,Object? field = null,Object? message = null,}) {
  return _then(_self.copyWith(
claimReference: null == claimReference ? _self.claimReference : claimReference // ignore: cast_nullable_to_non_nullable
as String,field: null == field ? _self.field : field // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ClaimValidationError].
extension ClaimValidationErrorPatterns on ClaimValidationError {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClaimValidationError value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClaimValidationError() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClaimValidationError value)  $default,){
final _that = this;
switch (_that) {
case _ClaimValidationError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClaimValidationError value)?  $default,){
final _that = this;
switch (_that) {
case _ClaimValidationError() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String claimReference,  String field,  String message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClaimValidationError() when $default != null:
return $default(_that.claimReference,_that.field,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String claimReference,  String field,  String message)  $default,) {final _that = this;
switch (_that) {
case _ClaimValidationError():
return $default(_that.claimReference,_that.field,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String claimReference,  String field,  String message)?  $default,) {final _that = this;
switch (_that) {
case _ClaimValidationError() when $default != null:
return $default(_that.claimReference,_that.field,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ClaimValidationError implements ClaimValidationError {
  const _ClaimValidationError({this.claimReference = '', this.field = '', this.message = ''});
  factory _ClaimValidationError.fromJson(Map<String, dynamic> json) => _$ClaimValidationErrorFromJson(json);

@override@JsonKey() final  String claimReference;
@override@JsonKey() final  String field;
@override@JsonKey() final  String message;

/// Create a copy of ClaimValidationError
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClaimValidationErrorCopyWith<_ClaimValidationError> get copyWith => __$ClaimValidationErrorCopyWithImpl<_ClaimValidationError>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClaimValidationErrorToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClaimValidationError&&(identical(other.claimReference, claimReference) || other.claimReference == claimReference)&&(identical(other.field, field) || other.field == field)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,claimReference,field,message);

@override
String toString() {
  return 'ClaimValidationError(claimReference: $claimReference, field: $field, message: $message)';
}


}

/// @nodoc
abstract mixin class _$ClaimValidationErrorCopyWith<$Res> implements $ClaimValidationErrorCopyWith<$Res> {
  factory _$ClaimValidationErrorCopyWith(_ClaimValidationError value, $Res Function(_ClaimValidationError) _then) = __$ClaimValidationErrorCopyWithImpl;
@override @useResult
$Res call({
 String claimReference, String field, String message
});




}
/// @nodoc
class __$ClaimValidationErrorCopyWithImpl<$Res>
    implements _$ClaimValidationErrorCopyWith<$Res> {
  __$ClaimValidationErrorCopyWithImpl(this._self, this._then);

  final _ClaimValidationError _self;
  final $Res Function(_ClaimValidationError) _then;

/// Create a copy of ClaimValidationError
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? claimReference = null,Object? field = null,Object? message = null,}) {
  return _then(_ClaimValidationError(
claimReference: null == claimReference ? _self.claimReference : claimReference // ignore: cast_nullable_to_non_nullable
as String,field: null == field ? _self.field : field // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ClaimValidation {

 List<ClaimValidationError> get errors; List<ClaimValidationError> get warnings;
/// Create a copy of ClaimValidation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClaimValidationCopyWith<ClaimValidation> get copyWith => _$ClaimValidationCopyWithImpl<ClaimValidation>(this as ClaimValidation, _$identity);

  /// Serializes this ClaimValidation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClaimValidation&&const DeepCollectionEquality().equals(other.errors, errors)&&const DeepCollectionEquality().equals(other.warnings, warnings));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(errors),const DeepCollectionEquality().hash(warnings));

@override
String toString() {
  return 'ClaimValidation(errors: $errors, warnings: $warnings)';
}


}

/// @nodoc
abstract mixin class $ClaimValidationCopyWith<$Res>  {
  factory $ClaimValidationCopyWith(ClaimValidation value, $Res Function(ClaimValidation) _then) = _$ClaimValidationCopyWithImpl;
@useResult
$Res call({
 List<ClaimValidationError> errors, List<ClaimValidationError> warnings
});




}
/// @nodoc
class _$ClaimValidationCopyWithImpl<$Res>
    implements $ClaimValidationCopyWith<$Res> {
  _$ClaimValidationCopyWithImpl(this._self, this._then);

  final ClaimValidation _self;
  final $Res Function(ClaimValidation) _then;

/// Create a copy of ClaimValidation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? errors = null,Object? warnings = null,}) {
  return _then(_self.copyWith(
errors: null == errors ? _self.errors : errors // ignore: cast_nullable_to_non_nullable
as List<ClaimValidationError>,warnings: null == warnings ? _self.warnings : warnings // ignore: cast_nullable_to_non_nullable
as List<ClaimValidationError>,
  ));
}

}


/// Adds pattern-matching-related methods to [ClaimValidation].
extension ClaimValidationPatterns on ClaimValidation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClaimValidation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClaimValidation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClaimValidation value)  $default,){
final _that = this;
switch (_that) {
case _ClaimValidation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClaimValidation value)?  $default,){
final _that = this;
switch (_that) {
case _ClaimValidation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<ClaimValidationError> errors,  List<ClaimValidationError> warnings)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClaimValidation() when $default != null:
return $default(_that.errors,_that.warnings);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<ClaimValidationError> errors,  List<ClaimValidationError> warnings)  $default,) {final _that = this;
switch (_that) {
case _ClaimValidation():
return $default(_that.errors,_that.warnings);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<ClaimValidationError> errors,  List<ClaimValidationError> warnings)?  $default,) {final _that = this;
switch (_that) {
case _ClaimValidation() when $default != null:
return $default(_that.errors,_that.warnings);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ClaimValidation implements ClaimValidation {
  const _ClaimValidation({final  List<ClaimValidationError> errors = const <ClaimValidationError>[], final  List<ClaimValidationError> warnings = const <ClaimValidationError>[]}): _errors = errors,_warnings = warnings;
  factory _ClaimValidation.fromJson(Map<String, dynamic> json) => _$ClaimValidationFromJson(json);

 final  List<ClaimValidationError> _errors;
@override@JsonKey() List<ClaimValidationError> get errors {
  if (_errors is EqualUnmodifiableListView) return _errors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_errors);
}

 final  List<ClaimValidationError> _warnings;
@override@JsonKey() List<ClaimValidationError> get warnings {
  if (_warnings is EqualUnmodifiableListView) return _warnings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_warnings);
}


/// Create a copy of ClaimValidation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClaimValidationCopyWith<_ClaimValidation> get copyWith => __$ClaimValidationCopyWithImpl<_ClaimValidation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClaimValidationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClaimValidation&&const DeepCollectionEquality().equals(other._errors, _errors)&&const DeepCollectionEquality().equals(other._warnings, _warnings));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_errors),const DeepCollectionEquality().hash(_warnings));

@override
String toString() {
  return 'ClaimValidation(errors: $errors, warnings: $warnings)';
}


}

/// @nodoc
abstract mixin class _$ClaimValidationCopyWith<$Res> implements $ClaimValidationCopyWith<$Res> {
  factory _$ClaimValidationCopyWith(_ClaimValidation value, $Res Function(_ClaimValidation) _then) = __$ClaimValidationCopyWithImpl;
@override @useResult
$Res call({
 List<ClaimValidationError> errors, List<ClaimValidationError> warnings
});




}
/// @nodoc
class __$ClaimValidationCopyWithImpl<$Res>
    implements _$ClaimValidationCopyWith<$Res> {
  __$ClaimValidationCopyWithImpl(this._self, this._then);

  final _ClaimValidation _self;
  final $Res Function(_ClaimValidation) _then;

/// Create a copy of ClaimValidation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? errors = null,Object? warnings = null,}) {
  return _then(_ClaimValidation(
errors: null == errors ? _self._errors : errors // ignore: cast_nullable_to_non_nullable
as List<ClaimValidationError>,warnings: null == warnings ? _self._warnings : warnings // ignore: cast_nullable_to_non_nullable
as List<ClaimValidationError>,
  ));
}


}

// dart format on
