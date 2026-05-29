// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_preferences.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NotificationPreferences {

 String get userId; Map<NotificationCategory, bool> get categoryEnabled; Map<NotificationCategory, List<NotificationChannel>> get categoryChannels; QuietHours get quietHours; bool get smartTimingEnabled; bool get geofenceEnabled; double get geofenceRadiusKm; bool get soundEnabled; bool get vibrationEnabled; bool get badgeEnabled; DateTime? get lastUpdated;
/// Create a copy of NotificationPreferences
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationPreferencesCopyWith<NotificationPreferences> get copyWith => _$NotificationPreferencesCopyWithImpl<NotificationPreferences>(this as NotificationPreferences, _$identity);

  /// Serializes this NotificationPreferences to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationPreferences&&(identical(other.userId, userId) || other.userId == userId)&&const DeepCollectionEquality().equals(other.categoryEnabled, categoryEnabled)&&const DeepCollectionEquality().equals(other.categoryChannels, categoryChannels)&&(identical(other.quietHours, quietHours) || other.quietHours == quietHours)&&(identical(other.smartTimingEnabled, smartTimingEnabled) || other.smartTimingEnabled == smartTimingEnabled)&&(identical(other.geofenceEnabled, geofenceEnabled) || other.geofenceEnabled == geofenceEnabled)&&(identical(other.geofenceRadiusKm, geofenceRadiusKm) || other.geofenceRadiusKm == geofenceRadiusKm)&&(identical(other.soundEnabled, soundEnabled) || other.soundEnabled == soundEnabled)&&(identical(other.vibrationEnabled, vibrationEnabled) || other.vibrationEnabled == vibrationEnabled)&&(identical(other.badgeEnabled, badgeEnabled) || other.badgeEnabled == badgeEnabled)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,const DeepCollectionEquality().hash(categoryEnabled),const DeepCollectionEquality().hash(categoryChannels),quietHours,smartTimingEnabled,geofenceEnabled,geofenceRadiusKm,soundEnabled,vibrationEnabled,badgeEnabled,lastUpdated);

@override
String toString() {
  return 'NotificationPreferences(userId: $userId, categoryEnabled: $categoryEnabled, categoryChannels: $categoryChannels, quietHours: $quietHours, smartTimingEnabled: $smartTimingEnabled, geofenceEnabled: $geofenceEnabled, geofenceRadiusKm: $geofenceRadiusKm, soundEnabled: $soundEnabled, vibrationEnabled: $vibrationEnabled, badgeEnabled: $badgeEnabled, lastUpdated: $lastUpdated)';
}


}

/// @nodoc
abstract mixin class $NotificationPreferencesCopyWith<$Res>  {
  factory $NotificationPreferencesCopyWith(NotificationPreferences value, $Res Function(NotificationPreferences) _then) = _$NotificationPreferencesCopyWithImpl;
@useResult
$Res call({
 String userId, Map<NotificationCategory, bool> categoryEnabled, Map<NotificationCategory, List<NotificationChannel>> categoryChannels, QuietHours quietHours, bool smartTimingEnabled, bool geofenceEnabled, double geofenceRadiusKm, bool soundEnabled, bool vibrationEnabled, bool badgeEnabled, DateTime? lastUpdated
});


$QuietHoursCopyWith<$Res> get quietHours;

}
/// @nodoc
class _$NotificationPreferencesCopyWithImpl<$Res>
    implements $NotificationPreferencesCopyWith<$Res> {
  _$NotificationPreferencesCopyWithImpl(this._self, this._then);

  final NotificationPreferences _self;
  final $Res Function(NotificationPreferences) _then;

/// Create a copy of NotificationPreferences
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? categoryEnabled = null,Object? categoryChannels = null,Object? quietHours = null,Object? smartTimingEnabled = null,Object? geofenceEnabled = null,Object? geofenceRadiusKm = null,Object? soundEnabled = null,Object? vibrationEnabled = null,Object? badgeEnabled = null,Object? lastUpdated = freezed,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,categoryEnabled: null == categoryEnabled ? _self.categoryEnabled : categoryEnabled // ignore: cast_nullable_to_non_nullable
as Map<NotificationCategory, bool>,categoryChannels: null == categoryChannels ? _self.categoryChannels : categoryChannels // ignore: cast_nullable_to_non_nullable
as Map<NotificationCategory, List<NotificationChannel>>,quietHours: null == quietHours ? _self.quietHours : quietHours // ignore: cast_nullable_to_non_nullable
as QuietHours,smartTimingEnabled: null == smartTimingEnabled ? _self.smartTimingEnabled : smartTimingEnabled // ignore: cast_nullable_to_non_nullable
as bool,geofenceEnabled: null == geofenceEnabled ? _self.geofenceEnabled : geofenceEnabled // ignore: cast_nullable_to_non_nullable
as bool,geofenceRadiusKm: null == geofenceRadiusKm ? _self.geofenceRadiusKm : geofenceRadiusKm // ignore: cast_nullable_to_non_nullable
as double,soundEnabled: null == soundEnabled ? _self.soundEnabled : soundEnabled // ignore: cast_nullable_to_non_nullable
as bool,vibrationEnabled: null == vibrationEnabled ? _self.vibrationEnabled : vibrationEnabled // ignore: cast_nullable_to_non_nullable
as bool,badgeEnabled: null == badgeEnabled ? _self.badgeEnabled : badgeEnabled // ignore: cast_nullable_to_non_nullable
as bool,lastUpdated: freezed == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of NotificationPreferences
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QuietHoursCopyWith<$Res> get quietHours {
  
  return $QuietHoursCopyWith<$Res>(_self.quietHours, (value) {
    return _then(_self.copyWith(quietHours: value));
  });
}
}


