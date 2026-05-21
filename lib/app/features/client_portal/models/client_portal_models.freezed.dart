// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'client_portal_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ClientDashboard {
  String get clientId;
  String get clientName;
  List<TodayAppointment> get todayAppointments;
  List<UpcomingAppointment> get upcomingAppointments;
  List<RecentActivity> get recentActivity;
  List<ClientNotification> get notifications;

  /// Create a copy of ClientDashboard
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ClientDashboardCopyWith<ClientDashboard> get copyWith =>
      _$ClientDashboardCopyWithImpl<ClientDashboard>(
          this as ClientDashboard, _$identity);

  /// Serializes this ClientDashboard to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ClientDashboard &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.clientName, clientName) ||
                other.clientName == clientName) &&
            const DeepCollectionEquality()
                .equals(other.todayAppointments, todayAppointments) &&
            const DeepCollectionEquality()
                .equals(other.upcomingAppointments, upcomingAppointments) &&
            const DeepCollectionEquality()
                .equals(other.recentActivity, recentActivity) &&
            const DeepCollectionEquality()
                .equals(other.notifications, notifications));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      clientId,
      clientName,
      const DeepCollectionEquality().hash(todayAppointments),
      const DeepCollectionEquality().hash(upcomingAppointments),
      const DeepCollectionEquality().hash(recentActivity),
      const DeepCollectionEquality().hash(notifications));

  @override
  String toString() {
    return 'ClientDashboard(clientId: $clientId, clientName: $clientName, todayAppointments: $todayAppointments, upcomingAppointments: $upcomingAppointments, recentActivity: $recentActivity, notifications: $notifications)';
  }
}

/// @nodoc
abstract mixin class $ClientDashboardCopyWith<$Res> {
  factory $ClientDashboardCopyWith(
          ClientDashboard value, $Res Function(ClientDashboard) _then) =
      _$ClientDashboardCopyWithImpl;
  @useResult
  $Res call(
      {String clientId,
      String clientName,
      List<TodayAppointment> todayAppointments,
      List<UpcomingAppointment> upcomingAppointments,
      List<RecentActivity> recentActivity,
      List<ClientNotification> notifications});
}

/// @nodoc
class _$ClientDashboardCopyWithImpl<$Res>
    implements $ClientDashboardCopyWith<$Res> {
  _$ClientDashboardCopyWithImpl(this._self, this._then);

  final ClientDashboard _self;
  final $Res Function(ClientDashboard) _then;

  /// Create a copy of ClientDashboard
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clientId = null,
    Object? clientName = null,
    Object? todayAppointments = null,
    Object? upcomingAppointments = null,
    Object? recentActivity = null,
    Object? notifications = null,
  }) {
    return _then(_self.copyWith(
      clientId: null == clientId
          ? _self.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      clientName: null == clientName
          ? _self.clientName
          : clientName // ignore: cast_nullable_to_non_nullable
              as String,
      todayAppointments: null == todayAppointments
          ? _self.todayAppointments
          : todayAppointments // ignore: cast_nullable_to_non_nullable
              as List<TodayAppointment>,
      upcomingAppointments: null == upcomingAppointments
          ? _self.upcomingAppointments
          : upcomingAppointments // ignore: cast_nullable_to_non_nullable
              as List<UpcomingAppointment>,
      recentActivity: null == recentActivity
          ? _self.recentActivity
          : recentActivity // ignore: cast_nullable_to_non_nullable
              as List<RecentActivity>,
      notifications: null == notifications
          ? _self.notifications
          : notifications // ignore: cast_nullable_to_non_nullable
              as List<ClientNotification>,
    ));
  }
}

/// Adds pattern-matching-related methods to [ClientDashboard].
extension ClientDashboardPatterns on ClientDashboard {
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
    TResult Function(_ClientDashboard value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ClientDashboard() when $default != null:
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
    TResult Function(_ClientDashboard value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ClientDashboard():
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
    TResult? Function(_ClientDashboard value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ClientDashboard() when $default != null:
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
            String clientId,
            String clientName,
            List<TodayAppointment> todayAppointments,
            List<UpcomingAppointment> upcomingAppointments,
            List<RecentActivity> recentActivity,
            List<ClientNotification> notifications)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ClientDashboard() when $default != null:
        return $default(
            _that.clientId,
            _that.clientName,
            _that.todayAppointments,
            _that.upcomingAppointments,
            _that.recentActivity,
            _that.notifications);
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
            String clientId,
            String clientName,
            List<TodayAppointment> todayAppointments,
            List<UpcomingAppointment> upcomingAppointments,
            List<RecentActivity> recentActivity,
            List<ClientNotification> notifications)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ClientDashboard():
        return $default(
            _that.clientId,
            _that.clientName,
            _that.todayAppointments,
            _that.upcomingAppointments,
            _that.recentActivity,
            _that.notifications);
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
            String clientId,
            String clientName,
            List<TodayAppointment> todayAppointments,
            List<UpcomingAppointment> upcomingAppointments,
            List<RecentActivity> recentActivity,
            List<ClientNotification> notifications)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ClientDashboard() when $default != null:
        return $default(
            _that.clientId,
            _that.clientName,
            _that.todayAppointments,
            _that.upcomingAppointments,
            _that.recentActivity,
            _that.notifications);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ClientDashboard implements ClientDashboard {
  const _ClientDashboard(
      {required this.clientId,
      required this.clientName,
      required final List<TodayAppointment> todayAppointments,
      required final List<UpcomingAppointment> upcomingAppointments,
      required final List<RecentActivity> recentActivity,
      required final List<ClientNotification> notifications})
      : _todayAppointments = todayAppointments,
        _upcomingAppointments = upcomingAppointments,
        _recentActivity = recentActivity,
        _notifications = notifications;
  factory _ClientDashboard.fromJson(Map<String, dynamic> json) =>
      _$ClientDashboardFromJson(json);

  @override
  final String clientId;
  @override
  final String clientName;
  final List<TodayAppointment> _todayAppointments;
  @override
  List<TodayAppointment> get todayAppointments {
    if (_todayAppointments is EqualUnmodifiableListView)
      return _todayAppointments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_todayAppointments);
  }

  final List<UpcomingAppointment> _upcomingAppointments;
  @override
  List<UpcomingAppointment> get upcomingAppointments {
    if (_upcomingAppointments is EqualUnmodifiableListView)
      return _upcomingAppointments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_upcomingAppointments);
  }

  final List<RecentActivity> _recentActivity;
  @override
  List<RecentActivity> get recentActivity {
    if (_recentActivity is EqualUnmodifiableListView) return _recentActivity;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recentActivity);
  }

  final List<ClientNotification> _notifications;
  @override
  List<ClientNotification> get notifications {
    if (_notifications is EqualUnmodifiableListView) return _notifications;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_notifications);
  }

  /// Create a copy of ClientDashboard
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ClientDashboardCopyWith<_ClientDashboard> get copyWith =>
      __$ClientDashboardCopyWithImpl<_ClientDashboard>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ClientDashboardToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ClientDashboard &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.clientName, clientName) ||
                other.clientName == clientName) &&
            const DeepCollectionEquality()
                .equals(other._todayAppointments, _todayAppointments) &&
            const DeepCollectionEquality()
                .equals(other._upcomingAppointments, _upcomingAppointments) &&
            const DeepCollectionEquality()
                .equals(other._recentActivity, _recentActivity) &&
            const DeepCollectionEquality()
                .equals(other._notifications, _notifications));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      clientId,
      clientName,
      const DeepCollectionEquality().hash(_todayAppointments),
      const DeepCollectionEquality().hash(_upcomingAppointments),
      const DeepCollectionEquality().hash(_recentActivity),
      const DeepCollectionEquality().hash(_notifications));

  @override
  String toString() {
    return 'ClientDashboard(clientId: $clientId, clientName: $clientName, todayAppointments: $todayAppointments, upcomingAppointments: $upcomingAppointments, recentActivity: $recentActivity, notifications: $notifications)';
  }
}

/// @nodoc
abstract mixin class _$ClientDashboardCopyWith<$Res>
    implements $ClientDashboardCopyWith<$Res> {
  factory _$ClientDashboardCopyWith(
          _ClientDashboard value, $Res Function(_ClientDashboard) _then) =
      __$ClientDashboardCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String clientId,
      String clientName,
      List<TodayAppointment> todayAppointments,
      List<UpcomingAppointment> upcomingAppointments,
      List<RecentActivity> recentActivity,
      List<ClientNotification> notifications});
}

/// @nodoc
class __$ClientDashboardCopyWithImpl<$Res>
    implements _$ClientDashboardCopyWith<$Res> {
  __$ClientDashboardCopyWithImpl(this._self, this._then);

  final _ClientDashboard _self;
  final $Res Function(_ClientDashboard) _then;

  /// Create a copy of ClientDashboard
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? clientId = null,
    Object? clientName = null,
    Object? todayAppointments = null,
    Object? upcomingAppointments = null,
    Object? recentActivity = null,
    Object? notifications = null,
  }) {
    return _then(_ClientDashboard(
      clientId: null == clientId
          ? _self.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      clientName: null == clientName
          ? _self.clientName
          : clientName // ignore: cast_nullable_to_non_nullable
              as String,
      todayAppointments: null == todayAppointments
          ? _self._todayAppointments
          : todayAppointments // ignore: cast_nullable_to_non_nullable
              as List<TodayAppointment>,
      upcomingAppointments: null == upcomingAppointments
          ? _self._upcomingAppointments
          : upcomingAppointments // ignore: cast_nullable_to_non_nullable
              as List<UpcomingAppointment>,
      recentActivity: null == recentActivity
          ? _self._recentActivity
          : recentActivity // ignore: cast_nullable_to_non_nullable
              as List<RecentActivity>,
      notifications: null == notifications
          ? _self._notifications
          : notifications // ignore: cast_nullable_to_non_nullable
              as List<ClientNotification>,
    ));
  }
}

/// @nodoc
mixin _$TodayAppointment {
  String get appointmentId;
  String get workerName;
  String get serviceName;
  String get startTime;
  String get endTime;
  String get status;
  String? get eta;
  String? get workerPhoto;

  /// Create a copy of TodayAppointment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TodayAppointmentCopyWith<TodayAppointment> get copyWith =>
      _$TodayAppointmentCopyWithImpl<TodayAppointment>(
          this as TodayAppointment, _$identity);

  /// Serializes this TodayAppointment to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TodayAppointment &&
            (identical(other.appointmentId, appointmentId) ||
                other.appointmentId == appointmentId) &&
            (identical(other.workerName, workerName) ||
                other.workerName == workerName) &&
            (identical(other.serviceName, serviceName) ||
                other.serviceName == serviceName) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.eta, eta) || other.eta == eta) &&
            (identical(other.workerPhoto, workerPhoto) ||
                other.workerPhoto == workerPhoto));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, appointmentId, workerName,
      serviceName, startTime, endTime, status, eta, workerPhoto);

  @override
  String toString() {
    return 'TodayAppointment(appointmentId: $appointmentId, workerName: $workerName, serviceName: $serviceName, startTime: $startTime, endTime: $endTime, status: $status, eta: $eta, workerPhoto: $workerPhoto)';
  }
}

/// @nodoc
abstract mixin class $TodayAppointmentCopyWith<$Res> {
  factory $TodayAppointmentCopyWith(
          TodayAppointment value, $Res Function(TodayAppointment) _then) =
      _$TodayAppointmentCopyWithImpl;
  @useResult
  $Res call(
      {String appointmentId,
      String workerName,
      String serviceName,
      String startTime,
      String endTime,
      String status,
      String? eta,
      String? workerPhoto});
}

