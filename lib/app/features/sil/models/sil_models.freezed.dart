// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sil_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SILAddress {

 String get line1; String get line2; String get suburb; String get state; String get postcode; String get country;
/// Create a copy of SILAddress
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SILAddressCopyWith<SILAddress> get copyWith => _$SILAddressCopyWithImpl<SILAddress>(this as SILAddress, _$identity);

  /// Serializes this SILAddress to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SILAddress&&(identical(other.line1, line1) || other.line1 == line1)&&(identical(other.line2, line2) || other.line2 == line2)&&(identical(other.suburb, suburb) || other.suburb == suburb)&&(identical(other.state, state) || other.state == state)&&(identical(other.postcode, postcode) || other.postcode == postcode)&&(identical(other.country, country) || other.country == country));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,line1,line2,suburb,state,postcode,country);

@override
String toString() {
  return 'SILAddress(line1: $line1, line2: $line2, suburb: $suburb, state: $state, postcode: $postcode, country: $country)';
}


}

/// @nodoc
abstract mixin class $SILAddressCopyWith<$Res>  {
  factory $SILAddressCopyWith(SILAddress value, $Res Function(SILAddress) _then) = _$SILAddressCopyWithImpl;
@useResult
$Res call({
 String line1, String line2, String suburb, String state, String postcode, String country
});




}
/// @nodoc
class _$SILAddressCopyWithImpl<$Res>
    implements $SILAddressCopyWith<$Res> {
  _$SILAddressCopyWithImpl(this._self, this._then);

  final SILAddress _self;
  final $Res Function(SILAddress) _then;

/// Create a copy of SILAddress
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? line1 = null,Object? line2 = null,Object? suburb = null,Object? state = null,Object? postcode = null,Object? country = null,}) {
  return _then(_self.copyWith(
line1: null == line1 ? _self.line1 : line1 // ignore: cast_nullable_to_non_nullable
as String,line2: null == line2 ? _self.line2 : line2 // ignore: cast_nullable_to_non_nullable
as String,suburb: null == suburb ? _self.suburb : suburb // ignore: cast_nullable_to_non_nullable
as String,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String,postcode: null == postcode ? _self.postcode : postcode // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SILAddress].
extension SILAddressPatterns on SILAddress {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SILAddress value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SILAddress() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SILAddress value)  $default,){
final _that = this;
switch (_that) {
case _SILAddress():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SILAddress value)?  $default,){
final _that = this;
switch (_that) {
case _SILAddress() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String line1,  String line2,  String suburb,  String state,  String postcode,  String country)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SILAddress() when $default != null:
return $default(_that.line1,_that.line2,_that.suburb,_that.state,_that.postcode,_that.country);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String line1,  String line2,  String suburb,  String state,  String postcode,  String country)  $default,) {final _that = this;
switch (_that) {
case _SILAddress():
return $default(_that.line1,_that.line2,_that.suburb,_that.state,_that.postcode,_that.country);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String line1,  String line2,  String suburb,  String state,  String postcode,  String country)?  $default,) {final _that = this;
switch (_that) {
case _SILAddress() when $default != null:
return $default(_that.line1,_that.line2,_that.suburb,_that.state,_that.postcode,_that.country);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SILAddress implements SILAddress {
  const _SILAddress({this.line1 = '', this.line2 = '', this.suburb = '', this.state = '', this.postcode = '', this.country = 'Australia'});
  factory _SILAddress.fromJson(Map<String, dynamic> json) => _$SILAddressFromJson(json);

@override@JsonKey() final  String line1;
@override@JsonKey() final  String line2;
@override@JsonKey() final  String suburb;
@override@JsonKey() final  String state;
@override@JsonKey() final  String postcode;
@override@JsonKey() final  String country;

/// Create a copy of SILAddress
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SILAddressCopyWith<_SILAddress> get copyWith => __$SILAddressCopyWithImpl<_SILAddress>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SILAddressToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SILAddress&&(identical(other.line1, line1) || other.line1 == line1)&&(identical(other.line2, line2) || other.line2 == line2)&&(identical(other.suburb, suburb) || other.suburb == suburb)&&(identical(other.state, state) || other.state == state)&&(identical(other.postcode, postcode) || other.postcode == postcode)&&(identical(other.country, country) || other.country == country));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,line1,line2,suburb,state,postcode,country);

@override
String toString() {
  return 'SILAddress(line1: $line1, line2: $line2, suburb: $suburb, state: $state, postcode: $postcode, country: $country)';
}


}

/// @nodoc
abstract mixin class _$SILAddressCopyWith<$Res> implements $SILAddressCopyWith<$Res> {
  factory _$SILAddressCopyWith(_SILAddress value, $Res Function(_SILAddress) _then) = __$SILAddressCopyWithImpl;
@override @useResult
$Res call({
 String line1, String line2, String suburb, String state, String postcode, String country
});




}
/// @nodoc
class __$SILAddressCopyWithImpl<$Res>
    implements _$SILAddressCopyWith<$Res> {
  __$SILAddressCopyWithImpl(this._self, this._then);

  final _SILAddress _self;
  final $Res Function(_SILAddress) _then;

/// Create a copy of SILAddress
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? line1 = null,Object? line2 = null,Object? suburb = null,Object? state = null,Object? postcode = null,Object? country = null,}) {
  return _then(_SILAddress(
line1: null == line1 ? _self.line1 : line1 // ignore: cast_nullable_to_non_nullable
as String,line2: null == line2 ? _self.line2 : line2 // ignore: cast_nullable_to_non_nullable
as String,suburb: null == suburb ? _self.suburb : suburb // ignore: cast_nullable_to_non_nullable
as String,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String,postcode: null == postcode ? _self.postcode : postcode // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$SILRoom {

 String get roomId; String get label; bool get vacant; List<String> get accessibility;
/// Create a copy of SILRoom
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SILRoomCopyWith<SILRoom> get copyWith => _$SILRoomCopyWithImpl<SILRoom>(this as SILRoom, _$identity);

  /// Serializes this SILRoom to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SILRoom&&(identical(other.roomId, roomId) || other.roomId == roomId)&&(identical(other.label, label) || other.label == label)&&(identical(other.vacant, vacant) || other.vacant == vacant)&&const DeepCollectionEquality().equals(other.accessibility, accessibility));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,roomId,label,vacant,const DeepCollectionEquality().hash(accessibility));

@override
String toString() {
  return 'SILRoom(roomId: $roomId, label: $label, vacant: $vacant, accessibility: $accessibility)';
}


}

/// @nodoc
abstract mixin class $SILRoomCopyWith<$Res>  {
  factory $SILRoomCopyWith(SILRoom value, $Res Function(SILRoom) _then) = _$SILRoomCopyWithImpl;
@useResult
$Res call({
 String roomId, String label, bool vacant, List<String> accessibility
});




}
/// @nodoc
class _$SILRoomCopyWithImpl<$Res>
    implements $SILRoomCopyWith<$Res> {
  _$SILRoomCopyWithImpl(this._self, this._then);

  final SILRoom _self;
  final $Res Function(SILRoom) _then;

/// Create a copy of SILRoom
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? roomId = null,Object? label = null,Object? vacant = null,Object? accessibility = null,}) {
  return _then(_self.copyWith(
roomId: null == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,vacant: null == vacant ? _self.vacant : vacant // ignore: cast_nullable_to_non_nullable
as bool,accessibility: null == accessibility ? _self.accessibility : accessibility // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [SILRoom].
extension SILRoomPatterns on SILRoom {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SILRoom value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SILRoom() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SILRoom value)  $default,){
final _that = this;
switch (_that) {
case _SILRoom():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SILRoom value)?  $default,){
final _that = this;
switch (_that) {
case _SILRoom() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String roomId,  String label,  bool vacant,  List<String> accessibility)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SILRoom() when $default != null:
return $default(_that.roomId,_that.label,_that.vacant,_that.accessibility);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String roomId,  String label,  bool vacant,  List<String> accessibility)  $default,) {final _that = this;
switch (_that) {
case _SILRoom():
return $default(_that.roomId,_that.label,_that.vacant,_that.accessibility);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String roomId,  String label,  bool vacant,  List<String> accessibility)?  $default,) {final _that = this;
switch (_that) {
case _SILRoom() when $default != null:
return $default(_that.roomId,_that.label,_that.vacant,_that.accessibility);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SILRoom implements SILRoom {
  const _SILRoom({required this.roomId, this.label = '', this.vacant = true, final  List<String> accessibility = const <String>[]}): _accessibility = accessibility;
  factory _SILRoom.fromJson(Map<String, dynamic> json) => _$SILRoomFromJson(json);

@override final  String roomId;
@override@JsonKey() final  String label;
@override@JsonKey() final  bool vacant;
 final  List<String> _accessibility;
@override@JsonKey() List<String> get accessibility {
  if (_accessibility is EqualUnmodifiableListView) return _accessibility;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_accessibility);
}


/// Create a copy of SILRoom
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SILRoomCopyWith<_SILRoom> get copyWith => __$SILRoomCopyWithImpl<_SILRoom>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SILRoomToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SILRoom&&(identical(other.roomId, roomId) || other.roomId == roomId)&&(identical(other.label, label) || other.label == label)&&(identical(other.vacant, vacant) || other.vacant == vacant)&&const DeepCollectionEquality().equals(other._accessibility, _accessibility));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,roomId,label,vacant,const DeepCollectionEquality().hash(_accessibility));

@override
String toString() {
  return 'SILRoom(roomId: $roomId, label: $label, vacant: $vacant, accessibility: $accessibility)';
}


}

/// @nodoc
abstract mixin class _$SILRoomCopyWith<$Res> implements $SILRoomCopyWith<$Res> {
  factory _$SILRoomCopyWith(_SILRoom value, $Res Function(_SILRoom) _then) = __$SILRoomCopyWithImpl;
@override @useResult
$Res call({
 String roomId, String label, bool vacant, List<String> accessibility
});




}
/// @nodoc
class __$SILRoomCopyWithImpl<$Res>
    implements _$SILRoomCopyWith<$Res> {
  __$SILRoomCopyWithImpl(this._self, this._then);

  final _SILRoom _self;
  final $Res Function(_SILRoom) _then;

/// Create a copy of SILRoom
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? roomId = null,Object? label = null,Object? vacant = null,Object? accessibility = null,}) {
  return _then(_SILRoom(
roomId: null == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,vacant: null == vacant ? _self.vacant : vacant // ignore: cast_nullable_to_non_nullable
as bool,accessibility: null == accessibility ? _self._accessibility : accessibility // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$SILProperty {

 String get id; String get name; String get reference; String get propertyType; String get silDesignCategory; int get bedrooms; int get maxOccupancy; bool get active; List<SILRoom> get rooms; List<String> get amenities; SILAddress? get address;
/// Create a copy of SILProperty
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SILPropertyCopyWith<SILProperty> get copyWith => _$SILPropertyCopyWithImpl<SILProperty>(this as SILProperty, _$identity);

  /// Serializes this SILProperty to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SILProperty&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.reference, reference) || other.reference == reference)&&(identical(other.propertyType, propertyType) || other.propertyType == propertyType)&&(identical(other.silDesignCategory, silDesignCategory) || other.silDesignCategory == silDesignCategory)&&(identical(other.bedrooms, bedrooms) || other.bedrooms == bedrooms)&&(identical(other.maxOccupancy, maxOccupancy) || other.maxOccupancy == maxOccupancy)&&(identical(other.active, active) || other.active == active)&&const DeepCollectionEquality().equals(other.rooms, rooms)&&const DeepCollectionEquality().equals(other.amenities, amenities)&&(identical(other.address, address) || other.address == address));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,reference,propertyType,silDesignCategory,bedrooms,maxOccupancy,active,const DeepCollectionEquality().hash(rooms),const DeepCollectionEquality().hash(amenities),address);

@override
String toString() {
  return 'SILProperty(id: $id, name: $name, reference: $reference, propertyType: $propertyType, silDesignCategory: $silDesignCategory, bedrooms: $bedrooms, maxOccupancy: $maxOccupancy, active: $active, rooms: $rooms, amenities: $amenities, address: $address)';
}


}

/// @nodoc
abstract mixin class $SILPropertyCopyWith<$Res>  {
  factory $SILPropertyCopyWith(SILProperty value, $Res Function(SILProperty) _then) = _$SILPropertyCopyWithImpl;
@useResult
$Res call({
 String id, String name, String reference, String propertyType, String silDesignCategory, int bedrooms, int maxOccupancy, bool active, List<SILRoom> rooms, List<String> amenities, SILAddress? address
});


$SILAddressCopyWith<$Res>? get address;

}
/// @nodoc
class _$SILPropertyCopyWithImpl<$Res>
    implements $SILPropertyCopyWith<$Res> {
  _$SILPropertyCopyWithImpl(this._self, this._then);

  final SILProperty _self;
  final $Res Function(SILProperty) _then;

/// Create a copy of SILProperty
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? reference = null,Object? propertyType = null,Object? silDesignCategory = null,Object? bedrooms = null,Object? maxOccupancy = null,Object? active = null,Object? rooms = null,Object? amenities = null,Object? address = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,reference: null == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String,propertyType: null == propertyType ? _self.propertyType : propertyType // ignore: cast_nullable_to_non_nullable
as String,silDesignCategory: null == silDesignCategory ? _self.silDesignCategory : silDesignCategory // ignore: cast_nullable_to_non_nullable
as String,bedrooms: null == bedrooms ? _self.bedrooms : bedrooms // ignore: cast_nullable_to_non_nullable
as int,maxOccupancy: null == maxOccupancy ? _self.maxOccupancy : maxOccupancy // ignore: cast_nullable_to_non_nullable
as int,active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool,rooms: null == rooms ? _self.rooms : rooms // ignore: cast_nullable_to_non_nullable
as List<SILRoom>,amenities: null == amenities ? _self.amenities : amenities // ignore: cast_nullable_to_non_nullable
as List<String>,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as SILAddress?,
  ));
}
/// Create a copy of SILProperty
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SILAddressCopyWith<$Res>? get address {
    if (_self.address == null) {
    return null;
  }

  return $SILAddressCopyWith<$Res>(_self.address!, (value) {
    return _then(_self.copyWith(address: value));
  });
}
}


