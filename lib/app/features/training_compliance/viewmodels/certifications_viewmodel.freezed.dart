// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'certifications_viewmodel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CertificationsState {

 bool get isLoading; List<Certification> get certifications; String? get errorMessage;
/// Create a copy of CertificationsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CertificationsStateCopyWith<CertificationsState> get copyWith => _$CertificationsStateCopyWithImpl<CertificationsState>(this as CertificationsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CertificationsState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other.certifications, certifications)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(certifications),errorMessage);

@override
String toString() {
  return 'CertificationsState(isLoading: $isLoading, certifications: $certifications, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $CertificationsStateCopyWith<$Res>  {
  factory $CertificationsStateCopyWith(CertificationsState value, $Res Function(CertificationsState) _then) = _$CertificationsStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, List<Certification> certifications, String? errorMessage
});




}
/// @nodoc
class _$CertificationsStateCopyWithImpl<$Res>
    implements $CertificationsStateCopyWith<$Res> {
  _$CertificationsStateCopyWithImpl(this._self, this._then);

  final CertificationsState _self;
  final $Res Function(CertificationsState) _then;

/// Create a copy of CertificationsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? certifications = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,certifications: null == certifications ? _self.certifications : certifications // ignore: cast_nullable_to_non_nullable
as List<Certification>,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CertificationsState].
extension CertificationsStatePatterns on CertificationsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CertificationsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CertificationsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CertificationsState value)  $default,){
final _that = this;
switch (_that) {
case _CertificationsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CertificationsState value)?  $default,){
final _that = this;
switch (_that) {
case _CertificationsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  List<Certification> certifications,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CertificationsState() when $default != null:
return $default(_that.isLoading,_that.certifications,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  List<Certification> certifications,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _CertificationsState():
return $default(_that.isLoading,_that.certifications,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  List<Certification> certifications,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _CertificationsState() when $default != null:
return $default(_that.isLoading,_that.certifications,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _CertificationsState implements CertificationsState {
  const _CertificationsState({this.isLoading = false, final  List<Certification> certifications = const [], this.errorMessage}): _certifications = certifications;
  

@override@JsonKey() final  bool isLoading;
 final  List<Certification> _certifications;
@override@JsonKey() List<Certification> get certifications {
  if (_certifications is EqualUnmodifiableListView) return _certifications;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_certifications);
}

@override final  String? errorMessage;

/// Create a copy of CertificationsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CertificationsStateCopyWith<_CertificationsState> get copyWith => __$CertificationsStateCopyWithImpl<_CertificationsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CertificationsState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other._certifications, _certifications)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(_certifications),errorMessage);

@override
String toString() {
  return 'CertificationsState(isLoading: $isLoading, certifications: $certifications, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$CertificationsStateCopyWith<$Res> implements $CertificationsStateCopyWith<$Res> {
  factory _$CertificationsStateCopyWith(_CertificationsState value, $Res Function(_CertificationsState) _then) = __$CertificationsStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, List<Certification> certifications, String? errorMessage
});




}
/// @nodoc
class __$CertificationsStateCopyWithImpl<$Res>
    implements _$CertificationsStateCopyWith<$Res> {
  __$CertificationsStateCopyWithImpl(this._self, this._then);

  final _CertificationsState _self;
  final $Res Function(_CertificationsState) _then;

/// Create a copy of CertificationsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? certifications = null,Object? errorMessage = freezed,}) {
  return _then(_CertificationsState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,certifications: null == certifications ? _self._certifications : certifications // ignore: cast_nullable_to_non_nullable
as List<Certification>,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