/// @nodoc
class _$TodayAppointmentCopyWithImpl<$Res>
    implements $TodayAppointmentCopyWith<$Res> {
  _$TodayAppointmentCopyWithImpl(this._self, this._then);

  final TodayAppointment _self;
  final $Res Function(TodayAppointment) _then;

  /// Create a copy of TodayAppointment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appointmentId = null,
    Object? workerName = null,
    Object? serviceName = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? status = null,
    Object? eta = freezed,
    Object? workerPhoto = freezed,
  }) {
    return _then(_self.copyWith(
      appointmentId: null == appointmentId
          ? _self.appointmentId
          : appointmentId // ignore: cast_nullable_to_non_nullable
              as String,
      workerName: null == workerName
          ? _self.workerName
          : workerName // ignore: cast_nullable_to_non_nullable
              as String,
      serviceName: null == serviceName
          ? _self.serviceName
          : serviceName // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _self.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as String,
      endTime: null == endTime
          ? _self.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      eta: freezed == eta
          ? _self.eta
          : eta // ignore: cast_nullable_to_non_nullable
              as String?,
      workerPhoto: freezed == workerPhoto
          ? _self.workerPhoto
          : workerPhoto // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [TodayAppointment].
extension TodayAppointmentPatterns on TodayAppointment {
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
    TResult Function(_TodayAppointment value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TodayAppointment() when $default != null:
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
    TResult Function(_TodayAppointment value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TodayAppointment():
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
    TResult? Function(_TodayAppointment value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TodayAppointment() when $default != null:
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
            String workerName,
            String serviceName,
            String startTime,
            String endTime,
            String status,
            String? eta,
            String? workerPhoto)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TodayAppointment() when $default != null:
        return $default(
            _that.appointmentId,
            _that.workerName,
            _that.serviceName,
            _that.startTime,
            _that.endTime,
            _that.status,
            _that.eta,
            _that.workerPhoto);
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
            String workerName,
            String serviceName,
            String startTime,
            String endTime,
            String status,
            String? eta,
            String? workerPhoto)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TodayAppointment():
        return $default(
            _that.appointmentId,
            _that.workerName,
            _that.serviceName,
            _that.startTime,
            _that.endTime,
            _that.status,
            _that.eta,
            _that.workerPhoto);
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
            String workerName,
            String serviceName,
            String startTime,
            String endTime,
            String status,
            String? eta,
            String? workerPhoto)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TodayAppointment() when $default != null:
        return $default(
            _that.appointmentId,
            _that.workerName,
            _that.serviceName,
            _that.startTime,
            _that.endTime,
            _that.status,
            _that.eta,
            _that.workerPhoto);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _TodayAppointment implements TodayAppointment {
  const _TodayAppointment(
      {required this.appointmentId,
      required this.workerName,
      required this.serviceName,
      required this.startTime,
      required this.endTime,
      required this.status,
      this.eta,
      this.workerPhoto});
  factory _TodayAppointment.fromJson(Map<String, dynamic> json) =>
      _$TodayAppointmentFromJson(json);

  @override
  final String appointmentId;
  @override
  final String workerName;
  @override
  final String serviceName;
  @override
  final String startTime;
  @override
  final String endTime;
  @override
  final String status;
  @override
  final String? eta;
  @override
  final String? workerPhoto;

  /// Create a copy of TodayAppointment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TodayAppointmentCopyWith<_TodayAppointment> get copyWith =>
      __$TodayAppointmentCopyWithImpl<_TodayAppointment>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TodayAppointmentToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TodayAppointment &&
            (identical(other.appointmentId, appointmentId) ||
                other.appointmentId == appointmentId) &&
            (identical(other.workerName, workerName) ||
                other.workerName == workerName) &&
            (identical(other.serviceName, serviceName) ||
                other.serviceName == serviceName) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.eta, eta) || other.eta == eta) &&
            (identical(other.workerPhoto, workerPhoto) ||
                other.workerPhoto == workerPhoto));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, appointmentId, workerName,
      serviceName, startTime, endTime, status, eta, workerPhoto);

  @override
  String toString() {
    return 'TodayAppointment(appointmentId: $appointmentId, workerName: $workerName, serviceName: $serviceName, startTime: $startTime, endTime: $endTime, status: $status, eta: $eta, workerPhoto: $workerPhoto)';
  }
}

/// @nodoc
abstract mixin class _$TodayAppointmentCopyWith<$Res>
    implements $TodayAppointmentCopyWith<$Res> {
  factory _$TodayAppointmentCopyWith(
          _TodayAppointment value, $Res Function(_TodayAppointment) _then) =
      __$TodayAppointmentCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String appointmentId,
      String workerName,
      String serviceName,
      String startTime,
      String endTime,
      String status,
      String? eta,
      String? workerPhoto});
}