/// Adds pattern-matching-related methods to [SILProperty].
extension SILPropertyPatterns on SILProperty {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SILProperty value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SILProperty() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SILProperty value)  $default,){
final _that = this;
switch (_that) {
case _SILProperty():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SILProperty value)?  $default,){
final _that = this;
switch (_that) {
case _SILProperty() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String reference,  String propertyType,  String silDesignCategory,  int bedrooms,  int maxOccupancy,  bool active,  List<SILRoom> rooms,  List<String> amenities,  SILAddress? address)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SILProperty() when $default != null:
return $default(_that.id,_that.name,_that.reference,_that.propertyType,_that.silDesignCategory,_that.bedrooms,_that.maxOccupancy,_that.active,_that.rooms,_that.amenities,_that.address);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String reference,  String propertyType,  String silDesignCategory,  int bedrooms,  int maxOccupancy,  bool active,  List<SILRoom> rooms,  List<String> amenities,  SILAddress? address)  $default,) {final _that = this;
switch (_that) {
case _SILProperty():
return $default(_that.id,_that.name,_that.reference,_that.propertyType,_that.silDesignCategory,_that.bedrooms,_that.maxOccupancy,_that.active,_that.rooms,_that.amenities,_that.address);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String reference,  String propertyType,  String silDesignCategory,  int bedrooms,  int maxOccupancy,  bool active,  List<SILRoom> rooms,  List<String> amenities,  SILAddress? address)?  $default,) {final _that = this;
switch (_that) {
case _SILProperty() when $default != null:
return $default(_that.id,_that.name,_that.reference,_that.propertyType,_that.silDesignCategory,_that.bedrooms,_that.maxOccupancy,_that.active,_that.rooms,_that.amenities,_that.address);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SILProperty implements SILProperty {
  const _SILProperty({required this.id, required this.name, this.reference = '', this.propertyType = 'house', this.silDesignCategory = 'basic', this.bedrooms = 0, this.maxOccupancy = 0, this.active = true, final  List<SILRoom> rooms = const <SILRoom>[], final  List<String> amenities = const <String>[], this.address}): _rooms = rooms,_amenities = amenities;
  factory _SILProperty.fromJson(Map<String, dynamic> json) => _$SILPropertyFromJson(json);

@override final  String id;
@override final  String name;
@override@JsonKey() final  String reference;
@override@JsonKey() final  String propertyType;
@override@JsonKey() final  String silDesignCategory;
@override@JsonKey() final  int bedrooms;
@override@JsonKey() final  int maxOccupancy;
@override@JsonKey() final  bool active;
 final  List<SILRoom> _rooms;
@override@JsonKey() List<SILRoom> get rooms {
  if (_rooms is EqualUnmodifiableListView) return _rooms;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rooms);
}

 final  List<String> _amenities;
@override@JsonKey() List<String> get amenities {
  if (_amenities is EqualUnmodifiableListView) return _amenities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_amenities);
}

@override final  SILAddress? address;

/// Create a copy of SILProperty
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SILPropertyCopyWith<_SILProperty> get copyWith => __$SILPropertyCopyWithImpl<_SILProperty>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SILPropertyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SILProperty&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.reference, reference) || other.reference == reference)&&(identical(other.propertyType, propertyType) || other.propertyType == propertyType)&&(identical(other.silDesignCategory, silDesignCategory) || other.silDesignCategory == silDesignCategory)&&(identical(other.bedrooms, bedrooms) || other.bedrooms == bedrooms)&&(identical(other.maxOccupancy, maxOccupancy) || other.maxOccupancy == maxOccupancy)&&(identical(other.active, active) || other.active == active)&&const DeepCollectionEquality().equals(other._rooms, _rooms)&&const DeepCollectionEquality().equals(other._amenities, _amenities)&&(identical(other.address, address) || other.address == address));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,reference,propertyType,silDesignCategory,bedrooms,maxOccupancy,active,const DeepCollectionEquality().hash(_rooms),const DeepCollectionEquality().hash(_amenities),address);

@override
String toString() {
  return 'SILProperty(id: $id, name: $name, reference: $reference, propertyType: $propertyType, silDesignCategory: $silDesignCategory, bedrooms: $bedrooms, maxOccupancy: $maxOccupancy, active: $active, rooms: $rooms, amenities: $amenities, address: $address)';
}


}

/// @nodoc
abstract mixin class _$SILPropertyCopyWith<$Res> implements $SILPropertyCopyWith<$Res> {
  factory _$SILPropertyCopyWith(_SILProperty value, $Res Function(_SILProperty) _then) = __$SILPropertyCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String reference, String propertyType, String silDesignCategory, int bedrooms, int maxOccupancy, bool active, List<SILRoom> rooms, List<String> amenities, SILAddress? address
});


@override $SILAddressCopyWith<$Res>? get address;

}
/// @nodoc
class __$SILPropertyCopyWithImpl<$Res>
    implements _$SILPropertyCopyWith<$Res> {
  __$SILPropertyCopyWithImpl(this._self, this._then);

  final _SILProperty _self;
  final $Res Function(_SILProperty) _then;

/// Create a copy of SILProperty
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? reference = null,Object? propertyType = null,Object? silDesignCategory = null,Object? bedrooms = null,Object? maxOccupancy = null,Object? active = null,Object? rooms = null,Object? amenities = null,Object? address = freezed,}) {
  return _then(_SILProperty(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,reference: null == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String,propertyType: null == propertyType ? _self.propertyType : propertyType // ignore: cast_nullable_to_non_nullable
as String,silDesignCategory: null == silDesignCategory ? _self.silDesignCategory : silDesignCategory // ignore: cast_nullable_to_non_nullable
as String,bedrooms: null == bedrooms ? _self.bedrooms : bedrooms // ignore: cast_nullable_to_non_nullable
as int,maxOccupancy: null == maxOccupancy ? _self.maxOccupancy : maxOccupancy // ignore: cast_nullable_to_non_nullable
as int,active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool,rooms: null == rooms ? _self._rooms : rooms // ignore: cast_nullable_to_non_nullable
as List<SILRoom>,amenities: null == amenities ? _self._amenities : amenities // ignore: cast_nullable_to_non_nullable
as List<String>,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as SILAddress?,
  ));
}

/// Create a copy of SILProperty
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SILAddressCopyWith<$Res>? get address {
    if (_self.address == null) {
    return null;
  }

  return $SILAddressCopyWith<$Res>(_self.address!, (value) {
    return _then(_self.copyWith(address: value));
  });
}
}


/// @nodoc
mixin _$SILOccupancy {

 String get id; String get propertyId; String get roomId; String get clientId; String get status; String get fundingType; String? get startDate; String? get endDate;
/// Create a copy of SILOccupancy
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SILOccupancyCopyWith<SILOccupancy> get copyWith => _$SILOccupancyCopyWithImpl<SILOccupancy>(this as SILOccupancy, _$identity);

  /// Serializes this SILOccupancy to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SILOccupancy&&(identical(other.id, id) || other.id == id)&&(identical(other.propertyId, propertyId) || other.propertyId == propertyId)&&(identical(other.roomId, roomId) || other.roomId == roomId)&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.status, status) || other.status == status)&&(identical(other.fundingType, fundingType) || other.fundingType == fundingType)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,propertyId,roomId,clientId,status,fundingType,startDate,endDate);

@override
String toString() {
  return 'SILOccupancy(id: $id, propertyId: $propertyId, roomId: $roomId, clientId: $clientId, status: $status, fundingType: $fundingType, startDate: $startDate, endDate: $endDate)';
}


}

/// @nodoc
abstract mixin class $SILOccupancyCopyWith<$Res>  {
  factory $SILOccupancyCopyWith(SILOccupancy value, $Res Function(SILOccupancy) _then) = _$SILOccupancyCopyWithImpl;
@useResult
$Res call({
 String id, String propertyId, String roomId, String clientId, String status, String fundingType, String? startDate, String? endDate
});




}
/// @nodoc
class _$SILOccupancyCopyWithImpl<$Res>
    implements $SILOccupancyCopyWith<$Res> {
  _$SILOccupancyCopyWithImpl(this._self, this._then);

  final SILOccupancy _self;
  final $Res Function(SILOccupancy) _then;

/// Create a copy of SILOccupancy
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? propertyId = null,Object? roomId = null,Object? clientId = null,Object? status = null,Object? fundingType = null,Object? startDate = freezed,Object? endDate = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,propertyId: null == propertyId ? _self.propertyId : propertyId // ignore: cast_nullable_to_non_nullable
as String,roomId: null == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as String,clientId: null == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,fundingType: null == fundingType ? _self.fundingType : fundingType // ignore: cast_nullable_to_non_nullable
as String,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SILOccupancy].
extension SILOccupancyPatterns on SILOccupancy {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SILOccupancy value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SILOccupancy() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SILOccupancy value)  $default,){
final _that = this;
switch (_that) {
case _SILOccupancy():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SILOccupancy value)?  $default,){
final _that = this;
switch (_that) {
case _SILOccupancy() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String propertyId,  String roomId,  String clientId,  String status,  String fundingType,  String? startDate,  String? endDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SILOccupancy() when $default != null:
return $default(_that.id,_that.propertyId,_that.roomId,_that.clientId,_that.status,_that.fundingType,_that.startDate,_that.endDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String propertyId,  String roomId,  String clientId,  String status,  String fundingType,  String? startDate,  String? endDate)  $default,) {final _that = this;
switch (_that) {
case _SILOccupancy():
return $default(_that.id,_that.propertyId,_that.roomId,_that.clientId,_that.status,_that.fundingType,_that.startDate,_that.endDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String propertyId,  String roomId,  String clientId,  String status,  String fundingType,  String? startDate,  String? endDate)?  $default,) {final _that = this;
switch (_that) {
case _SILOccupancy() when $default != null:
return $default(_that.id,_that.propertyId,_that.roomId,_that.clientId,_that.status,_that.fundingType,_that.startDate,_that.endDate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SILOccupancy implements SILOccupancy {
  const _SILOccupancy({required this.id, required this.propertyId, required this.roomId, required this.clientId, this.status = 'active', this.fundingType = 'plan_managed', this.startDate, this.endDate});
  factory _SILOccupancy.fromJson(Map<String, dynamic> json) => _$SILOccupancyFromJson(json);

@override final  String id;
@override final  String propertyId;
@override final  String roomId;
@override final  String clientId;
@override@JsonKey() final  String status;
@override@JsonKey() final  String fundingType;
@override final  String? startDate;
@override final  String? endDate;

/// Create a copy of SILOccupancy
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SILOccupancyCopyWith<_SILOccupancy> get copyWith => __$SILOccupancyCopyWithImpl<_SILOccupancy>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SILOccupancyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SILOccupancy&&(identical(other.id, id) || other.id == id)&&(identical(other.propertyId, propertyId) || other.propertyId == propertyId)&&(identical(other.roomId, roomId) || other.roomId == roomId)&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.status, status) || other.status == status)&&(identical(other.fundingType, fundingType) || other.fundingType == fundingType)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,propertyId,roomId,clientId,status,fundingType,startDate,endDate);

@override
String toString() {
  return 'SILOccupancy(id: $id, propertyId: $propertyId, roomId: $roomId, clientId: $clientId, status: $status, fundingType: $fundingType, startDate: $startDate, endDate: $endDate)';
}


}

/// @nodoc
abstract mixin class _$SILOccupancyCopyWith<$Res> implements $SILOccupancyCopyWith<$Res> {
  factory _$SILOccupancyCopyWith(_SILOccupancy value, $Res Function(_SILOccupancy) _then) = __$SILOccupancyCopyWithImpl;
@override @useResult
$Res call({
 String id, String propertyId, String roomId, String clientId, String status, String fundingType, String? startDate, String? endDate
});




}
/// @nodoc
class __$SILOccupancyCopyWithImpl<$Res>
    implements _$SILOccupancyCopyWith<$Res> {
  __$SILOccupancyCopyWithImpl(this._self, this._then);

  final _SILOccupancy _self;
  final $Res Function(_SILOccupancy) _then;

/// Create a copy of SILOccupancy
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? propertyId = null,Object? roomId = null,Object? clientId = null,Object? status = null,Object? fundingType = null,Object? startDate = freezed,Object? endDate = freezed,}) {
  return _then(_SILOccupancy(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,propertyId: null == propertyId ? _self.propertyId : propertyId // ignore: cast_nullable_to_non_nullable
as String,roomId: null == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as String,clientId: null == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,fundingType: null == fundingType ? _self.fundingType : fundingType // ignore: cast_nullable_to_non_nullable
as String,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$SILVacancyRoom {

 String get roomId; String get label; bool get occupied; List<String> get accessibility;
/// Create a copy of SILVacancyRoom
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SILVacancyRoomCopyWith<SILVacancyRoom> get copyWith => _$SILVacancyRoomCopyWithImpl<SILVacancyRoom>(this as SILVacancyRoom, _$identity);

  /// Serializes this SILVacancyRoom to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SILVacancyRoom&&(identical(other.roomId, roomId) || other.roomId == roomId)&&(identical(other.label, label) || other.label == label)&&(identical(other.occupied, occupied) || other.occupied == occupied)&&const DeepCollectionEquality().equals(other.accessibility, accessibility));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,roomId,label,occupied,const DeepCollectionEquality().hash(accessibility));

@override
String toString() {
  return 'SILVacancyRoom(roomId: $roomId, label: $label, occupied: $occupied, accessibility: $accessibility)';
}


}

/// @nodoc
abstract mixin class $SILVacancyRoomCopyWith<$Res>  {
  factory $SILVacancyRoomCopyWith(SILVacancyRoom value, $Res Function(SILVacancyRoom) _then) = _$SILVacancyRoomCopyWithImpl;
@useResult
$Res call({
 String roomId, String label, bool occupied, List<String> accessibility
});




}
/// @nodoc
class _$SILVacancyRoomCopyWithImpl<$Res>
    implements $SILVacancyRoomCopyWith<$Res> {
  _$SILVacancyRoomCopyWithImpl(this._self, this._then);

  final SILVacancyRoom _self;
  final $Res Function(SILVacancyRoom) _then;

/// Create a copy of SILVacancyRoom
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? roomId = null,Object? label = null,Object? occupied = null,Object? accessibility = null,}) {
  return _then(_self.copyWith(
roomId: null == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,occupied: null == occupied ? _self.occupied : occupied // ignore: cast_nullable_to_non_nullable
as bool,accessibility: null == accessibility ? _self.accessibility : accessibility // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [SILVacancyRoom].
extension SILVacancyRoomPatterns on SILVacancyRoom {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SILVacancyRoom value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SILVacancyRoom() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SILVacancyRoom value)  $default,){
final _that = this;
switch (_that) {
case _SILVacancyRoom():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SILVacancyRoom value)?  $default,){
final _that = this;
switch (_that) {
case _SILVacancyRoom() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String roomId,  String label,  bool occupied,  List<String> accessibility)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SILVacancyRoom() when $default != null:
return $default(_that.roomId,_that.label,_that.occupied,_that.accessibility);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String roomId,  String label,  bool occupied,  List<String> accessibility)  $default,) {final _that = this;
switch (_that) {
case _SILVacancyRoom():
return $default(_that.roomId,_that.label,_that.occupied,_that.accessibility);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String roomId,  String label,  bool occupied,  List<String> accessibility)?  $default,) {final _that = this;
switch (_that) {
case _SILVacancyRoom() when $default != null:
return $default(_that.roomId,_that.label,_that.occupied,_that.accessibility);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SILVacancyRoom implements SILVacancyRoom {
  const _SILVacancyRoom({required this.roomId, this.label = '', this.occupied = false, final  List<String> accessibility = const <String>[]}): _accessibility = accessibility;
  factory _SILVacancyRoom.fromJson(Map<String, dynamic> json) => _$SILVacancyRoomFromJson(json);

@override final  String roomId;
@override@JsonKey() final  String label;
@override@JsonKey() final  bool occupied;
 final  List<String> _accessibility;
@override@JsonKey() List<String> get accessibility {
  if (_accessibility is EqualUnmodifiableListView) return _accessibility;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_accessibility);
}


/// Create a copy of SILVacancyRoom
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SILVacancyRoomCopyWith<_SILVacancyRoom> get copyWith => __$SILVacancyRoomCopyWithImpl<_SILVacancyRoom>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SILVacancyRoomToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SILVacancyRoom&&(identical(other.roomId, roomId) || other.roomId == roomId)&&(identical(other.label, label) || other.label == label)&&(identical(other.occupied, occupied) || other.occupied == occupied)&&const DeepCollectionEquality().equals(other._accessibility, _accessibility));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,roomId,label,occupied,const DeepCollectionEquality().hash(_accessibility));

@override
String toString() {
  return 'SILVacancyRoom(roomId: $roomId, label: $label, occupied: $occupied, accessibility: $accessibility)';
}


}

/// @nodoc
abstract mixin class _$SILVacancyRoomCopyWith<$Res> implements $SILVacancyRoomCopyWith<$Res> {
  factory _$SILVacancyRoomCopyWith(_SILVacancyRoom value, $Res Function(_SILVacancyRoom) _then) = __$SILVacancyRoomCopyWithImpl;
@override @useResult
$Res call({
 String roomId, String label, bool occupied, List<String> accessibility
});




}
/// @nodoc
class __$SILVacancyRoomCopyWithImpl<$Res>
    implements _$SILVacancyRoomCopyWith<$Res> {
  __$SILVacancyRoomCopyWithImpl(this._self, this._then);

  final _SILVacancyRoom _self;
  final $Res Function(_SILVacancyRoom) _then;

/// Create a copy of SILVacancyRoom
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? roomId = null,Object? label = null,Object? occupied = null,Object? accessibility = null,}) {
  return _then(_SILVacancyRoom(
roomId: null == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,occupied: null == occupied ? _self.occupied : occupied // ignore: cast_nullable_to_non_nullable
as bool,accessibility: null == accessibility ? _self._accessibility : accessibility // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$SILVacancyBoard {

 String get propertyId; String get propertyName; int get totalRooms; int get occupiedCount; int get vacantCount; List<SILVacancyRoom> get rooms;
/// Create a copy of SILVacancyBoard
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SILVacancyBoardCopyWith<SILVacancyBoard> get copyWith => _$SILVacancyBoardCopyWithImpl<SILVacancyBoard>(this as SILVacancyBoard, _$identity);

  /// Serializes this SILVacancyBoard to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SILVacancyBoard&&(identical(other.propertyId, propertyId) || other.propertyId == propertyId)&&(identical(other.propertyName, propertyName) || other.propertyName == propertyName)&&(identical(other.totalRooms, totalRooms) || other.totalRooms == totalRooms)&&(identical(other.occupiedCount, occupiedCount) || other.occupiedCount == occupiedCount)&&(identical(other.vacantCount, vacantCount) || other.vacantCount == vacantCount)&&const DeepCollectionEquality().equals(other.rooms, rooms));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,propertyId,propertyName,totalRooms,occupiedCount,vacantCount,const DeepCollectionEquality().hash(rooms));

@override
String toString() {
  return 'SILVacancyBoard(propertyId: $propertyId, propertyName: $propertyName, totalRooms: $totalRooms, occupiedCount: $occupiedCount, vacantCount: $vacantCount, rooms: $rooms)';
}


}

/// @nodoc
abstract mixin class $SILVacancyBoardCopyWith<$Res>  {
  factory $SILVacancyBoardCopyWith(SILVacancyBoard value, $Res Function(SILVacancyBoard) _then) = _$SILVacancyBoardCopyWithImpl;
@useResult
$Res call({
 String propertyId, String propertyName, int totalRooms, int occupiedCount, int vacantCount, List<SILVacancyRoom> rooms
});




}
/// @nodoc
class _$SILVacancyBoardCopyWithImpl<$Res>
    implements $SILVacancyBoardCopyWith<$Res> {
  _$SILVacancyBoardCopyWithImpl(this._self, this._then);

  final SILVacancyBoard _self;
  final $Res Function(SILVacancyBoard) _then;

/// Create a copy of SILVacancyBoard
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? propertyId = null,Object? propertyName = null,Object? totalRooms = null,Object? occupiedCount = null,Object? vacantCount = null,Object? rooms = null,}) {
  return _then(_self.copyWith(
propertyId: null == propertyId ? _self.propertyId : propertyId // ignore: cast_nullable_to_non_nullable
as String,propertyName: null == propertyName ? _self.propertyName : propertyName // ignore: cast_nullable_to_non_nullable
as String,totalRooms: null == totalRooms ? _self.totalRooms : totalRooms // ignore: cast_nullable_to_non_nullable
as int,occupiedCount: null == occupiedCount ? _self.occupiedCount : occupiedCount // ignore: cast_nullable_to_non_nullable
as int,vacantCount: null == vacantCount ? _self.vacantCount : vacantCount // ignore: cast_nullable_to_non_nullable
as int,rooms: null == rooms ? _self.rooms : rooms // ignore: cast_nullable_to_non_nullable
as List<SILVacancyRoom>,
  ));
}

}


/// Adds pattern-matching-related methods to [SILVacancyBoard].
extension SILVacancyBoardPatterns on SILVacancyBoard {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SILVacancyBoard value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SILVacancyBoard() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SILVacancyBoard value)  $default,){
final _that = this;
switch (_that) {
case _SILVacancyBoard():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SILVacancyBoard value)?  $default,){
final _that = this;
switch (_that) {
case _SILVacancyBoard() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String propertyId,  String propertyName,  int totalRooms,  int occupiedCount,  int vacantCount,  List<SILVacancyRoom> rooms)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SILVacancyBoard() when $default != null:
return $default(_that.propertyId,_that.propertyName,_that.totalRooms,_that.occupiedCount,_that.vacantCount,_that.rooms);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String propertyId,  String propertyName,  int totalRooms,  int occupiedCount,  int vacantCount,  List<SILVacancyRoom> rooms)  $default,) {final _that = this;
switch (_that) {
case _SILVacancyBoard():
return $default(_that.propertyId,_that.propertyName,_that.totalRooms,_that.occupiedCount,_that.vacantCount,_that.rooms);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String propertyId,  String propertyName,  int totalRooms,  int occupiedCount,  int vacantCount,  List<SILVacancyRoom> rooms)?  $default,) {final _that = this;
switch (_that) {
case _SILVacancyBoard() when $default != null:
return $default(_that.propertyId,_that.propertyName,_that.totalRooms,_that.occupiedCount,_that.vacantCount,_that.rooms);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SILVacancyBoard implements SILVacancyBoard {
  const _SILVacancyBoard({required this.propertyId, this.propertyName = '', this.totalRooms = 0, this.occupiedCount = 0, this.vacantCount = 0, final  List<SILVacancyRoom> rooms = const <SILVacancyRoom>[]}): _rooms = rooms;
  factory _SILVacancyBoard.fromJson(Map<String, dynamic> json) => _$SILVacancyBoardFromJson(json);

@override final  String propertyId;
@override@JsonKey() final  String propertyName;
@override@JsonKey() final  int totalRooms;
@override@JsonKey() final  int occupiedCount;
@override@JsonKey() final  int vacantCount;
 final  List<SILVacancyRoom> _rooms;
@override@JsonKey() List<SILVacancyRoom> get rooms {
  if (_rooms is EqualUnmodifiableListView) return _rooms;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rooms);
}


/// Create a copy of SILVacancyBoard
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SILVacancyBoardCopyWith<_SILVacancyBoard> get copyWith => __$SILVacancyBoardCopyWithImpl<_SILVacancyBoard>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SILVacancyBoardToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SILVacancyBoard&&(identical(other.propertyId, propertyId) || other.propertyId == propertyId)&&(identical(other.propertyName, propertyName) || other.propertyName == propertyName)&&(identical(other.totalRooms, totalRooms) || other.totalRooms == totalRooms)&&(identical(other.occupiedCount, occupiedCount) || other.occupiedCount == occupiedCount)&&(identical(other.vacantCount, vacantCount) || other.vacantCount == vacantCount)&&const DeepCollectionEquality().equals(other._rooms, _rooms));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,propertyId,propertyName,totalRooms,occupiedCount,vacantCount,const DeepCollectionEquality().hash(_rooms));