/// Adds pattern-matching-related methods to [NotificationPreferences].
extension NotificationPreferencesPatterns on NotificationPreferences {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationPreferences value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationPreferences() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationPreferences value)  $default,){
final _that = this;
switch (_that) {
case _NotificationPreferences():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationPreferences value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationPreferences() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  Map<NotificationCategory, bool> categoryEnabled,  Map<NotificationCategory, List<NotificationChannel>> categoryChannels,  QuietHours quietHours,  bool smartTimingEnabled,  bool geofenceEnabled,  double geofenceRadiusKm,  bool soundEnabled,  bool vibrationEnabled,  bool badgeEnabled,  DateTime? lastUpdated)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationPreferences() when $default != null:
return $default(_that.userId,_that.categoryEnabled,_that.categoryChannels,_that.quietHours,_that.smartTimingEnabled,_that.geofenceEnabled,_that.geofenceRadiusKm,_that.soundEnabled,_that.vibrationEnabled,_that.badgeEnabled,_that.lastUpdated);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  Map<NotificationCategory, bool> categoryEnabled,  Map<NotificationCategory, List<NotificationChannel>> categoryChannels,  QuietHours quietHours,  bool smartTimingEnabled,  bool geofenceEnabled,  double geofenceRadiusKm,  bool soundEnabled,  bool vibrationEnabled,  bool badgeEnabled,  DateTime? lastUpdated)  $default,) {final _that = this;
switch (_that) {
case _NotificationPreferences():
return $default(_that.userId,_that.categoryEnabled,_that.categoryChannels,_that.quietHours,_that.smartTimingEnabled,_that.geofenceEnabled,_that.geofenceRadiusKm,_that.soundEnabled,_that.vibrationEnabled,_that.badgeEnabled,_that.lastUpdated);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  Map<NotificationCategory, bool> categoryEnabled,  Map<NotificationCategory, List<NotificationChannel>> categoryChannels,  QuietHours quietHours,  bool smartTimingEnabled,  bool geofenceEnabled,  double geofenceRadiusKm,  bool soundEnabled,  bool vibrationEnabled,  bool badgeEnabled,  DateTime? lastUpdated)?  $default,) {final _that = this;
switch (_that) {
case _NotificationPreferences() when $default != null:
return $default(_that.userId,_that.categoryEnabled,_that.categoryChannels,_that.quietHours,_that.smartTimingEnabled,_that.geofenceEnabled,_that.geofenceRadiusKm,_that.soundEnabled,_that.vibrationEnabled,_that.badgeEnabled,_that.lastUpdated);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NotificationPreferences implements NotificationPreferences {
  const _NotificationPreferences({required this.userId, required final  Map<NotificationCategory, bool> categoryEnabled, required final  Map<NotificationCategory, List<NotificationChannel>> categoryChannels, required this.quietHours, this.smartTimingEnabled = true, this.geofenceEnabled = true, this.geofenceRadiusKm = 5.0, this.soundEnabled = true, this.vibrationEnabled = true, this.badgeEnabled = true, this.lastUpdated}): _categoryEnabled = categoryEnabled,_categoryChannels = categoryChannels;
  factory _NotificationPreferences.fromJson(Map<String, dynamic> json) => _$NotificationPreferencesFromJson(json);

@override final  String userId;
 final  Map<NotificationCategory, bool> _categoryEnabled;
@override Map<NotificationCategory, bool> get categoryEnabled {
  if (_categoryEnabled is EqualUnmodifiableMapView) return _categoryEnabled;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_categoryEnabled);
}

 final  Map<NotificationCategory, List<NotificationChannel>> _categoryChannels;
@override Map<NotificationCategory, List<NotificationChannel>> get categoryChannels {
  if (_categoryChannels is EqualUnmodifiableMapView) return _categoryChannels;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_categoryChannels);
}

@override final  QuietHours quietHours;
@override@JsonKey() final  bool smartTimingEnabled;
@override@JsonKey() final  bool geofenceEnabled;
@override@JsonKey() final  double geofenceRadiusKm;
@override@JsonKey() final  bool soundEnabled;
@override@JsonKey() final  bool vibrationEnabled;
@override@JsonKey() final  bool badgeEnabled;
@override final  DateTime? lastUpdated;

/// Create a copy of NotificationPreferences
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationPreferencesCopyWith<_NotificationPreferences> get copyWith => __$NotificationPreferencesCopyWithImpl<_NotificationPreferences>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationPreferencesToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationPreferences&&(identical(other.userId, userId) || other.userId == userId)&&const DeepCollectionEquality().equals(other._categoryEnabled, _categoryEnabled)&&const DeepCollectionEquality().equals(other._categoryChannels, _categoryChannels)&&(identical(other.quietHours, quietHours) || other.quietHours == quietHours)&&(identical(other.smartTimingEnabled, smartTimingEnabled) || other.smartTimingEnabled == smartTimingEnabled)&&(identical(other.geofenceEnabled, geofenceEnabled) || other.geofenceEnabled == geofenceEnabled)&&(identical(other.geofenceRadiusKm, geofenceRadiusKm) || other.geofenceRadiusKm == geofenceRadiusKm)&&(identical(other.soundEnabled, soundEnabled) || other.soundEnabled == soundEnabled)&&(identical(other.vibrationEnabled, vibrationEnabled) || other.vibrationEnabled == vibrationEnabled)&&(identical(other.badgeEnabled, badgeEnabled) || other.badgeEnabled == badgeEnabled)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,const DeepCollectionEquality().hash(_categoryEnabled),const DeepCollectionEquality().hash(_categoryChannels),quietHours,smartTimingEnabled,geofenceEnabled,geofenceRadiusKm,soundEnabled,vibrationEnabled,badgeEnabled,lastUpdated);

@override
String toString() {
  return 'NotificationPreferences(userId: $userId, categoryEnabled: $categoryEnabled, categoryChannels: $categoryChannels, quietHours: $quietHours, smartTimingEnabled: $smartTimingEnabled, geofenceEnabled: $geofenceEnabled, geofenceRadiusKm: $geofenceRadiusKm, soundEnabled: $soundEnabled, vibrationEnabled: $vibrationEnabled, badgeEnabled: $badgeEnabled, lastUpdated: $lastUpdated)';
}


}

