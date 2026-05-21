// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'realtime_portal_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LiveLocation {
  String get appointmentId;
  String get workerId;
  double get latitude;
  double get longitude;
  double get accuracy;
  DateTime get timestamp;
  double? get distance;
  int? get eta;
  String? get status;

  /// Create a copy of LiveLocation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LiveLocationCopyWith<LiveLocation> get copyWith =>
      _$LiveLocationCopyWithImpl<LiveLocation>(
          this as LiveLocation, _$identity);

  /// Serializes this LiveLocation to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LiveLocation &&
            (identical(other.appointmentId, appointmentId) ||
                other.appointmentId == appointmentId) &&
            (identical(other.workerId, workerId) ||
                other.workerId == workerId) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.accuracy, accuracy) ||
                other.accuracy == accuracy) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.distance, distance) ||
                other.distance == distance) &&
            (identical(other.eta, eta) || other.eta == eta) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, appointmentId, workerId,
      latitude, longitude, accuracy, timestamp, distance, eta, status);

  @override
  String toString() {
    return 'LiveLocation(appointmentId: $appointmentId, workerId: $workerId, latitude: $latitude, longitude: $longitude, accuracy: $accuracy, timestamp: $timestamp, distance: $distance, eta: $eta, status: $status)';
  }
}

/// @nodoc
abstract mixin class $LiveLocationCopyWith<$Res> {
  factory $LiveLocationCopyWith(
          LiveLocation value, $Res Function(LiveLocation) _then) =
      _$LiveLocationCopyWithImpl;
  @useResult
  $Res call(
      {String appointmentId,
      String workerId,
      double latitude,
      double longitude,
      double accuracy,
      DateTime timestamp,
      double? distance,
      int? eta,
      String? status});
}

/// @nodoc
class _$LiveLocationCopyWithImpl<$Res> implements $LiveLocationCopyWith<$Res> {
  _$LiveLocationCopyWithImpl(this._self, this._then);

  final LiveLocation _self;
  final $Res Function(LiveLocation) _then;

  /// Create a copy of LiveLocation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appointmentId = null,
    Object? workerId = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? accuracy = null,
    Object? timestamp = null,
    Object? distance = freezed,
    Object? eta = freezed,
    Object? status = freezed,
  }) {
    return _then(_self.copyWith(
      appointmentId: null == appointmentId
          ? _self.appointmentId
          : appointmentId // ignore: cast_nullable_to_non_nullable
              as String,
      workerId: null == workerId
          ? _self.workerId
          : workerId // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: null == latitude
          ? _self.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _self.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      accuracy: null == accuracy
          ? _self.accuracy
          : accuracy // ignore: cast_nullable_to_non_nullable
              as double,
      timestamp: null == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      distance: freezed == distance
          ? _self.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double?,
      eta: freezed == eta
          ? _self.eta
          : eta // ignore: cast_nullable_to_non_nullable
              as int?,
      status: freezed == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [LiveLocation].
extension LiveLocationPatterns on LiveLocation {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_LiveLocation value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LiveLocation() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_LiveLocation value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LiveLocation():
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_LiveLocation value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LiveLocation() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String appointmentId,
            String workerId,
            double latitude,
            double longitude,
            double accuracy,
            DateTime timestamp,
            double? distance,
            int? eta,
            String? status)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LiveLocation() when $default != null:
        return $default(
            _that.appointmentId,
            _that.workerId,
            _that.latitude,
            _that.longitude,
            _that.accuracy,
            _that.timestamp,
            _that.distance,
            _that.eta,
            _that.status);
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String appointmentId,
            String workerId,
            double latitude,
            double longitude,
            double accuracy,
            DateTime timestamp,
            double? distance,
            int? eta,
            String? status)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LiveLocation():
        return $default(
            _that.appointmentId,
            _that.workerId,
            _that.latitude,
            _that.longitude,
            _that.accuracy,
            _that.timestamp,
            _that.distance,
            _that.eta,
            _that.status);
      case _:
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String appointmentId,
            String workerId,
            double latitude,
            double longitude,
            double accuracy,
            DateTime timestamp,
            double? distance,
            int? eta,
            String? status)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LiveLocation() when $default != null:
        return $default(
            _that.appointmentId,
            _that.workerId,
            _that.latitude,
            _that.longitude,
            _that.accuracy,
            _that.timestamp,
            _that.distance,
            _that.eta,
            _that.status);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _LiveLocation implements LiveLocation {
  const _LiveLocation(
      {required this.appointmentId,
      required this.workerId,
      required this.latitude,
      required this.longitude,
      required this.accuracy,
      required this.timestamp,
      this.distance,
      this.eta,
      this.status});
  factory _LiveLocation.fromJson(Map<String, dynamic> json) =>
      _$LiveLocationFromJson(json);

  @override
  final String appointmentId;
  @override
  final String workerId;
  @override
  final double latitude;
  @override
  final double longitude;
  @override
  final double accuracy;
  @override
  final DateTime timestamp;
  @override
  final double? distance;
  @override
  final int? eta;
  @override
  final String? status;

  /// Create a copy of LiveLocation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LiveLocationCopyWith<_LiveLocation> get copyWith =>
      __$LiveLocationCopyWithImpl<_LiveLocation>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$LiveLocationToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LiveLocation &&
            (identical(other.appointmentId, appointmentId) ||
                other.appointmentId == appointmentId) &&
            (identical(other.workerId, workerId) ||
                other.workerId == workerId) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.accuracy, accuracy) ||
                other.accuracy == accuracy) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.distance, distance) ||
                other.distance == distance) &&
            (identical(other.eta, eta) || other.eta == eta) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, appointmentId, workerId,
      latitude, longitude, accuracy, timestamp, distance, eta, status);

  @override
  String toString() {
    return 'LiveLocation(appointmentId: $appointmentId, workerId: $workerId, latitude: $latitude, longitude: $longitude, accuracy: $accuracy, timestamp: $timestamp, distance: $distance, eta: $eta, status: $status)';
  }
}

/// @nodoc
abstract mixin class _$LiveLocationCopyWith<$Res>
    implements $LiveLocationCopyWith<$Res> {
  factory _$LiveLocationCopyWith(
          _LiveLocation value, $Res Function(_LiveLocation) _then) =
      __$LiveLocationCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String appointmentId,
      String workerId,
      double latitude,
      double longitude,
      double accuracy,
      DateTime timestamp,
      double? distance,
      int? eta,
      String? status});
}

/// @nodoc
class __$LiveLocationCopyWithImpl<$Res>
    implements _$LiveLocationCopyWith<$Res> {
  __$LiveLocationCopyWithImpl(this._self, this._then);

  final _LiveLocation _self;
  final $Res Function(_LiveLocation) _then;

  /// Create a copy of LiveLocation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? appointmentId = null,
    Object? workerId = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? accuracy = null,
    Object? timestamp = null,
    Object? distance = freezed,
    Object? eta = freezed,
    Object? status = freezed,
  }) {
    return _then(_LiveLocation(
      appointmentId: null == appointmentId
          ? _self.appointmentId
          : appointmentId // ignore: cast_nullable_to_non_nullable
              as String,
      workerId: null == workerId
          ? _self.workerId
          : workerId // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: null == latitude
          ? _self.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _self.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      accuracy: null == accuracy
          ? _self.accuracy
          : accuracy // ignore: cast_nullable_to_non_nullable
              as double,
      timestamp: null == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      distance: freezed == distance
          ? _self.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double?,
      eta: freezed == eta
          ? _self.eta
          : eta // ignore: cast_nullable_to_non_nullable
              as int?,
      status: freezed == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$LocationUpdate {
  double get latitude;
  double get longitude;
  double get accuracy;
  DateTime get timestamp;

  /// Create a copy of LocationUpdate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LocationUpdateCopyWith<LocationUpdate> get copyWith =>
      _$LocationUpdateCopyWithImpl<LocationUpdate>(
          this as LocationUpdate, _$identity);

  /// Serializes this LocationUpdate to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LocationUpdate &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.accuracy, accuracy) ||
                other.accuracy == accuracy) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, latitude, longitude, accuracy, timestamp);

  @override
  String toString() {
    return 'LocationUpdate(latitude: $latitude, longitude: $longitude, accuracy: $accuracy, timestamp: $timestamp)';
  }
}

/// @nodoc
abstract mixin class $LocationUpdateCopyWith<$Res> {
  factory $LocationUpdateCopyWith(
          LocationUpdate value, $Res Function(LocationUpdate) _then) =
      _$LocationUpdateCopyWithImpl;
  @useResult
  $Res call(
      {double latitude, double longitude, double accuracy, DateTime timestamp});
}

/// @nodoc
class _$LocationUpdateCopyWithImpl<$Res>
    implements $LocationUpdateCopyWith<$Res> {
  _$LocationUpdateCopyWithImpl(this._self, this._then);

  final LocationUpdate _self;
  final $Res Function(LocationUpdate) _then;

  /// Create a copy of LocationUpdate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? latitude = null,
    Object? longitude = null,
    Object? accuracy = null,
    Object? timestamp = null,
  }) {
    return _then(_self.copyWith(
      latitude: null == latitude
          ? _self.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _self.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      accuracy: null == accuracy
          ? _self.accuracy
          : accuracy // ignore: cast_nullable_to_non_nullable
              as double,
      timestamp: null == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// Adds pattern-matching-related methods to [LocationUpdate].
extension LocationUpdatePatterns on LocationUpdate {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_LocationUpdate value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LocationUpdate() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_LocationUpdate value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LocationUpdate():
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_LocationUpdate value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LocationUpdate() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(double latitude, double longitude, double accuracy,
            DateTime timestamp)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LocationUpdate() when $default != null:
        return $default(
            _that.latitude, _that.longitude, _that.accuracy, _that.timestamp);
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(double latitude, double longitude, double accuracy,
            DateTime timestamp)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LocationUpdate():
        return $default(
            _that.latitude, _that.longitude, _that.accuracy, _that.timestamp);
      case _:
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(double latitude, double longitude, double accuracy,
            DateTime timestamp)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LocationUpdate() when $default != null:
        return $default(
            _that.latitude, _that.longitude, _that.accuracy, _that.timestamp);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _LocationUpdate implements LocationUpdate {
  const _LocationUpdate(
      {required this.latitude,
      required this.longitude,
      required this.accuracy,
      required this.timestamp});
  factory _LocationUpdate.fromJson(Map<String, dynamic> json) =>
      _$LocationUpdateFromJson(json);

  @override
  final double latitude;
  @override
  final double longitude;
  @override
  final double accuracy;
  @override
  final DateTime timestamp;

  /// Create a copy of LocationUpdate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LocationUpdateCopyWith<_LocationUpdate> get copyWith =>
      __$LocationUpdateCopyWithImpl<_LocationUpdate>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$LocationUpdateToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LocationUpdate &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.accuracy, accuracy) ||
                other.accuracy == accuracy) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, latitude, longitude, accuracy, timestamp);

  @override
  String toString() {
    return 'LocationUpdate(latitude: $latitude, longitude: $longitude, accuracy: $accuracy, timestamp: $timestamp)';
  }
}

/// @nodoc
abstract mixin class _$LocationUpdateCopyWith<$Res>
    implements $LocationUpdateCopyWith<$Res> {
  factory _$LocationUpdateCopyWith(
          _LocationUpdate value, $Res Function(_LocationUpdate) _then) =
      __$LocationUpdateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {double latitude, double longitude, double accuracy, DateTime timestamp});
}

/// @nodoc
class __$LocationUpdateCopyWithImpl<$Res>
    implements _$LocationUpdateCopyWith<$Res> {
  __$LocationUpdateCopyWithImpl(this._self, this._then);

  final _LocationUpdate _self;
  final $Res Function(_LocationUpdate) _then;

  /// Create a copy of LocationUpdate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? latitude = null,
    Object? longitude = null,
    Object? accuracy = null,
    Object? timestamp = null,
  }) {
    return _then(_LocationUpdate(
      latitude: null == latitude
          ? _self.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _self.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      accuracy: null == accuracy
          ? _self.accuracy
          : accuracy // ignore: cast_nullable_to_non_nullable
              as double,
      timestamp: null == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
mixin _$GeofenceEvent {
  String get appointmentId;
  String get event; // 'approaching', 'arrived', 'departed'
  double get distance;
  DateTime get timestamp;
  bool? get insideGeofence;
  bool? get approaching;

  /// Create a copy of GeofenceEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GeofenceEventCopyWith<GeofenceEvent> get copyWith =>
      _$GeofenceEventCopyWithImpl<GeofenceEvent>(
          this as GeofenceEvent, _$identity);

  /// Serializes this GeofenceEvent to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GeofenceEvent &&
            (identical(other.appointmentId, appointmentId) ||
                other.appointmentId == appointmentId) &&
            (identical(other.event, event) || other.event == event) &&
            (identical(other.distance, distance) ||
                other.distance == distance) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.insideGeofence, insideGeofence) ||
                other.insideGeofence == insideGeofence) &&
            (identical(other.approaching, approaching) ||
                other.approaching == approaching));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, appointmentId, event, distance,
      timestamp, insideGeofence, approaching);

  @override
  String toString() {
    return 'GeofenceEvent(appointmentId: $appointmentId, event: $event, distance: $distance, timestamp: $timestamp, insideGeofence: $insideGeofence, approaching: $approaching)';
  }
}

/// @nodoc
abstract mixin class $GeofenceEventCopyWith<$Res> {
  factory $GeofenceEventCopyWith(
          GeofenceEvent value, $Res Function(GeofenceEvent) _then) =
      _$GeofenceEventCopyWithImpl;
  @useResult
  $Res call(
      {String appointmentId,
      String event,
      double distance,
      DateTime timestamp,
      bool? insideGeofence,
      bool? approaching});
}

/// @nodoc
class _$GeofenceEventCopyWithImpl<$Res>
    implements $GeofenceEventCopyWith<$Res> {
  _$GeofenceEventCopyWithImpl(this._self, this._then);

  final GeofenceEvent _self;
  final $Res Function(GeofenceEvent) _then;

  /// Create a copy of GeofenceEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appointmentId = null,
    Object? event = null,
    Object? distance = null,
    Object? timestamp = null,
    Object? insideGeofence = freezed,
    Object? approaching = freezed,
  }) {
    return _then(_self.copyWith(
      appointmentId: null == appointmentId
          ? _self.appointmentId
          : appointmentId // ignore: cast_nullable_to_non_nullable
              as String,
      event: null == event
          ? _self.event
          : event // ignore: cast_nullable_to_non_nullable
              as String,
      distance: null == distance
          ? _self.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double,
      timestamp: null == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      insideGeofence: freezed == insideGeofence
          ? _self.insideGeofence
          : insideGeofence // ignore: cast_nullable_to_non_nullable
              as bool?,
      approaching: freezed == approaching
          ? _self.approaching
          : approaching // ignore: cast_nullable_to_non_nullable
              as bool?,
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_GeofenceEvent value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GeofenceEvent() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_GeofenceEvent value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GeofenceEvent():
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_GeofenceEvent value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GeofenceEvent() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String appointmentId, String event, double distance,
            DateTime timestamp, bool? insideGeofence, bool? approaching)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GeofenceEvent() when $default != null:
        return $default(_that.appointmentId, _that.event, _that.distance,
            _that.timestamp, _that.insideGeofence, _that.approaching);
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String appointmentId, String event, double distance,
            DateTime timestamp, bool? insideGeofence, bool? approaching)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GeofenceEvent():
        return $default(_that.appointmentId, _that.event, _that.distance,
            _that.timestamp, _that.insideGeofence, _that.approaching);
      case _:
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String appointmentId, String event, double distance,
            DateTime timestamp, bool? insideGeofence, bool? approaching)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GeofenceEvent() when $default != null:
        return $default(_that.appointmentId, _that.event, _that.distance,
            _that.timestamp, _that.insideGeofence, _that.approaching);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _GeofenceEvent implements GeofenceEvent {
  const _GeofenceEvent(
      {required this.appointmentId,
      required this.event,
      required this.distance,
      required this.timestamp,
      this.insideGeofence,
      this.approaching});
  factory _GeofenceEvent.fromJson(Map<String, dynamic> json) =>
      _$GeofenceEventFromJson(json);

  @override
  final String appointmentId;
  @override
  final String event;
// 'approaching', 'arrived', 'departed'
  @override
  final double distance;
  @override
  final DateTime timestamp;
  @override
  final bool? insideGeofence;
  @override
  final bool? approaching;

  /// Create a copy of GeofenceEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GeofenceEventCopyWith<_GeofenceEvent> get copyWith =>
      __$GeofenceEventCopyWithImpl<_GeofenceEvent>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$GeofenceEventToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GeofenceEvent &&
            (identical(other.appointmentId, appointmentId) ||
                other.appointmentId == appointmentId) &&
            (identical(other.event, event) || other.event == event) &&
            (identical(other.distance, distance) ||
                other.distance == distance) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.insideGeofence, insideGeofence) ||
                other.insideGeofence == insideGeofence) &&
            (identical(other.approaching, approaching) ||
                other.approaching == approaching));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, appointmentId, event, distance,
      timestamp, insideGeofence, approaching);

  @override
  String toString() {
    return 'GeofenceEvent(appointmentId: $appointmentId, event: $event, distance: $distance, timestamp: $timestamp, insideGeofence: $insideGeofence, approaching: $approaching)';
  }
}

/// @nodoc
abstract mixin class _$GeofenceEventCopyWith<$Res>
    implements $GeofenceEventCopyWith<$Res> {
  factory _$GeofenceEventCopyWith(
          _GeofenceEvent value, $Res Function(_GeofenceEvent) _then) =
      __$GeofenceEventCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String appointmentId,
      String event,
      double distance,
      DateTime timestamp,
      bool? insideGeofence,
      bool? approaching});
}

/// @nodoc
class __$GeofenceEventCopyWithImpl<$Res>
    implements _$GeofenceEventCopyWith<$Res> {
  __$GeofenceEventCopyWithImpl(this._self, this._then);

  final _GeofenceEvent _self;
  final $Res Function(_GeofenceEvent) _then;

  /// Create a copy of GeofenceEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? appointmentId = null,
    Object? event = null,
    Object? distance = null,
    Object? timestamp = null,
    Object? insideGeofence = freezed,
    Object? approaching = freezed,
  }) {
    return _then(_GeofenceEvent(
      appointmentId: null == appointmentId
          ? _self.appointmentId
          : appointmentId // ignore: cast_nullable_to_non_nullable
              as String,
      event: null == event
          ? _self.event
          : event // ignore: cast_nullable_to_non_nullable
              as String,
      distance: null == distance
          ? _self.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double,
      timestamp: null == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      insideGeofence: freezed == insideGeofence
          ? _self.insideGeofence
          : insideGeofence // ignore: cast_nullable_to_non_nullable
              as bool?,
      approaching: freezed == approaching
          ? _self.approaching
          : approaching // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
mixin _$TrackingSession {
  String get sessionId;
  String get appointmentId;
  String get workerId;
  String get status;
  DateTime get startTime;
  DateTime? get endTime;
  ClientLocation? get clientLocation;
  List<LocationUpdate>? get locations;
  int? get duration;
  double? get totalDistance;

  /// Create a copy of TrackingSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TrackingSessionCopyWith<TrackingSession> get copyWith =>
      _$TrackingSessionCopyWithImpl<TrackingSession>(
          this as TrackingSession, _$identity);

  /// Serializes this TrackingSession to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TrackingSession &&
            (identical(other.sessionId, sessionId) ||
                other.sessionId == sessionId) &&
            (identical(other.appointmentId, appointmentId) ||
                other.appointmentId == appointmentId) &&
            (identical(other.workerId, workerId) ||
                other.workerId == workerId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.clientLocation, clientLocation) ||
                other.clientLocation == clientLocation) &&
            const DeepCollectionEquality().equals(other.locations, locations) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.totalDistance, totalDistance) ||
                other.totalDistance == totalDistance));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      sessionId,
      appointmentId,
      workerId,
      status,
      startTime,
      endTime,
      clientLocation,
      const DeepCollectionEquality().hash(locations),
      duration,
      totalDistance);

  @override
  String toString() {
    return 'TrackingSession(sessionId: $sessionId, appointmentId: $appointmentId, workerId: $workerId, status: $status, startTime: $startTime, endTime: $endTime, clientLocation: $clientLocation, locations: $locations, duration: $duration, totalDistance: $totalDistance)';
  }
}

/// @nodoc
abstract mixin class $TrackingSessionCopyWith<$Res> {
  factory $TrackingSessionCopyWith(
          TrackingSession value, $Res Function(TrackingSession) _then) =
      _$TrackingSessionCopyWithImpl;
  @useResult
  $Res call(
      {String sessionId,
      String appointmentId,
      String workerId,
      String status,
      DateTime startTime,
      DateTime? endTime,
      ClientLocation? clientLocation,
      List<LocationUpdate>? locations,
      int? duration,
      double? totalDistance});

  $ClientLocationCopyWith<$Res>? get clientLocation;
}

/// @nodoc
class _$TrackingSessionCopyWithImpl<$Res>
    implements $TrackingSessionCopyWith<$Res> {
  _$TrackingSessionCopyWithImpl(this._self, this._then);

  final TrackingSession _self;
  final $Res Function(TrackingSession) _then;

  /// Create a copy of TrackingSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sessionId = null,
    Object? appointmentId = null,
    Object? workerId = null,
    Object? status = null,
    Object? startTime = null,
    Object? endTime = freezed,
    Object? clientLocation = freezed,
    Object? locations = freezed,
    Object? duration = freezed,
    Object? totalDistance = freezed,
  }) {
    return _then(_self.copyWith(
      sessionId: null == sessionId
          ? _self.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String,
      appointmentId: null == appointmentId
          ? _self.appointmentId
          : appointmentId // ignore: cast_nullable_to_non_nullable
              as String,
      workerId: null == workerId
          ? _self.workerId
          : workerId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _self.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: freezed == endTime
          ? _self.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      clientLocation: freezed == clientLocation
          ? _self.clientLocation
          : clientLocation // ignore: cast_nullable_to_non_nullable
              as ClientLocation?,
      locations: freezed == locations
          ? _self.locations
          : locations // ignore: cast_nullable_to_non_nullable
              as List<LocationUpdate>?,
      duration: freezed == duration
          ? _self.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int?,
      totalDistance: freezed == totalDistance
          ? _self.totalDistance
          : totalDistance // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }

  /// Create a copy of TrackingSession
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ClientLocationCopyWith<$Res>? get clientLocation {
    if (_self.clientLocation == null) {
      return null;
    }

    return $ClientLocationCopyWith<$Res>(_self.clientLocation!, (value) {
      return _then(_self.copyWith(clientLocation: value));
    });
  }
}

/// Adds pattern-matching-related methods to [TrackingSession].
extension TrackingSessionPatterns on TrackingSession {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_TrackingSession value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TrackingSession() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_TrackingSession value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TrackingSession():
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_TrackingSession value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TrackingSession() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String sessionId,
            String appointmentId,
            String workerId,
            String status,
            DateTime startTime,
            DateTime? endTime,
            ClientLocation? clientLocation,
            List<LocationUpdate>? locations,
            int? duration,
            double? totalDistance)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TrackingSession() when $default != null:
        return $default(
            _that.sessionId,
            _that.appointmentId,
            _that.workerId,
            _that.status,
            _that.startTime,
            _that.endTime,
            _that.clientLocation,
            _that.locations,
            _that.duration,
            _that.totalDistance);
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String sessionId,
            String appointmentId,
            String workerId,
            String status,
            DateTime startTime,
            DateTime? endTime,
            ClientLocation? clientLocation,
            List<LocationUpdate>? locations,
            int? duration,
            double? totalDistance)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TrackingSession():
        return $default(
            _that.sessionId,
            _that.appointmentId,
            _that.workerId,
            _that.status,
            _that.startTime,
            _that.endTime,
            _that.clientLocation,
            _that.locations,
            _that.duration,
            _that.totalDistance);
      case _:
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String sessionId,
            String appointmentId,
            String workerId,
            String status,
            DateTime startTime,
            DateTime? endTime,
            ClientLocation? clientLocation,
            List<LocationUpdate>? locations,
            int? duration,
            double? totalDistance)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TrackingSession() when $default != null:
        return $default(
            _that.sessionId,
            _that.appointmentId,
            _that.workerId,
            _that.status,
            _that.startTime,
            _that.endTime,
            _that.clientLocation,
            _that.locations,
            _that.duration,
            _that.totalDistance);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _TrackingSession implements TrackingSession {
  const _TrackingSession(
      {required this.sessionId,
      required this.appointmentId,
      required this.workerId,
      required this.status,
      required this.startTime,
      this.endTime,
      this.clientLocation,
      final List<LocationUpdate>? locations,
      this.duration,
      this.totalDistance})
      : _locations = locations;
  factory _TrackingSession.fromJson(Map<String, dynamic> json) =>
      _$TrackingSessionFromJson(json);

  @override
  final String sessionId;
  @override
  final String appointmentId;
  @override
  final String workerId;
  @override
  final String status;
  @override
  final DateTime startTime;
  @override
  final DateTime? endTime;
  @override
  final ClientLocation? clientLocation;
  final List<LocationUpdate>? _locations;
  @override
  List<LocationUpdate>? get locations {
    final value = _locations;
    if (value == null) return null;
    if (_locations is EqualUnmodifiableListView) return _locations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final int? duration;
  @override
  final double? totalDistance;

  /// Create a copy of TrackingSession
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TrackingSessionCopyWith<_TrackingSession> get copyWith =>
      __$TrackingSessionCopyWithImpl<_TrackingSession>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TrackingSessionToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TrackingSession &&
            (identical(other.sessionId, sessionId) ||
                other.sessionId == sessionId) &&
            (identical(other.appointmentId, appointmentId) ||
                other.appointmentId == appointmentId) &&
            (identical(other.workerId, workerId) ||
                other.workerId == workerId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.clientLocation, clientLocation) ||
                other.clientLocation == clientLocation) &&
            const DeepCollectionEquality()
                .equals(other._locations, _locations) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.totalDistance, totalDistance) ||
                other.totalDistance == totalDistance));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      sessionId,
      appointmentId,
      workerId,
      status,
      startTime,
      endTime,
      clientLocation,
      const DeepCollectionEquality().hash(_locations),
      duration,
      totalDistance);

  @override
  String toString() {
    return 'TrackingSession(sessionId: $sessionId, appointmentId: $appointmentId, workerId: $workerId, status: $status, startTime: $startTime, endTime: $endTime, clientLocation: $clientLocation, locations: $locations, duration: $duration, totalDistance: $totalDistance)';
  }
}

/// @nodoc
abstract mixin class _$TrackingSessionCopyWith<$Res>
    implements $TrackingSessionCopyWith<$Res> {
  factory _$TrackingSessionCopyWith(
          _TrackingSession value, $Res Function(_TrackingSession) _then) =
      __$TrackingSessionCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String sessionId,
      String appointmentId,
      String workerId,
      String status,
      DateTime startTime,
      DateTime? endTime,
      ClientLocation? clientLocation,
      List<LocationUpdate>? locations,
      int? duration,
      double? totalDistance});

  @override
  $ClientLocationCopyWith<$Res>? get clientLocation;
}

/// @nodoc
class __$TrackingSessionCopyWithImpl<$Res>
    implements _$TrackingSessionCopyWith<$Res> {
  __$TrackingSessionCopyWithImpl(this._self, this._then);

  final _TrackingSession _self;
  final $Res Function(_TrackingSession) _then;

  /// Create a copy of TrackingSession
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? sessionId = null,
    Object? appointmentId = null,
    Object? workerId = null,
    Object? status = null,
    Object? startTime = null,
    Object? endTime = freezed,
    Object? clientLocation = freezed,
    Object? locations = freezed,
    Object? duration = freezed,
    Object? totalDistance = freezed,
  }) {
    return _then(_TrackingSession(
      sessionId: null == sessionId
          ? _self.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String,
      appointmentId: null == appointmentId
          ? _self.appointmentId
          : appointmentId // ignore: cast_nullable_to_non_nullable
              as String,
      workerId: null == workerId
          ? _self.workerId
          : workerId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _self.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: freezed == endTime
          ? _self.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      clientLocation: freezed == clientLocation
          ? _self.clientLocation
          : clientLocation // ignore: cast_nullable_to_non_nullable
              as ClientLocation?,
      locations: freezed == locations
          ? _self._locations
          : locations // ignore: cast_nullable_to_non_nullable
              as List<LocationUpdate>?,
      duration: freezed == duration
          ? _self.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int?,
      totalDistance: freezed == totalDistance
          ? _self.totalDistance
          : totalDistance // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }

  /// Create a copy of TrackingSession
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ClientLocationCopyWith<$Res>? get clientLocation {
    if (_self.clientLocation == null) {
      return null;
    }

    return $ClientLocationCopyWith<$Res>(_self.clientLocation!, (value) {
      return _then(_self.copyWith(clientLocation: value));
    });
  }
}

/// @nodoc
mixin _$ClientLocation {
  double get lat;
  double get lng;
  String? get address;

  /// Create a copy of ClientLocation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ClientLocationCopyWith<ClientLocation> get copyWith =>
      _$ClientLocationCopyWithImpl<ClientLocation>(
          this as ClientLocation, _$identity);

  /// Serializes this ClientLocation to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ClientLocation &&
            (identical(other.lat, lat) || other.lat == lat) &&
            (identical(other.lng, lng) || other.lng == lng) &&
            (identical(other.address, address) || other.address == address));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, lat, lng, address);

  @override
  String toString() {
    return 'ClientLocation(lat: $lat, lng: $lng, address: $address)';
  }
}

/// @nodoc
abstract mixin class $ClientLocationCopyWith<$Res> {
  factory $ClientLocationCopyWith(
          ClientLocation value, $Res Function(ClientLocation) _then) =
      _$ClientLocationCopyWithImpl;
  @useResult
  $Res call({double lat, double lng, String? address});
}