/// @nodoc
class __$TodayAppointmentCopyWithImpl<$Res>
    implements _$TodayAppointmentCopyWith<$Res> {
  __$TodayAppointmentCopyWithImpl(this._self, this._then);

  final _TodayAppointment _self;
  final $Res Function(_TodayAppointment) _then;

  /// Create a copy of TodayAppointment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? appointmentId = null,
    Object? workerName = null,
    Object? serviceName = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? status = null,
    Object? eta = freezed,
    Object? workerPhoto = freezed,
  }) {
    return _then(_TodayAppointment(
      appointmentId: null == appointmentId
          ? _self.appointmentId
          : appointmentId // ignore: cast_nullable_to_non_nullable
              as String,
      workerName: null == workerName
          ? _self.workerName
          : workerName // ignore: cast_nullable_to_non_nullable
              as String,
      serviceName: null == serviceName
          ? _self.serviceName
          : serviceName // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _self.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as String,
      endTime: null == endTime
          ? _self.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      eta: freezed == eta
          ? _self.eta
          : eta // ignore: cast_nullable_to_non_nullable
              as String?,
      workerPhoto: freezed == workerPhoto
          ? _self.workerPhoto
          : workerPhoto // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$UpcomingAppointment {
  String get appointmentId;
  String get workerName;
  String get serviceName;
  String get date;
  String get startTime;
  String get endTime;
  String get status;

  /// Create a copy of UpcomingAppointment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UpcomingAppointmentCopyWith<UpcomingAppointment> get copyWith =>
      _$UpcomingAppointmentCopyWithImpl<UpcomingAppointment>(
          this as UpcomingAppointment, _$identity);

  /// Serializes this UpcomingAppointment to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UpcomingAppointment &&
            (identical(other.appointmentId, appointmentId) ||
                other.appointmentId == appointmentId) &&
            (identical(other.workerName, workerName) ||
                other.workerName == workerName) &&
            (identical(other.serviceName, serviceName) ||
                other.serviceName == serviceName) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, appointmentId, workerName,
      serviceName, date, startTime, endTime, status);

  @override
  String toString() {
    return 'UpcomingAppointment(appointmentId: $appointmentId, workerName: $workerName, serviceName: $serviceName, date: $date, startTime: $startTime, endTime: $endTime, status: $status)';
  }
}

/// @nodoc
abstract mixin class $UpcomingAppointmentCopyWith<$Res> {
  factory $UpcomingAppointmentCopyWith(
          UpcomingAppointment value, $Res Function(UpcomingAppointment) _then) =
      _$UpcomingAppointmentCopyWithImpl;
  @useResult
  $Res call(
      {String appointmentId,
      String workerName,
      String serviceName,
      String date,
      String startTime,
      String endTime,
      String status});
}

/// @nodoc
class _$UpcomingAppointmentCopyWithImpl<$Res>
    implements $UpcomingAppointmentCopyWith<$Res> {
  _$UpcomingAppointmentCopyWithImpl(this._self, this._then);

  final UpcomingAppointment _self;
  final $Res Function(UpcomingAppointment) _then;

  /// Create a copy of UpcomingAppointment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appointmentId = null,
    Object? workerName = null,
    Object? serviceName = null,
    Object? date = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? status = null,
  }) {
    return _then(_self.copyWith(
      appointmentId: null == appointmentId
          ? _self.appointmentId
          : appointmentId // ignore: cast_nullable_to_non_nullable
              as String,
      workerName: null == workerName
          ? _self.workerName
          : workerName // ignore: cast_nullable_to_non_nullable
              as String,
      serviceName: null == serviceName
          ? _self.serviceName
          : serviceName // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _self.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as String,
      endTime: null == endTime
          ? _self.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [UpcomingAppointment].
extension UpcomingAppointmentPatterns on UpcomingAppointment {
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
    TResult Function(_UpcomingAppointment value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UpcomingAppointment() when $default != null:
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
    TResult Function(_UpcomingAppointment value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UpcomingAppointment():
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
    TResult? Function(_UpcomingAppointment value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UpcomingAppointment() when $default != null:
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
            String workerName,
            String serviceName,
            String date,
            String startTime,
            String endTime,
            String status)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UpcomingAppointment() when $default != null:
        return $default(
            _that.appointmentId,
            _that.workerName,
            _that.serviceName,
            _that.date,
            _that.startTime,
            _that.endTime,
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
            String workerName,
            String serviceName,
            String date,
            String startTime,
            String endTime,
            String status)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UpcomingAppointment():
        return $default(
            _that.appointmentId,
            _that.workerName,
            _that.serviceName,
            _that.date,
            _that.startTime,
            _that.endTime,
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
            String workerName,
            String serviceName,
            String date,
            String startTime,
            String endTime,
            String status)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UpcomingAppointment() when $default != null:
        return $default(
            _that.appointmentId,
            _that.workerName,
            _that.serviceName,
            _that.date,
            _that.startTime,
            _that.endTime,
            _that.status);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _UpcomingAppointment implements UpcomingAppointment {
  const _UpcomingAppointment(
      {required this.appointmentId,
      required this.workerName,
      required this.serviceName,
      required this.date,
      required this.startTime,
      required this.endTime,
      required this.status});
  factory _UpcomingAppointment.fromJson(Map<String, dynamic> json) =>
      _$UpcomingAppointmentFromJson(json);

  @override
  final String appointmentId;
  @override
  final String workerName;
  @override
  final String serviceName;
  @override
  final String date;
  @override
  final String startTime;
  @override
  final String endTime;
  @override
  final String status;

  /// Create a copy of UpcomingAppointment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UpcomingAppointmentCopyWith<_UpcomingAppointment> get copyWith =>
      __$UpcomingAppointmentCopyWithImpl<_UpcomingAppointment>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UpcomingAppointmentToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UpcomingAppointment &&
            (identical(other.appointmentId, appointmentId) ||
                other.appointmentId == appointmentId) &&
            (identical(other.workerName, workerName) ||
                other.workerName == workerName) &&
            (identical(other.serviceName, serviceName) ||
                other.serviceName == serviceName) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, appointmentId, workerName,
      serviceName, date, startTime, endTime, status);

  @override
  String toString() {
    return 'UpcomingAppointment(appointmentId: $appointmentId, workerName: $workerName, serviceName: $serviceName, date: $date, startTime: $startTime, endTime: $endTime, status: $status)';
  }
}

/// @nodoc
abstract mixin class _$UpcomingAppointmentCopyWith<$Res>
    implements $UpcomingAppointmentCopyWith<$Res> {
  factory _$UpcomingAppointmentCopyWith(_UpcomingAppointment value,
          $Res Function(_UpcomingAppointment) _then) =
      __$UpcomingAppointmentCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String appointmentId,
      String workerName,
      String serviceName,
      String date,
      String startTime,
      String endTime,
      String status});
}

/// @nodoc
class __$UpcomingAppointmentCopyWithImpl<$Res>
    implements _$UpcomingAppointmentCopyWith<$Res> {
  __$UpcomingAppointmentCopyWithImpl(this._self, this._then);

  final _UpcomingAppointment _self;
  final $Res Function(_UpcomingAppointment) _then;

  /// Create a copy of UpcomingAppointment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? appointmentId = null,
    Object? workerName = null,
    Object? serviceName = null,
    Object? date = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? status = null,
  }) {
    return _then(_UpcomingAppointment(
      appointmentId: null == appointmentId
          ? _self.appointmentId
          : appointmentId // ignore: cast_nullable_to_non_nullable
              as String,
      workerName: null == workerName
          ? _self.workerName
          : workerName // ignore: cast_nullable_to_non_nullable
              as String,
      serviceName: null == serviceName
          ? _self.serviceName
          : serviceName // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _self.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as String,
      endTime: null == endTime
          ? _self.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$RecentActivity {
  String get type;
  String get message;
  String get timestamp;

  /// Create a copy of RecentActivity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RecentActivityCopyWith<RecentActivity> get copyWith =>
      _$RecentActivityCopyWithImpl<RecentActivity>(
          this as RecentActivity, _$identity);

  /// Serializes this RecentActivity to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RecentActivity &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, type, message, timestamp);

  @override
  String toString() {
    return 'RecentActivity(type: $type, message: $message, timestamp: $timestamp)';
  }
}

/// @nodoc
abstract mixin class $RecentActivityCopyWith<$Res> {
  factory $RecentActivityCopyWith(
          RecentActivity value, $Res Function(RecentActivity) _then) =
      _$RecentActivityCopyWithImpl;
  @useResult
  $Res call({String type, String message, String timestamp});
}

/// @nodoc
class _$RecentActivityCopyWithImpl<$Res>
    implements $RecentActivityCopyWith<$Res> {
  _$RecentActivityCopyWithImpl(this._self, this._then);

  final RecentActivity _self;
  final $Res Function(RecentActivity) _then;

  /// Create a copy of RecentActivity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? message = null,
    Object? timestamp = null,
  }) {
    return _then(_self.copyWith(
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [RecentActivity].
extension RecentActivityPatterns on RecentActivity {
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
    TResult Function(_RecentActivity value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RecentActivity() when $default != null:
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
    TResult Function(_RecentActivity value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RecentActivity():
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
    TResult? Function(_RecentActivity value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RecentActivity() when $default != null:
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
    TResult Function(String type, String message, String timestamp)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RecentActivity() when $default != null:
        return $default(_that.type, _that.message, _that.timestamp);
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
    TResult Function(String type, String message, String timestamp) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RecentActivity():
        return $default(_that.type, _that.message, _that.timestamp);
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
    TResult? Function(String type, String message, String timestamp)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RecentActivity() when $default != null:
        return $default(_that.type, _that.message, _that.timestamp);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _RecentActivity implements RecentActivity {
  const _RecentActivity(
      {required this.type, required this.message, required this.timestamp});
  factory _RecentActivity.fromJson(Map<String, dynamic> json) =>
      _$RecentActivityFromJson(json);

  @override
  final String type;
  @override
  final String message;
  @override
  final String timestamp;

  /// Create a copy of RecentActivity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RecentActivityCopyWith<_RecentActivity> get copyWith =>
      __$RecentActivityCopyWithImpl<_RecentActivity>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$RecentActivityToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RecentActivity &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, type, message, timestamp);

  @override
  String toString() {
    return 'RecentActivity(type: $type, message: $message, timestamp: $timestamp)';
  }
}

/// @nodoc
abstract mixin class _$RecentActivityCopyWith<$Res>
    implements $RecentActivityCopyWith<$Res> {
  factory _$RecentActivityCopyWith(
          _RecentActivity value, $Res Function(_RecentActivity) _then) =
      __$RecentActivityCopyWithImpl;
  @override
  @useResult
  $Res call({String type, String message, String timestamp});
}

/// @nodoc
class __$RecentActivityCopyWithImpl<$Res>
    implements _$RecentActivityCopyWith<$Res> {
  __$RecentActivityCopyWithImpl(this._self, this._then);

  final _RecentActivity _self;
  final $Res Function(_RecentActivity) _then;

  /// Create a copy of RecentActivity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? type = null,
    Object? message = null,
    Object? timestamp = null,
  }) {
    return _then(_RecentActivity(
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$ClientNotification {
  String get id;
  String get type;
  String get message;
  String get timestamp;
  bool get read;

  /// Create a copy of ClientNotification
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ClientNotificationCopyWith<ClientNotification> get copyWith =>
      _$ClientNotificationCopyWithImpl<ClientNotification>(
          this as ClientNotification, _$identity);

  /// Serializes this ClientNotification to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ClientNotification &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.read, read) || other.read == read));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, type, message, timestamp, read);

  @override
  String toString() {
    return 'ClientNotification(id: $id, type: $type, message: $message, timestamp: $timestamp, read: $read)';
  }
}

/// @nodoc
abstract mixin class $ClientNotificationCopyWith<$Res> {
  factory $ClientNotificationCopyWith(
          ClientNotification value, $Res Function(ClientNotification) _then) =
      _$ClientNotificationCopyWithImpl;
  @useResult
  $Res call(
      {String id, String type, String message, String timestamp, bool read});
}

/// @nodoc
class _$ClientNotificationCopyWithImpl<$Res>
    implements $ClientNotificationCopyWith<$Res> {
  _$ClientNotificationCopyWithImpl(this._self, this._then);

  final ClientNotification _self;
  final $Res Function(ClientNotification) _then;

  /// Create a copy of ClientNotification
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? message = null,
    Object? timestamp = null,
    Object? read = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as String,
      read: null == read
          ? _self.read
          : read // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [ClientNotification].
extension ClientNotificationPatterns on ClientNotification {
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
    TResult Function(_ClientNotification value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ClientNotification() when $default != null:
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
    TResult Function(_ClientNotification value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ClientNotification():
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
    TResult? Function(_ClientNotification value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ClientNotification() when $default != null:
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
    TResult Function(String id, String type, String message, String timestamp,
            bool read)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ClientNotification() when $default != null:
        return $default(
            _that.id, _that.type, _that.message, _that.timestamp, _that.read);
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
            String id, String type, String message, String timestamp, bool read)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ClientNotification():
        return $default(
            _that.id, _that.type, _that.message, _that.timestamp, _that.read);
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
    TResult? Function(String id, String type, String message, String timestamp,
            bool read)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ClientNotification() when $default != null:
        return $default(
            _that.id, _that.type, _that.message, _that.timestamp, _that.read);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ClientNotification implements ClientNotification {
  const _ClientNotification(
      {required this.id,
      required this.type,
      required this.message,
      required this.timestamp,
      required this.read});
  factory _ClientNotification.fromJson(Map<String, dynamic> json) =>
      _$ClientNotificationFromJson(json);

  @override
  final String id;
  @override
  final String type;
  @override
  final String message;
  @override
  final String timestamp;
  @override
  final bool read;

  /// Create a copy of ClientNotification
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ClientNotificationCopyWith<_ClientNotification> get copyWith =>
      __$ClientNotificationCopyWithImpl<_ClientNotification>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ClientNotificationToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ClientNotification &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.read, read) || other.read == read));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, type, message, timestamp, read);

  @override
  String toString() {
    return 'ClientNotification(id: $id, type: $type, message: $message, timestamp: $timestamp, read: $read)';
  }
}

/// @nodoc
abstract mixin class _$ClientNotificationCopyWith<$Res>
    implements $ClientNotificationCopyWith<$Res> {
  factory _$ClientNotificationCopyWith(
          _ClientNotification value, $Res Function(_ClientNotification) _then) =
      __$ClientNotificationCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id, String type, String message, String timestamp, bool read});
}

/// @nodoc
class __$ClientNotificationCopyWithImpl<$Res>
    implements _$ClientNotificationCopyWith<$Res> {
  __$ClientNotificationCopyWithImpl(this._self, this._then);

  final _ClientNotification _self;
  final $Res Function(_ClientNotification) _then;

  /// Create a copy of ClientNotification
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? message = null,
    Object? timestamp = null,
    Object? read = null,
  }) {
    return _then(_ClientNotification(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as String,
      read: null == read
          ? _self.read
          : read // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
mixin _$WorkerLocation {
  String get appointmentId;
  String get workerName;
  double get latitude;
  double get longitude;
  double get accuracy;
  String get timestamp;
  bool get isEnRoute;
  String? get eta;
  double? get distanceRemaining;
  String? get lastUpdated;

  /// Create a copy of WorkerLocation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WorkerLocationCopyWith<WorkerLocation> get copyWith =>
      _$WorkerLocationCopyWithImpl<WorkerLocation>(
          this as WorkerLocation, _$identity);

  /// Serializes this WorkerLocation to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WorkerLocation &&
            (identical(other.appointmentId, appointmentId) ||
                other.appointmentId == appointmentId) &&
            (identical(other.workerName, workerName) ||
                other.workerName == workerName) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.accuracy, accuracy) ||
                other.accuracy == accuracy) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.isEnRoute, isEnRoute) ||
                other.isEnRoute == isEnRoute) &&
            (identical(other.eta, eta) || other.eta == eta) &&
            (identical(other.distanceRemaining, distanceRemaining) ||
                other.distanceRemaining == distanceRemaining) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      appointmentId,
      workerName,
      latitude,
      longitude,
      accuracy,
      timestamp,
      isEnRoute,
      eta,
      distanceRemaining,
      lastUpdated);

  @override
  String toString() {
    return 'WorkerLocation(appointmentId: $appointmentId, workerName: $workerName, latitude: $latitude, longitude: $longitude, accuracy: $accuracy, timestamp: $timestamp, isEnRoute: $isEnRoute, eta: $eta, distanceRemaining: $distanceRemaining, lastUpdated: $lastUpdated)';
  }
}

/// @nodoc
abstract mixin class $WorkerLocationCopyWith<$Res> {
  factory $WorkerLocationCopyWith(
          WorkerLocation value, $Res Function(WorkerLocation) _then) =
      _$WorkerLocationCopyWithImpl;
  @useResult
  $Res call(
      {String appointmentId,
      String workerName,
      double latitude,
      double longitude,
      double accuracy,
      String timestamp,
      bool isEnRoute,
      String? eta,
      double? distanceRemaining,
      String? lastUpdated});
}

/// @nodoc
class _$WorkerLocationCopyWithImpl<$Res>
    implements $WorkerLocationCopyWith<$Res> {
  _$WorkerLocationCopyWithImpl(this._self, this._then);

  final WorkerLocation _self;
  final $Res Function(WorkerLocation) _then;

  /// Create a copy of WorkerLocation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appointmentId = null,
    Object? workerName = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? accuracy = null,
    Object? timestamp = null,
    Object? isEnRoute = null,
    Object? eta = freezed,
    Object? distanceRemaining = freezed,
    Object? lastUpdated = freezed,
  }) {
    return _then(_self.copyWith(
      appointmentId: null == appointmentId
          ? _self.appointmentId
          : appointmentId // ignore: cast_nullable_to_non_nullable
              as String,
      workerName: null == workerName
          ? _self.workerName
          : workerName // ignore: cast_nullable_to_non_nullable
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
              as String,
      isEnRoute: null == isEnRoute
          ? _self.isEnRoute
          : isEnRoute // ignore: cast_nullable_to_non_nullable
              as bool,
      eta: freezed == eta
          ? _self.eta
          : eta // ignore: cast_nullable_to_non_nullable
              as String?,
      distanceRemaining: freezed == distanceRemaining
          ? _self.distanceRemaining
          : distanceRemaining // ignore: cast_nullable_to_non_nullable
              as double?,
      lastUpdated: freezed == lastUpdated
          ? _self.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [WorkerLocation].
extension WorkerLocationPatterns on WorkerLocation {
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
    TResult Function(_WorkerLocation value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _WorkerLocation() when $default != null:
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
    TResult Function(_WorkerLocation value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WorkerLocation():
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
    TResult? Function(_WorkerLocation value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WorkerLocation() when $default != null:
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
            String workerName,
            double latitude,
            double longitude,
            double accuracy,
            String timestamp,
            bool isEnRoute,
            String? eta,
            double? distanceRemaining,
            String? lastUpdated)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _WorkerLocation() when $default != null:
        return $default(
            _that.appointmentId,
            _that.workerName,
            _that.latitude,
            _that.longitude,
            _that.accuracy,
            _that.timestamp,
            _that.isEnRoute,
            _that.eta,
            _that.distanceRemaining,
            _that.lastUpdated);
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
            String workerName,
            double latitude,
            double longitude,
            double accuracy,
            String timestamp,
            bool isEnRoute,
            String? eta,
            double? distanceRemaining,
            String? lastUpdated)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WorkerLocation():
        return $default(
            _that.appointmentId,
            _that.workerName,
            _that.latitude,
            _that.longitude,
            _that.accuracy,
            _that.timestamp,
            _that.isEnRoute,
            _that.eta,
            _that.distanceRemaining,
            _that.lastUpdated);
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
            String workerName,
            double latitude,
            double longitude,
            double accuracy,
            String timestamp,
            bool isEnRoute,
            String? eta,
            double? distanceRemaining,
            String? lastUpdated)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WorkerLocation() when $default != null:
        return $default(
            _that.appointmentId,
            _that.workerName,
            _that.latitude,
            _that.longitude,
            _that.accuracy,
            _that.timestamp,
            _that.isEnRoute,
            _that.eta,
            _that.distanceRemaining,
            _that.lastUpdated);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _WorkerLocation implements WorkerLocation {
  const _WorkerLocation(
      {required this.appointmentId,
      required this.workerName,
      required this.latitude,
      required this.longitude,
      required this.accuracy,
      required this.timestamp,
      required this.isEnRoute,
      this.eta,
      this.distanceRemaining,
      this.lastUpdated});
  factory _WorkerLocation.fromJson(Map<String, dynamic> json) =>
      _$WorkerLocationFromJson(json);

  @override
  final String appointmentId;
  @override
  final String workerName;
  @override
  final double latitude;
  @override
  final double longitude;
  @override
  final double accuracy;
  @override
  final String timestamp;
  @override
  final bool isEnRoute;
  @override
  final String? eta;
  @override
  final double? distanceRemaining;
  @override
  final String? lastUpdated;

  /// Create a copy of WorkerLocation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WorkerLocationCopyWith<_WorkerLocation> get copyWith =>
      __$WorkerLocationCopyWithImpl<_WorkerLocation>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$WorkerLocationToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WorkerLocation &&
            (identical(other.appointmentId, appointmentId) ||
                other.appointmentId == appointmentId) &&
            (identical(other.workerName, workerName) ||
                other.workerName == workerName) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.accuracy, accuracy) ||
                other.accuracy == accuracy) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.isEnRoute, isEnRoute) ||
                other.isEnRoute == isEnRoute) &&
            (identical(other.eta, eta) || other.eta == eta) &&
            (identical(other.distanceRemaining, distanceRemaining) ||
                other.distanceRemaining == distanceRemaining) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      appointmentId,
      workerName,
      latitude,
      longitude,
      accuracy,
      timestamp,
      isEnRoute,
      eta,
      distanceRemaining,
      lastUpdated);

  @override
  String toString() {
    return 'WorkerLocation(appointmentId: $appointmentId, workerName: $workerName, latitude: $latitude, longitude: $longitude, accuracy: $accuracy, timestamp: $timestamp, isEnRoute: $isEnRoute, eta: $eta, distanceRemaining: $distanceRemaining, lastUpdated: $lastUpdated)';
  }
}

/// @nodoc
abstract mixin class _$WorkerLocationCopyWith<$Res>
    implements $WorkerLocationCopyWith<$Res> {
  factory _$WorkerLocationCopyWith(
          _WorkerLocation value, $Res Function(_WorkerLocation) _then) =
      __$WorkerLocationCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String appointmentId,
      String workerName,
      double latitude,
      double longitude,
      double accuracy,
      String timestamp,
      bool isEnRoute,
      String? eta,
      double? distanceRemaining,
      String? lastUpdated});
}

/// @nodoc
class __$WorkerLocationCopyWithImpl<$Res>
    implements _$WorkerLocationCopyWith<$Res> {
  __$WorkerLocationCopyWithImpl(this._self, this._then);

  final _WorkerLocation _self;
  final $Res Function(_WorkerLocation) _then;

  /// Create a copy of WorkerLocation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? appointmentId = null,
    Object? workerName = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? accuracy = null,
    Object? timestamp = null,
    Object? isEnRoute = null,
    Object? eta = freezed,
    Object? distanceRemaining = freezed,
    Object? lastUpdated = freezed,
  }) {
    return _then(_WorkerLocation(
      appointmentId: null == appointmentId
          ? _self.appointmentId
          : appointmentId // ignore: cast_nullable_to_non_nullable
              as String,
      workerName: null == workerName
          ? _self.workerName
          : workerName // ignore: cast_nullable_to_non_nullable
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
              as String,
      isEnRoute: null == isEnRoute
          ? _self.isEnRoute
          : isEnRoute // ignore: cast_nullable_to_non_nullable
              as bool,
      eta: freezed == eta
          ? _self.eta
          : eta // ignore: cast_nullable_to_non_nullable
              as String?,
      distanceRemaining: freezed == distanceRemaining
          ? _self.distanceRemaining
          : distanceRemaining // ignore: cast_nullable_to_non_nullable
              as double?,
      lastUpdated: freezed == lastUpdated
          ? _self.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$AppointmentStatus {
  String get appointmentId;
  String get status;
  String get workerName;
  String get serviceName;
  String get startTime;
  String get endTime;
  String? get actualStartTime;
  String? get actualEndTime;
  String? get eta;
  List<String> get notes;
  List<String> get photos;
  List<ChecklistItem> get checklistItems;
  String get lastUpdated;

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
            (identical(other.workerName, workerName) ||
                other.workerName == workerName) &&
            (identical(other.serviceName, serviceName) ||
                other.serviceName == serviceName) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.actualStartTime, actualStartTime) ||
                other.actualStartTime == actualStartTime) &&
            (identical(other.actualEndTime, actualEndTime) ||
                other.actualEndTime == actualEndTime) &&
            (identical(other.eta, eta) || other.eta == eta) &&
            const DeepCollectionEquality().equals(other.notes, notes) &&
            const DeepCollectionEquality().equals(other.photos, photos) &&
            const DeepCollectionEquality()
                .equals(other.checklistItems, checklistItems) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      appointmentId,
      status,
      workerName,
      serviceName,
      startTime,
      endTime,
      actualStartTime,
      actualEndTime,
      eta,
      const DeepCollectionEquality().hash(notes),
      const DeepCollectionEquality().hash(photos),
      const DeepCollectionEquality().hash(checklistItems),
      lastUpdated);

  @override
  String toString() {
    return 'AppointmentStatus(appointmentId: $appointmentId, status: $status, workerName: $workerName, serviceName: $serviceName, startTime: $startTime, endTime: $endTime, actualStartTime: $actualStartTime, actualEndTime: $actualEndTime, eta: $eta, notes: $notes, photos: $photos, checklistItems: $checklistItems, lastUpdated: $lastUpdated)';
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
      String workerName,
      String serviceName,
      String startTime,
      String endTime,
      String? actualStartTime,
      String? actualEndTime,
      String? eta,
      List<String> notes,
      List<String> photos,
      List<ChecklistItem> checklistItems,
      String lastUpdated});
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
    Object? workerName = null,
    Object? serviceName = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? actualStartTime = freezed,
    Object? actualEndTime = freezed,
    Object? eta = freezed,
    Object? notes = null,
    Object? photos = null,
    Object? checklistItems = null,
    Object? lastUpdated = null,
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
      workerName: null == workerName
          ? _self.workerName
          : workerName // ignore: cast_nullable_to_non_nullable
              as String,
      serviceName: null == serviceName
          ? _self.serviceName
          : serviceName // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _self.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as String,
      endTime: null == endTime
          ? _self.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as String,
      actualStartTime: freezed == actualStartTime
          ? _self.actualStartTime
          : actualStartTime // ignore: cast_nullable_to_non_nullable
              as String?,
      actualEndTime: freezed == actualEndTime
          ? _self.actualEndTime
          : actualEndTime // ignore: cast_nullable_to_non_nullable
              as String?,
      eta: freezed == eta
          ? _self.eta
          : eta // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: null == notes
          ? _self.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      photos: null == photos
          ? _self.photos
          : photos // ignore: cast_nullable_to_non_nullable
              as List<String>,
      checklistItems: null == checklistItems
          ? _self.checklistItems
          : checklistItems // ignore: cast_nullable_to_non_nullable
              as List<ChecklistItem>,
      lastUpdated: null == lastUpdated
          ? _self.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as String,
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
    TResult Function(
            String appointmentId,
            String status,
            String workerName,
            String serviceName,
            String startTime,
            String endTime,
            String? actualStartTime,
            String? actualEndTime,
            String? eta,
            List<String> notes,
            List<String> photos,
            List<ChecklistItem> checklistItems,
            String lastUpdated)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AppointmentStatus() when $default != null:
        return $default(
            _that.appointmentId,
            _that.status,
            _that.workerName,
            _that.serviceName,
            _that.startTime,
            _that.endTime,
            _that.actualStartTime,
            _that.actualEndTime,
            _that.eta,
            _that.notes,
            _that.photos,
            _that.checklistItems,
            _that.lastUpdated);
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
            String status,
            String workerName,
            String serviceName,
            String startTime,
            String endTime,
            String? actualStartTime,
            String? actualEndTime,
            String? eta,
            List<String> notes,
            List<String> photos,
            List<ChecklistItem> checklistItems,
            String lastUpdated)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AppointmentStatus():
        return $default(
            _that.appointmentId,
            _that.status,
            _that.workerName,
            _that.serviceName,
            _that.startTime,
            _that.endTime,
            _that.actualStartTime,
            _that.actualEndTime,
            _that.eta,
            _that.notes,
            _that.photos,
            _that.checklistItems,
            _that.lastUpdated);
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
            String status,
            String workerName,
            String serviceName,
            String startTime,
            String endTime,
            String? actualStartTime,
            String? actualEndTime,
            String? eta,
            List<String> notes,
            List<String> photos,
            List<ChecklistItem> checklistItems,
            String lastUpdated)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AppointmentStatus() when $default != null:
        return $default(
            _that.appointmentId,
            _that.status,
            _that.workerName,
            _that.serviceName,
            _that.startTime,
            _that.endTime,
            _that.actualStartTime,
            _that.actualEndTime,
            _that.eta,
            _that.notes,
            _that.photos,
            _that.checklistItems,
            _that.lastUpdated);
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
      required this.workerName,
      required this.serviceName,
      required this.startTime,
      required this.endTime,
      this.actualStartTime,
      this.actualEndTime,
      this.eta,
      required final List<String> notes,
      required final List<String> photos,
      required final List<ChecklistItem> checklistItems,
      required this.lastUpdated})
      : _notes = notes,
        _photos = photos,
        _checklistItems = checklistItems;
  factory _AppointmentStatus.fromJson(Map<String, dynamic> json) =>
      _$AppointmentStatusFromJson(json);

  @override
  final String appointmentId;
  @override
  final String status;
  @override
  final String workerName;
  @override
  final String serviceName;
  @override
  final String startTime;
  @override
  final String endTime;
  @override
  final String? actualStartTime;
  @override
  final String? actualEndTime;
  @override
  final String? eta;
  final List<String> _notes;
  @override
  List<String> get notes {
    if (_notes is EqualUnmodifiableListView) return _notes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_notes);
  }

  final List<String> _photos;
  @override
  List<String> get photos {
    if (_photos is EqualUnmodifiableListView) return _photos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_photos);
  }

  final List<ChecklistItem> _checklistItems;
  @override
  List<ChecklistItem> get checklistItems {
    if (_checklistItems is EqualUnmodifiableListView) return _checklistItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_checklistItems);
  }

  @override
  final String lastUpdated;

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
            (identical(other.workerName, workerName) ||
                other.workerName == workerName) &&
            (identical(other.serviceName, serviceName) ||
                other.serviceName == serviceName) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.actualStartTime, actualStartTime) ||
                other.actualStartTime == actualStartTime) &&
            (identical(other.actualEndTime, actualEndTime) ||
                other.actualEndTime == actualEndTime) &&
            (identical(other.eta, eta) || other.eta == eta) &&
            const DeepCollectionEquality().equals(other._notes, _notes) &&
            const DeepCollectionEquality().equals(other._photos, _photos) &&
            const DeepCollectionEquality()
                .equals(other._checklistItems, _checklistItems) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      appointmentId,
      status,
      workerName,
      serviceName,
      startTime,
      endTime,
      actualStartTime,
      actualEndTime,
      eta,
      const DeepCollectionEquality().hash(_notes),
      const DeepCollectionEquality().hash(_photos),
      const DeepCollectionEquality().hash(_checklistItems),
      lastUpdated);

  @override
  String toString() {
    return 'AppointmentStatus(appointmentId: $appointmentId, status: $status, workerName: $workerName, serviceName: $serviceName, startTime: $startTime, endTime: $endTime, actualStartTime: $actualStartTime, actualEndTime: $actualEndTime, eta: $eta, notes: $notes, photos: $photos, checklistItems: $checklistItems, lastUpdated: $lastUpdated)';
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
      String workerName,
      String serviceName,
      String startTime,
      String endTime,
      String? actualStartTime,
      String? actualEndTime,
      String? eta,
      List<String> notes,
      List<String> photos,
      List<ChecklistItem> checklistItems,
      String lastUpdated});
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
    Object? workerName = null,
    Object? serviceName = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? actualStartTime = freezed,
    Object? actualEndTime = freezed,
    Object? eta = freezed,
    Object? notes = null,
    Object? photos = null,
    Object? checklistItems = null,
    Object? lastUpdated = null,
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
      workerName: null == workerName
          ? _self.workerName
          : workerName // ignore: cast_nullable_to_non_nullable
              as String,
      serviceName: null == serviceName
          ? _self.serviceName
          : serviceName // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _self.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as String,
      endTime: null == endTime
          ? _self.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as String,
      actualStartTime: freezed == actualStartTime
          ? _self.actualStartTime
          : actualStartTime // ignore: cast_nullable_to_non_nullable
              as String?,
      actualEndTime: freezed == actualEndTime
          ? _self.actualEndTime
          : actualEndTime // ignore: cast_nullable_to_non_nullable
              as String?,
      eta: freezed == eta
          ? _self.eta
          : eta // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: null == notes
          ? _self._notes
          : notes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      photos: null == photos
          ? _self._photos
          : photos // ignore: cast_nullable_to_non_nullable
              as List<String>,
      checklistItems: null == checklistItems
          ? _self._checklistItems
          : checklistItems // ignore: cast_nullable_to_non_nullable
              as List<ChecklistItem>,
      lastUpdated: null == lastUpdated
          ? _self.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$ChecklistItem {
  String get item;
  bool get completed;

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
            (identical(other.item, item) || other.item == item) &&
            (identical(other.completed, completed) ||
                other.completed == completed));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, item, completed);

  @override
  String toString() {
    return 'ChecklistItem(item: $item, completed: $completed)';
  }
}

