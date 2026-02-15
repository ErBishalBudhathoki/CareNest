// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'realtime_portal_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LiveLocation _$LiveLocationFromJson(Map<String, dynamic> json) {
  return _LiveLocation.fromJson(json);
}

/// @nodoc
mixin _$LiveLocation {
  String get appointmentId => throw _privateConstructorUsedError;
  String get workerId => throw _privateConstructorUsedError;
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;
  double get accuracy => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  double? get distance => throw _privateConstructorUsedError;
  int? get eta => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LiveLocationCopyWith<LiveLocation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LiveLocationCopyWith<$Res> {
  factory $LiveLocationCopyWith(
          LiveLocation value, $Res Function(LiveLocation) then) =
      _$LiveLocationCopyWithImpl<$Res, LiveLocation>;
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
class _$LiveLocationCopyWithImpl<$Res, $Val extends LiveLocation>
    implements $LiveLocationCopyWith<$Res> {
  _$LiveLocationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      appointmentId: null == appointmentId
          ? _value.appointmentId
          : appointmentId // ignore: cast_nullable_to_non_nullable
              as String,
      workerId: null == workerId
          ? _value.workerId
          : workerId // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      accuracy: null == accuracy
          ? _value.accuracy
          : accuracy // ignore: cast_nullable_to_non_nullable
              as double,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      distance: freezed == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double?,
      eta: freezed == eta
          ? _value.eta
          : eta // ignore: cast_nullable_to_non_nullable
              as int?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LiveLocationImplCopyWith<$Res>
    implements $LiveLocationCopyWith<$Res> {
  factory _$$LiveLocationImplCopyWith(
          _$LiveLocationImpl value, $Res Function(_$LiveLocationImpl) then) =
      __$$LiveLocationImplCopyWithImpl<$Res>;
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
class __$$LiveLocationImplCopyWithImpl<$Res>
    extends _$LiveLocationCopyWithImpl<$Res, _$LiveLocationImpl>
    implements _$$LiveLocationImplCopyWith<$Res> {
  __$$LiveLocationImplCopyWithImpl(
      _$LiveLocationImpl _value, $Res Function(_$LiveLocationImpl) _then)
      : super(_value, _then);

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
    return _then(_$LiveLocationImpl(
      appointmentId: null == appointmentId
          ? _value.appointmentId
          : appointmentId // ignore: cast_nullable_to_non_nullable
              as String,
      workerId: null == workerId
          ? _value.workerId
          : workerId // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      accuracy: null == accuracy
          ? _value.accuracy
          : accuracy // ignore: cast_nullable_to_non_nullable
              as double,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      distance: freezed == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double?,
      eta: freezed == eta
          ? _value.eta
          : eta // ignore: cast_nullable_to_non_nullable
              as int?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LiveLocationImpl implements _LiveLocation {
  const _$LiveLocationImpl(
      {required this.appointmentId,
      required this.workerId,
      required this.latitude,
      required this.longitude,
      required this.accuracy,
      required this.timestamp,
      this.distance,
      this.eta,
      this.status});

  factory _$LiveLocationImpl.fromJson(Map<String, dynamic> json) =>
      _$$LiveLocationImplFromJson(json);

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

  @override
  String toString() {
    return 'LiveLocation(appointmentId: $appointmentId, workerId: $workerId, latitude: $latitude, longitude: $longitude, accuracy: $accuracy, timestamp: $timestamp, distance: $distance, eta: $eta, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LiveLocationImpl &&
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

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, appointmentId, workerId,
      latitude, longitude, accuracy, timestamp, distance, eta, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LiveLocationImplCopyWith<_$LiveLocationImpl> get copyWith =>
      __$$LiveLocationImplCopyWithImpl<_$LiveLocationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LiveLocationImplToJson(
      this,
    );
  }
}

abstract class _LiveLocation implements LiveLocation {
  const factory _LiveLocation(
      {required final String appointmentId,
      required final String workerId,
      required final double latitude,
      required final double longitude,
      required final double accuracy,
      required final DateTime timestamp,
      final double? distance,
      final int? eta,
      final String? status}) = _$LiveLocationImpl;

  factory _LiveLocation.fromJson(Map<String, dynamic> json) =
      _$LiveLocationImpl.fromJson;

  @override
  String get appointmentId;
  @override
  String get workerId;
  @override
  double get latitude;
  @override
  double get longitude;
  @override
  double get accuracy;
  @override
  DateTime get timestamp;
  @override
  double? get distance;
  @override
  int? get eta;
  @override
  String? get status;
  @override
  @JsonKey(ignore: true)
  _$$LiveLocationImplCopyWith<_$LiveLocationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LocationUpdate _$LocationUpdateFromJson(Map<String, dynamic> json) {
  return _LocationUpdate.fromJson(json);
}

/// @nodoc
mixin _$LocationUpdate {
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;
  double get accuracy => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LocationUpdateCopyWith<LocationUpdate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocationUpdateCopyWith<$Res> {
  factory $LocationUpdateCopyWith(
          LocationUpdate value, $Res Function(LocationUpdate) then) =
      _$LocationUpdateCopyWithImpl<$Res, LocationUpdate>;
  @useResult
  $Res call(
      {double latitude, double longitude, double accuracy, DateTime timestamp});
}

/// @nodoc
class _$LocationUpdateCopyWithImpl<$Res, $Val extends LocationUpdate>
    implements $LocationUpdateCopyWith<$Res> {
  _$LocationUpdateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? latitude = null,
    Object? longitude = null,
    Object? accuracy = null,
    Object? timestamp = null,
  }) {
    return _then(_value.copyWith(
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      accuracy: null == accuracy
          ? _value.accuracy
          : accuracy // ignore: cast_nullable_to_non_nullable
              as double,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LocationUpdateImplCopyWith<$Res>
    implements $LocationUpdateCopyWith<$Res> {
  factory _$$LocationUpdateImplCopyWith(_$LocationUpdateImpl value,
          $Res Function(_$LocationUpdateImpl) then) =
      __$$LocationUpdateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double latitude, double longitude, double accuracy, DateTime timestamp});
}

/// @nodoc
class __$$LocationUpdateImplCopyWithImpl<$Res>
    extends _$LocationUpdateCopyWithImpl<$Res, _$LocationUpdateImpl>
    implements _$$LocationUpdateImplCopyWith<$Res> {
  __$$LocationUpdateImplCopyWithImpl(
      _$LocationUpdateImpl _value, $Res Function(_$LocationUpdateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? latitude = null,
    Object? longitude = null,
    Object? accuracy = null,
    Object? timestamp = null,
  }) {
    return _then(_$LocationUpdateImpl(
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      accuracy: null == accuracy
          ? _value.accuracy
          : accuracy // ignore: cast_nullable_to_non_nullable
              as double,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LocationUpdateImpl implements _LocationUpdate {
  const _$LocationUpdateImpl(
      {required this.latitude,
      required this.longitude,
      required this.accuracy,
      required this.timestamp});

  factory _$LocationUpdateImpl.fromJson(Map<String, dynamic> json) =>
      _$$LocationUpdateImplFromJson(json);

  @override
  final double latitude;
  @override
  final double longitude;
  @override
  final double accuracy;
  @override
  final DateTime timestamp;

  @override
  String toString() {
    return 'LocationUpdate(latitude: $latitude, longitude: $longitude, accuracy: $accuracy, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocationUpdateImpl &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.accuracy, accuracy) ||
                other.accuracy == accuracy) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, latitude, longitude, accuracy, timestamp);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LocationUpdateImplCopyWith<_$LocationUpdateImpl> get copyWith =>
      __$$LocationUpdateImplCopyWithImpl<_$LocationUpdateImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LocationUpdateImplToJson(
      this,
    );
  }
}

abstract class _LocationUpdate implements LocationUpdate {
  const factory _LocationUpdate(
      {required final double latitude,
      required final double longitude,
      required final double accuracy,
      required final DateTime timestamp}) = _$LocationUpdateImpl;

  factory _LocationUpdate.fromJson(Map<String, dynamic> json) =
      _$LocationUpdateImpl.fromJson;

  @override
  double get latitude;
  @override
  double get longitude;
  @override
  double get accuracy;
  @override
  DateTime get timestamp;
  @override
  @JsonKey(ignore: true)
  _$$LocationUpdateImplCopyWith<_$LocationUpdateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GeofenceEvent _$GeofenceEventFromJson(Map<String, dynamic> json) {
  return _GeofenceEvent.fromJson(json);
}

/// @nodoc
mixin _$GeofenceEvent {
  String get appointmentId => throw _privateConstructorUsedError;
  String get event =>
      throw _privateConstructorUsedError; // 'approaching', 'arrived', 'departed'
  double get distance => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  bool? get insideGeofence => throw _privateConstructorUsedError;
  bool? get approaching => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GeofenceEventCopyWith<GeofenceEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GeofenceEventCopyWith<$Res> {
  factory $GeofenceEventCopyWith(
          GeofenceEvent value, $Res Function(GeofenceEvent) then) =
      _$GeofenceEventCopyWithImpl<$Res, GeofenceEvent>;
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
class _$GeofenceEventCopyWithImpl<$Res, $Val extends GeofenceEvent>
    implements $GeofenceEventCopyWith<$Res> {
  _$GeofenceEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      appointmentId: null == appointmentId
          ? _value.appointmentId
          : appointmentId // ignore: cast_nullable_to_non_nullable
              as String,
      event: null == event
          ? _value.event
          : event // ignore: cast_nullable_to_non_nullable
              as String,
      distance: null == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      insideGeofence: freezed == insideGeofence
          ? _value.insideGeofence
          : insideGeofence // ignore: cast_nullable_to_non_nullable
              as bool?,
      approaching: freezed == approaching
          ? _value.approaching
          : approaching // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GeofenceEventImplCopyWith<$Res>
    implements $GeofenceEventCopyWith<$Res> {
  factory _$$GeofenceEventImplCopyWith(
          _$GeofenceEventImpl value, $Res Function(_$GeofenceEventImpl) then) =
      __$$GeofenceEventImplCopyWithImpl<$Res>;
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
class __$$GeofenceEventImplCopyWithImpl<$Res>
    extends _$GeofenceEventCopyWithImpl<$Res, _$GeofenceEventImpl>
    implements _$$GeofenceEventImplCopyWith<$Res> {
  __$$GeofenceEventImplCopyWithImpl(
      _$GeofenceEventImpl _value, $Res Function(_$GeofenceEventImpl) _then)
      : super(_value, _then);

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
    return _then(_$GeofenceEventImpl(
      appointmentId: null == appointmentId
          ? _value.appointmentId
          : appointmentId // ignore: cast_nullable_to_non_nullable
              as String,
      event: null == event
          ? _value.event
          : event // ignore: cast_nullable_to_non_nullable
              as String,
      distance: null == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      insideGeofence: freezed == insideGeofence
          ? _value.insideGeofence
          : insideGeofence // ignore: cast_nullable_to_non_nullable
              as bool?,
      approaching: freezed == approaching
          ? _value.approaching
          : approaching // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GeofenceEventImpl implements _GeofenceEvent {
  const _$GeofenceEventImpl(
      {required this.appointmentId,
      required this.event,
      required this.distance,
      required this.timestamp,
      this.insideGeofence,
      this.approaching});

  factory _$GeofenceEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$GeofenceEventImplFromJson(json);

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

  @override
  String toString() {
    return 'GeofenceEvent(appointmentId: $appointmentId, event: $event, distance: $distance, timestamp: $timestamp, insideGeofence: $insideGeofence, approaching: $approaching)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GeofenceEventImpl &&
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

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, appointmentId, event, distance,
      timestamp, insideGeofence, approaching);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GeofenceEventImplCopyWith<_$GeofenceEventImpl> get copyWith =>
      __$$GeofenceEventImplCopyWithImpl<_$GeofenceEventImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GeofenceEventImplToJson(
      this,
    );
  }
}

abstract class _GeofenceEvent implements GeofenceEvent {
  const factory _GeofenceEvent(
      {required final String appointmentId,
      required final String event,
      required final double distance,
      required final DateTime timestamp,
      final bool? insideGeofence,
      final bool? approaching}) = _$GeofenceEventImpl;

  factory _GeofenceEvent.fromJson(Map<String, dynamic> json) =
      _$GeofenceEventImpl.fromJson;

  @override
  String get appointmentId;
  @override
  String get event;
  @override // 'approaching', 'arrived', 'departed'
  double get distance;
  @override
  DateTime get timestamp;
  @override
  bool? get insideGeofence;
  @override
  bool? get approaching;
  @override
  @JsonKey(ignore: true)
  _$$GeofenceEventImplCopyWith<_$GeofenceEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TrackingSession _$TrackingSessionFromJson(Map<String, dynamic> json) {
  return _TrackingSession.fromJson(json);
}

/// @nodoc
mixin _$TrackingSession {
  String get sessionId => throw _privateConstructorUsedError;
  String get appointmentId => throw _privateConstructorUsedError;
  String get workerId => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  DateTime get startTime => throw _privateConstructorUsedError;
  DateTime? get endTime => throw _privateConstructorUsedError;
  ClientLocation? get clientLocation => throw _privateConstructorUsedError;
  List<LocationUpdate>? get locations => throw _privateConstructorUsedError;
  int? get duration => throw _privateConstructorUsedError;
  double? get totalDistance => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TrackingSessionCopyWith<TrackingSession> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrackingSessionCopyWith<$Res> {
  factory $TrackingSessionCopyWith(
          TrackingSession value, $Res Function(TrackingSession) then) =
      _$TrackingSessionCopyWithImpl<$Res, TrackingSession>;
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
class _$TrackingSessionCopyWithImpl<$Res, $Val extends TrackingSession>
    implements $TrackingSessionCopyWith<$Res> {
  _$TrackingSessionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      sessionId: null == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String,
      appointmentId: null == appointmentId
          ? _value.appointmentId
          : appointmentId // ignore: cast_nullable_to_non_nullable
              as String,
      workerId: null == workerId
          ? _value.workerId
          : workerId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: freezed == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      clientLocation: freezed == clientLocation
          ? _value.clientLocation
          : clientLocation // ignore: cast_nullable_to_non_nullable
              as ClientLocation?,
      locations: freezed == locations
          ? _value.locations
          : locations // ignore: cast_nullable_to_non_nullable
              as List<LocationUpdate>?,
      duration: freezed == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int?,
      totalDistance: freezed == totalDistance
          ? _value.totalDistance
          : totalDistance // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ClientLocationCopyWith<$Res>? get clientLocation {
    if (_value.clientLocation == null) {
      return null;
    }

    return $ClientLocationCopyWith<$Res>(_value.clientLocation!, (value) {
      return _then(_value.copyWith(clientLocation: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TrackingSessionImplCopyWith<$Res>
    implements $TrackingSessionCopyWith<$Res> {
  factory _$$TrackingSessionImplCopyWith(_$TrackingSessionImpl value,
          $Res Function(_$TrackingSessionImpl) then) =
      __$$TrackingSessionImplCopyWithImpl<$Res>;
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
class __$$TrackingSessionImplCopyWithImpl<$Res>
    extends _$TrackingSessionCopyWithImpl<$Res, _$TrackingSessionImpl>
    implements _$$TrackingSessionImplCopyWith<$Res> {
  __$$TrackingSessionImplCopyWithImpl(
      _$TrackingSessionImpl _value, $Res Function(_$TrackingSessionImpl) _then)
      : super(_value, _then);

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
    return _then(_$TrackingSessionImpl(
      sessionId: null == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String,
      appointmentId: null == appointmentId
          ? _value.appointmentId
          : appointmentId // ignore: cast_nullable_to_non_nullable
              as String,
      workerId: null == workerId
          ? _value.workerId
          : workerId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: freezed == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      clientLocation: freezed == clientLocation
          ? _value.clientLocation
          : clientLocation // ignore: cast_nullable_to_non_nullable
              as ClientLocation?,
      locations: freezed == locations
          ? _value._locations
          : locations // ignore: cast_nullable_to_non_nullable
              as List<LocationUpdate>?,
      duration: freezed == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int?,
      totalDistance: freezed == totalDistance
          ? _value.totalDistance
          : totalDistance // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TrackingSessionImpl implements _TrackingSession {
  const _$TrackingSessionImpl(
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

  factory _$TrackingSessionImpl.fromJson(Map<String, dynamic> json) =>
      _$$TrackingSessionImplFromJson(json);

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

  @override
  String toString() {
    return 'TrackingSession(sessionId: $sessionId, appointmentId: $appointmentId, workerId: $workerId, status: $status, startTime: $startTime, endTime: $endTime, clientLocation: $clientLocation, locations: $locations, duration: $duration, totalDistance: $totalDistance)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TrackingSessionImpl &&
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

  @JsonKey(ignore: true)
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

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TrackingSessionImplCopyWith<_$TrackingSessionImpl> get copyWith =>
      __$$TrackingSessionImplCopyWithImpl<_$TrackingSessionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TrackingSessionImplToJson(
      this,
    );
  }
}

abstract class _TrackingSession implements TrackingSession {
  const factory _TrackingSession(
      {required final String sessionId,
      required final String appointmentId,
      required final String workerId,
      required final String status,
      required final DateTime startTime,
      final DateTime? endTime,
      final ClientLocation? clientLocation,
      final List<LocationUpdate>? locations,
      final int? duration,
      final double? totalDistance}) = _$TrackingSessionImpl;

  factory _TrackingSession.fromJson(Map<String, dynamic> json) =
      _$TrackingSessionImpl.fromJson;

  @override
  String get sessionId;
  @override
  String get appointmentId;
  @override
  String get workerId;
  @override
  String get status;
  @override
  DateTime get startTime;
  @override
  DateTime? get endTime;
  @override
  ClientLocation? get clientLocation;
  @override
  List<LocationUpdate>? get locations;
  @override
  int? get duration;
  @override
  double? get totalDistance;
  @override
  @JsonKey(ignore: true)
  _$$TrackingSessionImplCopyWith<_$TrackingSessionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ClientLocation _$ClientLocationFromJson(Map<String, dynamic> json) {
  return _ClientLocation.fromJson(json);
}

/// @nodoc
mixin _$ClientLocation {
  double get lat => throw _privateConstructorUsedError;
  double get lng => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ClientLocationCopyWith<ClientLocation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClientLocationCopyWith<$Res> {
  factory $ClientLocationCopyWith(
          ClientLocation value, $Res Function(ClientLocation) then) =
      _$ClientLocationCopyWithImpl<$Res, ClientLocation>;
  @useResult
  $Res call({double lat, double lng, String? address});
}

/// @nodoc
class _$ClientLocationCopyWithImpl<$Res, $Val extends ClientLocation>
    implements $ClientLocationCopyWith<$Res> {
  _$ClientLocationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lat = null,
    Object? lng = null,
    Object? address = freezed,
  }) {
    return _then(_value.copyWith(
      lat: null == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double,
      lng: null == lng
          ? _value.lng
          : lng // ignore: cast_nullable_to_non_nullable
              as double,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ClientLocationImplCopyWith<$Res>
    implements $ClientLocationCopyWith<$Res> {
  factory _$$ClientLocationImplCopyWith(_$ClientLocationImpl value,
          $Res Function(_$ClientLocationImpl) then) =
      __$$ClientLocationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double lat, double lng, String? address});
}

/// @nodoc
class __$$ClientLocationImplCopyWithImpl<$Res>
    extends _$ClientLocationCopyWithImpl<$Res, _$ClientLocationImpl>
    implements _$$ClientLocationImplCopyWith<$Res> {
  __$$ClientLocationImplCopyWithImpl(
      _$ClientLocationImpl _value, $Res Function(_$ClientLocationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lat = null,
    Object? lng = null,
    Object? address = freezed,
  }) {
    return _then(_$ClientLocationImpl(
      lat: null == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double,
      lng: null == lng
          ? _value.lng
          : lng // ignore: cast_nullable_to_non_nullable
              as double,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ClientLocationImpl implements _ClientLocation {
  const _$ClientLocationImpl(
      {required this.lat, required this.lng, this.address});

  factory _$ClientLocationImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClientLocationImplFromJson(json);

  @override
  final double lat;
  @override
  final double lng;
  @override
  final String? address;

  @override
  String toString() {
    return 'ClientLocation(lat: $lat, lng: $lng, address: $address)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClientLocationImpl &&
            (identical(other.lat, lat) || other.lat == lat) &&
            (identical(other.lng, lng) || other.lng == lng) &&
            (identical(other.address, address) || other.address == address));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, lat, lng, address);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ClientLocationImplCopyWith<_$ClientLocationImpl> get copyWith =>
      __$$ClientLocationImplCopyWithImpl<_$ClientLocationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClientLocationImplToJson(
      this,
    );
  }
}

abstract class _ClientLocation implements ClientLocation {
  const factory _ClientLocation(
      {required final double lat,
      required final double lng,
      final String? address}) = _$ClientLocationImpl;

  factory _ClientLocation.fromJson(Map<String, dynamic> json) =
      _$ClientLocationImpl.fromJson;

  @override
  double get lat;
  @override
  double get lng;
  @override
  String? get address;
  @override
  @JsonKey(ignore: true)
  _$$ClientLocationImplCopyWith<_$ClientLocationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ETACalculation _$ETACalculationFromJson(Map<String, dynamic> json) {
  return _ETACalculation.fromJson(json);
}

/// @nodoc
mixin _$ETACalculation {
  int get minutes => throw _privateConstructorUsedError;
  double get distance => throw _privateConstructorUsedError;
  double get avgSpeed => throw _privateConstructorUsedError;
  DateTime get estimatedArrival => throw _privateConstructorUsedError;
  String? get trafficCondition => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ETACalculationCopyWith<ETACalculation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ETACalculationCopyWith<$Res> {
  factory $ETACalculationCopyWith(
          ETACalculation value, $Res Function(ETACalculation) then) =
      _$ETACalculationCopyWithImpl<$Res, ETACalculation>;
  @useResult
  $Res call(
      {int minutes,
      double distance,
      double avgSpeed,
      DateTime estimatedArrival,
      String? trafficCondition});
}

/// @nodoc
class _$ETACalculationCopyWithImpl<$Res, $Val extends ETACalculation>
    implements $ETACalculationCopyWith<$Res> {
  _$ETACalculationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? minutes = null,
    Object? distance = null,
    Object? avgSpeed = null,
    Object? estimatedArrival = null,
    Object? trafficCondition = freezed,
  }) {
    return _then(_value.copyWith(
      minutes: null == minutes
          ? _value.minutes
          : minutes // ignore: cast_nullable_to_non_nullable
              as int,
      distance: null == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double,
      avgSpeed: null == avgSpeed
          ? _value.avgSpeed
          : avgSpeed // ignore: cast_nullable_to_non_nullable
              as double,
      estimatedArrival: null == estimatedArrival
          ? _value.estimatedArrival
          : estimatedArrival // ignore: cast_nullable_to_non_nullable
              as DateTime,
      trafficCondition: freezed == trafficCondition
          ? _value.trafficCondition
          : trafficCondition // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ETACalculationImplCopyWith<$Res>
    implements $ETACalculationCopyWith<$Res> {
  factory _$$ETACalculationImplCopyWith(_$ETACalculationImpl value,
          $Res Function(_$ETACalculationImpl) then) =
      __$$ETACalculationImplCopyWithImpl<$Res>;
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
class __$$ETACalculationImplCopyWithImpl<$Res>
    extends _$ETACalculationCopyWithImpl<$Res, _$ETACalculationImpl>
    implements _$$ETACalculationImplCopyWith<$Res> {
  __$$ETACalculationImplCopyWithImpl(
      _$ETACalculationImpl _value, $Res Function(_$ETACalculationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? minutes = null,
    Object? distance = null,
    Object? avgSpeed = null,
    Object? estimatedArrival = null,
    Object? trafficCondition = freezed,
  }) {
    return _then(_$ETACalculationImpl(
      minutes: null == minutes
          ? _value.minutes
          : minutes // ignore: cast_nullable_to_non_nullable
              as int,
      distance: null == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double,
      avgSpeed: null == avgSpeed
          ? _value.avgSpeed
          : avgSpeed // ignore: cast_nullable_to_non_nullable
              as double,
      estimatedArrival: null == estimatedArrival
          ? _value.estimatedArrival
          : estimatedArrival // ignore: cast_nullable_to_non_nullable
              as DateTime,
      trafficCondition: freezed == trafficCondition
          ? _value.trafficCondition
          : trafficCondition // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ETACalculationImpl implements _ETACalculation {
  const _$ETACalculationImpl(
      {required this.minutes,
      required this.distance,
      required this.avgSpeed,
      required this.estimatedArrival,
      this.trafficCondition});

  factory _$ETACalculationImpl.fromJson(Map<String, dynamic> json) =>
      _$$ETACalculationImplFromJson(json);

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

  @override
  String toString() {
    return 'ETACalculation(minutes: $minutes, distance: $distance, avgSpeed: $avgSpeed, estimatedArrival: $estimatedArrival, trafficCondition: $trafficCondition)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ETACalculationImpl &&
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

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, minutes, distance, avgSpeed,
      estimatedArrival, trafficCondition);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ETACalculationImplCopyWith<_$ETACalculationImpl> get copyWith =>
      __$$ETACalculationImplCopyWithImpl<_$ETACalculationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ETACalculationImplToJson(
      this,
    );
  }
}

abstract class _ETACalculation implements ETACalculation {
  const factory _ETACalculation(
      {required final int minutes,
      required final double distance,
      required final double avgSpeed,
      required final DateTime estimatedArrival,
      final String? trafficCondition}) = _$ETACalculationImpl;

  factory _ETACalculation.fromJson(Map<String, dynamic> json) =
      _$ETACalculationImpl.fromJson;

  @override
  int get minutes;
  @override
  double get distance;
  @override
  double get avgSpeed;
  @override
  DateTime get estimatedArrival;
  @override
  String? get trafficCondition;
  @override
  @JsonKey(ignore: true)
  _$$ETACalculationImplCopyWith<_$ETACalculationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AppointmentStatus _$AppointmentStatusFromJson(Map<String, dynamic> json) {
  return _AppointmentStatus.fromJson(json);
}

/// @nodoc
mixin _$AppointmentStatus {
  String get appointmentId => throw _privateConstructorUsedError;
  String get status =>
      throw _privateConstructorUsedError; // 'scheduled', 'en_route', 'arrived', 'in_progress', 'completed'
  int get progress => throw _privateConstructorUsedError; // 0-100
  String? get notes => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppointmentStatusCopyWith<AppointmentStatus> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppointmentStatusCopyWith<$Res> {
  factory $AppointmentStatusCopyWith(
          AppointmentStatus value, $Res Function(AppointmentStatus) then) =
      _$AppointmentStatusCopyWithImpl<$Res, AppointmentStatus>;
  @useResult
  $Res call(
      {String appointmentId,
      String status,
      int progress,
      String? notes,
      DateTime timestamp});
}

/// @nodoc
class _$AppointmentStatusCopyWithImpl<$Res, $Val extends AppointmentStatus>
    implements $AppointmentStatusCopyWith<$Res> {
  _$AppointmentStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appointmentId = null,
    Object? status = null,
    Object? progress = null,
    Object? notes = freezed,
    Object? timestamp = null,
  }) {
    return _then(_value.copyWith(
      appointmentId: null == appointmentId
          ? _value.appointmentId
          : appointmentId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as int,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppointmentStatusImplCopyWith<$Res>
    implements $AppointmentStatusCopyWith<$Res> {
  factory _$$AppointmentStatusImplCopyWith(_$AppointmentStatusImpl value,
          $Res Function(_$AppointmentStatusImpl) then) =
      __$$AppointmentStatusImplCopyWithImpl<$Res>;
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
class __$$AppointmentStatusImplCopyWithImpl<$Res>
    extends _$AppointmentStatusCopyWithImpl<$Res, _$AppointmentStatusImpl>
    implements _$$AppointmentStatusImplCopyWith<$Res> {
  __$$AppointmentStatusImplCopyWithImpl(_$AppointmentStatusImpl _value,
      $Res Function(_$AppointmentStatusImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appointmentId = null,
    Object? status = null,
    Object? progress = null,
    Object? notes = freezed,
    Object? timestamp = null,
  }) {
    return _then(_$AppointmentStatusImpl(
      appointmentId: null == appointmentId
          ? _value.appointmentId
          : appointmentId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as int,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppointmentStatusImpl implements _AppointmentStatus {
  const _$AppointmentStatusImpl(
      {required this.appointmentId,
      required this.status,
      required this.progress,
      this.notes,
      required this.timestamp});

  factory _$AppointmentStatusImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppointmentStatusImplFromJson(json);

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

  @override
  String toString() {
    return 'AppointmentStatus(appointmentId: $appointmentId, status: $status, progress: $progress, notes: $notes, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppointmentStatusImpl &&
            (identical(other.appointmentId, appointmentId) ||
                other.appointmentId == appointmentId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.progress, progress) ||
                other.progress == progress) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, appointmentId, status, progress, notes, timestamp);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppointmentStatusImplCopyWith<_$AppointmentStatusImpl> get copyWith =>
      __$$AppointmentStatusImplCopyWithImpl<_$AppointmentStatusImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppointmentStatusImplToJson(
      this,
    );
  }
}

abstract class _AppointmentStatus implements AppointmentStatus {
  const factory _AppointmentStatus(
      {required final String appointmentId,
      required final String status,
      required final int progress,
      final String? notes,
      required final DateTime timestamp}) = _$AppointmentStatusImpl;

  factory _AppointmentStatus.fromJson(Map<String, dynamic> json) =
      _$AppointmentStatusImpl.fromJson;

  @override
  String get appointmentId;
  @override
  String get status;
  @override // 'scheduled', 'en_route', 'arrived', 'in_progress', 'completed'
  int get progress;
  @override // 0-100
  String? get notes;
  @override
  DateTime get timestamp;
  @override
  @JsonKey(ignore: true)
  _$$AppointmentStatusImplCopyWith<_$AppointmentStatusImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ServiceProgress _$ServiceProgressFromJson(Map<String, dynamic> json) {
  return _ServiceProgress.fromJson(json);
}

/// @nodoc
mixin _$ServiceProgress {
  String get appointmentId => throw _privateConstructorUsedError;
  int get progress => throw _privateConstructorUsedError;
  List<ProgressStep> get steps => throw _privateConstructorUsedError;
  String? get currentStep => throw _privateConstructorUsedError;
  DateTime? get startTime => throw _privateConstructorUsedError;
  DateTime? get estimatedCompletion => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ServiceProgressCopyWith<ServiceProgress> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ServiceProgressCopyWith<$Res> {
  factory $ServiceProgressCopyWith(
          ServiceProgress value, $Res Function(ServiceProgress) then) =
      _$ServiceProgressCopyWithImpl<$Res, ServiceProgress>;
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
class _$ServiceProgressCopyWithImpl<$Res, $Val extends ServiceProgress>
    implements $ServiceProgressCopyWith<$Res> {
  _$ServiceProgressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      appointmentId: null == appointmentId
          ? _value.appointmentId
          : appointmentId // ignore: cast_nullable_to_non_nullable
              as String,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as int,
      steps: null == steps
          ? _value.steps
          : steps // ignore: cast_nullable_to_non_nullable
              as List<ProgressStep>,
      currentStep: freezed == currentStep
          ? _value.currentStep
          : currentStep // ignore: cast_nullable_to_non_nullable
              as String?,
      startTime: freezed == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      estimatedCompletion: freezed == estimatedCompletion
          ? _value.estimatedCompletion
          : estimatedCompletion // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ServiceProgressImplCopyWith<$Res>
    implements $ServiceProgressCopyWith<$Res> {
  factory _$$ServiceProgressImplCopyWith(_$ServiceProgressImpl value,
          $Res Function(_$ServiceProgressImpl) then) =
      __$$ServiceProgressImplCopyWithImpl<$Res>;
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
class __$$ServiceProgressImplCopyWithImpl<$Res>
    extends _$ServiceProgressCopyWithImpl<$Res, _$ServiceProgressImpl>
    implements _$$ServiceProgressImplCopyWith<$Res> {
  __$$ServiceProgressImplCopyWithImpl(
      _$ServiceProgressImpl _value, $Res Function(_$ServiceProgressImpl) _then)
      : super(_value, _then);

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
    return _then(_$ServiceProgressImpl(
      appointmentId: null == appointmentId
          ? _value.appointmentId
          : appointmentId // ignore: cast_nullable_to_non_nullable
              as String,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as int,
      steps: null == steps
          ? _value._steps
          : steps // ignore: cast_nullable_to_non_nullable
              as List<ProgressStep>,
      currentStep: freezed == currentStep
          ? _value.currentStep
          : currentStep // ignore: cast_nullable_to_non_nullable
              as String?,
      startTime: freezed == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      estimatedCompletion: freezed == estimatedCompletion
          ? _value.estimatedCompletion
          : estimatedCompletion // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ServiceProgressImpl implements _ServiceProgress {
  const _$ServiceProgressImpl(
      {required this.appointmentId,
      required this.progress,
      required final List<ProgressStep> steps,
      this.currentStep,
      this.startTime,
      this.estimatedCompletion})
      : _steps = steps;

  factory _$ServiceProgressImpl.fromJson(Map<String, dynamic> json) =>
      _$$ServiceProgressImplFromJson(json);

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

  @override
  String toString() {
    return 'ServiceProgress(appointmentId: $appointmentId, progress: $progress, steps: $steps, currentStep: $currentStep, startTime: $startTime, estimatedCompletion: $estimatedCompletion)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServiceProgressImpl &&
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

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      appointmentId,
      progress,
      const DeepCollectionEquality().hash(_steps),
      currentStep,
      startTime,
      estimatedCompletion);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ServiceProgressImplCopyWith<_$ServiceProgressImpl> get copyWith =>
      __$$ServiceProgressImplCopyWithImpl<_$ServiceProgressImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ServiceProgressImplToJson(
      this,
    );
  }
}

abstract class _ServiceProgress implements ServiceProgress {
  const factory _ServiceProgress(
      {required final String appointmentId,
      required final int progress,
      required final List<ProgressStep> steps,
      final String? currentStep,
      final DateTime? startTime,
      final DateTime? estimatedCompletion}) = _$ServiceProgressImpl;

  factory _ServiceProgress.fromJson(Map<String, dynamic> json) =
      _$ServiceProgressImpl.fromJson;

  @override
  String get appointmentId;
  @override
  int get progress;
  @override
  List<ProgressStep> get steps;
  @override
  String? get currentStep;
  @override
  DateTime? get startTime;
  @override
  DateTime? get estimatedCompletion;
  @override
  @JsonKey(ignore: true)
  _$$ServiceProgressImplCopyWith<_$ServiceProgressImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ProgressStep _$ProgressStepFromJson(Map<String, dynamic> json) {
  return _ProgressStep.fromJson(json);
}

/// @nodoc
mixin _$ProgressStep {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  bool get completed => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProgressStepCopyWith<ProgressStep> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProgressStepCopyWith<$Res> {
  factory $ProgressStepCopyWith(
          ProgressStep value, $Res Function(ProgressStep) then) =
      _$ProgressStepCopyWithImpl<$Res, ProgressStep>;
  @useResult
  $Res call({String id, String name, bool completed, DateTime? completedAt});
}

/// @nodoc
class _$ProgressStepCopyWithImpl<$Res, $Val extends ProgressStep>
    implements $ProgressStepCopyWith<$Res> {
  _$ProgressStepCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? completed = null,
    Object? completedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      completed: null == completed
          ? _value.completed
          : completed // ignore: cast_nullable_to_non_nullable
              as bool,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProgressStepImplCopyWith<$Res>
    implements $ProgressStepCopyWith<$Res> {
  factory _$$ProgressStepImplCopyWith(
          _$ProgressStepImpl value, $Res Function(_$ProgressStepImpl) then) =
      __$$ProgressStepImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, bool completed, DateTime? completedAt});
}

/// @nodoc
class __$$ProgressStepImplCopyWithImpl<$Res>
    extends _$ProgressStepCopyWithImpl<$Res, _$ProgressStepImpl>
    implements _$$ProgressStepImplCopyWith<$Res> {
  __$$ProgressStepImplCopyWithImpl(
      _$ProgressStepImpl _value, $Res Function(_$ProgressStepImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? completed = null,
    Object? completedAt = freezed,
  }) {
    return _then(_$ProgressStepImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      completed: null == completed
          ? _value.completed
          : completed // ignore: cast_nullable_to_non_nullable
              as bool,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProgressStepImpl implements _ProgressStep {
  const _$ProgressStepImpl(
      {required this.id,
      required this.name,
      required this.completed,
      this.completedAt});

  factory _$ProgressStepImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProgressStepImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final bool completed;
  @override
  final DateTime? completedAt;

  @override
  String toString() {
    return 'ProgressStep(id: $id, name: $name, completed: $completed, completedAt: $completedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProgressStepImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.completed, completed) ||
                other.completed == completed) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, completed, completedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProgressStepImplCopyWith<_$ProgressStepImpl> get copyWith =>
      __$$ProgressStepImplCopyWithImpl<_$ProgressStepImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProgressStepImplToJson(
      this,
    );
  }
}

abstract class _ProgressStep implements ProgressStep {
  const factory _ProgressStep(
      {required final String id,
      required final String name,
      required final bool completed,
      final DateTime? completedAt}) = _$ProgressStepImpl;

  factory _ProgressStep.fromJson(Map<String, dynamic> json) =
      _$ProgressStepImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  bool get completed;
  @override
  DateTime? get completedAt;
  @override
  @JsonKey(ignore: true)
  _$$ProgressStepImplCopyWith<_$ProgressStepImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SecureMessage _$SecureMessageFromJson(Map<String, dynamic> json) {
  return _SecureMessage.fromJson(json);
}

/// @nodoc
mixin _$SecureMessage {
  String get id => throw _privateConstructorUsedError;
  String get conversationId => throw _privateConstructorUsedError;
  String get senderId => throw _privateConstructorUsedError;
  String get senderType => throw _privateConstructorUsedError;
  String get senderName => throw _privateConstructorUsedError;
  String get recipientId => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  List<MessageAttachment>? get attachments =>
      throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  bool get read => throw _privateConstructorUsedError;
  DateTime? get readAt => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SecureMessageCopyWith<SecureMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SecureMessageCopyWith<$Res> {
  factory $SecureMessageCopyWith(
          SecureMessage value, $Res Function(SecureMessage) then) =
      _$SecureMessageCopyWithImpl<$Res, SecureMessage>;
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
class _$SecureMessageCopyWithImpl<$Res, $Val extends SecureMessage>
    implements $SecureMessageCopyWith<$Res> {
  _$SecureMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      conversationId: null == conversationId
          ? _value.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
              as String,
      senderId: null == senderId
          ? _value.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as String,
      senderType: null == senderType
          ? _value.senderType
          : senderType // ignore: cast_nullable_to_non_nullable
              as String,
      senderName: null == senderName
          ? _value.senderName
          : senderName // ignore: cast_nullable_to_non_nullable
              as String,
      recipientId: null == recipientId
          ? _value.recipientId
          : recipientId // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      attachments: freezed == attachments
          ? _value.attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<MessageAttachment>?,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      read: null == read
          ? _value.read
          : read // ignore: cast_nullable_to_non_nullable
              as bool,
      readAt: freezed == readAt
          ? _value.readAt
          : readAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SecureMessageImplCopyWith<$Res>
    implements $SecureMessageCopyWith<$Res> {
  factory _$$SecureMessageImplCopyWith(
          _$SecureMessageImpl value, $Res Function(_$SecureMessageImpl) then) =
      __$$SecureMessageImplCopyWithImpl<$Res>;
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
class __$$SecureMessageImplCopyWithImpl<$Res>
    extends _$SecureMessageCopyWithImpl<$Res, _$SecureMessageImpl>
    implements _$$SecureMessageImplCopyWith<$Res> {
  __$$SecureMessageImplCopyWithImpl(
      _$SecureMessageImpl _value, $Res Function(_$SecureMessageImpl) _then)
      : super(_value, _then);

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
    return _then(_$SecureMessageImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      conversationId: null == conversationId
          ? _value.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
              as String,
      senderId: null == senderId
          ? _value.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as String,
      senderType: null == senderType
          ? _value.senderType
          : senderType // ignore: cast_nullable_to_non_nullable
              as String,
      senderName: null == senderName
          ? _value.senderName
          : senderName // ignore: cast_nullable_to_non_nullable
              as String,
      recipientId: null == recipientId
          ? _value.recipientId
          : recipientId // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      attachments: freezed == attachments
          ? _value._attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<MessageAttachment>?,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      read: null == read
          ? _value.read
          : read // ignore: cast_nullable_to_non_nullable
              as bool,
      readAt: freezed == readAt
          ? _value.readAt
          : readAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SecureMessageImpl implements _SecureMessage {
  const _$SecureMessageImpl(
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

  factory _$SecureMessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$SecureMessageImplFromJson(json);

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

  @override
  String toString() {
    return 'SecureMessage(id: $id, conversationId: $conversationId, senderId: $senderId, senderType: $senderType, senderName: $senderName, recipientId: $recipientId, message: $message, attachments: $attachments, timestamp: $timestamp, read: $read, readAt: $readAt, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SecureMessageImpl &&
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

  @JsonKey(ignore: true)
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

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SecureMessageImplCopyWith<_$SecureMessageImpl> get copyWith =>
      __$$SecureMessageImplCopyWithImpl<_$SecureMessageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SecureMessageImplToJson(
      this,
    );
  }
}

abstract class _SecureMessage implements SecureMessage {
  const factory _SecureMessage(
      {required final String id,
      required final String conversationId,
      required final String senderId,
      required final String senderType,
      required final String senderName,
      required final String recipientId,
      required final String message,
      final List<MessageAttachment>? attachments,
      required final DateTime timestamp,
      required final bool read,
      final DateTime? readAt,
      final String? type}) = _$SecureMessageImpl;

  factory _SecureMessage.fromJson(Map<String, dynamic> json) =
      _$SecureMessageImpl.fromJson;

  @override
  String get id;
  @override
  String get conversationId;
  @override
  String get senderId;
  @override
  String get senderType;
  @override
  String get senderName;
  @override
  String get recipientId;
  @override
  String get message;
  @override
  List<MessageAttachment>? get attachments;
  @override
  DateTime get timestamp;
  @override
  bool get read;
  @override
  DateTime? get readAt;
  @override
  String? get type;
  @override
  @JsonKey(ignore: true)
  _$$SecureMessageImplCopyWith<_$SecureMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MessageThread _$MessageThreadFromJson(Map<String, dynamic> json) {
  return _MessageThread.fromJson(json);
}

/// @nodoc
mixin _$MessageThread {
  String get id => throw _privateConstructorUsedError;
  String get appointmentId => throw _privateConstructorUsedError;
  String get clientId => throw _privateConstructorUsedError;
  String get workerId => throw _privateConstructorUsedError;
  String get organizationId => throw _privateConstructorUsedError;
  List<String> get participants => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  String? get lastMessage => throw _privateConstructorUsedError;
  DateTime? get lastMessageAt => throw _privateConstructorUsedError;
  Map<String, int>? get unreadCount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MessageThreadCopyWith<MessageThread> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageThreadCopyWith<$Res> {
  factory $MessageThreadCopyWith(
          MessageThread value, $Res Function(MessageThread) then) =
      _$MessageThreadCopyWithImpl<$Res, MessageThread>;
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
      Map<String, int>? unreadCount});
}

/// @nodoc
class _$MessageThreadCopyWithImpl<$Res, $Val extends MessageThread>
    implements $MessageThreadCopyWith<$Res> {
  _$MessageThreadCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      appointmentId: null == appointmentId
          ? _value.appointmentId
          : appointmentId // ignore: cast_nullable_to_non_nullable
              as String,
      clientId: null == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      workerId: null == workerId
          ? _value.workerId
          : workerId // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      participants: null == participants
          ? _value.participants
          : participants // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastMessage: freezed == lastMessage
          ? _value.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      lastMessageAt: freezed == lastMessageAt
          ? _value.lastMessageAt
          : lastMessageAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      unreadCount: freezed == unreadCount
          ? _value.unreadCount
          : unreadCount // ignore: cast_nullable_to_non_nullable
              as Map<String, int>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MessageThreadImplCopyWith<$Res>
    implements $MessageThreadCopyWith<$Res> {
  factory _$$MessageThreadImplCopyWith(
          _$MessageThreadImpl value, $Res Function(_$MessageThreadImpl) then) =
      __$$MessageThreadImplCopyWithImpl<$Res>;
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
      Map<String, int>? unreadCount});
}

/// @nodoc
class __$$MessageThreadImplCopyWithImpl<$Res>
    extends _$MessageThreadCopyWithImpl<$Res, _$MessageThreadImpl>
    implements _$$MessageThreadImplCopyWith<$Res> {
  __$$MessageThreadImplCopyWithImpl(
      _$MessageThreadImpl _value, $Res Function(_$MessageThreadImpl) _then)
      : super(_value, _then);

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
  }) {
    return _then(_$MessageThreadImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      appointmentId: null == appointmentId
          ? _value.appointmentId
          : appointmentId // ignore: cast_nullable_to_non_nullable
              as String,
      clientId: null == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      workerId: null == workerId
          ? _value.workerId
          : workerId // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      participants: null == participants
          ? _value._participants
          : participants // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastMessage: freezed == lastMessage
          ? _value.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      lastMessageAt: freezed == lastMessageAt
          ? _value.lastMessageAt
          : lastMessageAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      unreadCount: freezed == unreadCount
          ? _value._unreadCount
          : unreadCount // ignore: cast_nullable_to_non_nullable
              as Map<String, int>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MessageThreadImpl implements _MessageThread {
  const _$MessageThreadImpl(
      {required this.id,
      required this.appointmentId,
      required this.clientId,
      required this.workerId,
      required this.organizationId,
      required final List<String> participants,
      required this.createdAt,
      this.lastMessage,
      this.lastMessageAt,
      final Map<String, int>? unreadCount})
      : _participants = participants,
        _unreadCount = unreadCount;

  factory _$MessageThreadImpl.fromJson(Map<String, dynamic> json) =>
      _$$MessageThreadImplFromJson(json);

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

  @override
  String toString() {
    return 'MessageThread(id: $id, appointmentId: $appointmentId, clientId: $clientId, workerId: $workerId, organizationId: $organizationId, participants: $participants, createdAt: $createdAt, lastMessage: $lastMessage, lastMessageAt: $lastMessageAt, unreadCount: $unreadCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageThreadImpl &&
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
                .equals(other._unreadCount, _unreadCount));
  }

  @JsonKey(ignore: true)
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
      const DeepCollectionEquality().hash(_unreadCount));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageThreadImplCopyWith<_$MessageThreadImpl> get copyWith =>
      __$$MessageThreadImplCopyWithImpl<_$MessageThreadImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MessageThreadImplToJson(
      this,
    );
  }
}

abstract class _MessageThread implements MessageThread {
  const factory _MessageThread(
      {required final String id,
      required final String appointmentId,
      required final String clientId,
      required final String workerId,
      required final String organizationId,
      required final List<String> participants,
      required final DateTime createdAt,
      final String? lastMessage,
      final DateTime? lastMessageAt,
      final Map<String, int>? unreadCount}) = _$MessageThreadImpl;

  factory _MessageThread.fromJson(Map<String, dynamic> json) =
      _$MessageThreadImpl.fromJson;

  @override
  String get id;
  @override
  String get appointmentId;
  @override
  String get clientId;
  @override
  String get workerId;
  @override
  String get organizationId;
  @override
  List<String> get participants;
  @override
  DateTime get createdAt;
  @override
  String? get lastMessage;
  @override
  DateTime? get lastMessageAt;
  @override
  Map<String, int>? get unreadCount;
  @override
  @JsonKey(ignore: true)
  _$$MessageThreadImplCopyWith<_$MessageThreadImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MessageAttachment _$MessageAttachmentFromJson(Map<String, dynamic> json) {
  return _MessageAttachment.fromJson(json);
}

/// @nodoc
mixin _$MessageAttachment {
  String get url => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  int get size => throw _privateConstructorUsedError;
  String? get thumbnail => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MessageAttachmentCopyWith<MessageAttachment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageAttachmentCopyWith<$Res> {
  factory $MessageAttachmentCopyWith(
          MessageAttachment value, $Res Function(MessageAttachment) then) =
      _$MessageAttachmentCopyWithImpl<$Res, MessageAttachment>;
  @useResult
  $Res call(
      {String url, String name, String type, int size, String? thumbnail});
}

/// @nodoc
class _$MessageAttachmentCopyWithImpl<$Res, $Val extends MessageAttachment>
    implements $MessageAttachmentCopyWith<$Res> {
  _$MessageAttachmentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? name = null,
    Object? type = null,
    Object? size = null,
    Object? thumbnail = freezed,
  }) {
    return _then(_value.copyWith(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int,
      thumbnail: freezed == thumbnail
          ? _value.thumbnail
          : thumbnail // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MessageAttachmentImplCopyWith<$Res>
    implements $MessageAttachmentCopyWith<$Res> {
  factory _$$MessageAttachmentImplCopyWith(_$MessageAttachmentImpl value,
          $Res Function(_$MessageAttachmentImpl) then) =
      __$$MessageAttachmentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String url, String name, String type, int size, String? thumbnail});
}

/// @nodoc
class __$$MessageAttachmentImplCopyWithImpl<$Res>
    extends _$MessageAttachmentCopyWithImpl<$Res, _$MessageAttachmentImpl>
    implements _$$MessageAttachmentImplCopyWith<$Res> {
  __$$MessageAttachmentImplCopyWithImpl(_$MessageAttachmentImpl _value,
      $Res Function(_$MessageAttachmentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? name = null,
    Object? type = null,
    Object? size = null,
    Object? thumbnail = freezed,
  }) {
    return _then(_$MessageAttachmentImpl(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int,
      thumbnail: freezed == thumbnail
          ? _value.thumbnail
          : thumbnail // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MessageAttachmentImpl implements _MessageAttachment {
  const _$MessageAttachmentImpl(
      {required this.url,
      required this.name,
      required this.type,
      required this.size,
      this.thumbnail});

  factory _$MessageAttachmentImpl.fromJson(Map<String, dynamic> json) =>
      _$$MessageAttachmentImplFromJson(json);

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

  @override
  String toString() {
    return 'MessageAttachment(url: $url, name: $name, type: $type, size: $size, thumbnail: $thumbnail)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageAttachmentImpl &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.thumbnail, thumbnail) ||
                other.thumbnail == thumbnail));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, url, name, type, size, thumbnail);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageAttachmentImplCopyWith<_$MessageAttachmentImpl> get copyWith =>
      __$$MessageAttachmentImplCopyWithImpl<_$MessageAttachmentImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MessageAttachmentImplToJson(
      this,
    );
  }
}

abstract class _MessageAttachment implements MessageAttachment {
  const factory _MessageAttachment(
      {required final String url,
      required final String name,
      required final String type,
      required final int size,
      final String? thumbnail}) = _$MessageAttachmentImpl;

  factory _MessageAttachment.fromJson(Map<String, dynamic> json) =
      _$MessageAttachmentImpl.fromJson;

  @override
  String get url;
  @override
  String get name;
  @override
  String get type;
  @override
  int get size;
  @override
  String? get thumbnail;
  @override
  @JsonKey(ignore: true)
  _$$MessageAttachmentImplCopyWith<_$MessageAttachmentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

VoiceMessage _$VoiceMessageFromJson(Map<String, dynamic> json) {
  return _VoiceMessage.fromJson(json);
}

/// @nodoc
mixin _$VoiceMessage {
  String get id => throw _privateConstructorUsedError;
  String get conversationId => throw _privateConstructorUsedError;
  String get senderId => throw _privateConstructorUsedError;
  String get audioUrl => throw _privateConstructorUsedError;
  int get duration => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  bool? get played => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VoiceMessageCopyWith<VoiceMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VoiceMessageCopyWith<$Res> {
  factory $VoiceMessageCopyWith(
          VoiceMessage value, $Res Function(VoiceMessage) then) =
      _$VoiceMessageCopyWithImpl<$Res, VoiceMessage>;
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
class _$VoiceMessageCopyWithImpl<$Res, $Val extends VoiceMessage>
    implements $VoiceMessageCopyWith<$Res> {
  _$VoiceMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      conversationId: null == conversationId
          ? _value.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
              as String,
      senderId: null == senderId
          ? _value.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as String,
      audioUrl: null == audioUrl
          ? _value.audioUrl
          : audioUrl // ignore: cast_nullable_to_non_nullable
              as String,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      played: freezed == played
          ? _value.played
          : played // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VoiceMessageImplCopyWith<$Res>
    implements $VoiceMessageCopyWith<$Res> {
  factory _$$VoiceMessageImplCopyWith(
          _$VoiceMessageImpl value, $Res Function(_$VoiceMessageImpl) then) =
      __$$VoiceMessageImplCopyWithImpl<$Res>;
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
class __$$VoiceMessageImplCopyWithImpl<$Res>
    extends _$VoiceMessageCopyWithImpl<$Res, _$VoiceMessageImpl>
    implements _$$VoiceMessageImplCopyWith<$Res> {
  __$$VoiceMessageImplCopyWithImpl(
      _$VoiceMessageImpl _value, $Res Function(_$VoiceMessageImpl) _then)
      : super(_value, _then);

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
    return _then(_$VoiceMessageImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      conversationId: null == conversationId
          ? _value.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
              as String,
      senderId: null == senderId
          ? _value.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as String,
      audioUrl: null == audioUrl
          ? _value.audioUrl
          : audioUrl // ignore: cast_nullable_to_non_nullable
              as String,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      played: freezed == played
          ? _value.played
          : played // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VoiceMessageImpl implements _VoiceMessage {
  const _$VoiceMessageImpl(
      {required this.id,
      required this.conversationId,
      required this.senderId,
      required this.audioUrl,
      required this.duration,
      required this.timestamp,
      this.played});

  factory _$VoiceMessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$VoiceMessageImplFromJson(json);

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

  @override
  String toString() {
    return 'VoiceMessage(id: $id, conversationId: $conversationId, senderId: $senderId, audioUrl: $audioUrl, duration: $duration, timestamp: $timestamp, played: $played)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VoiceMessageImpl &&
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

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, conversationId, senderId,
      audioUrl, duration, timestamp, played);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VoiceMessageImplCopyWith<_$VoiceMessageImpl> get copyWith =>
      __$$VoiceMessageImplCopyWithImpl<_$VoiceMessageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VoiceMessageImplToJson(
      this,
    );
  }
}

abstract class _VoiceMessage implements VoiceMessage {
  const factory _VoiceMessage(
      {required final String id,
      required final String conversationId,
      required final String senderId,
      required final String audioUrl,
      required final int duration,
      required final DateTime timestamp,
      final bool? played}) = _$VoiceMessageImpl;

  factory _VoiceMessage.fromJson(Map<String, dynamic> json) =
      _$VoiceMessageImpl.fromJson;

  @override
  String get id;
  @override
  String get conversationId;
  @override
  String get senderId;
  @override
  String get audioUrl;
  @override
  int get duration;
  @override
  DateTime get timestamp;
  @override
  bool? get played;
  @override
  @JsonKey(ignore: true)
  _$$VoiceMessageImplCopyWith<_$VoiceMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TypingIndicator _$TypingIndicatorFromJson(Map<String, dynamic> json) {
  return _TypingIndicator.fromJson(json);
}

/// @nodoc
mixin _$TypingIndicator {
  String get conversationId => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get userName => throw _privateConstructorUsedError;
  bool get isTyping => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TypingIndicatorCopyWith<TypingIndicator> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TypingIndicatorCopyWith<$Res> {
  factory $TypingIndicatorCopyWith(
          TypingIndicator value, $Res Function(TypingIndicator) then) =
      _$TypingIndicatorCopyWithImpl<$Res, TypingIndicator>;
  @useResult
  $Res call(
      {String conversationId, String userId, String userName, bool isTyping});
}

/// @nodoc
class _$TypingIndicatorCopyWithImpl<$Res, $Val extends TypingIndicator>
    implements $TypingIndicatorCopyWith<$Res> {
  _$TypingIndicatorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? conversationId = null,
    Object? userId = null,
    Object? userName = null,
    Object? isTyping = null,
  }) {
    return _then(_value.copyWith(
      conversationId: null == conversationId
          ? _value.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      isTyping: null == isTyping
          ? _value.isTyping
          : isTyping // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TypingIndicatorImplCopyWith<$Res>
    implements $TypingIndicatorCopyWith<$Res> {
  factory _$$TypingIndicatorImplCopyWith(_$TypingIndicatorImpl value,
          $Res Function(_$TypingIndicatorImpl) then) =
      __$$TypingIndicatorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String conversationId, String userId, String userName, bool isTyping});
}

/// @nodoc
class __$$TypingIndicatorImplCopyWithImpl<$Res>
    extends _$TypingIndicatorCopyWithImpl<$Res, _$TypingIndicatorImpl>
    implements _$$TypingIndicatorImplCopyWith<$Res> {
  __$$TypingIndicatorImplCopyWithImpl(
      _$TypingIndicatorImpl _value, $Res Function(_$TypingIndicatorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? conversationId = null,
    Object? userId = null,
    Object? userName = null,
    Object? isTyping = null,
  }) {
    return _then(_$TypingIndicatorImpl(
      conversationId: null == conversationId
          ? _value.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      isTyping: null == isTyping
          ? _value.isTyping
          : isTyping // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TypingIndicatorImpl implements _TypingIndicator {
  const _$TypingIndicatorImpl(
      {required this.conversationId,
      required this.userId,
      required this.userName,
      required this.isTyping});

  factory _$TypingIndicatorImpl.fromJson(Map<String, dynamic> json) =>
      _$$TypingIndicatorImplFromJson(json);

  @override
  final String conversationId;
  @override
  final String userId;
  @override
  final String userName;
  @override
  final bool isTyping;

  @override
  String toString() {
    return 'TypingIndicator(conversationId: $conversationId, userId: $userId, userName: $userName, isTyping: $isTyping)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TypingIndicatorImpl &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.isTyping, isTyping) ||
                other.isTyping == isTyping));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, conversationId, userId, userName, isTyping);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TypingIndicatorImplCopyWith<_$TypingIndicatorImpl> get copyWith =>
      __$$TypingIndicatorImplCopyWithImpl<_$TypingIndicatorImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TypingIndicatorImplToJson(
      this,
    );
  }
}

abstract class _TypingIndicator implements TypingIndicator {
  const factory _TypingIndicator(
      {required final String conversationId,
      required final String userId,
      required final String userName,
      required final bool isTyping}) = _$TypingIndicatorImpl;

  factory _TypingIndicator.fromJson(Map<String, dynamic> json) =
      _$TypingIndicatorImpl.fromJson;

  @override
  String get conversationId;
  @override
  String get userId;
  @override
  String get userName;
  @override
  bool get isTyping;
  @override
  @JsonKey(ignore: true)
  _$$TypingIndicatorImplCopyWith<_$TypingIndicatorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DigitalSignature _$DigitalSignatureFromJson(Map<String, dynamic> json) {
  return _DigitalSignature.fromJson(json);
}

/// @nodoc
mixin _$DigitalSignature {
  String get id => throw _privateConstructorUsedError;
  String get appointmentId => throw _privateConstructorUsedError;
  String get clientId => throw _privateConstructorUsedError;
  String get signatureData => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  String get hash => throw _privateConstructorUsedError;
  bool get verified => throw _privateConstructorUsedError;
  String? get ipAddress => throw _privateConstructorUsedError;
  String? get deviceInfo => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DigitalSignatureCopyWith<DigitalSignature> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DigitalSignatureCopyWith<$Res> {
  factory $DigitalSignatureCopyWith(
          DigitalSignature value, $Res Function(DigitalSignature) then) =
      _$DigitalSignatureCopyWithImpl<$Res, DigitalSignature>;
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
class _$DigitalSignatureCopyWithImpl<$Res, $Val extends DigitalSignature>
    implements $DigitalSignatureCopyWith<$Res> {
  _$DigitalSignatureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      appointmentId: null == appointmentId
          ? _value.appointmentId
          : appointmentId // ignore: cast_nullable_to_non_nullable
              as String,
      clientId: null == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      signatureData: null == signatureData
          ? _value.signatureData
          : signatureData // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      hash: null == hash
          ? _value.hash
          : hash // ignore: cast_nullable_to_non_nullable
              as String,
      verified: null == verified
          ? _value.verified
          : verified // ignore: cast_nullable_to_non_nullable
              as bool,
      ipAddress: freezed == ipAddress
          ? _value.ipAddress
          : ipAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      deviceInfo: freezed == deviceInfo
          ? _value.deviceInfo
          : deviceInfo // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DigitalSignatureImplCopyWith<$Res>
    implements $DigitalSignatureCopyWith<$Res> {
  factory _$$DigitalSignatureImplCopyWith(_$DigitalSignatureImpl value,
          $Res Function(_$DigitalSignatureImpl) then) =
      __$$DigitalSignatureImplCopyWithImpl<$Res>;
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
class __$$DigitalSignatureImplCopyWithImpl<$Res>
    extends _$DigitalSignatureCopyWithImpl<$Res, _$DigitalSignatureImpl>
    implements _$$DigitalSignatureImplCopyWith<$Res> {
  __$$DigitalSignatureImplCopyWithImpl(_$DigitalSignatureImpl _value,
      $Res Function(_$DigitalSignatureImpl) _then)
      : super(_value, _then);

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
    return _then(_$DigitalSignatureImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      appointmentId: null == appointmentId
          ? _value.appointmentId
          : appointmentId // ignore: cast_nullable_to_non_nullable
              as String,
      clientId: null == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      signatureData: null == signatureData
          ? _value.signatureData
          : signatureData // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      hash: null == hash
          ? _value.hash
          : hash // ignore: cast_nullable_to_non_nullable
              as String,
      verified: null == verified
          ? _value.verified
          : verified // ignore: cast_nullable_to_non_nullable
              as bool,
      ipAddress: freezed == ipAddress
          ? _value.ipAddress
          : ipAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      deviceInfo: freezed == deviceInfo
          ? _value.deviceInfo
          : deviceInfo // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DigitalSignatureImpl implements _DigitalSignature {
  const _$DigitalSignatureImpl(
      {required this.id,
      required this.appointmentId,
      required this.clientId,
      required this.signatureData,
      required this.timestamp,
      required this.hash,
      required this.verified,
      this.ipAddress,
      this.deviceInfo});

  factory _$DigitalSignatureImpl.fromJson(Map<String, dynamic> json) =>
      _$$DigitalSignatureImplFromJson(json);

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

  @override
  String toString() {
    return 'DigitalSignature(id: $id, appointmentId: $appointmentId, clientId: $clientId, signatureData: $signatureData, timestamp: $timestamp, hash: $hash, verified: $verified, ipAddress: $ipAddress, deviceInfo: $deviceInfo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DigitalSignatureImpl &&
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

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, appointmentId, clientId,
      signatureData, timestamp, hash, verified, ipAddress, deviceInfo);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DigitalSignatureImplCopyWith<_$DigitalSignatureImpl> get copyWith =>
      __$$DigitalSignatureImplCopyWithImpl<_$DigitalSignatureImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DigitalSignatureImplToJson(
      this,
    );
  }
}

abstract class _DigitalSignature implements DigitalSignature {
  const factory _DigitalSignature(
      {required final String id,
      required final String appointmentId,
      required final String clientId,
      required final String signatureData,
      required final DateTime timestamp,
      required final String hash,
      required final bool verified,
      final String? ipAddress,
      final String? deviceInfo}) = _$DigitalSignatureImpl;

  factory _DigitalSignature.fromJson(Map<String, dynamic> json) =
      _$DigitalSignatureImpl.fromJson;

  @override
  String get id;
  @override
  String get appointmentId;
  @override
  String get clientId;
  @override
  String get signatureData;
  @override
  DateTime get timestamp;
  @override
  String get hash;
  @override
  bool get verified;
  @override
  String? get ipAddress;
  @override
  String? get deviceInfo;
  @override
  @JsonKey(ignore: true)
  _$$DigitalSignatureImplCopyWith<_$DigitalSignatureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ServiceConfirmation _$ServiceConfirmationFromJson(Map<String, dynamic> json) {
  return _ServiceConfirmation.fromJson(json);
}

/// @nodoc
mixin _$ServiceConfirmation {
  String get id => throw _privateConstructorUsedError;
  String get appointmentId => throw _privateConstructorUsedError;
  String get clientId => throw _privateConstructorUsedError;
  String get workerId => throw _privateConstructorUsedError;
  String get signatureId => throw _privateConstructorUsedError;
  int? get rating => throw _privateConstructorUsedError;
  String? get feedback => throw _privateConstructorUsedError;
  List<ChecklistItem>? get checklist => throw _privateConstructorUsedError;
  List<String>? get photos => throw _privateConstructorUsedError;
  List<IncidentReport>? get incidents => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String? get reportUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ServiceConfirmationCopyWith<ServiceConfirmation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ServiceConfirmationCopyWith<$Res> {
  factory $ServiceConfirmationCopyWith(
          ServiceConfirmation value, $Res Function(ServiceConfirmation) then) =
      _$ServiceConfirmationCopyWithImpl<$Res, ServiceConfirmation>;
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
class _$ServiceConfirmationCopyWithImpl<$Res, $Val extends ServiceConfirmation>
    implements $ServiceConfirmationCopyWith<$Res> {
  _$ServiceConfirmationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      appointmentId: null == appointmentId
          ? _value.appointmentId
          : appointmentId // ignore: cast_nullable_to_non_nullable
              as String,
      clientId: null == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      workerId: null == workerId
          ? _value.workerId
          : workerId // ignore: cast_nullable_to_non_nullable
              as String,
      signatureId: null == signatureId
          ? _value.signatureId
          : signatureId // ignore: cast_nullable_to_non_nullable
              as String,
      rating: freezed == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as int?,
      feedback: freezed == feedback
          ? _value.feedback
          : feedback // ignore: cast_nullable_to_non_nullable
              as String?,
      checklist: freezed == checklist
          ? _value.checklist
          : checklist // ignore: cast_nullable_to_non_nullable
              as List<ChecklistItem>?,
      photos: freezed == photos
          ? _value.photos
          : photos // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      incidents: freezed == incidents
          ? _value.incidents
          : incidents // ignore: cast_nullable_to_non_nullable
              as List<IncidentReport>?,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      reportUrl: freezed == reportUrl
          ? _value.reportUrl
          : reportUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ServiceConfirmationImplCopyWith<$Res>
    implements $ServiceConfirmationCopyWith<$Res> {
  factory _$$ServiceConfirmationImplCopyWith(_$ServiceConfirmationImpl value,
          $Res Function(_$ServiceConfirmationImpl) then) =
      __$$ServiceConfirmationImplCopyWithImpl<$Res>;
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
class __$$ServiceConfirmationImplCopyWithImpl<$Res>
    extends _$ServiceConfirmationCopyWithImpl<$Res, _$ServiceConfirmationImpl>
    implements _$$ServiceConfirmationImplCopyWith<$Res> {
  __$$ServiceConfirmationImplCopyWithImpl(_$ServiceConfirmationImpl _value,
      $Res Function(_$ServiceConfirmationImpl) _then)
      : super(_value, _then);

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
    return _then(_$ServiceConfirmationImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      appointmentId: null == appointmentId
          ? _value.appointmentId
          : appointmentId // ignore: cast_nullable_to_non_nullable
              as String,
      clientId: null == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      workerId: null == workerId
          ? _value.workerId
          : workerId // ignore: cast_nullable_to_non_nullable
              as String,
      signatureId: null == signatureId
          ? _value.signatureId
          : signatureId // ignore: cast_nullable_to_non_nullable
              as String,
      rating: freezed == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as int?,
      feedback: freezed == feedback
          ? _value.feedback
          : feedback // ignore: cast_nullable_to_non_nullable
              as String?,
      checklist: freezed == checklist
          ? _value._checklist
          : checklist // ignore: cast_nullable_to_non_nullable
              as List<ChecklistItem>?,
      photos: freezed == photos
          ? _value._photos
          : photos // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      incidents: freezed == incidents
          ? _value._incidents
          : incidents // ignore: cast_nullable_to_non_nullable
              as List<IncidentReport>?,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      reportUrl: freezed == reportUrl
          ? _value.reportUrl
          : reportUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ServiceConfirmationImpl implements _ServiceConfirmation {
  const _$ServiceConfirmationImpl(
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

  factory _$ServiceConfirmationImpl.fromJson(Map<String, dynamic> json) =>
      _$$ServiceConfirmationImplFromJson(json);

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

  @override
  String toString() {
    return 'ServiceConfirmation(id: $id, appointmentId: $appointmentId, clientId: $clientId, workerId: $workerId, signatureId: $signatureId, rating: $rating, feedback: $feedback, checklist: $checklist, photos: $photos, incidents: $incidents, timestamp: $timestamp, status: $status, reportUrl: $reportUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServiceConfirmationImpl &&
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

  @JsonKey(ignore: true)
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

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ServiceConfirmationImplCopyWith<_$ServiceConfirmationImpl> get copyWith =>
      __$$ServiceConfirmationImplCopyWithImpl<_$ServiceConfirmationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ServiceConfirmationImplToJson(
      this,
    );
  }
}

abstract class _ServiceConfirmation implements ServiceConfirmation {
  const factory _ServiceConfirmation(
      {required final String id,
      required final String appointmentId,
      required final String clientId,
      required final String workerId,
      required final String signatureId,
      final int? rating,
      final String? feedback,
      final List<ChecklistItem>? checklist,
      final List<String>? photos,
      final List<IncidentReport>? incidents,
      required final DateTime timestamp,
      required final String status,
      final String? reportUrl}) = _$ServiceConfirmationImpl;

  factory _ServiceConfirmation.fromJson(Map<String, dynamic> json) =
      _$ServiceConfirmationImpl.fromJson;

  @override
  String get id;
  @override
  String get appointmentId;
  @override
  String get clientId;
  @override
  String get workerId;
  @override
  String get signatureId;
  @override
  int? get rating;
  @override
  String? get feedback;
  @override
  List<ChecklistItem>? get checklist;
  @override
  List<String>? get photos;
  @override
  List<IncidentReport>? get incidents;
  @override
  DateTime get timestamp;
  @override
  String get status;
  @override
  String? get reportUrl;
  @override
  @JsonKey(ignore: true)
  _$$ServiceConfirmationImplCopyWith<_$ServiceConfirmationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ChecklistItem _$ChecklistItemFromJson(Map<String, dynamic> json) {
  return _ChecklistItem.fromJson(json);
}

/// @nodoc
mixin _$ChecklistItem {
  int get id => throw _privateConstructorUsedError;
  String get item => throw _privateConstructorUsedError;
  bool get required => throw _privateConstructorUsedError;
  bool? get completed => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChecklistItemCopyWith<ChecklistItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChecklistItemCopyWith<$Res> {
  factory $ChecklistItemCopyWith(
          ChecklistItem value, $Res Function(ChecklistItem) then) =
      _$ChecklistItemCopyWithImpl<$Res, ChecklistItem>;
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
class _$ChecklistItemCopyWithImpl<$Res, $Val extends ChecklistItem>
    implements $ChecklistItemCopyWith<$Res> {
  _$ChecklistItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      item: null == item
          ? _value.item
          : item // ignore: cast_nullable_to_non_nullable
              as String,
      required: null == required
          ? _value.required
          : required // ignore: cast_nullable_to_non_nullable
              as bool,
      completed: freezed == completed
          ? _value.completed
          : completed // ignore: cast_nullable_to_non_nullable
              as bool?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChecklistItemImplCopyWith<$Res>
    implements $ChecklistItemCopyWith<$Res> {
  factory _$$ChecklistItemImplCopyWith(
          _$ChecklistItemImpl value, $Res Function(_$ChecklistItemImpl) then) =
      __$$ChecklistItemImplCopyWithImpl<$Res>;
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
class __$$ChecklistItemImplCopyWithImpl<$Res>
    extends _$ChecklistItemCopyWithImpl<$Res, _$ChecklistItemImpl>
    implements _$$ChecklistItemImplCopyWith<$Res> {
  __$$ChecklistItemImplCopyWithImpl(
      _$ChecklistItemImpl _value, $Res Function(_$ChecklistItemImpl) _then)
      : super(_value, _then);

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
    return _then(_$ChecklistItemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      item: null == item
          ? _value.item
          : item // ignore: cast_nullable_to_non_nullable
              as String,
      required: null == required
          ? _value.required
          : required // ignore: cast_nullable_to_non_nullable
              as bool,
      completed: freezed == completed
          ? _value.completed
          : completed // ignore: cast_nullable_to_non_nullable
              as bool?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChecklistItemImpl implements _ChecklistItem {
  const _$ChecklistItemImpl(
      {required this.id,
      required this.item,
      required this.required,
      this.completed,
      this.completedAt,
      this.notes});

  factory _$ChecklistItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChecklistItemImplFromJson(json);

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

  @override
  String toString() {
    return 'ChecklistItem(id: $id, item: $item, required: $required, completed: $completed, completedAt: $completedAt, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChecklistItemImpl &&
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

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, item, required, completed, completedAt, notes);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChecklistItemImplCopyWith<_$ChecklistItemImpl> get copyWith =>
      __$$ChecklistItemImplCopyWithImpl<_$ChecklistItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChecklistItemImplToJson(
      this,
    );
  }
}

abstract class _ChecklistItem implements ChecklistItem {
  const factory _ChecklistItem(
      {required final int id,
      required final String item,
      required final bool required,
      final bool? completed,
      final DateTime? completedAt,
      final String? notes}) = _$ChecklistItemImpl;

  factory _ChecklistItem.fromJson(Map<String, dynamic> json) =
      _$ChecklistItemImpl.fromJson;

  @override
  int get id;
  @override
  String get item;
  @override
  bool get required;
  @override
  bool? get completed;
  @override
  DateTime? get completedAt;
  @override
  String? get notes;
  @override
  @JsonKey(ignore: true)
  _$$ChecklistItemImplCopyWith<_$ChecklistItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ClientRating _$ClientRatingFromJson(Map<String, dynamic> json) {
  return _ClientRating.fromJson(json);
}

/// @nodoc
mixin _$ClientRating {
  int get stars => throw _privateConstructorUsedError; // 1-5
  String? get feedback => throw _privateConstructorUsedError;
  List<String>? get tags => throw _privateConstructorUsedError;
  DateTime? get timestamp => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ClientRatingCopyWith<ClientRating> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClientRatingCopyWith<$Res> {
  factory $ClientRatingCopyWith(
          ClientRating value, $Res Function(ClientRating) then) =
      _$ClientRatingCopyWithImpl<$Res, ClientRating>;
  @useResult
  $Res call(
      {int stars, String? feedback, List<String>? tags, DateTime? timestamp});
}

/// @nodoc
class _$ClientRatingCopyWithImpl<$Res, $Val extends ClientRating>
    implements $ClientRatingCopyWith<$Res> {
  _$ClientRatingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stars = null,
    Object? feedback = freezed,
    Object? tags = freezed,
    Object? timestamp = freezed,
  }) {
    return _then(_value.copyWith(
      stars: null == stars
          ? _value.stars
          : stars // ignore: cast_nullable_to_non_nullable
              as int,
      feedback: freezed == feedback
          ? _value.feedback
          : feedback // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: freezed == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ClientRatingImplCopyWith<$Res>
    implements $ClientRatingCopyWith<$Res> {
  factory _$$ClientRatingImplCopyWith(
          _$ClientRatingImpl value, $Res Function(_$ClientRatingImpl) then) =
      __$$ClientRatingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int stars, String? feedback, List<String>? tags, DateTime? timestamp});
}

/// @nodoc
class __$$ClientRatingImplCopyWithImpl<$Res>
    extends _$ClientRatingCopyWithImpl<$Res, _$ClientRatingImpl>
    implements _$$ClientRatingImplCopyWith<$Res> {
  __$$ClientRatingImplCopyWithImpl(
      _$ClientRatingImpl _value, $Res Function(_$ClientRatingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stars = null,
    Object? feedback = freezed,
    Object? tags = freezed,
    Object? timestamp = freezed,
  }) {
    return _then(_$ClientRatingImpl(
      stars: null == stars
          ? _value.stars
          : stars // ignore: cast_nullable_to_non_nullable
              as int,
      feedback: freezed == feedback
          ? _value.feedback
          : feedback // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: freezed == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ClientRatingImpl implements _ClientRating {
  const _$ClientRatingImpl(
      {required this.stars,
      this.feedback,
      final List<String>? tags,
      this.timestamp})
      : _tags = tags;

  factory _$ClientRatingImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClientRatingImplFromJson(json);

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

  @override
  String toString() {
    return 'ClientRating(stars: $stars, feedback: $feedback, tags: $tags, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClientRatingImpl &&
            (identical(other.stars, stars) || other.stars == stars) &&
            (identical(other.feedback, feedback) ||
                other.feedback == feedback) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, stars, feedback,
      const DeepCollectionEquality().hash(_tags), timestamp);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ClientRatingImplCopyWith<_$ClientRatingImpl> get copyWith =>
      __$$ClientRatingImplCopyWithImpl<_$ClientRatingImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClientRatingImplToJson(
      this,
    );
  }
}

abstract class _ClientRating implements ClientRating {
  const factory _ClientRating(
      {required final int stars,
      final String? feedback,
      final List<String>? tags,
      final DateTime? timestamp}) = _$ClientRatingImpl;

  factory _ClientRating.fromJson(Map<String, dynamic> json) =
      _$ClientRatingImpl.fromJson;

  @override
  int get stars;
  @override // 1-5
  String? get feedback;
  @override
  List<String>? get tags;
  @override
  DateTime? get timestamp;
  @override
  @JsonKey(ignore: true)
  _$$ClientRatingImplCopyWith<_$ClientRatingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

IncidentReport _$IncidentReportFromJson(Map<String, dynamic> json) {
  return _IncidentReport.fromJson(json);
}

/// @nodoc
mixin _$IncidentReport {
  String get id => throw _privateConstructorUsedError;
  String get appointmentId => throw _privateConstructorUsedError;
  String get reportedBy => throw _privateConstructorUsedError;
  String get reporterType => throw _privateConstructorUsedError;
  String get severity =>
      throw _privateConstructorUsedError; // 'low', 'medium', 'high', 'critical'
  String get category =>
      throw _privateConstructorUsedError; // 'safety', 'quality', 'behavior', 'equipment', 'other'
  String get description => throw _privateConstructorUsedError;
  List<String>? get photos => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String? get resolution => throw _privateConstructorUsedError;
  DateTime? get resolvedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $IncidentReportCopyWith<IncidentReport> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IncidentReportCopyWith<$Res> {
  factory $IncidentReportCopyWith(
          IncidentReport value, $Res Function(IncidentReport) then) =
      _$IncidentReportCopyWithImpl<$Res, IncidentReport>;
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
class _$IncidentReportCopyWithImpl<$Res, $Val extends IncidentReport>
    implements $IncidentReportCopyWith<$Res> {
  _$IncidentReportCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      appointmentId: null == appointmentId
          ? _value.appointmentId
          : appointmentId // ignore: cast_nullable_to_non_nullable
              as String,
      reportedBy: null == reportedBy
          ? _value.reportedBy
          : reportedBy // ignore: cast_nullable_to_non_nullable
              as String,
      reporterType: null == reporterType
          ? _value.reporterType
          : reporterType // ignore: cast_nullable_to_non_nullable
              as String,
      severity: null == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      photos: freezed == photos
          ? _value.photos
          : photos // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      resolution: freezed == resolution
          ? _value.resolution
          : resolution // ignore: cast_nullable_to_non_nullable
              as String?,
      resolvedAt: freezed == resolvedAt
          ? _value.resolvedAt
          : resolvedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$IncidentReportImplCopyWith<$Res>
    implements $IncidentReportCopyWith<$Res> {
  factory _$$IncidentReportImplCopyWith(_$IncidentReportImpl value,
          $Res Function(_$IncidentReportImpl) then) =
      __$$IncidentReportImplCopyWithImpl<$Res>;
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
class __$$IncidentReportImplCopyWithImpl<$Res>
    extends _$IncidentReportCopyWithImpl<$Res, _$IncidentReportImpl>
    implements _$$IncidentReportImplCopyWith<$Res> {
  __$$IncidentReportImplCopyWithImpl(
      _$IncidentReportImpl _value, $Res Function(_$IncidentReportImpl) _then)
      : super(_value, _then);

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
    return _then(_$IncidentReportImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      appointmentId: null == appointmentId
          ? _value.appointmentId
          : appointmentId // ignore: cast_nullable_to_non_nullable
              as String,
      reportedBy: null == reportedBy
          ? _value.reportedBy
          : reportedBy // ignore: cast_nullable_to_non_nullable
              as String,
      reporterType: null == reporterType
          ? _value.reporterType
          : reporterType // ignore: cast_nullable_to_non_nullable
              as String,
      severity: null == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      photos: freezed == photos
          ? _value._photos
          : photos // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      resolution: freezed == resolution
          ? _value.resolution
          : resolution // ignore: cast_nullable_to_non_nullable
              as String?,
      resolvedAt: freezed == resolvedAt
          ? _value.resolvedAt
          : resolvedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$IncidentReportImpl implements _IncidentReport {
  const _$IncidentReportImpl(
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

  factory _$IncidentReportImpl.fromJson(Map<String, dynamic> json) =>
      _$$IncidentReportImplFromJson(json);

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

  @override
  String toString() {
    return 'IncidentReport(id: $id, appointmentId: $appointmentId, reportedBy: $reportedBy, reporterType: $reporterType, severity: $severity, category: $category, description: $description, photos: $photos, timestamp: $timestamp, status: $status, resolution: $resolution, resolvedAt: $resolvedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IncidentReportImpl &&
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

  @JsonKey(ignore: true)
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

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$IncidentReportImplCopyWith<_$IncidentReportImpl> get copyWith =>
      __$$IncidentReportImplCopyWithImpl<_$IncidentReportImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IncidentReportImplToJson(
      this,
    );
  }
}

abstract class _IncidentReport implements IncidentReport {
  const factory _IncidentReport(
      {required final String id,
      required final String appointmentId,
      required final String reportedBy,
      required final String reporterType,
      required final String severity,
      required final String category,
      required final String description,
      final List<String>? photos,
      required final DateTime timestamp,
      required final String status,
      final String? resolution,
      final DateTime? resolvedAt}) = _$IncidentReportImpl;

  factory _IncidentReport.fromJson(Map<String, dynamic> json) =
      _$IncidentReportImpl.fromJson;

  @override
  String get id;
  @override
  String get appointmentId;
  @override
  String get reportedBy;
  @override
  String get reporterType;
  @override
  String get severity;
  @override // 'low', 'medium', 'high', 'critical'
  String get category;
  @override // 'safety', 'quality', 'behavior', 'equipment', 'other'
  String get description;
  @override
  List<String>? get photos;
  @override
  DateTime get timestamp;
  @override
  String get status;
  @override
  String? get resolution;
  @override
  DateTime? get resolvedAt;
  @override
  @JsonKey(ignore: true)
  _$$IncidentReportImplCopyWith<_$IncidentReportImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ServiceReport _$ServiceReportFromJson(Map<String, dynamic> json) {
  return _ServiceReport.fromJson(json);
}

/// @nodoc
mixin _$ServiceReport {
  String get appointmentId => throw _privateConstructorUsedError;
  String get reportUrl => throw _privateConstructorUsedError;
  DateTime get generatedAt => throw _privateConstructorUsedError;
  String? get pdfPath => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ServiceReportCopyWith<ServiceReport> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ServiceReportCopyWith<$Res> {
  factory $ServiceReportCopyWith(
          ServiceReport value, $Res Function(ServiceReport) then) =
      _$ServiceReportCopyWithImpl<$Res, ServiceReport>;
  @useResult
  $Res call(
      {String appointmentId,
      String reportUrl,
      DateTime generatedAt,
      String? pdfPath});
}

/// @nodoc
class _$ServiceReportCopyWithImpl<$Res, $Val extends ServiceReport>
    implements $ServiceReportCopyWith<$Res> {
  _$ServiceReportCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appointmentId = null,
    Object? reportUrl = null,
    Object? generatedAt = null,
    Object? pdfPath = freezed,
  }) {
    return _then(_value.copyWith(
      appointmentId: null == appointmentId
          ? _value.appointmentId
          : appointmentId // ignore: cast_nullable_to_non_nullable
              as String,
      reportUrl: null == reportUrl
          ? _value.reportUrl
          : reportUrl // ignore: cast_nullable_to_non_nullable
              as String,
      generatedAt: null == generatedAt
          ? _value.generatedAt
          : generatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      pdfPath: freezed == pdfPath
          ? _value.pdfPath
          : pdfPath // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ServiceReportImplCopyWith<$Res>
    implements $ServiceReportCopyWith<$Res> {
  factory _$$ServiceReportImplCopyWith(
          _$ServiceReportImpl value, $Res Function(_$ServiceReportImpl) then) =
      __$$ServiceReportImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String appointmentId,
      String reportUrl,
      DateTime generatedAt,
      String? pdfPath});
}

/// @nodoc
class __$$ServiceReportImplCopyWithImpl<$Res>
    extends _$ServiceReportCopyWithImpl<$Res, _$ServiceReportImpl>
    implements _$$ServiceReportImplCopyWith<$Res> {
  __$$ServiceReportImplCopyWithImpl(
      _$ServiceReportImpl _value, $Res Function(_$ServiceReportImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appointmentId = null,
    Object? reportUrl = null,
    Object? generatedAt = null,
    Object? pdfPath = freezed,
  }) {
    return _then(_$ServiceReportImpl(
      appointmentId: null == appointmentId
          ? _value.appointmentId
          : appointmentId // ignore: cast_nullable_to_non_nullable
              as String,
      reportUrl: null == reportUrl
          ? _value.reportUrl
          : reportUrl // ignore: cast_nullable_to_non_nullable
              as String,
      generatedAt: null == generatedAt
          ? _value.generatedAt
          : generatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      pdfPath: freezed == pdfPath
          ? _value.pdfPath
          : pdfPath // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ServiceReportImpl implements _ServiceReport {
  const _$ServiceReportImpl(
      {required this.appointmentId,
      required this.reportUrl,
      required this.generatedAt,
      this.pdfPath});

  factory _$ServiceReportImpl.fromJson(Map<String, dynamic> json) =>
      _$$ServiceReportImplFromJson(json);

  @override
  final String appointmentId;
  @override
  final String reportUrl;
  @override
  final DateTime generatedAt;
  @override
  final String? pdfPath;

  @override
  String toString() {
    return 'ServiceReport(appointmentId: $appointmentId, reportUrl: $reportUrl, generatedAt: $generatedAt, pdfPath: $pdfPath)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServiceReportImpl &&
            (identical(other.appointmentId, appointmentId) ||
                other.appointmentId == appointmentId) &&
            (identical(other.reportUrl, reportUrl) ||
                other.reportUrl == reportUrl) &&
            (identical(other.generatedAt, generatedAt) ||
                other.generatedAt == generatedAt) &&
            (identical(other.pdfPath, pdfPath) || other.pdfPath == pdfPath));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, appointmentId, reportUrl, generatedAt, pdfPath);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ServiceReportImplCopyWith<_$ServiceReportImpl> get copyWith =>
      __$$ServiceReportImplCopyWithImpl<_$ServiceReportImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ServiceReportImplToJson(
      this,
    );
  }
}

abstract class _ServiceReport implements ServiceReport {
  const factory _ServiceReport(
      {required final String appointmentId,
      required final String reportUrl,
      required final DateTime generatedAt,
      final String? pdfPath}) = _$ServiceReportImpl;

  factory _ServiceReport.fromJson(Map<String, dynamic> json) =
      _$ServiceReportImpl.fromJson;

  @override
  String get appointmentId;
  @override
  String get reportUrl;
  @override
  DateTime get generatedAt;
  @override
  String? get pdfPath;
  @override
  @JsonKey(ignore: true)
  _$$ServiceReportImplCopyWith<_$ServiceReportImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FamilyMember _$FamilyMemberFromJson(Map<String, dynamic> json) {
  return _FamilyMember.fromJson(json);
}

/// @nodoc
mixin _$FamilyMember {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get clientId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get relationship => throw _privateConstructorUsedError;
  String get role => throw _privateConstructorUsedError;
  FamilyPermissions get permissions => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  DateTime get joinedAt => throw _privateConstructorUsedError;
  NotificationPreferences? get notificationPreferences =>
      throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  String? get updatedBy => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FamilyMemberCopyWith<FamilyMember> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FamilyMemberCopyWith<$Res> {
  factory $FamilyMemberCopyWith(
          FamilyMember value, $Res Function(FamilyMember) then) =
      _$FamilyMemberCopyWithImpl<$Res, FamilyMember>;
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
class _$FamilyMemberCopyWithImpl<$Res, $Val extends FamilyMember>
    implements $FamilyMemberCopyWith<$Res> {
  _$FamilyMemberCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      clientId: null == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      relationship: null == relationship
          ? _value.relationship
          : relationship // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      permissions: null == permissions
          ? _value.permissions
          : permissions // ignore: cast_nullable_to_non_nullable
              as FamilyPermissions,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      joinedAt: null == joinedAt
          ? _value.joinedAt
          : joinedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      notificationPreferences: freezed == notificationPreferences
          ? _value.notificationPreferences
          : notificationPreferences // ignore: cast_nullable_to_non_nullable
              as NotificationPreferences?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedBy: freezed == updatedBy
          ? _value.updatedBy
          : updatedBy // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $FamilyPermissionsCopyWith<$Res> get permissions {
    return $FamilyPermissionsCopyWith<$Res>(_value.permissions, (value) {
      return _then(_value.copyWith(permissions: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $NotificationPreferencesCopyWith<$Res>? get notificationPreferences {
    if (_value.notificationPreferences == null) {
      return null;
    }

    return $NotificationPreferencesCopyWith<$Res>(
        _value.notificationPreferences!, (value) {
      return _then(_value.copyWith(notificationPreferences: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$FamilyMemberImplCopyWith<$Res>
    implements $FamilyMemberCopyWith<$Res> {
  factory _$$FamilyMemberImplCopyWith(
          _$FamilyMemberImpl value, $Res Function(_$FamilyMemberImpl) then) =
      __$$FamilyMemberImplCopyWithImpl<$Res>;
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
class __$$FamilyMemberImplCopyWithImpl<$Res>
    extends _$FamilyMemberCopyWithImpl<$Res, _$FamilyMemberImpl>
    implements _$$FamilyMemberImplCopyWith<$Res> {
  __$$FamilyMemberImplCopyWithImpl(
      _$FamilyMemberImpl _value, $Res Function(_$FamilyMemberImpl) _then)
      : super(_value, _then);

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
    return _then(_$FamilyMemberImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      clientId: null == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      relationship: null == relationship
          ? _value.relationship
          : relationship // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      permissions: null == permissions
          ? _value.permissions
          : permissions // ignore: cast_nullable_to_non_nullable
              as FamilyPermissions,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      joinedAt: null == joinedAt
          ? _value.joinedAt
          : joinedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      notificationPreferences: freezed == notificationPreferences
          ? _value.notificationPreferences
          : notificationPreferences // ignore: cast_nullable_to_non_nullable
              as NotificationPreferences?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedBy: freezed == updatedBy
          ? _value.updatedBy
          : updatedBy // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FamilyMemberImpl implements _FamilyMember {
  const _$FamilyMemberImpl(
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

  factory _$FamilyMemberImpl.fromJson(Map<String, dynamic> json) =>
      _$$FamilyMemberImplFromJson(json);

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

  @override
  String toString() {
    return 'FamilyMember(id: $id, userId: $userId, clientId: $clientId, name: $name, email: $email, relationship: $relationship, role: $role, permissions: $permissions, status: $status, joinedAt: $joinedAt, notificationPreferences: $notificationPreferences, updatedAt: $updatedAt, updatedBy: $updatedBy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FamilyMemberImpl &&
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

  @JsonKey(ignore: true)
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

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FamilyMemberImplCopyWith<_$FamilyMemberImpl> get copyWith =>
      __$$FamilyMemberImplCopyWithImpl<_$FamilyMemberImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FamilyMemberImplToJson(
      this,
    );
  }
}

abstract class _FamilyMember implements FamilyMember {
  const factory _FamilyMember(
      {required final String id,
      required final String userId,
      required final String clientId,
      required final String name,
      required final String email,
      required final String relationship,
      required final String role,
      required final FamilyPermissions permissions,
      required final String status,
      required final DateTime joinedAt,
      final NotificationPreferences? notificationPreferences,
      final DateTime? updatedAt,
      final String? updatedBy}) = _$FamilyMemberImpl;

  factory _FamilyMember.fromJson(Map<String, dynamic> json) =
      _$FamilyMemberImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get clientId;
  @override
  String get name;
  @override
  String get email;
  @override
  String get relationship;
  @override
  String get role;
  @override
  FamilyPermissions get permissions;
  @override
  String get status;
  @override
  DateTime get joinedAt;
  @override
  NotificationPreferences? get notificationPreferences;
  @override
  DateTime? get updatedAt;
  @override
  String? get updatedBy;
  @override
  @JsonKey(ignore: true)
  _$$FamilyMemberImplCopyWith<_$FamilyMemberImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FamilyPermissions _$FamilyPermissionsFromJson(Map<String, dynamic> json) {
  return _FamilyPermissions.fromJson(json);
}

/// @nodoc
mixin _$FamilyPermissions {
  bool get viewAppointments => throw _privateConstructorUsedError;
  bool get viewDocuments => throw _privateConstructorUsedError;
  bool get viewInvoices => throw _privateConstructorUsedError;
  bool get editProfile => throw _privateConstructorUsedError;
  bool get approveServices => throw _privateConstructorUsedError;
  bool get manageFamily => throw _privateConstructorUsedError;
  bool get viewMessages => throw _privateConstructorUsedError;
  bool get sendMessages => throw _privateConstructorUsedError;
  bool get viewLocation => throw _privateConstructorUsedError;
  bool get receiveNotifications => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FamilyPermissionsCopyWith<FamilyPermissions> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FamilyPermissionsCopyWith<$Res> {
  factory $FamilyPermissionsCopyWith(
          FamilyPermissions value, $Res Function(FamilyPermissions) then) =
      _$FamilyPermissionsCopyWithImpl<$Res, FamilyPermissions>;
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
class _$FamilyPermissionsCopyWithImpl<$Res, $Val extends FamilyPermissions>
    implements $FamilyPermissionsCopyWith<$Res> {
  _$FamilyPermissionsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      viewAppointments: null == viewAppointments
          ? _value.viewAppointments
          : viewAppointments // ignore: cast_nullable_to_non_nullable
              as bool,
      viewDocuments: null == viewDocuments
          ? _value.viewDocuments
          : viewDocuments // ignore: cast_nullable_to_non_nullable
              as bool,
      viewInvoices: null == viewInvoices
          ? _value.viewInvoices
          : viewInvoices // ignore: cast_nullable_to_non_nullable
              as bool,
      editProfile: null == editProfile
          ? _value.editProfile
          : editProfile // ignore: cast_nullable_to_non_nullable
              as bool,
      approveServices: null == approveServices
          ? _value.approveServices
          : approveServices // ignore: cast_nullable_to_non_nullable
              as bool,
      manageFamily: null == manageFamily
          ? _value.manageFamily
          : manageFamily // ignore: cast_nullable_to_non_nullable
              as bool,
      viewMessages: null == viewMessages
          ? _value.viewMessages
          : viewMessages // ignore: cast_nullable_to_non_nullable
              as bool,
      sendMessages: null == sendMessages
          ? _value.sendMessages
          : sendMessages // ignore: cast_nullable_to_non_nullable
              as bool,
      viewLocation: null == viewLocation
          ? _value.viewLocation
          : viewLocation // ignore: cast_nullable_to_non_nullable
              as bool,
      receiveNotifications: null == receiveNotifications
          ? _value.receiveNotifications
          : receiveNotifications // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FamilyPermissionsImplCopyWith<$Res>
    implements $FamilyPermissionsCopyWith<$Res> {
  factory _$$FamilyPermissionsImplCopyWith(_$FamilyPermissionsImpl value,
          $Res Function(_$FamilyPermissionsImpl) then) =
      __$$FamilyPermissionsImplCopyWithImpl<$Res>;
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
class __$$FamilyPermissionsImplCopyWithImpl<$Res>
    extends _$FamilyPermissionsCopyWithImpl<$Res, _$FamilyPermissionsImpl>
    implements _$$FamilyPermissionsImplCopyWith<$Res> {
  __$$FamilyPermissionsImplCopyWithImpl(_$FamilyPermissionsImpl _value,
      $Res Function(_$FamilyPermissionsImpl) _then)
      : super(_value, _then);

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
    return _then(_$FamilyPermissionsImpl(
      viewAppointments: null == viewAppointments
          ? _value.viewAppointments
          : viewAppointments // ignore: cast_nullable_to_non_nullable
              as bool,
      viewDocuments: null == viewDocuments
          ? _value.viewDocuments
          : viewDocuments // ignore: cast_nullable_to_non_nullable
              as bool,
      viewInvoices: null == viewInvoices
          ? _value.viewInvoices
          : viewInvoices // ignore: cast_nullable_to_non_nullable
              as bool,
      editProfile: null == editProfile
          ? _value.editProfile
          : editProfile // ignore: cast_nullable_to_non_nullable
              as bool,
      approveServices: null == approveServices
          ? _value.approveServices
          : approveServices // ignore: cast_nullable_to_non_nullable
              as bool,
      manageFamily: null == manageFamily
          ? _value.manageFamily
          : manageFamily // ignore: cast_nullable_to_non_nullable
              as bool,
      viewMessages: null == viewMessages
          ? _value.viewMessages
          : viewMessages // ignore: cast_nullable_to_non_nullable
              as bool,
      sendMessages: null == sendMessages
          ? _value.sendMessages
          : sendMessages // ignore: cast_nullable_to_non_nullable
              as bool,
      viewLocation: null == viewLocation
          ? _value.viewLocation
          : viewLocation // ignore: cast_nullable_to_non_nullable
              as bool,
      receiveNotifications: null == receiveNotifications
          ? _value.receiveNotifications
          : receiveNotifications // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FamilyPermissionsImpl implements _FamilyPermissions {
  const _$FamilyPermissionsImpl(
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

  factory _$FamilyPermissionsImpl.fromJson(Map<String, dynamic> json) =>
      _$$FamilyPermissionsImplFromJson(json);

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

  @override
  String toString() {
    return 'FamilyPermissions(viewAppointments: $viewAppointments, viewDocuments: $viewDocuments, viewInvoices: $viewInvoices, editProfile: $editProfile, approveServices: $approveServices, manageFamily: $manageFamily, viewMessages: $viewMessages, sendMessages: $sendMessages, viewLocation: $viewLocation, receiveNotifications: $receiveNotifications)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FamilyPermissionsImpl &&
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

  @JsonKey(ignore: true)
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

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FamilyPermissionsImplCopyWith<_$FamilyPermissionsImpl> get copyWith =>
      __$$FamilyPermissionsImplCopyWithImpl<_$FamilyPermissionsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FamilyPermissionsImplToJson(
      this,
    );
  }
}

abstract class _FamilyPermissions implements FamilyPermissions {
  const factory _FamilyPermissions(
      {required final bool viewAppointments,
      required final bool viewDocuments,
      required final bool viewInvoices,
      required final bool editProfile,
      required final bool approveServices,
      required final bool manageFamily,
      required final bool viewMessages,
      required final bool sendMessages,
      required final bool viewLocation,
      required final bool receiveNotifications}) = _$FamilyPermissionsImpl;

  factory _FamilyPermissions.fromJson(Map<String, dynamic> json) =
      _$FamilyPermissionsImpl.fromJson;

  @override
  bool get viewAppointments;
  @override
  bool get viewDocuments;
  @override
  bool get viewInvoices;
  @override
  bool get editProfile;
  @override
  bool get approveServices;
  @override
  bool get manageFamily;
  @override
  bool get viewMessages;
  @override
  bool get sendMessages;
  @override
  bool get viewLocation;
  @override
  bool get receiveNotifications;
  @override
  @JsonKey(ignore: true)
  _$$FamilyPermissionsImplCopyWith<_$FamilyPermissionsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FamilyInvitation _$FamilyInvitationFromJson(Map<String, dynamic> json) {
  return _FamilyInvitation.fromJson(json);
}

/// @nodoc
mixin _$FamilyInvitation {
  String get id => throw _privateConstructorUsedError;
  String get clientId => throw _privateConstructorUsedError;
  String get invitedBy => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get relationship => throw _privateConstructorUsedError;
  String get role => throw _privateConstructorUsedError;
  FamilyPermissions get permissions => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  DateTime get invitedAt => throw _privateConstructorUsedError;
  DateTime get expiresAt => throw _privateConstructorUsedError;
  String get token => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FamilyInvitationCopyWith<FamilyInvitation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FamilyInvitationCopyWith<$Res> {
  factory $FamilyInvitationCopyWith(
          FamilyInvitation value, $Res Function(FamilyInvitation) then) =
      _$FamilyInvitationCopyWithImpl<$Res, FamilyInvitation>;
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
class _$FamilyInvitationCopyWithImpl<$Res, $Val extends FamilyInvitation>
    implements $FamilyInvitationCopyWith<$Res> {
  _$FamilyInvitationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      clientId: null == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      invitedBy: null == invitedBy
          ? _value.invitedBy
          : invitedBy // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      relationship: null == relationship
          ? _value.relationship
          : relationship // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      permissions: null == permissions
          ? _value.permissions
          : permissions // ignore: cast_nullable_to_non_nullable
              as FamilyPermissions,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      invitedAt: null == invitedAt
          ? _value.invitedAt
          : invitedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      expiresAt: null == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $FamilyPermissionsCopyWith<$Res> get permissions {
    return $FamilyPermissionsCopyWith<$Res>(_value.permissions, (value) {
      return _then(_value.copyWith(permissions: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$FamilyInvitationImplCopyWith<$Res>
    implements $FamilyInvitationCopyWith<$Res> {
  factory _$$FamilyInvitationImplCopyWith(_$FamilyInvitationImpl value,
          $Res Function(_$FamilyInvitationImpl) then) =
      __$$FamilyInvitationImplCopyWithImpl<$Res>;
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
class __$$FamilyInvitationImplCopyWithImpl<$Res>
    extends _$FamilyInvitationCopyWithImpl<$Res, _$FamilyInvitationImpl>
    implements _$$FamilyInvitationImplCopyWith<$Res> {
  __$$FamilyInvitationImplCopyWithImpl(_$FamilyInvitationImpl _value,
      $Res Function(_$FamilyInvitationImpl) _then)
      : super(_value, _then);

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
    return _then(_$FamilyInvitationImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      clientId: null == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      invitedBy: null == invitedBy
          ? _value.invitedBy
          : invitedBy // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      relationship: null == relationship
          ? _value.relationship
          : relationship // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      permissions: null == permissions
          ? _value.permissions
          : permissions // ignore: cast_nullable_to_non_nullable
              as FamilyPermissions,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      invitedAt: null == invitedAt
          ? _value.invitedAt
          : invitedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      expiresAt: null == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FamilyInvitationImpl implements _FamilyInvitation {
  const _$FamilyInvitationImpl(
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

  factory _$FamilyInvitationImpl.fromJson(Map<String, dynamic> json) =>
      _$$FamilyInvitationImplFromJson(json);

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

  @override
  String toString() {
    return 'FamilyInvitation(id: $id, clientId: $clientId, invitedBy: $invitedBy, email: $email, name: $name, relationship: $relationship, role: $role, permissions: $permissions, status: $status, invitedAt: $invitedAt, expiresAt: $expiresAt, token: $token)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FamilyInvitationImpl &&
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

  @JsonKey(ignore: true)
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

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FamilyInvitationImplCopyWith<_$FamilyInvitationImpl> get copyWith =>
      __$$FamilyInvitationImplCopyWithImpl<_$FamilyInvitationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FamilyInvitationImplToJson(
      this,
    );
  }
}

abstract class _FamilyInvitation implements FamilyInvitation {
  const factory _FamilyInvitation(
      {required final String id,
      required final String clientId,
      required final String invitedBy,
      required final String email,
      required final String name,
      required final String relationship,
      required final String role,
      required final FamilyPermissions permissions,
      required final String status,
      required final DateTime invitedAt,
      required final DateTime expiresAt,
      required final String token}) = _$FamilyInvitationImpl;

  factory _FamilyInvitation.fromJson(Map<String, dynamic> json) =
      _$FamilyInvitationImpl.fromJson;

  @override
  String get id;
  @override
  String get clientId;
  @override
  String get invitedBy;
  @override
  String get email;
  @override
  String get name;
  @override
  String get relationship;
  @override
  String get role;
  @override
  FamilyPermissions get permissions;
  @override
  String get status;
  @override
  DateTime get invitedAt;
  @override
  DateTime get expiresAt;
  @override
  String get token;
  @override
  @JsonKey(ignore: true)
  _$$FamilyInvitationImplCopyWith<_$FamilyInvitationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AccessAuditLog _$AccessAuditLogFromJson(Map<String, dynamic> json) {
  return _AccessAuditLog.fromJson(json);
}

/// @nodoc
mixin _$AccessAuditLog {
  String get id => throw _privateConstructorUsedError;
  String get clientId => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get action => throw _privateConstructorUsedError;
  String? get targetUserId => throw _privateConstructorUsedError;
  Map<String, dynamic>? get details => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AccessAuditLogCopyWith<AccessAuditLog> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccessAuditLogCopyWith<$Res> {
  factory $AccessAuditLogCopyWith(
          AccessAuditLog value, $Res Function(AccessAuditLog) then) =
      _$AccessAuditLogCopyWithImpl<$Res, AccessAuditLog>;
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
class _$AccessAuditLogCopyWithImpl<$Res, $Val extends AccessAuditLog>
    implements $AccessAuditLogCopyWith<$Res> {
  _$AccessAuditLogCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      clientId: null == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      action: null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as String,
      targetUserId: freezed == targetUserId
          ? _value.targetUserId
          : targetUserId // ignore: cast_nullable_to_non_nullable
              as String?,
      details: freezed == details
          ? _value.details
          : details // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AccessAuditLogImplCopyWith<$Res>
    implements $AccessAuditLogCopyWith<$Res> {
  factory _$$AccessAuditLogImplCopyWith(_$AccessAuditLogImpl value,
          $Res Function(_$AccessAuditLogImpl) then) =
      __$$AccessAuditLogImplCopyWithImpl<$Res>;
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
class __$$AccessAuditLogImplCopyWithImpl<$Res>
    extends _$AccessAuditLogCopyWithImpl<$Res, _$AccessAuditLogImpl>
    implements _$$AccessAuditLogImplCopyWith<$Res> {
  __$$AccessAuditLogImplCopyWithImpl(
      _$AccessAuditLogImpl _value, $Res Function(_$AccessAuditLogImpl) _then)
      : super(_value, _then);

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
    return _then(_$AccessAuditLogImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      clientId: null == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      action: null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as String,
      targetUserId: freezed == targetUserId
          ? _value.targetUserId
          : targetUserId // ignore: cast_nullable_to_non_nullable
              as String?,
      details: freezed == details
          ? _value._details
          : details // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AccessAuditLogImpl implements _AccessAuditLog {
  const _$AccessAuditLogImpl(
      {required this.id,
      required this.clientId,
      required this.userId,
      required this.action,
      this.targetUserId,
      final Map<String, dynamic>? details,
      required this.timestamp})
      : _details = details;

  factory _$AccessAuditLogImpl.fromJson(Map<String, dynamic> json) =>
      _$$AccessAuditLogImplFromJson(json);

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

  @override
  String toString() {
    return 'AccessAuditLog(id: $id, clientId: $clientId, userId: $userId, action: $action, targetUserId: $targetUserId, details: $details, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AccessAuditLogImpl &&
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

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, clientId, userId, action,
      targetUserId, const DeepCollectionEquality().hash(_details), timestamp);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AccessAuditLogImplCopyWith<_$AccessAuditLogImpl> get copyWith =>
      __$$AccessAuditLogImplCopyWithImpl<_$AccessAuditLogImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AccessAuditLogImplToJson(
      this,
    );
  }
}

abstract class _AccessAuditLog implements AccessAuditLog {
  const factory _AccessAuditLog(
      {required final String id,
      required final String clientId,
      required final String userId,
      required final String action,
      final String? targetUserId,
      final Map<String, dynamic>? details,
      required final DateTime timestamp}) = _$AccessAuditLogImpl;

  factory _AccessAuditLog.fromJson(Map<String, dynamic> json) =
      _$AccessAuditLogImpl.fromJson;

  @override
  String get id;
  @override
  String get clientId;
  @override
  String get userId;
  @override
  String get action;
  @override
  String? get targetUserId;
  @override
  Map<String, dynamic>? get details;
  @override
  DateTime get timestamp;
  @override
  @JsonKey(ignore: true)
  _$$AccessAuditLogImplCopyWith<_$AccessAuditLogImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NotificationPreferences _$NotificationPreferencesFromJson(
    Map<String, dynamic> json) {
  return _NotificationPreferences.fromJson(json);
}

/// @nodoc
mixin _$NotificationPreferences {
  bool get email => throw _privateConstructorUsedError;
  bool get sms => throw _privateConstructorUsedError;
  bool get push => throw _privateConstructorUsedError;
  bool get appointmentReminders => throw _privateConstructorUsedError;
  bool get statusUpdates => throw _privateConstructorUsedError;
  bool get emergencyAlerts => throw _privateConstructorUsedError;
  bool get serviceConfirmations => throw _privateConstructorUsedError;
  QuietHours? get quietHours => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NotificationPreferencesCopyWith<NotificationPreferences> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationPreferencesCopyWith<$Res> {
  factory $NotificationPreferencesCopyWith(NotificationPreferences value,
          $Res Function(NotificationPreferences) then) =
      _$NotificationPreferencesCopyWithImpl<$Res, NotificationPreferences>;
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
class _$NotificationPreferencesCopyWithImpl<$Res,
        $Val extends NotificationPreferences>
    implements $NotificationPreferencesCopyWith<$Res> {
  _$NotificationPreferencesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as bool,
      sms: null == sms
          ? _value.sms
          : sms // ignore: cast_nullable_to_non_nullable
              as bool,
      push: null == push
          ? _value.push
          : push // ignore: cast_nullable_to_non_nullable
              as bool,
      appointmentReminders: null == appointmentReminders
          ? _value.appointmentReminders
          : appointmentReminders // ignore: cast_nullable_to_non_nullable
              as bool,
      statusUpdates: null == statusUpdates
          ? _value.statusUpdates
          : statusUpdates // ignore: cast_nullable_to_non_nullable
              as bool,
      emergencyAlerts: null == emergencyAlerts
          ? _value.emergencyAlerts
          : emergencyAlerts // ignore: cast_nullable_to_non_nullable
              as bool,
      serviceConfirmations: null == serviceConfirmations
          ? _value.serviceConfirmations
          : serviceConfirmations // ignore: cast_nullable_to_non_nullable
              as bool,
      quietHours: freezed == quietHours
          ? _value.quietHours
          : quietHours // ignore: cast_nullable_to_non_nullable
              as QuietHours?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $QuietHoursCopyWith<$Res>? get quietHours {
    if (_value.quietHours == null) {
      return null;
    }

    return $QuietHoursCopyWith<$Res>(_value.quietHours!, (value) {
      return _then(_value.copyWith(quietHours: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$NotificationPreferencesImplCopyWith<$Res>
    implements $NotificationPreferencesCopyWith<$Res> {
  factory _$$NotificationPreferencesImplCopyWith(
          _$NotificationPreferencesImpl value,
          $Res Function(_$NotificationPreferencesImpl) then) =
      __$$NotificationPreferencesImplCopyWithImpl<$Res>;
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
class __$$NotificationPreferencesImplCopyWithImpl<$Res>
    extends _$NotificationPreferencesCopyWithImpl<$Res,
        _$NotificationPreferencesImpl>
    implements _$$NotificationPreferencesImplCopyWith<$Res> {
  __$$NotificationPreferencesImplCopyWithImpl(
      _$NotificationPreferencesImpl _value,
      $Res Function(_$NotificationPreferencesImpl) _then)
      : super(_value, _then);

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
    return _then(_$NotificationPreferencesImpl(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as bool,
      sms: null == sms
          ? _value.sms
          : sms // ignore: cast_nullable_to_non_nullable
              as bool,
      push: null == push
          ? _value.push
          : push // ignore: cast_nullable_to_non_nullable
              as bool,
      appointmentReminders: null == appointmentReminders
          ? _value.appointmentReminders
          : appointmentReminders // ignore: cast_nullable_to_non_nullable
              as bool,
      statusUpdates: null == statusUpdates
          ? _value.statusUpdates
          : statusUpdates // ignore: cast_nullable_to_non_nullable
              as bool,
      emergencyAlerts: null == emergencyAlerts
          ? _value.emergencyAlerts
          : emergencyAlerts // ignore: cast_nullable_to_non_nullable
              as bool,
      serviceConfirmations: null == serviceConfirmations
          ? _value.serviceConfirmations
          : serviceConfirmations // ignore: cast_nullable_to_non_nullable
              as bool,
      quietHours: freezed == quietHours
          ? _value.quietHours
          : quietHours // ignore: cast_nullable_to_non_nullable
              as QuietHours?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationPreferencesImpl implements _NotificationPreferences {
  const _$NotificationPreferencesImpl(
      {this.email = true,
      this.sms = false,
      this.push = true,
      this.appointmentReminders = true,
      this.statusUpdates = true,
      this.emergencyAlerts = true,
      this.serviceConfirmations = true,
      this.quietHours});

  factory _$NotificationPreferencesImpl.fromJson(Map<String, dynamic> json) =>
      _$$NotificationPreferencesImplFromJson(json);

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

  @override
  String toString() {
    return 'NotificationPreferences(email: $email, sms: $sms, push: $push, appointmentReminders: $appointmentReminders, statusUpdates: $statusUpdates, emergencyAlerts: $emergencyAlerts, serviceConfirmations: $serviceConfirmations, quietHours: $quietHours)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationPreferencesImpl &&
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

  @JsonKey(ignore: true)
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

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationPreferencesImplCopyWith<_$NotificationPreferencesImpl>
      get copyWith => __$$NotificationPreferencesImplCopyWithImpl<
          _$NotificationPreferencesImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationPreferencesImplToJson(
      this,
    );
  }
}

abstract class _NotificationPreferences implements NotificationPreferences {
  const factory _NotificationPreferences(
      {final bool email,
      final bool sms,
      final bool push,
      final bool appointmentReminders,
      final bool statusUpdates,
      final bool emergencyAlerts,
      final bool serviceConfirmations,
      final QuietHours? quietHours}) = _$NotificationPreferencesImpl;

  factory _NotificationPreferences.fromJson(Map<String, dynamic> json) =
      _$NotificationPreferencesImpl.fromJson;

  @override
  bool get email;
  @override
  bool get sms;
  @override
  bool get push;
  @override
  bool get appointmentReminders;
  @override
  bool get statusUpdates;
  @override
  bool get emergencyAlerts;
  @override
  bool get serviceConfirmations;
  @override
  QuietHours? get quietHours;
  @override
  @JsonKey(ignore: true)
  _$$NotificationPreferencesImplCopyWith<_$NotificationPreferencesImpl>
      get copyWith => throw _privateConstructorUsedError;
}

QuietHours _$QuietHoursFromJson(Map<String, dynamic> json) {
  return _QuietHours.fromJson(json);
}

/// @nodoc
mixin _$QuietHours {
  String get start => throw _privateConstructorUsedError;
  String get end => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $QuietHoursCopyWith<QuietHours> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuietHoursCopyWith<$Res> {
  factory $QuietHoursCopyWith(
          QuietHours value, $Res Function(QuietHours) then) =
      _$QuietHoursCopyWithImpl<$Res, QuietHours>;
  @useResult
  $Res call({String start, String end});
}

/// @nodoc
class _$QuietHoursCopyWithImpl<$Res, $Val extends QuietHours>
    implements $QuietHoursCopyWith<$Res> {
  _$QuietHoursCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? start = null,
    Object? end = null,
  }) {
    return _then(_value.copyWith(
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as String,
      end: null == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$QuietHoursImplCopyWith<$Res>
    implements $QuietHoursCopyWith<$Res> {
  factory _$$QuietHoursImplCopyWith(
          _$QuietHoursImpl value, $Res Function(_$QuietHoursImpl) then) =
      __$$QuietHoursImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String start, String end});
}

/// @nodoc
class __$$QuietHoursImplCopyWithImpl<$Res>
    extends _$QuietHoursCopyWithImpl<$Res, _$QuietHoursImpl>
    implements _$$QuietHoursImplCopyWith<$Res> {
  __$$QuietHoursImplCopyWithImpl(
      _$QuietHoursImpl _value, $Res Function(_$QuietHoursImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? start = null,
    Object? end = null,
  }) {
    return _then(_$QuietHoursImpl(
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as String,
      end: null == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$QuietHoursImpl implements _QuietHours {
  const _$QuietHoursImpl({required this.start, required this.end});

  factory _$QuietHoursImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuietHoursImplFromJson(json);

  @override
  final String start;
  @override
  final String end;

  @override
  String toString() {
    return 'QuietHours(start: $start, end: $end)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuietHoursImpl &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.end, end) || other.end == end));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, start, end);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$QuietHoursImplCopyWith<_$QuietHoursImpl> get copyWith =>
      __$$QuietHoursImplCopyWithImpl<_$QuietHoursImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QuietHoursImplToJson(
      this,
    );
  }
}

abstract class _QuietHours implements QuietHours {
  const factory _QuietHours(
      {required final String start,
      required final String end}) = _$QuietHoursImpl;

  factory _QuietHours.fromJson(Map<String, dynamic> json) =
      _$QuietHoursImpl.fromJson;

  @override
  String get start;
  @override
  String get end;
  @override
  @JsonKey(ignore: true)
  _$$QuietHoursImplCopyWith<_$QuietHoursImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DocumentShare _$DocumentShareFromJson(Map<String, dynamic> json) {
  return _DocumentShare.fromJson(json);
}

/// @nodoc
mixin _$DocumentShare {
  String get id => throw _privateConstructorUsedError;
  String get clientId => throw _privateConstructorUsedError;
  String get documentId => throw _privateConstructorUsedError;
  String get sharedBy => throw _privateConstructorUsedError;
  List<String> get sharedWith => throw _privateConstructorUsedError;
  List<String> get permissions => throw _privateConstructorUsedError;
  DateTime get sharedAt => throw _privateConstructorUsedError;
  DateTime? get expiresAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DocumentShareCopyWith<DocumentShare> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DocumentShareCopyWith<$Res> {
  factory $DocumentShareCopyWith(
          DocumentShare value, $Res Function(DocumentShare) then) =
      _$DocumentShareCopyWithImpl<$Res, DocumentShare>;
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
class _$DocumentShareCopyWithImpl<$Res, $Val extends DocumentShare>
    implements $DocumentShareCopyWith<$Res> {
  _$DocumentShareCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      clientId: null == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      documentId: null == documentId
          ? _value.documentId
          : documentId // ignore: cast_nullable_to_non_nullable
              as String,
      sharedBy: null == sharedBy
          ? _value.sharedBy
          : sharedBy // ignore: cast_nullable_to_non_nullable
              as String,
      sharedWith: null == sharedWith
          ? _value.sharedWith
          : sharedWith // ignore: cast_nullable_to_non_nullable
              as List<String>,
      permissions: null == permissions
          ? _value.permissions
          : permissions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      sharedAt: null == sharedAt
          ? _value.sharedAt
          : sharedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DocumentShareImplCopyWith<$Res>
    implements $DocumentShareCopyWith<$Res> {
  factory _$$DocumentShareImplCopyWith(
          _$DocumentShareImpl value, $Res Function(_$DocumentShareImpl) then) =
      __$$DocumentShareImplCopyWithImpl<$Res>;
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
class __$$DocumentShareImplCopyWithImpl<$Res>
    extends _$DocumentShareCopyWithImpl<$Res, _$DocumentShareImpl>
    implements _$$DocumentShareImplCopyWith<$Res> {
  __$$DocumentShareImplCopyWithImpl(
      _$DocumentShareImpl _value, $Res Function(_$DocumentShareImpl) _then)
      : super(_value, _then);

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
    return _then(_$DocumentShareImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      clientId: null == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      documentId: null == documentId
          ? _value.documentId
          : documentId // ignore: cast_nullable_to_non_nullable
              as String,
      sharedBy: null == sharedBy
          ? _value.sharedBy
          : sharedBy // ignore: cast_nullable_to_non_nullable
              as String,
      sharedWith: null == sharedWith
          ? _value._sharedWith
          : sharedWith // ignore: cast_nullable_to_non_nullable
              as List<String>,
      permissions: null == permissions
          ? _value._permissions
          : permissions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      sharedAt: null == sharedAt
          ? _value.sharedAt
          : sharedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DocumentShareImpl implements _DocumentShare {
  const _$DocumentShareImpl(
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

  factory _$DocumentShareImpl.fromJson(Map<String, dynamic> json) =>
      _$$DocumentShareImplFromJson(json);

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

  @override
  String toString() {
    return 'DocumentShare(id: $id, clientId: $clientId, documentId: $documentId, sharedBy: $sharedBy, sharedWith: $sharedWith, permissions: $permissions, sharedAt: $sharedAt, expiresAt: $expiresAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DocumentShareImpl &&
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

  @JsonKey(ignore: true)
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

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DocumentShareImplCopyWith<_$DocumentShareImpl> get copyWith =>
      __$$DocumentShareImplCopyWithImpl<_$DocumentShareImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DocumentShareImplToJson(
      this,
    );
  }
}

abstract class _DocumentShare implements DocumentShare {
  const factory _DocumentShare(
      {required final String id,
      required final String clientId,
      required final String documentId,
      required final String sharedBy,
      required final List<String> sharedWith,
      required final List<String> permissions,
      required final DateTime sharedAt,
      final DateTime? expiresAt}) = _$DocumentShareImpl;

  factory _DocumentShare.fromJson(Map<String, dynamic> json) =
      _$DocumentShareImpl.fromJson;

  @override
  String get id;
  @override
  String get clientId;
  @override
  String get documentId;
  @override
  String get sharedBy;
  @override
  List<String> get sharedWith;
  @override
  List<String> get permissions;
  @override
  DateTime get sharedAt;
  @override
  DateTime? get expiresAt;
  @override
  @JsonKey(ignore: true)
  _$$DocumentShareImplCopyWith<_$DocumentShareImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PushNotification _$PushNotificationFromJson(Map<String, dynamic> json) {
  return _PushNotification.fromJson(json);
}

/// @nodoc
mixin _$PushNotification {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get body => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get priority =>
      throw _privateConstructorUsedError; // 'critical', 'high', 'normal', 'low'
  Map<String, dynamic>? get data => throw _privateConstructorUsedError;
  List<NotificationAction>? get actions => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  bool? get read => throw _privateConstructorUsedError;
  DateTime? get readAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PushNotificationCopyWith<PushNotification> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PushNotificationCopyWith<$Res> {
  factory $PushNotificationCopyWith(
          PushNotification value, $Res Function(PushNotification) then) =
      _$PushNotificationCopyWithImpl<$Res, PushNotification>;
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
class _$PushNotificationCopyWithImpl<$Res, $Val extends PushNotification>
    implements $PushNotificationCopyWith<$Res> {
  _$PushNotificationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as String,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      actions: freezed == actions
          ? _value.actions
          : actions // ignore: cast_nullable_to_non_nullable
              as List<NotificationAction>?,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      read: freezed == read
          ? _value.read
          : read // ignore: cast_nullable_to_non_nullable
              as bool?,
      readAt: freezed == readAt
          ? _value.readAt
          : readAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PushNotificationImplCopyWith<$Res>
    implements $PushNotificationCopyWith<$Res> {
  factory _$$PushNotificationImplCopyWith(_$PushNotificationImpl value,
          $Res Function(_$PushNotificationImpl) then) =
      __$$PushNotificationImplCopyWithImpl<$Res>;
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
class __$$PushNotificationImplCopyWithImpl<$Res>
    extends _$PushNotificationCopyWithImpl<$Res, _$PushNotificationImpl>
    implements _$$PushNotificationImplCopyWith<$Res> {
  __$$PushNotificationImplCopyWithImpl(_$PushNotificationImpl _value,
      $Res Function(_$PushNotificationImpl) _then)
      : super(_value, _then);

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
    return _then(_$PushNotificationImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as String,
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      actions: freezed == actions
          ? _value._actions
          : actions // ignore: cast_nullable_to_non_nullable
              as List<NotificationAction>?,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      read: freezed == read
          ? _value.read
          : read // ignore: cast_nullable_to_non_nullable
              as bool?,
      readAt: freezed == readAt
          ? _value.readAt
          : readAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PushNotificationImpl implements _PushNotification {
  const _$PushNotificationImpl(
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

  factory _$PushNotificationImpl.fromJson(Map<String, dynamic> json) =>
      _$$PushNotificationImplFromJson(json);

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

  @override
  String toString() {
    return 'PushNotification(id: $id, userId: $userId, title: $title, body: $body, type: $type, priority: $priority, data: $data, actions: $actions, timestamp: $timestamp, read: $read, readAt: $readAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PushNotificationImpl &&
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

  @JsonKey(ignore: true)
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

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PushNotificationImplCopyWith<_$PushNotificationImpl> get copyWith =>
      __$$PushNotificationImplCopyWithImpl<_$PushNotificationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PushNotificationImplToJson(
      this,
    );
  }
}

abstract class _PushNotification implements PushNotification {
  const factory _PushNotification(
      {required final String id,
      required final String userId,
      required final String title,
      required final String body,
      required final String type,
      required final String priority,
      final Map<String, dynamic>? data,
      final List<NotificationAction>? actions,
      required final DateTime timestamp,
      final bool? read,
      final DateTime? readAt}) = _$PushNotificationImpl;

  factory _PushNotification.fromJson(Map<String, dynamic> json) =
      _$PushNotificationImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get title;
  @override
  String get body;
  @override
  String get type;
  @override
  String get priority;
  @override // 'critical', 'high', 'normal', 'low'
  Map<String, dynamic>? get data;
  @override
  List<NotificationAction>? get actions;
  @override
  DateTime get timestamp;
  @override
  bool? get read;
  @override
  DateTime? get readAt;
  @override
  @JsonKey(ignore: true)
  _$$PushNotificationImplCopyWith<_$PushNotificationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NotificationAction _$NotificationActionFromJson(Map<String, dynamic> json) {
  return _NotificationAction.fromJson(json);
}

/// @nodoc
mixin _$NotificationAction {
  String get id => throw _privateConstructorUsedError;
  String get label => throw _privateConstructorUsedError;
  String get action => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NotificationActionCopyWith<NotificationAction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationActionCopyWith<$Res> {
  factory $NotificationActionCopyWith(
          NotificationAction value, $Res Function(NotificationAction) then) =
      _$NotificationActionCopyWithImpl<$Res, NotificationAction>;
  @useResult
  $Res call({String id, String label, String action});
}

/// @nodoc
class _$NotificationActionCopyWithImpl<$Res, $Val extends NotificationAction>
    implements $NotificationActionCopyWith<$Res> {
  _$NotificationActionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? label = null,
    Object? action = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      action: null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NotificationActionImplCopyWith<$Res>
    implements $NotificationActionCopyWith<$Res> {
  factory _$$NotificationActionImplCopyWith(_$NotificationActionImpl value,
          $Res Function(_$NotificationActionImpl) then) =
      __$$NotificationActionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String label, String action});
}

/// @nodoc
class __$$NotificationActionImplCopyWithImpl<$Res>
    extends _$NotificationActionCopyWithImpl<$Res, _$NotificationActionImpl>
    implements _$$NotificationActionImplCopyWith<$Res> {
  __$$NotificationActionImplCopyWithImpl(_$NotificationActionImpl _value,
      $Res Function(_$NotificationActionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? label = null,
    Object? action = null,
  }) {
    return _then(_$NotificationActionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      action: null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationActionImpl implements _NotificationAction {
  const _$NotificationActionImpl(
      {required this.id, required this.label, required this.action});

  factory _$NotificationActionImpl.fromJson(Map<String, dynamic> json) =>
      _$$NotificationActionImplFromJson(json);

  @override
  final String id;
  @override
  final String label;
  @override
  final String action;

  @override
  String toString() {
    return 'NotificationAction(id: $id, label: $label, action: $action)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationActionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.action, action) || other.action == action));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, label, action);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationActionImplCopyWith<_$NotificationActionImpl> get copyWith =>
      __$$NotificationActionImplCopyWithImpl<_$NotificationActionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationActionImplToJson(
      this,
    );
  }
}

abstract class _NotificationAction implements NotificationAction {
  const factory _NotificationAction(
      {required final String id,
      required final String label,
      required final String action}) = _$NotificationActionImpl;

  factory _NotificationAction.fromJson(Map<String, dynamic> json) =
      _$NotificationActionImpl.fromJson;

  @override
  String get id;
  @override
  String get label;
  @override
  String get action;
  @override
  @JsonKey(ignore: true)
  _$$NotificationActionImplCopyWith<_$NotificationActionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WebSocketEvent _$WebSocketEventFromJson(Map<String, dynamic> json) {
  return _WebSocketEvent.fromJson(json);
}

/// @nodoc
mixin _$WebSocketEvent {
  String get event => throw _privateConstructorUsedError;
  Map<String, dynamic> get data => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WebSocketEventCopyWith<WebSocketEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WebSocketEventCopyWith<$Res> {
  factory $WebSocketEventCopyWith(
          WebSocketEvent value, $Res Function(WebSocketEvent) then) =
      _$WebSocketEventCopyWithImpl<$Res, WebSocketEvent>;
  @useResult
  $Res call({String event, Map<String, dynamic> data, DateTime timestamp});
}

/// @nodoc
class _$WebSocketEventCopyWithImpl<$Res, $Val extends WebSocketEvent>
    implements $WebSocketEventCopyWith<$Res> {
  _$WebSocketEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? event = null,
    Object? data = null,
    Object? timestamp = null,
  }) {
    return _then(_value.copyWith(
      event: null == event
          ? _value.event
          : event // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WebSocketEventImplCopyWith<$Res>
    implements $WebSocketEventCopyWith<$Res> {
  factory _$$WebSocketEventImplCopyWith(_$WebSocketEventImpl value,
          $Res Function(_$WebSocketEventImpl) then) =
      __$$WebSocketEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String event, Map<String, dynamic> data, DateTime timestamp});
}

/// @nodoc
class __$$WebSocketEventImplCopyWithImpl<$Res>
    extends _$WebSocketEventCopyWithImpl<$Res, _$WebSocketEventImpl>
    implements _$$WebSocketEventImplCopyWith<$Res> {
  __$$WebSocketEventImplCopyWithImpl(
      _$WebSocketEventImpl _value, $Res Function(_$WebSocketEventImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? event = null,
    Object? data = null,
    Object? timestamp = null,
  }) {
    return _then(_$WebSocketEventImpl(
      event: null == event
          ? _value.event
          : event // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WebSocketEventImpl implements _WebSocketEvent {
  const _$WebSocketEventImpl(
      {required this.event,
      required final Map<String, dynamic> data,
      required this.timestamp})
      : _data = data;

  factory _$WebSocketEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$WebSocketEventImplFromJson(json);

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

  @override
  String toString() {
    return 'WebSocketEvent(event: $event, data: $data, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WebSocketEventImpl &&
            (identical(other.event, event) || other.event == event) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, event,
      const DeepCollectionEquality().hash(_data), timestamp);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WebSocketEventImplCopyWith<_$WebSocketEventImpl> get copyWith =>
      __$$WebSocketEventImplCopyWithImpl<_$WebSocketEventImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WebSocketEventImplToJson(
      this,
    );
  }
}

abstract class _WebSocketEvent implements WebSocketEvent {
  const factory _WebSocketEvent(
      {required final String event,
      required final Map<String, dynamic> data,
      required final DateTime timestamp}) = _$WebSocketEventImpl;

  factory _WebSocketEvent.fromJson(Map<String, dynamic> json) =
      _$WebSocketEventImpl.fromJson;

  @override
  String get event;
  @override
  Map<String, dynamic> get data;
  @override
  DateTime get timestamp;
  @override
  @JsonKey(ignore: true)
  _$$WebSocketEventImplCopyWith<_$WebSocketEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ConnectionStatus _$ConnectionStatusFromJson(Map<String, dynamic> json) {
  return _ConnectionStatus.fromJson(json);
}

/// @nodoc
mixin _$ConnectionStatus {
  bool get connected => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  DateTime? get lastConnected => throw _privateConstructorUsedError;
  DateTime? get lastDisconnected => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ConnectionStatusCopyWith<ConnectionStatus> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConnectionStatusCopyWith<$Res> {
  factory $ConnectionStatusCopyWith(
          ConnectionStatus value, $Res Function(ConnectionStatus) then) =
      _$ConnectionStatusCopyWithImpl<$Res, ConnectionStatus>;
  @useResult
  $Res call(
      {bool connected,
      String? error,
      DateTime? lastConnected,
      DateTime? lastDisconnected});
}

/// @nodoc
class _$ConnectionStatusCopyWithImpl<$Res, $Val extends ConnectionStatus>
    implements $ConnectionStatusCopyWith<$Res> {
  _$ConnectionStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? connected = null,
    Object? error = freezed,
    Object? lastConnected = freezed,
    Object? lastDisconnected = freezed,
  }) {
    return _then(_value.copyWith(
      connected: null == connected
          ? _value.connected
          : connected // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      lastConnected: freezed == lastConnected
          ? _value.lastConnected
          : lastConnected // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastDisconnected: freezed == lastDisconnected
          ? _value.lastDisconnected
          : lastDisconnected // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ConnectionStatusImplCopyWith<$Res>
    implements $ConnectionStatusCopyWith<$Res> {
  factory _$$ConnectionStatusImplCopyWith(_$ConnectionStatusImpl value,
          $Res Function(_$ConnectionStatusImpl) then) =
      __$$ConnectionStatusImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool connected,
      String? error,
      DateTime? lastConnected,
      DateTime? lastDisconnected});
}

/// @nodoc
class __$$ConnectionStatusImplCopyWithImpl<$Res>
    extends _$ConnectionStatusCopyWithImpl<$Res, _$ConnectionStatusImpl>
    implements _$$ConnectionStatusImplCopyWith<$Res> {
  __$$ConnectionStatusImplCopyWithImpl(_$ConnectionStatusImpl _value,
      $Res Function(_$ConnectionStatusImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? connected = null,
    Object? error = freezed,
    Object? lastConnected = freezed,
    Object? lastDisconnected = freezed,
  }) {
    return _then(_$ConnectionStatusImpl(
      connected: null == connected
          ? _value.connected
          : connected // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      lastConnected: freezed == lastConnected
          ? _value.lastConnected
          : lastConnected // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastDisconnected: freezed == lastDisconnected
          ? _value.lastDisconnected
          : lastDisconnected // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ConnectionStatusImpl implements _ConnectionStatus {
  const _$ConnectionStatusImpl(
      {required this.connected,
      this.error,
      this.lastConnected,
      this.lastDisconnected});

  factory _$ConnectionStatusImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConnectionStatusImplFromJson(json);

  @override
  final bool connected;
  @override
  final String? error;
  @override
  final DateTime? lastConnected;
  @override
  final DateTime? lastDisconnected;

  @override
  String toString() {
    return 'ConnectionStatus(connected: $connected, error: $error, lastConnected: $lastConnected, lastDisconnected: $lastDisconnected)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConnectionStatusImpl &&
            (identical(other.connected, connected) ||
                other.connected == connected) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.lastConnected, lastConnected) ||
                other.lastConnected == lastConnected) &&
            (identical(other.lastDisconnected, lastDisconnected) ||
                other.lastDisconnected == lastDisconnected));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, connected, error, lastConnected, lastDisconnected);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ConnectionStatusImplCopyWith<_$ConnectionStatusImpl> get copyWith =>
      __$$ConnectionStatusImplCopyWithImpl<_$ConnectionStatusImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConnectionStatusImplToJson(
      this,
    );
  }
}

abstract class _ConnectionStatus implements ConnectionStatus {
  const factory _ConnectionStatus(
      {required final bool connected,
      final String? error,
      final DateTime? lastConnected,
      final DateTime? lastDisconnected}) = _$ConnectionStatusImpl;

  factory _ConnectionStatus.fromJson(Map<String, dynamic> json) =
      _$ConnectionStatusImpl.fromJson;

  @override
  bool get connected;
  @override
  String? get error;
  @override
  DateTime? get lastConnected;
  @override
  DateTime? get lastDisconnected;
  @override
  @JsonKey(ignore: true)
  _$$ConnectionStatusImplCopyWith<_$ConnectionStatusImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EmergencyAlert _$EmergencyAlertFromJson(Map<String, dynamic> json) {
  return _EmergencyAlert.fromJson(json);
}

/// @nodoc
mixin _$EmergencyAlert {
  String get id => throw _privateConstructorUsedError;
  String get appointmentId => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get userType => throw _privateConstructorUsedError;
  ClientLocation get location => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String get priority => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EmergencyAlertCopyWith<EmergencyAlert> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmergencyAlertCopyWith<$Res> {
  factory $EmergencyAlertCopyWith(
          EmergencyAlert value, $Res Function(EmergencyAlert) then) =
      _$EmergencyAlertCopyWithImpl<$Res, EmergencyAlert>;
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
class _$EmergencyAlertCopyWithImpl<$Res, $Val extends EmergencyAlert>
    implements $EmergencyAlertCopyWith<$Res> {
  _$EmergencyAlertCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      appointmentId: null == appointmentId
          ? _value.appointmentId
          : appointmentId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      userType: null == userType
          ? _value.userType
          : userType // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as ClientLocation,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ClientLocationCopyWith<$Res> get location {
    return $ClientLocationCopyWith<$Res>(_value.location, (value) {
      return _then(_value.copyWith(location: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$EmergencyAlertImplCopyWith<$Res>
    implements $EmergencyAlertCopyWith<$Res> {
  factory _$$EmergencyAlertImplCopyWith(_$EmergencyAlertImpl value,
          $Res Function(_$EmergencyAlertImpl) then) =
      __$$EmergencyAlertImplCopyWithImpl<$Res>;
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
class __$$EmergencyAlertImplCopyWithImpl<$Res>
    extends _$EmergencyAlertCopyWithImpl<$Res, _$EmergencyAlertImpl>
    implements _$$EmergencyAlertImplCopyWith<$Res> {
  __$$EmergencyAlertImplCopyWithImpl(
      _$EmergencyAlertImpl _value, $Res Function(_$EmergencyAlertImpl) _then)
      : super(_value, _then);

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
    return _then(_$EmergencyAlertImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      appointmentId: null == appointmentId
          ? _value.appointmentId
          : appointmentId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      userType: null == userType
          ? _value.userType
          : userType // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as ClientLocation,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EmergencyAlertImpl implements _EmergencyAlert {
  const _$EmergencyAlertImpl(
      {required this.id,
      required this.appointmentId,
      required this.userId,
      required this.userType,
      required this.location,
      required this.message,
      required this.timestamp,
      required this.status,
      required this.priority});

  factory _$EmergencyAlertImpl.fromJson(Map<String, dynamic> json) =>
      _$$EmergencyAlertImplFromJson(json);

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

  @override
  String toString() {
    return 'EmergencyAlert(id: $id, appointmentId: $appointmentId, userId: $userId, userType: $userType, location: $location, message: $message, timestamp: $timestamp, status: $status, priority: $priority)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmergencyAlertImpl &&
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

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, appointmentId, userId,
      userType, location, message, timestamp, status, priority);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EmergencyAlertImplCopyWith<_$EmergencyAlertImpl> get copyWith =>
      __$$EmergencyAlertImplCopyWithImpl<_$EmergencyAlertImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EmergencyAlertImplToJson(
      this,
    );
  }
}

abstract class _EmergencyAlert implements EmergencyAlert {
  const factory _EmergencyAlert(
      {required final String id,
      required final String appointmentId,
      required final String userId,
      required final String userType,
      required final ClientLocation location,
      required final String message,
      required final DateTime timestamp,
      required final String status,
      required final String priority}) = _$EmergencyAlertImpl;

  factory _EmergencyAlert.fromJson(Map<String, dynamic> json) =
      _$EmergencyAlertImpl.fromJson;

  @override
  String get id;
  @override
  String get appointmentId;
  @override
  String get userId;
  @override
  String get userType;
  @override
  ClientLocation get location;
  @override
  String get message;
  @override
  DateTime get timestamp;
  @override
  String get status;
  @override
  String get priority;
  @override
  @JsonKey(ignore: true)
  _$$EmergencyAlertImplCopyWith<_$EmergencyAlertImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RealtimePortalDashboard _$RealtimePortalDashboardFromJson(
    Map<String, dynamic> json) {
  return _RealtimePortalDashboard.fromJson(json);
}

/// @nodoc
mixin _$RealtimePortalDashboard {
  List<AppointmentStatus> get upcomingAppointments =>
      throw _privateConstructorUsedError;
  LiveLocation? get activeTracking => throw _privateConstructorUsedError;
  int? get unreadMessages => throw _privateConstructorUsedError;
  List<PushNotification>? get recentNotifications =>
      throw _privateConstructorUsedError;
  List<FamilyMember>? get familyMembers => throw _privateConstructorUsedError;
  ServiceConfirmation? get lastServiceConfirmation =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RealtimePortalDashboardCopyWith<RealtimePortalDashboard> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RealtimePortalDashboardCopyWith<$Res> {
  factory $RealtimePortalDashboardCopyWith(RealtimePortalDashboard value,
          $Res Function(RealtimePortalDashboard) then) =
      _$RealtimePortalDashboardCopyWithImpl<$Res, RealtimePortalDashboard>;
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
class _$RealtimePortalDashboardCopyWithImpl<$Res,
        $Val extends RealtimePortalDashboard>
    implements $RealtimePortalDashboardCopyWith<$Res> {
  _$RealtimePortalDashboardCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      upcomingAppointments: null == upcomingAppointments
          ? _value.upcomingAppointments
          : upcomingAppointments // ignore: cast_nullable_to_non_nullable
              as List<AppointmentStatus>,
      activeTracking: freezed == activeTracking
          ? _value.activeTracking
          : activeTracking // ignore: cast_nullable_to_non_nullable
              as LiveLocation?,
      unreadMessages: freezed == unreadMessages
          ? _value.unreadMessages
          : unreadMessages // ignore: cast_nullable_to_non_nullable
              as int?,
      recentNotifications: freezed == recentNotifications
          ? _value.recentNotifications
          : recentNotifications // ignore: cast_nullable_to_non_nullable
              as List<PushNotification>?,
      familyMembers: freezed == familyMembers
          ? _value.familyMembers
          : familyMembers // ignore: cast_nullable_to_non_nullable
              as List<FamilyMember>?,
      lastServiceConfirmation: freezed == lastServiceConfirmation
          ? _value.lastServiceConfirmation
          : lastServiceConfirmation // ignore: cast_nullable_to_non_nullable
              as ServiceConfirmation?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $LiveLocationCopyWith<$Res>? get activeTracking {
    if (_value.activeTracking == null) {
      return null;
    }

    return $LiveLocationCopyWith<$Res>(_value.activeTracking!, (value) {
      return _then(_value.copyWith(activeTracking: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ServiceConfirmationCopyWith<$Res>? get lastServiceConfirmation {
    if (_value.lastServiceConfirmation == null) {
      return null;
    }

    return $ServiceConfirmationCopyWith<$Res>(_value.lastServiceConfirmation!,
        (value) {
      return _then(_value.copyWith(lastServiceConfirmation: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$RealtimePortalDashboardImplCopyWith<$Res>
    implements $RealtimePortalDashboardCopyWith<$Res> {
  factory _$$RealtimePortalDashboardImplCopyWith(
          _$RealtimePortalDashboardImpl value,
          $Res Function(_$RealtimePortalDashboardImpl) then) =
      __$$RealtimePortalDashboardImplCopyWithImpl<$Res>;
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
class __$$RealtimePortalDashboardImplCopyWithImpl<$Res>
    extends _$RealtimePortalDashboardCopyWithImpl<$Res,
        _$RealtimePortalDashboardImpl>
    implements _$$RealtimePortalDashboardImplCopyWith<$Res> {
  __$$RealtimePortalDashboardImplCopyWithImpl(
      _$RealtimePortalDashboardImpl _value,
      $Res Function(_$RealtimePortalDashboardImpl) _then)
      : super(_value, _then);

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
    return _then(_$RealtimePortalDashboardImpl(
      upcomingAppointments: null == upcomingAppointments
          ? _value._upcomingAppointments
          : upcomingAppointments // ignore: cast_nullable_to_non_nullable
              as List<AppointmentStatus>,
      activeTracking: freezed == activeTracking
          ? _value.activeTracking
          : activeTracking // ignore: cast_nullable_to_non_nullable
              as LiveLocation?,
      unreadMessages: freezed == unreadMessages
          ? _value.unreadMessages
          : unreadMessages // ignore: cast_nullable_to_non_nullable
              as int?,
      recentNotifications: freezed == recentNotifications
          ? _value._recentNotifications
          : recentNotifications // ignore: cast_nullable_to_non_nullable
              as List<PushNotification>?,
      familyMembers: freezed == familyMembers
          ? _value._familyMembers
          : familyMembers // ignore: cast_nullable_to_non_nullable
              as List<FamilyMember>?,
      lastServiceConfirmation: freezed == lastServiceConfirmation
          ? _value.lastServiceConfirmation
          : lastServiceConfirmation // ignore: cast_nullable_to_non_nullable
              as ServiceConfirmation?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RealtimePortalDashboardImpl implements _RealtimePortalDashboard {
  const _$RealtimePortalDashboardImpl(
      {required final List<AppointmentStatus> upcomingAppointments,
      this.activeTracking,
      this.unreadMessages,
      final List<PushNotification>? recentNotifications,
      final List<FamilyMember>? familyMembers,
      this.lastServiceConfirmation})
      : _upcomingAppointments = upcomingAppointments,
        _recentNotifications = recentNotifications,
        _familyMembers = familyMembers;

  factory _$RealtimePortalDashboardImpl.fromJson(Map<String, dynamic> json) =>
      _$$RealtimePortalDashboardImplFromJson(json);

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

  @override
  String toString() {
    return 'RealtimePortalDashboard(upcomingAppointments: $upcomingAppointments, activeTracking: $activeTracking, unreadMessages: $unreadMessages, recentNotifications: $recentNotifications, familyMembers: $familyMembers, lastServiceConfirmation: $lastServiceConfirmation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RealtimePortalDashboardImpl &&
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

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_upcomingAppointments),
      activeTracking,
      unreadMessages,
      const DeepCollectionEquality().hash(_recentNotifications),
      const DeepCollectionEquality().hash(_familyMembers),
      lastServiceConfirmation);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RealtimePortalDashboardImplCopyWith<_$RealtimePortalDashboardImpl>
      get copyWith => __$$RealtimePortalDashboardImplCopyWithImpl<
          _$RealtimePortalDashboardImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RealtimePortalDashboardImplToJson(
      this,
    );
  }
}

abstract class _RealtimePortalDashboard implements RealtimePortalDashboard {
  const factory _RealtimePortalDashboard(
          {required final List<AppointmentStatus> upcomingAppointments,
          final LiveLocation? activeTracking,
          final int? unreadMessages,
          final List<PushNotification>? recentNotifications,
          final List<FamilyMember>? familyMembers,
          final ServiceConfirmation? lastServiceConfirmation}) =
      _$RealtimePortalDashboardImpl;

  factory _RealtimePortalDashboard.fromJson(Map<String, dynamic> json) =
      _$RealtimePortalDashboardImpl.fromJson;

  @override
  List<AppointmentStatus> get upcomingAppointments;
  @override
  LiveLocation? get activeTracking;
  @override
  int? get unreadMessages;
  @override
  List<PushNotification>? get recentNotifications;
  @override
  List<FamilyMember>? get familyMembers;
  @override
  ServiceConfirmation? get lastServiceConfirmation;
  @override
  @JsonKey(ignore: true)
  _$$RealtimePortalDashboardImplCopyWith<_$RealtimePortalDashboardImpl>
      get copyWith => throw _privateConstructorUsedError;
}