/// @nodoc
class _$ClientLocationCopyWithImpl<$Res>
    implements $ClientLocationCopyWith<$Res> {
  _$ClientLocationCopyWithImpl(this._self, this._then);

  final ClientLocation _self;
  final $Res Function(ClientLocation) _then;

  /// Create a copy of ClientLocation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lat = null,
    Object? lng = null,
    Object? address = freezed,
  }) {
    return _then(_self.copyWith(
      lat: null == lat
          ? _self.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double,
      lng: null == lng
          ? _self.lng
          : lng // ignore: cast_nullable_to_non_nullable
              as double,
      address: freezed == address
          ? _self.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [ClientLocation].
extension ClientLocationPatterns on ClientLocation {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_ClientLocation value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ClientLocation() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_ClientLocation value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ClientLocation():
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_ClientLocation value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ClientLocation() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(double lat, double lng, String? address)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ClientLocation() when $default != null:
        return $default(_that.lat, _that.lng, _that.address);
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(double lat, double lng, String? address) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ClientLocation():
        return $default(_that.lat, _that.lng, _that.address);
      case _:
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(double lat, double lng, String? address)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ClientLocation() when $default != null:
        return $default(_that.lat, _that.lng, _that.address);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ClientLocation implements ClientLocation {
  const _ClientLocation({required this.lat, required this.lng, this.address});
  factory _ClientLocation.fromJson(Map<String, dynamic> json) =>
      _$ClientLocationFromJson(json);

  @override
  final double lat;
  @override
  final double lng;
  @override
  final String? address;

  /// Create a copy of ClientLocation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ClientLocationCopyWith<_ClientLocation> get copyWith =>
      __$ClientLocationCopyWithImpl<_ClientLocation>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ClientLocationToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ClientLocation &&
            (identical(other.lat, lat) || other.lat == lat) &&
            (identical(other.lng, lng) || other.lng == lng) &&
            (identical(other.address, address) || other.address == address));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, lat, lng, address);

  @override
  String toString() {
    return 'ClientLocation(lat: $lat, lng: $lng, address: $address)';
  }
}

/// @nodoc
abstract mixin class _$ClientLocationCopyWith<$Res>
    implements $ClientLocationCopyWith<$Res> {
  factory _$ClientLocationCopyWith(
          _ClientLocation value, $Res Function(_ClientLocation) _then) =
      __$ClientLocationCopyWithImpl;
  @override
  @useResult
  $Res call({double lat, double lng, String? address});
}

/// @nodoc
class __$ClientLocationCopyWithImpl<$Res>
    implements _$ClientLocationCopyWith<$Res> {
  __$ClientLocationCopyWithImpl(this._self, this._then);

  final _ClientLocation _self;
  final $Res Function(_ClientLocation) _then;

  /// Create a copy of ClientLocation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? lat = null,
    Object? lng = null,
    Object? address = freezed,
  }) {
    return _then(_ClientLocation(
      lat: null == lat
          ? _self.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double,
      lng: null == lng
          ? _self.lng
          : lng // ignore: cast_nullable_to_non_nullable
              as double,
      address: freezed == address
          ? _self.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$ETACalculation {
  int get minutes;
  double get distance;
  double get avgSpeed;
  DateTime get estimatedArrival;
  String? get trafficCondition;

  /// Create a copy of ETACalculation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ETACalculationCopyWith<ETACalculation> get copyWith =>
      _$ETACalculationCopyWithImpl<ETACalculation>(
          this as ETACalculation, _$identity);

  /// Serializes this ETACalculation to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ETACalculation &&
            (identical(other.minutes, minutes) || other.minutes == minutes) &&
            (identical(other.distance, distance) ||
                other.distance == distance) &&
            (identical(other.avgSpeed, avgSpeed) ||
                other.avgSpeed == avgSpeed) &&
            (identical(other.estimatedArrival, estimatedArrival) ||
                other.estimatedArrival == estimatedArrival) &&
            (identical(other.trafficCondition, trafficCondition) ||
                other.trafficCondition == trafficCondition));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, minutes, distance, avgSpeed,
      estimatedArrival, trafficCondition);

  @override
  String toString() {
    return 'ETACalculation(minutes: $minutes, distance: $distance, avgSpeed: $avgSpeed, estimatedArrival: $estimatedArrival, trafficCondition: $trafficCondition)';
  }
}

/// @nodoc
abstract mixin class $ETACalculationCopyWith<$Res> {
  factory $ETACalculationCopyWith(
          ETACalculation value, $Res Function(ETACalculation) _then) =
      _$ETACalculationCopyWithImpl;
  @useResult
  $Res call(
      {int minutes,
      double distance,
      double avgSpeed,
      DateTime estimatedArrival,
      String? trafficCondition});
}

/// @nodoc
class _$ETACalculationCopyWithImpl<$Res>
    implements $ETACalculationCopyWith<$Res> {
  _$ETACalculationCopyWithImpl(this._self, this._then);

  final ETACalculation _self;
  final $Res Function(ETACalculation) _then;

  /// Create a copy of ETACalculation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? minutes = null,
    Object? distance = null,
    Object? avgSpeed = null,
    Object? estimatedArrival = null,
    Object? trafficCondition = freezed,
  }) {
    return _then(_self.copyWith(
      minutes: null == minutes
          ? _self.minutes
          : minutes // ignore: cast_nullable_to_non_nullable
              as int,
      distance: null == distance
          ? _self.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double,
      avgSpeed: null == avgSpeed
          ? _self.avgSpeed
          : avgSpeed // ignore: cast_nullable_to_non_nullable
              as double,
      estimatedArrival: null == estimatedArrival
          ? _self.estimatedArrival
          : estimatedArrival // ignore: cast_nullable_to_non_nullable
              as DateTime,
      trafficCondition: freezed == trafficCondition
          ? _self.trafficCondition
          : trafficCondition // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [ETACalculation].
extension ETACalculationPatterns on ETACalculation {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_ETACalculation value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ETACalculation() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_ETACalculation value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ETACalculation():
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_ETACalculation value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ETACalculation() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(int minutes, double distance, double avgSpeed,
            DateTime estimatedArrival, String? trafficCondition)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ETACalculation() when $default != null:
        return $default(_that.minutes, _that.distance, _that.avgSpeed,
            _that.estimatedArrival, _that.trafficCondition);
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(int minutes, double distance, double avgSpeed,
            DateTime estimatedArrival, String? trafficCondition)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ETACalculation():
        return $default(_that.minutes, _that.distance, _that.avgSpeed,
            _that.estimatedArrival, _that.trafficCondition);
      case _:
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(int minutes, double distance, double avgSpeed,
            DateTime estimatedArrival, String? trafficCondition)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ETACalculation() when $default != null:
        return $default(_that.minutes, _that.distance, _that.avgSpeed,
            _that.estimatedArrival, _that.trafficCondition);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ETACalculation implements ETACalculation {
  const _ETACalculation(
      {required this.minutes,
      required this.distance,
      required this.avgSpeed,
      required this.estimatedArrival,
      this.trafficCondition});
  factory _ETACalculation.fromJson(Map<String, dynamic> json) =>
      _$ETACalculationFromJson(json);

  @override
  final int minutes;
  @override
  final double distance;
  @override
  final double avgSpeed;
  @override
  final DateTime estimatedArrival;
  @override
  final String? trafficCondition;

  /// Create a copy of ETACalculation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ETACalculationCopyWith<_ETACalculation> get copyWith =>
      __$ETACalculationCopyWithImpl<_ETACalculation>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ETACalculationToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ETACalculation &&
            (identical(other.minutes, minutes) || other.minutes == minutes) &&
            (identical(other.distance, distance) ||
                other.distance == distance) &&
            (identical(other.avgSpeed, avgSpeed) ||
                other.avgSpeed == avgSpeed) &&
            (identical(other.estimatedArrival, estimatedArrival) ||
                other.estimatedArrival == estimatedArrival) &&
            (identical(other.trafficCondition, trafficCondition) ||
                other.trafficCondition == trafficCondition));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, minutes, distance, avgSpeed,
      estimatedArrival, trafficCondition);

  @override
  String toString() {
    return 'ETACalculation(minutes: $minutes, distance: $distance, avgSpeed: $avgSpeed, estimatedArrival: $estimatedArrival, trafficCondition: $trafficCondition)';
  }
}

/// @nodoc
abstract mixin class _$ETACalculationCopyWith<$Res>
    implements $ETACalculationCopyWith<$Res> {
  factory _$ETACalculationCopyWith(
          _ETACalculation value, $Res Function(_ETACalculation) _then) =
      __$ETACalculationCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int minutes,
      double distance,
      double avgSpeed,
      DateTime estimatedArrival,
      String? trafficCondition});
}

/// @nodoc
class __$ETACalculationCopyWithImpl<$Res>
    implements _$ETACalculationCopyWith<$Res> {
  __$ETACalculationCopyWithImpl(this._self, this._then);

  final _ETACalculation _self;
  final $Res Function(_ETACalculation) _then;

  /// Create a copy of ETACalculation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? minutes = null,
    Object? distance = null,
    Object? avgSpeed = null,
    Object? estimatedArrival = null,
    Object? trafficCondition = freezed,
  }) {
    return _then(_ETACalculation(
      minutes: null == minutes
          ? _self.minutes
          : minutes // ignore: cast_nullable_to_non_nullable
              as int,
      distance: null == distance
          ? _self.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double,
      avgSpeed: null == avgSpeed
          ? _self.avgSpeed
          : avgSpeed // ignore: cast_nullable_to_non_nullable
              as double,
      estimatedArrival: null == estimatedArrival
          ? _self.estimatedArrival
          : estimatedArrival // ignore: cast_nullable_to_non_nullable
              as DateTime,
      trafficCondition: freezed == trafficCondition
          ? _self.trafficCondition
          : trafficCondition // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$AppointmentStatus {
  String get appointmentId;
  String
      get status; // 'scheduled', 'en_route', 'arrived', 'in_progress', 'completed'
  int get progress; // 0-100
  String? get notes;
  DateTime get timestamp;

  /// Create a copy of AppointmentStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AppointmentStatusCopyWith<AppointmentStatus> get copyWith =>
      _$AppointmentStatusCopyWithImpl<AppointmentStatus>(
          this as AppointmentStatus, _$identity);

  /// Serializes this AppointmentStatus to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AppointmentStatus &&
            (identical(other.appointmentId, appointmentId) ||
                other.appointmentId == appointmentId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.progress, progress) ||
                other.progress == progress) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, appointmentId, status, progress, notes, timestamp);

  @override
  String toString() {
    return 'AppointmentStatus(appointmentId: $appointmentId, status: $status, progress: $progress, notes: $notes, timestamp: $timestamp)';
  }
}

/// @nodoc
abstract mixin class $AppointmentStatusCopyWith<$Res> {
  factory $AppointmentStatusCopyWith(
          AppointmentStatus value, $Res Function(AppointmentStatus) _then) =
      _$AppointmentStatusCopyWithImpl;
  @useResult
  $Res call(
      {String appointmentId,
      String status,
      int progress,
      String? notes,
      DateTime timestamp});
}

/// @nodoc
class _$AppointmentStatusCopyWithImpl<$Res>
    implements $AppointmentStatusCopyWith<$Res> {
  _$AppointmentStatusCopyWithImpl(this._self, this._then);

  final AppointmentStatus _self;
  final $Res Function(AppointmentStatus) _then;

  /// Create a copy of AppointmentStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appointmentId = null,
    Object? status = null,
    Object? progress = null,
    Object? notes = freezed,
    Object? timestamp = null,
  }) {
    return _then(_self.copyWith(
      appointmentId: null == appointmentId
          ? _self.appointmentId
          : appointmentId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      progress: null == progress
          ? _self.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as int,
      notes: freezed == notes
          ? _self.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      timestamp: null == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// Adds pattern-matching-related methods to [AppointmentStatus].
extension AppointmentStatusPatterns on AppointmentStatus {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_AppointmentStatus value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AppointmentStatus() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_AppointmentStatus value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AppointmentStatus():
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_AppointmentStatus value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AppointmentStatus() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String appointmentId, String status, int progress,
            String? notes, DateTime timestamp)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AppointmentStatus() when $default != null:
        return $default(_that.appointmentId, _that.status, _that.progress,
            _that.notes, _that.timestamp);
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String appointmentId, String status, int progress,
            String? notes, DateTime timestamp)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AppointmentStatus():
        return $default(_that.appointmentId, _that.status, _that.progress,
            _that.notes, _that.timestamp);
      case _:
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String appointmentId, String status, int progress,
            String? notes, DateTime timestamp)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AppointmentStatus() when $default != null:
        return $default(_that.appointmentId, _that.status, _that.progress,
            _that.notes, _that.timestamp);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _AppointmentStatus implements AppointmentStatus {
  const _AppointmentStatus(
      {required this.appointmentId,
      required this.status,
      required this.progress,
      this.notes,
      required this.timestamp});
  factory _AppointmentStatus.fromJson(Map<String, dynamic> json) =>
      _$AppointmentStatusFromJson(json);

  @override
  final String appointmentId;
  @override
  final String status;
// 'scheduled', 'en_route', 'arrived', 'in_progress', 'completed'
  @override
  final int progress;
// 0-100
  @override
  final String? notes;
  @override
  final DateTime timestamp;

  /// Create a copy of AppointmentStatus
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AppointmentStatusCopyWith<_AppointmentStatus> get copyWith =>
      __$AppointmentStatusCopyWithImpl<_AppointmentStatus>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AppointmentStatusToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AppointmentStatus &&
            (identical(other.appointmentId, appointmentId) ||
                other.appointmentId == appointmentId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.progress, progress) ||
                other.progress == progress) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, appointmentId, status, progress, notes, timestamp);

  @override
  String toString() {
    return 'AppointmentStatus(appointmentId: $appointmentId, status: $status, progress: $progress, notes: $notes, timestamp: $timestamp)';
  }
}

/// @nodoc
abstract mixin class _$AppointmentStatusCopyWith<$Res>
    implements $AppointmentStatusCopyWith<$Res> {
  factory _$AppointmentStatusCopyWith(
          _AppointmentStatus value, $Res Function(_AppointmentStatus) _then) =
      __$AppointmentStatusCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String appointmentId,
      String status,
      int progress,
      String? notes,
      DateTime timestamp});
}

/// @nodoc
class __$AppointmentStatusCopyWithImpl<$Res>
    implements _$AppointmentStatusCopyWith<$Res> {
  __$AppointmentStatusCopyWithImpl(this._self, this._then);

  final _AppointmentStatus _self;
  final $Res Function(_AppointmentStatus) _then;

  /// Create a copy of AppointmentStatus
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? appointmentId = null,
    Object? status = null,
    Object? progress = null,
    Object? notes = freezed,
    Object? timestamp = null,
  }) {
    return _then(_AppointmentStatus(
      appointmentId: null == appointmentId
          ? _self.appointmentId
          : appointmentId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      progress: null == progress
          ? _self.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as int,
      notes: freezed == notes
          ? _self.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      timestamp: null == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
mixin _$ServiceProgress {
  String get appointmentId;
  int get progress;
  List<ProgressStep> get steps;
  String? get currentStep;
  DateTime? get startTime;
  DateTime? get estimatedCompletion;

  /// Create a copy of ServiceProgress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ServiceProgressCopyWith<ServiceProgress> get copyWith =>
      _$ServiceProgressCopyWithImpl<ServiceProgress>(
          this as ServiceProgress, _$identity);

  /// Serializes this ServiceProgress to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ServiceProgress &&
            (identical(other.appointmentId, appointmentId) ||
                other.appointmentId == appointmentId) &&
            (identical(other.progress, progress) ||
                other.progress == progress) &&
            const DeepCollectionEquality().equals(other.steps, steps) &&
            (identical(other.currentStep, currentStep) ||
                other.currentStep == currentStep) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.estimatedCompletion, estimatedCompletion) ||
                other.estimatedCompletion == estimatedCompletion));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      appointmentId,
      progress,
      const DeepCollectionEquality().hash(steps),
      currentStep,
      startTime,
      estimatedCompletion);

  @override
  String toString() {
    return 'ServiceProgress(appointmentId: $appointmentId, progress: $progress, steps: $steps, currentStep: $currentStep, startTime: $startTime, estimatedCompletion: $estimatedCompletion)';
  }
}

/// @nodoc
abstract mixin class $ServiceProgressCopyWith<$Res> {
  factory $ServiceProgressCopyWith(
          ServiceProgress value, $Res Function(ServiceProgress) _then) =
      _$ServiceProgressCopyWithImpl;
  @useResult
  $Res call(
      {String appointmentId,
      int progress,
      List<ProgressStep> steps,
      String? currentStep,
      DateTime? startTime,
      DateTime? estimatedCompletion});
}

/// @nodoc
class _$ServiceProgressCopyWithImpl<$Res>
    implements $ServiceProgressCopyWith<$Res> {
  _$ServiceProgressCopyWithImpl(this._self, this._then);

  final ServiceProgress _self;
  final $Res Function(ServiceProgress) _then;

  /// Create a copy of ServiceProgress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appointmentId = null,
    Object? progress = null,
    Object? steps = null,
    Object? currentStep = freezed,
    Object? startTime = freezed,
    Object? estimatedCompletion = freezed,
  }) {
    return _then(_self.copyWith(
      appointmentId: null == appointmentId
          ? _self.appointmentId
          : appointmentId // ignore: cast_nullable_to_non_nullable
              as String,
      progress: null == progress
          ? _self.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as int,
      steps: null == steps
          ? _self.steps
          : steps // ignore: cast_nullable_to_non_nullable
              as List<ProgressStep>,
      currentStep: freezed == currentStep
          ? _self.currentStep
          : currentStep // ignore: cast_nullable_to_non_nullable
              as String?,
      startTime: freezed == startTime
          ? _self.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      estimatedCompletion: freezed == estimatedCompletion
          ? _self.estimatedCompletion
          : estimatedCompletion // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// Adds pattern-matching-related methods to [ServiceProgress].
extension ServiceProgressPatterns on ServiceProgress {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_ServiceProgress value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ServiceProgress() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_ServiceProgress value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ServiceProgress():
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_ServiceProgress value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ServiceProgress() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String appointmentId,
            int progress,
            List<ProgressStep> steps,
            String? currentStep,
            DateTime? startTime,
            DateTime? estimatedCompletion)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ServiceProgress() when $default != null:
        return $default(_that.appointmentId, _that.progress, _that.steps,
            _that.currentStep, _that.startTime, _that.estimatedCompletion);
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String appointmentId,
            int progress,
            List<ProgressStep> steps,
            String? currentStep,
            DateTime? startTime,
            DateTime? estimatedCompletion)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ServiceProgress():
        return $default(_that.appointmentId, _that.progress, _that.steps,
            _that.currentStep, _that.startTime, _that.estimatedCompletion);
      case _:
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String appointmentId,
            int progress,
            List<ProgressStep> steps,
            String? currentStep,
            DateTime? startTime,
            DateTime? estimatedCompletion)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ServiceProgress() when $default != null:
        return $default(_that.appointmentId, _that.progress, _that.steps,
            _that.currentStep, _that.startTime, _that.estimatedCompletion);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ServiceProgress implements ServiceProgress {
  const _ServiceProgress(
      {required this.appointmentId,
      required this.progress,
      required final List<ProgressStep> steps,
      this.currentStep,
      this.startTime,
      this.estimatedCompletion})
      : _steps = steps;
  factory _ServiceProgress.fromJson(Map<String, dynamic> json) =>
      _$ServiceProgressFromJson(json);

  @override
  final String appointmentId;
  @override
  final int progress;
  final List<ProgressStep> _steps;
  @override
  List<ProgressStep> get steps {
    if (_steps is EqualUnmodifiableListView) return _steps;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_steps);
  }

  @override
  final String? currentStep;
  @override
  final DateTime? startTime;
  @override
  final DateTime? estimatedCompletion;

  /// Create a copy of ServiceProgress
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ServiceProgressCopyWith<_ServiceProgress> get copyWith =>
      __$ServiceProgressCopyWithImpl<_ServiceProgress>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ServiceProgressToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ServiceProgress &&
            (identical(other.appointmentId, appointmentId) ||
                other.appointmentId == appointmentId) &&
            (identical(other.progress, progress) ||
                other.progress == progress) &&
            const DeepCollectionEquality().equals(other._steps, _steps) &&
            (identical(other.currentStep, currentStep) ||
                other.currentStep == currentStep) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.estimatedCompletion, estimatedCompletion) ||
                other.estimatedCompletion == estimatedCompletion));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      appointmentId,
      progress,
      const DeepCollectionEquality().hash(_steps),
      currentStep,
      startTime,
      estimatedCompletion);

  @override
  String toString() {
    return 'ServiceProgress(appointmentId: $appointmentId, progress: $progress, steps: $steps, currentStep: $currentStep, startTime: $startTime, estimatedCompletion: $estimatedCompletion)';
  }
}

/// @nodoc
abstract mixin class _$ServiceProgressCopyWith<$Res>
    implements $ServiceProgressCopyWith<$Res> {
  factory _$ServiceProgressCopyWith(
          _ServiceProgress value, $Res Function(_ServiceProgress) _then) =
      __$ServiceProgressCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String appointmentId,
      int progress,
      List<ProgressStep> steps,
      String? currentStep,
      DateTime? startTime,
      DateTime? estimatedCompletion});
}

/// @nodoc
class __$ServiceProgressCopyWithImpl<$Res>
    implements _$ServiceProgressCopyWith<$Res> {
  __$ServiceProgressCopyWithImpl(this._self, this._then);

  final _ServiceProgress _self;
  final $Res Function(_ServiceProgress) _then;

  /// Create a copy of ServiceProgress
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? appointmentId = null,
    Object? progress = null,
    Object? steps = null,
    Object? currentStep = freezed,
    Object? startTime = freezed,
    Object? estimatedCompletion = freezed,
  }) {
    return _then(_ServiceProgress(
      appointmentId: null == appointmentId
          ? _self.appointmentId
          : appointmentId // ignore: cast_nullable_to_non_nullable
              as String,
      progress: null == progress
          ? _self.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as int,
      steps: null == steps
          ? _self._steps
          : steps // ignore: cast_nullable_to_non_nullable
              as List<ProgressStep>,
      currentStep: freezed == currentStep
          ? _self.currentStep
          : currentStep // ignore: cast_nullable_to_non_nullable
              as String?,
      startTime: freezed == startTime
          ? _self.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      estimatedCompletion: freezed == estimatedCompletion
          ? _self.estimatedCompletion
          : estimatedCompletion // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
mixin _$ProgressStep {
  String get id;
  String get name;
  bool get completed;
  DateTime? get completedAt;

  /// Create a copy of ProgressStep
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ProgressStepCopyWith<ProgressStep> get copyWith =>
      _$ProgressStepCopyWithImpl<ProgressStep>(
          this as ProgressStep, _$identity);

  /// Serializes this ProgressStep to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ProgressStep &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.completed, completed) ||
                other.completed == completed) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, completed, completedAt);

  @override
  String toString() {
    return 'ProgressStep(id: $id, name: $name, completed: $completed, completedAt: $completedAt)';
  }
}

/// @nodoc
abstract mixin class $ProgressStepCopyWith<$Res> {
  factory $ProgressStepCopyWith(
          ProgressStep value, $Res Function(ProgressStep) _then) =
      _$ProgressStepCopyWithImpl;
  @useResult
  $Res call({String id, String name, bool completed, DateTime? completedAt});
}

/// @nodoc
class _$ProgressStepCopyWithImpl<$Res> implements $ProgressStepCopyWith<$Res> {
  _$ProgressStepCopyWithImpl(this._self, this._then);

  final ProgressStep _self;
  final $Res Function(ProgressStep) _then;

  /// Create a copy of ProgressStep
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? completed = null,
    Object? completedAt = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      completed: null == completed
          ? _self.completed
          : completed // ignore: cast_nullable_to_non_nullable
              as bool,
      completedAt: freezed == completedAt
          ? _self.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// Adds pattern-matching-related methods to [ProgressStep].
extension ProgressStepPatterns on ProgressStep {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_ProgressStep value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ProgressStep() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_ProgressStep value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ProgressStep():
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_ProgressStep value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ProgressStep() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String id, String name, bool completed, DateTime? completedAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ProgressStep() when $default != null:
        return $default(
            _that.id, _that.name, _that.completed, _that.completedAt);
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String id, String name, bool completed, DateTime? completedAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ProgressStep():
        return $default(
            _that.id, _that.name, _that.completed, _that.completedAt);
      case _:
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String id, String name, bool completed, DateTime? completedAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ProgressStep() when $default != null:
        return $default(
            _that.id, _that.name, _that.completed, _that.completedAt);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ProgressStep implements ProgressStep {
  const _ProgressStep(
      {required this.id,
      required this.name,
      required this.completed,
      this.completedAt});
  factory _ProgressStep.fromJson(Map<String, dynamic> json) =>
      _$ProgressStepFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final bool completed;
  @override
  final DateTime? completedAt;

  /// Create a copy of ProgressStep
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ProgressStepCopyWith<_ProgressStep> get copyWith =>
      __$ProgressStepCopyWithImpl<_ProgressStep>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ProgressStepToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ProgressStep &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.completed, completed) ||
                other.completed == completed) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, completed, completedAt);

  @override
  String toString() {
    return 'ProgressStep(id: $id, name: $name, completed: $completed, completedAt: $completedAt)';
  }
}

/// @nodoc
abstract mixin class _$ProgressStepCopyWith<$Res>
    implements $ProgressStepCopyWith<$Res> {
  factory _$ProgressStepCopyWith(
          _ProgressStep value, $Res Function(_ProgressStep) _then) =
      __$ProgressStepCopyWithImpl;
  @override
  @useResult
  $Res call({String id, String name, bool completed, DateTime? completedAt});
}

/// @nodoc
class __$ProgressStepCopyWithImpl<$Res>
    implements _$ProgressStepCopyWith<$Res> {
  __$ProgressStepCopyWithImpl(this._self, this._then);

  final _ProgressStep _self;
  final $Res Function(_ProgressStep) _then;

  /// Create a copy of ProgressStep
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? completed = null,
    Object? completedAt = freezed,
  }) {
    return _then(_ProgressStep(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      completed: null == completed
          ? _self.completed
          : completed // ignore: cast_nullable_to_non_nullable
              as bool,
      completedAt: freezed == completedAt
          ? _self.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
mixin _$SecureMessage {
  String get id;
  String get conversationId;
  String get senderId;
  String get senderType;
  String get senderName;
  String get recipientId;
  String get message;
  List<MessageAttachment>? get attachments;
  DateTime get timestamp;
  bool get read;
  DateTime? get readAt;
  String? get type;

  /// Create a copy of SecureMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SecureMessageCopyWith<SecureMessage> get copyWith =>
      _$SecureMessageCopyWithImpl<SecureMessage>(
          this as SecureMessage, _$identity);

  /// Serializes this SecureMessage to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SecureMessage &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId) &&
            (identical(other.senderId, senderId) ||
                other.senderId == senderId) &&
            (identical(other.senderType, senderType) ||
                other.senderType == senderType) &&
            (identical(other.senderName, senderName) ||
                other.senderName == senderName) &&
            (identical(other.recipientId, recipientId) ||
                other.recipientId == recipientId) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality()
                .equals(other.attachments, attachments) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.read, read) || other.read == read) &&
            (identical(other.readAt, readAt) || other.readAt == readAt) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      conversationId,
      senderId,
      senderType,
      senderName,
      recipientId,
      message,
      const DeepCollectionEquality().hash(attachments),
      timestamp,
      read,
      readAt,
      type);

  @override
  String toString() {
    return 'SecureMessage(id: $id, conversationId: $conversationId, senderId: $senderId, senderType: $senderType, senderName: $senderName, recipientId: $recipientId, message: $message, attachments: $attachments, timestamp: $timestamp, read: $read, readAt: $readAt, type: $type)';
  }
}

/// @nodoc
abstract mixin class $SecureMessageCopyWith<$Res> {
  factory $SecureMessageCopyWith(
          SecureMessage value, $Res Function(SecureMessage) _then) =
      _$SecureMessageCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String conversationId,
      String senderId,
      String senderType,
      String senderName,
      String recipientId,
      String message,
      List<MessageAttachment>? attachments,
      DateTime timestamp,
      bool read,
      DateTime? readAt,
      String? type});
}

