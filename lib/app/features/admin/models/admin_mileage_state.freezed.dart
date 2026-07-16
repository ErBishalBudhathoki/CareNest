// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin_mileage_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AdminMileageState {

 List<Trip> get trips; Map<String, Map<String, dynamic>> get rawTripsById; bool get isLoading; String? get error; String get filterStatus;
/// Create a copy of AdminMileageState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdminMileageStateCopyWith<AdminMileageState> get copyWith => _$AdminMileageStateCopyWithImpl<AdminMileageState>(this as AdminMileageState, _$identity);

  /// Serializes this AdminMileageState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdminMileageState&&const DeepCollectionEquality().equals(other.trips, trips)&&const DeepCollectionEquality().equals(other.rawTripsById, rawTripsById)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error)&&(identical(other.filterStatus, filterStatus) || other.filterStatus == filterStatus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(trips),const DeepCollectionEquality().hash(rawTripsById),isLoading,error,filterStatus);

@override
String toString() {
  return 'AdminMileageState(trips: $trips, rawTripsById: $rawTripsById, isLoading: $isLoading, error: $error, filterStatus: $filterStatus)';
}


}

/// @nodoc
abstract mixin class $AdminMileageStateCopyWith<$Res>  {
  factory $AdminMileageStateCopyWith(AdminMileageState value, $Res Function(AdminMileageState) _then) = _$AdminMileageStateCopyWithImpl;
@useResult
$Res call({
 List<Trip> trips, Map<String, Map<String, dynamic>> rawTripsById, bool isLoading, String? error, String filterStatus
});




}
/// @nodoc
class _$AdminMileageStateCopyWithImpl<$Res>
    implements $AdminMileageStateCopyWith<$Res> {
  _$AdminMileageStateCopyWithImpl(this._self, this._then);

  final AdminMileageState _self;
  final $Res Function(AdminMileageState) _then;

/// Create a copy of AdminMileageState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? trips = null,Object? rawTripsById = null,Object? isLoading = null,Object? error = freezed,Object? filterStatus = null,}) {
  return _then(_self.copyWith(
trips: null == trips ? _self.trips : trips // ignore: cast_nullable_to_non_nullable
as List<Trip>,rawTripsById: null == rawTripsById ? _self.rawTripsById : rawTripsById // ignore: cast_nullable_to_non_nullable
as Map<String, Map<String, dynamic>>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,filterStatus: null == filterStatus ? _self.filterStatus : filterStatus // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AdminMileageState].
extension AdminMileageStatePatterns on AdminMileageState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AdminMileageState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AdminMileageState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AdminMileageState value)  $default,){
final _that = this;
switch (_that) {
case _AdminMileageState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AdminMileageState value)?  $default,){
final _that = this;
switch (_that) {
case _AdminMileageState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Trip> trips,  Map<String, Map<String, dynamic>> rawTripsById,  bool isLoading,  String? error,  String filterStatus)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AdminMileageState() when $default != null:
return $default(_that.trips,_that.rawTripsById,_that.isLoading,_that.error,_that.filterStatus);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Trip> trips,  Map<String, Map<String, dynamic>> rawTripsById,  bool isLoading,  String? error,  String filterStatus)  $default,) {final _that = this;
switch (_that) {
case _AdminMileageState():
return $default(_that.trips,_that.rawTripsById,_that.isLoading,_that.error,_that.filterStatus);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Trip> trips,  Map<String, Map<String, dynamic>> rawTripsById,  bool isLoading,  String? error,  String filterStatus)?  $default,) {final _that = this;
switch (_that) {
case _AdminMileageState() when $default != null:
return $default(_that.trips,_that.rawTripsById,_that.isLoading,_that.error,_that.filterStatus);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AdminMileageState extends AdminMileageState {
  const _AdminMileageState({final  List<Trip> trips = const [], final  Map<String, Map<String, dynamic>> rawTripsById = const {}, this.isLoading = false, this.error, this.filterStatus = 'PENDING'}): _trips = trips,_rawTripsById = rawTripsById,super._();
  factory _AdminMileageState.fromJson(Map<String, dynamic> json) => _$AdminMileageStateFromJson(json);

 final  List<Trip> _trips;
@override@JsonKey() List<Trip> get trips {
  if (_trips is EqualUnmodifiableListView) return _trips;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_trips);
}

 final  Map<String, Map<String, dynamic>> _rawTripsById;
@override@JsonKey() Map<String, Map<String, dynamic>> get rawTripsById {
  if (_rawTripsById is EqualUnmodifiableMapView) return _rawTripsById;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_rawTripsById);
}

@override@JsonKey() final  bool isLoading;
@override final  String? error;
@override@JsonKey() final  String filterStatus;

/// Create a copy of AdminMileageState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdminMileageStateCopyWith<_AdminMileageState> get copyWith => __$AdminMileageStateCopyWithImpl<_AdminMileageState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AdminMileageStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdminMileageState&&const DeepCollectionEquality().equals(other._trips, _trips)&&const DeepCollectionEquality().equals(other._rawTripsById, _rawTripsById)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error)&&(identical(other.filterStatus, filterStatus) || other.filterStatus == filterStatus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_trips),const DeepCollectionEquality().hash(_rawTripsById),isLoading,error,filterStatus);

@override
String toString() {
  return 'AdminMileageState(trips: $trips, rawTripsById: $rawTripsById, isLoading: $isLoading, error: $error, filterStatus: $filterStatus)';
}


}

/// @nodoc
abstract mixin class _$AdminMileageStateCopyWith<$Res> implements $AdminMileageStateCopyWith<$Res> {
  factory _$AdminMileageStateCopyWith(_AdminMileageState value, $Res Function(_AdminMileageState) _then) = __$AdminMileageStateCopyWithImpl;
@override @useResult
$Res call({
 List<Trip> trips, Map<String, Map<String, dynamic>> rawTripsById, bool isLoading, String? error, String filterStatus
});




}
/// @nodoc
class __$AdminMileageStateCopyWithImpl<$Res>
    implements _$AdminMileageStateCopyWith<$Res> {
  __$AdminMileageStateCopyWithImpl(this._self, this._then);

  final _AdminMileageState _self;
  final $Res Function(_AdminMileageState) _then;

/// Create a copy of AdminMileageState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? trips = null,Object? rawTripsById = null,Object? isLoading = null,Object? error = freezed,Object? filterStatus = null,}) {
  return _then(_AdminMileageState(
trips: null == trips ? _self._trips : trips // ignore: cast_nullable_to_non_nullable
as List<Trip>,rawTripsById: null == rawTripsById ? _self._rawTripsById : rawTripsById // ignore: cast_nullable_to_non_nullable
as Map<String, Map<String, dynamic>>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,filterStatus: null == filterStatus ? _self.filterStatus : filterStatus // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
