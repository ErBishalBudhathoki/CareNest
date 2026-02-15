// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'client_portal_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ClientDashboard _$ClientDashboardFromJson(Map<String, dynamic> json) {
  return _ClientDashboard.fromJson(json);
}

/// @nodoc
mixin _$ClientDashboard {
  String get clientId => throw _privateConstructorUsedError;
  String get clientName => throw _privateConstructorUsedError;
  List<TodayAppointment> get todayAppointments =>
      throw _privateConstructorUsedError;
  List<UpcomingAppointment> get upcomingAppointments =>
      throw _privateConstructorUsedError;
  List<RecentActivity> get recentActivity => throw _privateConstructorUsedError;
  List<ClientNotification> get notifications =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ClientDashboardCopyWith<ClientDashboard> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClientDashboardCopyWith<$Res> {
  factory $ClientDashboardCopyWith(
          ClientDashboard value, $Res Function(ClientDashboard) then) =
      _$ClientDashboardCopyWithImpl<$Res, ClientDashboard>;
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
class _$ClientDashboardCopyWithImpl<$Res, $Val extends ClientDashboard>
    implements $ClientDashboardCopyWith<$Res> {
  _$ClientDashboardCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      clientId: null == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      clientName: null == clientName
          ? _value.clientName
          : clientName // ignore: cast_nullable_to_non_nullable
              as String,
      todayAppointments: null == todayAppointments
          ? _value.todayAppointments
          : todayAppointments // ignore: cast_nullable_to_non_nullable
              as List<TodayAppointment>,
      upcomingAppointments: null == upcomingAppointments
          ? _value.upcomingAppointments
          : upcomingAppointments // ignore: cast_nullable_to_non_nullable
              as List<UpcomingAppointment>,
      recentActivity: null == recentActivity
          ? _value.recentActivity
          : recentActivity // ignore: cast_nullable_to_non_nullable
              as List<RecentActivity>,
      notifications: null == notifications
          ? _value.notifications
          : notifications // ignore: cast_nullable_to_non_nullable
              as List<ClientNotification>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ClientDashboardImplCopyWith<$Res>
    implements $ClientDashboardCopyWith<$Res> {
  factory _$$ClientDashboardImplCopyWith(_$ClientDashboardImpl value,
          $Res Function(_$ClientDashboardImpl) then) =
      __$$ClientDashboardImplCopyWithImpl<$Res>;
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
class __$$ClientDashboardImplCopyWithImpl<$Res>
    extends _$ClientDashboardCopyWithImpl<$Res, _$ClientDashboardImpl>
    implements _$$ClientDashboardImplCopyWith<$Res> {
  __$$ClientDashboardImplCopyWithImpl(
      _$ClientDashboardImpl _value, $Res Function(_$ClientDashboardImpl) _then)
      : super(_value, _then);

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
    return _then(_$ClientDashboardImpl(
      clientId: null == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      clientName: null == clientName
          ? _value.clientName
          : clientName // ignore: cast_nullable_to_non_nullable
              as String,
      todayAppointments: null == todayAppointments
          ? _value._todayAppointments
          : todayAppointments // ignore: cast_nullable_to_non_nullable
              as List<TodayAppointment>,
      upcomingAppointments: null == upcomingAppointments
          ? _value._upcomingAppointments
          : upcomingAppointments // ignore: cast_nullable_to_non_nullable
              as List<UpcomingAppointment>,
      recentActivity: null == recentActivity
          ? _value._recentActivity
          : recentActivity // ignore: cast_nullable_to_non_nullable
              as List<RecentActivity>,
      notifications: null == notifications
          ? _value._notifications
          : notifications // ignore: cast_nullable_to_non_nullable
              as List<ClientNotification>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ClientDashboardImpl implements _ClientDashboard {
  const _$ClientDashboardImpl(
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

  factory _$ClientDashboardImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClientDashboardImplFromJson(json);

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

  @override
  String toString() {
    return 'ClientDashboard(clientId: $clientId, clientName: $clientName, todayAppointments: $todayAppointments, upcomingAppointments: $upcomingAppointments, recentActivity: $recentActivity, notifications: $notifications)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClientDashboardImpl &&
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

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      clientId,
      clientName,
      const DeepCollectionEquality().hash(_todayAppointments),
      const DeepCollectionEquality().hash(_upcomingAppointments),
      const DeepCollectionEquality().hash(_recentActivity),
      const DeepCollectionEquality().hash(_notifications));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ClientDashboardImplCopyWith<_$ClientDashboardImpl> get copyWith =>
      __$$ClientDashboardImplCopyWithImpl<_$ClientDashboardImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClientDashboardImplToJson(
      this,
    );
  }
}

abstract class _ClientDashboard implements ClientDashboard {
  const factory _ClientDashboard(
          {required final String clientId,
          required final String clientName,
          required final List<TodayAppointment> todayAppointments,
          required final List<UpcomingAppointment> upcomingAppointments,
          required final List<RecentActivity> recentActivity,
          required final List<ClientNotification> notifications}) =
      _$ClientDashboardImpl;

  factory _ClientDashboard.fromJson(Map<String, dynamic> json) =
      _$ClientDashboardImpl.fromJson;

  @override
  String get clientId;
  @override
  String get clientName;
  @override
  List<TodayAppointment> get todayAppointments;
  @override
  List<UpcomingAppointment> get upcomingAppointments;
  @override
  List<RecentActivity> get recentActivity;
  @override
  List<ClientNotification> get notifications;
  @override
  @JsonKey(ignore: true)
  _$$ClientDashboardImplCopyWith<_$ClientDashboardImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TodayAppointment _$TodayAppointmentFromJson(Map<String, dynamic> json) {
  return _TodayAppointment.fromJson(json);
}

/// @nodoc
mixin _$TodayAppointment {
  String get appointmentId => throw _privateConstructorUsedError;
  String get workerName => throw _privateConstructorUsedError;
  String get serviceName => throw _privateConstructorUsedError;
  String get startTime => throw _privateConstructorUsedError;
  String get endTime => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String? get eta => throw _privateConstructorUsedError;
  String? get workerPhoto => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TodayAppointmentCopyWith<TodayAppointment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TodayAppointmentCopyWith<$Res> {
  factory $TodayAppointmentCopyWith(
          TodayAppointment value, $Res Function(TodayAppointment) then) =
      _$TodayAppointmentCopyWithImpl<$Res, TodayAppointment>;
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
class _$TodayAppointmentCopyWithImpl<$Res, $Val extends TodayAppointment>
    implements $TodayAppointmentCopyWith<$Res> {
  _$TodayAppointmentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      appointmentId: null == appointmentId
          ? _value.appointmentId
          : appointmentId // ignore: cast_nullable_to_non_nullable
              as String,
      workerName: null == workerName
          ? _value.workerName
          : workerName // ignore: cast_nullable_to_non_nullable
              as String,
      serviceName: null == serviceName
          ? _value.serviceName
          : serviceName // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as String,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      eta: freezed == eta
          ? _value.eta
          : eta // ignore: cast_nullable_to_non_nullable
              as String?,
      workerPhoto: freezed == workerPhoto
          ? _value.workerPhoto
          : workerPhoto // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TodayAppointmentImplCopyWith<$Res>
    implements $TodayAppointmentCopyWith<$Res> {
  factory _$$TodayAppointmentImplCopyWith(_$TodayAppointmentImpl value,
          $Res Function(_$TodayAppointmentImpl) then) =
      __$$TodayAppointmentImplCopyWithImpl<$Res>;
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
class __$$TodayAppointmentImplCopyWithImpl<$Res>
    extends _$TodayAppointmentCopyWithImpl<$Res, _$TodayAppointmentImpl>
    implements _$$TodayAppointmentImplCopyWith<$Res> {
  __$$TodayAppointmentImplCopyWithImpl(_$TodayAppointmentImpl _value,
      $Res Function(_$TodayAppointmentImpl) _then)
      : super(_value, _then);

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
    return _then(_$TodayAppointmentImpl(
      appointmentId: null == appointmentId
          ? _value.appointmentId
          : appointmentId // ignore: cast_nullable_to_non_nullable
              as String,
      workerName: null == workerName
          ? _value.workerName
          : workerName // ignore: cast_nullable_to_non_nullable
              as String,
      serviceName: null == serviceName
          ? _value.serviceName
          : serviceName // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as String,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      eta: freezed == eta
          ? _value.eta
          : eta // ignore: cast_nullable_to_non_nullable
              as String?,
      workerPhoto: freezed == workerPhoto
          ? _value.workerPhoto
          : workerPhoto // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TodayAppointmentImpl implements _TodayAppointment {
  const _$TodayAppointmentImpl(
      {required this.appointmentId,
      required this.workerName,
      required this.serviceName,
      required this.startTime,
      required this.endTime,
      required this.status,
      this.eta,
      this.workerPhoto});

  factory _$TodayAppointmentImpl.fromJson(Map<String, dynamic> json) =>
      _$$TodayAppointmentImplFromJson(json);

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

  @override
  String toString() {
    return 'TodayAppointment(appointmentId: $appointmentId, workerName: $workerName, serviceName: $serviceName, startTime: $startTime, endTime: $endTime, status: $status, eta: $eta, workerPhoto: $workerPhoto)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TodayAppointmentImpl &&
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

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, appointmentId, workerName,
      serviceName, startTime, endTime, status, eta, workerPhoto);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TodayAppointmentImplCopyWith<_$TodayAppointmentImpl> get copyWith =>
      __$$TodayAppointmentImplCopyWithImpl<_$TodayAppointmentImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TodayAppointmentImplToJson(
      this,
    );
  }
}

abstract class _TodayAppointment implements TodayAppointment {
  const factory _TodayAppointment(
      {required final String appointmentId,
      required final String workerName,
      required final String serviceName,
      required final String startTime,
      required final String endTime,
      required final String status,
      final String? eta,
      final String? workerPhoto}) = _$TodayAppointmentImpl;

  factory _TodayAppointment.fromJson(Map<String, dynamic> json) =
      _$TodayAppointmentImpl.fromJson;

  @override
  String get appointmentId;
  @override
  String get workerName;
  @override
  String get serviceName;
  @override
  String get startTime;
  @override
  String get endTime;
  @override
  String get status;
  @override
  String? get eta;
  @override
  String? get workerPhoto;
  @override
  @JsonKey(ignore: true)
  _$$TodayAppointmentImplCopyWith<_$TodayAppointmentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UpcomingAppointment _$UpcomingAppointmentFromJson(Map<String, dynamic> json) {
  return _UpcomingAppointment.fromJson(json);
}

/// @nodoc
mixin _$UpcomingAppointment {
  String get appointmentId => throw _privateConstructorUsedError;
  String get workerName => throw _privateConstructorUsedError;
  String get serviceName => throw _privateConstructorUsedError;
  String get date => throw _privateConstructorUsedError;
  String get startTime => throw _privateConstructorUsedError;
  String get endTime => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UpcomingAppointmentCopyWith<UpcomingAppointment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpcomingAppointmentCopyWith<$Res> {
  factory $UpcomingAppointmentCopyWith(
          UpcomingAppointment value, $Res Function(UpcomingAppointment) then) =
      _$UpcomingAppointmentCopyWithImpl<$Res, UpcomingAppointment>;
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
class _$UpcomingAppointmentCopyWithImpl<$Res, $Val extends UpcomingAppointment>
    implements $UpcomingAppointmentCopyWith<$Res> {
  _$UpcomingAppointmentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      appointmentId: null == appointmentId
          ? _value.appointmentId
          : appointmentId // ignore: cast_nullable_to_non_nullable
              as String,
      workerName: null == workerName
          ? _value.workerName
          : workerName // ignore: cast_nullable_to_non_nullable
              as String,
      serviceName: null == serviceName
          ? _value.serviceName
          : serviceName // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as String,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UpcomingAppointmentImplCopyWith<$Res>
    implements $UpcomingAppointmentCopyWith<$Res> {
  factory _$$UpcomingAppointmentImplCopyWith(_$UpcomingAppointmentImpl value,
          $Res Function(_$UpcomingAppointmentImpl) then) =
      __$$UpcomingAppointmentImplCopyWithImpl<$Res>;
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
class __$$UpcomingAppointmentImplCopyWithImpl<$Res>
    extends _$UpcomingAppointmentCopyWithImpl<$Res, _$UpcomingAppointmentImpl>
    implements _$$UpcomingAppointmentImplCopyWith<$Res> {
  __$$UpcomingAppointmentImplCopyWithImpl(_$UpcomingAppointmentImpl _value,
      $Res Function(_$UpcomingAppointmentImpl) _then)
      : super(_value, _then);

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
    return _then(_$UpcomingAppointmentImpl(
      appointmentId: null == appointmentId
          ? _value.appointmentId
          : appointmentId // ignore: cast_nullable_to_non_nullable
              as String,
      workerName: null == workerName
          ? _value.workerName
          : workerName // ignore: cast_nullable_to_non_nullable
              as String,
      serviceName: null == serviceName
          ? _value.serviceName
          : serviceName // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as String,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UpcomingAppointmentImpl implements _UpcomingAppointment {
  const _$UpcomingAppointmentImpl(
      {required this.appointmentId,
      required this.workerName,
      required this.serviceName,
      required this.date,
      required this.startTime,
      required this.endTime,
      required this.status});

  factory _$UpcomingAppointmentImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpcomingAppointmentImplFromJson(json);

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

  @override
  String toString() {
    return 'UpcomingAppointment(appointmentId: $appointmentId, workerName: $workerName, serviceName: $serviceName, date: $date, startTime: $startTime, endTime: $endTime, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpcomingAppointmentImpl &&
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

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, appointmentId, workerName,
      serviceName, date, startTime, endTime, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UpcomingAppointmentImplCopyWith<_$UpcomingAppointmentImpl> get copyWith =>
      __$$UpcomingAppointmentImplCopyWithImpl<_$UpcomingAppointmentImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UpcomingAppointmentImplToJson(
      this,
    );
  }
}

abstract class _UpcomingAppointment implements UpcomingAppointment {
  const factory _UpcomingAppointment(
      {required final String appointmentId,
      required final String workerName,
      required final String serviceName,
      required final String date,
      required final String startTime,
      required final String endTime,
      required final String status}) = _$UpcomingAppointmentImpl;

  factory _UpcomingAppointment.fromJson(Map<String, dynamic> json) =
      _$UpcomingAppointmentImpl.fromJson;

  @override
  String get appointmentId;
  @override
  String get workerName;
  @override
  String get serviceName;
  @override
  String get date;
  @override
  String get startTime;
  @override
  String get endTime;
  @override
  String get status;
  @override
  @JsonKey(ignore: true)
  _$$UpcomingAppointmentImplCopyWith<_$UpcomingAppointmentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RecentActivity _$RecentActivityFromJson(Map<String, dynamic> json) {
  return _RecentActivity.fromJson(json);
}

/// @nodoc
mixin _$RecentActivity {
  String get type => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  String get timestamp => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RecentActivityCopyWith<RecentActivity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecentActivityCopyWith<$Res> {
  factory $RecentActivityCopyWith(
          RecentActivity value, $Res Function(RecentActivity) then) =
      _$RecentActivityCopyWithImpl<$Res, RecentActivity>;
  @useResult
  $Res call({String type, String message, String timestamp});
}

/// @nodoc
class _$RecentActivityCopyWithImpl<$Res, $Val extends RecentActivity>
    implements $RecentActivityCopyWith<$Res> {
  _$RecentActivityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? message = null,
    Object? timestamp = null,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RecentActivityImplCopyWith<$Res>
    implements $RecentActivityCopyWith<$Res> {
  factory _$$RecentActivityImplCopyWith(_$RecentActivityImpl value,
          $Res Function(_$RecentActivityImpl) then) =
      __$$RecentActivityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String type, String message, String timestamp});
}

/// @nodoc
class __$$RecentActivityImplCopyWithImpl<$Res>
    extends _$RecentActivityCopyWithImpl<$Res, _$RecentActivityImpl>
    implements _$$RecentActivityImplCopyWith<$Res> {
  __$$RecentActivityImplCopyWithImpl(
      _$RecentActivityImpl _value, $Res Function(_$RecentActivityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? message = null,
    Object? timestamp = null,
  }) {
    return _then(_$RecentActivityImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RecentActivityImpl implements _RecentActivity {
  const _$RecentActivityImpl(
      {required this.type, required this.message, required this.timestamp});

  factory _$RecentActivityImpl.fromJson(Map<String, dynamic> json) =>
      _$$RecentActivityImplFromJson(json);

  @override
  final String type;
  @override
  final String message;
  @override
  final String timestamp;

  @override
  String toString() {
    return 'RecentActivity(type: $type, message: $message, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecentActivityImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, type, message, timestamp);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RecentActivityImplCopyWith<_$RecentActivityImpl> get copyWith =>
      __$$RecentActivityImplCopyWithImpl<_$RecentActivityImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RecentActivityImplToJson(
      this,
    );
  }
}

abstract class _RecentActivity implements RecentActivity {
  const factory _RecentActivity(
      {required final String type,
      required final String message,
      required final String timestamp}) = _$RecentActivityImpl;

  factory _RecentActivity.fromJson(Map<String, dynamic> json) =
      _$RecentActivityImpl.fromJson;

  @override
  String get type;
  @override
  String get message;
  @override
  String get timestamp;
  @override
  @JsonKey(ignore: true)
  _$$RecentActivityImplCopyWith<_$RecentActivityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ClientNotification _$ClientNotificationFromJson(Map<String, dynamic> json) {
  return _ClientNotification.fromJson(json);
}

/// @nodoc
mixin _$ClientNotification {
  String get id => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  String get timestamp => throw _privateConstructorUsedError;
  bool get read => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ClientNotificationCopyWith<ClientNotification> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClientNotificationCopyWith<$Res> {
  factory $ClientNotificationCopyWith(
          ClientNotification value, $Res Function(ClientNotification) then) =
      _$ClientNotificationCopyWithImpl<$Res, ClientNotification>;
  @useResult
  $Res call(
      {String id, String type, String message, String timestamp, bool read});
}

/// @nodoc
class _$ClientNotificationCopyWithImpl<$Res, $Val extends ClientNotification>
    implements $ClientNotificationCopyWith<$Res> {
  _$ClientNotificationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? message = null,
    Object? timestamp = null,
    Object? read = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as String,
      read: null == read
          ? _value.read
          : read // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ClientNotificationImplCopyWith<$Res>
    implements $ClientNotificationCopyWith<$Res> {
  factory _$$ClientNotificationImplCopyWith(_$ClientNotificationImpl value,
          $Res Function(_$ClientNotificationImpl) then) =
      __$$ClientNotificationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id, String type, String message, String timestamp, bool read});
}

/// @nodoc
class __$$ClientNotificationImplCopyWithImpl<$Res>
    extends _$ClientNotificationCopyWithImpl<$Res, _$ClientNotificationImpl>
    implements _$$ClientNotificationImplCopyWith<$Res> {
  __$$ClientNotificationImplCopyWithImpl(_$ClientNotificationImpl _value,
      $Res Function(_$ClientNotificationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? message = null,
    Object? timestamp = null,
    Object? read = null,
  }) {
    return _then(_$ClientNotificationImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as String,
      read: null == read
          ? _value.read
          : read // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ClientNotificationImpl implements _ClientNotification {
  const _$ClientNotificationImpl(
      {required this.id,
      required this.type,
      required this.message,
      required this.timestamp,
      required this.read});

  factory _$ClientNotificationImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClientNotificationImplFromJson(json);

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

  @override
  String toString() {
    return 'ClientNotification(id: $id, type: $type, message: $message, timestamp: $timestamp, read: $read)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClientNotificationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.read, read) || other.read == read));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, type, message, timestamp, read);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ClientNotificationImplCopyWith<_$ClientNotificationImpl> get copyWith =>
      __$$ClientNotificationImplCopyWithImpl<_$ClientNotificationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClientNotificationImplToJson(
      this,
    );
  }
}

abstract class _ClientNotification implements ClientNotification {
  const factory _ClientNotification(
      {required final String id,
      required final String type,
      required final String message,
      required final String timestamp,
      required final bool read}) = _$ClientNotificationImpl;

  factory _ClientNotification.fromJson(Map<String, dynamic> json) =
      _$ClientNotificationImpl.fromJson;

  @override
  String get id;
  @override
  String get type;
  @override
  String get message;
  @override
  String get timestamp;
  @override
  bool get read;
  @override
  @JsonKey(ignore: true)
  _$$ClientNotificationImplCopyWith<_$ClientNotificationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WorkerLocation _$WorkerLocationFromJson(Map<String, dynamic> json) {
  return _WorkerLocation.fromJson(json);
}

/// @nodoc
mixin _$WorkerLocation {
  String get appointmentId => throw _privateConstructorUsedError;
  String get workerName => throw _privateConstructorUsedError;
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;
  double get accuracy => throw _privateConstructorUsedError;
  String get timestamp => throw _privateConstructorUsedError;
  bool get isEnRoute => throw _privateConstructorUsedError;
  String? get eta => throw _privateConstructorUsedError;
  double? get distanceRemaining => throw _privateConstructorUsedError;
  String? get lastUpdated => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WorkerLocationCopyWith<WorkerLocation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkerLocationCopyWith<$Res> {
  factory $WorkerLocationCopyWith(
          WorkerLocation value, $Res Function(WorkerLocation) then) =
      _$WorkerLocationCopyWithImpl<$Res, WorkerLocation>;
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
class _$WorkerLocationCopyWithImpl<$Res, $Val extends WorkerLocation>
    implements $WorkerLocationCopyWith<$Res> {
  _$WorkerLocationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      appointmentId: null == appointmentId
          ? _value.appointmentId
          : appointmentId // ignore: cast_nullable_to_non_nullable
              as String,
      workerName: null == workerName
          ? _value.workerName
          : workerName // ignore: cast_nullable_to_non_nullable
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
              as String,
      isEnRoute: null == isEnRoute
          ? _value.isEnRoute
          : isEnRoute // ignore: cast_nullable_to_non_nullable
              as bool,
      eta: freezed == eta
          ? _value.eta
          : eta // ignore: cast_nullable_to_non_nullable
              as String?,
      distanceRemaining: freezed == distanceRemaining
          ? _value.distanceRemaining
          : distanceRemaining // ignore: cast_nullable_to_non_nullable
              as double?,
      lastUpdated: freezed == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WorkerLocationImplCopyWith<$Res>
    implements $WorkerLocationCopyWith<$Res> {
  factory _$$WorkerLocationImplCopyWith(_$WorkerLocationImpl value,
          $Res Function(_$WorkerLocationImpl) then) =
      __$$WorkerLocationImplCopyWithImpl<$Res>;
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
class __$$WorkerLocationImplCopyWithImpl<$Res>
    extends _$WorkerLocationCopyWithImpl<$Res, _$WorkerLocationImpl>
    implements _$$WorkerLocationImplCopyWith<$Res> {
  __$$WorkerLocationImplCopyWithImpl(
      _$WorkerLocationImpl _value, $Res Function(_$WorkerLocationImpl) _then)
      : super(_value, _then);

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
    return _then(_$WorkerLocationImpl(
      appointmentId: null == appointmentId
          ? _value.appointmentId
          : appointmentId // ignore: cast_nullable_to_non_nullable
              as String,
      workerName: null == workerName
          ? _value.workerName
          : workerName // ignore: cast_nullable_to_non_nullable
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
              as String,
      isEnRoute: null == isEnRoute
          ? _value.isEnRoute
          : isEnRoute // ignore: cast_nullable_to_non_nullable
              as bool,
      eta: freezed == eta
          ? _value.eta
          : eta // ignore: cast_nullable_to_non_nullable
              as String?,
      distanceRemaining: freezed == distanceRemaining
          ? _value.distanceRemaining
          : distanceRemaining // ignore: cast_nullable_to_non_nullable
              as double?,
      lastUpdated: freezed == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WorkerLocationImpl implements _WorkerLocation {
  const _$WorkerLocationImpl(
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

  factory _$WorkerLocationImpl.fromJson(Map<String, dynamic> json) =>
      _$$WorkerLocationImplFromJson(json);

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

  @override
  String toString() {
    return 'WorkerLocation(appointmentId: $appointmentId, workerName: $workerName, latitude: $latitude, longitude: $longitude, accuracy: $accuracy, timestamp: $timestamp, isEnRoute: $isEnRoute, eta: $eta, distanceRemaining: $distanceRemaining, lastUpdated: $lastUpdated)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkerLocationImpl &&
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

  @JsonKey(ignore: true)
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

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkerLocationImplCopyWith<_$WorkerLocationImpl> get copyWith =>
      __$$WorkerLocationImplCopyWithImpl<_$WorkerLocationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WorkerLocationImplToJson(
      this,
    );
  }
}

abstract class _WorkerLocation implements WorkerLocation {
  const factory _WorkerLocation(
      {required final String appointmentId,
      required final String workerName,
      required final double latitude,
      required final double longitude,
      required final double accuracy,
      required final String timestamp,
      required final bool isEnRoute,
      final String? eta,
      final double? distanceRemaining,
      final String? lastUpdated}) = _$WorkerLocationImpl;

  factory _WorkerLocation.fromJson(Map<String, dynamic> json) =
      _$WorkerLocationImpl.fromJson;

  @override
  String get appointmentId;
  @override
  String get workerName;
  @override
  double get latitude;
  @override
  double get longitude;
  @override
  double get accuracy;
  @override
  String get timestamp;
  @override
  bool get isEnRoute;
  @override
  String? get eta;
  @override
  double? get distanceRemaining;
  @override
  String? get lastUpdated;
  @override
  @JsonKey(ignore: true)
  _$$WorkerLocationImplCopyWith<_$WorkerLocationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AppointmentStatus _$AppointmentStatusFromJson(Map<String, dynamic> json) {
  return _AppointmentStatus.fromJson(json);
}

/// @nodoc
mixin _$AppointmentStatus {
  String get appointmentId => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String get workerName => throw _privateConstructorUsedError;
  String get serviceName => throw _privateConstructorUsedError;
  String get startTime => throw _privateConstructorUsedError;
  String get endTime => throw _privateConstructorUsedError;
  String? get actualStartTime => throw _privateConstructorUsedError;
  String? get actualEndTime => throw _privateConstructorUsedError;
  String? get eta => throw _privateConstructorUsedError;
  List<String> get notes => throw _privateConstructorUsedError;
  List<String> get photos => throw _privateConstructorUsedError;
  List<ChecklistItem> get checklistItems => throw _privateConstructorUsedError;
  String get lastUpdated => throw _privateConstructorUsedError;

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
    return _then(_value.copyWith(
      appointmentId: null == appointmentId
          ? _value.appointmentId
          : appointmentId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      workerName: null == workerName
          ? _value.workerName
          : workerName // ignore: cast_nullable_to_non_nullable
              as String,
      serviceName: null == serviceName
          ? _value.serviceName
          : serviceName // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as String,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as String,
      actualStartTime: freezed == actualStartTime
          ? _value.actualStartTime
          : actualStartTime // ignore: cast_nullable_to_non_nullable
              as String?,
      actualEndTime: freezed == actualEndTime
          ? _value.actualEndTime
          : actualEndTime // ignore: cast_nullable_to_non_nullable
              as String?,
      eta: freezed == eta
          ? _value.eta
          : eta // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: null == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      photos: null == photos
          ? _value.photos
          : photos // ignore: cast_nullable_to_non_nullable
              as List<String>,
      checklistItems: null == checklistItems
          ? _value.checklistItems
          : checklistItems // ignore: cast_nullable_to_non_nullable
              as List<ChecklistItem>,
      lastUpdated: null == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as String,
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
    return _then(_$AppointmentStatusImpl(
      appointmentId: null == appointmentId
          ? _value.appointmentId
          : appointmentId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      workerName: null == workerName
          ? _value.workerName
          : workerName // ignore: cast_nullable_to_non_nullable
              as String,
      serviceName: null == serviceName
          ? _value.serviceName
          : serviceName // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as String,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as String,
      actualStartTime: freezed == actualStartTime
          ? _value.actualStartTime
          : actualStartTime // ignore: cast_nullable_to_non_nullable
              as String?,
      actualEndTime: freezed == actualEndTime
          ? _value.actualEndTime
          : actualEndTime // ignore: cast_nullable_to_non_nullable
              as String?,
      eta: freezed == eta
          ? _value.eta
          : eta // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: null == notes
          ? _value._notes
          : notes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      photos: null == photos
          ? _value._photos
          : photos // ignore: cast_nullable_to_non_nullable
              as List<String>,
      checklistItems: null == checklistItems
          ? _value._checklistItems
          : checklistItems // ignore: cast_nullable_to_non_nullable
              as List<ChecklistItem>,
      lastUpdated: null == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppointmentStatusImpl implements _AppointmentStatus {
  const _$AppointmentStatusImpl(
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

  factory _$AppointmentStatusImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppointmentStatusImplFromJson(json);

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

  @override
  String toString() {
    return 'AppointmentStatus(appointmentId: $appointmentId, status: $status, workerName: $workerName, serviceName: $serviceName, startTime: $startTime, endTime: $endTime, actualStartTime: $actualStartTime, actualEndTime: $actualEndTime, eta: $eta, notes: $notes, photos: $photos, checklistItems: $checklistItems, lastUpdated: $lastUpdated)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppointmentStatusImpl &&
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

  @JsonKey(ignore: true)
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
      required final String workerName,
      required final String serviceName,
      required final String startTime,
      required final String endTime,
      final String? actualStartTime,
      final String? actualEndTime,
      final String? eta,
      required final List<String> notes,
      required final List<String> photos,
      required final List<ChecklistItem> checklistItems,
      required final String lastUpdated}) = _$AppointmentStatusImpl;

  factory _AppointmentStatus.fromJson(Map<String, dynamic> json) =
      _$AppointmentStatusImpl.fromJson;

  @override
  String get appointmentId;
  @override
  String get status;
  @override
  String get workerName;
  @override
  String get serviceName;
  @override
  String get startTime;
  @override
  String get endTime;
  @override
  String? get actualStartTime;
  @override
  String? get actualEndTime;
  @override
  String? get eta;
  @override
  List<String> get notes;
  @override
  List<String> get photos;
  @override
  List<ChecklistItem> get checklistItems;
  @override
  String get lastUpdated;
  @override
  @JsonKey(ignore: true)
  _$$AppointmentStatusImplCopyWith<_$AppointmentStatusImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ChecklistItem _$ChecklistItemFromJson(Map<String, dynamic> json) {
  return _ChecklistItem.fromJson(json);
}

/// @nodoc
mixin _$ChecklistItem {
  String get item => throw _privateConstructorUsedError;
  bool get completed => throw _privateConstructorUsedError;

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
  $Res call({String item, bool completed});
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
    Object? item = null,
    Object? completed = null,
  }) {
    return _then(_value.copyWith(
      item: null == item
          ? _value.item
          : item // ignore: cast_nullable_to_non_nullable
              as String,
      completed: null == completed
          ? _value.completed
          : completed // ignore: cast_nullable_to_non_nullable
              as bool,
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
  $Res call({String item, bool completed});
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
    Object? item = null,
    Object? completed = null,
  }) {
    return _then(_$ChecklistItemImpl(
      item: null == item
          ? _value.item
          : item // ignore: cast_nullable_to_non_nullable
              as String,
      completed: null == completed
          ? _value.completed
          : completed // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChecklistItemImpl implements _ChecklistItem {
  const _$ChecklistItemImpl({required this.item, required this.completed});

  factory _$ChecklistItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChecklistItemImplFromJson(json);

  @override
  final String item;
  @override
  final bool completed;

  @override
  String toString() {
    return 'ChecklistItem(item: $item, completed: $completed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChecklistItemImpl &&
            (identical(other.item, item) || other.item == item) &&
            (identical(other.completed, completed) ||
                other.completed == completed));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, item, completed);

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
      {required final String item,
      required final bool completed}) = _$ChecklistItemImpl;

  factory _ChecklistItem.fromJson(Map<String, dynamic> json) =
      _$ChecklistItemImpl.fromJson;

  @override
  String get item;
  @override
  bool get completed;
  @override
  @JsonKey(ignore: true)
  _$$ChecklistItemImplCopyWith<_$ChecklistItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ServiceHistory _$ServiceHistoryFromJson(Map<String, dynamic> json) {
  return _ServiceHistory.fromJson(json);
}

/// @nodoc
mixin _$ServiceHistory {
  String get serviceId => throw _privateConstructorUsedError;
  String get workerName => throw _privateConstructorUsedError;
  String get serviceName => throw _privateConstructorUsedError;
  String get date => throw _privateConstructorUsedError;
  String get startTime => throw _privateConstructorUsedError;
  String get endTime => throw _privateConstructorUsedError;
  int get rating => throw _privateConstructorUsedError;
  String? get feedback => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ServiceHistoryCopyWith<ServiceHistory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ServiceHistoryCopyWith<$Res> {
  factory $ServiceHistoryCopyWith(
          ServiceHistory value, $Res Function(ServiceHistory) then) =
      _$ServiceHistoryCopyWithImpl<$Res, ServiceHistory>;
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
class _$ServiceHistoryCopyWithImpl<$Res, $Val extends ServiceHistory>
    implements $ServiceHistoryCopyWith<$Res> {
  _$ServiceHistoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      serviceId: null == serviceId
          ? _value.serviceId
          : serviceId // ignore: cast_nullable_to_non_nullable
              as String,
      workerName: null == workerName
          ? _value.workerName
          : workerName // ignore: cast_nullable_to_non_nullable
              as String,
      serviceName: null == serviceName
          ? _value.serviceName
          : serviceName // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as String,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as String,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as int,
      feedback: freezed == feedback
          ? _value.feedback
          : feedback // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ServiceHistoryImplCopyWith<$Res>
    implements $ServiceHistoryCopyWith<$Res> {
  factory _$$ServiceHistoryImplCopyWith(_$ServiceHistoryImpl value,
          $Res Function(_$ServiceHistoryImpl) then) =
      __$$ServiceHistoryImplCopyWithImpl<$Res>;
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
class __$$ServiceHistoryImplCopyWithImpl<$Res>
    extends _$ServiceHistoryCopyWithImpl<$Res, _$ServiceHistoryImpl>
    implements _$$ServiceHistoryImplCopyWith<$Res> {
  __$$ServiceHistoryImplCopyWithImpl(
      _$ServiceHistoryImpl _value, $Res Function(_$ServiceHistoryImpl) _then)
      : super(_value, _then);

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
    return _then(_$ServiceHistoryImpl(
      serviceId: null == serviceId
          ? _value.serviceId
          : serviceId // ignore: cast_nullable_to_non_nullable
              as String,
      workerName: null == workerName
          ? _value.workerName
          : workerName // ignore: cast_nullable_to_non_nullable
              as String,
      serviceName: null == serviceName
          ? _value.serviceName
          : serviceName // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as String,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as String,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as int,
      feedback: freezed == feedback
          ? _value.feedback
          : feedback // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ServiceHistoryImpl implements _ServiceHistory {
  const _$ServiceHistoryImpl(
      {required this.serviceId,
      required this.workerName,
      required this.serviceName,
      required this.date,
      required this.startTime,
      required this.endTime,
      required this.rating,
      this.feedback});

  factory _$ServiceHistoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$ServiceHistoryImplFromJson(json);

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

  @override
  String toString() {
    return 'ServiceHistory(serviceId: $serviceId, workerName: $workerName, serviceName: $serviceName, date: $date, startTime: $startTime, endTime: $endTime, rating: $rating, feedback: $feedback)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServiceHistoryImpl &&
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

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, serviceId, workerName,
      serviceName, date, startTime, endTime, rating, feedback);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ServiceHistoryImplCopyWith<_$ServiceHistoryImpl> get copyWith =>
      __$$ServiceHistoryImplCopyWithImpl<_$ServiceHistoryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ServiceHistoryImplToJson(
      this,
    );
  }
}

abstract class _ServiceHistory implements ServiceHistory {
  const factory _ServiceHistory(
      {required final String serviceId,
      required final String workerName,
      required final String serviceName,
      required final String date,
      required final String startTime,
      required final String endTime,
      required final int rating,
      final String? feedback}) = _$ServiceHistoryImpl;

  factory _ServiceHistory.fromJson(Map<String, dynamic> json) =
      _$ServiceHistoryImpl.fromJson;

  @override
  String get serviceId;
  @override
  String get workerName;
  @override
  String get serviceName;
  @override
  String get date;
  @override
  String get startTime;
  @override
  String get endTime;
  @override
  int get rating;
  @override
  String? get feedback;
  @override
  @JsonKey(ignore: true)
  _$$ServiceHistoryImplCopyWith<_$ServiceHistoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ClientAppointment _$ClientAppointmentFromJson(Map<String, dynamic> json) {
  return _ClientAppointment.fromJson(json);
}

/// @nodoc
mixin _$ClientAppointment {
  String get id => throw _privateConstructorUsedError;
  String get date => throw _privateConstructorUsedError;
  String get startTime => throw _privateConstructorUsedError;
  String get endTime => throw _privateConstructorUsedError;
  String? get userEmail => throw _privateConstructorUsedError;
  String? get assignmentId => throw _privateConstructorUsedError;
  String? get scheduleId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ClientAppointmentCopyWith<ClientAppointment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClientAppointmentCopyWith<$Res> {
  factory $ClientAppointmentCopyWith(
          ClientAppointment value, $Res Function(ClientAppointment) then) =
      _$ClientAppointmentCopyWithImpl<$Res, ClientAppointment>;
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
class _$ClientAppointmentCopyWithImpl<$Res, $Val extends ClientAppointment>
    implements $ClientAppointmentCopyWith<$Res> {
  _$ClientAppointmentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as String,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as String,
      userEmail: freezed == userEmail
          ? _value.userEmail
          : userEmail // ignore: cast_nullable_to_non_nullable
              as String?,
      assignmentId: freezed == assignmentId
          ? _value.assignmentId
          : assignmentId // ignore: cast_nullable_to_non_nullable
              as String?,
      scheduleId: freezed == scheduleId
          ? _value.scheduleId
          : scheduleId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ClientAppointmentImplCopyWith<$Res>
    implements $ClientAppointmentCopyWith<$Res> {
  factory _$$ClientAppointmentImplCopyWith(_$ClientAppointmentImpl value,
          $Res Function(_$ClientAppointmentImpl) then) =
      __$$ClientAppointmentImplCopyWithImpl<$Res>;
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
class __$$ClientAppointmentImplCopyWithImpl<$Res>
    extends _$ClientAppointmentCopyWithImpl<$Res, _$ClientAppointmentImpl>
    implements _$$ClientAppointmentImplCopyWith<$Res> {
  __$$ClientAppointmentImplCopyWithImpl(_$ClientAppointmentImpl _value,
      $Res Function(_$ClientAppointmentImpl) _then)
      : super(_value, _then);

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
    return _then(_$ClientAppointmentImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as String,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as String,
      userEmail: freezed == userEmail
          ? _value.userEmail
          : userEmail // ignore: cast_nullable_to_non_nullable
              as String?,
      assignmentId: freezed == assignmentId
          ? _value.assignmentId
          : assignmentId // ignore: cast_nullable_to_non_nullable
              as String?,
      scheduleId: freezed == scheduleId
          ? _value.scheduleId
          : scheduleId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ClientAppointmentImpl implements _ClientAppointment {
  const _$ClientAppointmentImpl(
      {required this.id,
      required this.date,
      required this.startTime,
      required this.endTime,
      this.userEmail,
      this.assignmentId,
      this.scheduleId});

  factory _$ClientAppointmentImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClientAppointmentImplFromJson(json);

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

  @override
  String toString() {
    return 'ClientAppointment(id: $id, date: $date, startTime: $startTime, endTime: $endTime, userEmail: $userEmail, assignmentId: $assignmentId, scheduleId: $scheduleId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClientAppointmentImpl &&
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

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, date, startTime, endTime,
      userEmail, assignmentId, scheduleId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ClientAppointmentImplCopyWith<_$ClientAppointmentImpl> get copyWith =>
      __$$ClientAppointmentImplCopyWithImpl<_$ClientAppointmentImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClientAppointmentImplToJson(
      this,
    );
  }
}

abstract class _ClientAppointment implements ClientAppointment {
  const factory _ClientAppointment(
      {required final String id,
      required final String date,
      required final String startTime,
      required final String endTime,
      final String? userEmail,
      final String? assignmentId,
      final String? scheduleId}) = _$ClientAppointmentImpl;

  factory _ClientAppointment.fromJson(Map<String, dynamic> json) =
      _$ClientAppointmentImpl.fromJson;

  @override
  String get id;
  @override
  String get date;
  @override
  String get startTime;
  @override
  String get endTime;
  @override
  String? get userEmail;
  @override
  String? get assignmentId;
  @override
  String? get scheduleId;
  @override
  @JsonKey(ignore: true)
  _$$ClientAppointmentImplCopyWith<_$ClientAppointmentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ClientAppointmentDetail _$ClientAppointmentDetailFromJson(
    Map<String, dynamic> json) {
  return _ClientAppointmentDetail.fromJson(json);
}

/// @nodoc
mixin _$ClientAppointmentDetail {
  String get id => throw _privateConstructorUsedError;
  String get date => throw _privateConstructorUsedError;
  String get startTime => throw _privateConstructorUsedError;
  String get endTime => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  ClientEmployee? get employee => throw _privateConstructorUsedError;
  List<String>? get services => throw _privateConstructorUsedError;
  String? get serviceName => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;
  String? get assignmentId => throw _privateConstructorUsedError;
  String? get scheduleId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ClientAppointmentDetailCopyWith<ClientAppointmentDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClientAppointmentDetailCopyWith<$Res> {
  factory $ClientAppointmentDetailCopyWith(ClientAppointmentDetail value,
          $Res Function(ClientAppointmentDetail) then) =
      _$ClientAppointmentDetailCopyWithImpl<$Res, ClientAppointmentDetail>;
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
class _$ClientAppointmentDetailCopyWithImpl<$Res,
        $Val extends ClientAppointmentDetail>
    implements $ClientAppointmentDetailCopyWith<$Res> {
  _$ClientAppointmentDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as String,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      employee: freezed == employee
          ? _value.employee
          : employee // ignore: cast_nullable_to_non_nullable
              as ClientEmployee?,
      services: freezed == services
          ? _value.services
          : services // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      serviceName: freezed == serviceName
          ? _value.serviceName
          : serviceName // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      assignmentId: freezed == assignmentId
          ? _value.assignmentId
          : assignmentId // ignore: cast_nullable_to_non_nullable
              as String?,
      scheduleId: freezed == scheduleId
          ? _value.scheduleId
          : scheduleId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ClientEmployeeCopyWith<$Res>? get employee {
    if (_value.employee == null) {
      return null;
    }

    return $ClientEmployeeCopyWith<$Res>(_value.employee!, (value) {
      return _then(_value.copyWith(employee: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ClientAppointmentDetailImplCopyWith<$Res>
    implements $ClientAppointmentDetailCopyWith<$Res> {
  factory _$$ClientAppointmentDetailImplCopyWith(
          _$ClientAppointmentDetailImpl value,
          $Res Function(_$ClientAppointmentDetailImpl) then) =
      __$$ClientAppointmentDetailImplCopyWithImpl<$Res>;
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
class __$$ClientAppointmentDetailImplCopyWithImpl<$Res>
    extends _$ClientAppointmentDetailCopyWithImpl<$Res,
        _$ClientAppointmentDetailImpl>
    implements _$$ClientAppointmentDetailImplCopyWith<$Res> {
  __$$ClientAppointmentDetailImplCopyWithImpl(
      _$ClientAppointmentDetailImpl _value,
      $Res Function(_$ClientAppointmentDetailImpl) _then)
      : super(_value, _then);

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
    return _then(_$ClientAppointmentDetailImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as String,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      employee: freezed == employee
          ? _value.employee
          : employee // ignore: cast_nullable_to_non_nullable
              as ClientEmployee?,
      services: freezed == services
          ? _value._services
          : services // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      serviceName: freezed == serviceName
          ? _value.serviceName
          : serviceName // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      assignmentId: freezed == assignmentId
          ? _value.assignmentId
          : assignmentId // ignore: cast_nullable_to_non_nullable
              as String?,
      scheduleId: freezed == scheduleId
          ? _value.scheduleId
          : scheduleId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ClientAppointmentDetailImpl implements _ClientAppointmentDetail {
  const _$ClientAppointmentDetailImpl(
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

  factory _$ClientAppointmentDetailImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClientAppointmentDetailImplFromJson(json);

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

  @override
  String toString() {
    return 'ClientAppointmentDetail(id: $id, date: $date, startTime: $startTime, endTime: $endTime, status: $status, notes: $notes, employee: $employee, services: $services, serviceName: $serviceName, location: $location, assignmentId: $assignmentId, scheduleId: $scheduleId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClientAppointmentDetailImpl &&
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

  @JsonKey(ignore: true)
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

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ClientAppointmentDetailImplCopyWith<_$ClientAppointmentDetailImpl>
      get copyWith => __$$ClientAppointmentDetailImplCopyWithImpl<
          _$ClientAppointmentDetailImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClientAppointmentDetailImplToJson(
      this,
    );
  }
}

abstract class _ClientAppointmentDetail implements ClientAppointmentDetail {
  const factory _ClientAppointmentDetail(
      {required final String id,
      required final String date,
      required final String startTime,
      required final String endTime,
      required final String status,
      final String? notes,
      final ClientEmployee? employee,
      final List<String>? services,
      final String? serviceName,
      final String? location,
      final String? assignmentId,
      final String? scheduleId}) = _$ClientAppointmentDetailImpl;

  factory _ClientAppointmentDetail.fromJson(Map<String, dynamic> json) =
      _$ClientAppointmentDetailImpl.fromJson;

  @override
  String get id;
  @override
  String get date;
  @override
  String get startTime;
  @override
  String get endTime;
  @override
  String get status;
  @override
  String? get notes;
  @override
  ClientEmployee? get employee;
  @override
  List<String>? get services;
  @override
  String? get serviceName;
  @override
  String? get location;
  @override
  String? get assignmentId;
  @override
  String? get scheduleId;
  @override
  @JsonKey(ignore: true)
  _$$ClientAppointmentDetailImplCopyWith<_$ClientAppointmentDetailImpl>
      get copyWith => throw _privateConstructorUsedError;
}

ClientEmployee _$ClientEmployeeFromJson(Map<String, dynamic> json) {
  return _ClientEmployee.fromJson(json);
}

/// @nodoc
mixin _$ClientEmployee {
  String get email => throw _privateConstructorUsedError;
  String get firstName => throw _privateConstructorUsedError;
  String get lastName => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get photo => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ClientEmployeeCopyWith<ClientEmployee> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClientEmployeeCopyWith<$Res> {
  factory $ClientEmployeeCopyWith(
          ClientEmployee value, $Res Function(ClientEmployee) then) =
      _$ClientEmployeeCopyWithImpl<$Res, ClientEmployee>;
  @useResult
  $Res call(
      {String email,
      String firstName,
      String lastName,
      String? phone,
      String? photo});
}

/// @nodoc
class _$ClientEmployeeCopyWithImpl<$Res, $Val extends ClientEmployee>
    implements $ClientEmployeeCopyWith<$Res> {
  _$ClientEmployeeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? phone = freezed,
    Object? photo = freezed,
  }) {
    return _then(_value.copyWith(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      photo: freezed == photo
          ? _value.photo
          : photo // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ClientEmployeeImplCopyWith<$Res>
    implements $ClientEmployeeCopyWith<$Res> {
  factory _$$ClientEmployeeImplCopyWith(_$ClientEmployeeImpl value,
          $Res Function(_$ClientEmployeeImpl) then) =
      __$$ClientEmployeeImplCopyWithImpl<$Res>;
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
class __$$ClientEmployeeImplCopyWithImpl<$Res>
    extends _$ClientEmployeeCopyWithImpl<$Res, _$ClientEmployeeImpl>
    implements _$$ClientEmployeeImplCopyWith<$Res> {
  __$$ClientEmployeeImplCopyWithImpl(
      _$ClientEmployeeImpl _value, $Res Function(_$ClientEmployeeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? phone = freezed,
    Object? photo = freezed,
  }) {
    return _then(_$ClientEmployeeImpl(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      photo: freezed == photo
          ? _value.photo
          : photo // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ClientEmployeeImpl implements _ClientEmployee {
  const _$ClientEmployeeImpl(
      {required this.email,
      required this.firstName,
      required this.lastName,
      this.phone,
      this.photo});

  factory _$ClientEmployeeImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClientEmployeeImplFromJson(json);

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

  @override
  String toString() {
    return 'ClientEmployee(email: $email, firstName: $firstName, lastName: $lastName, phone: $phone, photo: $photo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClientEmployeeImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.photo, photo) || other.photo == photo));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, email, firstName, lastName, phone, photo);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ClientEmployeeImplCopyWith<_$ClientEmployeeImpl> get copyWith =>
      __$$ClientEmployeeImplCopyWithImpl<_$ClientEmployeeImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClientEmployeeImplToJson(
      this,
    );
  }
}

abstract class _ClientEmployee implements ClientEmployee {
  const factory _ClientEmployee(
      {required final String email,
      required final String firstName,
      required final String lastName,
      final String? phone,
      final String? photo}) = _$ClientEmployeeImpl;

  factory _ClientEmployee.fromJson(Map<String, dynamic> json) =
      _$ClientEmployeeImpl.fromJson;

  @override
  String get email;
  @override
  String get firstName;
  @override
  String get lastName;
  @override
  String? get phone;
  @override
  String? get photo;
  @override
  @JsonKey(ignore: true)
  _$$ClientEmployeeImplCopyWith<_$ClientEmployeeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ClientInvoice _$ClientInvoiceFromJson(Map<String, dynamic> json) {
  return _ClientInvoice.fromJson(json);
}

/// @nodoc
mixin _$ClientInvoice {
  String get id => throw _privateConstructorUsedError;
  String get invoiceNumber => throw _privateConstructorUsedError;
  Map<String, dynamic> get workflow => throw _privateConstructorUsedError;
  Map<String, dynamic> get financialSummary =>
      throw _privateConstructorUsedError;
  List<dynamic>? get lineItems => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ClientInvoiceCopyWith<ClientInvoice> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClientInvoiceCopyWith<$Res> {
  factory $ClientInvoiceCopyWith(
          ClientInvoice value, $Res Function(ClientInvoice) then) =
      _$ClientInvoiceCopyWithImpl<$Res, ClientInvoice>;
  @useResult
  $Res call(
      {String id,
      String invoiceNumber,
      Map<String, dynamic> workflow,
      Map<String, dynamic> financialSummary,
      List<dynamic>? lineItems});
}

/// @nodoc
class _$ClientInvoiceCopyWithImpl<$Res, $Val extends ClientInvoice>
    implements $ClientInvoiceCopyWith<$Res> {
  _$ClientInvoiceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? invoiceNumber = null,
    Object? workflow = null,
    Object? financialSummary = null,
    Object? lineItems = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      invoiceNumber: null == invoiceNumber
          ? _value.invoiceNumber
          : invoiceNumber // ignore: cast_nullable_to_non_nullable
              as String,
      workflow: null == workflow
          ? _value.workflow
          : workflow // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      financialSummary: null == financialSummary
          ? _value.financialSummary
          : financialSummary // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      lineItems: freezed == lineItems
          ? _value.lineItems
          : lineItems // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ClientInvoiceImplCopyWith<$Res>
    implements $ClientInvoiceCopyWith<$Res> {
  factory _$$ClientInvoiceImplCopyWith(
          _$ClientInvoiceImpl value, $Res Function(_$ClientInvoiceImpl) then) =
      __$$ClientInvoiceImplCopyWithImpl<$Res>;
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
class __$$ClientInvoiceImplCopyWithImpl<$Res>
    extends _$ClientInvoiceCopyWithImpl<$Res, _$ClientInvoiceImpl>
    implements _$$ClientInvoiceImplCopyWith<$Res> {
  __$$ClientInvoiceImplCopyWithImpl(
      _$ClientInvoiceImpl _value, $Res Function(_$ClientInvoiceImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? invoiceNumber = null,
    Object? workflow = null,
    Object? financialSummary = null,
    Object? lineItems = freezed,
  }) {
    return _then(_$ClientInvoiceImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      invoiceNumber: null == invoiceNumber
          ? _value.invoiceNumber
          : invoiceNumber // ignore: cast_nullable_to_non_nullable
              as String,
      workflow: null == workflow
          ? _value._workflow
          : workflow // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      financialSummary: null == financialSummary
          ? _value._financialSummary
          : financialSummary // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      lineItems: freezed == lineItems
          ? _value._lineItems
          : lineItems // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ClientInvoiceImpl implements _ClientInvoice {
  const _$ClientInvoiceImpl(
      {required this.id,
      required this.invoiceNumber,
      required final Map<String, dynamic> workflow,
      required final Map<String, dynamic> financialSummary,
      final List<dynamic>? lineItems})
      : _workflow = workflow,
        _financialSummary = financialSummary,
        _lineItems = lineItems;

  factory _$ClientInvoiceImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClientInvoiceImplFromJson(json);

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

  @override
  String toString() {
    return 'ClientInvoice(id: $id, invoiceNumber: $invoiceNumber, workflow: $workflow, financialSummary: $financialSummary, lineItems: $lineItems)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClientInvoiceImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.invoiceNumber, invoiceNumber) ||
                other.invoiceNumber == invoiceNumber) &&
            const DeepCollectionEquality().equals(other._workflow, _workflow) &&
            const DeepCollectionEquality()
                .equals(other._financialSummary, _financialSummary) &&
            const DeepCollectionEquality()
                .equals(other._lineItems, _lineItems));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      invoiceNumber,
      const DeepCollectionEquality().hash(_workflow),
      const DeepCollectionEquality().hash(_financialSummary),
      const DeepCollectionEquality().hash(_lineItems));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ClientInvoiceImplCopyWith<_$ClientInvoiceImpl> get copyWith =>
      __$$ClientInvoiceImplCopyWithImpl<_$ClientInvoiceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClientInvoiceImplToJson(
      this,
    );
  }
}

abstract class _ClientInvoice implements ClientInvoice {
  const factory _ClientInvoice(
      {required final String id,
      required final String invoiceNumber,
      required final Map<String, dynamic> workflow,
      required final Map<String, dynamic> financialSummary,
      final List<dynamic>? lineItems}) = _$ClientInvoiceImpl;

  factory _ClientInvoice.fromJson(Map<String, dynamic> json) =
      _$ClientInvoiceImpl.fromJson;

  @override
  String get id;
  @override
  String get invoiceNumber;
  @override
  Map<String, dynamic> get workflow;
  @override
  Map<String, dynamic> get financialSummary;
  @override
  List<dynamic>? get lineItems;
  @override
  @JsonKey(ignore: true)
  _$$ClientInvoiceImplCopyWith<_$ClientInvoiceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AppointmentParams _$AppointmentParamsFromJson(Map<String, dynamic> json) {
  return _AppointmentParams.fromJson(json);
}

/// @nodoc
mixin _$AppointmentParams {
  String get assignmentId => throw _privateConstructorUsedError;
  String get scheduleId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppointmentParamsCopyWith<AppointmentParams> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppointmentParamsCopyWith<$Res> {
  factory $AppointmentParamsCopyWith(
          AppointmentParams value, $Res Function(AppointmentParams) then) =
      _$AppointmentParamsCopyWithImpl<$Res, AppointmentParams>;
  @useResult
  $Res call({String assignmentId, String scheduleId});
}

/// @nodoc
class _$AppointmentParamsCopyWithImpl<$Res, $Val extends AppointmentParams>
    implements $AppointmentParamsCopyWith<$Res> {
  _$AppointmentParamsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? assignmentId = null,
    Object? scheduleId = null,
  }) {
    return _then(_value.copyWith(
      assignmentId: null == assignmentId
          ? _value.assignmentId
          : assignmentId // ignore: cast_nullable_to_non_nullable
              as String,
      scheduleId: null == scheduleId
          ? _value.scheduleId
          : scheduleId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppointmentParamsImplCopyWith<$Res>
    implements $AppointmentParamsCopyWith<$Res> {
  factory _$$AppointmentParamsImplCopyWith(_$AppointmentParamsImpl value,
          $Res Function(_$AppointmentParamsImpl) then) =
      __$$AppointmentParamsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String assignmentId, String scheduleId});
}

/// @nodoc
class __$$AppointmentParamsImplCopyWithImpl<$Res>
    extends _$AppointmentParamsCopyWithImpl<$Res, _$AppointmentParamsImpl>
    implements _$$AppointmentParamsImplCopyWith<$Res> {
  __$$AppointmentParamsImplCopyWithImpl(_$AppointmentParamsImpl _value,
      $Res Function(_$AppointmentParamsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? assignmentId = null,
    Object? scheduleId = null,
  }) {
    return _then(_$AppointmentParamsImpl(
      assignmentId: null == assignmentId
          ? _value.assignmentId
          : assignmentId // ignore: cast_nullable_to_non_nullable
              as String,
      scheduleId: null == scheduleId
          ? _value.scheduleId
          : scheduleId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppointmentParamsImpl implements _AppointmentParams {
  const _$AppointmentParamsImpl(
      {required this.assignmentId, required this.scheduleId});

  factory _$AppointmentParamsImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppointmentParamsImplFromJson(json);

  @override
  final String assignmentId;
  @override
  final String scheduleId;

  @override
  String toString() {
    return 'AppointmentParams(assignmentId: $assignmentId, scheduleId: $scheduleId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppointmentParamsImpl &&
            (identical(other.assignmentId, assignmentId) ||
                other.assignmentId == assignmentId) &&
            (identical(other.scheduleId, scheduleId) ||
                other.scheduleId == scheduleId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, assignmentId, scheduleId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppointmentParamsImplCopyWith<_$AppointmentParamsImpl> get copyWith =>
      __$$AppointmentParamsImplCopyWithImpl<_$AppointmentParamsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppointmentParamsImplToJson(
      this,
    );
  }
}

abstract class _AppointmentParams implements AppointmentParams {
  const factory _AppointmentParams(
      {required final String assignmentId,
      required final String scheduleId}) = _$AppointmentParamsImpl;

  factory _AppointmentParams.fromJson(Map<String, dynamic> json) =
      _$AppointmentParamsImpl.fromJson;

  @override
  String get assignmentId;
  @override
  String get scheduleId;
  @override
  @JsonKey(ignore: true)
  _$$AppointmentParamsImplCopyWith<_$AppointmentParamsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