/// @nodoc
class _$SecureMessageCopyWithImpl<$Res>
    implements $SecureMessageCopyWith<$Res> {
  _$SecureMessageCopyWithImpl(this._self, this._then);

  final SecureMessage _self;
  final $Res Function(SecureMessage) _then;

  /// Create a copy of SecureMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? conversationId = null,
    Object? senderId = null,
    Object? senderType = null,
    Object? senderName = null,
    Object? recipientId = null,
    Object? message = null,
    Object? attachments = freezed,
    Object? timestamp = null,
    Object? read = null,
    Object? readAt = freezed,
    Object? type = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      conversationId: null == conversationId
          ? _self.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
              as String,
      senderId: null == senderId
          ? _self.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as String,
      senderType: null == senderType
          ? _self.senderType
          : senderType // ignore: cast_nullable_to_non_nullable
              as String,
      senderName: null == senderName
          ? _self.senderName
          : senderName // ignore: cast_nullable_to_non_nullable
              as String,
      recipientId: null == recipientId
          ? _self.recipientId
          : recipientId // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      attachments: freezed == attachments
          ? _self.attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<MessageAttachment>?,
      timestamp: null == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      read: null == read
          ? _self.read
          : read // ignore: cast_nullable_to_non_nullable
              as bool,
      readAt: freezed == readAt
          ? _self.readAt
          : readAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      type: freezed == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [SecureMessage].
extension SecureMessagePatterns on SecureMessage {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_SecureMessage value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SecureMessage() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_SecureMessage value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SecureMessage():
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_SecureMessage value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SecureMessage() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String id,
            String conversationId,
            String senderId,
            String senderType,
            String senderName,
            String recipientId,
            String message,
            List<MessageAttachment>? attachments,
            DateTime timestamp,
            bool read,
            DateTime? readAt,
            String? type)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SecureMessage() when $default != null:
        return $default(
            _that.id,
            _that.conversationId,
            _that.senderId,
            _that.senderType,
            _that.senderName,
            _that.recipientId,
            _that.message,
            _that.attachments,
            _that.timestamp,
            _that.read,
            _that.readAt,
            _that.type);
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String id,
            String conversationId,
            String senderId,
            String senderType,
            String senderName,
            String recipientId,
            String message,
            List<MessageAttachment>? attachments,
            DateTime timestamp,
            bool read,
            DateTime? readAt,
            String? type)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SecureMessage():
        return $default(
            _that.id,
            _that.conversationId,
            _that.senderId,
            _that.senderType,
            _that.senderName,
            _that.recipientId,
            _that.message,
            _that.attachments,
            _that.timestamp,
            _that.read,
            _that.readAt,
            _that.type);
      case _:
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String id,
            String conversationId,
            String senderId,
            String senderType,
            String senderName,
            String recipientId,
            String message,
            List<MessageAttachment>? attachments,
            DateTime timestamp,
            bool read,
            DateTime? readAt,
            String? type)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SecureMessage() when $default != null:
        return $default(
            _that.id,
            _that.conversationId,
            _that.senderId,
            _that.senderType,
            _that.senderName,
            _that.recipientId,
            _that.message,
            _that.attachments,
            _that.timestamp,
            _that.read,
            _that.readAt,
            _that.type);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _SecureMessage implements SecureMessage {
  const _SecureMessage(
      {required this.id,
      required this.conversationId,
      required this.senderId,
      required this.senderType,
      required this.senderName,
      required this.recipientId,
      required this.message,
      final List<MessageAttachment>? attachments,
      required this.timestamp,
      required this.read,
      this.readAt,
      this.type})
      : _attachments = attachments;
  factory _SecureMessage.fromJson(Map<String, dynamic> json) =>
      _$SecureMessageFromJson(json);

  @override
  final String id;
  @override
  final String conversationId;
  @override
  final String senderId;
  @override
  final String senderType;
  @override
  final String senderName;
  @override
  final String recipientId;
  @override
  final String message;
  final List<MessageAttachment>? _attachments;
  @override
  List<MessageAttachment>? get attachments {
    final value = _attachments;
    if (value == null) return null;
    if (_attachments is EqualUnmodifiableListView) return _attachments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final DateTime timestamp;
  @override
  final bool read;
  @override
  final DateTime? readAt;
  @override
  final String? type;

  /// Create a copy of SecureMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SecureMessageCopyWith<_SecureMessage> get copyWith =>
      __$SecureMessageCopyWithImpl<_SecureMessage>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SecureMessageToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SecureMessage &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId) &&
            (identical(other.senderId, senderId) ||
                other.senderId == senderId) &&
            (identical(other.senderType, senderType) ||
                other.senderType == senderType) &&
            (identical(other.senderName, senderName) ||
                other.senderName == senderName) &&
            (identical(other.recipientId, recipientId) ||
                other.recipientId == recipientId) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality()
                .equals(other._attachments, _attachments) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.read, read) || other.read == read) &&
            (identical(other.readAt, readAt) || other.readAt == readAt) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      conversationId,
      senderId,
      senderType,
      senderName,
      recipientId,
      message,
      const DeepCollectionEquality().hash(_attachments),
      timestamp,
      read,
      readAt,
      type);

  @override
  String toString() {
    return 'SecureMessage(id: $id, conversationId: $conversationId, senderId: $senderId, senderType: $senderType, senderName: $senderName, recipientId: $recipientId, message: $message, attachments: $attachments, timestamp: $timestamp, read: $read, readAt: $readAt, type: $type)';
  }
}

/// @nodoc
abstract mixin class _$SecureMessageCopyWith<$Res>
    implements $SecureMessageCopyWith<$Res> {
  factory _$SecureMessageCopyWith(
          _SecureMessage value, $Res Function(_SecureMessage) _then) =
      __$SecureMessageCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String conversationId,
      String senderId,
      String senderType,
      String senderName,
      String recipientId,
      String message,
      List<MessageAttachment>? attachments,
      DateTime timestamp,
      bool read,
      DateTime? readAt,
      String? type});
}

/// @nodoc
class __$SecureMessageCopyWithImpl<$Res>
    implements _$SecureMessageCopyWith<$Res> {
  __$SecureMessageCopyWithImpl(this._self, this._then);

  final _SecureMessage _self;
  final $Res Function(_SecureMessage) _then;

  /// Create a copy of SecureMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? conversationId = null,
    Object? senderId = null,
    Object? senderType = null,
    Object? senderName = null,
    Object? recipientId = null,
    Object? message = null,
    Object? attachments = freezed,
    Object? timestamp = null,
    Object? read = null,
    Object? readAt = freezed,
    Object? type = freezed,
  }) {
    return _then(_SecureMessage(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      conversationId: null == conversationId
          ? _self.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
              as String,
      senderId: null == senderId
          ? _self.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as String,
      senderType: null == senderType
          ? _self.senderType
          : senderType // ignore: cast_nullable_to_non_nullable
              as String,
      senderName: null == senderName
          ? _self.senderName
          : senderName // ignore: cast_nullable_to_non_nullable
              as String,
      recipientId: null == recipientId
          ? _self.recipientId
          : recipientId // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      attachments: freezed == attachments
          ? _self._attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<MessageAttachment>?,
      timestamp: null == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      read: null == read
          ? _self.read
          : read // ignore: cast_nullable_to_non_nullable
              as bool,
      readAt: freezed == readAt
          ? _self.readAt
          : readAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      type: freezed == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$MessageThread {
  String get id;
  String get appointmentId;
  String get clientId;
  String get workerId;
  String get organizationId;
  List<String> get participants;
  DateTime get createdAt;
  String? get lastMessage;
  DateTime? get lastMessageAt;
  Map<String, int>? get unreadCount;

  /// Resolved human-readable name for the worker in this conversation.
  /// Populated by the backend when listing conversations.
  String? get workerName;

  /// Resolved human-readable name for the client in this conversation.
  String? get clientName;

  /// Create a copy of MessageThread
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MessageThreadCopyWith<MessageThread> get copyWith =>
      _$MessageThreadCopyWithImpl<MessageThread>(
          this as MessageThread, _$identity);

  /// Serializes this MessageThread to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MessageThread &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.appointmentId, appointmentId) ||
                other.appointmentId == appointmentId) &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.workerId, workerId) ||
                other.workerId == workerId) &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            const DeepCollectionEquality()
                .equals(other.participants, participants) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.lastMessage, lastMessage) ||
                other.lastMessage == lastMessage) &&
            (identical(other.lastMessageAt, lastMessageAt) ||
                other.lastMessageAt == lastMessageAt) &&
            const DeepCollectionEquality()
                .equals(other.unreadCount, unreadCount) &&
            (identical(other.workerName, workerName) ||
                other.workerName == workerName) &&
            (identical(other.clientName, clientName) ||
                other.clientName == clientName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      appointmentId,
      clientId,
      workerId,
      organizationId,
      const DeepCollectionEquality().hash(participants),
      createdAt,
      lastMessage,
      lastMessageAt,
      const DeepCollectionEquality().hash(unreadCount),
      workerName,
      clientName);

  @override
  String toString() {
    return 'MessageThread(id: $id, appointmentId: $appointmentId, clientId: $clientId, workerId: $workerId, organizationId: $organizationId, participants: $participants, createdAt: $createdAt, lastMessage: $lastMessage, lastMessageAt: $lastMessageAt, unreadCount: $unreadCount, workerName: $workerName, clientName: $clientName)';
  }
}

/// @nodoc
abstract mixin class $MessageThreadCopyWith<$Res> {
  factory $MessageThreadCopyWith(
          MessageThread value, $Res Function(MessageThread) _then) =
      _$MessageThreadCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String appointmentId,
      String clientId,
      String workerId,
      String organizationId,
      List<String> participants,
      DateTime createdAt,
      String? lastMessage,
      DateTime? lastMessageAt,
      Map<String, int>? unreadCount,
      String? workerName,
      String? clientName});
}

/// @nodoc
class _$MessageThreadCopyWithImpl<$Res>
    implements $MessageThreadCopyWith<$Res> {
  _$MessageThreadCopyWithImpl(this._self, this._then);

  final MessageThread _self;
  final $Res Function(MessageThread) _then;

  /// Create a copy of MessageThread
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? appointmentId = null,
    Object? clientId = null,
    Object? workerId = null,
    Object? organizationId = null,
    Object? participants = null,
    Object? createdAt = null,
    Object? lastMessage = freezed,
    Object? lastMessageAt = freezed,
    Object? unreadCount = freezed,
    Object? workerName = freezed,
    Object? clientName = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      appointmentId: null == appointmentId
          ? _self.appointmentId
          : appointmentId // ignore: cast_nullable_to_non_nullable
              as String,
      clientId: null == clientId
          ? _self.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      workerId: null == workerId
          ? _self.workerId
          : workerId // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: null == organizationId
          ? _self.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      participants: null == participants
          ? _self.participants
          : participants // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastMessage: freezed == lastMessage
          ? _self.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      lastMessageAt: freezed == lastMessageAt
          ? _self.lastMessageAt
          : lastMessageAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      unreadCount: freezed == unreadCount
          ? _self.unreadCount
          : unreadCount // ignore: cast_nullable_to_non_nullable
              as Map<String, int>?,
      workerName: freezed == workerName
          ? _self.workerName
          : workerName // ignore: cast_nullable_to_non_nullable
              as String?,
      clientName: freezed == clientName
          ? _self.clientName
          : clientName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [MessageThread].
extension MessageThreadPatterns on MessageThread {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_MessageThread value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MessageThread() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_MessageThread value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MessageThread():
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_MessageThread value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MessageThread() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String id,
            String appointmentId,
            String clientId,
            String workerId,
            String organizationId,
            List<String> participants,
            DateTime createdAt,
            String? lastMessage,
            DateTime? lastMessageAt,
            Map<String, int>? unreadCount,
            String? workerName,
            String? clientName)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MessageThread() when $default != null:
        return $default(
            _that.id,
            _that.appointmentId,
            _that.clientId,
            _that.workerId,
            _that.organizationId,
            _that.participants,
            _that.createdAt,
            _that.lastMessage,
            _that.lastMessageAt,
            _that.unreadCount,
            _that.workerName,
            _that.clientName);
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String id,
            String appointmentId,
            String clientId,
            String workerId,
            String organizationId,
            List<String> participants,
            DateTime createdAt,
            String? lastMessage,
            DateTime? lastMessageAt,
            Map<String, int>? unreadCount,
            String? workerName,
            String? clientName)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MessageThread():
        return $default(
            _that.id,
            _that.appointmentId,
            _that.clientId,
            _that.workerId,
            _that.organizationId,
            _that.participants,
            _that.createdAt,
            _that.lastMessage,
            _that.lastMessageAt,
            _that.unreadCount,
            _that.workerName,
            _that.clientName);
      case _:
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String id,
            String appointmentId,
            String clientId,
            String workerId,
            String organizationId,
            List<String> participants,
            DateTime createdAt,
            String? lastMessage,
            DateTime? lastMessageAt,
            Map<String, int>? unreadCount,
            String? workerName,
            String? clientName)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MessageThread() when $default != null:
        return $default(
            _that.id,
            _that.appointmentId,
            _that.clientId,
            _that.workerId,
            _that.organizationId,
            _that.participants,
            _that.createdAt,
            _that.lastMessage,
            _that.lastMessageAt,
            _that.unreadCount,
            _that.workerName,
            _that.clientName);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _MessageThread implements MessageThread {
  const _MessageThread(
      {required this.id,
      required this.appointmentId,
      required this.clientId,
      required this.workerId,
      required this.organizationId,
      required final List<String> participants,
      required this.createdAt,
      this.lastMessage,
      this.lastMessageAt,
      final Map<String, int>? unreadCount,
      this.workerName,
      this.clientName})
      : _participants = participants,
        _unreadCount = unreadCount;
  factory _MessageThread.fromJson(Map<String, dynamic> json) =>
      _$MessageThreadFromJson(json);

  @override
  final String id;
  @override
  final String appointmentId;
  @override
  final String clientId;
  @override
  final String workerId;
  @override
  final String organizationId;
  final List<String> _participants;
  @override
  List<String> get participants {
    if (_participants is EqualUnmodifiableListView) return _participants;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_participants);
  }

  @override
  final DateTime createdAt;
  @override
  final String? lastMessage;
  @override
  final DateTime? lastMessageAt;
  final Map<String, int>? _unreadCount;
  @override
  Map<String, int>? get unreadCount {
    final value = _unreadCount;
    if (value == null) return null;
    if (_unreadCount is EqualUnmodifiableMapView) return _unreadCount;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  /// Resolved human-readable name for the worker in this conversation.
  /// Populated by the backend when listing conversations.
  @override
  final String? workerName;

  /// Resolved human-readable name for the client in this conversation.
  @override
  final String? clientName;

  /// Create a copy of MessageThread
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MessageThreadCopyWith<_MessageThread> get copyWith =>
      __$MessageThreadCopyWithImpl<_MessageThread>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$MessageThreadToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MessageThread &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.appointmentId, appointmentId) ||
                other.appointmentId == appointmentId) &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.workerId, workerId) ||
                other.workerId == workerId) &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            const DeepCollectionEquality()
                .equals(other._participants, _participants) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.lastMessage, lastMessage) ||
                other.lastMessage == lastMessage) &&
            (identical(other.lastMessageAt, lastMessageAt) ||
                other.lastMessageAt == lastMessageAt) &&
            const DeepCollectionEquality()
                .equals(other._unreadCount, _unreadCount) &&
            (identical(other.workerName, workerName) ||
                other.workerName == workerName) &&
            (identical(other.clientName, clientName) ||
                other.clientName == clientName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      appointmentId,
      clientId,
      workerId,
      organizationId,
      const DeepCollectionEquality().hash(_participants),
      createdAt,
      lastMessage,
      lastMessageAt,
      const DeepCollectionEquality().hash(_unreadCount),
      workerName,
      clientName);

  @override
  String toString() {
    return 'MessageThread(id: $id, appointmentId: $appointmentId, clientId: $clientId, workerId: $workerId, organizationId: $organizationId, participants: $participants, createdAt: $createdAt, lastMessage: $lastMessage, lastMessageAt: $lastMessageAt, unreadCount: $unreadCount, workerName: $workerName, clientName: $clientName)';
  }
}

/// @nodoc
abstract mixin class _$MessageThreadCopyWith<$Res>
    implements $MessageThreadCopyWith<$Res> {
  factory _$MessageThreadCopyWith(
          _MessageThread value, $Res Function(_MessageThread) _then) =
      __$MessageThreadCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String appointmentId,
      String clientId,
      String workerId,
      String organizationId,
      List<String> participants,
      DateTime createdAt,
      String? lastMessage,
      DateTime? lastMessageAt,
      Map<String, int>? unreadCount,
      String? workerName,
      String? clientName});
}

/// @nodoc
class __$MessageThreadCopyWithImpl<$Res>
    implements _$MessageThreadCopyWith<$Res> {
  __$MessageThreadCopyWithImpl(this._self, this._then);

  final _MessageThread _self;
  final $Res Function(_MessageThread) _then;

  /// Create a copy of MessageThread
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? appointmentId = null,
    Object? clientId = null,
    Object? workerId = null,
    Object? organizationId = null,
    Object? participants = null,
    Object? createdAt = null,
    Object? lastMessage = freezed,
    Object? lastMessageAt = freezed,
    Object? unreadCount = freezed,
    Object? workerName = freezed,
    Object? clientName = freezed,
  }) {
    return _then(_MessageThread(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      appointmentId: null == appointmentId
          ? _self.appointmentId
          : appointmentId // ignore: cast_nullable_to_non_nullable
              as String,
      clientId: null == clientId
          ? _self.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      workerId: null == workerId
          ? _self.workerId
          : workerId // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: null == organizationId
          ? _self.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      participants: null == participants
          ? _self._participants
          : participants // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastMessage: freezed == lastMessage
          ? _self.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      lastMessageAt: freezed == lastMessageAt
          ? _self.lastMessageAt
          : lastMessageAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      unreadCount: freezed == unreadCount
          ? _self._unreadCount
          : unreadCount // ignore: cast_nullable_to_non_nullable
              as Map<String, int>?,
      workerName: freezed == workerName
          ? _self.workerName
          : workerName // ignore: cast_nullable_to_non_nullable
              as String?,
      clientName: freezed == clientName
          ? _self.clientName
          : clientName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$MessageAttachment {
  String get url;
  String get name;
  String get type;
  int get size;
  String? get thumbnail;

  /// Create a copy of MessageAttachment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MessageAttachmentCopyWith<MessageAttachment> get copyWith =>
      _$MessageAttachmentCopyWithImpl<MessageAttachment>(
          this as MessageAttachment, _$identity);

  /// Serializes this MessageAttachment to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MessageAttachment &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.thumbnail, thumbnail) ||
                other.thumbnail == thumbnail));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, url, name, type, size, thumbnail);

  @override
  String toString() {
    return 'MessageAttachment(url: $url, name: $name, type: $type, size: $size, thumbnail: $thumbnail)';
  }
}

/// @nodoc
abstract mixin class $MessageAttachmentCopyWith<$Res> {
  factory $MessageAttachmentCopyWith(
          MessageAttachment value, $Res Function(MessageAttachment) _then) =
      _$MessageAttachmentCopyWithImpl;
  @useResult
  $Res call(
      {String url, String name, String type, int size, String? thumbnail});
}

/// @nodoc
class _$MessageAttachmentCopyWithImpl<$Res>
    implements $MessageAttachmentCopyWith<$Res> {
  _$MessageAttachmentCopyWithImpl(this._self, this._then);

  final MessageAttachment _self;
  final $Res Function(MessageAttachment) _then;

  /// Create a copy of MessageAttachment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? name = null,
    Object? type = null,
    Object? size = null,
    Object? thumbnail = freezed,
  }) {
    return _then(_self.copyWith(
      url: null == url
          ? _self.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      size: null == size
          ? _self.size
          : size // ignore: cast_nullable_to_non_nullable
              as int,
      thumbnail: freezed == thumbnail
          ? _self.thumbnail
          : thumbnail // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [MessageAttachment].
extension MessageAttachmentPatterns on MessageAttachment {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_MessageAttachment value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MessageAttachment() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_MessageAttachment value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MessageAttachment():
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_MessageAttachment value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MessageAttachment() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String url, String name, String type, int size, String? thumbnail)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MessageAttachment() when $default != null:
        return $default(
            _that.url, _that.name, _that.type, _that.size, _that.thumbnail);
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String url, String name, String type, int size, String? thumbnail)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MessageAttachment():
        return $default(
            _that.url, _that.name, _that.type, _that.size, _that.thumbnail);
      case _:
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String url, String name, String type, int size, String? thumbnail)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MessageAttachment() when $default != null:
        return $default(
            _that.url, _that.name, _that.type, _that.size, _that.thumbnail);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _MessageAttachment implements MessageAttachment {
  const _MessageAttachment(
      {required this.url,
      required this.name,
      required this.type,
      required this.size,
      this.thumbnail});
  factory _MessageAttachment.fromJson(Map<String, dynamic> json) =>
      _$MessageAttachmentFromJson(json);

  @override
  final String url;
  @override
  final String name;
  @override
  final String type;
  @override
  final int size;
  @override
  final String? thumbnail;

  /// Create a copy of MessageAttachment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MessageAttachmentCopyWith<_MessageAttachment> get copyWith =>
      __$MessageAttachmentCopyWithImpl<_MessageAttachment>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$MessageAttachmentToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MessageAttachment &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.thumbnail, thumbnail) ||
                other.thumbnail == thumbnail));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, url, name, type, size, thumbnail);

  @override
  String toString() {
    return 'MessageAttachment(url: $url, name: $name, type: $type, size: $size, thumbnail: $thumbnail)';
  }
}

/// @nodoc
abstract mixin class _$MessageAttachmentCopyWith<$Res>
    implements $MessageAttachmentCopyWith<$Res> {
  factory _$MessageAttachmentCopyWith(
          _MessageAttachment value, $Res Function(_MessageAttachment) _then) =
      __$MessageAttachmentCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String url, String name, String type, int size, String? thumbnail});
}

/// @nodoc
class __$MessageAttachmentCopyWithImpl<$Res>
    implements _$MessageAttachmentCopyWith<$Res> {
  __$MessageAttachmentCopyWithImpl(this._self, this._then);

  final _MessageAttachment _self;
  final $Res Function(_MessageAttachment) _then;

  /// Create a copy of MessageAttachment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? url = null,
    Object? name = null,
    Object? type = null,
    Object? size = null,
    Object? thumbnail = freezed,
  }) {
    return _then(_MessageAttachment(
      url: null == url
          ? _self.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      size: null == size
          ? _self.size
          : size // ignore: cast_nullable_to_non_nullable
              as int,
      thumbnail: freezed == thumbnail
          ? _self.thumbnail
          : thumbnail // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$VoiceMessage {
  String get id;
  String get conversationId;
  String get senderId;
  String get audioUrl;
  int get duration;
  DateTime get timestamp;
  bool? get played;

  /// Create a copy of VoiceMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $VoiceMessageCopyWith<VoiceMessage> get copyWith =>
      _$VoiceMessageCopyWithImpl<VoiceMessage>(
          this as VoiceMessage, _$identity);

  /// Serializes this VoiceMessage to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is VoiceMessage &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId) &&
            (identical(other.senderId, senderId) ||
                other.senderId == senderId) &&
            (identical(other.audioUrl, audioUrl) ||
                other.audioUrl == audioUrl) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.played, played) || other.played == played));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, conversationId, senderId,
      audioUrl, duration, timestamp, played);

  @override
  String toString() {
    return 'VoiceMessage(id: $id, conversationId: $conversationId, senderId: $senderId, audioUrl: $audioUrl, duration: $duration, timestamp: $timestamp, played: $played)';
  }
}

/// @nodoc
abstract mixin class $VoiceMessageCopyWith<$Res> {
  factory $VoiceMessageCopyWith(
          VoiceMessage value, $Res Function(VoiceMessage) _then) =
      _$VoiceMessageCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String conversationId,
      String senderId,
      String audioUrl,
      int duration,
      DateTime timestamp,
      bool? played});
}

/// @nodoc
class _$VoiceMessageCopyWithImpl<$Res> implements $VoiceMessageCopyWith<$Res> {
  _$VoiceMessageCopyWithImpl(this._self, this._then);

  final VoiceMessage _self;
  final $Res Function(VoiceMessage) _then;

  /// Create a copy of VoiceMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? conversationId = null,
    Object? senderId = null,
    Object? audioUrl = null,
    Object? duration = null,
    Object? timestamp = null,
    Object? played = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      conversationId: null == conversationId
          ? _self.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
              as String,
      senderId: null == senderId
          ? _self.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as String,
      audioUrl: null == audioUrl
          ? _self.audioUrl
          : audioUrl // ignore: cast_nullable_to_non_nullable
              as String,
      duration: null == duration
          ? _self.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int,
      timestamp: null == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      played: freezed == played
          ? _self.played
          : played // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// Adds pattern-matching-related methods to [VoiceMessage].
extension VoiceMessagePatterns on VoiceMessage {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_VoiceMessage value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _VoiceMessage() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_VoiceMessage value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VoiceMessage():
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_VoiceMessage value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VoiceMessage() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String id, String conversationId, String senderId,
            String audioUrl, int duration, DateTime timestamp, bool? played)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _VoiceMessage() when $default != null:
        return $default(_that.id, _that.conversationId, _that.senderId,
            _that.audioUrl, _that.duration, _that.timestamp, _that.played);
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String id, String conversationId, String senderId,
            String audioUrl, int duration, DateTime timestamp, bool? played)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VoiceMessage():
        return $default(_that.id, _that.conversationId, _that.senderId,
            _that.audioUrl, _that.duration, _that.timestamp, _that.played);
      case _:
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String id, String conversationId, String senderId,
            String audioUrl, int duration, DateTime timestamp, bool? played)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VoiceMessage() when $default != null:
        return $default(_that.id, _that.conversationId, _that.senderId,
            _that.audioUrl, _that.duration, _that.timestamp, _that.played);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _VoiceMessage implements VoiceMessage {
  const _VoiceMessage(
      {required this.id,
      required this.conversationId,
      required this.senderId,
      required this.audioUrl,
      required this.duration,
      required this.timestamp,
      this.played});
  factory _VoiceMessage.fromJson(Map<String, dynamic> json) =>
      _$VoiceMessageFromJson(json);

  @override
  final String id;
  @override
  final String conversationId;
  @override
  final String senderId;
  @override
  final String audioUrl;
  @override
  final int duration;
  @override
  final DateTime timestamp;
  @override
  final bool? played;

  /// Create a copy of VoiceMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$VoiceMessageCopyWith<_VoiceMessage> get copyWith =>
      __$VoiceMessageCopyWithImpl<_VoiceMessage>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$VoiceMessageToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _VoiceMessage &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId) &&
            (identical(other.senderId, senderId) ||
                other.senderId == senderId) &&
            (identical(other.audioUrl, audioUrl) ||
                other.audioUrl == audioUrl) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.played, played) || other.played == played));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, conversationId, senderId,
      audioUrl, duration, timestamp, played);

  @override
  String toString() {
    return 'VoiceMessage(id: $id, conversationId: $conversationId, senderId: $senderId, audioUrl: $audioUrl, duration: $duration, timestamp: $timestamp, played: $played)';
  }
}

/// @nodoc
abstract mixin class _$VoiceMessageCopyWith<$Res>
    implements $VoiceMessageCopyWith<$Res> {
  factory _$VoiceMessageCopyWith(
          _VoiceMessage value, $Res Function(_VoiceMessage) _then) =
      __$VoiceMessageCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String conversationId,
      String senderId,
      String audioUrl,
      int duration,
      DateTime timestamp,
      bool? played});
}

/// @nodoc
class __$VoiceMessageCopyWithImpl<$Res>
    implements _$VoiceMessageCopyWith<$Res> {
  __$VoiceMessageCopyWithImpl(this._self, this._then);

  final _VoiceMessage _self;
  final $Res Function(_VoiceMessage) _then;

  /// Create a copy of VoiceMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? conversationId = null,
    Object? senderId = null,
    Object? audioUrl = null,
    Object? duration = null,
    Object? timestamp = null,
    Object? played = freezed,
  }) {
    return _then(_VoiceMessage(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      conversationId: null == conversationId
          ? _self.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
              as String,
      senderId: null == senderId
          ? _self.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as String,
      audioUrl: null == audioUrl
          ? _self.audioUrl
          : audioUrl // ignore: cast_nullable_to_non_nullable
              as String,
      duration: null == duration
          ? _self.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int,
      timestamp: null == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      played: freezed == played
          ? _self.played
          : played // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
mixin _$TypingIndicator {
  String get conversationId;
  String get userId;
  String get userName;
  bool get isTyping;

  /// Create a copy of TypingIndicator
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TypingIndicatorCopyWith<TypingIndicator> get copyWith =>
      _$TypingIndicatorCopyWithImpl<TypingIndicator>(
          this as TypingIndicator, _$identity);

  /// Serializes this TypingIndicator to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TypingIndicator &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.isTyping, isTyping) ||
                other.isTyping == isTyping));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, conversationId, userId, userName, isTyping);

  @override
  String toString() {
    return 'TypingIndicator(conversationId: $conversationId, userId: $userId, userName: $userName, isTyping: $isTyping)';
  }
}

/// @nodoc
abstract mixin class $TypingIndicatorCopyWith<$Res> {
  factory $TypingIndicatorCopyWith(
          TypingIndicator value, $Res Function(TypingIndicator) _then) =
      _$TypingIndicatorCopyWithImpl;
  @useResult
  $Res call(
      {String conversationId, String userId, String userName, bool isTyping});
}

/// @nodoc
class _$TypingIndicatorCopyWithImpl<$Res>
    implements $TypingIndicatorCopyWith<$Res> {
  _$TypingIndicatorCopyWithImpl(this._self, this._then);

  final TypingIndicator _self;
  final $Res Function(TypingIndicator) _then;

  /// Create a copy of TypingIndicator
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? conversationId = null,
    Object? userId = null,
    Object? userName = null,
    Object? isTyping = null,
  }) {
    return _then(_self.copyWith(
      conversationId: null == conversationId
          ? _self.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      userName: null == userName
          ? _self.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      isTyping: null == isTyping
          ? _self.isTyping
          : isTyping // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [TypingIndicator].
extension TypingIndicatorPatterns on TypingIndicator {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_TypingIndicator value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TypingIndicator() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_TypingIndicator value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TypingIndicator():
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_TypingIndicator value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TypingIndicator() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String conversationId, String userId, String userName,
            bool isTyping)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TypingIndicator() when $default != null:
        return $default(
            _that.conversationId, _that.userId, _that.userName, _that.isTyping);
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String conversationId, String userId, String userName,
            bool isTyping)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TypingIndicator():
        return $default(
            _that.conversationId, _that.userId, _that.userName, _that.isTyping);
      case _:
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String conversationId, String userId, String userName,
            bool isTyping)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TypingIndicator() when $default != null:
        return $default(
            _that.conversationId, _that.userId, _that.userName, _that.isTyping);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _TypingIndicator implements TypingIndicator {
  const _TypingIndicator(
      {required this.conversationId,
      required this.userId,
      required this.userName,
      required this.isTyping});
  factory _TypingIndicator.fromJson(Map<String, dynamic> json) =>
      _$TypingIndicatorFromJson(json);

  @override
  final String conversationId;
  @override
  final String userId;
  @override
  final String userName;
  @override
  final bool isTyping;

  /// Create a copy of TypingIndicator
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TypingIndicatorCopyWith<_TypingIndicator> get copyWith =>
      __$TypingIndicatorCopyWithImpl<_TypingIndicator>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TypingIndicatorToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TypingIndicator &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.isTyping, isTyping) ||
                other.isTyping == isTyping));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, conversationId, userId, userName, isTyping);

  @override
  String toString() {
    return 'TypingIndicator(conversationId: $conversationId, userId: $userId, userName: $userName, isTyping: $isTyping)';
  }
}

