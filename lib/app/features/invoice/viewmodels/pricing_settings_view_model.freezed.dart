// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pricing_settings_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PricingSettingsState {

 PricingSettings get settings; bool get isLoading; String? get errorMessage; bool get saveSucceeded;
/// Create a copy of PricingSettingsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PricingSettingsStateCopyWith<PricingSettingsState> get copyWith => _$PricingSettingsStateCopyWithImpl<PricingSettingsState>(this as PricingSettingsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PricingSettingsState&&(identical(other.settings, settings) || other.settings == settings)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.saveSucceeded, saveSucceeded) || other.saveSucceeded == saveSucceeded));
}


@override
int get hashCode => Object.hash(runtimeType,settings,isLoading,errorMessage,saveSucceeded);

@override
String toString() {
  return 'PricingSettingsState(settings: $settings, isLoading: $isLoading, errorMessage: $errorMessage, saveSucceeded: $saveSucceeded)';
}


}

/// @nodoc
abstract mixin class $PricingSettingsStateCopyWith<$Res>  {
  factory $PricingSettingsStateCopyWith(PricingSettingsState value, $Res Function(PricingSettingsState) _then) = _$PricingSettingsStateCopyWithImpl;
@useResult
$Res call({
 PricingSettings settings, bool isLoading, String? errorMessage, bool saveSucceeded
});




}
/// @nodoc
class _$PricingSettingsStateCopyWithImpl<$Res>
    implements $PricingSettingsStateCopyWith<$Res> {
  _$PricingSettingsStateCopyWithImpl(this._self, this._then);

  final PricingSettingsState _self;
  final $Res Function(PricingSettingsState) _then;

/// Create a copy of PricingSettingsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? settings = null,Object? isLoading = null,Object? errorMessage = freezed,Object? saveSucceeded = null,}) {
  return _then(_self.copyWith(
settings: null == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as PricingSettings,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,saveSucceeded: null == saveSucceeded ? _self.saveSucceeded : saveSucceeded // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PricingSettingsState].
extension PricingSettingsStatePatterns on PricingSettingsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PricingSettingsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PricingSettingsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PricingSettingsState value)  $default,){
final _that = this;
switch (_that) {
case _PricingSettingsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PricingSettingsState value)?  $default,){
final _that = this;
switch (_that) {
case _PricingSettingsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PricingSettings settings,  bool isLoading,  String? errorMessage,  bool saveSucceeded)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PricingSettingsState() when $default != null:
return $default(_that.settings,_that.isLoading,_that.errorMessage,_that.saveSucceeded);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PricingSettings settings,  bool isLoading,  String? errorMessage,  bool saveSucceeded)  $default,) {final _that = this;
switch (_that) {
case _PricingSettingsState():
return $default(_that.settings,_that.isLoading,_that.errorMessage,_that.saveSucceeded);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PricingSettings settings,  bool isLoading,  String? errorMessage,  bool saveSucceeded)?  $default,) {final _that = this;
switch (_that) {
case _PricingSettingsState() when $default != null:
return $default(_that.settings,_that.isLoading,_that.errorMessage,_that.saveSucceeded);case _:
  return null;

}
}

}

/// @nodoc


class _PricingSettingsState implements PricingSettingsState {
  const _PricingSettingsState({required this.settings, this.isLoading = false, this.errorMessage, this.saveSucceeded = false});
  

@override final  PricingSettings settings;
@override@JsonKey() final  bool isLoading;
@override final  String? errorMessage;
@override@JsonKey() final  bool saveSucceeded;

/// Create a copy of PricingSettingsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PricingSettingsStateCopyWith<_PricingSettingsState> get copyWith => __$PricingSettingsStateCopyWithImpl<_PricingSettingsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PricingSettingsState&&(identical(other.settings, settings) || other.settings == settings)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.saveSucceeded, saveSucceeded) || other.saveSucceeded == saveSucceeded));
}


@override
int get hashCode => Object.hash(runtimeType,settings,isLoading,errorMessage,saveSucceeded);

@override
String toString() {
  return 'PricingSettingsState(settings: $settings, isLoading: $isLoading, errorMessage: $errorMessage, saveSucceeded: $saveSucceeded)';
}


}

/// @nodoc
abstract mixin class _$PricingSettingsStateCopyWith<$Res> implements $PricingSettingsStateCopyWith<$Res> {
  factory _$PricingSettingsStateCopyWith(_PricingSettingsState value, $Res Function(_PricingSettingsState) _then) = __$PricingSettingsStateCopyWithImpl;
@override @useResult
$Res call({
 PricingSettings settings, bool isLoading, String? errorMessage, bool saveSucceeded
});




}
/// @nodoc
class __$PricingSettingsStateCopyWithImpl<$Res>
    implements _$PricingSettingsStateCopyWith<$Res> {
  __$PricingSettingsStateCopyWithImpl(this._self, this._then);

  final _PricingSettingsState _self;
  final $Res Function(_PricingSettingsState) _then;

/// Create a copy of PricingSettingsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? settings = null,Object? isLoading = null,Object? errorMessage = freezed,Object? saveSucceeded = null,}) {
  return _then(_PricingSettingsState(
settings: null == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as PricingSettings,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,saveSucceeded: null == saveSucceeded ? _self.saveSucceeded : saveSucceeded // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
