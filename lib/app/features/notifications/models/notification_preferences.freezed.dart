// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_preferences.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

NotificationPreferences _$NotificationPreferencesFromJson(
    Map<String, dynamic> json) {
  return _NotificationPreferences.fromJson(json);
}

/// @nodoc
mixin _$NotificationPreferences {
  String get userId => throw _privateConstructorUsedError;
  Map<NotificationCategory, bool> get categoryEnabled =>
      throw _privateConstructorUsedError;
  Map<NotificationCategory, List<NotificationChannel>> get categoryChannels =>
      throw _privateConstructorUsedError;
  QuietHours get quietHours => throw _privateConstructorUsedError;
  bool get smartTimingEnabled => throw _privateConstructorUsedError;
  bool get geofenceEnabled => throw _privateConstructorUsedError;
  double get geofenceRadiusKm => throw _privateConstructorUsedError;
  bool get soundEnabled => throw _privateConstructorUsedError;
  bool get vibrationEnabled => throw _privateConstructorUsedError;
  bool get badgeEnabled => throw _privateConstructorUsedError;
  DateTime? get lastUpdated => throw _privateConstructorUsedError;

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
      {String userId,
      Map<NotificationCategory, bool> categoryEnabled,
      Map<NotificationCategory, List<NotificationChannel>> categoryChannels,
      QuietHours quietHours,
      bool smartTimingEnabled,
      bool geofenceEnabled,
      double geofenceRadiusKm,
      bool soundEnabled,
      bool vibrationEnabled,
      bool badgeEnabled,
      DateTime? lastUpdated});

  $QuietHoursCopyWith<$Res> get quietHours;
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
    Object? userId = null,
    Object? categoryEnabled = null,
    Object? categoryChannels = null,
    Object? quietHours = null,
    Object? smartTimingEnabled = null,
    Object? geofenceEnabled = null,
    Object? geofenceRadiusKm = null,
    Object? soundEnabled = null,
    Object? vibrationEnabled = null,
    Object? badgeEnabled = null,
    Object? lastUpdated = freezed,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      categoryEnabled: null == categoryEnabled
          ? _value.categoryEnabled
          : categoryEnabled // ignore: cast_nullable_to_non_nullable
              as Map<NotificationCategory, bool>,
      categoryChannels: null == categoryChannels
          ? _value.categoryChannels
          : categoryChannels // ignore: cast_nullable_to_non_nullable
              as Map<NotificationCategory, List<NotificationChannel>>,
      quietHours: null == quietHours
          ? _value.quietHours
          : quietHours // ignore: cast_nullable_to_non_nullable
              as QuietHours,
      smartTimingEnabled: null == smartTimingEnabled
          ? _value.smartTimingEnabled
          : smartTimingEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      geofenceEnabled: null == geofenceEnabled
          ? _value.geofenceEnabled
          : geofenceEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      geofenceRadiusKm: null == geofenceRadiusKm
          ? _value.geofenceRadiusKm
          : geofenceRadiusKm // ignore: cast_nullable_to_non_nullable
              as double,
      soundEnabled: null == soundEnabled
          ? _value.soundEnabled
          : soundEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      vibrationEnabled: null == vibrationEnabled
          ? _value.vibrationEnabled
          : vibrationEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      badgeEnabled: null == badgeEnabled
          ? _value.badgeEnabled
          : badgeEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      lastUpdated: freezed == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $QuietHoursCopyWith<$Res> get quietHours {
    return $QuietHoursCopyWith<$Res>(_value.quietHours, (value) {
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
      {String userId,
      Map<NotificationCategory, bool> categoryEnabled,
      Map<NotificationCategory, List<NotificationChannel>> categoryChannels,
      QuietHours quietHours,
      bool smartTimingEnabled,
      bool geofenceEnabled,
      double geofenceRadiusKm,
      bool soundEnabled,
      bool vibrationEnabled,
      bool badgeEnabled,
      DateTime? lastUpdated});

  @override
  $QuietHoursCopyWith<$Res> get quietHours;
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
    Object? userId = null,
    Object? categoryEnabled = null,
    Object? categoryChannels = null,
    Object? quietHours = null,
    Object? smartTimingEnabled = null,
    Object? geofenceEnabled = null,
    Object? geofenceRadiusKm = null,
    Object? soundEnabled = null,
    Object? vibrationEnabled = null,
    Object? badgeEnabled = null,
    Object? lastUpdated = freezed,
  }) {
    return _then(_$NotificationPreferencesImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      categoryEnabled: null == categoryEnabled
          ? _value._categoryEnabled
          : categoryEnabled // ignore: cast_nullable_to_non_nullable
              as Map<NotificationCategory, bool>,
      categoryChannels: null == categoryChannels
          ? _value._categoryChannels
          : categoryChannels // ignore: cast_nullable_to_non_nullable
              as Map<NotificationCategory, List<NotificationChannel>>,
      quietHours: null == quietHours
          ? _value.quietHours
          : quietHours // ignore: cast_nullable_to_non_nullable
              as QuietHours,
      smartTimingEnabled: null == smartTimingEnabled
          ? _value.smartTimingEnabled
          : smartTimingEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      geofenceEnabled: null == geofenceEnabled
          ? _value.geofenceEnabled
          : geofenceEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      geofenceRadiusKm: null == geofenceRadiusKm
          ? _value.geofenceRadiusKm
          : geofenceRadiusKm // ignore: cast_nullable_to_non_nullable
              as double,
      soundEnabled: null == soundEnabled
          ? _value.soundEnabled
          : soundEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      vibrationEnabled: null == vibrationEnabled
          ? _value.vibrationEnabled
          : vibrationEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      badgeEnabled: null == badgeEnabled
          ? _value.badgeEnabled
          : badgeEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      lastUpdated: freezed == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationPreferencesImpl implements _NotificationPreferences {
  const _$NotificationPreferencesImpl(
      {required this.userId,
      required final Map<NotificationCategory, bool> categoryEnabled,
      required final Map<NotificationCategory, List<NotificationChannel>>
          categoryChannels,
      required this.quietHours,
      this.smartTimingEnabled = true,
      this.geofenceEnabled = true,
      this.geofenceRadiusKm = 5.0,
      this.soundEnabled = true,
      this.vibrationEnabled = true,
      this.badgeEnabled = true,
      this.lastUpdated})
      : _categoryEnabled = categoryEnabled,
        _categoryChannels = categoryChannels;

  factory _$NotificationPreferencesImpl.fromJson(Map<String, dynamic> json) =>
      _$$NotificationPreferencesImplFromJson(json);

  @override
  final String userId;
  final Map<NotificationCategory, bool> _categoryEnabled;
  @override
  Map<NotificationCategory, bool> get categoryEnabled {
    if (_categoryEnabled is EqualUnmodifiableMapView) return _categoryEnabled;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_categoryEnabled);
  }

  final Map<NotificationCategory, List<NotificationChannel>> _categoryChannels;
  @override
  Map<NotificationCategory, List<NotificationChannel>> get categoryChannels {
    if (_categoryChannels is EqualUnmodifiableMapView) return _categoryChannels;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_categoryChannels);
  }

  @override
  final QuietHours quietHours;
  @override
  @JsonKey()
  final bool smartTimingEnabled;
  @override
  @JsonKey()
  final bool geofenceEnabled;
  @override
  @JsonKey()
  final double geofenceRadiusKm;
  @override
  @JsonKey()
  final bool soundEnabled;
  @override
  @JsonKey()
  final bool vibrationEnabled;
  @override
  @JsonKey()
  final bool badgeEnabled;
  @override
  final DateTime? lastUpdated;

  @override
  String toString() {
    return 'NotificationPreferences(userId: $userId, categoryEnabled: $categoryEnabled, categoryChannels: $categoryChannels, quietHours: $quietHours, smartTimingEnabled: $smartTimingEnabled, geofenceEnabled: $geofenceEnabled, geofenceRadiusKm: $geofenceRadiusKm, soundEnabled: $soundEnabled, vibrationEnabled: $vibrationEnabled, badgeEnabled: $badgeEnabled, lastUpdated: $lastUpdated)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationPreferencesImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            const DeepCollectionEquality()
                .equals(other._categoryEnabled, _categoryEnabled) &&
            const DeepCollectionEquality()
                .equals(other._categoryChannels, _categoryChannels) &&
            (identical(other.quietHours, quietHours) ||
                other.quietHours == quietHours) &&
            (identical(other.smartTimingEnabled, smartTimingEnabled) ||
                other.smartTimingEnabled == smartTimingEnabled) &&
            (identical(other.geofenceEnabled, geofenceEnabled) ||
                other.geofenceEnabled == geofenceEnabled) &&
            (identical(other.geofenceRadiusKm, geofenceRadiusKm) ||
                other.geofenceRadiusKm == geofenceRadiusKm) &&
            (identical(other.soundEnabled, soundEnabled) ||
                other.soundEnabled == soundEnabled) &&
            (identical(other.vibrationEnabled, vibrationEnabled) ||
                other.vibrationEnabled == vibrationEnabled) &&
            (identical(other.badgeEnabled, badgeEnabled) ||
                other.badgeEnabled == badgeEnabled) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      userId,
      const DeepCollectionEquality().hash(_categoryEnabled),
      const DeepCollectionEquality().hash(_categoryChannels),
      quietHours,
      smartTimingEnabled,
      geofenceEnabled,
      geofenceRadiusKm,
      soundEnabled,
      vibrationEnabled,
      badgeEnabled,
      lastUpdated);

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
      {required final String userId,
      required final Map<NotificationCategory, bool> categoryEnabled,
      required final Map<NotificationCategory, List<NotificationChannel>>
          categoryChannels,
      required final QuietHours quietHours,
      final bool smartTimingEnabled,
      final bool geofenceEnabled,
      final double geofenceRadiusKm,
      final bool soundEnabled,
      final bool vibrationEnabled,
      final bool badgeEnabled,
      final DateTime? lastUpdated}) = _$NotificationPreferencesImpl;

  factory _NotificationPreferences.fromJson(Map<String, dynamic> json) =
      _$NotificationPreferencesImpl.fromJson;

  @override
  String get userId;
  @override
  Map<NotificationCategory, bool> get categoryEnabled;
  @override
  Map<NotificationCategory, List<NotificationChannel>> get categoryChannels;
  @override
  QuietHours get quietHours;
  @override
  bool get smartTimingEnabled;
  @override
  bool get geofenceEnabled;
  @override
  double get geofenceRadiusKm;
  @override
  bool get soundEnabled;
  @override
  bool get vibrationEnabled;
  @override
  bool get badgeEnabled;
  @override
  DateTime? get lastUpdated;
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
  bool get enabled => throw _privateConstructorUsedError;
  String get startTime => throw _privateConstructorUsedError; // HH:mm format
  String get endTime => throw _privateConstructorUsedError; // HH:mm format
  List<int> get daysOfWeek => throw _privateConstructorUsedError;

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
  $Res call(
      {bool enabled, String startTime, String endTime, List<int> daysOfWeek});
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
    Object? enabled = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? daysOfWeek = null,
  }) {
    return _then(_value.copyWith(
      enabled: null == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as String,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as String,
      daysOfWeek: null == daysOfWeek
          ? _value.daysOfWeek
          : daysOfWeek // ignore: cast_nullable_to_non_nullable
              as List<int>,
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
  $Res call(
      {bool enabled, String startTime, String endTime, List<int> daysOfWeek});
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
    Object? enabled = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? daysOfWeek = null,
  }) {
    return _then(_$QuietHoursImpl(
      enabled: null == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as String,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as String,
      daysOfWeek: null == daysOfWeek
          ? _value._daysOfWeek
          : daysOfWeek // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$QuietHoursImpl implements _QuietHours {
  const _$QuietHoursImpl(
      {this.enabled = false,
      this.startTime = '22:00',
      this.endTime = '08:00',
      final List<int> daysOfWeek = const []})
      : _daysOfWeek = daysOfWeek;

  factory _$QuietHoursImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuietHoursImplFromJson(json);

  @override
  @JsonKey()
  final bool enabled;
  @override
  @JsonKey()
  final String startTime;
// HH:mm format
  @override
  @JsonKey()
  final String endTime;
// HH:mm format
  final List<int> _daysOfWeek;
// HH:mm format
  @override
  @JsonKey()
  List<int> get daysOfWeek {
    if (_daysOfWeek is EqualUnmodifiableListView) return _daysOfWeek;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_daysOfWeek);
  }

  @override
  String toString() {
    return 'QuietHours(enabled: $enabled, startTime: $startTime, endTime: $endTime, daysOfWeek: $daysOfWeek)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuietHoursImpl &&
            (identical(other.enabled, enabled) || other.enabled == enabled) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            const DeepCollectionEquality()
                .equals(other._daysOfWeek, _daysOfWeek));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, enabled, startTime, endTime,
      const DeepCollectionEquality().hash(_daysOfWeek));

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
      {final bool enabled,
      final String startTime,
      final String endTime,
      final List<int> daysOfWeek}) = _$QuietHoursImpl;

  factory _QuietHours.fromJson(Map<String, dynamic> json) =
      _$QuietHoursImpl.fromJson;

  @override
  bool get enabled;
  @override
  String get startTime;
  @override // HH:mm format
  String get endTime;
  @override // HH:mm format
  List<int> get daysOfWeek;
  @override
  @JsonKey(ignore: true)
  _$$QuietHoursImplCopyWith<_$QuietHoursImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GeofenceEvent _$GeofenceEventFromJson(Map<String, dynamic> json) {
  return _GeofenceEvent.fromJson(json);
}

/// @nodoc
mixin _$GeofenceEvent {
  String get eventId => throw _privateConstructorUsedError;
  String get workerId => throw _privateConstructorUsedError;
  String get workerName => throw _privateConstructorUsedError;
  String get appointmentId => throw _privateConstructorUsedError;
  String get clientName => throw _privateConstructorUsedError;
  String get clientAddress => throw _privateConstructorUsedError;
  GeofenceEventType get eventType => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;
  double? get distanceMeters => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;

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
      {String eventId,
      String workerId,
      String workerName,
      String appointmentId,
      String clientName,
      String clientAddress,
      GeofenceEventType eventType,
      DateTime timestamp,
      double latitude,
      double longitude,
      double? distanceMeters,
      String? notes});
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
    Object? eventId = null,
    Object? workerId = null,
    Object? workerName = null,
    Object? appointmentId = null,
    Object? clientName = null,
    Object? clientAddress = null,
    Object? eventType = null,
    Object? timestamp = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? distanceMeters = freezed,
    Object? notes = freezed,
  }) {
    return _then(_value.copyWith(
      eventId: null == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as String,
      workerId: null == workerId
          ? _value.workerId
          : workerId // ignore: cast_nullable_to_non_nullable
              as String,
      workerName: null == workerName
          ? _value.workerName
          : workerName // ignore: cast_nullable_to_non_nullable
              as String,
      appointmentId: null == appointmentId
          ? _value.appointmentId
          : appointmentId // ignore: cast_nullable_to_non_nullable
              as String,
      clientName: null == clientName
          ? _value.clientName
          : clientName // ignore: cast_nullable_to_non_nullable
              as String,
      clientAddress: null == clientAddress
          ? _value.clientAddress
          : clientAddress // ignore: cast_nullable_to_non_nullable
              as String,
      eventType: null == eventType
          ? _value.eventType
          : eventType // ignore: cast_nullable_to_non_nullable
              as GeofenceEventType,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      distanceMeters: freezed == distanceMeters
          ? _value.distanceMeters
          : distanceMeters // ignore: cast_nullable_to_non_nullable
              as double?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
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
      {String eventId,
      String workerId,
      String workerName,
      String appointmentId,
      String clientName,
      String clientAddress,
      GeofenceEventType eventType,
      DateTime timestamp,
      double latitude,
      double longitude,
      double? distanceMeters,
      String? notes});
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
    Object? eventId = null,
    Object? workerId = null,
    Object? workerName = null,
    Object? appointmentId = null,
    Object? clientName = null,
    Object? clientAddress = null,
    Object? eventType = null,
    Object? timestamp = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? distanceMeters = freezed,
    Object? notes = freezed,
  }) {
    return _then(_$GeofenceEventImpl(
      eventId: null == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as String,
      workerId: null == workerId
          ? _value.workerId
          : workerId // ignore: cast_nullable_to_non_nullable
              as String,
      workerName: null == workerName
          ? _value.workerName
          : workerName // ignore: cast_nullable_to_non_nullable
              as String,
      appointmentId: null == appointmentId
          ? _value.appointmentId
          : appointmentId // ignore: cast_nullable_to_non_nullable
              as String,
      clientName: null == clientName
          ? _value.clientName
          : clientName // ignore: cast_nullable_to_non_nullable
              as String,
      clientAddress: null == clientAddress
          ? _value.clientAddress
          : clientAddress // ignore: cast_nullable_to_non_nullable
              as String,
      eventType: null == eventType
          ? _value.eventType
          : eventType // ignore: cast_nullable_to_non_nullable
              as GeofenceEventType,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      distanceMeters: freezed == distanceMeters
          ? _value.distanceMeters
          : distanceMeters // ignore: cast_nullable_to_non_nullable
              as double?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GeofenceEventImpl implements _GeofenceEvent {
  const _$GeofenceEventImpl(
      {required this.eventId,
      required this.workerId,
      required this.workerName,
      required this.appointmentId,
      required this.clientName,
      required this.clientAddress,
      required this.eventType,
      required this.timestamp,
      required this.latitude,
      required this.longitude,
      this.distanceMeters,
      this.notes});

  factory _$GeofenceEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$GeofenceEventImplFromJson(json);

  @override
  final String eventId;
  @override
  final String workerId;
  @override
  final String workerName;
  @override
  final String appointmentId;
  @override
  final String clientName;
  @override
  final String clientAddress;
  @override
  final GeofenceEventType eventType;
  @override
  final DateTime timestamp;
  @override
  final double latitude;
  @override
  final double longitude;
  @override
  final double? distanceMeters;
  @override
  final String? notes;

  @override
  String toString() {
    return 'GeofenceEvent(eventId: $eventId, workerId: $workerId, workerName: $workerName, appointmentId: $appointmentId, clientName: $clientName, clientAddress: $clientAddress, eventType: $eventType, timestamp: $timestamp, latitude: $latitude, longitude: $longitude, distanceMeters: $distanceMeters, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GeofenceEventImpl &&
            (identical(other.eventId, eventId) || other.eventId == eventId) &&
            (identical(other.workerId, workerId) ||
                other.workerId == workerId) &&
            (identical(other.workerName, workerName) ||
                other.workerName == workerName) &&
            (identical(other.appointmentId, appointmentId) ||
                other.appointmentId == appointmentId) &&
            (identical(other.clientName, clientName) ||
                other.clientName == clientName) &&
            (identical(other.clientAddress, clientAddress) ||
                other.clientAddress == clientAddress) &&
            (identical(other.eventType, eventType) ||
                other.eventType == eventType) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.distanceMeters, distanceMeters) ||
                other.distanceMeters == distanceMeters) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      eventId,
      workerId,
      workerName,
      appointmentId,
      clientName,
      clientAddress,
      eventType,
      timestamp,
      latitude,
      longitude,
      distanceMeters,
      notes);

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
      {required final String eventId,
      required final String workerId,
      required final String workerName,
      required final String appointmentId,
      required final String clientName,
      required final String clientAddress,
      required final GeofenceEventType eventType,
      required final DateTime timestamp,
      required final double latitude,
      required final double longitude,
      final double? distanceMeters,
      final String? notes}) = _$GeofenceEventImpl;

  factory _GeofenceEvent.fromJson(Map<String, dynamic> json) =
      _$GeofenceEventImpl.fromJson;

  @override
  String get eventId;
  @override
  String get workerId;
  @override
  String get workerName;
  @override
  String get appointmentId;
  @override
  String get clientName;
  @override
  String get clientAddress;
  @override
  GeofenceEventType get eventType;
  @override
  DateTime get timestamp;
  @override
  double get latitude;
  @override
  double get longitude;
  @override
  double? get distanceMeters;
  @override
  String? get notes;
  @override
  @JsonKey(ignore: true)
  _$$GeofenceEventImplCopyWith<_$GeofenceEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ShiftChangeNotification _$ShiftChangeNotificationFromJson(
    Map<String, dynamic> json) {
  return _ShiftChangeNotification.fromJson(json);
}

/// @nodoc
mixin _$ShiftChangeNotification {
  String get notificationId => throw _privateConstructorUsedError;
  String get shiftId => throw _privateConstructorUsedError;
  String get workerId => throw _privateConstructorUsedError;
  String get workerName => throw _privateConstructorUsedError;
  String get clientName => throw _privateConstructorUsedError;
  ShiftChangeType get changeType => throw _privateConstructorUsedError;
  DateTime get shiftDate => throw _privateConstructorUsedError;
  String get shiftTime => throw _privateConstructorUsedError;
  String? get oldTime => throw _privateConstructorUsedError;
  String? get newTime => throw _privateConstructorUsedError;
  String? get reason => throw _privateConstructorUsedError;
  String? get replacementWorkerId => throw _privateConstructorUsedError;
  String? get replacementWorkerName => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ShiftChangeNotificationCopyWith<ShiftChangeNotification> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShiftChangeNotificationCopyWith<$Res> {
  factory $ShiftChangeNotificationCopyWith(ShiftChangeNotification value,
          $Res Function(ShiftChangeNotification) then) =
      _$ShiftChangeNotificationCopyWithImpl<$Res, ShiftChangeNotification>;
  @useResult
  $Res call(
      {String notificationId,
      String shiftId,
      String workerId,
      String workerName,
      String clientName,
      ShiftChangeType changeType,
      DateTime shiftDate,
      String shiftTime,
      String? oldTime,
      String? newTime,
      String? reason,
      String? replacementWorkerId,
      String? replacementWorkerName,
      DateTime timestamp});
}

/// @nodoc
class _$ShiftChangeNotificationCopyWithImpl<$Res,
        $Val extends ShiftChangeNotification>
    implements $ShiftChangeNotificationCopyWith<$Res> {
  _$ShiftChangeNotificationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notificationId = null,
    Object? shiftId = null,
    Object? workerId = null,
    Object? workerName = null,
    Object? clientName = null,
    Object? changeType = null,
    Object? shiftDate = null,
    Object? shiftTime = null,
    Object? oldTime = freezed,
    Object? newTime = freezed,
    Object? reason = freezed,
    Object? replacementWorkerId = freezed,
    Object? replacementWorkerName = freezed,
    Object? timestamp = null,
  }) {
    return _then(_value.copyWith(
      notificationId: null == notificationId
          ? _value.notificationId
          : notificationId // ignore: cast_nullable_to_non_nullable
              as String,
      shiftId: null == shiftId
          ? _value.shiftId
          : shiftId // ignore: cast_nullable_to_non_nullable
              as String,
      workerId: null == workerId
          ? _value.workerId
          : workerId // ignore: cast_nullable_to_non_nullable
              as String,
      workerName: null == workerName
          ? _value.workerName
          : workerName // ignore: cast_nullable_to_non_nullable
              as String,
      clientName: null == clientName
          ? _value.clientName
          : clientName // ignore: cast_nullable_to_non_nullable
              as String,
      changeType: null == changeType
          ? _value.changeType
          : changeType // ignore: cast_nullable_to_non_nullable
              as ShiftChangeType,
      shiftDate: null == shiftDate
          ? _value.shiftDate
          : shiftDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      shiftTime: null == shiftTime
          ? _value.shiftTime
          : shiftTime // ignore: cast_nullable_to_non_nullable
              as String,
      oldTime: freezed == oldTime
          ? _value.oldTime
          : oldTime // ignore: cast_nullable_to_non_nullable
              as String?,
      newTime: freezed == newTime
          ? _value.newTime
          : newTime // ignore: cast_nullable_to_non_nullable
              as String?,
      reason: freezed == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String?,
      replacementWorkerId: freezed == replacementWorkerId
          ? _value.replacementWorkerId
          : replacementWorkerId // ignore: cast_nullable_to_non_nullable
              as String?,
      replacementWorkerName: freezed == replacementWorkerName
          ? _value.replacementWorkerName
          : replacementWorkerName // ignore: cast_nullable_to_non_nullable
              as String?,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ShiftChangeNotificationImplCopyWith<$Res>
    implements $ShiftChangeNotificationCopyWith<$Res> {
  factory _$$ShiftChangeNotificationImplCopyWith(
          _$ShiftChangeNotificationImpl value,
          $Res Function(_$ShiftChangeNotificationImpl) then) =
      __$$ShiftChangeNotificationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String notificationId,
      String shiftId,
      String workerId,
      String workerName,
      String clientName,
      ShiftChangeType changeType,
      DateTime shiftDate,
      String shiftTime,
      String? oldTime,
      String? newTime,
      String? reason,
      String? replacementWorkerId,
      String? replacementWorkerName,
      DateTime timestamp});
}

/// @nodoc
class __$$ShiftChangeNotificationImplCopyWithImpl<$Res>
    extends _$ShiftChangeNotificationCopyWithImpl<$Res,
        _$ShiftChangeNotificationImpl>
    implements _$$ShiftChangeNotificationImplCopyWith<$Res> {
  __$$ShiftChangeNotificationImplCopyWithImpl(
      _$ShiftChangeNotificationImpl _value,
      $Res Function(_$ShiftChangeNotificationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notificationId = null,
    Object? shiftId = null,
    Object? workerId = null,
    Object? workerName = null,
    Object? clientName = null,
    Object? changeType = null,
    Object? shiftDate = null,
    Object? shiftTime = null,
    Object? oldTime = freezed,
    Object? newTime = freezed,
    Object? reason = freezed,
    Object? replacementWorkerId = freezed,
    Object? replacementWorkerName = freezed,
    Object? timestamp = null,
  }) {
    return _then(_$ShiftChangeNotificationImpl(
      notificationId: null == notificationId
          ? _value.notificationId
          : notificationId // ignore: cast_nullable_to_non_nullable
              as String,
      shiftId: null == shiftId
          ? _value.shiftId
          : shiftId // ignore: cast_nullable_to_non_nullable
              as String,
      workerId: null == workerId
          ? _value.workerId
          : workerId // ignore: cast_nullable_to_non_nullable
              as String,
      workerName: null == workerName
          ? _value.workerName
          : workerName // ignore: cast_nullable_to_non_nullable
              as String,
      clientName: null == clientName
          ? _value.clientName
          : clientName // ignore: cast_nullable_to_non_nullable
              as String,
      changeType: null == changeType
          ? _value.changeType
          : changeType // ignore: cast_nullable_to_non_nullable
              as ShiftChangeType,
      shiftDate: null == shiftDate
          ? _value.shiftDate
          : shiftDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      shiftTime: null == shiftTime
          ? _value.shiftTime
          : shiftTime // ignore: cast_nullable_to_non_nullable
              as String,
      oldTime: freezed == oldTime
          ? _value.oldTime
          : oldTime // ignore: cast_nullable_to_non_nullable
              as String?,
      newTime: freezed == newTime
          ? _value.newTime
          : newTime // ignore: cast_nullable_to_non_nullable
              as String?,
      reason: freezed == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String?,
      replacementWorkerId: freezed == replacementWorkerId
          ? _value.replacementWorkerId
          : replacementWorkerId // ignore: cast_nullable_to_non_nullable
              as String?,
      replacementWorkerName: freezed == replacementWorkerName
          ? _value.replacementWorkerName
          : replacementWorkerName // ignore: cast_nullable_to_non_nullable
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
class _$ShiftChangeNotificationImpl implements _ShiftChangeNotification {
  const _$ShiftChangeNotificationImpl(
      {required this.notificationId,
      required this.shiftId,
      required this.workerId,
      required this.workerName,
      required this.clientName,
      required this.changeType,
      required this.shiftDate,
      required this.shiftTime,
      this.oldTime,
      this.newTime,
      this.reason,
      this.replacementWorkerId,
      this.replacementWorkerName,
      required this.timestamp});

  factory _$ShiftChangeNotificationImpl.fromJson(Map<String, dynamic> json) =>
      _$$ShiftChangeNotificationImplFromJson(json);

  @override
  final String notificationId;
  @override
  final String shiftId;
  @override
  final String workerId;
  @override
  final String workerName;
  @override
  final String clientName;
  @override
  final ShiftChangeType changeType;
  @override
  final DateTime shiftDate;
  @override
  final String shiftTime;
  @override
  final String? oldTime;
  @override
  final String? newTime;
  @override
  final String? reason;
  @override
  final String? replacementWorkerId;
  @override
  final String? replacementWorkerName;
  @override
  final DateTime timestamp;

  @override
  String toString() {
    return 'ShiftChangeNotification(notificationId: $notificationId, shiftId: $shiftId, workerId: $workerId, workerName: $workerName, clientName: $clientName, changeType: $changeType, shiftDate: $shiftDate, shiftTime: $shiftTime, oldTime: $oldTime, newTime: $newTime, reason: $reason, replacementWorkerId: $replacementWorkerId, replacementWorkerName: $replacementWorkerName, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShiftChangeNotificationImpl &&
            (identical(other.notificationId, notificationId) ||
                other.notificationId == notificationId) &&
            (identical(other.shiftId, shiftId) || other.shiftId == shiftId) &&
            (identical(other.workerId, workerId) ||
                other.workerId == workerId) &&
            (identical(other.workerName, workerName) ||
                other.workerName == workerName) &&
            (identical(other.clientName, clientName) ||
                other.clientName == clientName) &&
            (identical(other.changeType, changeType) ||
                other.changeType == changeType) &&
            (identical(other.shiftDate, shiftDate) ||
                other.shiftDate == shiftDate) &&
            (identical(other.shiftTime, shiftTime) ||
                other.shiftTime == shiftTime) &&
            (identical(other.oldTime, oldTime) || other.oldTime == oldTime) &&
            (identical(other.newTime, newTime) || other.newTime == newTime) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.replacementWorkerId, replacementWorkerId) ||
                other.replacementWorkerId == replacementWorkerId) &&
            (identical(other.replacementWorkerName, replacementWorkerName) ||
                other.replacementWorkerName == replacementWorkerName) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      notificationId,
      shiftId,
      workerId,
      workerName,
      clientName,
      changeType,
      shiftDate,
      shiftTime,
      oldTime,
      newTime,
      reason,
      replacementWorkerId,
      replacementWorkerName,
      timestamp);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ShiftChangeNotificationImplCopyWith<_$ShiftChangeNotificationImpl>
      get copyWith => __$$ShiftChangeNotificationImplCopyWithImpl<
          _$ShiftChangeNotificationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ShiftChangeNotificationImplToJson(
      this,
    );
  }
}

abstract class _ShiftChangeNotification implements ShiftChangeNotification {
  const factory _ShiftChangeNotification(
      {required final String notificationId,
      required final String shiftId,
      required final String workerId,
      required final String workerName,
      required final String clientName,
      required final ShiftChangeType changeType,
      required final DateTime shiftDate,
      required final String shiftTime,
      final String? oldTime,
      final String? newTime,
      final String? reason,
      final String? replacementWorkerId,
      final String? replacementWorkerName,
      required final DateTime timestamp}) = _$ShiftChangeNotificationImpl;

  factory _ShiftChangeNotification.fromJson(Map<String, dynamic> json) =
      _$ShiftChangeNotificationImpl.fromJson;

  @override
  String get notificationId;
  @override
  String get shiftId;
  @override
  String get workerId;
  @override
  String get workerName;
  @override
  String get clientName;
  @override
  ShiftChangeType get changeType;
  @override
  DateTime get shiftDate;
  @override
  String get shiftTime;
  @override
  String? get oldTime;
  @override
  String? get newTime;
  @override
  String? get reason;
  @override
  String? get replacementWorkerId;
  @override
  String? get replacementWorkerName;
  @override
  DateTime get timestamp;
  @override
  @JsonKey(ignore: true)
  _$$ShiftChangeNotificationImplCopyWith<_$ShiftChangeNotificationImpl>
      get copyWith => throw _privateConstructorUsedError;
}

SmartTimingRecommendation _$SmartTimingRecommendationFromJson(
    Map<String, dynamic> json) {
  return _SmartTimingRecommendation.fromJson(json);
}

/// @nodoc
mixin _$SmartTimingRecommendation {
  String get userId => throw _privateConstructorUsedError;
  NotificationCategory get category => throw _privateConstructorUsedError;
  DateTime get recommendedTime => throw _privateConstructorUsedError;
  double get confidence => throw _privateConstructorUsedError;
  String get reason => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SmartTimingRecommendationCopyWith<SmartTimingRecommendation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SmartTimingRecommendationCopyWith<$Res> {
  factory $SmartTimingRecommendationCopyWith(SmartTimingRecommendation value,
          $Res Function(SmartTimingRecommendation) then) =
      _$SmartTimingRecommendationCopyWithImpl<$Res, SmartTimingRecommendation>;
  @useResult
  $Res call(
      {String userId,
      NotificationCategory category,
      DateTime recommendedTime,
      double confidence,
      String reason,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class _$SmartTimingRecommendationCopyWithImpl<$Res,
        $Val extends SmartTimingRecommendation>
    implements $SmartTimingRecommendationCopyWith<$Res> {
  _$SmartTimingRecommendationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? category = null,
    Object? recommendedTime = null,
    Object? confidence = null,
    Object? reason = null,
    Object? metadata = freezed,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as NotificationCategory,
      recommendedTime: null == recommendedTime
          ? _value.recommendedTime
          : recommendedTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
      reason: null == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SmartTimingRecommendationImplCopyWith<$Res>
    implements $SmartTimingRecommendationCopyWith<$Res> {
  factory _$$SmartTimingRecommendationImplCopyWith(
          _$SmartTimingRecommendationImpl value,
          $Res Function(_$SmartTimingRecommendationImpl) then) =
      __$$SmartTimingRecommendationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userId,
      NotificationCategory category,
      DateTime recommendedTime,
      double confidence,
      String reason,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class __$$SmartTimingRecommendationImplCopyWithImpl<$Res>
    extends _$SmartTimingRecommendationCopyWithImpl<$Res,
        _$SmartTimingRecommendationImpl>
    implements _$$SmartTimingRecommendationImplCopyWith<$Res> {
  __$$SmartTimingRecommendationImplCopyWithImpl(
      _$SmartTimingRecommendationImpl _value,
      $Res Function(_$SmartTimingRecommendationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? category = null,
    Object? recommendedTime = null,
    Object? confidence = null,
    Object? reason = null,
    Object? metadata = freezed,
  }) {
    return _then(_$SmartTimingRecommendationImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as NotificationCategory,
      recommendedTime: null == recommendedTime
          ? _value.recommendedTime
          : recommendedTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
      reason: null == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SmartTimingRecommendationImpl implements _SmartTimingRecommendation {
  const _$SmartTimingRecommendationImpl(
      {required this.userId,
      required this.category,
      required this.recommendedTime,
      required this.confidence,
      required this.reason,
      final Map<String, dynamic>? metadata})
      : _metadata = metadata;

  factory _$SmartTimingRecommendationImpl.fromJson(Map<String, dynamic> json) =>
      _$$SmartTimingRecommendationImplFromJson(json);

  @override
  final String userId;
  @override
  final NotificationCategory category;
  @override
  final DateTime recommendedTime;
  @override
  final double confidence;
  @override
  final String reason;
  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'SmartTimingRecommendation(userId: $userId, category: $category, recommendedTime: $recommendedTime, confidence: $confidence, reason: $reason, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SmartTimingRecommendationImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.recommendedTime, recommendedTime) ||
                other.recommendedTime == recommendedTime) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      userId,
      category,
      recommendedTime,
      confidence,
      reason,
      const DeepCollectionEquality().hash(_metadata));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SmartTimingRecommendationImplCopyWith<_$SmartTimingRecommendationImpl>
      get copyWith => __$$SmartTimingRecommendationImplCopyWithImpl<
          _$SmartTimingRecommendationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SmartTimingRecommendationImplToJson(
      this,
    );
  }
}

abstract class _SmartTimingRecommendation implements SmartTimingRecommendation {
  const factory _SmartTimingRecommendation(
      {required final String userId,
      required final NotificationCategory category,
      required final DateTime recommendedTime,
      required final double confidence,
      required final String reason,
      final Map<String, dynamic>? metadata}) = _$SmartTimingRecommendationImpl;

  factory _SmartTimingRecommendation.fromJson(Map<String, dynamic> json) =
      _$SmartTimingRecommendationImpl.fromJson;

  @override
  String get userId;
  @override
  NotificationCategory get category;
  @override
  DateTime get recommendedTime;
  @override
  double get confidence;
  @override
  String get reason;
  @override
  Map<String, dynamic>? get metadata;
  @override
  @JsonKey(ignore: true)
  _$$SmartTimingRecommendationImplCopyWith<_$SmartTimingRecommendationImpl>
      get copyWith => throw _privateConstructorUsedError;
}

NotificationDeliveryStatus _$NotificationDeliveryStatusFromJson(
    Map<String, dynamic> json) {
  return _NotificationDeliveryStatus.fromJson(json);
}

/// @nodoc
mixin _$NotificationDeliveryStatus {
  String get notificationId => throw _privateConstructorUsedError;
  Map<NotificationChannel, DeliveryResult> get channelResults =>
      throw _privateConstructorUsedError;
  DateTime get sentAt => throw _privateConstructorUsedError;
  DateTime? get deliveredAt => throw _privateConstructorUsedError;
  DateTime? get readAt => throw _privateConstructorUsedError;
  DateTime? get actionedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NotificationDeliveryStatusCopyWith<NotificationDeliveryStatus>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationDeliveryStatusCopyWith<$Res> {
  factory $NotificationDeliveryStatusCopyWith(NotificationDeliveryStatus value,
          $Res Function(NotificationDeliveryStatus) then) =
      _$NotificationDeliveryStatusCopyWithImpl<$Res,
          NotificationDeliveryStatus>;
  @useResult
  $Res call(
      {String notificationId,
      Map<NotificationChannel, DeliveryResult> channelResults,
      DateTime sentAt,
      DateTime? deliveredAt,
      DateTime? readAt,
      DateTime? actionedAt});
}

/// @nodoc
class _$NotificationDeliveryStatusCopyWithImpl<$Res,
        $Val extends NotificationDeliveryStatus>
    implements $NotificationDeliveryStatusCopyWith<$Res> {
  _$NotificationDeliveryStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notificationId = null,
    Object? channelResults = null,
    Object? sentAt = null,
    Object? deliveredAt = freezed,
    Object? readAt = freezed,
    Object? actionedAt = freezed,
  }) {
    return _then(_value.copyWith(
      notificationId: null == notificationId
          ? _value.notificationId
          : notificationId // ignore: cast_nullable_to_non_nullable
              as String,
      channelResults: null == channelResults
          ? _value.channelResults
          : channelResults // ignore: cast_nullable_to_non_nullable
              as Map<NotificationChannel, DeliveryResult>,
      sentAt: null == sentAt
          ? _value.sentAt
          : sentAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      deliveredAt: freezed == deliveredAt
          ? _value.deliveredAt
          : deliveredAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      readAt: freezed == readAt
          ? _value.readAt
          : readAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      actionedAt: freezed == actionedAt
          ? _value.actionedAt
          : actionedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NotificationDeliveryStatusImplCopyWith<$Res>
    implements $NotificationDeliveryStatusCopyWith<$Res> {
  factory _$$NotificationDeliveryStatusImplCopyWith(
          _$NotificationDeliveryStatusImpl value,
          $Res Function(_$NotificationDeliveryStatusImpl) then) =
      __$$NotificationDeliveryStatusImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String notificationId,
      Map<NotificationChannel, DeliveryResult> channelResults,
      DateTime sentAt,
      DateTime? deliveredAt,
      DateTime? readAt,
      DateTime? actionedAt});
}

/// @nodoc
class __$$NotificationDeliveryStatusImplCopyWithImpl<$Res>
    extends _$NotificationDeliveryStatusCopyWithImpl<$Res,
        _$NotificationDeliveryStatusImpl>
    implements _$$NotificationDeliveryStatusImplCopyWith<$Res> {
  __$$NotificationDeliveryStatusImplCopyWithImpl(
      _$NotificationDeliveryStatusImpl _value,
      $Res Function(_$NotificationDeliveryStatusImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notificationId = null,
    Object? channelResults = null,
    Object? sentAt = null,
    Object? deliveredAt = freezed,
    Object? readAt = freezed,
    Object? actionedAt = freezed,
  }) {
    return _then(_$NotificationDeliveryStatusImpl(
      notificationId: null == notificationId
          ? _value.notificationId
          : notificationId // ignore: cast_nullable_to_non_nullable
              as String,
      channelResults: null == channelResults
          ? _value._channelResults
          : channelResults // ignore: cast_nullable_to_non_nullable
              as Map<NotificationChannel, DeliveryResult>,
      sentAt: null == sentAt
          ? _value.sentAt
          : sentAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      deliveredAt: freezed == deliveredAt
          ? _value.deliveredAt
          : deliveredAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      readAt: freezed == readAt
          ? _value.readAt
          : readAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      actionedAt: freezed == actionedAt
          ? _value.actionedAt
          : actionedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationDeliveryStatusImpl implements _NotificationDeliveryStatus {
  const _$NotificationDeliveryStatusImpl(
      {required this.notificationId,
      required final Map<NotificationChannel, DeliveryResult> channelResults,
      required this.sentAt,
      this.deliveredAt,
      this.readAt,
      this.actionedAt})
      : _channelResults = channelResults;

  factory _$NotificationDeliveryStatusImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$NotificationDeliveryStatusImplFromJson(json);

  @override
  final String notificationId;
  final Map<NotificationChannel, DeliveryResult> _channelResults;
  @override
  Map<NotificationChannel, DeliveryResult> get channelResults {
    if (_channelResults is EqualUnmodifiableMapView) return _channelResults;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_channelResults);
  }

  @override
  final DateTime sentAt;
  @override
  final DateTime? deliveredAt;
  @override
  final DateTime? readAt;
  @override
  final DateTime? actionedAt;

  @override
  String toString() {
    return 'NotificationDeliveryStatus(notificationId: $notificationId, channelResults: $channelResults, sentAt: $sentAt, deliveredAt: $deliveredAt, readAt: $readAt, actionedAt: $actionedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationDeliveryStatusImpl &&
            (identical(other.notificationId, notificationId) ||
                other.notificationId == notificationId) &&
            const DeepCollectionEquality()
                .equals(other._channelResults, _channelResults) &&
            (identical(other.sentAt, sentAt) || other.sentAt == sentAt) &&
            (identical(other.deliveredAt, deliveredAt) ||
                other.deliveredAt == deliveredAt) &&
            (identical(other.readAt, readAt) || other.readAt == readAt) &&
            (identical(other.actionedAt, actionedAt) ||
                other.actionedAt == actionedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      notificationId,
      const DeepCollectionEquality().hash(_channelResults),
      sentAt,
      deliveredAt,
      readAt,
      actionedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationDeliveryStatusImplCopyWith<_$NotificationDeliveryStatusImpl>
      get copyWith => __$$NotificationDeliveryStatusImplCopyWithImpl<
          _$NotificationDeliveryStatusImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationDeliveryStatusImplToJson(
      this,
    );
  }
}

abstract class _NotificationDeliveryStatus
    implements NotificationDeliveryStatus {
  const factory _NotificationDeliveryStatus(
      {required final String notificationId,
      required final Map<NotificationChannel, DeliveryResult> channelResults,
      required final DateTime sentAt,
      final DateTime? deliveredAt,
      final DateTime? readAt,
      final DateTime? actionedAt}) = _$NotificationDeliveryStatusImpl;

  factory _NotificationDeliveryStatus.fromJson(Map<String, dynamic> json) =
      _$NotificationDeliveryStatusImpl.fromJson;

  @override
  String get notificationId;
  @override
  Map<NotificationChannel, DeliveryResult> get channelResults;
  @override
  DateTime get sentAt;
  @override
  DateTime? get deliveredAt;
  @override
  DateTime? get readAt;
  @override
  DateTime? get actionedAt;
  @override
  @JsonKey(ignore: true)
  _$$NotificationDeliveryStatusImplCopyWith<_$NotificationDeliveryStatusImpl>
      get copyWith => throw _privateConstructorUsedError;
}

DeliveryResult _$DeliveryResultFromJson(Map<String, dynamic> json) {
  return _DeliveryResult.fromJson(json);
}

/// @nodoc
mixin _$DeliveryResult {
  bool get success => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  String? get messageId => throw _privateConstructorUsedError;
  DateTime? get timestamp => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DeliveryResultCopyWith<DeliveryResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeliveryResultCopyWith<$Res> {
  factory $DeliveryResultCopyWith(
          DeliveryResult value, $Res Function(DeliveryResult) then) =
      _$DeliveryResultCopyWithImpl<$Res, DeliveryResult>;
  @useResult
  $Res call(
      {bool success,
      String? errorMessage,
      String? messageId,
      DateTime? timestamp});
}

/// @nodoc
class _$DeliveryResultCopyWithImpl<$Res, $Val extends DeliveryResult>
    implements $DeliveryResultCopyWith<$Res> {
  _$DeliveryResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? errorMessage = freezed,
    Object? messageId = freezed,
    Object? timestamp = freezed,
  }) {
    return _then(_value.copyWith(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      messageId: freezed == messageId
          ? _value.messageId
          : messageId // ignore: cast_nullable_to_non_nullable
              as String?,
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DeliveryResultImplCopyWith<$Res>
    implements $DeliveryResultCopyWith<$Res> {
  factory _$$DeliveryResultImplCopyWith(_$DeliveryResultImpl value,
          $Res Function(_$DeliveryResultImpl) then) =
      __$$DeliveryResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool success,
      String? errorMessage,
      String? messageId,
      DateTime? timestamp});
}

/// @nodoc
class __$$DeliveryResultImplCopyWithImpl<$Res>
    extends _$DeliveryResultCopyWithImpl<$Res, _$DeliveryResultImpl>
    implements _$$DeliveryResultImplCopyWith<$Res> {
  __$$DeliveryResultImplCopyWithImpl(
      _$DeliveryResultImpl _value, $Res Function(_$DeliveryResultImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? errorMessage = freezed,
    Object? messageId = freezed,
    Object? timestamp = freezed,
  }) {
    return _then(_$DeliveryResultImpl(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      messageId: freezed == messageId
          ? _value.messageId
          : messageId // ignore: cast_nullable_to_non_nullable
              as String?,
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DeliveryResultImpl implements _DeliveryResult {
  const _$DeliveryResultImpl(
      {required this.success,
      this.errorMessage,
      this.messageId,
      this.timestamp});

  factory _$DeliveryResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$DeliveryResultImplFromJson(json);

  @override
  final bool success;
  @override
  final String? errorMessage;
  @override
  final String? messageId;
  @override
  final DateTime? timestamp;

  @override
  String toString() {
    return 'DeliveryResult(success: $success, errorMessage: $errorMessage, messageId: $messageId, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeliveryResultImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.messageId, messageId) ||
                other.messageId == messageId) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, success, errorMessage, messageId, timestamp);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DeliveryResultImplCopyWith<_$DeliveryResultImpl> get copyWith =>
      __$$DeliveryResultImplCopyWithImpl<_$DeliveryResultImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DeliveryResultImplToJson(
      this,
    );
  }
}

abstract class _DeliveryResult implements DeliveryResult {
  const factory _DeliveryResult(
      {required final bool success,
      final String? errorMessage,
      final String? messageId,
      final DateTime? timestamp}) = _$DeliveryResultImpl;

  factory _DeliveryResult.fromJson(Map<String, dynamic> json) =
      _$DeliveryResultImpl.fromJson;

  @override
  bool get success;
  @override
  String? get errorMessage;
  @override
  String? get messageId;
  @override
  DateTime? get timestamp;
  @override
  @JsonKey(ignore: true)
  _$$DeliveryResultImplCopyWith<_$DeliveryResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