/// @nodoc
abstract mixin class _$TypingIndicatorCopyWith<$Res>
    implements $TypingIndicatorCopyWith<$Res> {
  factory _$TypingIndicatorCopyWith(
          _TypingIndicator value, $Res Function(_TypingIndicator) _then) =
      __$TypingIndicatorCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String conversationId, String userId, String userName, bool isTyping});
}

/// @nodoc
class __$TypingIndicatorCopyWithImpl<$Res>
    implements _$TypingIndicatorCopyWith<$Res> {
  __$TypingIndicatorCopyWithImpl(this._self, this._then);

  final _TypingIndicator _self;
  final $Res Function(_TypingIndicator) _then;

  /// Create a copy of TypingIndicator
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? conversationId = null,
    Object? userId = null,
    Object? userName = null,
    Object? isTyping = null,
  }) {
    return _then(_TypingIndicator(
      conversationId: null == conversationId
          ? _self.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      userName: null == userName
          ? _self.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      isTyping: null == isTyping
          ? _self.isTyping
          : isTyping // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
mixin _$DigitalSignature {
  String get id;
  String get appointmentId;
  String get clientId;
  String get signatureData;
  DateTime get timestamp;
  String get hash;
  bool get verified;
  String? get ipAddress;
  String? get deviceInfo;

  /// Create a copy of DigitalSignature
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DigitalSignatureCopyWith<DigitalSignature> get copyWith =>
      _$DigitalSignatureCopyWithImpl<DigitalSignature>(
          this as DigitalSignature, _$identity);

  /// Serializes this DigitalSignature to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DigitalSignature &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.appointmentId, appointmentId) ||
                other.appointmentId == appointmentId) &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.signatureData, signatureData) ||
                other.signatureData == signatureData) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.hash, hash) || other.hash == hash) &&
            (identical(other.verified, verified) ||
                other.verified == verified) &&
            (identical(other.ipAddress, ipAddress) ||
                other.ipAddress == ipAddress) &&
            (identical(other.deviceInfo, deviceInfo) ||
                other.deviceInfo == deviceInfo));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, appointmentId, clientId,
      signatureData, timestamp, hash, verified, ipAddress, deviceInfo);

  @override
  String toString() {
    return 'DigitalSignature(id: $id, appointmentId: $appointmentId, clientId: $clientId, signatureData: $signatureData, timestamp: $timestamp, hash: $hash, verified: $verified, ipAddress: $ipAddress, deviceInfo: $deviceInfo)';
  }
}

/// @nodoc
abstract mixin class $DigitalSignatureCopyWith<$Res> {
  factory $DigitalSignatureCopyWith(
          DigitalSignature value, $Res Function(DigitalSignature) _then) =
      _$DigitalSignatureCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String appointmentId,
      String clientId,
      String signatureData,
      DateTime timestamp,
      String hash,
      bool verified,
      String? ipAddress,
      String? deviceInfo});
}

/// @nodoc
class _$DigitalSignatureCopyWithImpl<$Res>
    implements $DigitalSignatureCopyWith<$Res> {
  _$DigitalSignatureCopyWithImpl(this._self, this._then);

  final DigitalSignature _self;
  final $Res Function(DigitalSignature) _then;

  /// Create a copy of DigitalSignature
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? appointmentId = null,
    Object? clientId = null,
    Object? signatureData = null,
    Object? timestamp = null,
    Object? hash = null,
    Object? verified = null,
    Object? ipAddress = freezed,
    Object? deviceInfo = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      appointmentId: null == appointmentId
          ? _self.appointmentId
          : appointmentId // ignore: cast_nullable_to_non_nullable
              as String,
      clientId: null == clientId
          ? _self.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      signatureData: null == signatureData
          ? _self.signatureData
          : signatureData // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      hash: null == hash
          ? _self.hash
          : hash // ignore: cast_nullable_to_non_nullable
              as String,
      verified: null == verified
          ? _self.verified
          : verified // ignore: cast_nullable_to_non_nullable
              as bool,
      ipAddress: freezed == ipAddress
          ? _self.ipAddress
          : ipAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      deviceInfo: freezed == deviceInfo
          ? _self.deviceInfo
          : deviceInfo // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [DigitalSignature].
extension DigitalSignaturePatterns on DigitalSignature {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_DigitalSignature value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DigitalSignature() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_DigitalSignature value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DigitalSignature():
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_DigitalSignature value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DigitalSignature() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String id,
            String appointmentId,
            String clientId,
            String signatureData,
            DateTime timestamp,
            String hash,
            bool verified,
            String? ipAddress,
            String? deviceInfo)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DigitalSignature() when $default != null:
        return $default(
            _that.id,
            _that.appointmentId,
            _that.clientId,
            _that.signatureData,
            _that.timestamp,
            _that.hash,
            _that.verified,
            _that.ipAddress,
            _that.deviceInfo);
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String id,
            String appointmentId,
            String clientId,
            String signatureData,
            DateTime timestamp,
            String hash,
            bool verified,
            String? ipAddress,
            String? deviceInfo)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DigitalSignature():
        return $default(
            _that.id,
            _that.appointmentId,
            _that.clientId,
            _that.signatureData,
            _that.timestamp,
            _that.hash,
            _that.verified,
            _that.ipAddress,
            _that.deviceInfo);
      case _:
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String id,
            String appointmentId,
            String clientId,
            String signatureData,
            DateTime timestamp,
            String hash,
            bool verified,
            String? ipAddress,
            String? deviceInfo)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DigitalSignature() when $default != null:
        return $default(
            _that.id,
            _that.appointmentId,
            _that.clientId,
            _that.signatureData,
            _that.timestamp,
            _that.hash,
            _that.verified,
            _that.ipAddress,
            _that.deviceInfo);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _DigitalSignature implements DigitalSignature {
  const _DigitalSignature(
      {required this.id,
      required this.appointmentId,
      required this.clientId,
      required this.signatureData,
      required this.timestamp,
      required this.hash,
      required this.verified,
      this.ipAddress,
      this.deviceInfo});
  factory _DigitalSignature.fromJson(Map<String, dynamic> json) =>
      _$DigitalSignatureFromJson(json);

  @override
  final String id;
  @override
  final String appointmentId;
  @override
  final String clientId;
  @override
  final String signatureData;
  @override
  final DateTime timestamp;
  @override
  final String hash;
  @override
  final bool verified;
  @override
  final String? ipAddress;
  @override
  final String? deviceInfo;

  /// Create a copy of DigitalSignature
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DigitalSignatureCopyWith<_DigitalSignature> get copyWith =>
      __$DigitalSignatureCopyWithImpl<_DigitalSignature>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$DigitalSignatureToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DigitalSignature &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.appointmentId, appointmentId) ||
                other.appointmentId == appointmentId) &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.signatureData, signatureData) ||
                other.signatureData == signatureData) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.hash, hash) || other.hash == hash) &&
            (identical(other.verified, verified) ||
                other.verified == verified) &&
            (identical(other.ipAddress, ipAddress) ||
                other.ipAddress == ipAddress) &&
            (identical(other.deviceInfo, deviceInfo) ||
                other.deviceInfo == deviceInfo));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, appointmentId, clientId,
      signatureData, timestamp, hash, verified, ipAddress, deviceInfo);

  @override
  String toString() {
    return 'DigitalSignature(id: $id, appointmentId: $appointmentId, clientId: $clientId, signatureData: $signatureData, timestamp: $timestamp, hash: $hash, verified: $verified, ipAddress: $ipAddress, deviceInfo: $deviceInfo)';
  }
}

/// @nodoc
abstract mixin class _$DigitalSignatureCopyWith<$Res>
    implements $DigitalSignatureCopyWith<$Res> {
  factory _$DigitalSignatureCopyWith(
          _DigitalSignature value, $Res Function(_DigitalSignature) _then) =
      __$DigitalSignatureCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String appointmentId,
      String clientId,
      String signatureData,
      DateTime timestamp,
      String hash,
      bool verified,
      String? ipAddress,
      String? deviceInfo});
}

/// @nodoc
class __$DigitalSignatureCopyWithImpl<$Res>
    implements _$DigitalSignatureCopyWith<$Res> {
  __$DigitalSignatureCopyWithImpl(this._self, this._then);

  final _DigitalSignature _self;
  final $Res Function(_DigitalSignature) _then;

  /// Create a copy of DigitalSignature
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? appointmentId = null,
    Object? clientId = null,
    Object? signatureData = null,
    Object? timestamp = null,
    Object? hash = null,
    Object? verified = null,
    Object? ipAddress = freezed,
    Object? deviceInfo = freezed,
  }) {
    return _then(_DigitalSignature(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      appointmentId: null == appointmentId
          ? _self.appointmentId
          : appointmentId // ignore: cast_nullable_to_non_nullable
              as String,
      clientId: null == clientId
          ? _self.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      signatureData: null == signatureData
          ? _self.signatureData
          : signatureData // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      hash: null == hash
          ? _self.hash
          : hash // ignore: cast_nullable_to_non_nullable
              as String,
      verified: null == verified
          ? _self.verified
          : verified // ignore: cast_nullable_to_non_nullable
              as bool,
      ipAddress: freezed == ipAddress
          ? _self.ipAddress
          : ipAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      deviceInfo: freezed == deviceInfo
          ? _self.deviceInfo
          : deviceInfo // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$ServiceConfirmation {
  String get id;
  String get appointmentId;
  String get clientId;
  String get workerId;
  String get signatureId;
  int? get rating;
  String? get feedback;
  List<ChecklistItem>? get checklist;
  List<String>? get photos;
  List<IncidentReport>? get incidents;
  DateTime get timestamp;
  String get status;
  String? get reportUrl;

  /// Create a copy of ServiceConfirmation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ServiceConfirmationCopyWith<ServiceConfirmation> get copyWith =>
      _$ServiceConfirmationCopyWithImpl<ServiceConfirmation>(
          this as ServiceConfirmation, _$identity);

  /// Serializes this ServiceConfirmation to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ServiceConfirmation &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.appointmentId, appointmentId) ||
                other.appointmentId == appointmentId) &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.workerId, workerId) ||
                other.workerId == workerId) &&
            (identical(other.signatureId, signatureId) ||
                other.signatureId == signatureId) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.feedback, feedback) ||
                other.feedback == feedback) &&
            const DeepCollectionEquality().equals(other.checklist, checklist) &&
            const DeepCollectionEquality().equals(other.photos, photos) &&
            const DeepCollectionEquality().equals(other.incidents, incidents) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.reportUrl, reportUrl) ||
                other.reportUrl == reportUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      appointmentId,
      clientId,
      workerId,
      signatureId,
      rating,
      feedback,
      const DeepCollectionEquality().hash(checklist),
      const DeepCollectionEquality().hash(photos),
      const DeepCollectionEquality().hash(incidents),
      timestamp,
      status,
      reportUrl);

  @override
  String toString() {
    return 'ServiceConfirmation(id: $id, appointmentId: $appointmentId, clientId: $clientId, workerId: $workerId, signatureId: $signatureId, rating: $rating, feedback: $feedback, checklist: $checklist, photos: $photos, incidents: $incidents, timestamp: $timestamp, status: $status, reportUrl: $reportUrl)';
  }
}

/// @nodoc
abstract mixin class $ServiceConfirmationCopyWith<$Res> {
  factory $ServiceConfirmationCopyWith(
          ServiceConfirmation value, $Res Function(ServiceConfirmation) _then) =
      _$ServiceConfirmationCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String appointmentId,
      String clientId,
      String workerId,
      String signatureId,
      int? rating,
      String? feedback,
      List<ChecklistItem>? checklist,
      List<String>? photos,
      List<IncidentReport>? incidents,
      DateTime timestamp,
      String status,
      String? reportUrl});
}

/// @nodoc
class _$ServiceConfirmationCopyWithImpl<$Res>
    implements $ServiceConfirmationCopyWith<$Res> {
  _$ServiceConfirmationCopyWithImpl(this._self, this._then);

  final ServiceConfirmation _self;
  final $Res Function(ServiceConfirmation) _then;

  /// Create a copy of ServiceConfirmation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? appointmentId = null,
    Object? clientId = null,
    Object? workerId = null,
    Object? signatureId = null,
    Object? rating = freezed,
    Object? feedback = freezed,
    Object? checklist = freezed,
    Object? photos = freezed,
    Object? incidents = freezed,
    Object? timestamp = null,
    Object? status = null,
    Object? reportUrl = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      appointmentId: null == appointmentId
          ? _self.appointmentId
          : appointmentId // ignore: cast_nullable_to_non_nullable
              as String,
      clientId: null == clientId
          ? _self.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      workerId: null == workerId
          ? _self.workerId
          : workerId // ignore: cast_nullable_to_non_nullable
              as String,
      signatureId: null == signatureId
          ? _self.signatureId
          : signatureId // ignore: cast_nullable_to_non_nullable
              as String,
      rating: freezed == rating
          ? _self.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as int?,
      feedback: freezed == feedback
          ? _self.feedback
          : feedback // ignore: cast_nullable_to_non_nullable
              as String?,
      checklist: freezed == checklist
          ? _self.checklist
          : checklist // ignore: cast_nullable_to_non_nullable
              as List<ChecklistItem>?,
      photos: freezed == photos
          ? _self.photos
          : photos // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      incidents: freezed == incidents
          ? _self.incidents
          : incidents // ignore: cast_nullable_to_non_nullable
              as List<IncidentReport>?,
      timestamp: null == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      reportUrl: freezed == reportUrl
          ? _self.reportUrl
          : reportUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [ServiceConfirmation].
extension ServiceConfirmationPatterns on ServiceConfirmation {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_ServiceConfirmation value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ServiceConfirmation() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_ServiceConfirmation value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ServiceConfirmation():
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_ServiceConfirmation value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ServiceConfirmation() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String id,
            String appointmentId,
            String clientId,
            String workerId,
            String signatureId,
            int? rating,
            String? feedback,
            List<ChecklistItem>? checklist,
            List<String>? photos,
            List<IncidentReport>? incidents,
            DateTime timestamp,
            String status,
            String? reportUrl)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ServiceConfirmation() when $default != null:
        return $default(
            _that.id,
            _that.appointmentId,
            _that.clientId,
            _that.workerId,
            _that.signatureId,
            _that.rating,
            _that.feedback,
            _that.checklist,
            _that.photos,
            _that.incidents,
            _that.timestamp,
            _that.status,
            _that.reportUrl);
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String id,
            String appointmentId,
            String clientId,
            String workerId,
            String signatureId,
            int? rating,
            String? feedback,
            List<ChecklistItem>? checklist,
            List<String>? photos,
            List<IncidentReport>? incidents,
            DateTime timestamp,
            String status,
            String? reportUrl)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ServiceConfirmation():
        return $default(
            _that.id,
            _that.appointmentId,
            _that.clientId,
            _that.workerId,
            _that.signatureId,
            _that.rating,
            _that.feedback,
            _that.checklist,
            _that.photos,
            _that.incidents,
            _that.timestamp,
            _that.status,
            _that.reportUrl);
      case _:
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String id,
            String appointmentId,
            String clientId,
            String workerId,
            String signatureId,
            int? rating,
            String? feedback,
            List<ChecklistItem>? checklist,
            List<String>? photos,
            List<IncidentReport>? incidents,
            DateTime timestamp,
            String status,
            String? reportUrl)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ServiceConfirmation() when $default != null:
        return $default(
            _that.id,
            _that.appointmentId,
            _that.clientId,
            _that.workerId,
            _that.signatureId,
            _that.rating,
            _that.feedback,
            _that.checklist,
            _that.photos,
            _that.incidents,
            _that.timestamp,
            _that.status,
            _that.reportUrl);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ServiceConfirmation implements ServiceConfirmation {
  const _ServiceConfirmation(
      {required this.id,
      required this.appointmentId,
      required this.clientId,
      required this.workerId,
      required this.signatureId,
      this.rating,
      this.feedback,
      final List<ChecklistItem>? checklist,
      final List<String>? photos,
      final List<IncidentReport>? incidents,
      required this.timestamp,
      required this.status,
      this.reportUrl})
      : _checklist = checklist,
        _photos = photos,
        _incidents = incidents;
  factory _ServiceConfirmation.fromJson(Map<String, dynamic> json) =>
      _$ServiceConfirmationFromJson(json);

  @override
  final String id;
  @override
  final String appointmentId;
  @override
  final String clientId;
  @override
  final String workerId;
  @override
  final String signatureId;
  @override
  final int? rating;
  @override
  final String? feedback;
  final List<ChecklistItem>? _checklist;
  @override
  List<ChecklistItem>? get checklist {
    final value = _checklist;
    if (value == null) return null;
    if (_checklist is EqualUnmodifiableListView) return _checklist;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _photos;
  @override
  List<String>? get photos {
    final value = _photos;
    if (value == null) return null;
    if (_photos is EqualUnmodifiableListView) return _photos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<IncidentReport>? _incidents;
  @override
  List<IncidentReport>? get incidents {
    final value = _incidents;
    if (value == null) return null;
    if (_incidents is EqualUnmodifiableListView) return _incidents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final DateTime timestamp;
  @override
  final String status;
  @override
  final String? reportUrl;

  /// Create a copy of ServiceConfirmation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ServiceConfirmationCopyWith<_ServiceConfirmation> get copyWith =>
      __$ServiceConfirmationCopyWithImpl<_ServiceConfirmation>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ServiceConfirmationToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ServiceConfirmation &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.appointmentId, appointmentId) ||
                other.appointmentId == appointmentId) &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.workerId, workerId) ||
                other.workerId == workerId) &&
            (identical(other.signatureId, signatureId) ||
                other.signatureId == signatureId) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.feedback, feedback) ||
                other.feedback == feedback) &&
            const DeepCollectionEquality()
                .equals(other._checklist, _checklist) &&
            const DeepCollectionEquality().equals(other._photos, _photos) &&
            const DeepCollectionEquality()
                .equals(other._incidents, _incidents) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.reportUrl, reportUrl) ||
                other.reportUrl == reportUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      appointmentId,
      clientId,
      workerId,
      signatureId,
      rating,
      feedback,
      const DeepCollectionEquality().hash(_checklist),
      const DeepCollectionEquality().hash(_photos),
      const DeepCollectionEquality().hash(_incidents),
      timestamp,
      status,
      reportUrl);

  @override
  String toString() {
    return 'ServiceConfirmation(id: $id, appointmentId: $appointmentId, clientId: $clientId, workerId: $workerId, signatureId: $signatureId, rating: $rating, feedback: $feedback, checklist: $checklist, photos: $photos, incidents: $incidents, timestamp: $timestamp, status: $status, reportUrl: $reportUrl)';
  }
}

/// @nodoc
abstract mixin class _$ServiceConfirmationCopyWith<$Res>
    implements $ServiceConfirmationCopyWith<$Res> {
  factory _$ServiceConfirmationCopyWith(_ServiceConfirmation value,
          $Res Function(_ServiceConfirmation) _then) =
      __$ServiceConfirmationCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String appointmentId,
      String clientId,
      String workerId,
      String signatureId,
      int? rating,
      String? feedback,
      List<ChecklistItem>? checklist,
      List<String>? photos,
      List<IncidentReport>? incidents,
      DateTime timestamp,
      String status,
      String? reportUrl});
}

/// @nodoc
class __$ServiceConfirmationCopyWithImpl<$Res>
    implements _$ServiceConfirmationCopyWith<$Res> {
  __$ServiceConfirmationCopyWithImpl(this._self, this._then);

  final _ServiceConfirmation _self;
  final $Res Function(_ServiceConfirmation) _then;

  /// Create a copy of ServiceConfirmation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? appointmentId = null,
    Object? clientId = null,
    Object? workerId = null,
    Object? signatureId = null,
    Object? rating = freezed,
    Object? feedback = freezed,
    Object? checklist = freezed,
    Object? photos = freezed,
    Object? incidents = freezed,
    Object? timestamp = null,
    Object? status = null,
    Object? reportUrl = freezed,
  }) {
    return _then(_ServiceConfirmation(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      appointmentId: null == appointmentId
          ? _self.appointmentId
          : appointmentId // ignore: cast_nullable_to_non_nullable
              as String,
      clientId: null == clientId
          ? _self.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      workerId: null == workerId
          ? _self.workerId
          : workerId // ignore: cast_nullable_to_non_nullable
              as String,
      signatureId: null == signatureId
          ? _self.signatureId
          : signatureId // ignore: cast_nullable_to_non_nullable
              as String,
      rating: freezed == rating
          ? _self.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as int?,
      feedback: freezed == feedback
          ? _self.feedback
          : feedback // ignore: cast_nullable_to_non_nullable
              as String?,
      checklist: freezed == checklist
          ? _self._checklist
          : checklist // ignore: cast_nullable_to_non_nullable
              as List<ChecklistItem>?,
      photos: freezed == photos
          ? _self._photos
          : photos // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      incidents: freezed == incidents
          ? _self._incidents
          : incidents // ignore: cast_nullable_to_non_nullable
              as List<IncidentReport>?,
      timestamp: null == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      reportUrl: freezed == reportUrl
          ? _self.reportUrl
          : reportUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$ChecklistItem {
  int get id;
  String get item;
  bool get required;
  bool? get completed;
  DateTime? get completedAt;
  String? get notes;

  /// Create a copy of ChecklistItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ChecklistItemCopyWith<ChecklistItem> get copyWith =>
      _$ChecklistItemCopyWithImpl<ChecklistItem>(
          this as ChecklistItem, _$identity);

  /// Serializes this ChecklistItem to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ChecklistItem &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.item, item) || other.item == item) &&
            (identical(other.required, required) ||
                other.required == required) &&
            (identical(other.completed, completed) ||
                other.completed == completed) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, item, required, completed, completedAt, notes);

  @override
  String toString() {
    return 'ChecklistItem(id: $id, item: $item, required: $required, completed: $completed, completedAt: $completedAt, notes: $notes)';
  }
}

/// @nodoc
abstract mixin class $ChecklistItemCopyWith<$Res> {
  factory $ChecklistItemCopyWith(
          ChecklistItem value, $Res Function(ChecklistItem) _then) =
      _$ChecklistItemCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      String item,
      bool required,
      bool? completed,
      DateTime? completedAt,
      String? notes});
}

/// @nodoc
class _$ChecklistItemCopyWithImpl<$Res>
    implements $ChecklistItemCopyWith<$Res> {
  _$ChecklistItemCopyWithImpl(this._self, this._then);

  final ChecklistItem _self;
  final $Res Function(ChecklistItem) _then;

  /// Create a copy of ChecklistItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? item = null,
    Object? required = null,
    Object? completed = freezed,
    Object? completedAt = freezed,
    Object? notes = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      item: null == item
          ? _self.item
          : item // ignore: cast_nullable_to_non_nullable
              as String,
      required: null == required
          ? _self.required
          : required // ignore: cast_nullable_to_non_nullable
              as bool,
      completed: freezed == completed
          ? _self.completed
          : completed // ignore: cast_nullable_to_non_nullable
              as bool?,
      completedAt: freezed == completedAt
          ? _self.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      notes: freezed == notes
          ? _self.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [ChecklistItem].
extension ChecklistItemPatterns on ChecklistItem {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_ChecklistItem value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ChecklistItem() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_ChecklistItem value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ChecklistItem():
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_ChecklistItem value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ChecklistItem() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(int id, String item, bool required, bool? completed,
            DateTime? completedAt, String? notes)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ChecklistItem() when $default != null:
        return $default(_that.id, _that.item, _that.required, _that.completed,
            _that.completedAt, _that.notes);
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(int id, String item, bool required, bool? completed,
            DateTime? completedAt, String? notes)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ChecklistItem():
        return $default(_that.id, _that.item, _that.required, _that.completed,
            _that.completedAt, _that.notes);
      case _:
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(int id, String item, bool required, bool? completed,
            DateTime? completedAt, String? notes)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ChecklistItem() when $default != null:
        return $default(_that.id, _that.item, _that.required, _that.completed,
            _that.completedAt, _that.notes);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ChecklistItem implements ChecklistItem {
  const _ChecklistItem(
      {required this.id,
      required this.item,
      required this.required,
      this.completed,
      this.completedAt,
      this.notes});
  factory _ChecklistItem.fromJson(Map<String, dynamic> json) =>
      _$ChecklistItemFromJson(json);

  @override
  final int id;
  @override
  final String item;
  @override
  final bool required;
  @override
  final bool? completed;
  @override
  final DateTime? completedAt;
  @override
  final String? notes;

  /// Create a copy of ChecklistItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ChecklistItemCopyWith<_ChecklistItem> get copyWith =>
      __$ChecklistItemCopyWithImpl<_ChecklistItem>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ChecklistItemToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ChecklistItem &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.item, item) || other.item == item) &&
            (identical(other.required, required) ||
                other.required == required) &&
            (identical(other.completed, completed) ||
                other.completed == completed) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, item, required, completed, completedAt, notes);

  @override
  String toString() {
    return 'ChecklistItem(id: $id, item: $item, required: $required, completed: $completed, completedAt: $completedAt, notes: $notes)';
  }
}

/// @nodoc
abstract mixin class _$ChecklistItemCopyWith<$Res>
    implements $ChecklistItemCopyWith<$Res> {
  factory _$ChecklistItemCopyWith(
          _ChecklistItem value, $Res Function(_ChecklistItem) _then) =
      __$ChecklistItemCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      String item,
      bool required,
      bool? completed,
      DateTime? completedAt,
      String? notes});
}

