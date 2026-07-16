// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fallback_pricing_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FallbackPricingState {

 double? get fallbackRate; bool get isLoading; String? get errorMessage; bool get saveSucceeded;
/// Create a copy of FallbackPricingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FallbackPricingStateCopyWith<FallbackPricingState> get copyWith => _$FallbackPricingStateCopyWithImpl<FallbackPricingState>(this as FallbackPricingState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FallbackPricingState&&(identical(other.fallbackRate, fallbackRate) || other.fallbackRate == fallbackRate)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.saveSucceeded, saveSucceeded) || other.saveSucceeded == saveSucceeded));
}


@override
int get hashCode => Object.hash(runtimeType,fallbackRate,isLoading,errorMessage,saveSucceeded);

@override
String toString() {
  return 'FallbackPricingState(fallbackRate: $fallbackRate, isLoading: $isLoading, errorMessage: $errorMessage, saveSucceeded: $saveSucceeded)';
}


}

/// @nodoc
abstract mixin class $FallbackPricingStateCopyWith<$Res>  {
  factory $FallbackPricingStateCopyWith(FallbackPricingState value, $Res Function(FallbackPricingState) _then) = _$FallbackPricingStateCopyWithImpl;
@useResult
$Res call({
 double? fallbackRate, bool isLoading, String? errorMessage, bool saveSucceeded
});




}
/// @nodoc
class _$FallbackPricingStateCopyWithImpl<$Res>
    implements $FallbackPricingStateCopyWith<$Res> {
  _$FallbackPricingStateCopyWithImpl(this._self, this._then);

  final FallbackPricingState _self;
  final $Res Function(FallbackPricingState) _then;

/// Create a copy of FallbackPricingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fallbackRate = freezed,Object? isLoading = null,Object? errorMessage = freezed,Object? saveSucceeded = null,}) {
  return _then(_self.copyWith(
fallbackRate: freezed == fallbackRate ? _self.fallbackRate : fallbackRate // ignore: cast_nullable_to_non_nullable
as double?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,saveSucceeded: null == saveSucceeded ? _self.saveSucceeded : saveSucceeded // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [FallbackPricingState].
extension FallbackPricingStatePatterns on FallbackPricingState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FallbackPricingState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FallbackPricingState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FallbackPricingState value)  $default,){
final _that = this;
switch (_that) {
case _FallbackPricingState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FallbackPricingState value)?  $default,){
final _that = this;
switch (_that) {
case _FallbackPricingState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double? fallbackRate,  bool isLoading,  String? errorMessage,  bool saveSucceeded)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FallbackPricingState() when $default != null:
return $default(_that.fallbackRate,_that.isLoading,_that.errorMessage,_that.saveSucceeded);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double? fallbackRate,  bool isLoading,  String? errorMessage,  bool saveSucceeded)  $default,) {final _that = this;
switch (_that) {
case _FallbackPricingState():
return $default(_that.fallbackRate,_that.isLoading,_that.errorMessage,_that.saveSucceeded);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double? fallbackRate,  bool isLoading,  String? errorMessage,  bool saveSucceeded)?  $default,) {final _that = this;
switch (_that) {
case _FallbackPricingState() when $default != null:
return $default(_that.fallbackRate,_that.isLoading,_that.errorMessage,_that.saveSucceeded);case _:
  return null;

}
}

}

/// @nodoc


class _FallbackPricingState implements FallbackPricingState {
  const _FallbackPricingState({this.fallbackRate, this.isLoading = false, this.errorMessage, this.saveSucceeded = false});
  

@override final  double? fallbackRate;
@override@JsonKey() final  bool isLoading;
@override final  String? errorMessage;
@override@JsonKey() final  bool saveSucceeded;

/// Create a copy of FallbackPricingState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FallbackPricingStateCopyWith<_FallbackPricingState> get copyWith => __$FallbackPricingStateCopyWithImpl<_FallbackPricingState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FallbackPricingState&&(identical(other.fallbackRate, fallbackRate) || other.fallbackRate == fallbackRate)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.saveSucceeded, saveSucceeded) || other.saveSucceeded == saveSucceeded));
}


@override
int get hashCode => Object.hash(runtimeType,fallbackRate,isLoading,errorMessage,saveSucceeded);

@override
String toString() {
  return 'FallbackPricingState(fallbackRate: $fallbackRate, isLoading: $isLoading, errorMessage: $errorMessage, saveSucceeded: $saveSucceeded)';
}


}

/// @nodoc
abstract mixin class _$FallbackPricingStateCopyWith<$Res> implements $FallbackPricingStateCopyWith<$Res> {
  factory _$FallbackPricingStateCopyWith(_FallbackPricingState value, $Res Function(_FallbackPricingState) _then) = __$FallbackPricingStateCopyWithImpl;
@override @useResult
$Res call({
 double? fallbackRate, bool isLoading, String? errorMessage, bool saveSucceeded
});




}
/// @nodoc
class __$FallbackPricingStateCopyWithImpl<$Res>
    implements _$FallbackPricingStateCopyWith<$Res> {
  __$FallbackPricingStateCopyWithImpl(this._self, this._then);

  final _FallbackPricingState _self;
  final $Res Function(_FallbackPricingState) _then;

/// Create a copy of FallbackPricingState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fallbackRate = freezed,Object? isLoading = null,Object? errorMessage = freezed,Object? saveSucceeded = null,}) {
  return _then(_FallbackPricingState(
fallbackRate: freezed == fallbackRate ? _self.fallbackRate : fallbackRate // ignore: cast_nullable_to_non_nullable
as double?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,saveSucceeded: null == saveSucceeded ? _self.saveSucceeded : saveSucceeded // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