@override
String toString() {
  return 'SILVacancyBoard(propertyId: $propertyId, propertyName: $propertyName, totalRooms: $totalRooms, occupiedCount: $occupiedCount, vacantCount: $vacantCount, rooms: $rooms)';
}


}

/// @nodoc
abstract mixin class _$SILVacancyBoardCopyWith<$Res> implements $SILVacancyBoardCopyWith<$Res> {
  factory _$SILVacancyBoardCopyWith(_SILVacancyBoard value, $Res Function(_SILVacancyBoard) _then) = __$SILVacancyBoardCopyWithImpl;
@override @useResult
$Res call({
 String propertyId, String propertyName, int totalRooms, int occupiedCount, int vacantCount, List<SILVacancyRoom> rooms
});




}
/// @nodoc
class __$SILVacancyBoardCopyWithImpl<$Res>
    implements _$SILVacancyBoardCopyWith<$Res> {
  __$SILVacancyBoardCopyWithImpl(this._self, this._then);

  final _SILVacancyBoard _self;
  final $Res Function(_SILVacancyBoard) _then;

/// Create a copy of SILVacancyBoard
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? propertyId = null,Object? propertyName = null,Object? totalRooms = null,Object? occupiedCount = null,Object? vacantCount = null,Object? rooms = null,}) {
  return _then(_SILVacancyBoard(
propertyId: null == propertyId ? _self.propertyId : propertyId // ignore: cast_nullable_to_non_nullable
as String,propertyName: null == propertyName ? _self.propertyName : propertyName // ignore: cast_nullable_to_non_nullable
as String,totalRooms: null == totalRooms ? _self.totalRooms : totalRooms // ignore: cast_nullable_to_non_nullable
as int,occupiedCount: null == occupiedCount ? _self.occupiedCount : occupiedCount // ignore: cast_nullable_to_non_nullable
as int,vacantCount: null == vacantCount ? _self.vacantCount : vacantCount // ignore: cast_nullable_to_non_nullable
as int,rooms: null == rooms ? _self._rooms : rooms // ignore: cast_nullable_to_non_nullable
as List<SILVacancyRoom>,
  ));
}


}


/// @nodoc
mixin _$SILRatioValue {

 int get staff; int get participants;
/// Create a copy of SILRatioValue
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SILRatioValueCopyWith<SILRatioValue> get copyWith => _$SILRatioValueCopyWithImpl<SILRatioValue>(this as SILRatioValue, _$identity);

  /// Serializes this SILRatioValue to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SILRatioValue&&(identical(other.staff, staff) || other.staff == staff)&&(identical(other.participants, participants) || other.participants == participants));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,staff,participants);

@override
String toString() {
  return 'SILRatioValue(staff: $staff, participants: $participants)';
}


}