/// @nodoc
class __$ChecklistItemCopyWithImpl<$Res>
    implements _$ChecklistItemCopyWith<$Res> {
  __$ChecklistItemCopyWithImpl(this._self, this._then);

  final _ChecklistItem _self;
  final $Res Function(_ChecklistItem) _then;

  /// Create a copy of ChecklistItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? item = null,
    Object? required = null,
    Object? completed = freezed,
    Object? completedAt = freezed,
    Object? notes = freezed,
  }) {
    return _then(_ChecklistItem(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      item: null == item
          ? _self.item
          : item // ignore: cast_nullable_to_non_nullable
              as String,
      required: null == required
          ? _self.required
          : required // ignore: cast_nullable_to_non_nullable
              as bool,
      completed: freezed == completed
          ? _self.completed
          : completed // ignore: cast_nullable_to_non_nullable
              as bool?,
      completedAt: freezed == completedAt
          ? _self.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      notes: freezed == notes
          ? _self.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$ClientRating {
  int get stars; // 1-5
  String? get feedback;
  List<String>? get tags;
  DateTime? get timestamp;

  /// Create a copy of ClientRating
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ClientRatingCopyWith<ClientRating> get copyWith =>
      _$ClientRatingCopyWithImpl<ClientRating>(
          this as ClientRating, _$identity);

  /// Serializes this ClientRating to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ClientRating &&
            (identical(other.stars, stars) || other.stars == stars) &&
            (identical(other.feedback, feedback) ||
                other.feedback == feedback) &&
            const DeepCollectionEquality().equals(other.tags, tags) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, stars, feedback,
      const DeepCollectionEquality().hash(tags), timestamp);

  @override
  String toString() {
    return 'ClientRating(stars: $stars, feedback: $feedback, tags: $tags, timestamp: $timestamp)';
  }
}

/// @nodoc
abstract mixin class $ClientRatingCopyWith<$Res> {
  factory $ClientRatingCopyWith(
          ClientRating value, $Res Function(ClientRating) _then) =
      _$ClientRatingCopyWithImpl;
  @useResult
  $Res call(
      {int stars, String? feedback, List<String>? tags, DateTime? timestamp});
}

/// @nodoc
class _$ClientRatingCopyWithImpl<$Res> implements $ClientRatingCopyWith<$Res> {
  _$ClientRatingCopyWithImpl(this._self, this._then);

  final ClientRating _self;
  final $Res Function(ClientRating) _then;

  /// Create a copy of ClientRating
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stars = null,
    Object? feedback = freezed,
    Object? tags = freezed,
    Object? timestamp = freezed,
  }) {
    return _then(_self.copyWith(
      stars: null == stars
          ? _self.stars
          : stars // ignore: cast_nullable_to_non_nullable
              as int,
      feedback: freezed == feedback
          ? _self.feedback
          : feedback // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: freezed == tags
          ? _self.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      timestamp: freezed == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// Adds pattern-matching-related methods to [ClientRating].
extension ClientRatingPatterns on ClientRating {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_ClientRating value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ClientRating() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_ClientRating value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ClientRating():
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_ClientRating value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ClientRating() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(int stars, String? feedback, List<String>? tags,
            DateTime? timestamp)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ClientRating() when $default != null:
        return $default(
            _that.stars, _that.feedback, _that.tags, _that.timestamp);
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(int stars, String? feedback, List<String>? tags,
            DateTime? timestamp)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ClientRating():
        return $default(
            _that.stars, _that.feedback, _that.tags, _that.timestamp);
      case _:
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(int stars, String? feedback, List<String>? tags,
            DateTime? timestamp)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ClientRating() when $default != null:
        return $default(
            _that.stars, _that.feedback, _that.tags, _that.timestamp);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ClientRating implements ClientRating {
  const _ClientRating(
      {required this.stars,
      this.feedback,
      final List<String>? tags,
      this.timestamp})
      : _tags = tags;
  factory _ClientRating.fromJson(Map<String, dynamic> json) =>
      _$ClientRatingFromJson(json);

  @override
  final int stars;
// 1-5
  @override
  final String? feedback;
  final List<String>? _tags;
  @override
  List<String>? get tags {
    final value = _tags;
    if (value == null) return null;
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final DateTime? timestamp;

  /// Create a copy of ClientRating
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ClientRatingCopyWith<_ClientRating> get copyWith =>
      __$ClientRatingCopyWithImpl<_ClientRating>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ClientRatingToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ClientRating &&
            (identical(other.stars, stars) || other.stars == stars) &&
            (identical(other.feedback, feedback) ||
                other.feedback == feedback) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, stars, feedback,
      const DeepCollectionEquality().hash(_tags), timestamp);

  @override
  String toString() {
    return 'ClientRating(stars: $stars, feedback: $feedback, tags: $tags, timestamp: $timestamp)';
  }
}

/// @nodoc
abstract mixin class _$ClientRatingCopyWith<$Res>
    implements $ClientRatingCopyWith<$Res> {
  factory _$ClientRatingCopyWith(
          _ClientRating value, $Res Function(_ClientRating) _then) =
      __$ClientRatingCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int stars, String? feedback, List<String>? tags, DateTime? timestamp});
}

/// @nodoc
class __$ClientRatingCopyWithImpl<$Res>
    implements _$ClientRatingCopyWith<$Res> {
  __$ClientRatingCopyWithImpl(this._self, this._then);

  final _ClientRating _self;
  final $Res Function(_ClientRating) _then;

  /// Create a copy of ClientRating
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? stars = null,
    Object? feedback = freezed,
    Object? tags = freezed,
    Object? timestamp = freezed,
  }) {
    return _then(_ClientRating(
      stars: null == stars
          ? _self.stars
          : stars // ignore: cast_nullable_to_non_nullable
              as int,
      feedback: freezed == feedback
          ? _self.feedback
          : feedback // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: freezed == tags
          ? _self._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      timestamp: freezed == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
mixin _$IncidentReport {
  String get id;
  String get appointmentId;
  String get reportedBy;
  String get reporterType;
  String get severity; // 'low', 'medium', 'high', 'critical'
  String get category; // 'safety', 'quality', 'behavior', 'equipment', 'other'
  String get description;
  List<String>? get photos;
  DateTime get timestamp;
  String get status;
  String? get resolution;
  DateTime? get resolvedAt;

  /// Create a copy of IncidentReport
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $IncidentReportCopyWith<IncidentReport> get copyWith =>
      _$IncidentReportCopyWithImpl<IncidentReport>(
          this as IncidentReport, _$identity);

  /// Serializes this IncidentReport to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is IncidentReport &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.appointmentId, appointmentId) ||
                other.appointmentId == appointmentId) &&
            (identical(other.reportedBy, reportedBy) ||
                other.reportedBy == reportedBy) &&
            (identical(other.reporterType, reporterType) ||
                other.reporterType == reporterType) &&
            (identical(other.severity, severity) ||
                other.severity == severity) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other.photos, photos) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.resolution, resolution) ||
                other.resolution == resolution) &&
            (identical(other.resolvedAt, resolvedAt) ||
                other.resolvedAt == resolvedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      appointmentId,
      reportedBy,
      reporterType,
      severity,
      category,
      description,
      const DeepCollectionEquality().hash(photos),
      timestamp,
      status,
      resolution,
      resolvedAt);

  @override
  String toString() {
    return 'IncidentReport(id: $id, appointmentId: $appointmentId, reportedBy: $reportedBy, reporterType: $reporterType, severity: $severity, category: $category, description: $description, photos: $photos, timestamp: $timestamp, status: $status, resolution: $resolution, resolvedAt: $resolvedAt)';
  }
}

/// @nodoc
abstract mixin class $IncidentReportCopyWith<$Res> {
  factory $IncidentReportCopyWith(
          IncidentReport value, $Res Function(IncidentReport) _then) =
      _$IncidentReportCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String appointmentId,
      String reportedBy,
      String reporterType,
      String severity,
      String category,
      String description,
      List<String>? photos,
      DateTime timestamp,
      String status,
      String? resolution,
      DateTime? resolvedAt});
}

/// @nodoc
class _$IncidentReportCopyWithImpl<$Res>
    implements $IncidentReportCopyWith<$Res> {
  _$IncidentReportCopyWithImpl(this._self, this._then);

  final IncidentReport _self;
  final $Res Function(IncidentReport) _then;

  /// Create a copy of IncidentReport
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? appointmentId = null,
    Object? reportedBy = null,
    Object? reporterType = null,
    Object? severity = null,
    Object? category = null,
    Object? description = null,
    Object? photos = freezed,
    Object? timestamp = null,
    Object? status = null,
    Object? resolution = freezed,
    Object? resolvedAt = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      appointmentId: null == appointmentId
          ? _self.appointmentId
          : appointmentId // ignore: cast_nullable_to_non_nullable
              as String,
      reportedBy: null == reportedBy
          ? _self.reportedBy
          : reportedBy // ignore: cast_nullable_to_non_nullable
              as String,
      reporterType: null == reporterType
          ? _self.reporterType
          : reporterType // ignore: cast_nullable_to_non_nullable
              as String,
      severity: null == severity
          ? _self.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      photos: freezed == photos
          ? _self.photos
          : photos // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      timestamp: null == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      resolution: freezed == resolution
          ? _self.resolution
          : resolution // ignore: cast_nullable_to_non_nullable
              as String?,
      resolvedAt: freezed == resolvedAt
          ? _self.resolvedAt
          : resolvedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// Adds pattern-matching-related methods to [IncidentReport].
extension IncidentReportPatterns on IncidentReport {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_IncidentReport value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _IncidentReport() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_IncidentReport value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _IncidentReport():
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_IncidentReport value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _IncidentReport() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String id,
            String appointmentId,
            String reportedBy,
            String reporterType,
            String severity,
            String category,
            String description,
            List<String>? photos,
            DateTime timestamp,
            String status,
            String? resolution,
            DateTime? resolvedAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _IncidentReport() when $default != null:
        return $default(
            _that.id,
            _that.appointmentId,
            _that.reportedBy,
            _that.reporterType,
            _that.severity,
            _that.category,
            _that.description,
            _that.photos,
            _that.timestamp,
            _that.status,
            _that.resolution,
            _that.resolvedAt);
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String id,
            String appointmentId,
            String reportedBy,
            String reporterType,
            String severity,
            String category,
            String description,
            List<String>? photos,
            DateTime timestamp,
            String status,
            String? resolution,
            DateTime? resolvedAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _IncidentReport():
        return $default(
            _that.id,
            _that.appointmentId,
            _that.reportedBy,
            _that.reporterType,
            _that.severity,
            _that.category,
            _that.description,
            _that.photos,
            _that.timestamp,
            _that.status,
            _that.resolution,
            _that.resolvedAt);
      case _:
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String id,
            String appointmentId,
            String reportedBy,
            String reporterType,
            String severity,
            String category,
            String description,
            List<String>? photos,
            DateTime timestamp,
            String status,
            String? resolution,
            DateTime? resolvedAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _IncidentReport() when $default != null:
        return $default(
            _that.id,
            _that.appointmentId,
            _that.reportedBy,
            _that.reporterType,
            _that.severity,
            _that.category,
            _that.description,
            _that.photos,
            _that.timestamp,
            _that.status,
            _that.resolution,
            _that.resolvedAt);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _IncidentReport implements IncidentReport {
  const _IncidentReport(
      {required this.id,
      required this.appointmentId,
      required this.reportedBy,
      required this.reporterType,
      required this.severity,
      required this.category,
      required this.description,
      final List<String>? photos,
      required this.timestamp,
      required this.status,
      this.resolution,
      this.resolvedAt})
      : _photos = photos;
  factory _IncidentReport.fromJson(Map<String, dynamic> json) =>
      _$IncidentReportFromJson(json);

  @override
  final String id;
  @override
  final String appointmentId;
  @override
  final String reportedBy;
  @override
  final String reporterType;
  @override
  final String severity;
// 'low', 'medium', 'high', 'critical'
  @override
  final String category;
// 'safety', 'quality', 'behavior', 'equipment', 'other'
  @override
  final String description;
  final List<String>? _photos;
  @override
  List<String>? get photos {
    final value = _photos;
    if (value == null) return null;
    if (_photos is EqualUnmodifiableListView) return _photos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final DateTime timestamp;
  @override
  final String status;
  @override
  final String? resolution;
  @override
  final DateTime? resolvedAt;

  /// Create a copy of IncidentReport
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$IncidentReportCopyWith<_IncidentReport> get copyWith =>
      __$IncidentReportCopyWithImpl<_IncidentReport>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$IncidentReportToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _IncidentReport &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.appointmentId, appointmentId) ||
                other.appointmentId == appointmentId) &&
            (identical(other.reportedBy, reportedBy) ||
                other.reportedBy == reportedBy) &&
            (identical(other.reporterType, reporterType) ||
                other.reporterType == reporterType) &&
            (identical(other.severity, severity) ||
                other.severity == severity) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._photos, _photos) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.resolution, resolution) ||
                other.resolution == resolution) &&
            (identical(other.resolvedAt, resolvedAt) ||
                other.resolvedAt == resolvedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      appointmentId,
      reportedBy,
      reporterType,
      severity,
      category,
      description,
      const DeepCollectionEquality().hash(_photos),
      timestamp,
      status,
      resolution,
      resolvedAt);

  @override
  String toString() {
    return 'IncidentReport(id: $id, appointmentId: $appointmentId, reportedBy: $reportedBy, reporterType: $reporterType, severity: $severity, category: $category, description: $description, photos: $photos, timestamp: $timestamp, status: $status, resolution: $resolution, resolvedAt: $resolvedAt)';
  }
}

/// @nodoc
abstract mixin class _$IncidentReportCopyWith<$Res>
    implements $IncidentReportCopyWith<$Res> {
  factory _$IncidentReportCopyWith(
          _IncidentReport value, $Res Function(_IncidentReport) _then) =
      __$IncidentReportCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String appointmentId,
      String reportedBy,
      String reporterType,
      String severity,
      String category,
      String description,
      List<String>? photos,
      DateTime timestamp,
      String status,
      String? resolution,
      DateTime? resolvedAt});
}

/// @nodoc
class __$IncidentReportCopyWithImpl<$Res>
    implements _$IncidentReportCopyWith<$Res> {
  __$IncidentReportCopyWithImpl(this._self, this._then);

  final _IncidentReport _self;
  final $Res Function(_IncidentReport) _then;

  /// Create a copy of IncidentReport
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? appointmentId = null,
    Object? reportedBy = null,
    Object? reporterType = null,
    Object? severity = null,
    Object? category = null,
    Object? description = null,
    Object? photos = freezed,
    Object? timestamp = null,
    Object? status = null,
    Object? resolution = freezed,
    Object? resolvedAt = freezed,
  }) {
    return _then(_IncidentReport(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      appointmentId: null == appointmentId
          ? _self.appointmentId
          : appointmentId // ignore: cast_nullable_to_non_nullable
              as String,
      reportedBy: null == reportedBy
          ? _self.reportedBy
          : reportedBy // ignore: cast_nullable_to_non_nullable
              as String,
      reporterType: null == reporterType
          ? _self.reporterType
          : reporterType // ignore: cast_nullable_to_non_nullable
              as String,
      severity: null == severity
          ? _self.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      photos: freezed == photos
          ? _self._photos
          : photos // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      timestamp: null == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      resolution: freezed == resolution
          ? _self.resolution
          : resolution // ignore: cast_nullable_to_non_nullable
              as String?,
      resolvedAt: freezed == resolvedAt
          ? _self.resolvedAt
          : resolvedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
mixin _$ServiceReport {
  String get appointmentId;
  String get reportUrl;
  DateTime get generatedAt;
  String? get pdfPath;

  /// Create a copy of ServiceReport
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ServiceReportCopyWith<ServiceReport> get copyWith =>
      _$ServiceReportCopyWithImpl<ServiceReport>(
          this as ServiceReport, _$identity);

  /// Serializes this ServiceReport to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ServiceReport &&
            (identical(other.appointmentId, appointmentId) ||
                other.appointmentId == appointmentId) &&
            (identical(other.reportUrl, reportUrl) ||
                other.reportUrl == reportUrl) &&
            (identical(other.generatedAt, generatedAt) ||
                other.generatedAt == generatedAt) &&
            (identical(other.pdfPath, pdfPath) || other.pdfPath == pdfPath));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, appointmentId, reportUrl, generatedAt, pdfPath);

  @override
  String toString() {
    return 'ServiceReport(appointmentId: $appointmentId, reportUrl: $reportUrl, generatedAt: $generatedAt, pdfPath: $pdfPath)';
  }
}

/// @nodoc
abstract mixin class $ServiceReportCopyWith<$Res> {
  factory $ServiceReportCopyWith(
          ServiceReport value, $Res Function(ServiceReport) _then) =
      _$ServiceReportCopyWithImpl;
  @useResult
  $Res call(
      {String appointmentId,
      String reportUrl,
      DateTime generatedAt,
      String? pdfPath});
}

/// @nodoc
class _$ServiceReportCopyWithImpl<$Res>
    implements $ServiceReportCopyWith<$Res> {
  _$ServiceReportCopyWithImpl(this._self, this._then);

  final ServiceReport _self;
  final $Res Function(ServiceReport) _then;

  /// Create a copy of ServiceReport
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appointmentId = null,
    Object? reportUrl = null,
    Object? generatedAt = null,
    Object? pdfPath = freezed,
  }) {
    return _then(_self.copyWith(
      appointmentId: null == appointmentId
          ? _self.appointmentId
          : appointmentId // ignore: cast_nullable_to_non_nullable
              as String,
      reportUrl: null == reportUrl
          ? _self.reportUrl
          : reportUrl // ignore: cast_nullable_to_non_nullable
              as String,
      generatedAt: null == generatedAt
          ? _self.generatedAt
          : generatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      pdfPath: freezed == pdfPath
          ? _self.pdfPath
          : pdfPath // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [ServiceReport].
extension ServiceReportPatterns on ServiceReport {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_ServiceReport value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ServiceReport() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_ServiceReport value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ServiceReport():
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_ServiceReport value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ServiceReport() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String appointmentId, String reportUrl,
            DateTime generatedAt, String? pdfPath)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ServiceReport() when $default != null:
        return $default(_that.appointmentId, _that.reportUrl, _that.generatedAt,
            _that.pdfPath);
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String appointmentId, String reportUrl,
            DateTime generatedAt, String? pdfPath)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ServiceReport():
        return $default(_that.appointmentId, _that.reportUrl, _that.generatedAt,
            _that.pdfPath);
      case _:
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String appointmentId, String reportUrl,
            DateTime generatedAt, String? pdfPath)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ServiceReport() when $default != null:
        return $default(_that.appointmentId, _that.reportUrl, _that.generatedAt,
            _that.pdfPath);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ServiceReport implements ServiceReport {
  const _ServiceReport(
      {required this.appointmentId,
      required this.reportUrl,
      required this.generatedAt,
      this.pdfPath});
  factory _ServiceReport.fromJson(Map<String, dynamic> json) =>
      _$ServiceReportFromJson(json);

  @override
  final String appointmentId;
  @override
  final String reportUrl;
  @override
  final DateTime generatedAt;
  @override
  final String? pdfPath;

  /// Create a copy of ServiceReport
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ServiceReportCopyWith<_ServiceReport> get copyWith =>
      __$ServiceReportCopyWithImpl<_ServiceReport>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ServiceReportToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ServiceReport &&
            (identical(other.appointmentId, appointmentId) ||
                other.appointmentId == appointmentId) &&
            (identical(other.reportUrl, reportUrl) ||
                other.reportUrl == reportUrl) &&
            (identical(other.generatedAt, generatedAt) ||
                other.generatedAt == generatedAt) &&
            (identical(other.pdfPath, pdfPath) || other.pdfPath == pdfPath));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, appointmentId, reportUrl, generatedAt, pdfPath);

  @override
  String toString() {
    return 'ServiceReport(appointmentId: $appointmentId, reportUrl: $reportUrl, generatedAt: $generatedAt, pdfPath: $pdfPath)';
  }
}

/// @nodoc
abstract mixin class _$ServiceReportCopyWith<$Res>
    implements $ServiceReportCopyWith<$Res> {
  factory _$ServiceReportCopyWith(
          _ServiceReport value, $Res Function(_ServiceReport) _then) =
      __$ServiceReportCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String appointmentId,
      String reportUrl,
      DateTime generatedAt,
      String? pdfPath});
}

/// @nodoc
class __$ServiceReportCopyWithImpl<$Res>
    implements _$ServiceReportCopyWith<$Res> {
  __$ServiceReportCopyWithImpl(this._self, this._then);

  final _ServiceReport _self;
  final $Res Function(_ServiceReport) _then;

  /// Create a copy of ServiceReport
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? appointmentId = null,
    Object? reportUrl = null,
    Object? generatedAt = null,
    Object? pdfPath = freezed,
  }) {
    return _then(_ServiceReport(
      appointmentId: null == appointmentId
          ? _self.appointmentId
          : appointmentId // ignore: cast_nullable_to_non_nullable
              as String,
      reportUrl: null == reportUrl
          ? _self.reportUrl
          : reportUrl // ignore: cast_nullable_to_non_nullable
              as String,
      generatedAt: null == generatedAt
          ? _self.generatedAt
          : generatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      pdfPath: freezed == pdfPath
          ? _self.pdfPath
          : pdfPath // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$FamilyMember {
  String get id;
  String get userId;
  String get clientId;
  String get name;
  String get email;
  String get relationship;
  String get role;
  FamilyPermissions get permissions;
  String get status;
  DateTime get joinedAt;
  NotificationPreferences? get notificationPreferences;
  DateTime? get updatedAt;
  String? get updatedBy;

  /// Create a copy of FamilyMember
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $FamilyMemberCopyWith<FamilyMember> get copyWith =>
      _$FamilyMemberCopyWithImpl<FamilyMember>(
          this as FamilyMember, _$identity);

  /// Serializes this FamilyMember to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is FamilyMember &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.relationship, relationship) ||
                other.relationship == relationship) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.permissions, permissions) ||
                other.permissions == permissions) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.joinedAt, joinedAt) ||
                other.joinedAt == joinedAt) &&
            (identical(
                    other.notificationPreferences, notificationPreferences) ||
                other.notificationPreferences == notificationPreferences) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.updatedBy, updatedBy) ||
                other.updatedBy == updatedBy));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      clientId,
      name,
      email,
      relationship,
      role,
      permissions,
      status,
      joinedAt,
      notificationPreferences,
      updatedAt,
      updatedBy);

  @override
  String toString() {
    return 'FamilyMember(id: $id, userId: $userId, clientId: $clientId, name: $name, email: $email, relationship: $relationship, role: $role, permissions: $permissions, status: $status, joinedAt: $joinedAt, notificationPreferences: $notificationPreferences, updatedAt: $updatedAt, updatedBy: $updatedBy)';
  }
}

/// @nodoc
abstract mixin class $FamilyMemberCopyWith<$Res> {
  factory $FamilyMemberCopyWith(
          FamilyMember value, $Res Function(FamilyMember) _then) =
      _$FamilyMemberCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String userId,
      String clientId,
      String name,
      String email,
      String relationship,
      String role,
      FamilyPermissions permissions,
      String status,
      DateTime joinedAt,
      NotificationPreferences? notificationPreferences,
      DateTime? updatedAt,
      String? updatedBy});

  $FamilyPermissionsCopyWith<$Res> get permissions;
  $NotificationPreferencesCopyWith<$Res>? get notificationPreferences;
}

/// @nodoc
class _$FamilyMemberCopyWithImpl<$Res> implements $FamilyMemberCopyWith<$Res> {
  _$FamilyMemberCopyWithImpl(this._self, this._then);

  final FamilyMember _self;
  final $Res Function(FamilyMember) _then;

  /// Create a copy of FamilyMember
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? clientId = null,
    Object? name = null,
    Object? email = null,
    Object? relationship = null,
    Object? role = null,
    Object? permissions = null,
    Object? status = null,
    Object? joinedAt = null,
    Object? notificationPreferences = freezed,
    Object? updatedAt = freezed,
    Object? updatedBy = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      clientId: null == clientId
          ? _self.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      relationship: null == relationship
          ? _self.relationship
          : relationship // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _self.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      permissions: null == permissions
          ? _self.permissions
          : permissions // ignore: cast_nullable_to_non_nullable
              as FamilyPermissions,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      joinedAt: null == joinedAt
          ? _self.joinedAt
          : joinedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      notificationPreferences: freezed == notificationPreferences
          ? _self.notificationPreferences
          : notificationPreferences // ignore: cast_nullable_to_non_nullable
              as NotificationPreferences?,
      updatedAt: freezed == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedBy: freezed == updatedBy
          ? _self.updatedBy
          : updatedBy // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of FamilyMember
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FamilyPermissionsCopyWith<$Res> get permissions {
    return $FamilyPermissionsCopyWith<$Res>(_self.permissions, (value) {
      return _then(_self.copyWith(permissions: value));
    });
  }

  /// Create a copy of FamilyMember
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NotificationPreferencesCopyWith<$Res>? get notificationPreferences {
    if (_self.notificationPreferences == null) {
      return null;
    }

    return $NotificationPreferencesCopyWith<$Res>(
        _self.notificationPreferences!, (value) {
      return _then(_self.copyWith(notificationPreferences: value));
    });
  }
}

/// Adds pattern-matching-related methods to [FamilyMember].
extension FamilyMemberPatterns on FamilyMember {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_FamilyMember value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _FamilyMember() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_FamilyMember value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FamilyMember():
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_FamilyMember value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FamilyMember() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String id,
            String userId,
            String clientId,
            String name,
            String email,
            String relationship,
            String role,
            FamilyPermissions permissions,
            String status,
            DateTime joinedAt,
            NotificationPreferences? notificationPreferences,
            DateTime? updatedAt,
            String? updatedBy)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _FamilyMember() when $default != null:
        return $default(
            _that.id,
            _that.userId,
            _that.clientId,
            _that.name,
            _that.email,
            _that.relationship,
            _that.role,
            _that.permissions,
            _that.status,
            _that.joinedAt,
            _that.notificationPreferences,
            _that.updatedAt,
            _that.updatedBy);
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String id,
            String userId,
            String clientId,
            String name,
            String email,
            String relationship,
            String role,
            FamilyPermissions permissions,
            String status,
            DateTime joinedAt,
            NotificationPreferences? notificationPreferences,
            DateTime? updatedAt,
            String? updatedBy)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FamilyMember():
        return $default(
            _that.id,
            _that.userId,
            _that.clientId,
            _that.name,
            _that.email,
            _that.relationship,
            _that.role,
            _that.permissions,
            _that.status,
            _that.joinedAt,
            _that.notificationPreferences,
            _that.updatedAt,
            _that.updatedBy);
      case _:
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String id,
            String userId,
            String clientId,
            String name,
            String email,
            String relationship,
            String role,
            FamilyPermissions permissions,
            String status,
            DateTime joinedAt,
            NotificationPreferences? notificationPreferences,
            DateTime? updatedAt,
            String? updatedBy)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FamilyMember() when $default != null:
        return $default(
            _that.id,
            _that.userId,
            _that.clientId,
            _that.name,
            _that.email,
            _that.relationship,
            _that.role,
            _that.permissions,
            _that.status,
            _that.joinedAt,
            _that.notificationPreferences,
            _that.updatedAt,
            _that.updatedBy);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _FamilyMember implements FamilyMember {
  const _FamilyMember(
      {required this.id,
      required this.userId,
      required this.clientId,
      required this.name,
      required this.email,
      required this.relationship,
      required this.role,
      required this.permissions,
      required this.status,
      required this.joinedAt,
      this.notificationPreferences,
      this.updatedAt,
      this.updatedBy});
  factory _FamilyMember.fromJson(Map<String, dynamic> json) =>
      _$FamilyMemberFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String clientId;
  @override
  final String name;
  @override
  final String email;
  @override
  final String relationship;
  @override
  final String role;
  @override
  final FamilyPermissions permissions;
  @override
  final String status;
  @override
  final DateTime joinedAt;
  @override
  final NotificationPreferences? notificationPreferences;
  @override
  final DateTime? updatedAt;
  @override
  final String? updatedBy;

  /// Create a copy of FamilyMember
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$FamilyMemberCopyWith<_FamilyMember> get copyWith =>
      __$FamilyMemberCopyWithImpl<_FamilyMember>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$FamilyMemberToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _FamilyMember &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.relationship, relationship) ||
                other.relationship == relationship) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.permissions, permissions) ||
                other.permissions == permissions) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.joinedAt, joinedAt) ||
                other.joinedAt == joinedAt) &&
            (identical(
                    other.notificationPreferences, notificationPreferences) ||
                other.notificationPreferences == notificationPreferences) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.updatedBy, updatedBy) ||
                other.updatedBy == updatedBy));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      clientId,
      name,
      email,
      relationship,
      role,
      permissions,
      status,
      joinedAt,
      notificationPreferences,
      updatedAt,
      updatedBy);

  @override
  String toString() {
    return 'FamilyMember(id: $id, userId: $userId, clientId: $clientId, name: $name, email: $email, relationship: $relationship, role: $role, permissions: $permissions, status: $status, joinedAt: $joinedAt, notificationPreferences: $notificationPreferences, updatedAt: $updatedAt, updatedBy: $updatedBy)';
  }
}

/// @nodoc
abstract mixin class _$FamilyMemberCopyWith<$Res>
    implements $FamilyMemberCopyWith<$Res> {
  factory _$FamilyMemberCopyWith(
          _FamilyMember value, $Res Function(_FamilyMember) _then) =
      __$FamilyMemberCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String clientId,
      String name,
      String email,
      String relationship,
      String role,
      FamilyPermissions permissions,
      String status,
      DateTime joinedAt,
      NotificationPreferences? notificationPreferences,
      DateTime? updatedAt,
      String? updatedBy});

  @override
  $FamilyPermissionsCopyWith<$Res> get permissions;
  @override
  $NotificationPreferencesCopyWith<$Res>? get notificationPreferences;
}

/// @nodoc
class __$FamilyMemberCopyWithImpl<$Res>
    implements _$FamilyMemberCopyWith<$Res> {
  __$FamilyMemberCopyWithImpl(this._self, this._then);

  final _FamilyMember _self;
  final $Res Function(_FamilyMember) _then;

  /// Create a copy of FamilyMember
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? clientId = null,
    Object? name = null,
    Object? email = null,
    Object? relationship = null,
    Object? role = null,
    Object? permissions = null,
    Object? status = null,
    Object? joinedAt = null,
    Object? notificationPreferences = freezed,
    Object? updatedAt = freezed,
    Object? updatedBy = freezed,
  }) {
    return _then(_FamilyMember(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      clientId: null == clientId
          ? _self.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      relationship: null == relationship
          ? _self.relationship
          : relationship // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _self.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      permissions: null == permissions
          ? _self.permissions
          : permissions // ignore: cast_nullable_to_non_nullable
              as FamilyPermissions,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      joinedAt: null == joinedAt
          ? _self.joinedAt
          : joinedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      notificationPreferences: freezed == notificationPreferences
          ? _self.notificationPreferences
          : notificationPreferences // ignore: cast_nullable_to_non_nullable
              as NotificationPreferences?,
      updatedAt: freezed == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedBy: freezed == updatedBy
          ? _self.updatedBy
          : updatedBy // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of FamilyMember
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FamilyPermissionsCopyWith<$Res> get permissions {
    return $FamilyPermissionsCopyWith<$Res>(_self.permissions, (value) {
      return _then(_self.copyWith(permissions: value));
    });
  }

  /// Create a copy of FamilyMember
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NotificationPreferencesCopyWith<$Res>? get notificationPreferences {
    if (_self.notificationPreferences == null) {
      return null;
    }

    return $NotificationPreferencesCopyWith<$Res>(
        _self.notificationPreferences!, (value) {
      return _then(_self.copyWith(notificationPreferences: value));
    });
  }
}

/// @nodoc
mixin _$FamilyPermissions {
  bool get viewAppointments;
  bool get viewDocuments;
  bool get viewInvoices;
  bool get editProfile;
  bool get approveServices;
  bool get manageFamily;
  bool get viewMessages;
  bool get sendMessages;
  bool get viewLocation;
  bool get receiveNotifications;

  /// Create a copy of FamilyPermissions
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $FamilyPermissionsCopyWith<FamilyPermissions> get copyWith =>
      _$FamilyPermissionsCopyWithImpl<FamilyPermissions>(
          this as FamilyPermissions, _$identity);

  /// Serializes this FamilyPermissions to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is FamilyPermissions &&
            (identical(other.viewAppointments, viewAppointments) ||
                other.viewAppointments == viewAppointments) &&
            (identical(other.viewDocuments, viewDocuments) ||
                other.viewDocuments == viewDocuments) &&
            (identical(other.viewInvoices, viewInvoices) ||
                other.viewInvoices == viewInvoices) &&
            (identical(other.editProfile, editProfile) ||
                other.editProfile == editProfile) &&
            (identical(other.approveServices, approveServices) ||
                other.approveServices == approveServices) &&
            (identical(other.manageFamily, manageFamily) ||
                other.manageFamily == manageFamily) &&
            (identical(other.viewMessages, viewMessages) ||
                other.viewMessages == viewMessages) &&
            (identical(other.sendMessages, sendMessages) ||
                other.sendMessages == sendMessages) &&
            (identical(other.viewLocation, viewLocation) ||
                other.viewLocation == viewLocation) &&
            (identical(other.receiveNotifications, receiveNotifications) ||
                other.receiveNotifications == receiveNotifications));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      viewAppointments,
      viewDocuments,
      viewInvoices,
      editProfile,
      approveServices,
      manageFamily,
      viewMessages,
      sendMessages,
      viewLocation,
      receiveNotifications);

  @override
  String toString() {
    return 'FamilyPermissions(viewAppointments: $viewAppointments, viewDocuments: $viewDocuments, viewInvoices: $viewInvoices, editProfile: $editProfile, approveServices: $approveServices, manageFamily: $manageFamily, viewMessages: $viewMessages, sendMessages: $sendMessages, viewLocation: $viewLocation, receiveNotifications: $receiveNotifications)';
  }
}