/// @nodoc
abstract mixin class $ChecklistItemCopyWith<$Res> {
  factory $ChecklistItemCopyWith(
          ChecklistItem value, $Res Function(ChecklistItem) _then) =
      _$ChecklistItemCopyWithImpl;
  @useResult
  $Res call({String item, bool completed});
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
    Object? item = null,
    Object? completed = null,
  }) {
    return _then(_self.copyWith(
      item: null == item
          ? _self.item
          : item // ignore: cast_nullable_to_non_nullable
              as String,
      completed: null == completed
          ? _self.completed
          : completed // ignore: cast_nullable_to_non_nullable
              as bool,
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
    TResult Function(String item, bool completed)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ChecklistItem() when $default != null:
        return $default(_that.item, _that.completed);
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
    TResult Function(String item, bool completed) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ChecklistItem():
        return $default(_that.item, _that.completed);
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
    TResult? Function(String item, bool completed)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ChecklistItem() when $default != null:
        return $default(_that.item, _that.completed);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ChecklistItem implements ChecklistItem {
  const _ChecklistItem({required this.item, required this.completed});
  factory _ChecklistItem.fromJson(Map<String, dynamic> json) =>
      _$ChecklistItemFromJson(json);

  @override
  final String item;
  @override
  final bool completed;

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
            (identical(other.item, item) || other.item == item) &&
            (identical(other.completed, completed) ||
                other.completed == completed));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, item, completed);

  @override
  String toString() {
    return 'ChecklistItem(item: $item, completed: $completed)';
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
  $Res call({String item, bool completed});
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
    Object? item = null,
    Object? completed = null,
  }) {
    return _then(_ChecklistItem(
      item: null == item
          ? _self.item
          : item // ignore: cast_nullable_to_non_nullable
              as String,
      completed: null == completed
          ? _self.completed
          : completed // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
mixin _$ServiceHistory {
  String get serviceId;
  String get workerName;
  String get serviceName;
  String get date;
  String get startTime;
  String get endTime;
  int get rating;
  String? get feedback;

  /// Create a copy of ServiceHistory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ServiceHistoryCopyWith<ServiceHistory> get copyWith =>
      _$ServiceHistoryCopyWithImpl<ServiceHistory>(
          this as ServiceHistory, _$identity);

  /// Serializes this ServiceHistory to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ServiceHistory &&
            (identical(other.serviceId, serviceId) ||
                other.serviceId == serviceId) &&
            (identical(other.workerName, workerName) ||
                other.workerName == workerName) &&
            (identical(other.serviceName, serviceName) ||
                other.serviceName == serviceName) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.feedback, feedback) ||
                other.feedback == feedback));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, serviceId, workerName,
      serviceName, date, startTime, endTime, rating, feedback);

  @override
  String toString() {
    return 'ServiceHistory(serviceId: $serviceId, workerName: $workerName, serviceName: $serviceName, date: $date, startTime: $startTime, endTime: $endTime, rating: $rating, feedback: $feedback)';
  }
}