/// @nodoc
abstract mixin class $SILRatioValueCopyWith<$Res>  {
  factory $SILRatioValueCopyWith(SILRatioValue value, $Res Function(SILRatioValue) _then) = _$SILRatioValueCopyWithImpl;
@useResult
$Res call({
 int staff, int participants
});




}
/// @nodoc
class _$SILRatioValueCopyWithImpl<$Res>
    implements $SILRatioValueCopyWith<$Res> {
  _$SILRatioValueCopyWithImpl(this._self, this._then);

  final SILRatioValue _self;
  final $Res Function(SILRatioValue) _then;

/// Create a copy of SILRatioValue
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? staff = null,Object? participants = null,}) {
  return _then(_self.copyWith(
staff: null == staff ? _self.staff : staff // ignore: cast_nullable_to_non_nullable
as int,participants: null == participants ? _self.participants : participants // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SILRatioValue].
extension SILRatioValuePatterns on SILRatioValue {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SILRatioValue value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SILRatioValue() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SILRatioValue value)  $default,){
final _that = this;
switch (_that) {
case _SILRatioValue():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SILRatioValue value)?  $default,){
final _that = this;
switch (_that) {
case _SILRatioValue() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int staff,  int participants)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SILRatioValue() when $default != null:
return $default(_that.staff,_that.participants);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int staff,  int participants)  $default,) {final _that = this;
switch (_that) {
case _SILRatioValue():
return $default(_that.staff,_that.participants);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int staff,  int participants)?  $default,) {final _that = this;
switch (_that) {
case _SILRatioValue() when $default != null:
return $default(_that.staff,_that.participants);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SILRatioValue implements SILRatioValue {
  const _SILRatioValue({this.staff = 1, this.participants = 1});
  factory _SILRatioValue.fromJson(Map<String, dynamic> json) => _$SILRatioValueFromJson(json);

@override@JsonKey() final  int staff;
@override@JsonKey() final  int participants;

/// Create a copy of SILRatioValue
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SILRatioValueCopyWith<_SILRatioValue> get copyWith => __$SILRatioValueCopyWithImpl<_SILRatioValue>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SILRatioValueToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SILRatioValue&&(identical(other.staff, staff) || other.staff == staff)&&(identical(other.participants, participants) || other.participants == participants));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,staff,participants);

@override
String toString() {
  return 'SILRatioValue(staff: $staff, participants: $participants)';
}


}

/// @nodoc
abstract mixin class _$SILRatioValueCopyWith<$Res> implements $SILRatioValueCopyWith<$Res> {
  factory _$SILRatioValueCopyWith(_SILRatioValue value, $Res Function(_SILRatioValue) _then) = __$SILRatioValueCopyWithImpl;
@override @useResult
$Res call({
 int staff, int participants
});




}
/// @nodoc
class __$SILRatioValueCopyWithImpl<$Res>
    implements _$SILRatioValueCopyWith<$Res> {
  __$SILRatioValueCopyWithImpl(this._self, this._then);

  final _SILRatioValue _self;
  final $Res Function(_SILRatioValue) _then;

/// Create a copy of SILRatioValue
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? staff = null,Object? participants = null,}) {
  return _then(_SILRatioValue(
staff: null == staff ? _self.staff : staff // ignore: cast_nullable_to_non_nullable
as int,participants: null == participants ? _self.participants : participants // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$SILRatioRule {

 String get id; String get name; SILRatioValue get ratio; String get shiftType; int get minParticipants; int get maxParticipants; bool get isActive;
/// Create a copy of SILRatioRule
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SILRatioRuleCopyWith<SILRatioRule> get copyWith => _$SILRatioRuleCopyWithImpl<SILRatioRule>(this as SILRatioRule, _$identity);

  /// Serializes this SILRatioRule to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SILRatioRule&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.ratio, ratio) || other.ratio == ratio)&&(identical(other.shiftType, shiftType) || other.shiftType == shiftType)&&(identical(other.minParticipants, minParticipants) || other.minParticipants == minParticipants)&&(identical(other.maxParticipants, maxParticipants) || other.maxParticipants == maxParticipants)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,ratio,shiftType,minParticipants,maxParticipants,isActive);

@override
String toString() {
  return 'SILRatioRule(id: $id, name: $name, ratio: $ratio, shiftType: $shiftType, minParticipants: $minParticipants, maxParticipants: $maxParticipants, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class $SILRatioRuleCopyWith<$Res>  {
  factory $SILRatioRuleCopyWith(SILRatioRule value, $Res Function(SILRatioRule) _then) = _$SILRatioRuleCopyWithImpl;
@useResult
$Res call({
 String id, String name, SILRatioValue ratio, String shiftType, int minParticipants, int maxParticipants, bool isActive
});


$SILRatioValueCopyWith<$Res> get ratio;

}
/// @nodoc
class _$SILRatioRuleCopyWithImpl<$Res>
    implements $SILRatioRuleCopyWith<$Res> {
  _$SILRatioRuleCopyWithImpl(this._self, this._then);

  final SILRatioRule _self;
  final $Res Function(SILRatioRule) _then;

/// Create a copy of SILRatioRule
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? ratio = null,Object? shiftType = null,Object? minParticipants = null,Object? maxParticipants = null,Object? isActive = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,ratio: null == ratio ? _self.ratio : ratio // ignore: cast_nullable_to_non_nullable
as SILRatioValue,shiftType: null == shiftType ? _self.shiftType : shiftType // ignore: cast_nullable_to_non_nullable
as String,minParticipants: null == minParticipants ? _self.minParticipants : minParticipants // ignore: cast_nullable_to_non_nullable
as int,maxParticipants: null == maxParticipants ? _self.maxParticipants : maxParticipants // ignore: cast_nullable_to_non_nullable
as int,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of SILRatioRule
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SILRatioValueCopyWith<$Res> get ratio {
  
  return $SILRatioValueCopyWith<$Res>(_self.ratio, (value) {
    return _then(_self.copyWith(ratio: value));
  });
}
}


/// Adds pattern-matching-related methods to [SILRatioRule].
extension SILRatioRulePatterns on SILRatioRule {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SILRatioRule value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SILRatioRule() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SILRatioRule value)  $default,){
final _that = this;
switch (_that) {
case _SILRatioRule():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SILRatioRule value)?  $default,){
final _that = this;
switch (_that) {
case _SILRatioRule() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  SILRatioValue ratio,  String shiftType,  int minParticipants,  int maxParticipants,  bool isActive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SILRatioRule() when $default != null:
return $default(_that.id,_that.name,_that.ratio,_that.shiftType,_that.minParticipants,_that.maxParticipants,_that.isActive);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  SILRatioValue ratio,  String shiftType,  int minParticipants,  int maxParticipants,  bool isActive)  $default,) {final _that = this;
switch (_that) {
case _SILRatioRule():
return $default(_that.id,_that.name,_that.ratio,_that.shiftType,_that.minParticipants,_that.maxParticipants,_that.isActive);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  SILRatioValue ratio,  String shiftType,  int minParticipants,  int maxParticipants,  bool isActive)?  $default,) {final _that = this;
switch (_that) {
case _SILRatioRule() when $default != null:
return $default(_that.id,_that.name,_that.ratio,_that.shiftType,_that.minParticipants,_that.maxParticipants,_that.isActive);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SILRatioRule implements SILRatioRule {
  const _SILRatioRule({required this.id, required this.name, this.ratio = const SILRatioValue(), this.shiftType = 'day', this.minParticipants = 1, this.maxParticipants = 0, this.isActive = true});
  factory _SILRatioRule.fromJson(Map<String, dynamic> json) => _$SILRatioRuleFromJson(json);

@override final  String id;
@override final  String name;
@override@JsonKey() final  SILRatioValue ratio;
@override@JsonKey() final  String shiftType;
@override@JsonKey() final  int minParticipants;
@override@JsonKey() final  int maxParticipants;
@override@JsonKey() final  bool isActive;

/// Create a copy of SILRatioRule
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SILRatioRuleCopyWith<_SILRatioRule> get copyWith => __$SILRatioRuleCopyWithImpl<_SILRatioRule>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SILRatioRuleToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SILRatioRule&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.ratio, ratio) || other.ratio == ratio)&&(identical(other.shiftType, shiftType) || other.shiftType == shiftType)&&(identical(other.minParticipants, minParticipants) || other.minParticipants == minParticipants)&&(identical(other.maxParticipants, maxParticipants) || other.maxParticipants == maxParticipants)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,ratio,shiftType,minParticipants,maxParticipants,isActive);

@override
String toString() {
  return 'SILRatioRule(id: $id, name: $name, ratio: $ratio, shiftType: $shiftType, minParticipants: $minParticipants, maxParticipants: $maxParticipants, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class _$SILRatioRuleCopyWith<$Res> implements $SILRatioRuleCopyWith<$Res> {
  factory _$SILRatioRuleCopyWith(_SILRatioRule value, $Res Function(_SILRatioRule) _then) = __$SILRatioRuleCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, SILRatioValue ratio, String shiftType, int minParticipants, int maxParticipants, bool isActive
});


@override $SILRatioValueCopyWith<$Res> get ratio;

}
/// @nodoc
class __$SILRatioRuleCopyWithImpl<$Res>
    implements _$SILRatioRuleCopyWith<$Res> {
  __$SILRatioRuleCopyWithImpl(this._self, this._then);

  final _SILRatioRule _self;
  final $Res Function(_SILRatioRule) _then;

/// Create a copy of SILRatioRule
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? ratio = null,Object? shiftType = null,Object? minParticipants = null,Object? maxParticipants = null,Object? isActive = null,}) {
  return _then(_SILRatioRule(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,ratio: null == ratio ? _self.ratio : ratio // ignore: cast_nullable_to_non_nullable
as SILRatioValue,shiftType: null == shiftType ? _self.shiftType : shiftType // ignore: cast_nullable_to_non_nullable
as String,minParticipants: null == minParticipants ? _self.minParticipants : minParticipants // ignore: cast_nullable_to_non_nullable
as int,maxParticipants: null == maxParticipants ? _self.maxParticipants : maxParticipants // ignore: cast_nullable_to_non_nullable
as int,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of SILRatioRule
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SILRatioValueCopyWith<$Res> get ratio {
  
  return $SILRatioValueCopyWith<$Res>(_self.ratio, (value) {
    return _then(_self.copyWith(ratio: value));
  });
}
}


/// @nodoc
mixin _$SILRosterEntry {

 String? get shiftId; List<String> get clientIds; List<String> get staffUserIds; String get shiftType; int get requiredStaff; int get assignedStaff; String get compliance; String? get startTime; String? get endTime;
/// Create a copy of SILRosterEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SILRosterEntryCopyWith<SILRosterEntry> get copyWith => _$SILRosterEntryCopyWithImpl<SILRosterEntry>(this as SILRosterEntry, _$identity);

  /// Serializes this SILRosterEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SILRosterEntry&&(identical(other.shiftId, shiftId) || other.shiftId == shiftId)&&const DeepCollectionEquality().equals(other.clientIds, clientIds)&&const DeepCollectionEquality().equals(other.staffUserIds, staffUserIds)&&(identical(other.shiftType, shiftType) || other.shiftType == shiftType)&&(identical(other.requiredStaff, requiredStaff) || other.requiredStaff == requiredStaff)&&(identical(other.assignedStaff, assignedStaff) || other.assignedStaff == assignedStaff)&&(identical(other.compliance, compliance) || other.compliance == compliance)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,shiftId,const DeepCollectionEquality().hash(clientIds),const DeepCollectionEquality().hash(staffUserIds),shiftType,requiredStaff,assignedStaff,compliance,startTime,endTime);

@override
String toString() {
  return 'SILRosterEntry(shiftId: $shiftId, clientIds: $clientIds, staffUserIds: $staffUserIds, shiftType: $shiftType, requiredStaff: $requiredStaff, assignedStaff: $assignedStaff, compliance: $compliance, startTime: $startTime, endTime: $endTime)';
}


}

/// @nodoc
abstract mixin class $SILRosterEntryCopyWith<$Res>  {
  factory $SILRosterEntryCopyWith(SILRosterEntry value, $Res Function(SILRosterEntry) _then) = _$SILRosterEntryCopyWithImpl;
@useResult
$Res call({
 String? shiftId, List<String> clientIds, List<String> staffUserIds, String shiftType, int requiredStaff, int assignedStaff, String compliance, String? startTime, String? endTime
});




}
/// @nodoc
class _$SILRosterEntryCopyWithImpl<$Res>
    implements $SILRosterEntryCopyWith<$Res> {
  _$SILRosterEntryCopyWithImpl(this._self, this._then);

  final SILRosterEntry _self;
  final $Res Function(SILRosterEntry) _then;

/// Create a copy of SILRosterEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? shiftId = freezed,Object? clientIds = null,Object? staffUserIds = null,Object? shiftType = null,Object? requiredStaff = null,Object? assignedStaff = null,Object? compliance = null,Object? startTime = freezed,Object? endTime = freezed,}) {
  return _then(_self.copyWith(
shiftId: freezed == shiftId ? _self.shiftId : shiftId // ignore: cast_nullable_to_non_nullable
as String?,clientIds: null == clientIds ? _self.clientIds : clientIds // ignore: cast_nullable_to_non_nullable
as List<String>,staffUserIds: null == staffUserIds ? _self.staffUserIds : staffUserIds // ignore: cast_nullable_to_non_nullable
as List<String>,shiftType: null == shiftType ? _self.shiftType : shiftType // ignore: cast_nullable_to_non_nullable
as String,requiredStaff: null == requiredStaff ? _self.requiredStaff : requiredStaff // ignore: cast_nullable_to_non_nullable
as int,assignedStaff: null == assignedStaff ? _self.assignedStaff : assignedStaff // ignore: cast_nullable_to_non_nullable
as int,compliance: null == compliance ? _self.compliance : compliance // ignore: cast_nullable_to_non_nullable
as String,startTime: freezed == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as String?,endTime: freezed == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SILRosterEntry].
extension SILRosterEntryPatterns on SILRosterEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SILRosterEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SILRosterEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SILRosterEntry value)  $default,){
final _that = this;
switch (_that) {
case _SILRosterEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SILRosterEntry value)?  $default,){
final _that = this;
switch (_that) {
case _SILRosterEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? shiftId,  List<String> clientIds,  List<String> staffUserIds,  String shiftType,  int requiredStaff,  int assignedStaff,  String compliance,  String? startTime,  String? endTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SILRosterEntry() when $default != null:
return $default(_that.shiftId,_that.clientIds,_that.staffUserIds,_that.shiftType,_that.requiredStaff,_that.assignedStaff,_that.compliance,_that.startTime,_that.endTime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? shiftId,  List<String> clientIds,  List<String> staffUserIds,  String shiftType,  int requiredStaff,  int assignedStaff,  String compliance,  String? startTime,  String? endTime)  $default,) {final _that = this;
switch (_that) {
case _SILRosterEntry():
return $default(_that.shiftId,_that.clientIds,_that.staffUserIds,_that.shiftType,_that.requiredStaff,_that.assignedStaff,_that.compliance,_that.startTime,_that.endTime);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? shiftId,  List<String> clientIds,  List<String> staffUserIds,  String shiftType,  int requiredStaff,  int assignedStaff,  String compliance,  String? startTime,  String? endTime)?  $default,) {final _that = this;
switch (_that) {
case _SILRosterEntry() when $default != null:
return $default(_that.shiftId,_that.clientIds,_that.staffUserIds,_that.shiftType,_that.requiredStaff,_that.assignedStaff,_that.compliance,_that.startTime,_that.endTime);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SILRosterEntry implements SILRosterEntry {
  const _SILRosterEntry({this.shiftId, final  List<String> clientIds = const <String>[], final  List<String> staffUserIds = const <String>[], this.shiftType = 'day', this.requiredStaff = 1, this.assignedStaff = 0, this.compliance = 'ok', this.startTime, this.endTime}): _clientIds = clientIds,_staffUserIds = staffUserIds;
  factory _SILRosterEntry.fromJson(Map<String, dynamic> json) => _$SILRosterEntryFromJson(json);

@override final  String? shiftId;
 final  List<String> _clientIds;
@override@JsonKey() List<String> get clientIds {
  if (_clientIds is EqualUnmodifiableListView) return _clientIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_clientIds);
}

 final  List<String> _staffUserIds;
@override@JsonKey() List<String> get staffUserIds {
  if (_staffUserIds is EqualUnmodifiableListView) return _staffUserIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_staffUserIds);
}

@override@JsonKey() final  String shiftType;
@override@JsonKey() final  int requiredStaff;
@override@JsonKey() final  int assignedStaff;
@override@JsonKey() final  String compliance;
@override final  String? startTime;
@override final  String? endTime;

/// Create a copy of SILRosterEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SILRosterEntryCopyWith<_SILRosterEntry> get copyWith => __$SILRosterEntryCopyWithImpl<_SILRosterEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SILRosterEntryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SILRosterEntry&&(identical(other.shiftId, shiftId) || other.shiftId == shiftId)&&const DeepCollectionEquality().equals(other._clientIds, _clientIds)&&const DeepCollectionEquality().equals(other._staffUserIds, _staffUserIds)&&(identical(other.shiftType, shiftType) || other.shiftType == shiftType)&&(identical(other.requiredStaff, requiredStaff) || other.requiredStaff == requiredStaff)&&(identical(other.assignedStaff, assignedStaff) || other.assignedStaff == assignedStaff)&&(identical(other.compliance, compliance) || other.compliance == compliance)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,shiftId,const DeepCollectionEquality().hash(_clientIds),const DeepCollectionEquality().hash(_staffUserIds),shiftType,requiredStaff,assignedStaff,compliance,startTime,endTime);

@override
String toString() {
  return 'SILRosterEntry(shiftId: $shiftId, clientIds: $clientIds, staffUserIds: $staffUserIds, shiftType: $shiftType, requiredStaff: $requiredStaff, assignedStaff: $assignedStaff, compliance: $compliance, startTime: $startTime, endTime: $endTime)';
}


}

/// @nodoc
abstract mixin class _$SILRosterEntryCopyWith<$Res> implements $SILRosterEntryCopyWith<$Res> {
  factory _$SILRosterEntryCopyWith(_SILRosterEntry value, $Res Function(_SILRosterEntry) _then) = __$SILRosterEntryCopyWithImpl;
@override @useResult
$Res call({
 String? shiftId, List<String> clientIds, List<String> staffUserIds, String shiftType, int requiredStaff, int assignedStaff, String compliance, String? startTime, String? endTime
});




}
/// @nodoc
class __$SILRosterEntryCopyWithImpl<$Res>
    implements _$SILRosterEntryCopyWith<$Res> {
  __$SILRosterEntryCopyWithImpl(this._self, this._then);

  final _SILRosterEntry _self;
  final $Res Function(_SILRosterEntry) _then;

/// Create a copy of SILRosterEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? shiftId = freezed,Object? clientIds = null,Object? staffUserIds = null,Object? shiftType = null,Object? requiredStaff = null,Object? assignedStaff = null,Object? compliance = null,Object? startTime = freezed,Object? endTime = freezed,}) {
  return _then(_SILRosterEntry(
shiftId: freezed == shiftId ? _self.shiftId : shiftId // ignore: cast_nullable_to_non_nullable
as String?,clientIds: null == clientIds ? _self._clientIds : clientIds // ignore: cast_nullable_to_non_nullable
as List<String>,staffUserIds: null == staffUserIds ? _self._staffUserIds : staffUserIds // ignore: cast_nullable_to_non_nullable
as List<String>,shiftType: null == shiftType ? _self.shiftType : shiftType // ignore: cast_nullable_to_non_nullable
as String,requiredStaff: null == requiredStaff ? _self.requiredStaff : requiredStaff // ignore: cast_nullable_to_non_nullable
as int,assignedStaff: null == assignedStaff ? _self.assignedStaff : assignedStaff // ignore: cast_nullable_to_non_nullable
as int,compliance: null == compliance ? _self.compliance : compliance // ignore: cast_nullable_to_non_nullable
as String,startTime: freezed == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as String?,endTime: freezed == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$SILRatioWarning {

 String get role; String get message;
/// Create a copy of SILRatioWarning
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SILRatioWarningCopyWith<SILRatioWarning> get copyWith => _$SILRatioWarningCopyWithImpl<SILRatioWarning>(this as SILRatioWarning, _$identity);

  /// Serializes this SILRatioWarning to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SILRatioWarning&&(identical(other.role, role) || other.role == role)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,role,message);

@override
String toString() {
  return 'SILRatioWarning(role: $role, message: $message)';
}


}

/// @nodoc
abstract mixin class $SILRatioWarningCopyWith<$Res>  {
  factory $SILRatioWarningCopyWith(SILRatioWarning value, $Res Function(SILRatioWarning) _then) = _$SILRatioWarningCopyWithImpl;
@useResult
$Res call({
 String role, String message
});




}
/// @nodoc
class _$SILRatioWarningCopyWithImpl<$Res>
    implements $SILRatioWarningCopyWith<$Res> {
  _$SILRatioWarningCopyWithImpl(this._self, this._then);

  final SILRatioWarning _self;
  final $Res Function(SILRatioWarning) _then;

/// Create a copy of SILRatioWarning
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? role = null,Object? message = null,}) {
  return _then(_self.copyWith(
role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SILRatioWarning].
extension SILRatioWarningPatterns on SILRatioWarning {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SILRatioWarning value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SILRatioWarning() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SILRatioWarning value)  $default,){
final _that = this;
switch (_that) {
case _SILRatioWarning():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SILRatioWarning value)?  $default,){
final _that = this;
switch (_that) {
case _SILRatioWarning() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String role,  String message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SILRatioWarning() when $default != null:
return $default(_that.role,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String role,  String message)  $default,) {final _that = this;
switch (_that) {
case _SILRatioWarning():
return $default(_that.role,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String role,  String message)?  $default,) {final _that = this;
switch (_that) {
case _SILRatioWarning() when $default != null:
return $default(_that.role,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SILRatioWarning implements SILRatioWarning {
  const _SILRatioWarning({this.role = '', this.message = ''});
  factory _SILRatioWarning.fromJson(Map<String, dynamic> json) => _$SILRatioWarningFromJson(json);

@override@JsonKey() final  String role;
@override@JsonKey() final  String message;

/// Create a copy of SILRatioWarning
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SILRatioWarningCopyWith<_SILRatioWarning> get copyWith => __$SILRatioWarningCopyWithImpl<_SILRatioWarning>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SILRatioWarningToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SILRatioWarning&&(identical(other.role, role) || other.role == role)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,role,message);

@override
String toString() {
  return 'SILRatioWarning(role: $role, message: $message)';
}


}

/// @nodoc
abstract mixin class _$SILRatioWarningCopyWith<$Res> implements $SILRatioWarningCopyWith<$Res> {
  factory _$SILRatioWarningCopyWith(_SILRatioWarning value, $Res Function(_SILRatioWarning) _then) = __$SILRatioWarningCopyWithImpl;
@override @useResult
$Res call({
 String role, String message
});




}
/// @nodoc
class __$SILRatioWarningCopyWithImpl<$Res>
    implements _$SILRatioWarningCopyWith<$Res> {
  __$SILRatioWarningCopyWithImpl(this._self, this._then);

  final _SILRatioWarning _self;
  final $Res Function(_SILRatioWarning) _then;

/// Create a copy of SILRatioWarning
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? role = null,Object? message = null,}) {
  return _then(_SILRatioWarning(
role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$SILRoster {

 String get id; String get propertyId; String get status; String? get weekStarting; List<SILRosterEntry> get entries; List<SILRatioWarning> get ratioWarnings;
/// Create a copy of SILRoster
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SILRosterCopyWith<SILRoster> get copyWith => _$SILRosterCopyWithImpl<SILRoster>(this as SILRoster, _$identity);

  /// Serializes this SILRoster to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SILRoster&&(identical(other.id, id) || other.id == id)&&(identical(other.propertyId, propertyId) || other.propertyId == propertyId)&&(identical(other.status, status) || other.status == status)&&(identical(other.weekStarting, weekStarting) || other.weekStarting == weekStarting)&&const DeepCollectionEquality().equals(other.entries, entries)&&const DeepCollectionEquality().equals(other.ratioWarnings, ratioWarnings));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,propertyId,status,weekStarting,const DeepCollectionEquality().hash(entries),const DeepCollectionEquality().hash(ratioWarnings));

@override
String toString() {
  return 'SILRoster(id: $id, propertyId: $propertyId, status: $status, weekStarting: $weekStarting, entries: $entries, ratioWarnings: $ratioWarnings)';
}


}

/// @nodoc
abstract mixin class $SILRosterCopyWith<$Res>  {
  factory $SILRosterCopyWith(SILRoster value, $Res Function(SILRoster) _then) = _$SILRosterCopyWithImpl;
@useResult
$Res call({
 String id, String propertyId, String status, String? weekStarting, List<SILRosterEntry> entries, List<SILRatioWarning> ratioWarnings
});




}
/// @nodoc
class _$SILRosterCopyWithImpl<$Res>
    implements $SILRosterCopyWith<$Res> {
  _$SILRosterCopyWithImpl(this._self, this._then);

  final SILRoster _self;
  final $Res Function(SILRoster) _then;

/// Create a copy of SILRoster
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? propertyId = null,Object? status = null,Object? weekStarting = freezed,Object? entries = null,Object? ratioWarnings = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,propertyId: null == propertyId ? _self.propertyId : propertyId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,weekStarting: freezed == weekStarting ? _self.weekStarting : weekStarting // ignore: cast_nullable_to_non_nullable
as String?,entries: null == entries ? _self.entries : entries // ignore: cast_nullable_to_non_nullable
as List<SILRosterEntry>,ratioWarnings: null == ratioWarnings ? _self.ratioWarnings : ratioWarnings // ignore: cast_nullable_to_non_nullable
as List<SILRatioWarning>,
  ));
}

}


/// Adds pattern-matching-related methods to [SILRoster].
extension SILRosterPatterns on SILRoster {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SILRoster value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SILRoster() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SILRoster value)  $default,){
final _that = this;
switch (_that) {
case _SILRoster():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SILRoster value)?  $default,){
final _that = this;
switch (_that) {
case _SILRoster() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String propertyId,  String status,  String? weekStarting,  List<SILRosterEntry> entries,  List<SILRatioWarning> ratioWarnings)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SILRoster() when $default != null:
return $default(_that.id,_that.propertyId,_that.status,_that.weekStarting,_that.entries,_that.ratioWarnings);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String propertyId,  String status,  String? weekStarting,  List<SILRosterEntry> entries,  List<SILRatioWarning> ratioWarnings)  $default,) {final _that = this;
switch (_that) {
case _SILRoster():
return $default(_that.id,_that.propertyId,_that.status,_that.weekStarting,_that.entries,_that.ratioWarnings);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String propertyId,  String status,  String? weekStarting,  List<SILRosterEntry> entries,  List<SILRatioWarning> ratioWarnings)?  $default,) {final _that = this;
switch (_that) {
case _SILRoster() when $default != null:
return $default(_that.id,_that.propertyId,_that.status,_that.weekStarting,_that.entries,_that.ratioWarnings);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SILRoster implements SILRoster {
  const _SILRoster({required this.id, required this.propertyId, this.status = 'draft', this.weekStarting, final  List<SILRosterEntry> entries = const <SILRosterEntry>[], final  List<SILRatioWarning> ratioWarnings = const <SILRatioWarning>[]}): _entries = entries,_ratioWarnings = ratioWarnings;
  factory _SILRoster.fromJson(Map<String, dynamic> json) => _$SILRosterFromJson(json);

@override final  String id;
@override final  String propertyId;
@override@JsonKey() final  String status;
@override final  String? weekStarting;
 final  List<SILRosterEntry> _entries;
@override@JsonKey() List<SILRosterEntry> get entries {
  if (_entries is EqualUnmodifiableListView) return _entries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_entries);
}

 final  List<SILRatioWarning> _ratioWarnings;
@override@JsonKey() List<SILRatioWarning> get ratioWarnings {
  if (_ratioWarnings is EqualUnmodifiableListView) return _ratioWarnings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_ratioWarnings);
}


/// Create a copy of SILRoster
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SILRosterCopyWith<_SILRoster> get copyWith => __$SILRosterCopyWithImpl<_SILRoster>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SILRosterToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SILRoster&&(identical(other.id, id) || other.id == id)&&(identical(other.propertyId, propertyId) || other.propertyId == propertyId)&&(identical(other.status, status) || other.status == status)&&(identical(other.weekStarting, weekStarting) || other.weekStarting == weekStarting)&&const DeepCollectionEquality().equals(other._entries, _entries)&&const DeepCollectionEquality().equals(other._ratioWarnings, _ratioWarnings));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,propertyId,status,weekStarting,const DeepCollectionEquality().hash(_entries),const DeepCollectionEquality().hash(_ratioWarnings));

@override
String toString() {
  return 'SILRoster(id: $id, propertyId: $propertyId, status: $status, weekStarting: $weekStarting, entries: $entries, ratioWarnings: $ratioWarnings)';
}


}

/// @nodoc
abstract mixin class _$SILRosterCopyWith<$Res> implements $SILRosterCopyWith<$Res> {
  factory _$SILRosterCopyWith(_SILRoster value, $Res Function(_SILRoster) _then) = __$SILRosterCopyWithImpl;
@override @useResult
$Res call({
 String id, String propertyId, String status, String? weekStarting, List<SILRosterEntry> entries, List<SILRatioWarning> ratioWarnings
});




}
/// @nodoc
class __$SILRosterCopyWithImpl<$Res>
    implements _$SILRosterCopyWith<$Res> {
  __$SILRosterCopyWithImpl(this._self, this._then);

  final _SILRoster _self;
  final $Res Function(_SILRoster) _then;

/// Create a copy of SILRoster
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? propertyId = null,Object? status = null,Object? weekStarting = freezed,Object? entries = null,Object? ratioWarnings = null,}) {
  return _then(_SILRoster(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,propertyId: null == propertyId ? _self.propertyId : propertyId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,weekStarting: freezed == weekStarting ? _self.weekStarting : weekStarting // ignore: cast_nullable_to_non_nullable
as String?,entries: null == entries ? _self._entries : entries // ignore: cast_nullable_to_non_nullable
as List<SILRosterEntry>,ratioWarnings: null == ratioWarnings ? _self._ratioWarnings : ratioWarnings // ignore: cast_nullable_to_non_nullable
as List<SILRatioWarning>,
  ));
}


}


/// @nodoc
mixin _$SILPriceValidation {

 bool get passed; double? get capApplied; String? get type; List<String> get errors;
/// Create a copy of SILPriceValidation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SILPriceValidationCopyWith<SILPriceValidation> get copyWith => _$SILPriceValidationCopyWithImpl<SILPriceValidation>(this as SILPriceValidation, _$identity);

  /// Serializes this SILPriceValidation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SILPriceValidation&&(identical(other.passed, passed) || other.passed == passed)&&(identical(other.capApplied, capApplied) || other.capApplied == capApplied)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other.errors, errors));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,passed,capApplied,type,const DeepCollectionEquality().hash(errors));

@override
String toString() {
  return 'SILPriceValidation(passed: $passed, capApplied: $capApplied, type: $type, errors: $errors)';
}


}

/// @nodoc
abstract mixin class $SILPriceValidationCopyWith<$Res>  {
  factory $SILPriceValidationCopyWith(SILPriceValidation value, $Res Function(SILPriceValidation) _then) = _$SILPriceValidationCopyWithImpl;
@useResult
$Res call({
 bool passed, double? capApplied, String? type, List<String> errors
});




}
/// @nodoc
class _$SILPriceValidationCopyWithImpl<$Res>
    implements $SILPriceValidationCopyWith<$Res> {
  _$SILPriceValidationCopyWithImpl(this._self, this._then);

  final SILPriceValidation _self;
  final $Res Function(SILPriceValidation) _then;

/// Create a copy of SILPriceValidation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? passed = null,Object? capApplied = freezed,Object? type = freezed,Object? errors = null,}) {
  return _then(_self.copyWith(
passed: null == passed ? _self.passed : passed // ignore: cast_nullable_to_non_nullable
as bool,capApplied: freezed == capApplied ? _self.capApplied : capApplied // ignore: cast_nullable_to_non_nullable
as double?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,errors: null == errors ? _self.errors : errors // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [SILPriceValidation].
extension SILPriceValidationPatterns on SILPriceValidation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SILPriceValidation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SILPriceValidation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SILPriceValidation value)  $default,){
final _that = this;
switch (_that) {
case _SILPriceValidation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SILPriceValidation value)?  $default,){
final _that = this;
switch (_that) {
case _SILPriceValidation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool passed,  double? capApplied,  String? type,  List<String> errors)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SILPriceValidation() when $default != null:
return $default(_that.passed,_that.capApplied,_that.type,_that.errors);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool passed,  double? capApplied,  String? type,  List<String> errors)  $default,) {final _that = this;
switch (_that) {
case _SILPriceValidation():
return $default(_that.passed,_that.capApplied,_that.type,_that.errors);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool passed,  double? capApplied,  String? type,  List<String> errors)?  $default,) {final _that = this;
switch (_that) {
case _SILPriceValidation() when $default != null:
return $default(_that.passed,_that.capApplied,_that.type,_that.errors);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SILPriceValidation implements SILPriceValidation {
  const _SILPriceValidation({this.passed = true, this.capApplied, this.type, final  List<String> errors = const <String>[]}): _errors = errors;
  factory _SILPriceValidation.fromJson(Map<String, dynamic> json) => _$SILPriceValidationFromJson(json);

@override@JsonKey() final  bool passed;
@override final  double? capApplied;
@override final  String? type;
 final  List<String> _errors;
@override@JsonKey() List<String> get errors {
  if (_errors is EqualUnmodifiableListView) return _errors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_errors);
}


/// Create a copy of SILPriceValidation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SILPriceValidationCopyWith<_SILPriceValidation> get copyWith => __$SILPriceValidationCopyWithImpl<_SILPriceValidation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SILPriceValidationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SILPriceValidation&&(identical(other.passed, passed) || other.passed == passed)&&(identical(other.capApplied, capApplied) || other.capApplied == capApplied)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other._errors, _errors));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,passed,capApplied,type,const DeepCollectionEquality().hash(_errors));

@override
String toString() {
  return 'SILPriceValidation(passed: $passed, capApplied: $capApplied, type: $type, errors: $errors)';
}


}

/// @nodoc
abstract mixin class _$SILPriceValidationCopyWith<$Res> implements $SILPriceValidationCopyWith<$Res> {
  factory _$SILPriceValidationCopyWith(_SILPriceValidation value, $Res Function(_SILPriceValidation) _then) = __$SILPriceValidationCopyWithImpl;
@override @useResult
$Res call({
 bool passed, double? capApplied, String? type, List<String> errors
});




}
/// @nodoc
class __$SILPriceValidationCopyWithImpl<$Res>
    implements _$SILPriceValidationCopyWith<$Res> {
  __$SILPriceValidationCopyWithImpl(this._self, this._then);

  final _SILPriceValidation _self;
  final $Res Function(_SILPriceValidation) _then;

/// Create a copy of SILPriceValidation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? passed = null,Object? capApplied = freezed,Object? type = freezed,Object? errors = null,}) {
  return _then(_SILPriceValidation(
passed: null == passed ? _self.passed : passed // ignore: cast_nullable_to_non_nullable
as bool,capApplied: freezed == capApplied ? _self.capApplied : capApplied // ignore: cast_nullable_to_non_nullable
as double?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,errors: null == errors ? _self._errors : errors // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$SILQuoteLine {

 String get supportNumber; String get supportName; String get shiftType; double get hoursPerWeek; double get unitPrice; String get gstCode; double get amount; List<String> get days; String get startTime; String get endTime; SILPriceValidation get priceValidation;
/// Create a copy of SILQuoteLine
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SILQuoteLineCopyWith<SILQuoteLine> get copyWith => _$SILQuoteLineCopyWithImpl<SILQuoteLine>(this as SILQuoteLine, _$identity);

  /// Serializes this SILQuoteLine to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SILQuoteLine&&(identical(other.supportNumber, supportNumber) || other.supportNumber == supportNumber)&&(identical(other.supportName, supportName) || other.supportName == supportName)&&(identical(other.shiftType, shiftType) || other.shiftType == shiftType)&&(identical(other.hoursPerWeek, hoursPerWeek) || other.hoursPerWeek == hoursPerWeek)&&(identical(other.unitPrice, unitPrice) || other.unitPrice == unitPrice)&&(identical(other.gstCode, gstCode) || other.gstCode == gstCode)&&(identical(other.amount, amount) || other.amount == amount)&&const DeepCollectionEquality().equals(other.days, days)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.priceValidation, priceValidation) || other.priceValidation == priceValidation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,supportNumber,supportName,shiftType,hoursPerWeek,unitPrice,gstCode,amount,const DeepCollectionEquality().hash(days),startTime,endTime,priceValidation);

@override
String toString() {
  return 'SILQuoteLine(supportNumber: $supportNumber, supportName: $supportName, shiftType: $shiftType, hoursPerWeek: $hoursPerWeek, unitPrice: $unitPrice, gstCode: $gstCode, amount: $amount, days: $days, startTime: $startTime, endTime: $endTime, priceValidation: $priceValidation)';
}


}

/// @nodoc
abstract mixin class $SILQuoteLineCopyWith<$Res>  {
  factory $SILQuoteLineCopyWith(SILQuoteLine value, $Res Function(SILQuoteLine) _then) = _$SILQuoteLineCopyWithImpl;
@useResult
$Res call({
 String supportNumber, String supportName, String shiftType, double hoursPerWeek, double unitPrice, String gstCode, double amount, List<String> days, String startTime, String endTime, SILPriceValidation priceValidation
});


$SILPriceValidationCopyWith<$Res> get priceValidation;

}
/// @nodoc
class _$SILQuoteLineCopyWithImpl<$Res>
    implements $SILQuoteLineCopyWith<$Res> {
  _$SILQuoteLineCopyWithImpl(this._self, this._then);

  final SILQuoteLine _self;
  final $Res Function(SILQuoteLine) _then;

/// Create a copy of SILQuoteLine
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? supportNumber = null,Object? supportName = null,Object? shiftType = null,Object? hoursPerWeek = null,Object? unitPrice = null,Object? gstCode = null,Object? amount = null,Object? days = null,Object? startTime = null,Object? endTime = null,Object? priceValidation = null,}) {
  return _then(_self.copyWith(
supportNumber: null == supportNumber ? _self.supportNumber : supportNumber // ignore: cast_nullable_to_non_nullable
as String,supportName: null == supportName ? _self.supportName : supportName // ignore: cast_nullable_to_non_nullable
as String,shiftType: null == shiftType ? _self.shiftType : shiftType // ignore: cast_nullable_to_non_nullable
as String,hoursPerWeek: null == hoursPerWeek ? _self.hoursPerWeek : hoursPerWeek // ignore: cast_nullable_to_non_nullable
as double,unitPrice: null == unitPrice ? _self.unitPrice : unitPrice // ignore: cast_nullable_to_non_nullable
as double,gstCode: null == gstCode ? _self.gstCode : gstCode // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,days: null == days ? _self.days : days // ignore: cast_nullable_to_non_nullable
as List<String>,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as String,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as String,priceValidation: null == priceValidation ? _self.priceValidation : priceValidation // ignore: cast_nullable_to_non_nullable
as SILPriceValidation,
  ));
}
/// Create a copy of SILQuoteLine
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SILPriceValidationCopyWith<$Res> get priceValidation {
  
  return $SILPriceValidationCopyWith<$Res>(_self.priceValidation, (value) {
    return _then(_self.copyWith(priceValidation: value));
  });
}
}


/// Adds pattern-matching-related methods to [SILQuoteLine].
extension SILQuoteLinePatterns on SILQuoteLine {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SILQuoteLine value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SILQuoteLine() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SILQuoteLine value)  $default,){
final _that = this;
switch (_that) {
case _SILQuoteLine():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SILQuoteLine value)?  $default,){
final _that = this;
switch (_that) {
case _SILQuoteLine() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String supportNumber,  String supportName,  String shiftType,  double hoursPerWeek,  double unitPrice,  String gstCode,  double amount,  List<String> days,  String startTime,  String endTime,  SILPriceValidation priceValidation)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SILQuoteLine() when $default != null:
return $default(_that.supportNumber,_that.supportName,_that.shiftType,_that.hoursPerWeek,_that.unitPrice,_that.gstCode,_that.amount,_that.days,_that.startTime,_that.endTime,_that.priceValidation);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String supportNumber,  String supportName,  String shiftType,  double hoursPerWeek,  double unitPrice,  String gstCode,  double amount,  List<String> days,  String startTime,  String endTime,  SILPriceValidation priceValidation)  $default,) {final _that = this;
switch (_that) {
case _SILQuoteLine():
return $default(_that.supportNumber,_that.supportName,_that.shiftType,_that.hoursPerWeek,_that.unitPrice,_that.gstCode,_that.amount,_that.days,_that.startTime,_that.endTime,_that.priceValidation);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String supportNumber,  String supportName,  String shiftType,  double hoursPerWeek,  double unitPrice,  String gstCode,  double amount,  List<String> days,  String startTime,  String endTime,  SILPriceValidation priceValidation)?  $default,) {final _that = this;
switch (_that) {
case _SILQuoteLine() when $default != null:
return $default(_that.supportNumber,_that.supportName,_that.shiftType,_that.hoursPerWeek,_that.unitPrice,_that.gstCode,_that.amount,_that.days,_that.startTime,_that.endTime,_that.priceValidation);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SILQuoteLine implements SILQuoteLine {
  const _SILQuoteLine({required this.supportNumber, this.supportName = '', this.shiftType = 'day', this.hoursPerWeek = 0, this.unitPrice = 0, this.gstCode = 'P2', this.amount = 0, final  List<String> days = const <String>[], this.startTime = '', this.endTime = '', this.priceValidation = const SILPriceValidation()}): _days = days;
  factory _SILQuoteLine.fromJson(Map<String, dynamic> json) => _$SILQuoteLineFromJson(json);

@override final  String supportNumber;
@override@JsonKey() final  String supportName;
@override@JsonKey() final  String shiftType;
@override@JsonKey() final  double hoursPerWeek;
@override@JsonKey() final  double unitPrice;
@override@JsonKey() final  String gstCode;
@override@JsonKey() final  double amount;
 final  List<String> _days;
@override@JsonKey() List<String> get days {
  if (_days is EqualUnmodifiableListView) return _days;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_days);
}

@override@JsonKey() final  String startTime;
@override@JsonKey() final  String endTime;
@override@JsonKey() final  SILPriceValidation priceValidation;

/// Create a copy of SILQuoteLine
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SILQuoteLineCopyWith<_SILQuoteLine> get copyWith => __$SILQuoteLineCopyWithImpl<_SILQuoteLine>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SILQuoteLineToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SILQuoteLine&&(identical(other.supportNumber, supportNumber) || other.supportNumber == supportNumber)&&(identical(other.supportName, supportName) || other.supportName == supportName)&&(identical(other.shiftType, shiftType) || other.shiftType == shiftType)&&(identical(other.hoursPerWeek, hoursPerWeek) || other.hoursPerWeek == hoursPerWeek)&&(identical(other.unitPrice, unitPrice) || other.unitPrice == unitPrice)&&(identical(other.gstCode, gstCode) || other.gstCode == gstCode)&&(identical(other.amount, amount) || other.amount == amount)&&const DeepCollectionEquality().equals(other._days, _days)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.priceValidation, priceValidation) || other.priceValidation == priceValidation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,supportNumber,supportName,shiftType,hoursPerWeek,unitPrice,gstCode,amount,const DeepCollectionEquality().hash(_days),startTime,endTime,priceValidation);

@override
String toString() {
  return 'SILQuoteLine(supportNumber: $supportNumber, supportName: $supportName, shiftType: $shiftType, hoursPerWeek: $hoursPerWeek, unitPrice: $unitPrice, gstCode: $gstCode, amount: $amount, days: $days, startTime: $startTime, endTime: $endTime, priceValidation: $priceValidation)';
}


}

/// @nodoc
abstract mixin class _$SILQuoteLineCopyWith<$Res> implements $SILQuoteLineCopyWith<$Res> {
  factory _$SILQuoteLineCopyWith(_SILQuoteLine value, $Res Function(_SILQuoteLine) _then) = __$SILQuoteLineCopyWithImpl;
@override @useResult
$Res call({
 String supportNumber, String supportName, String shiftType, double hoursPerWeek, double unitPrice, String gstCode, double amount, List<String> days, String startTime, String endTime, SILPriceValidation priceValidation
});


@override $SILPriceValidationCopyWith<$Res> get priceValidation;

}
/// @nodoc
class __$SILQuoteLineCopyWithImpl<$Res>
    implements _$SILQuoteLineCopyWith<$Res> {
  __$SILQuoteLineCopyWithImpl(this._self, this._then);

  final _SILQuoteLine _self;
  final $Res Function(_SILQuoteLine) _then;

/// Create a copy of SILQuoteLine
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? supportNumber = null,Object? supportName = null,Object? shiftType = null,Object? hoursPerWeek = null,Object? unitPrice = null,Object? gstCode = null,Object? amount = null,Object? days = null,Object? startTime = null,Object? endTime = null,Object? priceValidation = null,}) {
  return _then(_SILQuoteLine(
supportNumber: null == supportNumber ? _self.supportNumber : supportNumber // ignore: cast_nullable_to_non_nullable
as String,supportName: null == supportName ? _self.supportName : supportName // ignore: cast_nullable_to_non_nullable
as String,shiftType: null == shiftType ? _self.shiftType : shiftType // ignore: cast_nullable_to_non_nullable
as String,hoursPerWeek: null == hoursPerWeek ? _self.hoursPerWeek : hoursPerWeek // ignore: cast_nullable_to_non_nullable
as double,unitPrice: null == unitPrice ? _self.unitPrice : unitPrice // ignore: cast_nullable_to_non_nullable
as double,gstCode: null == gstCode ? _self.gstCode : gstCode // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,days: null == days ? _self._days : days // ignore: cast_nullable_to_non_nullable
as List<String>,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as String,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as String,priceValidation: null == priceValidation ? _self.priceValidation : priceValidation // ignore: cast_nullable_to_non_nullable
as SILPriceValidation,
  ));
}