/// @nodoc
abstract mixin class _$NotificationPreferencesCopyWith<$Res> implements $NotificationPreferencesCopyWith<$Res> {
  factory _$NotificationPreferencesCopyWith(_NotificationPreferences value, $Res Function(_NotificationPreferences) _then) = __$NotificationPreferencesCopyWithImpl;
@override @useResult
$Res call({
 String userId, Map<NotificationCategory, bool> categoryEnabled, Map<NotificationCategory, List<NotificationChannel>> categoryChannels, QuietHours quietHours, bool smartTimingEnabled, bool geofenceEnabled, double geofenceRadiusKm, bool soundEnabled, bool vibrationEnabled, bool badgeEnabled, DateTime? lastUpdated
});


@override $QuietHoursCopyWith<$Res> get quietHours;

}
/// @nodoc
class __$NotificationPreferencesCopyWithImpl<$Res>
    implements _$NotificationPreferencesCopyWith<$Res> {
  __$NotificationPreferencesCopyWithImpl(this._self, this._then);

  final _NotificationPreferences _self;
  final $Res Function(_NotificationPreferences) _then;

/// Create a copy of NotificationPreferences
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? categoryEnabled = null,Object? categoryChannels = null,Object? quietHours = null,Object? smartTimingEnabled = null,Object? geofenceEnabled = null,Object? geofenceRadiusKm = null,Object? soundEnabled = null,Object? vibrationEnabled = null,Object? badgeEnabled = null,Object? lastUpdated = freezed,}) {
  return _then(_NotificationPreferences(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,categoryEnabled: null == categoryEnabled ? _self._categoryEnabled : categoryEnabled // ignore: cast_nullable_to_non_nullable
as Map<NotificationCategory, bool>,categoryChannels: null == categoryChannels ? _self._categoryChannels : categoryChannels // ignore: cast_nullable_to_non_nullable
as Map<NotificationCategory, List<NotificationChannel>>,quietHours: null == quietHours ? _self.quietHours : quietHours // ignore: cast_nullable_to_non_nullable
as QuietHours,smartTimingEnabled: null == smartTimingEnabled ? _self.smartTimingEnabled : smartTimingEnabled // ignore: cast_nullable_to_non_nullable
as bool,geofenceEnabled: null == geofenceEnabled ? _self.geofenceEnabled : geofenceEnabled // ignore: cast_nullable_to_non_nullable
as bool,geofenceRadiusKm: null == geofenceRadiusKm ? _self.geofenceRadiusKm : geofenceRadiusKm // ignore: cast_nullable_to_non_nullable
as double,soundEnabled: null == soundEnabled ? _self.soundEnabled : soundEnabled // ignore: cast_nullable_to_non_nullable
as bool,vibrationEnabled: null == vibrationEnabled ? _self.vibrationEnabled : vibrationEnabled // ignore: cast_nullable_to_non_nullable
as bool,badgeEnabled: null == badgeEnabled ? _self.badgeEnabled : badgeEnabled // ignore: cast_nullable_to_non_nullable
as bool,lastUpdated: freezed == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of NotificationPreferences
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QuietHoursCopyWith<$Res> get quietHours {
  
  return $QuietHoursCopyWith<$Res>(_self.quietHours, (value) {
    return _then(_self.copyWith(quietHours: value));
  });
}
}


/// @nodoc
mixin _$QuietHours {

 bool get enabled; String get startTime;// HH:mm format
 String get endTime;// HH:mm format
 List<int> get daysOfWeek;
/// Create a copy of QuietHours
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuietHoursCopyWith<QuietHours> get copyWith => _$QuietHoursCopyWithImpl<QuietHours>(this as QuietHours, _$identity);

  /// Serializes this QuietHours to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuietHours&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&const DeepCollectionEquality().equals(other.daysOfWeek, daysOfWeek));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,enabled,startTime,endTime,const DeepCollectionEquality().hash(daysOfWeek));

@override
String toString() {
  return 'QuietHours(enabled: $enabled, startTime: $startTime, endTime: $endTime, daysOfWeek: $daysOfWeek)';
}


}

/// @nodoc
abstract mixin class $QuietHoursCopyWith<$Res>  {
  factory $QuietHoursCopyWith(QuietHours value, $Res Function(QuietHours) _then) = _$QuietHoursCopyWithImpl;
@useResult
$Res call({
 bool enabled, String startTime, String endTime, List<int> daysOfWeek
});




}
/// @nodoc
class _$QuietHoursCopyWithImpl<$Res>
    implements $QuietHoursCopyWith<$Res> {
  _$QuietHoursCopyWithImpl(this._self, this._then);

  final QuietHours _self;
  final $Res Function(QuietHours) _then;

/// Create a copy of QuietHours
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? enabled = null,Object? startTime = null,Object? endTime = null,Object? daysOfWeek = null,}) {
  return _then(_self.copyWith(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as String,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as String,daysOfWeek: null == daysOfWeek ? _self.daysOfWeek : daysOfWeek // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}

}


/// Adds pattern-matching-related methods to [QuietHours].
extension QuietHoursPatterns on QuietHours {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuietHours value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuietHours() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuietHours value)  $default,){
final _that = this;
switch (_that) {
case _QuietHours():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuietHours value)?  $default,){
final _that = this;
switch (_that) {
case _QuietHours() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool enabled,  String startTime,  String endTime,  List<int> daysOfWeek)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuietHours() when $default != null:
return $default(_that.enabled,_that.startTime,_that.endTime,_that.daysOfWeek);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool enabled,  String startTime,  String endTime,  List<int> daysOfWeek)  $default,) {final _that = this;
switch (_that) {
case _QuietHours():
return $default(_that.enabled,_that.startTime,_that.endTime,_that.daysOfWeek);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool enabled,  String startTime,  String endTime,  List<int> daysOfWeek)?  $default,) {final _that = this;
switch (_that) {
case _QuietHours() when $default != null:
return $default(_that.enabled,_that.startTime,_that.endTime,_that.daysOfWeek);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QuietHours implements QuietHours {
  const _QuietHours({this.enabled = false, this.startTime = '22:00', this.endTime = '08:00', final  List<int> daysOfWeek = const []}): _daysOfWeek = daysOfWeek;
  factory _QuietHours.fromJson(Map<String, dynamic> json) => _$QuietHoursFromJson(json);

@override@JsonKey() final  bool enabled;
@override@JsonKey() final  String startTime;
// HH:mm format
@override@JsonKey() final  String endTime;
// HH:mm format
 final  List<int> _daysOfWeek;
// HH:mm format
@override@JsonKey() List<int> get daysOfWeek {
  if (_daysOfWeek is EqualUnmodifiableListView) return _daysOfWeek;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_daysOfWeek);
}


/// Create a copy of QuietHours
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuietHoursCopyWith<_QuietHours> get copyWith => __$QuietHoursCopyWithImpl<_QuietHours>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QuietHoursToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuietHours&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&const DeepCollectionEquality().equals(other._daysOfWeek, _daysOfWeek));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,enabled,startTime,endTime,const DeepCollectionEquality().hash(_daysOfWeek));

@override
String toString() {
  return 'QuietHours(enabled: $enabled, startTime: $startTime, endTime: $endTime, daysOfWeek: $daysOfWeek)';
}


}