/// @nodoc
abstract mixin class $ServiceHistoryCopyWith<$Res> {
  factory $ServiceHistoryCopyWith(
          ServiceHistory value, $Res Function(ServiceHistory) _then) =
      _$ServiceHistoryCopyWithImpl;
  @useResult
  $Res call(
      {String serviceId,
      String workerName,
      String serviceName,
      String date,
      String startTime,
      String endTime,
      int rating,
      String? feedback});
}

/// @nodoc
class _$ServiceHistoryCopyWithImpl<$Res>
    implements $ServiceHistoryCopyWith<$Res> {
  _$ServiceHistoryCopyWithImpl(this._self, this._then);

  final ServiceHistory _self;
  final $Res Function(ServiceHistory) _then;

  /// Create a copy of ServiceHistory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? serviceId = null,
    Object? workerName = null,
    Object? serviceName = null,
    Object? date = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? rating = null,
    Object? feedback = freezed,
  }) {
    return _then(_self.copyWith(
      serviceId: null == serviceId
          ? _self.serviceId
          : serviceId // ignore: cast_nullable_to_non_nullable
              as String,
      workerName: null == workerName
          ? _self.workerName
          : workerName // ignore: cast_nullable_to_non_nullable
              as String,
      serviceName: null == serviceName
          ? _self.serviceName
          : serviceName // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _self.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as String,
      endTime: null == endTime
          ? _self.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as String,
      rating: null == rating
          ? _self.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as int,
      feedback: freezed == feedback
          ? _self.feedback
          : feedback // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [ServiceHistory].
extension ServiceHistoryPatterns on ServiceHistory {
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
    TResult Function(_ServiceHistory value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ServiceHistory() when $default != null:
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
    TResult Function(_ServiceHistory value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ServiceHistory():
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
    TResult? Function(_ServiceHistory value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ServiceHistory() when $default != null:
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
            String serviceId,
            String workerName,
            String serviceName,
            String date,
            String startTime,
            String endTime,
            int rating,
            String? feedback)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ServiceHistory() when $default != null:
        return $default(
            _that.serviceId,
            _that.workerName,
            _that.serviceName,
            _that.date,
            _that.startTime,
            _that.endTime,
            _that.rating,
            _that.feedback);
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
            String serviceId,
            String workerName,
            String serviceName,
            String date,
            String startTime,
            String endTime,
            int rating,
            String? feedback)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ServiceHistory():
        return $default(
            _that.serviceId,
            _that.workerName,
            _that.serviceName,
            _that.date,
            _that.startTime,
            _that.endTime,
            _that.rating,
            _that.feedback);
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
            String serviceId,
            String workerName,
            String serviceName,
            String date,
            String startTime,
            String endTime,
            int rating,
            String? feedback)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ServiceHistory() when $default != null:
        return $default(
            _that.serviceId,
            _that.workerName,
            _that.serviceName,
            _that.date,
            _that.startTime,
            _that.endTime,
            _that.rating,
            _that.feedback);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ServiceHistory implements ServiceHistory {
  const _ServiceHistory(
      {required this.serviceId,
      required this.workerName,
      required this.serviceName,
      required this.date,
      required this.startTime,
      required this.endTime,
      required this.rating,
      this.feedback});
  factory _ServiceHistory.fromJson(Map<String, dynamic> json) =>
      _$ServiceHistoryFromJson(json);

  @override
  final String serviceId;
  @override
  final String workerName;
  @override
  final String serviceName;
  @override
  final String date;
  @override
  final String startTime;
  @override
  final String endTime;
  @override
  final int rating;
  @override
  final String? feedback;

  /// Create a copy of ServiceHistory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ServiceHistoryCopyWith<_ServiceHistory> get copyWith =>
      __$ServiceHistoryCopyWithImpl<_ServiceHistory>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ServiceHistoryToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ServiceHistory &&
            (identical(other.serviceId, serviceId) ||
                other.serviceId == serviceId) &&
            (identical(other.workerName, workerName) ||
                other.workerName == workerName) &&
            (identical(other.serviceName, serviceName) ||
                other.serviceName == serviceName) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.feedback, feedback) ||
                other.feedback == feedback));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, serviceId, workerName,
      serviceName, date, startTime, endTime, rating, feedback);

  @override
  String toString() {
    return 'ServiceHistory(serviceId: $serviceId, workerName: $workerName, serviceName: $serviceName, date: $date, startTime: $startTime, endTime: $endTime, rating: $rating, feedback: $feedback)';
  }
}