/// Create a copy of SILQuoteLine
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SILPriceValidationCopyWith<$Res> get priceValidation {
  
  return $SILPriceValidationCopyWith<$Res>(_self.priceValidation, (value) {
    return _then(_self.copyWith(priceValidation: value));
  });
}
}


/// @nodoc
mixin _$SILQuoteTotals {

 double get weeklyHours; double get weeklyAmount; double get annualAmount;
/// Create a copy of SILQuoteTotals
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SILQuoteTotalsCopyWith<SILQuoteTotals> get copyWith => _$SILQuoteTotalsCopyWithImpl<SILQuoteTotals>(this as SILQuoteTotals, _$identity);

  /// Serializes this SILQuoteTotals to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SILQuoteTotals&&(identical(other.weeklyHours, weeklyHours) || other.weeklyHours == weeklyHours)&&(identical(other.weeklyAmount, weeklyAmount) || other.weeklyAmount == weeklyAmount)&&(identical(other.annualAmount, annualAmount) || other.annualAmount == annualAmount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,weeklyHours,weeklyAmount,annualAmount);

@override
String toString() {
  return 'SILQuoteTotals(weeklyHours: $weeklyHours, weeklyAmount: $weeklyAmount, annualAmount: $annualAmount)';
}


}

/// @nodoc
abstract mixin class $SILQuoteTotalsCopyWith<$Res>  {
  factory $SILQuoteTotalsCopyWith(SILQuoteTotals value, $Res Function(SILQuoteTotals) _then) = _$SILQuoteTotalsCopyWithImpl;
@useResult
$Res call({
 double weeklyHours, double weeklyAmount, double annualAmount
});




}
/// @nodoc
class _$SILQuoteTotalsCopyWithImpl<$Res>
    implements $SILQuoteTotalsCopyWith<$Res> {
  _$SILQuoteTotalsCopyWithImpl(this._self, this._then);

  final SILQuoteTotals _self;
  final $Res Function(SILQuoteTotals) _then;

/// Create a copy of SILQuoteTotals
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? weeklyHours = null,Object? weeklyAmount = null,Object? annualAmount = null,}) {
  return _then(_self.copyWith(
weeklyHours: null == weeklyHours ? _self.weeklyHours : weeklyHours // ignore: cast_nullable_to_non_nullable
as double,weeklyAmount: null == weeklyAmount ? _self.weeklyAmount : weeklyAmount // ignore: cast_nullable_to_non_nullable
as double,annualAmount: null == annualAmount ? _self.annualAmount : annualAmount // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [SILQuoteTotals].
extension SILQuoteTotalsPatterns on SILQuoteTotals {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SILQuoteTotals value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SILQuoteTotals() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SILQuoteTotals value)  $default,){
final _that = this;
switch (_that) {
case _SILQuoteTotals():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SILQuoteTotals value)?  $default,){
final _that = this;
switch (_that) {
case _SILQuoteTotals() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double weeklyHours,  double weeklyAmount,  double annualAmount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SILQuoteTotals() when $default != null:
return $default(_that.weeklyHours,_that.weeklyAmount,_that.annualAmount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double weeklyHours,  double weeklyAmount,  double annualAmount)  $default,) {final _that = this;
switch (_that) {
case _SILQuoteTotals():
return $default(_that.weeklyHours,_that.weeklyAmount,_that.annualAmount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double weeklyHours,  double weeklyAmount,  double annualAmount)?  $default,) {final _that = this;
switch (_that) {
case _SILQuoteTotals() when $default != null:
return $default(_that.weeklyHours,_that.weeklyAmount,_that.annualAmount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SILQuoteTotals implements SILQuoteTotals {
  const _SILQuoteTotals({this.weeklyHours = 0, this.weeklyAmount = 0, this.annualAmount = 0});
  factory _SILQuoteTotals.fromJson(Map<String, dynamic> json) => _$SILQuoteTotalsFromJson(json);

@override@JsonKey() final  double weeklyHours;
@override@JsonKey() final  double weeklyAmount;
@override@JsonKey() final  double annualAmount;

/// Create a copy of SILQuoteTotals
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SILQuoteTotalsCopyWith<_SILQuoteTotals> get copyWith => __$SILQuoteTotalsCopyWithImpl<_SILQuoteTotals>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SILQuoteTotalsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SILQuoteTotals&&(identical(other.weeklyHours, weeklyHours) || other.weeklyHours == weeklyHours)&&(identical(other.weeklyAmount, weeklyAmount) || other.weeklyAmount == weeklyAmount)&&(identical(other.annualAmount, annualAmount) || other.annualAmount == annualAmount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,weeklyHours,weeklyAmount,annualAmount);

@override
String toString() {
  return 'SILQuoteTotals(weeklyHours: $weeklyHours, weeklyAmount: $weeklyAmount, annualAmount: $annualAmount)';
}


}

/// @nodoc
abstract mixin class _$SILQuoteTotalsCopyWith<$Res> implements $SILQuoteTotalsCopyWith<$Res> {
  factory _$SILQuoteTotalsCopyWith(_SILQuoteTotals value, $Res Function(_SILQuoteTotals) _then) = __$SILQuoteTotalsCopyWithImpl;
@override @useResult
$Res call({
 double weeklyHours, double weeklyAmount, double annualAmount
});




}
/// @nodoc
class __$SILQuoteTotalsCopyWithImpl<$Res>
    implements _$SILQuoteTotalsCopyWith<$Res> {
  __$SILQuoteTotalsCopyWithImpl(this._self, this._then);

  final _SILQuoteTotals _self;
  final $Res Function(_SILQuoteTotals) _then;

/// Create a copy of SILQuoteTotals
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? weeklyHours = null,Object? weeklyAmount = null,Object? annualAmount = null,}) {
  return _then(_SILQuoteTotals(
weeklyHours: null == weeklyHours ? _self.weeklyHours : weeklyHours // ignore: cast_nullable_to_non_nullable
as double,weeklyAmount: null == weeklyAmount ? _self.weeklyAmount : weeklyAmount // ignore: cast_nullable_to_non_nullable
as double,annualAmount: null == annualAmount ? _self.annualAmount : annualAmount // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$SILQuote {

 String get id; String get clientId; String? get propertyId; String get status; String get fundingType; String? get validUntil; List<SILQuoteLine> get lines; SILQuoteTotals get totals; String? get rosterOfCareId;
/// Create a copy of SILQuote
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SILQuoteCopyWith<SILQuote> get copyWith => _$SILQuoteCopyWithImpl<SILQuote>(this as SILQuote, _$identity);

  /// Serializes this SILQuote to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SILQuote&&(identical(other.id, id) || other.id == id)&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.propertyId, propertyId) || other.propertyId == propertyId)&&(identical(other.status, status) || other.status == status)&&(identical(other.fundingType, fundingType) || other.fundingType == fundingType)&&(identical(other.validUntil, validUntil) || other.validUntil == validUntil)&&const DeepCollectionEquality().equals(other.lines, lines)&&(identical(other.totals, totals) || other.totals == totals)&&(identical(other.rosterOfCareId, rosterOfCareId) || other.rosterOfCareId == rosterOfCareId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,clientId,propertyId,status,fundingType,validUntil,const DeepCollectionEquality().hash(lines),totals,rosterOfCareId);

@override
String toString() {
  return 'SILQuote(id: $id, clientId: $clientId, propertyId: $propertyId, status: $status, fundingType: $fundingType, validUntil: $validUntil, lines: $lines, totals: $totals, rosterOfCareId: $rosterOfCareId)';
}


}

/// @nodoc
abstract mixin class $SILQuoteCopyWith<$Res>  {
  factory $SILQuoteCopyWith(SILQuote value, $Res Function(SILQuote) _then) = _$SILQuoteCopyWithImpl;
@useResult
$Res call({
 String id, String clientId, String? propertyId, String status, String fundingType, String? validUntil, List<SILQuoteLine> lines, SILQuoteTotals totals, String? rosterOfCareId
});


$SILQuoteTotalsCopyWith<$Res> get totals;

}
/// @nodoc
class _$SILQuoteCopyWithImpl<$Res>
    implements $SILQuoteCopyWith<$Res> {
  _$SILQuoteCopyWithImpl(this._self, this._then);

  final SILQuote _self;
  final $Res Function(SILQuote) _then;

/// Create a copy of SILQuote
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? clientId = null,Object? propertyId = freezed,Object? status = null,Object? fundingType = null,Object? validUntil = freezed,Object? lines = null,Object? totals = null,Object? rosterOfCareId = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,clientId: null == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String,propertyId: freezed == propertyId ? _self.propertyId : propertyId // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,fundingType: null == fundingType ? _self.fundingType : fundingType // ignore: cast_nullable_to_non_nullable
as String,validUntil: freezed == validUntil ? _self.validUntil : validUntil // ignore: cast_nullable_to_non_nullable
as String?,lines: null == lines ? _self.lines : lines // ignore: cast_nullable_to_non_nullable
as List<SILQuoteLine>,totals: null == totals ? _self.totals : totals // ignore: cast_nullable_to_non_nullable
as SILQuoteTotals,rosterOfCareId: freezed == rosterOfCareId ? _self.rosterOfCareId : rosterOfCareId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of SILQuote
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SILQuoteTotalsCopyWith<$Res> get totals {
  
  return $SILQuoteTotalsCopyWith<$Res>(_self.totals, (value) {
    return _then(_self.copyWith(totals: value));
  });
}
}


/// Adds pattern-matching-related methods to [SILQuote].
extension SILQuotePatterns on SILQuote {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SILQuote value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SILQuote() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SILQuote value)  $default,){
final _that = this;
switch (_that) {
case _SILQuote():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SILQuote value)?  $default,){
final _that = this;
switch (_that) {
case _SILQuote() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String clientId,  String? propertyId,  String status,  String fundingType,  String? validUntil,  List<SILQuoteLine> lines,  SILQuoteTotals totals,  String? rosterOfCareId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SILQuote() when $default != null:
return $default(_that.id,_that.clientId,_that.propertyId,_that.status,_that.fundingType,_that.validUntil,_that.lines,_that.totals,_that.rosterOfCareId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String clientId,  String? propertyId,  String status,  String fundingType,  String? validUntil,  List<SILQuoteLine> lines,  SILQuoteTotals totals,  String? rosterOfCareId)  $default,) {final _that = this;
switch (_that) {
case _SILQuote():
return $default(_that.id,_that.clientId,_that.propertyId,_that.status,_that.fundingType,_that.validUntil,_that.lines,_that.totals,_that.rosterOfCareId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String clientId,  String? propertyId,  String status,  String fundingType,  String? validUntil,  List<SILQuoteLine> lines,  SILQuoteTotals totals,  String? rosterOfCareId)?  $default,) {final _that = this;
switch (_that) {
case _SILQuote() when $default != null:
return $default(_that.id,_that.clientId,_that.propertyId,_that.status,_that.fundingType,_that.validUntil,_that.lines,_that.totals,_that.rosterOfCareId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SILQuote implements SILQuote {
  const _SILQuote({required this.id, required this.clientId, this.propertyId, this.status = 'draft', this.fundingType = 'plan_managed', this.validUntil, final  List<SILQuoteLine> lines = const <SILQuoteLine>[], this.totals = const SILQuoteTotals(), this.rosterOfCareId}): _lines = lines;
  factory _SILQuote.fromJson(Map<String, dynamic> json) => _$SILQuoteFromJson(json);

@override final  String id;
@override final  String clientId;
@override final  String? propertyId;
@override@JsonKey() final  String status;
@override@JsonKey() final  String fundingType;
@override final  String? validUntil;
 final  List<SILQuoteLine> _lines;
@override@JsonKey() List<SILQuoteLine> get lines {
  if (_lines is EqualUnmodifiableListView) return _lines;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lines);
}

@override@JsonKey() final  SILQuoteTotals totals;
@override final  String? rosterOfCareId;

/// Create a copy of SILQuote
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SILQuoteCopyWith<_SILQuote> get copyWith => __$SILQuoteCopyWithImpl<_SILQuote>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SILQuoteToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SILQuote&&(identical(other.id, id) || other.id == id)&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.propertyId, propertyId) || other.propertyId == propertyId)&&(identical(other.status, status) || other.status == status)&&(identical(other.fundingType, fundingType) || other.fundingType == fundingType)&&(identical(other.validUntil, validUntil) || other.validUntil == validUntil)&&const DeepCollectionEquality().equals(other._lines, _lines)&&(identical(other.totals, totals) || other.totals == totals)&&(identical(other.rosterOfCareId, rosterOfCareId) || other.rosterOfCareId == rosterOfCareId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,clientId,propertyId,status,fundingType,validUntil,const DeepCollectionEquality().hash(_lines),totals,rosterOfCareId);

@override
String toString() {
  return 'SILQuote(id: $id, clientId: $clientId, propertyId: $propertyId, status: $status, fundingType: $fundingType, validUntil: $validUntil, lines: $lines, totals: $totals, rosterOfCareId: $rosterOfCareId)';
}


}

/// @nodoc
abstract mixin class _$SILQuoteCopyWith<$Res> implements $SILQuoteCopyWith<$Res> {
  factory _$SILQuoteCopyWith(_SILQuote value, $Res Function(_SILQuote) _then) = __$SILQuoteCopyWithImpl;
@override @useResult
$Res call({
 String id, String clientId, String? propertyId, String status, String fundingType, String? validUntil, List<SILQuoteLine> lines, SILQuoteTotals totals, String? rosterOfCareId
});


@override $SILQuoteTotalsCopyWith<$Res> get totals;

}
/// @nodoc
class __$SILQuoteCopyWithImpl<$Res>
    implements _$SILQuoteCopyWith<$Res> {
  __$SILQuoteCopyWithImpl(this._self, this._then);

  final _SILQuote _self;
  final $Res Function(_SILQuote) _then;

/// Create a copy of SILQuote
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? clientId = null,Object? propertyId = freezed,Object? status = null,Object? fundingType = null,Object? validUntil = freezed,Object? lines = null,Object? totals = null,Object? rosterOfCareId = freezed,}) {
  return _then(_SILQuote(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,clientId: null == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String,propertyId: freezed == propertyId ? _self.propertyId : propertyId // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,fundingType: null == fundingType ? _self.fundingType : fundingType // ignore: cast_nullable_to_non_nullable
as String,validUntil: freezed == validUntil ? _self.validUntil : validUntil // ignore: cast_nullable_to_non_nullable
as String?,lines: null == lines ? _self._lines : lines // ignore: cast_nullable_to_non_nullable
as List<SILQuoteLine>,totals: null == totals ? _self.totals : totals // ignore: cast_nullable_to_non_nullable
as SILQuoteTotals,rosterOfCareId: freezed == rosterOfCareId ? _self.rosterOfCareId : rosterOfCareId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of SILQuote
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SILQuoteTotalsCopyWith<$Res> get totals {
  
  return $SILQuoteTotalsCopyWith<$Res>(_self.totals, (value) {
    return _then(_self.copyWith(totals: value));
  });
}
}


/// @nodoc
mixin _$SILRocSupport {

 String get supportNumber; String get supportName; String get shiftType; double get hoursPerWeek; double get unitPrice; String get gstCode; double get amount; List<String> get days; String get startTime; String get endTime;
/// Create a copy of SILRocSupport
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SILRocSupportCopyWith<SILRocSupport> get copyWith => _$SILRocSupportCopyWithImpl<SILRocSupport>(this as SILRocSupport, _$identity);

  /// Serializes this SILRocSupport to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SILRocSupport&&(identical(other.supportNumber, supportNumber) || other.supportNumber == supportNumber)&&(identical(other.supportName, supportName) || other.supportName == supportName)&&(identical(other.shiftType, shiftType) || other.shiftType == shiftType)&&(identical(other.hoursPerWeek, hoursPerWeek) || other.hoursPerWeek == hoursPerWeek)&&(identical(other.unitPrice, unitPrice) || other.unitPrice == unitPrice)&&(identical(other.gstCode, gstCode) || other.gstCode == gstCode)&&(identical(other.amount, amount) || other.amount == amount)&&const DeepCollectionEquality().equals(other.days, days)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,supportNumber,supportName,shiftType,hoursPerWeek,unitPrice,gstCode,amount,const DeepCollectionEquality().hash(days),startTime,endTime);

@override
String toString() {
  return 'SILRocSupport(supportNumber: $supportNumber, supportName: $supportName, shiftType: $shiftType, hoursPerWeek: $hoursPerWeek, unitPrice: $unitPrice, gstCode: $gstCode, amount: $amount, days: $days, startTime: $startTime, endTime: $endTime)';
}


}

/// @nodoc
abstract mixin class $SILRocSupportCopyWith<$Res>  {
  factory $SILRocSupportCopyWith(SILRocSupport value, $Res Function(SILRocSupport) _then) = _$SILRocSupportCopyWithImpl;
@useResult
$Res call({
 String supportNumber, String supportName, String shiftType, double hoursPerWeek, double unitPrice, String gstCode, double amount, List<String> days, String startTime, String endTime
});




}
/// @nodoc
class _$SILRocSupportCopyWithImpl<$Res>
    implements $SILRocSupportCopyWith<$Res> {
  _$SILRocSupportCopyWithImpl(this._self, this._then);

  final SILRocSupport _self;
  final $Res Function(SILRocSupport) _then;

/// Create a copy of SILRocSupport
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? supportNumber = null,Object? supportName = null,Object? shiftType = null,Object? hoursPerWeek = null,Object? unitPrice = null,Object? gstCode = null,Object? amount = null,Object? days = null,Object? startTime = null,Object? endTime = null,}) {
  return _then(_self.copyWith(
supportNumber: null == supportNumber ? _self.supportNumber : supportNumber // ignore: cast_nullable_to_non_nullable
as String,supportName: null == supportName ? _self.supportName : supportName // ignore: cast_nullable_to_non_nullable
as String,shiftType: null == shiftType ? _self.shiftType : shiftType // ignore: cast_nullable_to_non_nullable
as String,hoursPerWeek: null == hoursPerWeek ? _self.hoursPerWeek : hoursPerWeek // ignore: cast_nullable_to_non_nullable
as double,unitPrice: null == unitPrice ? _self.unitPrice : unitPrice // ignore: cast_nullable_to_non_nullable
as double,gstCode: null == gstCode ? _self.gstCode : gstCode // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,days: null == days ? _self.days : days // ignore: cast_nullable_to_non_nullable
as List<String>,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as String,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SILRocSupport].
extension SILRocSupportPatterns on SILRocSupport {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SILRocSupport value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SILRocSupport() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SILRocSupport value)  $default,){
final _that = this;
switch (_that) {
case _SILRocSupport():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SILRocSupport value)?  $default,){
final _that = this;
switch (_that) {
case _SILRocSupport() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String supportNumber,  String supportName,  String shiftType,  double hoursPerWeek,  double unitPrice,  String gstCode,  double amount,  List<String> days,  String startTime,  String endTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SILRocSupport() when $default != null:
return $default(_that.supportNumber,_that.supportName,_that.shiftType,_that.hoursPerWeek,_that.unitPrice,_that.gstCode,_that.amount,_that.days,_that.startTime,_that.endTime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String supportNumber,  String supportName,  String shiftType,  double hoursPerWeek,  double unitPrice,  String gstCode,  double amount,  List<String> days,  String startTime,  String endTime)  $default,) {final _that = this;
switch (_that) {
case _SILRocSupport():
return $default(_that.supportNumber,_that.supportName,_that.shiftType,_that.hoursPerWeek,_that.unitPrice,_that.gstCode,_that.amount,_that.days,_that.startTime,_that.endTime);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String supportNumber,  String supportName,  String shiftType,  double hoursPerWeek,  double unitPrice,  String gstCode,  double amount,  List<String> days,  String startTime,  String endTime)?  $default,) {final _that = this;
switch (_that) {
case _SILRocSupport() when $default != null:
return $default(_that.supportNumber,_that.supportName,_that.shiftType,_that.hoursPerWeek,_that.unitPrice,_that.gstCode,_that.amount,_that.days,_that.startTime,_that.endTime);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SILRocSupport implements SILRocSupport {
  const _SILRocSupport({required this.supportNumber, this.supportName = '', this.shiftType = 'day', this.hoursPerWeek = 0, this.unitPrice = 0, this.gstCode = 'P2', this.amount = 0, final  List<String> days = const <String>[], this.startTime = '', this.endTime = ''}): _days = days;
  factory _SILRocSupport.fromJson(Map<String, dynamic> json) => _$SILRocSupportFromJson(json);

@override final  String supportNumber;
@override@JsonKey() final  String supportName;
@override@JsonKey() final  String shiftType;
@override@JsonKey() final  double hoursPerWeek;
@override@JsonKey() final  double unitPrice;
@override@JsonKey() final  String gstCode;
@override@JsonKey() final  double amount;
 final  List<String> _days;
@override@JsonKey() List<String> get days {
  if (_days is EqualUnmodifiableListView) return _days;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_days);
}

@override@JsonKey() final  String startTime;
@override@JsonKey() final  String endTime;

/// Create a copy of SILRocSupport
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SILRocSupportCopyWith<_SILRocSupport> get copyWith => __$SILRocSupportCopyWithImpl<_SILRocSupport>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SILRocSupportToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SILRocSupport&&(identical(other.supportNumber, supportNumber) || other.supportNumber == supportNumber)&&(identical(other.supportName, supportName) || other.supportName == supportName)&&(identical(other.shiftType, shiftType) || other.shiftType == shiftType)&&(identical(other.hoursPerWeek, hoursPerWeek) || other.hoursPerWeek == hoursPerWeek)&&(identical(other.unitPrice, unitPrice) || other.unitPrice == unitPrice)&&(identical(other.gstCode, gstCode) || other.gstCode == gstCode)&&(identical(other.amount, amount) || other.amount == amount)&&const DeepCollectionEquality().equals(other._days, _days)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,supportNumber,supportName,shiftType,hoursPerWeek,unitPrice,gstCode,amount,const DeepCollectionEquality().hash(_days),startTime,endTime);

@override
String toString() {
  return 'SILRocSupport(supportNumber: $supportNumber, supportName: $supportName, shiftType: $shiftType, hoursPerWeek: $hoursPerWeek, unitPrice: $unitPrice, gstCode: $gstCode, amount: $amount, days: $days, startTime: $startTime, endTime: $endTime)';
}


}

/// @nodoc
abstract mixin class _$SILRocSupportCopyWith<$Res> implements $SILRocSupportCopyWith<$Res> {
  factory _$SILRocSupportCopyWith(_SILRocSupport value, $Res Function(_SILRocSupport) _then) = __$SILRocSupportCopyWithImpl;
@override @useResult
$Res call({
 String supportNumber, String supportName, String shiftType, double hoursPerWeek, double unitPrice, String gstCode, double amount, List<String> days, String startTime, String endTime
});




}
/// @nodoc
class __$SILRocSupportCopyWithImpl<$Res>
    implements _$SILRocSupportCopyWith<$Res> {
  __$SILRocSupportCopyWithImpl(this._self, this._then);

  final _SILRocSupport _self;
  final $Res Function(_SILRocSupport) _then;

/// Create a copy of SILRocSupport
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? supportNumber = null,Object? supportName = null,Object? shiftType = null,Object? hoursPerWeek = null,Object? unitPrice = null,Object? gstCode = null,Object? amount = null,Object? days = null,Object? startTime = null,Object? endTime = null,}) {
  return _then(_SILRocSupport(
supportNumber: null == supportNumber ? _self.supportNumber : supportNumber // ignore: cast_nullable_to_non_nullable
as String,supportName: null == supportName ? _self.supportName : supportName // ignore: cast_nullable_to_non_nullable
as String,shiftType: null == shiftType ? _self.shiftType : shiftType // ignore: cast_nullable_to_non_nullable
as String,hoursPerWeek: null == hoursPerWeek ? _self.hoursPerWeek : hoursPerWeek // ignore: cast_nullable_to_non_nullable
as double,unitPrice: null == unitPrice ? _self.unitPrice : unitPrice // ignore: cast_nullable_to_non_nullable
as double,gstCode: null == gstCode ? _self.gstCode : gstCode // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,days: null == days ? _self._days : days // ignore: cast_nullable_to_non_nullable
as List<String>,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as String,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$SILReviewSchedule {

 String get cadence; String? get nextReviewDate;
/// Create a copy of SILReviewSchedule
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SILReviewScheduleCopyWith<SILReviewSchedule> get copyWith => _$SILReviewScheduleCopyWithImpl<SILReviewSchedule>(this as SILReviewSchedule, _$identity);

  /// Serializes this SILReviewSchedule to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SILReviewSchedule&&(identical(other.cadence, cadence) || other.cadence == cadence)&&(identical(other.nextReviewDate, nextReviewDate) || other.nextReviewDate == nextReviewDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cadence,nextReviewDate);

@override
String toString() {
  return 'SILReviewSchedule(cadence: $cadence, nextReviewDate: $nextReviewDate)';
}


}

/// @nodoc
abstract mixin class $SILReviewScheduleCopyWith<$Res>  {
  factory $SILReviewScheduleCopyWith(SILReviewSchedule value, $Res Function(SILReviewSchedule) _then) = _$SILReviewScheduleCopyWithImpl;
@useResult
$Res call({
 String cadence, String? nextReviewDate
});




}
/// @nodoc
class _$SILReviewScheduleCopyWithImpl<$Res>
    implements $SILReviewScheduleCopyWith<$Res> {
  _$SILReviewScheduleCopyWithImpl(this._self, this._then);

  final SILReviewSchedule _self;
  final $Res Function(SILReviewSchedule) _then;

/// Create a copy of SILReviewSchedule
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cadence = null,Object? nextReviewDate = freezed,}) {
  return _then(_self.copyWith(
cadence: null == cadence ? _self.cadence : cadence // ignore: cast_nullable_to_non_nullable
as String,nextReviewDate: freezed == nextReviewDate ? _self.nextReviewDate : nextReviewDate // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SILReviewSchedule].
extension SILReviewSchedulePatterns on SILReviewSchedule {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SILReviewSchedule value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SILReviewSchedule() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SILReviewSchedule value)  $default,){
final _that = this;
switch (_that) {
case _SILReviewSchedule():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SILReviewSchedule value)?  $default,){
final _that = this;
switch (_that) {
case _SILReviewSchedule() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String cadence,  String? nextReviewDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SILReviewSchedule() when $default != null:
return $default(_that.cadence,_that.nextReviewDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String cadence,  String? nextReviewDate)  $default,) {final _that = this;
switch (_that) {
case _SILReviewSchedule():
return $default(_that.cadence,_that.nextReviewDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String cadence,  String? nextReviewDate)?  $default,) {final _that = this;
switch (_that) {
case _SILReviewSchedule() when $default != null:
return $default(_that.cadence,_that.nextReviewDate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SILReviewSchedule implements SILReviewSchedule {
  const _SILReviewSchedule({this.cadence = 'quarterly', this.nextReviewDate});
  factory _SILReviewSchedule.fromJson(Map<String, dynamic> json) => _$SILReviewScheduleFromJson(json);

@override@JsonKey() final  String cadence;
@override final  String? nextReviewDate;

/// Create a copy of SILReviewSchedule
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SILReviewScheduleCopyWith<_SILReviewSchedule> get copyWith => __$SILReviewScheduleCopyWithImpl<_SILReviewSchedule>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SILReviewScheduleToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SILReviewSchedule&&(identical(other.cadence, cadence) || other.cadence == cadence)&&(identical(other.nextReviewDate, nextReviewDate) || other.nextReviewDate == nextReviewDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cadence,nextReviewDate);

@override
String toString() {
  return 'SILReviewSchedule(cadence: $cadence, nextReviewDate: $nextReviewDate)';
}


}

/// @nodoc
abstract mixin class _$SILReviewScheduleCopyWith<$Res> implements $SILReviewScheduleCopyWith<$Res> {
  factory _$SILReviewScheduleCopyWith(_SILReviewSchedule value, $Res Function(_SILReviewSchedule) _then) = __$SILReviewScheduleCopyWithImpl;
@override @useResult
$Res call({
 String cadence, String? nextReviewDate
});




}
/// @nodoc
class __$SILReviewScheduleCopyWithImpl<$Res>
    implements _$SILReviewScheduleCopyWith<$Res> {
  __$SILReviewScheduleCopyWithImpl(this._self, this._then);

  final _SILReviewSchedule _self;
  final $Res Function(_SILReviewSchedule) _then;

/// Create a copy of SILReviewSchedule
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cadence = null,Object? nextReviewDate = freezed,}) {
  return _then(_SILReviewSchedule(
cadence: null == cadence ? _self.cadence : cadence // ignore: cast_nullable_to_non_nullable
as String,nextReviewDate: freezed == nextReviewDate ? _self.nextReviewDate : nextReviewDate // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$SILRosterOfCare {

 String get id; String get clientId; String? get propertyId; String? get quoteId; String get status; String? get effectiveFrom; String? get effectiveTo; SILReviewSchedule get reviewSchedule; List<SILRocSupport> get supports;
/// Create a copy of SILRosterOfCare
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SILRosterOfCareCopyWith<SILRosterOfCare> get copyWith => _$SILRosterOfCareCopyWithImpl<SILRosterOfCare>(this as SILRosterOfCare, _$identity);

  /// Serializes this SILRosterOfCare to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SILRosterOfCare&&(identical(other.id, id) || other.id == id)&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.propertyId, propertyId) || other.propertyId == propertyId)&&(identical(other.quoteId, quoteId) || other.quoteId == quoteId)&&(identical(other.status, status) || other.status == status)&&(identical(other.effectiveFrom, effectiveFrom) || other.effectiveFrom == effectiveFrom)&&(identical(other.effectiveTo, effectiveTo) || other.effectiveTo == effectiveTo)&&(identical(other.reviewSchedule, reviewSchedule) || other.reviewSchedule == reviewSchedule)&&const DeepCollectionEquality().equals(other.supports, supports));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,clientId,propertyId,quoteId,status,effectiveFrom,effectiveTo,reviewSchedule,const DeepCollectionEquality().hash(supports));

@override
String toString() {
  return 'SILRosterOfCare(id: $id, clientId: $clientId, propertyId: $propertyId, quoteId: $quoteId, status: $status, effectiveFrom: $effectiveFrom, effectiveTo: $effectiveTo, reviewSchedule: $reviewSchedule, supports: $supports)';
}


}

/// @nodoc
abstract mixin class $SILRosterOfCareCopyWith<$Res>  {
  factory $SILRosterOfCareCopyWith(SILRosterOfCare value, $Res Function(SILRosterOfCare) _then) = _$SILRosterOfCareCopyWithImpl;
@useResult
$Res call({
 String id, String clientId, String? propertyId, String? quoteId, String status, String? effectiveFrom, String? effectiveTo, SILReviewSchedule reviewSchedule, List<SILRocSupport> supports
});


$SILReviewScheduleCopyWith<$Res> get reviewSchedule;

}
/// @nodoc
class _$SILRosterOfCareCopyWithImpl<$Res>
    implements $SILRosterOfCareCopyWith<$Res> {
  _$SILRosterOfCareCopyWithImpl(this._self, this._then);

  final SILRosterOfCare _self;
  final $Res Function(SILRosterOfCare) _then;

/// Create a copy of SILRosterOfCare
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? clientId = null,Object? propertyId = freezed,Object? quoteId = freezed,Object? status = null,Object? effectiveFrom = freezed,Object? effectiveTo = freezed,Object? reviewSchedule = null,Object? supports = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,clientId: null == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String,propertyId: freezed == propertyId ? _self.propertyId : propertyId // ignore: cast_nullable_to_non_nullable
as String?,quoteId: freezed == quoteId ? _self.quoteId : quoteId // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,effectiveFrom: freezed == effectiveFrom ? _self.effectiveFrom : effectiveFrom // ignore: cast_nullable_to_non_nullable
as String?,effectiveTo: freezed == effectiveTo ? _self.effectiveTo : effectiveTo // ignore: cast_nullable_to_non_nullable
as String?,reviewSchedule: null == reviewSchedule ? _self.reviewSchedule : reviewSchedule // ignore: cast_nullable_to_non_nullable
as SILReviewSchedule,supports: null == supports ? _self.supports : supports // ignore: cast_nullable_to_non_nullable
as List<SILRocSupport>,
  ));
}
/// Create a copy of SILRosterOfCare
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SILReviewScheduleCopyWith<$Res> get reviewSchedule {
  
  return $SILReviewScheduleCopyWith<$Res>(_self.reviewSchedule, (value) {
    return _then(_self.copyWith(reviewSchedule: value));
  });
}
}


/// Adds pattern-matching-related methods to [SILRosterOfCare].
extension SILRosterOfCarePatterns on SILRosterOfCare {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SILRosterOfCare value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SILRosterOfCare() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SILRosterOfCare value)  $default,){
final _that = this;
switch (_that) {
case _SILRosterOfCare():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SILRosterOfCare value)?  $default,){
final _that = this;
switch (_that) {
case _SILRosterOfCare() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String clientId,  String? propertyId,  String? quoteId,  String status,  String? effectiveFrom,  String? effectiveTo,  SILReviewSchedule reviewSchedule,  List<SILRocSupport> supports)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SILRosterOfCare() when $default != null:
return $default(_that.id,_that.clientId,_that.propertyId,_that.quoteId,_that.status,_that.effectiveFrom,_that.effectiveTo,_that.reviewSchedule,_that.supports);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String clientId,  String? propertyId,  String? quoteId,  String status,  String? effectiveFrom,  String? effectiveTo,  SILReviewSchedule reviewSchedule,  List<SILRocSupport> supports)  $default,) {final _that = this;
switch (_that) {
case _SILRosterOfCare():
return $default(_that.id,_that.clientId,_that.propertyId,_that.quoteId,_that.status,_that.effectiveFrom,_that.effectiveTo,_that.reviewSchedule,_that.supports);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String clientId,  String? propertyId,  String? quoteId,  String status,  String? effectiveFrom,  String? effectiveTo,  SILReviewSchedule reviewSchedule,  List<SILRocSupport> supports)?  $default,) {final _that = this;
switch (_that) {
case _SILRosterOfCare() when $default != null:
return $default(_that.id,_that.clientId,_that.propertyId,_that.quoteId,_that.status,_that.effectiveFrom,_that.effectiveTo,_that.reviewSchedule,_that.supports);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SILRosterOfCare implements SILRosterOfCare {
  const _SILRosterOfCare({required this.id, required this.clientId, this.propertyId, this.quoteId, this.status = 'draft', this.effectiveFrom, this.effectiveTo, this.reviewSchedule = const SILReviewSchedule(), final  List<SILRocSupport> supports = const <SILRocSupport>[]}): _supports = supports;
  factory _SILRosterOfCare.fromJson(Map<String, dynamic> json) => _$SILRosterOfCareFromJson(json);

@override final  String id;
@override final  String clientId;
@override final  String? propertyId;
@override final  String? quoteId;
@override@JsonKey() final  String status;
@override final  String? effectiveFrom;
@override final  String? effectiveTo;
@override@JsonKey() final  SILReviewSchedule reviewSchedule;
 final  List<SILRocSupport> _supports;
@override@JsonKey() List<SILRocSupport> get supports {
  if (_supports is EqualUnmodifiableListView) return _supports;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_supports);
}


/// Create a copy of SILRosterOfCare
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SILRosterOfCareCopyWith<_SILRosterOfCare> get copyWith => __$SILRosterOfCareCopyWithImpl<_SILRosterOfCare>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SILRosterOfCareToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SILRosterOfCare&&(identical(other.id, id) || other.id == id)&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.propertyId, propertyId) || other.propertyId == propertyId)&&(identical(other.quoteId, quoteId) || other.quoteId == quoteId)&&(identical(other.status, status) || other.status == status)&&(identical(other.effectiveFrom, effectiveFrom) || other.effectiveFrom == effectiveFrom)&&(identical(other.effectiveTo, effectiveTo) || other.effectiveTo == effectiveTo)&&(identical(other.reviewSchedule, reviewSchedule) || other.reviewSchedule == reviewSchedule)&&const DeepCollectionEquality().equals(other._supports, _supports));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,clientId,propertyId,quoteId,status,effectiveFrom,effectiveTo,reviewSchedule,const DeepCollectionEquality().hash(_supports));

@override
String toString() {
  return 'SILRosterOfCare(id: $id, clientId: $clientId, propertyId: $propertyId, quoteId: $quoteId, status: $status, effectiveFrom: $effectiveFrom, effectiveTo: $effectiveTo, reviewSchedule: $reviewSchedule, supports: $supports)';
}


}

/// @nodoc
abstract mixin class _$SILRosterOfCareCopyWith<$Res> implements $SILRosterOfCareCopyWith<$Res> {
  factory _$SILRosterOfCareCopyWith(_SILRosterOfCare value, $Res Function(_SILRosterOfCare) _then) = __$SILRosterOfCareCopyWithImpl;
@override @useResult
$Res call({
 String id, String clientId, String? propertyId, String? quoteId, String status, String? effectiveFrom, String? effectiveTo, SILReviewSchedule reviewSchedule, List<SILRocSupport> supports
});


@override $SILReviewScheduleCopyWith<$Res> get reviewSchedule;

}
/// @nodoc
class __$SILRosterOfCareCopyWithImpl<$Res>
    implements _$SILRosterOfCareCopyWith<$Res> {
  __$SILRosterOfCareCopyWithImpl(this._self, this._then);

  final _SILRosterOfCare _self;
  final $Res Function(_SILRosterOfCare) _then;

/// Create a copy of SILRosterOfCare
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? clientId = null,Object? propertyId = freezed,Object? quoteId = freezed,Object? status = null,Object? effectiveFrom = freezed,Object? effectiveTo = freezed,Object? reviewSchedule = null,Object? supports = null,}) {
  return _then(_SILRosterOfCare(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,clientId: null == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String,propertyId: freezed == propertyId ? _self.propertyId : propertyId // ignore: cast_nullable_to_non_nullable
as String?,quoteId: freezed == quoteId ? _self.quoteId : quoteId // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,effectiveFrom: freezed == effectiveFrom ? _self.effectiveFrom : effectiveFrom // ignore: cast_nullable_to_non_nullable
as String?,effectiveTo: freezed == effectiveTo ? _self.effectiveTo : effectiveTo // ignore: cast_nullable_to_non_nullable
as String?,reviewSchedule: null == reviewSchedule ? _self.reviewSchedule : reviewSchedule // ignore: cast_nullable_to_non_nullable
as SILReviewSchedule,supports: null == supports ? _self._supports : supports // ignore: cast_nullable_to_non_nullable
as List<SILRocSupport>,
  ));
}

/// Create a copy of SILRosterOfCare
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SILReviewScheduleCopyWith<$Res> get reviewSchedule {
  
  return $SILReviewScheduleCopyWith<$Res>(_self.reviewSchedule, (value) {
    return _then(_self.copyWith(reviewSchedule: value));
  });
}
}

// dart format on