/// @nodoc
abstract mixin class _$QuietHoursCopyWith<$Res> implements $QuietHoursCopyWith<$Res> {
  factory _$QuietHoursCopyWith(_QuietHours value, $Res Function(_QuietHours) _then) = __$QuietHoursCopyWithImpl;
@override @useResult
$Res call({
 bool enabled, String startTime, String endTime, List<int> daysOfWeek
});




}
/// @nodoc
class __$QuietHoursCopyWithImpl<$Res>
    implements _$QuietHoursCopyWith<$Res> {
  __$QuietHoursCopyWithImpl(this._self, this._then);

  final _QuietHours _self;
  final $Res Function(_QuietHours) _then;

/// Create a copy of QuietHours
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? enabled = null,Object? startTime = null,Object? endTime = null,Object? daysOfWeek = null,}) {
  return _then(_QuietHours(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as String,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as String,daysOfWeek: null == daysOfWeek ? _self._daysOfWeek : daysOfWeek // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}


}


/// @nodoc
mixin _$GeofenceEvent {

 String get eventId; String get workerId; String get workerName; String get appointmentId; String get clientName; String get clientAddress; GeofenceEventType get eventType; DateTime get timestamp; double get latitude; double get longitude; double? get distanceMeters; String? get notes;
/// Create a copy of GeofenceEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GeofenceEventCopyWith<GeofenceEvent> get copyWith => _$GeofenceEventCopyWithImpl<GeofenceEvent>(this as GeofenceEvent, _$identity);

  /// Serializes this GeofenceEvent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GeofenceEvent&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.workerId, workerId) || other.workerId == workerId)&&(identical(other.workerName, workerName) || other.workerName == workerName)&&(identical(other.appointmentId, appointmentId) || other.appointmentId == appointmentId)&&(identical(other.clientName, clientName) || other.clientName == clientName)&&(identical(other.clientAddress, clientAddress) || other.clientAddress == clientAddress)&&(identical(other.eventType, eventType) || other.eventType == eventType)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.distanceMeters, distanceMeters) || other.distanceMeters == distanceMeters)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,workerId,workerName,appointmentId,clientName,clientAddress,eventType,timestamp,latitude,longitude,distanceMeters,notes);

@override
String toString() {
  return 'GeofenceEvent(eventId: $eventId, workerId: $workerId, workerName: $workerName, appointmentId: $appointmentId, clientName: $clientName, clientAddress: $clientAddress, eventType: $eventType, timestamp: $timestamp, latitude: $latitude, longitude: $longitude, distanceMeters: $distanceMeters, notes: $notes)';
}


}

/// @nodoc
abstract mixin class $GeofenceEventCopyWith<$Res>  {
  factory $GeofenceEventCopyWith(GeofenceEvent value, $Res Function(GeofenceEvent) _then) = _$GeofenceEventCopyWithImpl;
@useResult
$Res call({
 String eventId, String workerId, String workerName, String appointmentId, String clientName, String clientAddress, GeofenceEventType eventType, DateTime timestamp, double latitude, double longitude, double? distanceMeters, String? notes
});




}
/// @nodoc
class _$GeofenceEventCopyWithImpl<$Res>
    implements $GeofenceEventCopyWith<$Res> {
  _$GeofenceEventCopyWithImpl(this._self, this._then);

  final GeofenceEvent _self;
  final $Res Function(GeofenceEvent) _then;

/// Create a copy of GeofenceEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eventId = null,Object? workerId = null,Object? workerName = null,Object? appointmentId = null,Object? clientName = null,Object? clientAddress = null,Object? eventType = null,Object? timestamp = null,Object? latitude = null,Object? longitude = null,Object? distanceMeters = freezed,Object? notes = freezed,}) {
  return _then(_self.copyWith(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,workerId: null == workerId ? _self.workerId : workerId // ignore: cast_nullable_to_non_nullable
as String,workerName: null == workerName ? _self.workerName : workerName // ignore: cast_nullable_to_non_nullable
as String,appointmentId: null == appointmentId ? _self.appointmentId : appointmentId // ignore: cast_nullable_to_non_nullable
as String,clientName: null == clientName ? _self.clientName : clientName // ignore: cast_nullable_to_non_nullable
as String,clientAddress: null == clientAddress ? _self.clientAddress : clientAddress // ignore: cast_nullable_to_non_nullable
as String,eventType: null == eventType ? _self.eventType : eventType // ignore: cast_nullable_to_non_nullable
as GeofenceEventType,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,distanceMeters: freezed == distanceMeters ? _self.distanceMeters : distanceMeters // ignore: cast_nullable_to_non_nullable
as double?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [GeofenceEvent].
extension GeofenceEventPatterns on GeofenceEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GeofenceEvent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GeofenceEvent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GeofenceEvent value)  $default,){
final _that = this;
switch (_that) {
case _GeofenceEvent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GeofenceEvent value)?  $default,){
final _that = this;
switch (_that) {
case _GeofenceEvent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String eventId,  String workerId,  String workerName,  String appointmentId,  String clientName,  String clientAddress,  GeofenceEventType eventType,  DateTime timestamp,  double latitude,  double longitude,  double? distanceMeters,  String? notes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GeofenceEvent() when $default != null:
return $default(_that.eventId,_that.workerId,_that.workerName,_that.appointmentId,_that.clientName,_that.clientAddress,_that.eventType,_that.timestamp,_that.latitude,_that.longitude,_that.distanceMeters,_that.notes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String eventId,  String workerId,  String workerName,  String appointmentId,  String clientName,  String clientAddress,  GeofenceEventType eventType,  DateTime timestamp,  double latitude,  double longitude,  double? distanceMeters,  String? notes)  $default,) {final _that = this;
switch (_that) {
case _GeofenceEvent():
return $default(_that.eventId,_that.workerId,_that.workerName,_that.appointmentId,_that.clientName,_that.clientAddress,_that.eventType,_that.timestamp,_that.latitude,_that.longitude,_that.distanceMeters,_that.notes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String eventId,  String workerId,  String workerName,  String appointmentId,  String clientName,  String clientAddress,  GeofenceEventType eventType,  DateTime timestamp,  double latitude,  double longitude,  double? distanceMeters,  String? notes)?  $default,) {final _that = this;
switch (_that) {
case _GeofenceEvent() when $default != null:
return $default(_that.eventId,_that.workerId,_that.workerName,_that.appointmentId,_that.clientName,_that.clientAddress,_that.eventType,_that.timestamp,_that.latitude,_that.longitude,_that.distanceMeters,_that.notes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GeofenceEvent implements GeofenceEvent {
  const _GeofenceEvent({required this.eventId, required this.workerId, required this.workerName, required this.appointmentId, required this.clientName, required this.clientAddress, required this.eventType, required this.timestamp, required this.latitude, required this.longitude, this.distanceMeters, this.notes});
  factory _GeofenceEvent.fromJson(Map<String, dynamic> json) => _$GeofenceEventFromJson(json);

@override final  String eventId;
@override final  String workerId;
@override final  String workerName;
@override final  String appointmentId;
@override final  String clientName;
@override final  String clientAddress;
@override final  GeofenceEventType eventType;
@override final  DateTime timestamp;
@override final  double latitude;
@override final  double longitude;
@override final  double? distanceMeters;
@override final  String? notes;

/// Create a copy of GeofenceEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GeofenceEventCopyWith<_GeofenceEvent> get copyWith => __$GeofenceEventCopyWithImpl<_GeofenceEvent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GeofenceEventToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GeofenceEvent&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.workerId, workerId) || other.workerId == workerId)&&(identical(other.workerName, workerName) || other.workerName == workerName)&&(identical(other.appointmentId, appointmentId) || other.appointmentId == appointmentId)&&(identical(other.clientName, clientName) || other.clientName == clientName)&&(identical(other.clientAddress, clientAddress) || other.clientAddress == clientAddress)&&(identical(other.eventType, eventType) || other.eventType == eventType)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.distanceMeters, distanceMeters) || other.distanceMeters == distanceMeters)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,workerId,workerName,appointmentId,clientName,clientAddress,eventType,timestamp,latitude,longitude,distanceMeters,notes);

@override
String toString() {
  return 'GeofenceEvent(eventId: $eventId, workerId: $workerId, workerName: $workerName, appointmentId: $appointmentId, clientName: $clientName, clientAddress: $clientAddress, eventType: $eventType, timestamp: $timestamp, latitude: $latitude, longitude: $longitude, distanceMeters: $distanceMeters, notes: $notes)';
}


}

/// @nodoc
abstract mixin class _$GeofenceEventCopyWith<$Res> implements $GeofenceEventCopyWith<$Res> {
  factory _$GeofenceEventCopyWith(_GeofenceEvent value, $Res Function(_GeofenceEvent) _then) = __$GeofenceEventCopyWithImpl;
@override @useResult
$Res call({
 String eventId, String workerId, String workerName, String appointmentId, String clientName, String clientAddress, GeofenceEventType eventType, DateTime timestamp, double latitude, double longitude, double? distanceMeters, String? notes
});




}
/// @nodoc
class __$GeofenceEventCopyWithImpl<$Res>
    implements _$GeofenceEventCopyWith<$Res> {
  __$GeofenceEventCopyWithImpl(this._self, this._then);

  final _GeofenceEvent _self;
  final $Res Function(_GeofenceEvent) _then;

/// Create a copy of GeofenceEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? workerId = null,Object? workerName = null,Object? appointmentId = null,Object? clientName = null,Object? clientAddress = null,Object? eventType = null,Object? timestamp = null,Object? latitude = null,Object? longitude = null,Object? distanceMeters = freezed,Object? notes = freezed,}) {
  return _then(_GeofenceEvent(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,workerId: null == workerId ? _self.workerId : workerId // ignore: cast_nullable_to_non_nullable
as String,workerName: null == workerName ? _self.workerName : workerName // ignore: cast_nullable_to_non_nullable
as String,appointmentId: null == appointmentId ? _self.appointmentId : appointmentId // ignore: cast_nullable_to_non_nullable
as String,clientName: null == clientName ? _self.clientName : clientName // ignore: cast_nullable_to_non_nullable
as String,clientAddress: null == clientAddress ? _self.clientAddress : clientAddress // ignore: cast_nullable_to_non_nullable
as String,eventType: null == eventType ? _self.eventType : eventType // ignore: cast_nullable_to_non_nullable
as GeofenceEventType,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,distanceMeters: freezed == distanceMeters ? _self.distanceMeters : distanceMeters // ignore: cast_nullable_to_non_nullable
as double?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ShiftChangeNotification {

 String get notificationId; String get shiftId; String get workerId; String get workerName; String get clientName; ShiftChangeType get changeType; DateTime get shiftDate; String get shiftTime; String? get oldTime; String? get newTime; String? get reason; String? get replacementWorkerId; String? get replacementWorkerName; DateTime get timestamp;
/// Create a copy of ShiftChangeNotification
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShiftChangeNotificationCopyWith<ShiftChangeNotification> get copyWith => _$ShiftChangeNotificationCopyWithImpl<ShiftChangeNotification>(this as ShiftChangeNotification, _$identity);

  /// Serializes this ShiftChangeNotification to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShiftChangeNotification&&(identical(other.notificationId, notificationId) || other.notificationId == notificationId)&&(identical(other.shiftId, shiftId) || other.shiftId == shiftId)&&(identical(other.workerId, workerId) || other.workerId == workerId)&&(identical(other.workerName, workerName) || other.workerName == workerName)&&(identical(other.clientName, clientName) || other.clientName == clientName)&&(identical(other.changeType, changeType) || other.changeType == changeType)&&(identical(other.shiftDate, shiftDate) || other.shiftDate == shiftDate)&&(identical(other.shiftTime, shiftTime) || other.shiftTime == shiftTime)&&(identical(other.oldTime, oldTime) || other.oldTime == oldTime)&&(identical(other.newTime, newTime) || other.newTime == newTime)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.replacementWorkerId, replacementWorkerId) || other.replacementWorkerId == replacementWorkerId)&&(identical(other.replacementWorkerName, replacementWorkerName) || other.replacementWorkerName == replacementWorkerName)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,notificationId,shiftId,workerId,workerName,clientName,changeType,shiftDate,shiftTime,oldTime,newTime,reason,replacementWorkerId,replacementWorkerName,timestamp);

@override
String toString() {
  return 'ShiftChangeNotification(notificationId: $notificationId, shiftId: $shiftId, workerId: $workerId, workerName: $workerName, clientName: $clientName, changeType: $changeType, shiftDate: $shiftDate, shiftTime: $shiftTime, oldTime: $oldTime, newTime: $newTime, reason: $reason, replacementWorkerId: $replacementWorkerId, replacementWorkerName: $replacementWorkerName, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class $ShiftChangeNotificationCopyWith<$Res>  {
  factory $ShiftChangeNotificationCopyWith(ShiftChangeNotification value, $Res Function(ShiftChangeNotification) _then) = _$ShiftChangeNotificationCopyWithImpl;
@useResult
$Res call({
 String notificationId, String shiftId, String workerId, String workerName, String clientName, ShiftChangeType changeType, DateTime shiftDate, String shiftTime, String? oldTime, String? newTime, String? reason, String? replacementWorkerId, String? replacementWorkerName, DateTime timestamp
});




}
/// @nodoc
class _$ShiftChangeNotificationCopyWithImpl<$Res>
    implements $ShiftChangeNotificationCopyWith<$Res> {
  _$ShiftChangeNotificationCopyWithImpl(this._self, this._then);

  final ShiftChangeNotification _self;
  final $Res Function(ShiftChangeNotification) _then;

/// Create a copy of ShiftChangeNotification
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? notificationId = null,Object? shiftId = null,Object? workerId = null,Object? workerName = null,Object? clientName = null,Object? changeType = null,Object? shiftDate = null,Object? shiftTime = null,Object? oldTime = freezed,Object? newTime = freezed,Object? reason = freezed,Object? replacementWorkerId = freezed,Object? replacementWorkerName = freezed,Object? timestamp = null,}) {
  return _then(_self.copyWith(
notificationId: null == notificationId ? _self.notificationId : notificationId // ignore: cast_nullable_to_non_nullable
as String,shiftId: null == shiftId ? _self.shiftId : shiftId // ignore: cast_nullable_to_non_nullable
as String,workerId: null == workerId ? _self.workerId : workerId // ignore: cast_nullable_to_non_nullable
as String,workerName: null == workerName ? _self.workerName : workerName // ignore: cast_nullable_to_non_nullable
as String,clientName: null == clientName ? _self.clientName : clientName // ignore: cast_nullable_to_non_nullable
as String,changeType: null == changeType ? _self.changeType : changeType // ignore: cast_nullable_to_non_nullable
as ShiftChangeType,shiftDate: null == shiftDate ? _self.shiftDate : shiftDate // ignore: cast_nullable_to_non_nullable
as DateTime,shiftTime: null == shiftTime ? _self.shiftTime : shiftTime // ignore: cast_nullable_to_non_nullable
as String,oldTime: freezed == oldTime ? _self.oldTime : oldTime // ignore: cast_nullable_to_non_nullable
as String?,newTime: freezed == newTime ? _self.newTime : newTime // ignore: cast_nullable_to_non_nullable
as String?,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,replacementWorkerId: freezed == replacementWorkerId ? _self.replacementWorkerId : replacementWorkerId // ignore: cast_nullable_to_non_nullable
as String?,replacementWorkerName: freezed == replacementWorkerName ? _self.replacementWorkerName : replacementWorkerName // ignore: cast_nullable_to_non_nullable
as String?,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [ShiftChangeNotification].
extension ShiftChangeNotificationPatterns on ShiftChangeNotification {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShiftChangeNotification value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShiftChangeNotification() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShiftChangeNotification value)  $default,){
final _that = this;
switch (_that) {
case _ShiftChangeNotification():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShiftChangeNotification value)?  $default,){
final _that = this;
switch (_that) {
case _ShiftChangeNotification() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String notificationId,  String shiftId,  String workerId,  String workerName,  String clientName,  ShiftChangeType changeType,  DateTime shiftDate,  String shiftTime,  String? oldTime,  String? newTime,  String? reason,  String? replacementWorkerId,  String? replacementWorkerName,  DateTime timestamp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShiftChangeNotification() when $default != null:
return $default(_that.notificationId,_that.shiftId,_that.workerId,_that.workerName,_that.clientName,_that.changeType,_that.shiftDate,_that.shiftTime,_that.oldTime,_that.newTime,_that.reason,_that.replacementWorkerId,_that.replacementWorkerName,_that.timestamp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String notificationId,  String shiftId,  String workerId,  String workerName,  String clientName,  ShiftChangeType changeType,  DateTime shiftDate,  String shiftTime,  String? oldTime,  String? newTime,  String? reason,  String? replacementWorkerId,  String? replacementWorkerName,  DateTime timestamp)  $default,) {final _that = this;
switch (_that) {
case _ShiftChangeNotification():
return $default(_that.notificationId,_that.shiftId,_that.workerId,_that.workerName,_that.clientName,_that.changeType,_that.shiftDate,_that.shiftTime,_that.oldTime,_that.newTime,_that.reason,_that.replacementWorkerId,_that.replacementWorkerName,_that.timestamp);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String notificationId,  String shiftId,  String workerId,  String workerName,  String clientName,  ShiftChangeType changeType,  DateTime shiftDate,  String shiftTime,  String? oldTime,  String? newTime,  String? reason,  String? replacementWorkerId,  String? replacementWorkerName,  DateTime timestamp)?  $default,) {final _that = this;
switch (_that) {
case _ShiftChangeNotification() when $default != null:
return $default(_that.notificationId,_that.shiftId,_that.workerId,_that.workerName,_that.clientName,_that.changeType,_that.shiftDate,_that.shiftTime,_that.oldTime,_that.newTime,_that.reason,_that.replacementWorkerId,_that.replacementWorkerName,_that.timestamp);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ShiftChangeNotification implements ShiftChangeNotification {
  const _ShiftChangeNotification({required this.notificationId, required this.shiftId, required this.workerId, required this.workerName, required this.clientName, required this.changeType, required this.shiftDate, required this.shiftTime, this.oldTime, this.newTime, this.reason, this.replacementWorkerId, this.replacementWorkerName, required this.timestamp});
  factory _ShiftChangeNotification.fromJson(Map<String, dynamic> json) => _$ShiftChangeNotificationFromJson(json);

@override final  String notificationId;
@override final  String shiftId;
@override final  String workerId;
@override final  String workerName;
@override final  String clientName;
@override final  ShiftChangeType changeType;
@override final  DateTime shiftDate;
@override final  String shiftTime;
@override final  String? oldTime;
@override final  String? newTime;
@override final  String? reason;
@override final  String? replacementWorkerId;
@override final  String? replacementWorkerName;
@override final  DateTime timestamp;

/// Create a copy of ShiftChangeNotification
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShiftChangeNotificationCopyWith<_ShiftChangeNotification> get copyWith => __$ShiftChangeNotificationCopyWithImpl<_ShiftChangeNotification>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ShiftChangeNotificationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShiftChangeNotification&&(identical(other.notificationId, notificationId) || other.notificationId == notificationId)&&(identical(other.shiftId, shiftId) || other.shiftId == shiftId)&&(identical(other.workerId, workerId) || other.workerId == workerId)&&(identical(other.workerName, workerName) || other.workerName == workerName)&&(identical(other.clientName, clientName) || other.clientName == clientName)&&(identical(other.changeType, changeType) || other.changeType == changeType)&&(identical(other.shiftDate, shiftDate) || other.shiftDate == shiftDate)&&(identical(other.shiftTime, shiftTime) || other.shiftTime == shiftTime)&&(identical(other.oldTime, oldTime) || other.oldTime == oldTime)&&(identical(other.newTime, newTime) || other.newTime == newTime)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.replacementWorkerId, replacementWorkerId) || other.replacementWorkerId == replacementWorkerId)&&(identical(other.replacementWorkerName, replacementWorkerName) || other.replacementWorkerName == replacementWorkerName)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,notificationId,shiftId,workerId,workerName,clientName,changeType,shiftDate,shiftTime,oldTime,newTime,reason,replacementWorkerId,replacementWorkerName,timestamp);

@override
String toString() {
  return 'ShiftChangeNotification(notificationId: $notificationId, shiftId: $shiftId, workerId: $workerId, workerName: $workerName, clientName: $clientName, changeType: $changeType, shiftDate: $shiftDate, shiftTime: $shiftTime, oldTime: $oldTime, newTime: $newTime, reason: $reason, replacementWorkerId: $replacementWorkerId, replacementWorkerName: $replacementWorkerName, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class _$ShiftChangeNotificationCopyWith<$Res> implements $ShiftChangeNotificationCopyWith<$Res> {
  factory _$ShiftChangeNotificationCopyWith(_ShiftChangeNotification value, $Res Function(_ShiftChangeNotification) _then) = __$ShiftChangeNotificationCopyWithImpl;
@override @useResult
$Res call({
 String notificationId, String shiftId, String workerId, String workerName, String clientName, ShiftChangeType changeType, DateTime shiftDate, String shiftTime, String? oldTime, String? newTime, String? reason, String? replacementWorkerId, String? replacementWorkerName, DateTime timestamp
});




}
/// @nodoc
class __$ShiftChangeNotificationCopyWithImpl<$Res>
    implements _$ShiftChangeNotificationCopyWith<$Res> {
  __$ShiftChangeNotificationCopyWithImpl(this._self, this._then);

  final _ShiftChangeNotification _self;
  final $Res Function(_ShiftChangeNotification) _then;

/// Create a copy of ShiftChangeNotification
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? notificationId = null,Object? shiftId = null,Object? workerId = null,Object? workerName = null,Object? clientName = null,Object? changeType = null,Object? shiftDate = null,Object? shiftTime = null,Object? oldTime = freezed,Object? newTime = freezed,Object? reason = freezed,Object? replacementWorkerId = freezed,Object? replacementWorkerName = freezed,Object? timestamp = null,}) {
  return _then(_ShiftChangeNotification(
notificationId: null == notificationId ? _self.notificationId : notificationId // ignore: cast_nullable_to_non_nullable
as String,shiftId: null == shiftId ? _self.shiftId : shiftId // ignore: cast_nullable_to_non_nullable
as String,workerId: null == workerId ? _self.workerId : workerId // ignore: cast_nullable_to_non_nullable
as String,workerName: null == workerName ? _self.workerName : workerName // ignore: cast_nullable_to_non_nullable
as String,clientName: null == clientName ? _self.clientName : clientName // ignore: cast_nullable_to_non_nullable
as String,changeType: null == changeType ? _self.changeType : changeType // ignore: cast_nullable_to_non_nullable
as ShiftChangeType,shiftDate: null == shiftDate ? _self.shiftDate : shiftDate // ignore: cast_nullable_to_non_nullable
as DateTime,shiftTime: null == shiftTime ? _self.shiftTime : shiftTime // ignore: cast_nullable_to_non_nullable
as String,oldTime: freezed == oldTime ? _self.oldTime : oldTime // ignore: cast_nullable_to_non_nullable
as String?,newTime: freezed == newTime ? _self.newTime : newTime // ignore: cast_nullable_to_non_nullable
as String?,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,replacementWorkerId: freezed == replacementWorkerId ? _self.replacementWorkerId : replacementWorkerId // ignore: cast_nullable_to_non_nullable
as String?,replacementWorkerName: freezed == replacementWorkerName ? _self.replacementWorkerName : replacementWorkerName // ignore: cast_nullable_to_non_nullable
as String?,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$SmartTimingRecommendation {

 String get userId; NotificationCategory get category; DateTime get recommendedTime; double get confidence; String get reason; Map<String, dynamic>? get metadata;
/// Create a copy of SmartTimingRecommendation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SmartTimingRecommendationCopyWith<SmartTimingRecommendation> get copyWith => _$SmartTimingRecommendationCopyWithImpl<SmartTimingRecommendation>(this as SmartTimingRecommendation, _$identity);

  /// Serializes this SmartTimingRecommendation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SmartTimingRecommendation&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.category, category) || other.category == category)&&(identical(other.recommendedTime, recommendedTime) || other.recommendedTime == recommendedTime)&&(identical(other.confidence, confidence) || other.confidence == confidence)&&(identical(other.reason, reason) || other.reason == reason)&&const DeepCollectionEquality().equals(other.metadata, metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,category,recommendedTime,confidence,reason,const DeepCollectionEquality().hash(metadata));

@override
String toString() {
  return 'SmartTimingRecommendation(userId: $userId, category: $category, recommendedTime: $recommendedTime, confidence: $confidence, reason: $reason, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $SmartTimingRecommendationCopyWith<$Res>  {
  factory $SmartTimingRecommendationCopyWith(SmartTimingRecommendation value, $Res Function(SmartTimingRecommendation) _then) = _$SmartTimingRecommendationCopyWithImpl;
@useResult
$Res call({
 String userId, NotificationCategory category, DateTime recommendedTime, double confidence, String reason, Map<String, dynamic>? metadata
});




}
/// @nodoc
class _$SmartTimingRecommendationCopyWithImpl<$Res>
    implements $SmartTimingRecommendationCopyWith<$Res> {
  _$SmartTimingRecommendationCopyWithImpl(this._self, this._then);

  final SmartTimingRecommendation _self;
  final $Res Function(SmartTimingRecommendation) _then;

/// Create a copy of SmartTimingRecommendation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? category = null,Object? recommendedTime = null,Object? confidence = null,Object? reason = null,Object? metadata = freezed,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as NotificationCategory,recommendedTime: null == recommendedTime ? _self.recommendedTime : recommendedTime // ignore: cast_nullable_to_non_nullable
as DateTime,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as double,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,metadata: freezed == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [SmartTimingRecommendation].
extension SmartTimingRecommendationPatterns on SmartTimingRecommendation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SmartTimingRecommendation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SmartTimingRecommendation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SmartTimingRecommendation value)  $default,){
final _that = this;
switch (_that) {
case _SmartTimingRecommendation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SmartTimingRecommendation value)?  $default,){
final _that = this;
switch (_that) {
case _SmartTimingRecommendation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  NotificationCategory category,  DateTime recommendedTime,  double confidence,  String reason,  Map<String, dynamic>? metadata)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SmartTimingRecommendation() when $default != null:
return $default(_that.userId,_that.category,_that.recommendedTime,_that.confidence,_that.reason,_that.metadata);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  NotificationCategory category,  DateTime recommendedTime,  double confidence,  String reason,  Map<String, dynamic>? metadata)  $default,) {final _that = this;
switch (_that) {
case _SmartTimingRecommendation():
return $default(_that.userId,_that.category,_that.recommendedTime,_that.confidence,_that.reason,_that.metadata);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  NotificationCategory category,  DateTime recommendedTime,  double confidence,  String reason,  Map<String, dynamic>? metadata)?  $default,) {final _that = this;
switch (_that) {
case _SmartTimingRecommendation() when $default != null:
return $default(_that.userId,_that.category,_that.recommendedTime,_that.confidence,_that.reason,_that.metadata);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SmartTimingRecommendation implements SmartTimingRecommendation {
  const _SmartTimingRecommendation({required this.userId, required this.category, required this.recommendedTime, required this.confidence, required this.reason, final  Map<String, dynamic>? metadata}): _metadata = metadata;
  factory _SmartTimingRecommendation.fromJson(Map<String, dynamic> json) => _$SmartTimingRecommendationFromJson(json);

@override final  String userId;
@override final  NotificationCategory category;
@override final  DateTime recommendedTime;
@override final  double confidence;
@override final  String reason;
 final  Map<String, dynamic>? _metadata;
@override Map<String, dynamic>? get metadata {
  final value = _metadata;
  if (value == null) return null;
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of SmartTimingRecommendation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SmartTimingRecommendationCopyWith<_SmartTimingRecommendation> get copyWith => __$SmartTimingRecommendationCopyWithImpl<_SmartTimingRecommendation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SmartTimingRecommendationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SmartTimingRecommendation&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.category, category) || other.category == category)&&(identical(other.recommendedTime, recommendedTime) || other.recommendedTime == recommendedTime)&&(identical(other.confidence, confidence) || other.confidence == confidence)&&(identical(other.reason, reason) || other.reason == reason)&&const DeepCollectionEquality().equals(other._metadata, _metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,category,recommendedTime,confidence,reason,const DeepCollectionEquality().hash(_metadata));

@override
String toString() {
  return 'SmartTimingRecommendation(userId: $userId, category: $category, recommendedTime: $recommendedTime, confidence: $confidence, reason: $reason, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class _$SmartTimingRecommendationCopyWith<$Res> implements $SmartTimingRecommendationCopyWith<$Res> {
  factory _$SmartTimingRecommendationCopyWith(_SmartTimingRecommendation value, $Res Function(_SmartTimingRecommendation) _then) = __$SmartTimingRecommendationCopyWithImpl;
@override @useResult
$Res call({
 String userId, NotificationCategory category, DateTime recommendedTime, double confidence, String reason, Map<String, dynamic>? metadata
});




}
/// @nodoc
class __$SmartTimingRecommendationCopyWithImpl<$Res>
    implements _$SmartTimingRecommendationCopyWith<$Res> {
  __$SmartTimingRecommendationCopyWithImpl(this._self, this._then);

  final _SmartTimingRecommendation _self;
  final $Res Function(_SmartTimingRecommendation) _then;

/// Create a copy of SmartTimingRecommendation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? category = null,Object? recommendedTime = null,Object? confidence = null,Object? reason = null,Object? metadata = freezed,}) {
  return _then(_SmartTimingRecommendation(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as NotificationCategory,recommendedTime: null == recommendedTime ? _self.recommendedTime : recommendedTime // ignore: cast_nullable_to_non_nullable
as DateTime,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as double,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}


/// @nodoc
mixin _$NotificationDeliveryStatus {

 String get notificationId; Map<NotificationChannel, DeliveryResult> get channelResults; DateTime get sentAt; DateTime? get deliveredAt; DateTime? get readAt; DateTime? get actionedAt;
/// Create a copy of NotificationDeliveryStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationDeliveryStatusCopyWith<NotificationDeliveryStatus> get copyWith => _$NotificationDeliveryStatusCopyWithImpl<NotificationDeliveryStatus>(this as NotificationDeliveryStatus, _$identity);

  /// Serializes this NotificationDeliveryStatus to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationDeliveryStatus&&(identical(other.notificationId, notificationId) || other.notificationId == notificationId)&&const DeepCollectionEquality().equals(other.channelResults, channelResults)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.deliveredAt, deliveredAt) || other.deliveredAt == deliveredAt)&&(identical(other.readAt, readAt) || other.readAt == readAt)&&(identical(other.actionedAt, actionedAt) || other.actionedAt == actionedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,notificationId,const DeepCollectionEquality().hash(channelResults),sentAt,deliveredAt,readAt,actionedAt);

@override
String toString() {
  return 'NotificationDeliveryStatus(notificationId: $notificationId, channelResults: $channelResults, sentAt: $sentAt, deliveredAt: $deliveredAt, readAt: $readAt, actionedAt: $actionedAt)';
}


}

/// @nodoc
abstract mixin class $NotificationDeliveryStatusCopyWith<$Res>  {
  factory $NotificationDeliveryStatusCopyWith(NotificationDeliveryStatus value, $Res Function(NotificationDeliveryStatus) _then) = _$NotificationDeliveryStatusCopyWithImpl;
@useResult
$Res call({
 String notificationId, Map<NotificationChannel, DeliveryResult> channelResults, DateTime sentAt, DateTime? deliveredAt, DateTime? readAt, DateTime? actionedAt
});




}
/// @nodoc
class _$NotificationDeliveryStatusCopyWithImpl<$Res>
    implements $NotificationDeliveryStatusCopyWith<$Res> {
  _$NotificationDeliveryStatusCopyWithImpl(this._self, this._then);

  final NotificationDeliveryStatus _self;
  final $Res Function(NotificationDeliveryStatus) _then;

/// Create a copy of NotificationDeliveryStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? notificationId = null,Object? channelResults = null,Object? sentAt = null,Object? deliveredAt = freezed,Object? readAt = freezed,Object? actionedAt = freezed,}) {
  return _then(_self.copyWith(
notificationId: null == notificationId ? _self.notificationId : notificationId // ignore: cast_nullable_to_non_nullable
as String,channelResults: null == channelResults ? _self.channelResults : channelResults // ignore: cast_nullable_to_non_nullable
as Map<NotificationChannel, DeliveryResult>,sentAt: null == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime,deliveredAt: freezed == deliveredAt ? _self.deliveredAt : deliveredAt // ignore: cast_nullable_to_non_nullable
as DateTime?,readAt: freezed == readAt ? _self.readAt : readAt // ignore: cast_nullable_to_non_nullable
as DateTime?,actionedAt: freezed == actionedAt ? _self.actionedAt : actionedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationDeliveryStatus].
extension NotificationDeliveryStatusPatterns on NotificationDeliveryStatus {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationDeliveryStatus value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationDeliveryStatus() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationDeliveryStatus value)  $default,){
final _that = this;
switch (_that) {
case _NotificationDeliveryStatus():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationDeliveryStatus value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationDeliveryStatus() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String notificationId,  Map<NotificationChannel, DeliveryResult> channelResults,  DateTime sentAt,  DateTime? deliveredAt,  DateTime? readAt,  DateTime? actionedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationDeliveryStatus() when $default != null:
return $default(_that.notificationId,_that.channelResults,_that.sentAt,_that.deliveredAt,_that.readAt,_that.actionedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String notificationId,  Map<NotificationChannel, DeliveryResult> channelResults,  DateTime sentAt,  DateTime? deliveredAt,  DateTime? readAt,  DateTime? actionedAt)  $default,) {final _that = this;
switch (_that) {
case _NotificationDeliveryStatus():
return $default(_that.notificationId,_that.channelResults,_that.sentAt,_that.deliveredAt,_that.readAt,_that.actionedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String notificationId,  Map<NotificationChannel, DeliveryResult> channelResults,  DateTime sentAt,  DateTime? deliveredAt,  DateTime? readAt,  DateTime? actionedAt)?  $default,) {final _that = this;
switch (_that) {
case _NotificationDeliveryStatus() when $default != null:
return $default(_that.notificationId,_that.channelResults,_that.sentAt,_that.deliveredAt,_that.readAt,_that.actionedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NotificationDeliveryStatus implements NotificationDeliveryStatus {
  const _NotificationDeliveryStatus({required this.notificationId, required final  Map<NotificationChannel, DeliveryResult> channelResults, required this.sentAt, this.deliveredAt, this.readAt, this.actionedAt}): _channelResults = channelResults;
  factory _NotificationDeliveryStatus.fromJson(Map<String, dynamic> json) => _$NotificationDeliveryStatusFromJson(json);

@override final  String notificationId;
 final  Map<NotificationChannel, DeliveryResult> _channelResults;
@override Map<NotificationChannel, DeliveryResult> get channelResults {
  if (_channelResults is EqualUnmodifiableMapView) return _channelResults;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_channelResults);
}

@override final  DateTime sentAt;
@override final  DateTime? deliveredAt;
@override final  DateTime? readAt;
@override final  DateTime? actionedAt;

/// Create a copy of NotificationDeliveryStatus
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationDeliveryStatusCopyWith<_NotificationDeliveryStatus> get copyWith => __$NotificationDeliveryStatusCopyWithImpl<_NotificationDeliveryStatus>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationDeliveryStatusToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationDeliveryStatus&&(identical(other.notificationId, notificationId) || other.notificationId == notificationId)&&const DeepCollectionEquality().equals(other._channelResults, _channelResults)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.deliveredAt, deliveredAt) || other.deliveredAt == deliveredAt)&&(identical(other.readAt, readAt) || other.readAt == readAt)&&(identical(other.actionedAt, actionedAt) || other.actionedAt == actionedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,notificationId,const DeepCollectionEquality().hash(_channelResults),sentAt,deliveredAt,readAt,actionedAt);

@override
String toString() {
  return 'NotificationDeliveryStatus(notificationId: $notificationId, channelResults: $channelResults, sentAt: $sentAt, deliveredAt: $deliveredAt, readAt: $readAt, actionedAt: $actionedAt)';
}


}

/// @nodoc
abstract mixin class _$NotificationDeliveryStatusCopyWith<$Res> implements $NotificationDeliveryStatusCopyWith<$Res> {
  factory _$NotificationDeliveryStatusCopyWith(_NotificationDeliveryStatus value, $Res Function(_NotificationDeliveryStatus) _then) = __$NotificationDeliveryStatusCopyWithImpl;
@override @useResult
$Res call({
 String notificationId, Map<NotificationChannel, DeliveryResult> channelResults, DateTime sentAt, DateTime? deliveredAt, DateTime? readAt, DateTime? actionedAt
});




}
/// @nodoc
class __$NotificationDeliveryStatusCopyWithImpl<$Res>
    implements _$NotificationDeliveryStatusCopyWith<$Res> {
  __$NotificationDeliveryStatusCopyWithImpl(this._self, this._then);

  final _NotificationDeliveryStatus _self;
  final $Res Function(_NotificationDeliveryStatus) _then;

/// Create a copy of NotificationDeliveryStatus
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? notificationId = null,Object? channelResults = null,Object? sentAt = null,Object? deliveredAt = freezed,Object? readAt = freezed,Object? actionedAt = freezed,}) {
  return _then(_NotificationDeliveryStatus(
notificationId: null == notificationId ? _self.notificationId : notificationId // ignore: cast_nullable_to_non_nullable
as String,channelResults: null == channelResults ? _self._channelResults : channelResults // ignore: cast_nullable_to_non_nullable
as Map<NotificationChannel, DeliveryResult>,sentAt: null == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime,deliveredAt: freezed == deliveredAt ? _self.deliveredAt : deliveredAt // ignore: cast_nullable_to_non_nullable
as DateTime?,readAt: freezed == readAt ? _self.readAt : readAt // ignore: cast_nullable_to_non_nullable
as DateTime?,actionedAt: freezed == actionedAt ? _self.actionedAt : actionedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$DeliveryResult {

 bool get success; String? get errorMessage; String? get messageId; DateTime? get timestamp;
/// Create a copy of DeliveryResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeliveryResultCopyWith<DeliveryResult> get copyWith => _$DeliveryResultCopyWithImpl<DeliveryResult>(this as DeliveryResult, _$identity);

  /// Serializes this DeliveryResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeliveryResult&&(identical(other.success, success) || other.success == success)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.messageId, messageId) || other.messageId == messageId)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,errorMessage,messageId,timestamp);

@override
String toString() {
  return 'DeliveryResult(success: $success, errorMessage: $errorMessage, messageId: $messageId, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class $DeliveryResultCopyWith<$Res>  {
  factory $DeliveryResultCopyWith(DeliveryResult value, $Res Function(DeliveryResult) _then) = _$DeliveryResultCopyWithImpl;
@useResult
$Res call({
 bool success, String? errorMessage, String? messageId, DateTime? timestamp
});




}
/// @nodoc
class _$DeliveryResultCopyWithImpl<$Res>
    implements $DeliveryResultCopyWith<$Res> {
  _$DeliveryResultCopyWithImpl(this._self, this._then);

  final DeliveryResult _self;
  final $Res Function(DeliveryResult) _then;

/// Create a copy of DeliveryResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? errorMessage = freezed,Object? messageId = freezed,Object? timestamp = freezed,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,messageId: freezed == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as String?,timestamp: freezed == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [DeliveryResult].
extension DeliveryResultPatterns on DeliveryResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DeliveryResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeliveryResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DeliveryResult value)  $default,){
final _that = this;
switch (_that) {
case _DeliveryResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DeliveryResult value)?  $default,){
final _that = this;
switch (_that) {
case _DeliveryResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  String? errorMessage,  String? messageId,  DateTime? timestamp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeliveryResult() when $default != null:
return $default(_that.success,_that.errorMessage,_that.messageId,_that.timestamp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  String? errorMessage,  String? messageId,  DateTime? timestamp)  $default,) {final _that = this;
switch (_that) {
case _DeliveryResult():
return $default(_that.success,_that.errorMessage,_that.messageId,_that.timestamp);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  String? errorMessage,  String? messageId,  DateTime? timestamp)?  $default,) {final _that = this;
switch (_that) {
case _DeliveryResult() when $default != null:
return $default(_that.success,_that.errorMessage,_that.messageId,_that.timestamp);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DeliveryResult implements DeliveryResult {
  const _DeliveryResult({required this.success, this.errorMessage, this.messageId, this.timestamp});
  factory _DeliveryResult.fromJson(Map<String, dynamic> json) => _$DeliveryResultFromJson(json);

@override final  bool success;
@override final  String? errorMessage;
@override final  String? messageId;
@override final  DateTime? timestamp;

/// Create a copy of DeliveryResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeliveryResultCopyWith<_DeliveryResult> get copyWith => __$DeliveryResultCopyWithImpl<_DeliveryResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DeliveryResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeliveryResult&&(identical(other.success, success) || other.success == success)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.messageId, messageId) || other.messageId == messageId)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,errorMessage,messageId,timestamp);

@override
String toString() {
  return 'DeliveryResult(success: $success, errorMessage: $errorMessage, messageId: $messageId, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class _$DeliveryResultCopyWith<$Res> implements $DeliveryResultCopyWith<$Res> {
  factory _$DeliveryResultCopyWith(_DeliveryResult value, $Res Function(_DeliveryResult) _then) = __$DeliveryResultCopyWithImpl;
@override @useResult
$Res call({
 bool success, String? errorMessage, String? messageId, DateTime? timestamp
});




}
/// @nodoc
class __$DeliveryResultCopyWithImpl<$Res>
    implements _$DeliveryResultCopyWith<$Res> {
  __$DeliveryResultCopyWithImpl(this._self, this._then);

  final _DeliveryResult _self;
  final $Res Function(_DeliveryResult) _then;

/// Create a copy of DeliveryResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? errorMessage = freezed,Object? messageId = freezed,Object? timestamp = freezed,}) {
  return _then(_DeliveryResult(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,messageId: freezed == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as String?,timestamp: freezed == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