/// @nodoc
abstract mixin class _$ServiceHistoryCopyWith<$Res>
    implements $ServiceHistoryCopyWith<$Res> {
  factory _$ServiceHistoryCopyWith(
          _ServiceHistory value, $Res Function(_ServiceHistory) _then) =
      __$ServiceHistoryCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String serviceId,
      String workerName,
      String serviceName,
      String date,
      String startTime,
      String endTime,
      int rating,
      String? feedback});
}

/// @nodoc
class __$ServiceHistoryCopyWithImpl<$Res>
    implements _$ServiceHistoryCopyWith<$Res> {
  __$ServiceHistoryCopyWithImpl(this._self, this._then);

  final _ServiceHistory _self;
  final $Res Function(_ServiceHistory) _then;

  /// Create a copy of ServiceHistory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? serviceId = null,
    Object? workerName = null,
    Object? serviceName = null,
    Object? date = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? rating = null,
    Object? feedback = freezed,
  }) {
    return _then(_ServiceHistory(
      serviceId: null == serviceId
          ? _self.serviceId
          : serviceId // ignore: cast_nullable_to_non_nullable
              as String,
      workerName: null == workerName
          ? _self.workerName
          : workerName // ignore: cast_nullable_to_non_nullable
              as String,
      serviceName: null == serviceName
          ? _self.serviceName
          : serviceName // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _self.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as String,
      endTime: null == endTime
          ? _self.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as String,
      rating: null == rating
          ? _self.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as int,
      feedback: freezed == feedback
          ? _self.feedback
          : feedback // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$ClientAppointment {
  String get id;
  String get date;
  String get startTime;
  String get endTime;
  String? get userEmail;
  String? get assignmentId;
  String? get scheduleId;

  /// Create a copy of ClientAppointment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ClientAppointmentCopyWith<ClientAppointment> get copyWith =>
      _$ClientAppointmentCopyWithImpl<ClientAppointment>(
          this as ClientAppointment, _$identity);

  /// Serializes this ClientAppointment to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ClientAppointment &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.userEmail, userEmail) ||
                other.userEmail == userEmail) &&
            (identical(other.assignmentId, assignmentId) ||
                other.assignmentId == assignmentId) &&
            (identical(other.scheduleId, scheduleId) ||
                other.scheduleId == scheduleId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, date, startTime, endTime,
      userEmail, assignmentId, scheduleId);

  @override
  String toString() {
    return 'ClientAppointment(id: $id, date: $date, startTime: $startTime, endTime: $endTime, userEmail: $userEmail, assignmentId: $assignmentId, scheduleId: $scheduleId)';
  }
}

/// @nodoc
abstract mixin class $ClientAppointmentCopyWith<$Res> {
  factory $ClientAppointmentCopyWith(
          ClientAppointment value, $Res Function(ClientAppointment) _then) =
      _$ClientAppointmentCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String date,
      String startTime,
      String endTime,
      String? userEmail,
      String? assignmentId,
      String? scheduleId});
}

/// @nodoc
class _$ClientAppointmentCopyWithImpl<$Res>
    implements $ClientAppointmentCopyWith<$Res> {
  _$ClientAppointmentCopyWithImpl(this._self, this._then);

  final ClientAppointment _self;
  final $Res Function(ClientAppointment) _then;

  /// Create a copy of ClientAppointment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? userEmail = freezed,
    Object? assignmentId = freezed,
    Object? scheduleId = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _self.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as String,
      endTime: null == endTime
          ? _self.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as String,
      userEmail: freezed == userEmail
          ? _self.userEmail
          : userEmail // ignore: cast_nullable_to_non_nullable
              as String?,
      assignmentId: freezed == assignmentId
          ? _self.assignmentId
          : assignmentId // ignore: cast_nullable_to_non_nullable
              as String?,
      scheduleId: freezed == scheduleId
          ? _self.scheduleId
          : scheduleId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [ClientAppointment].
extension ClientAppointmentPatterns on ClientAppointment {
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
    TResult Function(_ClientAppointment value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ClientAppointment() when $default != null:
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
    TResult Function(_ClientAppointment value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ClientAppointment():
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
    TResult? Function(_ClientAppointment value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ClientAppointment() when $default != null:
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
    TResult Function(String id, String date, String startTime, String endTime,
            String? userEmail, String? assignmentId, String? scheduleId)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ClientAppointment() when $default != null:
        return $default(_that.id, _that.date, _that.startTime, _that.endTime,
            _that.userEmail, _that.assignmentId, _that.scheduleId);
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
    TResult Function(String id, String date, String startTime, String endTime,
            String? userEmail, String? assignmentId, String? scheduleId)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ClientAppointment():
        return $default(_that.id, _that.date, _that.startTime, _that.endTime,
            _that.userEmail, _that.assignmentId, _that.scheduleId);
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
    TResult? Function(String id, String date, String startTime, String endTime,
            String? userEmail, String? assignmentId, String? scheduleId)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ClientAppointment() when $default != null:
        return $default(_that.id, _that.date, _that.startTime, _that.endTime,
            _that.userEmail, _that.assignmentId, _that.scheduleId);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ClientAppointment implements ClientAppointment {
  const _ClientAppointment(
      {required this.id,
      required this.date,
      required this.startTime,
      required this.endTime,
      this.userEmail,
      this.assignmentId,
      this.scheduleId});
  factory _ClientAppointment.fromJson(Map<String, dynamic> json) =>
      _$ClientAppointmentFromJson(json);

  @override
  final String id;
  @override
  final String date;
  @override
  final String startTime;
  @override
  final String endTime;
  @override
  final String? userEmail;
  @override
  final String? assignmentId;
  @override
  final String? scheduleId;

  /// Create a copy of ClientAppointment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ClientAppointmentCopyWith<_ClientAppointment> get copyWith =>
      __$ClientAppointmentCopyWithImpl<_ClientAppointment>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ClientAppointmentToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ClientAppointment &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.userEmail, userEmail) ||
                other.userEmail == userEmail) &&
            (identical(other.assignmentId, assignmentId) ||
                other.assignmentId == assignmentId) &&
            (identical(other.scheduleId, scheduleId) ||
                other.scheduleId == scheduleId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, date, startTime, endTime,
      userEmail, assignmentId, scheduleId);

  @override
  String toString() {
    return 'ClientAppointment(id: $id, date: $date, startTime: $startTime, endTime: $endTime, userEmail: $userEmail, assignmentId: $assignmentId, scheduleId: $scheduleId)';
  }
}

/// @nodoc
abstract mixin class _$ClientAppointmentCopyWith<$Res>
    implements $ClientAppointmentCopyWith<$Res> {
  factory _$ClientAppointmentCopyWith(
          _ClientAppointment value, $Res Function(_ClientAppointment) _then) =
      __$ClientAppointmentCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String date,
      String startTime,
      String endTime,
      String? userEmail,
      String? assignmentId,
      String? scheduleId});
}

/// @nodoc
class __$ClientAppointmentCopyWithImpl<$Res>
    implements _$ClientAppointmentCopyWith<$Res> {
  __$ClientAppointmentCopyWithImpl(this._self, this._then);

  final _ClientAppointment _self;
  final $Res Function(_ClientAppointment) _then;

  /// Create a copy of ClientAppointment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? userEmail = freezed,
    Object? assignmentId = freezed,
    Object? scheduleId = freezed,
  }) {
    return _then(_ClientAppointment(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _self.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as String,
      endTime: null == endTime
          ? _self.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as String,
      userEmail: freezed == userEmail
          ? _self.userEmail
          : userEmail // ignore: cast_nullable_to_non_nullable
              as String?,
      assignmentId: freezed == assignmentId
          ? _self.assignmentId
          : assignmentId // ignore: cast_nullable_to_non_nullable
              as String?,
      scheduleId: freezed == scheduleId
          ? _self.scheduleId
          : scheduleId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$ClientAppointmentDetail {
  String get id;
  String get date;
  String get startTime;
  String get endTime;
  String get status;
  String? get notes;
  ClientEmployee? get employee;
  List<String>? get services;
  String? get serviceName;
  String? get location;
  String? get assignmentId;
  String? get scheduleId;

  /// Create a copy of ClientAppointmentDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ClientAppointmentDetailCopyWith<ClientAppointmentDetail> get copyWith =>
      _$ClientAppointmentDetailCopyWithImpl<ClientAppointmentDetail>(
          this as ClientAppointmentDetail, _$identity);

  /// Serializes this ClientAppointmentDetail to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ClientAppointmentDetail &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.employee, employee) ||
                other.employee == employee) &&
            const DeepCollectionEquality().equals(other.services, services) &&
            (identical(other.serviceName, serviceName) ||
                other.serviceName == serviceName) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.assignmentId, assignmentId) ||
                other.assignmentId == assignmentId) &&
            (identical(other.scheduleId, scheduleId) ||
                other.scheduleId == scheduleId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      date,
      startTime,
      endTime,
      status,
      notes,
      employee,
      const DeepCollectionEquality().hash(services),
      serviceName,
      location,
      assignmentId,
      scheduleId);

  @override
  String toString() {
    return 'ClientAppointmentDetail(id: $id, date: $date, startTime: $startTime, endTime: $endTime, status: $status, notes: $notes, employee: $employee, services: $services, serviceName: $serviceName, location: $location, assignmentId: $assignmentId, scheduleId: $scheduleId)';
  }
}

/// @nodoc
abstract mixin class $ClientAppointmentDetailCopyWith<$Res> {
  factory $ClientAppointmentDetailCopyWith(ClientAppointmentDetail value,
          $Res Function(ClientAppointmentDetail) _then) =
      _$ClientAppointmentDetailCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String date,
      String startTime,
      String endTime,
      String status,
      String? notes,
      ClientEmployee? employee,
      List<String>? services,
      String? serviceName,
      String? location,
      String? assignmentId,
      String? scheduleId});

  $ClientEmployeeCopyWith<$Res>? get employee;
}

/// @nodoc
class _$ClientAppointmentDetailCopyWithImpl<$Res>
    implements $ClientAppointmentDetailCopyWith<$Res> {
  _$ClientAppointmentDetailCopyWithImpl(this._self, this._then);

  final ClientAppointmentDetail _self;
  final $Res Function(ClientAppointmentDetail) _then;

  /// Create a copy of ClientAppointmentDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? status = null,
    Object? notes = freezed,
    Object? employee = freezed,
    Object? services = freezed,
    Object? serviceName = freezed,
    Object? location = freezed,
    Object? assignmentId = freezed,
    Object? scheduleId = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _self.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as String,
      endTime: null == endTime
          ? _self.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      notes: freezed == notes
          ? _self.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      employee: freezed == employee
          ? _self.employee
          : employee // ignore: cast_nullable_to_non_nullable
              as ClientEmployee?,
      services: freezed == services
          ? _self.services
          : services // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      serviceName: freezed == serviceName
          ? _self.serviceName
          : serviceName // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _self.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      assignmentId: freezed == assignmentId
          ? _self.assignmentId
          : assignmentId // ignore: cast_nullable_to_non_nullable
              as String?,
      scheduleId: freezed == scheduleId
          ? _self.scheduleId
          : scheduleId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of ClientAppointmentDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ClientEmployeeCopyWith<$Res>? get employee {
    if (_self.employee == null) {
      return null;
    }

    return $ClientEmployeeCopyWith<$Res>(_self.employee!, (value) {
      return _then(_self.copyWith(employee: value));
    });
  }
}