/// @nodoc
abstract mixin class $FamilyPermissionsCopyWith<$Res> {
  factory $FamilyPermissionsCopyWith(
          FamilyPermissions value, $Res Function(FamilyPermissions) _then) =
      _$FamilyPermissionsCopyWithImpl;
  @useResult
  $Res call(
      {bool viewAppointments,
      bool viewDocuments,
      bool viewInvoices,
      bool editProfile,
      bool approveServices,
      bool manageFamily,
      bool viewMessages,
      bool sendMessages,
      bool viewLocation,
      bool receiveNotifications});
}

/// @nodoc
class _$FamilyPermissionsCopyWithImpl<$Res>
    implements $FamilyPermissionsCopyWith<$Res> {
  _$FamilyPermissionsCopyWithImpl(this._self, this._then);

  final FamilyPermissions _self;
  final $Res Function(FamilyPermissions) _then;

  /// Create a copy of FamilyPermissions
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? viewAppointments = null,
    Object? viewDocuments = null,
    Object? viewInvoices = null,
    Object? editProfile = null,
    Object? approveServices = null,
    Object? manageFamily = null,
    Object? viewMessages = null,
    Object? sendMessages = null,
    Object? viewLocation = null,
    Object? receiveNotifications = null,
  }) {
    return _then(_self.copyWith(
      viewAppointments: null == viewAppointments
          ? _self.viewAppointments
          : viewAppointments // ignore: cast_nullable_to_non_nullable
              as bool,
      viewDocuments: null == viewDocuments
          ? _self.viewDocuments
          : viewDocuments // ignore: cast_nullable_to_non_nullable
              as bool,
      viewInvoices: null == viewInvoices
          ? _self.viewInvoices
          : viewInvoices // ignore: cast_nullable_to_non_nullable
              as bool,
      editProfile: null == editProfile
          ? _self.editProfile
          : editProfile // ignore: cast_nullable_to_non_nullable
              as bool,
      approveServices: null == approveServices
          ? _self.approveServices
          : approveServices // ignore: cast_nullable_to_non_nullable
              as bool,
      manageFamily: null == manageFamily
          ? _self.manageFamily
          : manageFamily // ignore: cast_nullable_to_non_nullable
              as bool,
      viewMessages: null == viewMessages
          ? _self.viewMessages
          : viewMessages // ignore: cast_nullable_to_non_nullable
              as bool,
      sendMessages: null == sendMessages
          ? _self.sendMessages
          : sendMessages // ignore: cast_nullable_to_non_nullable
              as bool,
      viewLocation: null == viewLocation
          ? _self.viewLocation
          : viewLocation // ignore: cast_nullable_to_non_nullable
              as bool,
      receiveNotifications: null == receiveNotifications
          ? _self.receiveNotifications
          : receiveNotifications // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [FamilyPermissions].
extension FamilyPermissionsPatterns on FamilyPermissions {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_FamilyPermissions value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _FamilyPermissions() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_FamilyPermissions value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FamilyPermissions():
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_FamilyPermissions value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FamilyPermissions() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            bool viewAppointments,
            bool viewDocuments,
            bool viewInvoices,
            bool editProfile,
            bool approveServices,
            bool manageFamily,
            bool viewMessages,
            bool sendMessages,
            bool viewLocation,
            bool receiveNotifications)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _FamilyPermissions() when $default != null:
        return $default(
            _that.viewAppointments,
            _that.viewDocuments,
            _that.viewInvoices,
            _that.editProfile,
            _that.approveServices,
            _that.manageFamily,
            _that.viewMessages,
            _that.sendMessages,
            _that.viewLocation,
            _that.receiveNotifications);
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            bool viewAppointments,
            bool viewDocuments,
            bool viewInvoices,
            bool editProfile,
            bool approveServices,
            bool manageFamily,
            bool viewMessages,
            bool sendMessages,
            bool viewLocation,
            bool receiveNotifications)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FamilyPermissions():
        return $default(
            _that.viewAppointments,
            _that.viewDocuments,
            _that.viewInvoices,
            _that.editProfile,
            _that.approveServices,
            _that.manageFamily,
            _that.viewMessages,
            _that.sendMessages,
            _that.viewLocation,
            _that.receiveNotifications);
      case _:
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            bool viewAppointments,
            bool viewDocuments,
            bool viewInvoices,
            bool editProfile,
            bool approveServices,
            bool manageFamily,
            bool viewMessages,
            bool sendMessages,
            bool viewLocation,
            bool receiveNotifications)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FamilyPermissions() when $default != null:
        return $default(
            _that.viewAppointments,
            _that.viewDocuments,
            _that.viewInvoices,
            _that.editProfile,
            _that.approveServices,
            _that.manageFamily,
            _that.viewMessages,
            _that.sendMessages,
            _that.viewLocation,
            _that.receiveNotifications);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _FamilyPermissions implements FamilyPermissions {
  const _FamilyPermissions(
      {required this.viewAppointments,
      required this.viewDocuments,
      required this.viewInvoices,
      required this.editProfile,
      required this.approveServices,
      required this.manageFamily,
      required this.viewMessages,
      required this.sendMessages,
      required this.viewLocation,
      required this.receiveNotifications});
  factory _FamilyPermissions.fromJson(Map<String, dynamic> json) =>
      _$FamilyPermissionsFromJson(json);

  @override
  final bool viewAppointments;
  @override
  final bool viewDocuments;
  @override
  final bool viewInvoices;
  @override
  final bool editProfile;
  @override
  final bool approveServices;
  @override
  final bool manageFamily;
  @override
  final bool viewMessages;
  @override
  final bool sendMessages;
  @override
  final bool viewLocation;
  @override
  final bool receiveNotifications;

  /// Create a copy of FamilyPermissions
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$FamilyPermissionsCopyWith<_FamilyPermissions> get copyWith =>
      __$FamilyPermissionsCopyWithImpl<_FamilyPermissions>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$FamilyPermissionsToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _FamilyPermissions &&
            (identical(other.viewAppointments, viewAppointments) ||
                other.viewAppointments == viewAppointments) &&
            (identical(other.viewDocuments, viewDocuments) ||
                other.viewDocuments == viewDocuments) &&
            (identical(other.viewInvoices, viewInvoices) ||
                other.viewInvoices == viewInvoices) &&
            (identical(other.editProfile, editProfile) ||
                other.editProfile == editProfile) &&
            (identical(other.approveServices, approveServices) ||
                other.approveServices == approveServices) &&
            (identical(other.manageFamily, manageFamily) ||
                other.manageFamily == manageFamily) &&
            (identical(other.viewMessages, viewMessages) ||
                other.viewMessages == viewMessages) &&
            (identical(other.sendMessages, sendMessages) ||
                other.sendMessages == sendMessages) &&
            (identical(other.viewLocation, viewLocation) ||
                other.viewLocation == viewLocation) &&
            (identical(other.receiveNotifications, receiveNotifications) ||
                other.receiveNotifications == receiveNotifications));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      viewAppointments,
      viewDocuments,
      viewInvoices,
      editProfile,
      approveServices,
      manageFamily,
      viewMessages,
      sendMessages,
      viewLocation,
      receiveNotifications);

  @override
  String toString() {
    return 'FamilyPermissions(viewAppointments: $viewAppointments, viewDocuments: $viewDocuments, viewInvoices: $viewInvoices, editProfile: $editProfile, approveServices: $approveServices, manageFamily: $manageFamily, viewMessages: $viewMessages, sendMessages: $sendMessages, viewLocation: $viewLocation, receiveNotifications: $receiveNotifications)';
  }
}

/// @nodoc
abstract mixin class _$FamilyPermissionsCopyWith<$Res>
    implements $FamilyPermissionsCopyWith<$Res> {
  factory _$FamilyPermissionsCopyWith(
          _FamilyPermissions value, $Res Function(_FamilyPermissions) _then) =
      __$FamilyPermissionsCopyWithImpl;
  @override
  @useResult
  $Res call(
      {bool viewAppointments,
      bool viewDocuments,
      bool viewInvoices,
      bool editProfile,
      bool approveServices,
      bool manageFamily,
      bool viewMessages,
      bool sendMessages,
      bool viewLocation,
      bool receiveNotifications});
}

/// @nodoc
class __$FamilyPermissionsCopyWithImpl<$Res>
    implements _$FamilyPermissionsCopyWith<$Res> {
  __$FamilyPermissionsCopyWithImpl(this._self, this._then);

  final _FamilyPermissions _self;
  final $Res Function(_FamilyPermissions) _then;

  /// Create a copy of FamilyPermissions
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? viewAppointments = null,
    Object? viewDocuments = null,
    Object? viewInvoices = null,
    Object? editProfile = null,
    Object? approveServices = null,
    Object? manageFamily = null,
    Object? viewMessages = null,
    Object? sendMessages = null,
    Object? viewLocation = null,
    Object? receiveNotifications = null,
  }) {
    return _then(_FamilyPermissions(
      viewAppointments: null == viewAppointments
          ? _self.viewAppointments
          : viewAppointments // ignore: cast_nullable_to_non_nullable
              as bool,
      viewDocuments: null == viewDocuments
          ? _self.viewDocuments
          : viewDocuments // ignore: cast_nullable_to_non_nullable
              as bool,
      viewInvoices: null == viewInvoices
          ? _self.viewInvoices
          : viewInvoices // ignore: cast_nullable_to_non_nullable
              as bool,
      editProfile: null == editProfile
          ? _self.editProfile
          : editProfile // ignore: cast_nullable_to_non_nullable
              as bool,
      approveServices: null == approveServices
          ? _self.approveServices
          : approveServices // ignore: cast_nullable_to_non_nullable
              as bool,
      manageFamily: null == manageFamily
          ? _self.manageFamily
          : manageFamily // ignore: cast_nullable_to_non_nullable
              as bool,
      viewMessages: null == viewMessages
          ? _self.viewMessages
          : viewMessages // ignore: cast_nullable_to_non_nullable
              as bool,
      sendMessages: null == sendMessages
          ? _self.sendMessages
          : sendMessages // ignore: cast_nullable_to_non_nullable
              as bool,
      viewLocation: null == viewLocation
          ? _self.viewLocation
          : viewLocation // ignore: cast_nullable_to_non_nullable
              as bool,
      receiveNotifications: null == receiveNotifications
          ? _self.receiveNotifications
          : receiveNotifications // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
mixin _$FamilyInvitation {
  String get id;
  String get clientId;
  String get invitedBy;
  String get email;
  String get name;
  String get relationship;
  String get role;
  FamilyPermissions get permissions;
  String get status;
  DateTime get invitedAt;
  DateTime get expiresAt;
  String get token;

  /// Create a copy of FamilyInvitation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $FamilyInvitationCopyWith<FamilyInvitation> get copyWith =>
      _$FamilyInvitationCopyWithImpl<FamilyInvitation>(
          this as FamilyInvitation, _$identity);

  /// Serializes this FamilyInvitation to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is FamilyInvitation &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.invitedBy, invitedBy) ||
                other.invitedBy == invitedBy) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.relationship, relationship) ||
                other.relationship == relationship) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.permissions, permissions) ||
                other.permissions == permissions) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.invitedAt, invitedAt) ||
                other.invitedAt == invitedAt) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.token, token) || other.token == token));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      clientId,
      invitedBy,
      email,
      name,
      relationship,
      role,
      permissions,
      status,
      invitedAt,
      expiresAt,
      token);

  @override
  String toString() {
    return 'FamilyInvitation(id: $id, clientId: $clientId, invitedBy: $invitedBy, email: $email, name: $name, relationship: $relationship, role: $role, permissions: $permissions, status: $status, invitedAt: $invitedAt, expiresAt: $expiresAt, token: $token)';
  }
}

/// @nodoc
abstract mixin class $FamilyInvitationCopyWith<$Res> {
  factory $FamilyInvitationCopyWith(
          FamilyInvitation value, $Res Function(FamilyInvitation) _then) =
      _$FamilyInvitationCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String clientId,
      String invitedBy,
      String email,
      String name,
      String relationship,
      String role,
      FamilyPermissions permissions,
      String status,
      DateTime invitedAt,
      DateTime expiresAt,
      String token});

  $FamilyPermissionsCopyWith<$Res> get permissions;
}

/// @nodoc
class _$FamilyInvitationCopyWithImpl<$Res>
    implements $FamilyInvitationCopyWith<$Res> {
  _$FamilyInvitationCopyWithImpl(this._self, this._then);

  final FamilyInvitation _self;
  final $Res Function(FamilyInvitation) _then;

  /// Create a copy of FamilyInvitation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? clientId = null,
    Object? invitedBy = null,
    Object? email = null,
    Object? name = null,
    Object? relationship = null,
    Object? role = null,
    Object? permissions = null,
    Object? status = null,
    Object? invitedAt = null,
    Object? expiresAt = null,
    Object? token = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      clientId: null == clientId
          ? _self.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      invitedBy: null == invitedBy
          ? _self.invitedBy
          : invitedBy // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      relationship: null == relationship
          ? _self.relationship
          : relationship // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _self.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      permissions: null == permissions
          ? _self.permissions
          : permissions // ignore: cast_nullable_to_non_nullable
              as FamilyPermissions,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      invitedAt: null == invitedAt
          ? _self.invitedAt
          : invitedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      expiresAt: null == expiresAt
          ? _self.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      token: null == token
          ? _self.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  /// Create a copy of FamilyInvitation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FamilyPermissionsCopyWith<$Res> get permissions {
    return $FamilyPermissionsCopyWith<$Res>(_self.permissions, (value) {
      return _then(_self.copyWith(permissions: value));
    });
  }
}

/// Adds pattern-matching-related methods to [FamilyInvitation].
extension FamilyInvitationPatterns on FamilyInvitation {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_FamilyInvitation value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _FamilyInvitation() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_FamilyInvitation value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FamilyInvitation():
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_FamilyInvitation value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FamilyInvitation() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String id,
            String clientId,
            String invitedBy,
            String email,
            String name,
            String relationship,
            String role,
            FamilyPermissions permissions,
            String status,
            DateTime invitedAt,
            DateTime expiresAt,
            String token)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _FamilyInvitation() when $default != null:
        return $default(
            _that.id,
            _that.clientId,
            _that.invitedBy,
            _that.email,
            _that.name,
            _that.relationship,
            _that.role,
            _that.permissions,
            _that.status,
            _that.invitedAt,
            _that.expiresAt,
            _that.token);
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String id,
            String clientId,
            String invitedBy,
            String email,
            String name,
            String relationship,
            String role,
            FamilyPermissions permissions,
            String status,
            DateTime invitedAt,
            DateTime expiresAt,
            String token)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FamilyInvitation():
        return $default(
            _that.id,
            _that.clientId,
            _that.invitedBy,
            _that.email,
            _that.name,
            _that.relationship,
            _that.role,
            _that.permissions,
            _that.status,
            _that.invitedAt,
            _that.expiresAt,
            _that.token);
      case _:
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String id,
            String clientId,
            String invitedBy,
            String email,
            String name,
            String relationship,
            String role,
            FamilyPermissions permissions,
            String status,
            DateTime invitedAt,
            DateTime expiresAt,
            String token)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FamilyInvitation() when $default != null:
        return $default(
            _that.id,
            _that.clientId,
            _that.invitedBy,
            _that.email,
            _that.name,
            _that.relationship,
            _that.role,
            _that.permissions,
            _that.status,
            _that.invitedAt,
            _that.expiresAt,
            _that.token);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _FamilyInvitation implements FamilyInvitation {
  const _FamilyInvitation(
      {required this.id,
      required this.clientId,
      required this.invitedBy,
      required this.email,
      required this.name,
      required this.relationship,
      required this.role,
      required this.permissions,
      required this.status,
      required this.invitedAt,
      required this.expiresAt,
      required this.token});
  factory _FamilyInvitation.fromJson(Map<String, dynamic> json) =>
      _$FamilyInvitationFromJson(json);

  @override
  final String id;
  @override
  final String clientId;
  @override
  final String invitedBy;
  @override
  final String email;
  @override
  final String name;
  @override
  final String relationship;
  @override
  final String role;
  @override
  final FamilyPermissions permissions;
  @override
  final String status;
  @override
  final DateTime invitedAt;
  @override
  final DateTime expiresAt;
  @override
  final String token;

  /// Create a copy of FamilyInvitation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$FamilyInvitationCopyWith<_FamilyInvitation> get copyWith =>
      __$FamilyInvitationCopyWithImpl<_FamilyInvitation>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$FamilyInvitationToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _FamilyInvitation &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.invitedBy, invitedBy) ||
                other.invitedBy == invitedBy) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.relationship, relationship) ||
                other.relationship == relationship) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.permissions, permissions) ||
                other.permissions == permissions) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.invitedAt, invitedAt) ||
                other.invitedAt == invitedAt) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.token, token) || other.token == token));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      clientId,
      invitedBy,
      email,
      name,
      relationship,
      role,
      permissions,
      status,
      invitedAt,
      expiresAt,
      token);

  @override
  String toString() {
    return 'FamilyInvitation(id: $id, clientId: $clientId, invitedBy: $invitedBy, email: $email, name: $name, relationship: $relationship, role: $role, permissions: $permissions, status: $status, invitedAt: $invitedAt, expiresAt: $expiresAt, token: $token)';
  }
}

/// @nodoc
abstract mixin class _$FamilyInvitationCopyWith<$Res>
    implements $FamilyInvitationCopyWith<$Res> {
  factory _$FamilyInvitationCopyWith(
          _FamilyInvitation value, $Res Function(_FamilyInvitation) _then) =
      __$FamilyInvitationCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String clientId,
      String invitedBy,
      String email,
      String name,
      String relationship,
      String role,
      FamilyPermissions permissions,
      String status,
      DateTime invitedAt,
      DateTime expiresAt,
      String token});

  @override
  $FamilyPermissionsCopyWith<$Res> get permissions;
}

/// @nodoc
class __$FamilyInvitationCopyWithImpl<$Res>
    implements _$FamilyInvitationCopyWith<$Res> {
  __$FamilyInvitationCopyWithImpl(this._self, this._then);

  final _FamilyInvitation _self;
  final $Res Function(_FamilyInvitation) _then;

  /// Create a copy of FamilyInvitation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? clientId = null,
    Object? invitedBy = null,
    Object? email = null,
    Object? name = null,
    Object? relationship = null,
    Object? role = null,
    Object? permissions = null,
    Object? status = null,
    Object? invitedAt = null,
    Object? expiresAt = null,
    Object? token = null,
  }) {
    return _then(_FamilyInvitation(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      clientId: null == clientId
          ? _self.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      invitedBy: null == invitedBy
          ? _self.invitedBy
          : invitedBy // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      relationship: null == relationship
          ? _self.relationship
          : relationship // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _self.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      permissions: null == permissions
          ? _self.permissions
          : permissions // ignore: cast_nullable_to_non_nullable
              as FamilyPermissions,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      invitedAt: null == invitedAt
          ? _self.invitedAt
          : invitedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      expiresAt: null == expiresAt
          ? _self.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      token: null == token
          ? _self.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  /// Create a copy of FamilyInvitation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FamilyPermissionsCopyWith<$Res> get permissions {
    return $FamilyPermissionsCopyWith<$Res>(_self.permissions, (value) {
      return _then(_self.copyWith(permissions: value));
    });
  }
}

/// @nodoc
mixin _$AccessAuditLog {
  String get id;
  String get clientId;
  String get userId;
  String get action;
  String? get targetUserId;
  Map<String, dynamic>? get details;
  DateTime get timestamp;

  /// Create a copy of AccessAuditLog
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AccessAuditLogCopyWith<AccessAuditLog> get copyWith =>
      _$AccessAuditLogCopyWithImpl<AccessAuditLog>(
          this as AccessAuditLog, _$identity);

  /// Serializes this AccessAuditLog to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AccessAuditLog &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.action, action) || other.action == action) &&
            (identical(other.targetUserId, targetUserId) ||
                other.targetUserId == targetUserId) &&
            const DeepCollectionEquality().equals(other.details, details) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, clientId, userId, action,
      targetUserId, const DeepCollectionEquality().hash(details), timestamp);

  @override
  String toString() {
    return 'AccessAuditLog(id: $id, clientId: $clientId, userId: $userId, action: $action, targetUserId: $targetUserId, details: $details, timestamp: $timestamp)';
  }
}

/// @nodoc
abstract mixin class $AccessAuditLogCopyWith<$Res> {
  factory $AccessAuditLogCopyWith(
          AccessAuditLog value, $Res Function(AccessAuditLog) _then) =
      _$AccessAuditLogCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String clientId,
      String userId,
      String action,
      String? targetUserId,
      Map<String, dynamic>? details,
      DateTime timestamp});
}

/// @nodoc
class _$AccessAuditLogCopyWithImpl<$Res>
    implements $AccessAuditLogCopyWith<$Res> {
  _$AccessAuditLogCopyWithImpl(this._self, this._then);

  final AccessAuditLog _self;
  final $Res Function(AccessAuditLog) _then;

  /// Create a copy of AccessAuditLog
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? clientId = null,
    Object? userId = null,
    Object? action = null,
    Object? targetUserId = freezed,
    Object? details = freezed,
    Object? timestamp = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      clientId: null == clientId
          ? _self.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      action: null == action
          ? _self.action
          : action // ignore: cast_nullable_to_non_nullable
              as String,
      targetUserId: freezed == targetUserId
          ? _self.targetUserId
          : targetUserId // ignore: cast_nullable_to_non_nullable
              as String?,
      details: freezed == details
          ? _self.details
          : details // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      timestamp: null == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// Adds pattern-matching-related methods to [AccessAuditLog].
extension AccessAuditLogPatterns on AccessAuditLog {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_AccessAuditLog value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AccessAuditLog() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_AccessAuditLog value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AccessAuditLog():
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_AccessAuditLog value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AccessAuditLog() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String id,
            String clientId,
            String userId,
            String action,
            String? targetUserId,
            Map<String, dynamic>? details,
            DateTime timestamp)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AccessAuditLog() when $default != null:
        return $default(_that.id, _that.clientId, _that.userId, _that.action,
            _that.targetUserId, _that.details, _that.timestamp);
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String id,
            String clientId,
            String userId,
            String action,
            String? targetUserId,
            Map<String, dynamic>? details,
            DateTime timestamp)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AccessAuditLog():
        return $default(_that.id, _that.clientId, _that.userId, _that.action,
            _that.targetUserId, _that.details, _that.timestamp);
      case _:
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String id,
            String clientId,
            String userId,
            String action,
            String? targetUserId,
            Map<String, dynamic>? details,
            DateTime timestamp)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AccessAuditLog() when $default != null:
        return $default(_that.id, _that.clientId, _that.userId, _that.action,
            _that.targetUserId, _that.details, _that.timestamp);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _AccessAuditLog implements AccessAuditLog {
  const _AccessAuditLog(
      {required this.id,
      required this.clientId,
      required this.userId,
      required this.action,
      this.targetUserId,
      final Map<String, dynamic>? details,
      required this.timestamp})
      : _details = details;
  factory _AccessAuditLog.fromJson(Map<String, dynamic> json) =>
      _$AccessAuditLogFromJson(json);

  @override
  final String id;
  @override
  final String clientId;
  @override
  final String userId;
  @override
  final String action;
  @override
  final String? targetUserId;
  final Map<String, dynamic>? _details;
  @override
  Map<String, dynamic>? get details {
    final value = _details;
    if (value == null) return null;
    if (_details is EqualUnmodifiableMapView) return _details;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final DateTime timestamp;

  /// Create a copy of AccessAuditLog
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AccessAuditLogCopyWith<_AccessAuditLog> get copyWith =>
      __$AccessAuditLogCopyWithImpl<_AccessAuditLog>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AccessAuditLogToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AccessAuditLog &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.action, action) || other.action == action) &&
            (identical(other.targetUserId, targetUserId) ||
                other.targetUserId == targetUserId) &&
            const DeepCollectionEquality().equals(other._details, _details) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, clientId, userId, action,
      targetUserId, const DeepCollectionEquality().hash(_details), timestamp);

  @override
  String toString() {
    return 'AccessAuditLog(id: $id, clientId: $clientId, userId: $userId, action: $action, targetUserId: $targetUserId, details: $details, timestamp: $timestamp)';
  }
}

/// @nodoc
abstract mixin class _$AccessAuditLogCopyWith<$Res>
    implements $AccessAuditLogCopyWith<$Res> {
  factory _$AccessAuditLogCopyWith(
          _AccessAuditLog value, $Res Function(_AccessAuditLog) _then) =
      __$AccessAuditLogCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String clientId,
      String userId,
      String action,
      String? targetUserId,
      Map<String, dynamic>? details,
      DateTime timestamp});
}

