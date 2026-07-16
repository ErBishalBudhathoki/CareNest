// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mileage_settings_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MileageSettingsState {

 bool get isLoading; double get reimbursementRate; String? get error;
/// Create a copy of MileageSettingsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MileageSettingsStateCopyWith<MileageSettingsState> get copyWith => _$MileageSettingsStateCopyWithImpl<MileageSettingsState>(this as MileageSettingsState, _$identity);

  /// Serializes this MileageSettingsState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MileageSettingsState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.reimbursementRate, reimbursementRate) || other.reimbursementRate == reimbursementRate)&&(identical(other.error, error) || other.error == error));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isLoading,reimbursementRate,error);

@override
String toString() {
  return 'MileageSettingsState(isLoading: $isLoading, reimbursementRate: $reimbursementRate, error: $error)';
}


}

/// @nodoc
abstract mixin class $MileageSettingsStateCopyWith<$Res>  {
  factory $MileageSettingsStateCopyWith(MileageSettingsState value, $Res Function(MileageSettingsState) _then) = _$MileageSettingsStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, double reimbursementRate, String? error
});




}
/// @nodoc
class _$MileageSettingsStateCopyWithImpl<$Res>
    implements $MileageSettingsStateCopyWith<$Res> {
  _$MileageSettingsStateCopyWithImpl(this._self, this._then);

  final MileageSettingsState _self;
  final $Res Function(MileageSettingsState) _then;

/// Create a copy of MileageSettingsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? reimbursementRate = null,Object? error = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,reimbursementRate: null == reimbursementRate ? _self.reimbursementRate : reimbursementRate // ignore: cast_nullable_to_non_nullable
as double,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MileageSettingsState].
extension MileageSettingsStatePatterns on MileageSettingsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MileageSettingsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MileageSettingsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MileageSettingsState value)  $default,){
final _that = this;
switch (_that) {
case _MileageSettingsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MileageSettingsState value)?  $default,){
final _that = this;
switch (_that) {
case _MileageSettingsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  double reimbursementRate,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MileageSettingsState() when $default != null:
return $default(_that.isLoading,_that.reimbursementRate,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  double reimbursementRate,  String? error)  $default,) {final _that = this;
switch (_that) {
case _MileageSettingsState():
return $default(_that.isLoading,_that.reimbursementRate,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  double reimbursementRate,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _MileageSettingsState() when $default != null:
return $default(_that.isLoading,_that.reimbursementRate,_that.error);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MileageSettingsState implements MileageSettingsState {
  const _MileageSettingsState({this.isLoading = false, this.reimbursementRate = 0.99, this.error});
  factory _MileageSettingsState.fromJson(Map<String, dynamic> json) => _$MileageSettingsStateFromJson(json);

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  double reimbursementRate;
@override final  String? error;

/// Create a copy of MileageSettingsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MileageSettingsStateCopyWith<_MileageSettingsState> get copyWith => __$MileageSettingsStateCopyWithImpl<_MileageSettingsState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MileageSettingsStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MileageSettingsState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.reimbursementRate, reimbursementRate) || other.reimbursementRate == reimbursementRate)&&(identical(other.error, error) || other.error == error));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isLoading,reimbursementRate,error);

@override
String toString() {
  return 'MileageSettingsState(isLoading: $isLoading, reimbursementRate: $reimbursementRate, error: $error)';
}


}

/// @nodoc
abstract mixin class _$MileageSettingsStateCopyWith<$Res> implements $MileageSettingsStateCopyWith<$Res> {
  factory _$MileageSettingsStateCopyWith(_MileageSettingsState value, $Res Function(_MileageSettingsState) _then) = __$MileageSettingsStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, double reimbursementRate, String? error
});




}
/// @nodoc
class __$MileageSettingsStateCopyWithImpl<$Res>
    implements _$MileageSettingsStateCopyWith<$Res> {
  __$MileageSettingsStateCopyWithImpl(this._self, this._then);

  final _MileageSettingsState _self;
  final $Res Function(_MileageSettingsState) _then;

/// Create a copy of MileageSettingsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? reimbursementRate = null,Object? error = freezed,}) {
  return _then(_MileageSettingsState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,reimbursementRate: null == reimbursementRate ? _self.reimbursementRate : reimbursementRate // ignore: cast_nullable_to_non_nullable
as double,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