/// Adds pattern-matching-related methods to [ClientAppointmentDetail].
extension ClientAppointmentDetailPatterns on ClientAppointmentDetail {
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
    TResult Function(_ClientAppointmentDetail value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ClientAppointmentDetail() when $default != null:
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
    TResult Function(_ClientAppointmentDetail value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ClientAppointmentDetail():
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
    TResult? Function(_ClientAppointmentDetail value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ClientAppointmentDetail() when $default != null:
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
            String date,
            String startTime,
            String endTime,
            String status,
            String? notes,
            ClientEmployee? employee,
            List<String>? services,
            String? serviceName,
            String? location,
            String? assignmentId,
            String? scheduleId)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ClientAppointmentDetail() when $default != null:
        return $default(
            _that.id,
            _that.date,
            _that.startTime,
            _that.endTime,
            _that.status,
            _that.notes,
            _that.employee,
            _that.services,
            _that.serviceName,
            _that.location,
            _that.assignmentId,
            _that.scheduleId);
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
            String date,
            String startTime,
            String endTime,
            String status,
            String? notes,
            ClientEmployee? employee,
            List<String>? services,
            String? serviceName,
            String? location,
            String? assignmentId,
            String? scheduleId)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ClientAppointmentDetail():
        return $default(
            _that.id,
            _that.date,
            _that.startTime,
            _that.endTime,
            _that.status,
            _that.notes,
            _that.employee,
            _that.services,
            _that.serviceName,
            _that.location,
            _that.assignmentId,
            _that.scheduleId);
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
            String date,
            String startTime,
            String endTime,
            String status,
            String? notes,
            ClientEmployee? employee,
            List<String>? services,
            String? serviceName,
            String? location,
            String? assignmentId,
            String? scheduleId)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ClientAppointmentDetail() when $default != null:
        return $default(
            _that.id,
            _that.date,
            _that.startTime,
            _that.endTime,
            _that.status,
            _that.notes,
            _that.employee,
            _that.services,
            _that.serviceName,
            _that.location,
            _that.assignmentId,
            _that.scheduleId);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ClientAppointmentDetail implements ClientAppointmentDetail {
  const _ClientAppointmentDetail(
      {required this.id,
      required this.date,
      required this.startTime,
      required this.endTime,
      required this.status,
      this.notes,
      this.employee,
      final List<String>? services,
      this.serviceName,
      this.location,
      this.assignmentId,
      this.scheduleId})
      : _services = services;
  factory _ClientAppointmentDetail.fromJson(Map<String, dynamic> json) =>
      _$ClientAppointmentDetailFromJson(json);

  @override
  final String id;
  @override
  final String date;
  @override
  final String startTime;
  @override
  final String endTime;
  @override
  final String status;
  @override
  final String? notes;
  @override
  final ClientEmployee? employee;
  final List<String>? _services;
  @override
  List<String>? get services {
    final value = _services;
    if (value == null) return null;
    if (_services is EqualUnmodifiableListView) return _services;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? serviceName;
  @override
  final String? location;
  @override
  final String? assignmentId;
  @override
  final String? scheduleId;

  /// Create a copy of ClientAppointmentDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ClientAppointmentDetailCopyWith<_ClientAppointmentDetail> get copyWith =>
      __$ClientAppointmentDetailCopyWithImpl<_ClientAppointmentDetail>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ClientAppointmentDetailToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ClientAppointmentDetail &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.employee, employee) ||
                other.employee == employee) &&
            const DeepCollectionEquality().equals(other._services, _services) &&
            (identical(other.serviceName, serviceName) ||
                other.serviceName == serviceName) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.assignmentId, assignmentId) ||
                other.assignmentId == assignmentId) &&
            (identical(other.scheduleId, scheduleId) ||
                other.scheduleId == scheduleId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      date,
      startTime,
      endTime,
      status,
      notes,
      employee,
      const DeepCollectionEquality().hash(_services),
      serviceName,
      location,
      assignmentId,
      scheduleId);

  @override
  String toString() {
    return 'ClientAppointmentDetail(id: $id, date: $date, startTime: $startTime, endTime: $endTime, status: $status, notes: $notes, employee: $employee, services: $services, serviceName: $serviceName, location: $location, assignmentId: $assignmentId, scheduleId: $scheduleId)';
  }
}

/// @nodoc
abstract mixin class _$ClientAppointmentDetailCopyWith<$Res>
    implements $ClientAppointmentDetailCopyWith<$Res> {
  factory _$ClientAppointmentDetailCopyWith(_ClientAppointmentDetail value,
          $Res Function(_ClientAppointmentDetail) _then) =
      __$ClientAppointmentDetailCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String date,
      String startTime,
      String endTime,
      String status,
      String? notes,
      ClientEmployee? employee,
      List<String>? services,
      String? serviceName,
      String? location,
      String? assignmentId,
      String? scheduleId});

  @override
  $ClientEmployeeCopyWith<$Res>? get employee;
}

/// @nodoc
class __$ClientAppointmentDetailCopyWithImpl<$Res>
    implements _$ClientAppointmentDetailCopyWith<$Res> {
  __$ClientAppointmentDetailCopyWithImpl(this._self, this._then);

  final _ClientAppointmentDetail _self;
  final $Res Function(_ClientAppointmentDetail) _then;

  /// Create a copy of ClientAppointmentDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? status = null,
    Object? notes = freezed,
    Object? employee = freezed,
    Object? services = freezed,
    Object? serviceName = freezed,
    Object? location = freezed,
    Object? assignmentId = freezed,
    Object? scheduleId = freezed,
  }) {
    return _then(_ClientAppointmentDetail(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _self.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as String,
      endTime: null == endTime
          ? _self.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      notes: freezed == notes
          ? _self.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      employee: freezed == employee
          ? _self.employee
          : employee // ignore: cast_nullable_to_non_nullable
              as ClientEmployee?,
      services: freezed == services
          ? _self._services
          : services // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      serviceName: freezed == serviceName
          ? _self.serviceName
          : serviceName // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _self.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      assignmentId: freezed == assignmentId
          ? _self.assignmentId
          : assignmentId // ignore: cast_nullable_to_non_nullable
              as String?,
      scheduleId: freezed == scheduleId
          ? _self.scheduleId
          : scheduleId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of ClientAppointmentDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ClientEmployeeCopyWith<$Res>? get employee {
    if (_self.employee == null) {
      return null;
    }

    return $ClientEmployeeCopyWith<$Res>(_self.employee!, (value) {
      return _then(_self.copyWith(employee: value));
    });
  }
}

/// @nodoc
mixin _$ClientEmployee {
  String get email;
  String get firstName;
  String get lastName;
  String? get phone;
  String? get photo;

  /// Create a copy of ClientEmployee
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ClientEmployeeCopyWith<ClientEmployee> get copyWith =>
      _$ClientEmployeeCopyWithImpl<ClientEmployee>(
          this as ClientEmployee, _$identity);

  /// Serializes this ClientEmployee to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ClientEmployee &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.photo, photo) || other.photo == photo));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, email, firstName, lastName, phone, photo);

  @override
  String toString() {
    return 'ClientEmployee(email: $email, firstName: $firstName, lastName: $lastName, phone: $phone, photo: $photo)';
  }
}

/// @nodoc
abstract mixin class $ClientEmployeeCopyWith<$Res> {
  factory $ClientEmployeeCopyWith(
          ClientEmployee value, $Res Function(ClientEmployee) _then) =
      _$ClientEmployeeCopyWithImpl;
  @useResult
  $Res call(
      {String email,
      String firstName,
      String lastName,
      String? phone,
      String? photo});
}

/// @nodoc
class _$ClientEmployeeCopyWithImpl<$Res>
    implements $ClientEmployeeCopyWith<$Res> {
  _$ClientEmployeeCopyWithImpl(this._self, this._then);

  final ClientEmployee _self;
  final $Res Function(ClientEmployee) _then;

  /// Create a copy of ClientEmployee
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? phone = freezed,
    Object? photo = freezed,
  }) {
    return _then(_self.copyWith(
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: null == firstName
          ? _self.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _self.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      phone: freezed == phone
          ? _self.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      photo: freezed == photo
          ? _self.photo
          : photo // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [ClientEmployee].
extension ClientEmployeePatterns on ClientEmployee {
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
    TResult Function(_ClientEmployee value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ClientEmployee() when $default != null:
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
    TResult Function(_ClientEmployee value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ClientEmployee():
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
    TResult? Function(_ClientEmployee value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ClientEmployee() when $default != null:
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
    TResult Function(String email, String firstName, String lastName,
            String? phone, String? photo)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ClientEmployee() when $default != null:
        return $default(_that.email, _that.firstName, _that.lastName,
            _that.phone, _that.photo);
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
    TResult Function(String email, String firstName, String lastName,
            String? phone, String? photo)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ClientEmployee():
        return $default(_that.email, _that.firstName, _that.lastName,
            _that.phone, _that.photo);
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
    TResult? Function(String email, String firstName, String lastName,
            String? phone, String? photo)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ClientEmployee() when $default != null:
        return $default(_that.email, _that.firstName, _that.lastName,
            _that.phone, _that.photo);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ClientEmployee implements ClientEmployee {
  const _ClientEmployee(
      {required this.email,
      required this.firstName,
      required this.lastName,
      this.phone,
      this.photo});
  factory _ClientEmployee.fromJson(Map<String, dynamic> json) =>
      _$ClientEmployeeFromJson(json);

  @override
  final String email;
  @override
  final String firstName;
  @override
  final String lastName;
  @override
  final String? phone;
  @override
  final String? photo;

  /// Create a copy of ClientEmployee
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ClientEmployeeCopyWith<_ClientEmployee> get copyWith =>
      __$ClientEmployeeCopyWithImpl<_ClientEmployee>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ClientEmployeeToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ClientEmployee &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.photo, photo) || other.photo == photo));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, email, firstName, lastName, phone, photo);

  @override
  String toString() {
    return 'ClientEmployee(email: $email, firstName: $firstName, lastName: $lastName, phone: $phone, photo: $photo)';
  }
}

/// @nodoc
abstract mixin class _$ClientEmployeeCopyWith<$Res>
    implements $ClientEmployeeCopyWith<$Res> {
  factory _$ClientEmployeeCopyWith(
          _ClientEmployee value, $Res Function(_ClientEmployee) _then) =
      __$ClientEmployeeCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String email,
      String firstName,
      String lastName,
      String? phone,
      String? photo});
}

/// @nodoc
class __$ClientEmployeeCopyWithImpl<$Res>
    implements _$ClientEmployeeCopyWith<$Res> {
  __$ClientEmployeeCopyWithImpl(this._self, this._then);

  final _ClientEmployee _self;
  final $Res Function(_ClientEmployee) _then;

  /// Create a copy of ClientEmployee
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? email = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? phone = freezed,
    Object? photo = freezed,
  }) {
    return _then(_ClientEmployee(
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: null == firstName
          ? _self.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _self.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      phone: freezed == phone
          ? _self.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      photo: freezed == photo
          ? _self.photo
          : photo // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$ClientInvoice {
  String get id;
  String get invoiceNumber;
  Map<String, dynamic> get workflow;
  Map<String, dynamic> get financialSummary;
  List<dynamic>? get lineItems;

  /// Create a copy of ClientInvoice
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ClientInvoiceCopyWith<ClientInvoice> get copyWith =>
      _$ClientInvoiceCopyWithImpl<ClientInvoice>(
          this as ClientInvoice, _$identity);

  /// Serializes this ClientInvoice to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ClientInvoice &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.invoiceNumber, invoiceNumber) ||
                other.invoiceNumber == invoiceNumber) &&
            const DeepCollectionEquality().equals(other.workflow, workflow) &&
            const DeepCollectionEquality()
                .equals(other.financialSummary, financialSummary) &&
            const DeepCollectionEquality().equals(other.lineItems, lineItems));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      invoiceNumber,
      const DeepCollectionEquality().hash(workflow),
      const DeepCollectionEquality().hash(financialSummary),
      const DeepCollectionEquality().hash(lineItems));

  @override
  String toString() {
    return 'ClientInvoice(id: $id, invoiceNumber: $invoiceNumber, workflow: $workflow, financialSummary: $financialSummary, lineItems: $lineItems)';
  }
}