/// @nodoc
class __$AccessAuditLogCopyWithImpl<$Res>
    implements _$AccessAuditLogCopyWith<$Res> {
  __$AccessAuditLogCopyWithImpl(this._self, this._then);

  final _AccessAuditLog _self;
  final $Res Function(_AccessAuditLog) _then;

  /// Create a copy of AccessAuditLog
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? clientId = null,
    Object? userId = null,
    Object? action = null,
    Object? targetUserId = freezed,
    Object? details = freezed,
    Object? timestamp = null,
  }) {
    return _then(_AccessAuditLog(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      clientId: null == clientId
          ? _self.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      action: null == action
          ? _self.action
          : action // ignore: cast_nullable_to_non_nullable
              as String,
      targetUserId: freezed == targetUserId
          ? _self.targetUserId
          : targetUserId // ignore: cast_nullable_to_non_nullable
              as String?,
      details: freezed == details
          ? _self._details
          : details // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      timestamp: null == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
mixin _$NotificationPreferences {
  bool get email;
  bool get sms;
  bool get push;
  bool get appointmentReminders;
  bool get statusUpdates;
  bool get emergencyAlerts;
  bool get serviceConfirmations;
  QuietHours? get quietHours;

  /// Create a copy of NotificationPreferences
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $NotificationPreferencesCopyWith<NotificationPreferences> get copyWith =>
      _$NotificationPreferencesCopyWithImpl<NotificationPreferences>(
          this as NotificationPreferences, _$identity);

  /// Serializes this NotificationPreferences to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is NotificationPreferences &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.sms, sms) || other.sms == sms) &&
            (identical(other.push, push) || other.push == push) &&
            (identical(other.appointmentReminders, appointmentReminders) ||
                other.appointmentReminders == appointmentReminders) &&
            (identical(other.statusUpdates, statusUpdates) ||
                other.statusUpdates == statusUpdates) &&
            (identical(other.emergencyAlerts, emergencyAlerts) ||
                other.emergencyAlerts == emergencyAlerts) &&
            (identical(other.serviceConfirmations, serviceConfirmations) ||
                other.serviceConfirmations == serviceConfirmations) &&
            (identical(other.quietHours, quietHours) ||
                other.quietHours == quietHours));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      email,
      sms,
      push,
      appointmentReminders,
      statusUpdates,
      emergencyAlerts,
      serviceConfirmations,
      quietHours);

  @override
  String toString() {
    return 'NotificationPreferences(email: $email, sms: $sms, push: $push, appointmentReminders: $appointmentReminders, statusUpdates: $statusUpdates, emergencyAlerts: $emergencyAlerts, serviceConfirmations: $serviceConfirmations, quietHours: $quietHours)';
  }
}

/// @nodoc
abstract mixin class $NotificationPreferencesCopyWith<$Res> {
  factory $NotificationPreferencesCopyWith(NotificationPreferences value,
          $Res Function(NotificationPreferences) _then) =
      _$NotificationPreferencesCopyWithImpl;
  @useResult
  $Res call(
      {bool email,
      bool sms,
      bool push,
      bool appointmentReminders,
      bool statusUpdates,
      bool emergencyAlerts,
      bool serviceConfirmations,
      QuietHours? quietHours});

  $QuietHoursCopyWith<$Res>? get quietHours;
}

/// @nodoc
class _$NotificationPreferencesCopyWithImpl<$Res>
    implements $NotificationPreferencesCopyWith<$Res> {
  _$NotificationPreferencesCopyWithImpl(this._self, this._then);

  final NotificationPreferences _self;
  final $Res Function(NotificationPreferences) _then;

  /// Create a copy of NotificationPreferences
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? sms = null,
    Object? push = null,
    Object? appointmentReminders = null,
    Object? statusUpdates = null,
    Object? emergencyAlerts = null,
    Object? serviceConfirmations = null,
    Object? quietHours = freezed,
  }) {
    return _then(_self.copyWith(
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as bool,
      sms: null == sms
          ? _self.sms
          : sms // ignore: cast_nullable_to_non_nullable
              as bool,
      push: null == push
          ? _self.push
          : push // ignore: cast_nullable_to_non_nullable
              as bool,
      appointmentReminders: null == appointmentReminders
          ? _self.appointmentReminders
          : appointmentReminders // ignore: cast_nullable_to_non_nullable
              as bool,
      statusUpdates: null == statusUpdates
          ? _self.statusUpdates
          : statusUpdates // ignore: cast_nullable_to_non_nullable
              as bool,
      emergencyAlerts: null == emergencyAlerts
          ? _self.emergencyAlerts
          : emergencyAlerts // ignore: cast_nullable_to_non_nullable
              as bool,
      serviceConfirmations: null == serviceConfirmations
          ? _self.serviceConfirmations
          : serviceConfirmations // ignore: cast_nullable_to_non_nullable
              as bool,
      quietHours: freezed == quietHours
          ? _self.quietHours
          : quietHours // ignore: cast_nullable_to_non_nullable
              as QuietHours?,
    ));
  }

  /// Create a copy of NotificationPreferences
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $QuietHoursCopyWith<$Res>? get quietHours {
    if (_self.quietHours == null) {
      return null;
    }

    return $QuietHoursCopyWith<$Res>(_self.quietHours!, (value) {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_NotificationPreferences value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _NotificationPreferences() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_NotificationPreferences value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NotificationPreferences():
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_NotificationPreferences value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NotificationPreferences() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            bool email,
            bool sms,
            bool push,
            bool appointmentReminders,
            bool statusUpdates,
            bool emergencyAlerts,
            bool serviceConfirmations,
            QuietHours? quietHours)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _NotificationPreferences() when $default != null:
        return $default(
            _that.email,
            _that.sms,
            _that.push,
            _that.appointmentReminders,
            _that.statusUpdates,
            _that.emergencyAlerts,
            _that.serviceConfirmations,
            _that.quietHours);
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            bool email,
            bool sms,
            bool push,
            bool appointmentReminders,
            bool statusUpdates,
            bool emergencyAlerts,
            bool serviceConfirmations,
            QuietHours? quietHours)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NotificationPreferences():
        return $default(
            _that.email,
            _that.sms,
            _that.push,
            _that.appointmentReminders,
            _that.statusUpdates,
            _that.emergencyAlerts,
            _that.serviceConfirmations,
            _that.quietHours);
      case _:
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            bool email,
            bool sms,
            bool push,
            bool appointmentReminders,
            bool statusUpdates,
            bool emergencyAlerts,
            bool serviceConfirmations,
            QuietHours? quietHours)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NotificationPreferences() when $default != null:
        return $default(
            _that.email,
            _that.sms,
            _that.push,
            _that.appointmentReminders,
            _that.statusUpdates,
            _that.emergencyAlerts,
            _that.serviceConfirmations,
            _that.quietHours);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _NotificationPreferences implements NotificationPreferences {
  const _NotificationPreferences(
      {this.email = true,
      this.sms = false,
      this.push = true,
      this.appointmentReminders = true,
      this.statusUpdates = true,
      this.emergencyAlerts = true,
      this.serviceConfirmations = true,
      this.quietHours});
  factory _NotificationPreferences.fromJson(Map<String, dynamic> json) =>
      _$NotificationPreferencesFromJson(json);

  @override
  @JsonKey()
  final bool email;
  @override
  @JsonKey()
  final bool sms;
  @override
  @JsonKey()
  final bool push;
  @override
  @JsonKey()
  final bool appointmentReminders;
  @override
  @JsonKey()
  final bool statusUpdates;
  @override
  @JsonKey()
  final bool emergencyAlerts;
  @override
  @JsonKey()
  final bool serviceConfirmations;
  @override
  final QuietHours? quietHours;

  /// Create a copy of NotificationPreferences
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$NotificationPreferencesCopyWith<_NotificationPreferences> get copyWith =>
      __$NotificationPreferencesCopyWithImpl<_NotificationPreferences>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$NotificationPreferencesToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _NotificationPreferences &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.sms, sms) || other.sms == sms) &&
            (identical(other.push, push) || other.push == push) &&
            (identical(other.appointmentReminders, appointmentReminders) ||
                other.appointmentReminders == appointmentReminders) &&
            (identical(other.statusUpdates, statusUpdates) ||
                other.statusUpdates == statusUpdates) &&
            (identical(other.emergencyAlerts, emergencyAlerts) ||
                other.emergencyAlerts == emergencyAlerts) &&
            (identical(other.serviceConfirmations, serviceConfirmations) ||
                other.serviceConfirmations == serviceConfirmations) &&
            (identical(other.quietHours, quietHours) ||
                other.quietHours == quietHours));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      email,
      sms,
      push,
      appointmentReminders,
      statusUpdates,
      emergencyAlerts,
      serviceConfirmations,
      quietHours);

  @override
  String toString() {
    return 'NotificationPreferences(email: $email, sms: $sms, push: $push, appointmentReminders: $appointmentReminders, statusUpdates: $statusUpdates, emergencyAlerts: $emergencyAlerts, serviceConfirmations: $serviceConfirmations, quietHours: $quietHours)';
  }
}

/// @nodoc
abstract mixin class _$NotificationPreferencesCopyWith<$Res>
    implements $NotificationPreferencesCopyWith<$Res> {
  factory _$NotificationPreferencesCopyWith(_NotificationPreferences value,
          $Res Function(_NotificationPreferences) _then) =
      __$NotificationPreferencesCopyWithImpl;
  @override
  @useResult
  $Res call(
      {bool email,
      bool sms,
      bool push,
      bool appointmentReminders,
      bool statusUpdates,
      bool emergencyAlerts,
      bool serviceConfirmations,
      QuietHours? quietHours});

  @override
  $QuietHoursCopyWith<$Res>? get quietHours;
}

/// @nodoc
class __$NotificationPreferencesCopyWithImpl<$Res>
    implements _$NotificationPreferencesCopyWith<$Res> {
  __$NotificationPreferencesCopyWithImpl(this._self, this._then);

  final _NotificationPreferences _self;
  final $Res Function(_NotificationPreferences) _then;

  /// Create a copy of NotificationPreferences
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? email = null,
    Object? sms = null,
    Object? push = null,
    Object? appointmentReminders = null,
    Object? statusUpdates = null,
    Object? emergencyAlerts = null,
    Object? serviceConfirmations = null,
    Object? quietHours = freezed,
  }) {
    return _then(_NotificationPreferences(
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as bool,
      sms: null == sms
          ? _self.sms
          : sms // ignore: cast_nullable_to_non_nullable
              as bool,
      push: null == push
          ? _self.push
          : push // ignore: cast_nullable_to_non_nullable
              as bool,
      appointmentReminders: null == appointmentReminders
          ? _self.appointmentReminders
          : appointmentReminders // ignore: cast_nullable_to_non_nullable
              as bool,
      statusUpdates: null == statusUpdates
          ? _self.statusUpdates
          : statusUpdates // ignore: cast_nullable_to_non_nullable
              as bool,
      emergencyAlerts: null == emergencyAlerts
          ? _self.emergencyAlerts
          : emergencyAlerts // ignore: cast_nullable_to_non_nullable
              as bool,
      serviceConfirmations: null == serviceConfirmations
          ? _self.serviceConfirmations
          : serviceConfirmations // ignore: cast_nullable_to_non_nullable
              as bool,
      quietHours: freezed == quietHours
          ? _self.quietHours
          : quietHours // ignore: cast_nullable_to_non_nullable
              as QuietHours?,
    ));
  }

  /// Create a copy of NotificationPreferences
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $QuietHoursCopyWith<$Res>? get quietHours {
    if (_self.quietHours == null) {
      return null;
    }

    return $QuietHoursCopyWith<$Res>(_self.quietHours!, (value) {
      return _then(_self.copyWith(quietHours: value));
    });
  }
}

/// @nodoc
mixin _$QuietHours {
  String get start;
  String get end;

  /// Create a copy of QuietHours
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $QuietHoursCopyWith<QuietHours> get copyWith =>
      _$QuietHoursCopyWithImpl<QuietHours>(this as QuietHours, _$identity);

  /// Serializes this QuietHours to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is QuietHours &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.end, end) || other.end == end));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, start, end);

  @override
  String toString() {
    return 'QuietHours(start: $start, end: $end)';
  }
}

/// @nodoc
abstract mixin class $QuietHoursCopyWith<$Res> {
  factory $QuietHoursCopyWith(
          QuietHours value, $Res Function(QuietHours) _then) =
      _$QuietHoursCopyWithImpl;
  @useResult
  $Res call({String start, String end});
}

/// @nodoc
class _$QuietHoursCopyWithImpl<$Res> implements $QuietHoursCopyWith<$Res> {
  _$QuietHoursCopyWithImpl(this._self, this._then);

  final QuietHours _self;
  final $Res Function(QuietHours) _then;

  /// Create a copy of QuietHours
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? start = null,
    Object? end = null,
  }) {
    return _then(_self.copyWith(
      start: null == start
          ? _self.start
          : start // ignore: cast_nullable_to_non_nullable
              as String,
      end: null == end
          ? _self.end
          : end // ignore: cast_nullable_to_non_nullable
              as String,
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_QuietHours value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _QuietHours() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_QuietHours value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _QuietHours():
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_QuietHours value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _QuietHours() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String start, String end)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _QuietHours() when $default != null:
        return $default(_that.start, _that.end);
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String start, String end) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _QuietHours():
        return $default(_that.start, _that.end);
      case _:
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String start, String end)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _QuietHours() when $default != null:
        return $default(_that.start, _that.end);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _QuietHours implements QuietHours {
  const _QuietHours({required this.start, required this.end});
  factory _QuietHours.fromJson(Map<String, dynamic> json) =>
      _$QuietHoursFromJson(json);

  @override
  final String start;
  @override
  final String end;

  /// Create a copy of QuietHours
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$QuietHoursCopyWith<_QuietHours> get copyWith =>
      __$QuietHoursCopyWithImpl<_QuietHours>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$QuietHoursToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _QuietHours &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.end, end) || other.end == end));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, start, end);

  @override
  String toString() {
    return 'QuietHours(start: $start, end: $end)';
  }
}

/// @nodoc
abstract mixin class _$QuietHoursCopyWith<$Res>
    implements $QuietHoursCopyWith<$Res> {
  factory _$QuietHoursCopyWith(
          _QuietHours value, $Res Function(_QuietHours) _then) =
      __$QuietHoursCopyWithImpl;
  @override
  @useResult
  $Res call({String start, String end});
}

/// @nodoc
class __$QuietHoursCopyWithImpl<$Res> implements _$QuietHoursCopyWith<$Res> {
  __$QuietHoursCopyWithImpl(this._self, this._then);

  final _QuietHours _self;
  final $Res Function(_QuietHours) _then;

  /// Create a copy of QuietHours
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? start = null,
    Object? end = null,
  }) {
    return _then(_QuietHours(
      start: null == start
          ? _self.start
          : start // ignore: cast_nullable_to_non_nullable
              as String,
      end: null == end
          ? _self.end
          : end // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$DocumentShare {
  String get id;
  String get clientId;
  String get documentId;
  String get sharedBy;
  List<String> get sharedWith;
  List<String> get permissions;
  DateTime get sharedAt;
  DateTime? get expiresAt;

  /// Create a copy of DocumentShare
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DocumentShareCopyWith<DocumentShare> get copyWith =>
      _$DocumentShareCopyWithImpl<DocumentShare>(
          this as DocumentShare, _$identity);

  /// Serializes this DocumentShare to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DocumentShare &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.documentId, documentId) ||
                other.documentId == documentId) &&
            (identical(other.sharedBy, sharedBy) ||
                other.sharedBy == sharedBy) &&
            const DeepCollectionEquality()
                .equals(other.sharedWith, sharedWith) &&
            const DeepCollectionEquality()
                .equals(other.permissions, permissions) &&
            (identical(other.sharedAt, sharedAt) ||
                other.sharedAt == sharedAt) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      clientId,
      documentId,
      sharedBy,
      const DeepCollectionEquality().hash(sharedWith),
      const DeepCollectionEquality().hash(permissions),
      sharedAt,
      expiresAt);

  @override
  String toString() {
    return 'DocumentShare(id: $id, clientId: $clientId, documentId: $documentId, sharedBy: $sharedBy, sharedWith: $sharedWith, permissions: $permissions, sharedAt: $sharedAt, expiresAt: $expiresAt)';
  }
}

/// @nodoc
abstract mixin class $DocumentShareCopyWith<$Res> {
  factory $DocumentShareCopyWith(
          DocumentShare value, $Res Function(DocumentShare) _then) =
      _$DocumentShareCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String clientId,
      String documentId,
      String sharedBy,
      List<String> sharedWith,
      List<String> permissions,
      DateTime sharedAt,
      DateTime? expiresAt});
}

/// @nodoc
class _$DocumentShareCopyWithImpl<$Res>
    implements $DocumentShareCopyWith<$Res> {
  _$DocumentShareCopyWithImpl(this._self, this._then);

  final DocumentShare _self;
  final $Res Function(DocumentShare) _then;

  /// Create a copy of DocumentShare
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? clientId = null,
    Object? documentId = null,
    Object? sharedBy = null,
    Object? sharedWith = null,
    Object? permissions = null,
    Object? sharedAt = null,
    Object? expiresAt = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      clientId: null == clientId
          ? _self.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      documentId: null == documentId
          ? _self.documentId
          : documentId // ignore: cast_nullable_to_non_nullable
              as String,
      sharedBy: null == sharedBy
          ? _self.sharedBy
          : sharedBy // ignore: cast_nullable_to_non_nullable
              as String,
      sharedWith: null == sharedWith
          ? _self.sharedWith
          : sharedWith // ignore: cast_nullable_to_non_nullable
              as List<String>,
      permissions: null == permissions
          ? _self.permissions
          : permissions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      sharedAt: null == sharedAt
          ? _self.sharedAt
          : sharedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      expiresAt: freezed == expiresAt
          ? _self.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// Adds pattern-matching-related methods to [DocumentShare].
extension DocumentSharePatterns on DocumentShare {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_DocumentShare value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DocumentShare() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_DocumentShare value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DocumentShare():
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_DocumentShare value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DocumentShare() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String id,
            String clientId,
            String documentId,
            String sharedBy,
            List<String> sharedWith,
            List<String> permissions,
            DateTime sharedAt,
            DateTime? expiresAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DocumentShare() when $default != null:
        return $default(
            _that.id,
            _that.clientId,
            _that.documentId,
            _that.sharedBy,
            _that.sharedWith,
            _that.permissions,
            _that.sharedAt,
            _that.expiresAt);
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String id,
            String clientId,
            String documentId,
            String sharedBy,
            List<String> sharedWith,
            List<String> permissions,
            DateTime sharedAt,
            DateTime? expiresAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DocumentShare():
        return $default(
            _that.id,
            _that.clientId,
            _that.documentId,
            _that.sharedBy,
            _that.sharedWith,
            _that.permissions,
            _that.sharedAt,
            _that.expiresAt);
      case _:
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String id,
            String clientId,
            String documentId,
            String sharedBy,
            List<String> sharedWith,
            List<String> permissions,
            DateTime sharedAt,
            DateTime? expiresAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DocumentShare() when $default != null:
        return $default(
            _that.id,
            _that.clientId,
            _that.documentId,
            _that.sharedBy,
            _that.sharedWith,
            _that.permissions,
            _that.sharedAt,
            _that.expiresAt);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _DocumentShare implements DocumentShare {
  const _DocumentShare(
      {required this.id,
      required this.clientId,
      required this.documentId,
      required this.sharedBy,
      required final List<String> sharedWith,
      required final List<String> permissions,
      required this.sharedAt,
      this.expiresAt})
      : _sharedWith = sharedWith,
        _permissions = permissions;
  factory _DocumentShare.fromJson(Map<String, dynamic> json) =>
      _$DocumentShareFromJson(json);

  @override
  final String id;
  @override
  final String clientId;
  @override
  final String documentId;
  @override
  final String sharedBy;
  final List<String> _sharedWith;
  @override
  List<String> get sharedWith {
    if (_sharedWith is EqualUnmodifiableListView) return _sharedWith;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sharedWith);
  }

  final List<String> _permissions;
  @override
  List<String> get permissions {
    if (_permissions is EqualUnmodifiableListView) return _permissions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_permissions);
  }

  @override
  final DateTime sharedAt;
  @override
  final DateTime? expiresAt;

  /// Create a copy of DocumentShare
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DocumentShareCopyWith<_DocumentShare> get copyWith =>
      __$DocumentShareCopyWithImpl<_DocumentShare>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$DocumentShareToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DocumentShare &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.documentId, documentId) ||
                other.documentId == documentId) &&
            (identical(other.sharedBy, sharedBy) ||
                other.sharedBy == sharedBy) &&
            const DeepCollectionEquality()
                .equals(other._sharedWith, _sharedWith) &&
            const DeepCollectionEquality()
                .equals(other._permissions, _permissions) &&
            (identical(other.sharedAt, sharedAt) ||
                other.sharedAt == sharedAt) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      clientId,
      documentId,
      sharedBy,
      const DeepCollectionEquality().hash(_sharedWith),
      const DeepCollectionEquality().hash(_permissions),
      sharedAt,
      expiresAt);

  @override
  String toString() {
    return 'DocumentShare(id: $id, clientId: $clientId, documentId: $documentId, sharedBy: $sharedBy, sharedWith: $sharedWith, permissions: $permissions, sharedAt: $sharedAt, expiresAt: $expiresAt)';
  }
}

/// @nodoc
abstract mixin class _$DocumentShareCopyWith<$Res>
    implements $DocumentShareCopyWith<$Res> {
  factory _$DocumentShareCopyWith(
          _DocumentShare value, $Res Function(_DocumentShare) _then) =
      __$DocumentShareCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String clientId,
      String documentId,
      String sharedBy,
      List<String> sharedWith,
      List<String> permissions,
      DateTime sharedAt,
      DateTime? expiresAt});
}

/// @nodoc
class __$DocumentShareCopyWithImpl<$Res>
    implements _$DocumentShareCopyWith<$Res> {
  __$DocumentShareCopyWithImpl(this._self, this._then);

  final _DocumentShare _self;
  final $Res Function(_DocumentShare) _then;

  /// Create a copy of DocumentShare
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? clientId = null,
    Object? documentId = null,
    Object? sharedBy = null,
    Object? sharedWith = null,
    Object? permissions = null,
    Object? sharedAt = null,
    Object? expiresAt = freezed,
  }) {
    return _then(_DocumentShare(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      clientId: null == clientId
          ? _self.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      documentId: null == documentId
          ? _self.documentId
          : documentId // ignore: cast_nullable_to_non_nullable
              as String,
      sharedBy: null == sharedBy
          ? _self.sharedBy
          : sharedBy // ignore: cast_nullable_to_non_nullable
              as String,
      sharedWith: null == sharedWith
          ? _self._sharedWith
          : sharedWith // ignore: cast_nullable_to_non_nullable
              as List<String>,
      permissions: null == permissions
          ? _self._permissions
          : permissions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      sharedAt: null == sharedAt
          ? _self.sharedAt
          : sharedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      expiresAt: freezed == expiresAt
          ? _self.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
mixin _$PushNotification {
  String get id;
  String get userId;
  String get title;
  String get body;
  String get type;
  String get priority; // 'critical', 'high', 'normal', 'low'
  Map<String, dynamic>? get data;
  List<NotificationAction>? get actions;
  DateTime get timestamp;
  bool? get read;
  DateTime? get readAt;

  /// Create a copy of PushNotification
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PushNotificationCopyWith<PushNotification> get copyWith =>
      _$PushNotificationCopyWithImpl<PushNotification>(
          this as PushNotification, _$identity);

  /// Serializes this PushNotification to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PushNotification &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.body, body) || other.body == body) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            const DeepCollectionEquality().equals(other.data, data) &&
            const DeepCollectionEquality().equals(other.actions, actions) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.read, read) || other.read == read) &&
            (identical(other.readAt, readAt) || other.readAt == readAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      title,
      body,
      type,
      priority,
      const DeepCollectionEquality().hash(data),
      const DeepCollectionEquality().hash(actions),
      timestamp,
      read,
      readAt);

  @override
  String toString() {
    return 'PushNotification(id: $id, userId: $userId, title: $title, body: $body, type: $type, priority: $priority, data: $data, actions: $actions, timestamp: $timestamp, read: $read, readAt: $readAt)';
  }
}

/// @nodoc
abstract mixin class $PushNotificationCopyWith<$Res> {
  factory $PushNotificationCopyWith(
          PushNotification value, $Res Function(PushNotification) _then) =
      _$PushNotificationCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String userId,
      String title,
      String body,
      String type,
      String priority,
      Map<String, dynamic>? data,
      List<NotificationAction>? actions,
      DateTime timestamp,
      bool? read,
      DateTime? readAt});
}

/// @nodoc
class _$PushNotificationCopyWithImpl<$Res>
    implements $PushNotificationCopyWith<$Res> {
  _$PushNotificationCopyWithImpl(this._self, this._then);

  final PushNotification _self;
  final $Res Function(PushNotification) _then;

  /// Create a copy of PushNotification
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? title = null,
    Object? body = null,
    Object? type = null,
    Object? priority = null,
    Object? data = freezed,
    Object? actions = freezed,
    Object? timestamp = null,
    Object? read = freezed,
    Object? readAt = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _self.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      priority: null == priority
          ? _self.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as String,
      data: freezed == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      actions: freezed == actions
          ? _self.actions
          : actions // ignore: cast_nullable_to_non_nullable
              as List<NotificationAction>?,
      timestamp: null == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      read: freezed == read
          ? _self.read
          : read // ignore: cast_nullable_to_non_nullable
              as bool?,
      readAt: freezed == readAt
          ? _self.readAt
          : readAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// Adds pattern-matching-related methods to [PushNotification].
extension PushNotificationPatterns on PushNotification {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_PushNotification value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PushNotification() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_PushNotification value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PushNotification():
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_PushNotification value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PushNotification() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String id,
            String userId,
            String title,
            String body,
            String type,
            String priority,
            Map<String, dynamic>? data,
            List<NotificationAction>? actions,
            DateTime timestamp,
            bool? read,
            DateTime? readAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PushNotification() when $default != null:
        return $default(
            _that.id,
            _that.userId,
            _that.title,
            _that.body,
            _that.type,
            _that.priority,
            _that.data,
            _that.actions,
            _that.timestamp,
            _that.read,
            _that.readAt);
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String id,
            String userId,
            String title,
            String body,
            String type,
            String priority,
            Map<String, dynamic>? data,
            List<NotificationAction>? actions,
            DateTime timestamp,
            bool? read,
            DateTime? readAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PushNotification():
        return $default(
            _that.id,
            _that.userId,
            _that.title,
            _that.body,
            _that.type,
            _that.priority,
            _that.data,
            _that.actions,
            _that.timestamp,
            _that.read,
            _that.readAt);
      case _:
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String id,
            String userId,
            String title,
            String body,
            String type,
            String priority,
            Map<String, dynamic>? data,
            List<NotificationAction>? actions,
            DateTime timestamp,
            bool? read,
            DateTime? readAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PushNotification() when $default != null:
        return $default(
            _that.id,
            _that.userId,
            _that.title,
            _that.body,
            _that.type,
            _that.priority,
            _that.data,
            _that.actions,
            _that.timestamp,
            _that.read,
            _that.readAt);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _PushNotification implements PushNotification {
  const _PushNotification(
      {required this.id,
      required this.userId,
      required this.title,
      required this.body,
      required this.type,
      required this.priority,
      final Map<String, dynamic>? data,
      final List<NotificationAction>? actions,
      required this.timestamp,
      this.read,
      this.readAt})
      : _data = data,
        _actions = actions;
  factory _PushNotification.fromJson(Map<String, dynamic> json) =>
      _$PushNotificationFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String title;
  @override
  final String body;
  @override
  final String type;
  @override
  final String priority;
// 'critical', 'high', 'normal', 'low'
  final Map<String, dynamic>? _data;
// 'critical', 'high', 'normal', 'low'
  @override
  Map<String, dynamic>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final List<NotificationAction>? _actions;
  @override
  List<NotificationAction>? get actions {
    final value = _actions;
    if (value == null) return null;
    if (_actions is EqualUnmodifiableListView) return _actions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final DateTime timestamp;
  @override
  final bool? read;
  @override
  final DateTime? readAt;

  /// Create a copy of PushNotification
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PushNotificationCopyWith<_PushNotification> get copyWith =>
      __$PushNotificationCopyWithImpl<_PushNotification>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PushNotificationToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PushNotification &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.body, body) || other.body == body) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            const DeepCollectionEquality().equals(other._actions, _actions) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.read, read) || other.read == read) &&
            (identical(other.readAt, readAt) || other.readAt == readAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      title,
      body,
      type,
      priority,
      const DeepCollectionEquality().hash(_data),
      const DeepCollectionEquality().hash(_actions),
      timestamp,
      read,
      readAt);

  @override
  String toString() {
    return 'PushNotification(id: $id, userId: $userId, title: $title, body: $body, type: $type, priority: $priority, data: $data, actions: $actions, timestamp: $timestamp, read: $read, readAt: $readAt)';
  }
}

/// @nodoc
abstract mixin class _$PushNotificationCopyWith<$Res>
    implements $PushNotificationCopyWith<$Res> {
  factory _$PushNotificationCopyWith(
          _PushNotification value, $Res Function(_PushNotification) _then) =
      __$PushNotificationCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String title,
      String body,
      String type,
      String priority,
      Map<String, dynamic>? data,
      List<NotificationAction>? actions,
      DateTime timestamp,
      bool? read,
      DateTime? readAt});
}

/// @nodoc
class __$PushNotificationCopyWithImpl<$Res>
    implements _$PushNotificationCopyWith<$Res> {
  __$PushNotificationCopyWithImpl(this._self, this._then);

  final _PushNotification _self;
  final $Res Function(_PushNotification) _then;

  /// Create a copy of PushNotification
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? title = null,
    Object? body = null,
    Object? type = null,
    Object? priority = null,
    Object? data = freezed,
    Object? actions = freezed,
    Object? timestamp = null,
    Object? read = freezed,
    Object? readAt = freezed,
  }) {
    return _then(_PushNotification(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _self.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      priority: null == priority
          ? _self.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as String,
      data: freezed == data
          ? _self._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      actions: freezed == actions
          ? _self._actions
          : actions // ignore: cast_nullable_to_non_nullable
              as List<NotificationAction>?,
      timestamp: null == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      read: freezed == read
          ? _self.read
          : read // ignore: cast_nullable_to_non_nullable
              as bool?,
      readAt: freezed == readAt
          ? _self.readAt
          : readAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
mixin _$NotificationAction {
  String get id;
  String get label;
  String get action;

  /// Create a copy of NotificationAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $NotificationActionCopyWith<NotificationAction> get copyWith =>
      _$NotificationActionCopyWithImpl<NotificationAction>(
          this as NotificationAction, _$identity);

  /// Serializes this NotificationAction to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is NotificationAction &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.action, action) || other.action == action));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, label, action);

  @override
  String toString() {
    return 'NotificationAction(id: $id, label: $label, action: $action)';
  }
}

/// @nodoc
abstract mixin class $NotificationActionCopyWith<$Res> {
  factory $NotificationActionCopyWith(
          NotificationAction value, $Res Function(NotificationAction) _then) =
      _$NotificationActionCopyWithImpl;
  @useResult
  $Res call({String id, String label, String action});
}

/// @nodoc
class _$NotificationActionCopyWithImpl<$Res>
    implements $NotificationActionCopyWith<$Res> {
  _$NotificationActionCopyWithImpl(this._self, this._then);

  final NotificationAction _self;
  final $Res Function(NotificationAction) _then;

  /// Create a copy of NotificationAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? label = null,
    Object? action = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      label: null == label
          ? _self.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      action: null == action
          ? _self.action
          : action // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [NotificationAction].
extension NotificationActionPatterns on NotificationAction {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_NotificationAction value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _NotificationAction() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_NotificationAction value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NotificationAction():
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_NotificationAction value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NotificationAction() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String id, String label, String action)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _NotificationAction() when $default != null:
        return $default(_that.id, _that.label, _that.action);
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String id, String label, String action) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NotificationAction():
        return $default(_that.id, _that.label, _that.action);
      case _:
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String id, String label, String action)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NotificationAction() when $default != null:
        return $default(_that.id, _that.label, _that.action);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _NotificationAction implements NotificationAction {
  const _NotificationAction(
      {required this.id, required this.label, required this.action});
  factory _NotificationAction.fromJson(Map<String, dynamic> json) =>
      _$NotificationActionFromJson(json);

  @override
  final String id;
  @override
  final String label;
  @override
  final String action;

  /// Create a copy of NotificationAction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$NotificationActionCopyWith<_NotificationAction> get copyWith =>
      __$NotificationActionCopyWithImpl<_NotificationAction>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$NotificationActionToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _NotificationAction &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.action, action) || other.action == action));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, label, action);

  @override
  String toString() {
    return 'NotificationAction(id: $id, label: $label, action: $action)';
  }
}

/// @nodoc
abstract mixin class _$NotificationActionCopyWith<$Res>
    implements $NotificationActionCopyWith<$Res> {
  factory _$NotificationActionCopyWith(
          _NotificationAction value, $Res Function(_NotificationAction) _then) =
      __$NotificationActionCopyWithImpl;
  @override
  @useResult
  $Res call({String id, String label, String action});
}