/// @nodoc
abstract mixin class $ClientInvoiceCopyWith<$Res> {
  factory $ClientInvoiceCopyWith(
          ClientInvoice value, $Res Function(ClientInvoice) _then) =
      _$ClientInvoiceCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String invoiceNumber,
      Map<String, dynamic> workflow,
      Map<String, dynamic> financialSummary,
      List<dynamic>? lineItems});
}

/// @nodoc
class _$ClientInvoiceCopyWithImpl<$Res>
    implements $ClientInvoiceCopyWith<$Res> {
  _$ClientInvoiceCopyWithImpl(this._self, this._then);

  final ClientInvoice _self;
  final $Res Function(ClientInvoice) _then;

  /// Create a copy of ClientInvoice
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? invoiceNumber = null,
    Object? workflow = null,
    Object? financialSummary = null,
    Object? lineItems = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      invoiceNumber: null == invoiceNumber
          ? _self.invoiceNumber
          : invoiceNumber // ignore: cast_nullable_to_non_nullable
              as String,
      workflow: null == workflow
          ? _self.workflow
          : workflow // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      financialSummary: null == financialSummary
          ? _self.financialSummary
          : financialSummary // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      lineItems: freezed == lineItems
          ? _self.lineItems
          : lineItems // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
    ));
  }
}

/// Adds pattern-matching-related methods to [ClientInvoice].
extension ClientInvoicePatterns on ClientInvoice {
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
    TResult Function(_ClientInvoice value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ClientInvoice() when $default != null:
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
    TResult Function(_ClientInvoice value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ClientInvoice():
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
    TResult? Function(_ClientInvoice value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ClientInvoice() when $default != null:
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
            String invoiceNumber,
            Map<String, dynamic> workflow,
            Map<String, dynamic> financialSummary,
            List<dynamic>? lineItems)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ClientInvoice() when $default != null:
        return $default(_that.id, _that.invoiceNumber, _that.workflow,
            _that.financialSummary, _that.lineItems);
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
            String invoiceNumber,
            Map<String, dynamic> workflow,
            Map<String, dynamic> financialSummary,
            List<dynamic>? lineItems)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ClientInvoice():
        return $default(_that.id, _that.invoiceNumber, _that.workflow,
            _that.financialSummary, _that.lineItems);
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
            String invoiceNumber,
            Map<String, dynamic> workflow,
            Map<String, dynamic> financialSummary,
            List<dynamic>? lineItems)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ClientInvoice() when $default != null:
        return $default(_that.id, _that.invoiceNumber, _that.workflow,
            _that.financialSummary, _that.lineItems);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ClientInvoice implements ClientInvoice {
  const _ClientInvoice(
      {required this.id,
      required this.invoiceNumber,
      required final Map<String, dynamic> workflow,
      required final Map<String, dynamic> financialSummary,
      final List<dynamic>? lineItems})
      : _workflow = workflow,
        _financialSummary = financialSummary,
        _lineItems = lineItems;
  factory _ClientInvoice.fromJson(Map<String, dynamic> json) =>
      _$ClientInvoiceFromJson(json);

  @override
  final String id;
  @override
  final String invoiceNumber;
  final Map<String, dynamic> _workflow;
  @override
  Map<String, dynamic> get workflow {
    if (_workflow is EqualUnmodifiableMapView) return _workflow;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_workflow);
  }

  final Map<String, dynamic> _financialSummary;
  @override
  Map<String, dynamic> get financialSummary {
    if (_financialSummary is EqualUnmodifiableMapView) return _financialSummary;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_financialSummary);
  }

  final List<dynamic>? _lineItems;
  @override
  List<dynamic>? get lineItems {
    final value = _lineItems;
    if (value == null) return null;
    if (_lineItems is EqualUnmodifiableListView) return _lineItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// Create a copy of ClientInvoice
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ClientInvoiceCopyWith<_ClientInvoice> get copyWith =>
      __$ClientInvoiceCopyWithImpl<_ClientInvoice>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ClientInvoiceToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ClientInvoice &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.invoiceNumber, invoiceNumber) ||
                other.invoiceNumber == invoiceNumber) &&
            const DeepCollectionEquality().equals(other._workflow, _workflow) &&
            const DeepCollectionEquality()
                .equals(other._financialSummary, _financialSummary) &&
            const DeepCollectionEquality()
                .equals(other._lineItems, _lineItems));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      invoiceNumber,
      const DeepCollectionEquality().hash(_workflow),
      const DeepCollectionEquality().hash(_financialSummary),
      const DeepCollectionEquality().hash(_lineItems));

  @override
  String toString() {
    return 'ClientInvoice(id: $id, invoiceNumber: $invoiceNumber, workflow: $workflow, financialSummary: $financialSummary, lineItems: $lineItems)';
  }
}

/// @nodoc
abstract mixin class _$ClientInvoiceCopyWith<$Res>
    implements $ClientInvoiceCopyWith<$Res> {
  factory _$ClientInvoiceCopyWith(
          _ClientInvoice value, $Res Function(_ClientInvoice) _then) =
      __$ClientInvoiceCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String invoiceNumber,
      Map<String, dynamic> workflow,
      Map<String, dynamic> financialSummary,
      List<dynamic>? lineItems});
}

/// @nodoc
class __$ClientInvoiceCopyWithImpl<$Res>
    implements _$ClientInvoiceCopyWith<$Res> {
  __$ClientInvoiceCopyWithImpl(this._self, this._then);

  final _ClientInvoice _self;
  final $Res Function(_ClientInvoice) _then;

  /// Create a copy of ClientInvoice
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? invoiceNumber = null,
    Object? workflow = null,
    Object? financialSummary = null,
    Object? lineItems = freezed,
  }) {
    return _then(_ClientInvoice(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      invoiceNumber: null == invoiceNumber
          ? _self.invoiceNumber
          : invoiceNumber // ignore: cast_nullable_to_non_nullable
              as String,
      workflow: null == workflow
          ? _self._workflow
          : workflow // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      financialSummary: null == financialSummary
          ? _self._financialSummary
          : financialSummary // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      lineItems: freezed == lineItems
          ? _self._lineItems
          : lineItems // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
    ));
  }
}

/// @nodoc
mixin _$AppointmentParams {
  String get assignmentId;
  String get scheduleId;

  /// Create a copy of AppointmentParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AppointmentParamsCopyWith<AppointmentParams> get copyWith =>
      _$AppointmentParamsCopyWithImpl<AppointmentParams>(
          this as AppointmentParams, _$identity);

  /// Serializes this AppointmentParams to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AppointmentParams &&
            (identical(other.assignmentId, assignmentId) ||
                other.assignmentId == assignmentId) &&
            (identical(other.scheduleId, scheduleId) ||
                other.scheduleId == scheduleId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, assignmentId, scheduleId);

  @override
  String toString() {
    return 'AppointmentParams(assignmentId: $assignmentId, scheduleId: $scheduleId)';
  }
}

/// @nodoc
abstract mixin class $AppointmentParamsCopyWith<$Res> {
  factory $AppointmentParamsCopyWith(
          AppointmentParams value, $Res Function(AppointmentParams) _then) =
      _$AppointmentParamsCopyWithImpl;
  @useResult
  $Res call({String assignmentId, String scheduleId});
}

/// @nodoc
class _$AppointmentParamsCopyWithImpl<$Res>
    implements $AppointmentParamsCopyWith<$Res> {
  _$AppointmentParamsCopyWithImpl(this._self, this._then);

  final AppointmentParams _self;
  final $Res Function(AppointmentParams) _then;

  /// Create a copy of AppointmentParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? assignmentId = null,
    Object? scheduleId = null,
  }) {
    return _then(_self.copyWith(
      assignmentId: null == assignmentId
          ? _self.assignmentId
          : assignmentId // ignore: cast_nullable_to_non_nullable
              as String,
      scheduleId: null == scheduleId
          ? _self.scheduleId
          : scheduleId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [AppointmentParams].
extension AppointmentParamsPatterns on AppointmentParams {
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
    TResult Function(_AppointmentParams value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AppointmentParams() when $default != null:
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
    TResult Function(_AppointmentParams value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AppointmentParams():
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
    TResult? Function(_AppointmentParams value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AppointmentParams() when $default != null:
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
    TResult Function(String assignmentId, String scheduleId)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AppointmentParams() when $default != null:
        return $default(_that.assignmentId, _that.scheduleId);
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
    TResult Function(String assignmentId, String scheduleId) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AppointmentParams():
        return $default(_that.assignmentId, _that.scheduleId);
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
    TResult? Function(String assignmentId, String scheduleId)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AppointmentParams() when $default != null:
        return $default(_that.assignmentId, _that.scheduleId);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _AppointmentParams implements AppointmentParams {
  const _AppointmentParams(
      {required this.assignmentId, required this.scheduleId});
  factory _AppointmentParams.fromJson(Map<String, dynamic> json) =>
      _$AppointmentParamsFromJson(json);

  @override
  final String assignmentId;
  @override
  final String scheduleId;

  /// Create a copy of AppointmentParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AppointmentParamsCopyWith<_AppointmentParams> get copyWith =>
      __$AppointmentParamsCopyWithImpl<_AppointmentParams>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AppointmentParamsToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AppointmentParams &&
            (identical(other.assignmentId, assignmentId) ||
                other.assignmentId == assignmentId) &&
            (identical(other.scheduleId, scheduleId) ||
                other.scheduleId == scheduleId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, assignmentId, scheduleId);

  @override
  String toString() {
    return 'AppointmentParams(assignmentId: $assignmentId, scheduleId: $scheduleId)';
  }
}

/// @nodoc
abstract mixin class _$AppointmentParamsCopyWith<$Res>
    implements $AppointmentParamsCopyWith<$Res> {
  factory _$AppointmentParamsCopyWith(
          _AppointmentParams value, $Res Function(_AppointmentParams) _then) =
      __$AppointmentParamsCopyWithImpl;
  @override
  @useResult
  $Res call({String assignmentId, String scheduleId});
}

/// @nodoc
class __$AppointmentParamsCopyWithImpl<$Res>
    implements _$AppointmentParamsCopyWith<$Res> {
  __$AppointmentParamsCopyWithImpl(this._self, this._then);

  final _AppointmentParams _self;
  final $Res Function(_AppointmentParams) _then;

  /// Create a copy of AppointmentParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? assignmentId = null,
    Object? scheduleId = null,
  }) {
    return _then(_AppointmentParams(
      assignmentId: null == assignmentId
          ? _self.assignmentId
          : assignmentId // ignore: cast_nullable_to_non_nullable
              as String,
      scheduleId: null == scheduleId
          ? _self.scheduleId
          : scheduleId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