/// @nodoc
class __$NotificationActionCopyWithImpl<$Res>
    implements _$NotificationActionCopyWith<$Res> {
  __$NotificationActionCopyWithImpl(this._self, this._then);

  final _NotificationAction _self;
  final $Res Function(_NotificationAction) _then;

  /// Create a copy of NotificationAction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? label = null,
    Object? action = null,
  }) {
    return _then(_NotificationAction(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      label: null == label
          ? _self.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      action: null == action
          ? _self.action
          : action // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$WebSocketEvent {
  String get event;
  Map<String, dynamic> get data;
  DateTime get timestamp;

  /// Create a copy of WebSocketEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WebSocketEventCopyWith<WebSocketEvent> get copyWith =>
      _$WebSocketEventCopyWithImpl<WebSocketEvent>(
          this as WebSocketEvent, _$identity);

  /// Serializes this WebSocketEvent to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WebSocketEvent &&
            (identical(other.event, event) || other.event == event) &&
            const DeepCollectionEquality().equals(other.data, data) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, event, const DeepCollectionEquality().hash(data), timestamp);

  @override
  String toString() {
    return 'WebSocketEvent(event: $event, data: $data, timestamp: $timestamp)';
  }
}

/// @nodoc
abstract mixin class $WebSocketEventCopyWith<$Res> {
  factory $WebSocketEventCopyWith(
          WebSocketEvent value, $Res Function(WebSocketEvent) _then) =
      _$WebSocketEventCopyWithImpl;
  @useResult
  $Res call({String event, Map<String, dynamic> data, DateTime timestamp});
}

/// @nodoc
class _$WebSocketEventCopyWithImpl<$Res>
    implements $WebSocketEventCopyWith<$Res> {
  _$WebSocketEventCopyWithImpl(this._self, this._then);

  final WebSocketEvent _self;
  final $Res Function(WebSocketEvent) _then;

  /// Create a copy of WebSocketEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? event = null,
    Object? data = null,
    Object? timestamp = null,
  }) {
    return _then(_self.copyWith(
      event: null == event
          ? _self.event
          : event // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      timestamp: null == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// Adds pattern-matching-related methods to [WebSocketEvent].
extension WebSocketEventPatterns on WebSocketEvent {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_WebSocketEvent value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _WebSocketEvent() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_WebSocketEvent value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WebSocketEvent():
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_WebSocketEvent value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WebSocketEvent() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String event, Map<String, dynamic> data, DateTime timestamp)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _WebSocketEvent() when $default != null:
        return $default(_that.event, _that.data, _that.timestamp);
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String event, Map<String, dynamic> data, DateTime timestamp)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WebSocketEvent():
        return $default(_that.event, _that.data, _that.timestamp);
      case _:
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String event, Map<String, dynamic> data, DateTime timestamp)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WebSocketEvent() when $default != null:
        return $default(_that.event, _that.data, _that.timestamp);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _WebSocketEvent implements WebSocketEvent {
  const _WebSocketEvent(
      {required this.event,
      required final Map<String, dynamic> data,
      required this.timestamp})
      : _data = data;
  factory _WebSocketEvent.fromJson(Map<String, dynamic> json) =>
      _$WebSocketEventFromJson(json);

  @override
  final String event;
  final Map<String, dynamic> _data;
  @override
  Map<String, dynamic> get data {
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_data);
  }

  @override
  final DateTime timestamp;

  /// Create a copy of WebSocketEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WebSocketEventCopyWith<_WebSocketEvent> get copyWith =>
      __$WebSocketEventCopyWithImpl<_WebSocketEvent>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$WebSocketEventToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WebSocketEvent &&
            (identical(other.event, event) || other.event == event) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, event,
      const DeepCollectionEquality().hash(_data), timestamp);

  @override
  String toString() {
    return 'WebSocketEvent(event: $event, data: $data, timestamp: $timestamp)';
  }
}

/// @nodoc
abstract mixin class _$WebSocketEventCopyWith<$Res>
    implements $WebSocketEventCopyWith<$Res> {
  factory _$WebSocketEventCopyWith(
          _WebSocketEvent value, $Res Function(_WebSocketEvent) _then) =
      __$WebSocketEventCopyWithImpl;
  @override
  @useResult
  $Res call({String event, Map<String, dynamic> data, DateTime timestamp});
}

/// @nodoc
class __$WebSocketEventCopyWithImpl<$Res>
    implements _$WebSocketEventCopyWith<$Res> {
  __$WebSocketEventCopyWithImpl(this._self, this._then);

  final _WebSocketEvent _self;
  final $Res Function(_WebSocketEvent) _then;

  /// Create a copy of WebSocketEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? event = null,
    Object? data = null,
    Object? timestamp = null,
  }) {
    return _then(_WebSocketEvent(
      event: null == event
          ? _self.event
          : event // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _self._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      timestamp: null == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
mixin _$ConnectionStatus {
  bool get connected;
  String? get error;
  DateTime? get lastConnected;
  DateTime? get lastDisconnected;

  /// Create a copy of ConnectionStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ConnectionStatusCopyWith<ConnectionStatus> get copyWith =>
      _$ConnectionStatusCopyWithImpl<ConnectionStatus>(
          this as ConnectionStatus, _$identity);

  /// Serializes this ConnectionStatus to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ConnectionStatus &&
            (identical(other.connected, connected) ||
                other.connected == connected) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.lastConnected, lastConnected) ||
                other.lastConnected == lastConnected) &&
            (identical(other.lastDisconnected, lastDisconnected) ||
                other.lastDisconnected == lastDisconnected));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, connected, error, lastConnected, lastDisconnected);

  @override
  String toString() {
    return 'ConnectionStatus(connected: $connected, error: $error, lastConnected: $lastConnected, lastDisconnected: $lastDisconnected)';
  }
}

/// @nodoc
abstract mixin class $ConnectionStatusCopyWith<$Res> {
  factory $ConnectionStatusCopyWith(
          ConnectionStatus value, $Res Function(ConnectionStatus) _then) =
      _$ConnectionStatusCopyWithImpl;
  @useResult
  $Res call(
      {bool connected,
      String? error,
      DateTime? lastConnected,
      DateTime? lastDisconnected});
}

/// @nodoc
class _$ConnectionStatusCopyWithImpl<$Res>
    implements $ConnectionStatusCopyWith<$Res> {
  _$ConnectionStatusCopyWithImpl(this._self, this._then);

  final ConnectionStatus _self;
  final $Res Function(ConnectionStatus) _then;

  /// Create a copy of ConnectionStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? connected = null,
    Object? error = freezed,
    Object? lastConnected = freezed,
    Object? lastDisconnected = freezed,
  }) {
    return _then(_self.copyWith(
      connected: null == connected
          ? _self.connected
          : connected // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      lastConnected: freezed == lastConnected
          ? _self.lastConnected
          : lastConnected // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastDisconnected: freezed == lastDisconnected
          ? _self.lastDisconnected
          : lastDisconnected // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// Adds pattern-matching-related methods to [ConnectionStatus].
extension ConnectionStatusPatterns on ConnectionStatus {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_ConnectionStatus value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ConnectionStatus() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_ConnectionStatus value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ConnectionStatus():
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_ConnectionStatus value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ConnectionStatus() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(bool connected, String? error, DateTime? lastConnected,
            DateTime? lastDisconnected)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ConnectionStatus() when $default != null:
        return $default(_that.connected, _that.error, _that.lastConnected,
            _that.lastDisconnected);
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(bool connected, String? error, DateTime? lastConnected,
            DateTime? lastDisconnected)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ConnectionStatus():
        return $default(_that.connected, _that.error, _that.lastConnected,
            _that.lastDisconnected);
      case _:
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(bool connected, String? error, DateTime? lastConnected,
            DateTime? lastDisconnected)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ConnectionStatus() when $default != null:
        return $default(_that.connected, _that.error, _that.lastConnected,
            _that.lastDisconnected);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ConnectionStatus implements ConnectionStatus {
  const _ConnectionStatus(
      {required this.connected,
      this.error,
      this.lastConnected,
      this.lastDisconnected});
  factory _ConnectionStatus.fromJson(Map<String, dynamic> json) =>
      _$ConnectionStatusFromJson(json);

  @override
  final bool connected;
  @override
  final String? error;
  @override
  final DateTime? lastConnected;
  @override
  final DateTime? lastDisconnected;

  /// Create a copy of ConnectionStatus
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ConnectionStatusCopyWith<_ConnectionStatus> get copyWith =>
      __$ConnectionStatusCopyWithImpl<_ConnectionStatus>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ConnectionStatusToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ConnectionStatus &&
            (identical(other.connected, connected) ||
                other.connected == connected) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.lastConnected, lastConnected) ||
                other.lastConnected == lastConnected) &&
            (identical(other.lastDisconnected, lastDisconnected) ||
                other.lastDisconnected == lastDisconnected));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, connected, error, lastConnected, lastDisconnected);

  @override
  String toString() {
    return 'ConnectionStatus(connected: $connected, error: $error, lastConnected: $lastConnected, lastDisconnected: $lastDisconnected)';
  }
}

/// @nodoc
abstract mixin class _$ConnectionStatusCopyWith<$Res>
    implements $ConnectionStatusCopyWith<$Res> {
  factory _$ConnectionStatusCopyWith(
          _ConnectionStatus value, $Res Function(_ConnectionStatus) _then) =
      __$ConnectionStatusCopyWithImpl;
  @override
  @useResult
  $Res call(
      {bool connected,
      String? error,
      DateTime? lastConnected,
      DateTime? lastDisconnected});
}

/// @nodoc
class __$ConnectionStatusCopyWithImpl<$Res>
    implements _$ConnectionStatusCopyWith<$Res> {
  __$ConnectionStatusCopyWithImpl(this._self, this._then);

  final _ConnectionStatus _self;
  final $Res Function(_ConnectionStatus) _then;

  /// Create a copy of ConnectionStatus
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? connected = null,
    Object? error = freezed,
    Object? lastConnected = freezed,
    Object? lastDisconnected = freezed,
  }) {
    return _then(_ConnectionStatus(
      connected: null == connected
          ? _self.connected
          : connected // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      lastConnected: freezed == lastConnected
          ? _self.lastConnected
          : lastConnected // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastDisconnected: freezed == lastDisconnected
          ? _self.lastDisconnected
          : lastDisconnected // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
mixin _$EmergencyAlert {
  String get id;
  String get appointmentId;
  String get userId;
  String get userType;
  ClientLocation get location;
  String get message;
  DateTime get timestamp;
  String get status;
  String get priority;

  /// Create a copy of EmergencyAlert
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $EmergencyAlertCopyWith<EmergencyAlert> get copyWith =>
      _$EmergencyAlertCopyWithImpl<EmergencyAlert>(
          this as EmergencyAlert, _$identity);

  /// Serializes this EmergencyAlert to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is EmergencyAlert &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.appointmentId, appointmentId) ||
                other.appointmentId == appointmentId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.userType, userType) ||
                other.userType == userType) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.priority, priority) ||
                other.priority == priority));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, appointmentId, userId,
      userType, location, message, timestamp, status, priority);

  @override
  String toString() {
    return 'EmergencyAlert(id: $id, appointmentId: $appointmentId, userId: $userId, userType: $userType, location: $location, message: $message, timestamp: $timestamp, status: $status, priority: $priority)';
  }
}

/// @nodoc
abstract mixin class $EmergencyAlertCopyWith<$Res> {
  factory $EmergencyAlertCopyWith(
          EmergencyAlert value, $Res Function(EmergencyAlert) _then) =
      _$EmergencyAlertCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String appointmentId,
      String userId,
      String userType,
      ClientLocation location,
      String message,
      DateTime timestamp,
      String status,
      String priority});

  $ClientLocationCopyWith<$Res> get location;
}

/// @nodoc
class _$EmergencyAlertCopyWithImpl<$Res>
    implements $EmergencyAlertCopyWith<$Res> {
  _$EmergencyAlertCopyWithImpl(this._self, this._then);

  final EmergencyAlert _self;
  final $Res Function(EmergencyAlert) _then;

  /// Create a copy of EmergencyAlert
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? appointmentId = null,
    Object? userId = null,
    Object? userType = null,
    Object? location = null,
    Object? message = null,
    Object? timestamp = null,
    Object? status = null,
    Object? priority = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      appointmentId: null == appointmentId
          ? _self.appointmentId
          : appointmentId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      userType: null == userType
          ? _self.userType
          : userType // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _self.location
          : location // ignore: cast_nullable_to_non_nullable
              as ClientLocation,
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      priority: null == priority
          ? _self.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  /// Create a copy of EmergencyAlert
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ClientLocationCopyWith<$Res> get location {
    return $ClientLocationCopyWith<$Res>(_self.location, (value) {
      return _then(_self.copyWith(location: value));
    });
  }
}

/// Adds pattern-matching-related methods to [EmergencyAlert].
extension EmergencyAlertPatterns on EmergencyAlert {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_EmergencyAlert value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _EmergencyAlert() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_EmergencyAlert value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EmergencyAlert():
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_EmergencyAlert value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EmergencyAlert() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String id,
            String appointmentId,
            String userId,
            String userType,
            ClientLocation location,
            String message,
            DateTime timestamp,
            String status,
            String priority)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _EmergencyAlert() when $default != null:
        return $default(
            _that.id,
            _that.appointmentId,
            _that.userId,
            _that.userType,
            _that.location,
            _that.message,
            _that.timestamp,
            _that.status,
            _that.priority);
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String id,
            String appointmentId,
            String userId,
            String userType,
            ClientLocation location,
            String message,
            DateTime timestamp,
            String status,
            String priority)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EmergencyAlert():
        return $default(
            _that.id,
            _that.appointmentId,
            _that.userId,
            _that.userType,
            _that.location,
            _that.message,
            _that.timestamp,
            _that.status,
            _that.priority);
      case _:
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String id,
            String appointmentId,
            String userId,
            String userType,
            ClientLocation location,
            String message,
            DateTime timestamp,
            String status,
            String priority)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EmergencyAlert() when $default != null:
        return $default(
            _that.id,
            _that.appointmentId,
            _that.userId,
            _that.userType,
            _that.location,
            _that.message,
            _that.timestamp,
            _that.status,
            _that.priority);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _EmergencyAlert implements EmergencyAlert {
  const _EmergencyAlert(
      {required this.id,
      required this.appointmentId,
      required this.userId,
      required this.userType,
      required this.location,
      required this.message,
      required this.timestamp,
      required this.status,
      required this.priority});
  factory _EmergencyAlert.fromJson(Map<String, dynamic> json) =>
      _$EmergencyAlertFromJson(json);

  @override
  final String id;
  @override
  final String appointmentId;
  @override
  final String userId;
  @override
  final String userType;
  @override
  final ClientLocation location;
  @override
  final String message;
  @override
  final DateTime timestamp;
  @override
  final String status;
  @override
  final String priority;

  /// Create a copy of EmergencyAlert
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$EmergencyAlertCopyWith<_EmergencyAlert> get copyWith =>
      __$EmergencyAlertCopyWithImpl<_EmergencyAlert>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$EmergencyAlertToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _EmergencyAlert &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.appointmentId, appointmentId) ||
                other.appointmentId == appointmentId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.userType, userType) ||
                other.userType == userType) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.priority, priority) ||
                other.priority == priority));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, appointmentId, userId,
      userType, location, message, timestamp, status, priority);

  @override
  String toString() {
    return 'EmergencyAlert(id: $id, appointmentId: $appointmentId, userId: $userId, userType: $userType, location: $location, message: $message, timestamp: $timestamp, status: $status, priority: $priority)';
  }
}

/// @nodoc
abstract mixin class _$EmergencyAlertCopyWith<$Res>
    implements $EmergencyAlertCopyWith<$Res> {
  factory _$EmergencyAlertCopyWith(
          _EmergencyAlert value, $Res Function(_EmergencyAlert) _then) =
      __$EmergencyAlertCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String appointmentId,
      String userId,
      String userType,
      ClientLocation location,
      String message,
      DateTime timestamp,
      String status,
      String priority});

  @override
  $ClientLocationCopyWith<$Res> get location;
}

/// @nodoc
class __$EmergencyAlertCopyWithImpl<$Res>
    implements _$EmergencyAlertCopyWith<$Res> {
  __$EmergencyAlertCopyWithImpl(this._self, this._then);

  final _EmergencyAlert _self;
  final $Res Function(_EmergencyAlert) _then;

  /// Create a copy of EmergencyAlert
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? appointmentId = null,
    Object? userId = null,
    Object? userType = null,
    Object? location = null,
    Object? message = null,
    Object? timestamp = null,
    Object? status = null,
    Object? priority = null,
  }) {
    return _then(_EmergencyAlert(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      appointmentId: null == appointmentId
          ? _self.appointmentId
          : appointmentId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      userType: null == userType
          ? _self.userType
          : userType // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _self.location
          : location // ignore: cast_nullable_to_non_nullable
              as ClientLocation,
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      priority: null == priority
          ? _self.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  /// Create a copy of EmergencyAlert
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ClientLocationCopyWith<$Res> get location {
    return $ClientLocationCopyWith<$Res>(_self.location, (value) {
      return _then(_self.copyWith(location: value));
    });
  }
}

/// @nodoc
mixin _$RealtimePortalDashboard {
  List<AppointmentStatus> get upcomingAppointments;
  LiveLocation? get activeTracking;
  int? get unreadMessages;
  List<PushNotification>? get recentNotifications;
  List<FamilyMember>? get familyMembers;
  ServiceConfirmation? get lastServiceConfirmation;

  /// Create a copy of RealtimePortalDashboard
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RealtimePortalDashboardCopyWith<RealtimePortalDashboard> get copyWith =>
      _$RealtimePortalDashboardCopyWithImpl<RealtimePortalDashboard>(
          this as RealtimePortalDashboard, _$identity);

  /// Serializes this RealtimePortalDashboard to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RealtimePortalDashboard &&
            const DeepCollectionEquality()
                .equals(other.upcomingAppointments, upcomingAppointments) &&
            (identical(other.activeTracking, activeTracking) ||
                other.activeTracking == activeTracking) &&
            (identical(other.unreadMessages, unreadMessages) ||
                other.unreadMessages == unreadMessages) &&
            const DeepCollectionEquality()
                .equals(other.recentNotifications, recentNotifications) &&
            const DeepCollectionEquality()
                .equals(other.familyMembers, familyMembers) &&
            (identical(
                    other.lastServiceConfirmation, lastServiceConfirmation) ||
                other.lastServiceConfirmation == lastServiceConfirmation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(upcomingAppointments),
      activeTracking,
      unreadMessages,
      const DeepCollectionEquality().hash(recentNotifications),
      const DeepCollectionEquality().hash(familyMembers),
      lastServiceConfirmation);

  @override
  String toString() {
    return 'RealtimePortalDashboard(upcomingAppointments: $upcomingAppointments, activeTracking: $activeTracking, unreadMessages: $unreadMessages, recentNotifications: $recentNotifications, familyMembers: $familyMembers, lastServiceConfirmation: $lastServiceConfirmation)';
  }
}

/// @nodoc
abstract mixin class $RealtimePortalDashboardCopyWith<$Res> {
  factory $RealtimePortalDashboardCopyWith(RealtimePortalDashboard value,
          $Res Function(RealtimePortalDashboard) _then) =
      _$RealtimePortalDashboardCopyWithImpl;
  @useResult
  $Res call(
      {List<AppointmentStatus> upcomingAppointments,
      LiveLocation? activeTracking,
      int? unreadMessages,
      List<PushNotification>? recentNotifications,
      List<FamilyMember>? familyMembers,
      ServiceConfirmation? lastServiceConfirmation});

  $LiveLocationCopyWith<$Res>? get activeTracking;
  $ServiceConfirmationCopyWith<$Res>? get lastServiceConfirmation;
}

/// @nodoc
class _$RealtimePortalDashboardCopyWithImpl<$Res>
    implements $RealtimePortalDashboardCopyWith<$Res> {
  _$RealtimePortalDashboardCopyWithImpl(this._self, this._then);

  final RealtimePortalDashboard _self;
  final $Res Function(RealtimePortalDashboard) _then;

  /// Create a copy of RealtimePortalDashboard
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? upcomingAppointments = null,
    Object? activeTracking = freezed,
    Object? unreadMessages = freezed,
    Object? recentNotifications = freezed,
    Object? familyMembers = freezed,
    Object? lastServiceConfirmation = freezed,
  }) {
    return _then(_self.copyWith(
      upcomingAppointments: null == upcomingAppointments
          ? _self.upcomingAppointments
          : upcomingAppointments // ignore: cast_nullable_to_non_nullable
              as List<AppointmentStatus>,
      activeTracking: freezed == activeTracking
          ? _self.activeTracking
          : activeTracking // ignore: cast_nullable_to_non_nullable
              as LiveLocation?,
      unreadMessages: freezed == unreadMessages
          ? _self.unreadMessages
          : unreadMessages // ignore: cast_nullable_to_non_nullable
              as int?,
      recentNotifications: freezed == recentNotifications
          ? _self.recentNotifications
          : recentNotifications // ignore: cast_nullable_to_non_nullable
              as List<PushNotification>?,
      familyMembers: freezed == familyMembers
          ? _self.familyMembers
          : familyMembers // ignore: cast_nullable_to_non_nullable
              as List<FamilyMember>?,
      lastServiceConfirmation: freezed == lastServiceConfirmation
          ? _self.lastServiceConfirmation
          : lastServiceConfirmation // ignore: cast_nullable_to_non_nullable
              as ServiceConfirmation?,
    ));
  }

  /// Create a copy of RealtimePortalDashboard
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LiveLocationCopyWith<$Res>? get activeTracking {
    if (_self.activeTracking == null) {
      return null;
    }

    return $LiveLocationCopyWith<$Res>(_self.activeTracking!, (value) {
      return _then(_self.copyWith(activeTracking: value));
    });
  }

  /// Create a copy of RealtimePortalDashboard
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ServiceConfirmationCopyWith<$Res>? get lastServiceConfirmation {
    if (_self.lastServiceConfirmation == null) {
      return null;
    }

    return $ServiceConfirmationCopyWith<$Res>(_self.lastServiceConfirmation!,
        (value) {
      return _then(_self.copyWith(lastServiceConfirmation: value));
    });
  }
}

/// Adds pattern-matching-related methods to [RealtimePortalDashboard].
extension RealtimePortalDashboardPatterns on RealtimePortalDashboard {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_RealtimePortalDashboard value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RealtimePortalDashboard() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_RealtimePortalDashboard value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RealtimePortalDashboard():
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_RealtimePortalDashboard value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RealtimePortalDashboard() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            List<AppointmentStatus> upcomingAppointments,
            LiveLocation? activeTracking,
            int? unreadMessages,
            List<PushNotification>? recentNotifications,
            List<FamilyMember>? familyMembers,
            ServiceConfirmation? lastServiceConfirmation)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RealtimePortalDashboard() when $default != null:
        return $default(
            _that.upcomingAppointments,
            _that.activeTracking,
            _that.unreadMessages,
            _that.recentNotifications,
            _that.familyMembers,
            _that.lastServiceConfirmation);
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            List<AppointmentStatus> upcomingAppointments,
            LiveLocation? activeTracking,
            int? unreadMessages,
            List<PushNotification>? recentNotifications,
            List<FamilyMember>? familyMembers,
            ServiceConfirmation? lastServiceConfirmation)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RealtimePortalDashboard():
        return $default(
            _that.upcomingAppointments,
            _that.activeTracking,
            _that.unreadMessages,
            _that.recentNotifications,
            _that.familyMembers,
            _that.lastServiceConfirmation);
      case _:
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            List<AppointmentStatus> upcomingAppointments,
            LiveLocation? activeTracking,
            int? unreadMessages,
            List<PushNotification>? recentNotifications,
            List<FamilyMember>? familyMembers,
            ServiceConfirmation? lastServiceConfirmation)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RealtimePortalDashboard() when $default != null:
        return $default(
            _that.upcomingAppointments,
            _that.activeTracking,
            _that.unreadMessages,
            _that.recentNotifications,
            _that.familyMembers,
            _that.lastServiceConfirmation);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _RealtimePortalDashboard implements RealtimePortalDashboard {
  const _RealtimePortalDashboard(
      {required final List<AppointmentStatus> upcomingAppointments,
      this.activeTracking,
      this.unreadMessages,
      final List<PushNotification>? recentNotifications,
      final List<FamilyMember>? familyMembers,
      this.lastServiceConfirmation})
      : _upcomingAppointments = upcomingAppointments,
        _recentNotifications = recentNotifications,
        _familyMembers = familyMembers;
  factory _RealtimePortalDashboard.fromJson(Map<String, dynamic> json) =>
      _$RealtimePortalDashboardFromJson(json);

  final List<AppointmentStatus> _upcomingAppointments;
  @override
  List<AppointmentStatus> get upcomingAppointments {
    if (_upcomingAppointments is EqualUnmodifiableListView)
      return _upcomingAppointments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_upcomingAppointments);
  }

  @override
  final LiveLocation? activeTracking;
  @override
  final int? unreadMessages;
  final List<PushNotification>? _recentNotifications;
  @override
  List<PushNotification>? get recentNotifications {
    final value = _recentNotifications;
    if (value == null) return null;
    if (_recentNotifications is EqualUnmodifiableListView)
      return _recentNotifications;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<FamilyMember>? _familyMembers;
  @override
  List<FamilyMember>? get familyMembers {
    final value = _familyMembers;
    if (value == null) return null;
    if (_familyMembers is EqualUnmodifiableListView) return _familyMembers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final ServiceConfirmation? lastServiceConfirmation;

  /// Create a copy of RealtimePortalDashboard
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RealtimePortalDashboardCopyWith<_RealtimePortalDashboard> get copyWith =>
      __$RealtimePortalDashboardCopyWithImpl<_RealtimePortalDashboard>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$RealtimePortalDashboardToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RealtimePortalDashboard &&
            const DeepCollectionEquality()
                .equals(other._upcomingAppointments, _upcomingAppointments) &&
            (identical(other.activeTracking, activeTracking) ||
                other.activeTracking == activeTracking) &&
            (identical(other.unreadMessages, unreadMessages) ||
                other.unreadMessages == unreadMessages) &&
            const DeepCollectionEquality()
                .equals(other._recentNotifications, _recentNotifications) &&
            const DeepCollectionEquality()
                .equals(other._familyMembers, _familyMembers) &&
            (identical(
                    other.lastServiceConfirmation, lastServiceConfirmation) ||
                other.lastServiceConfirmation == lastServiceConfirmation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_upcomingAppointments),
      activeTracking,
      unreadMessages,
      const DeepCollectionEquality().hash(_recentNotifications),
      const DeepCollectionEquality().hash(_familyMembers),
      lastServiceConfirmation);

  @override
  String toString() {
    return 'RealtimePortalDashboard(upcomingAppointments: $upcomingAppointments, activeTracking: $activeTracking, unreadMessages: $unreadMessages, recentNotifications: $recentNotifications, familyMembers: $familyMembers, lastServiceConfirmation: $lastServiceConfirmation)';
  }
}

/// @nodoc
abstract mixin class _$RealtimePortalDashboardCopyWith<$Res>
    implements $RealtimePortalDashboardCopyWith<$Res> {
  factory _$RealtimePortalDashboardCopyWith(_RealtimePortalDashboard value,
          $Res Function(_RealtimePortalDashboard) _then) =
      __$RealtimePortalDashboardCopyWithImpl;
  @override
  @useResult
  $Res call(
      {List<AppointmentStatus> upcomingAppointments,
      LiveLocation? activeTracking,
      int? unreadMessages,
      List<PushNotification>? recentNotifications,
      List<FamilyMember>? familyMembers,
      ServiceConfirmation? lastServiceConfirmation});

  @override
  $LiveLocationCopyWith<$Res>? get activeTracking;
  @override
  $ServiceConfirmationCopyWith<$Res>? get lastServiceConfirmation;
}

/// @nodoc
class __$RealtimePortalDashboardCopyWithImpl<$Res>
    implements _$RealtimePortalDashboardCopyWith<$Res> {
  __$RealtimePortalDashboardCopyWithImpl(this._self, this._then);

  final _RealtimePortalDashboard _self;
  final $Res Function(_RealtimePortalDashboard) _then;

  /// Create a copy of RealtimePortalDashboard
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? upcomingAppointments = null,
    Object? activeTracking = freezed,
    Object? unreadMessages = freezed,
    Object? recentNotifications = freezed,
    Object? familyMembers = freezed,
    Object? lastServiceConfirmation = freezed,
  }) {
    return _then(_RealtimePortalDashboard(
      upcomingAppointments: null == upcomingAppointments
          ? _self._upcomingAppointments
          : upcomingAppointments // ignore: cast_nullable_to_non_nullable
              as List<AppointmentStatus>,
      activeTracking: freezed == activeTracking
          ? _self.activeTracking
          : activeTracking // ignore: cast_nullable_to_non_nullable
              as LiveLocation?,
      unreadMessages: freezed == unreadMessages
          ? _self.unreadMessages
          : unreadMessages // ignore: cast_nullable_to_non_nullable
              as int?,
      recentNotifications: freezed == recentNotifications
          ? _self._recentNotifications
          : recentNotifications // ignore: cast_nullable_to_non_nullable
              as List<PushNotification>?,
      familyMembers: freezed == familyMembers
          ? _self._familyMembers
          : familyMembers // ignore: cast_nullable_to_non_nullable
              as List<FamilyMember>?,
      lastServiceConfirmation: freezed == lastServiceConfirmation
          ? _self.lastServiceConfirmation
          : lastServiceConfirmation // ignore: cast_nullable_to_non_nullable
              as ServiceConfirmation?,
    ));
  }

  /// Create a copy of RealtimePortalDashboard
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LiveLocationCopyWith<$Res>? get activeTracking {
    if (_self.activeTracking == null) {
      return null;
    }

    return $LiveLocationCopyWith<$Res>(_self.activeTracking!, (value) {
      return _then(_self.copyWith(activeTracking: value));
    });
  }

  /// Create a copy of RealtimePortalDashboard
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ServiceConfirmationCopyWith<$Res>? get lastServiceConfirmation {
    if (_self.lastServiceConfirmation == null) {
      return null;
    }

    return $ServiceConfirmationCopyWith<$Res>(_self.lastServiceConfirmation!,
        (value) {
      return _then(_self.copyWith(lastServiceConfirmation: value));
    });
  }
}

// dart format on
