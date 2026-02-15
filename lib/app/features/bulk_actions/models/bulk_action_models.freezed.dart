// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bulk_action_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TimesheetItem _$TimesheetItemFromJson(Map<String, dynamic> json) {
  return _TimesheetItem.fromJson(json);
}

/// @nodoc
mixin _$TimesheetItem {
  String get id => throw _privateConstructorUsedError;
  String get workerId => throw _privateConstructorUsedError;
  String get workerName => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  double get hours => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String? get clientName => throw _privateConstructorUsedError;
  String? get serviceName => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TimesheetItemCopyWith<TimesheetItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimesheetItemCopyWith<$Res> {
  factory $TimesheetItemCopyWith(
          TimesheetItem value, $Res Function(TimesheetItem) then) =
      _$TimesheetItemCopyWithImpl<$Res, TimesheetItem>;
  @useResult
  $Res call(
      {String id,
      String workerId,
      String workerName,
      DateTime date,
      double hours,
      String status,
      String? clientName,
      String? serviceName});
}

/// @nodoc
class _$TimesheetItemCopyWithImpl<$Res, $Val extends TimesheetItem>
    implements $TimesheetItemCopyWith<$Res> {
  _$TimesheetItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? workerId = null,
    Object? workerName = null,
    Object? date = null,
    Object? hours = null,
    Object? status = null,
    Object? clientName = freezed,
    Object? serviceName = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      workerId: null == workerId
          ? _value.workerId
          : workerId // ignore: cast_nullable_to_non_nullable
              as String,
      workerName: null == workerName
          ? _value.workerName
          : workerName // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      hours: null == hours
          ? _value.hours
          : hours // ignore: cast_nullable_to_non_nullable
              as double,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      clientName: freezed == clientName
          ? _value.clientName
          : clientName // ignore: cast_nullable_to_non_nullable
              as String?,
      serviceName: freezed == serviceName
          ? _value.serviceName
          : serviceName // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TimesheetItemImplCopyWith<$Res>
    implements $TimesheetItemCopyWith<$Res> {
  factory _$$TimesheetItemImplCopyWith(
          _$TimesheetItemImpl value, $Res Function(_$TimesheetItemImpl) then) =
      __$$TimesheetItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String workerId,
      String workerName,
      DateTime date,
      double hours,
      String status,
      String? clientName,
      String? serviceName});
}

/// @nodoc
class __$$TimesheetItemImplCopyWithImpl<$Res>
    extends _$TimesheetItemCopyWithImpl<$Res, _$TimesheetItemImpl>
    implements _$$TimesheetItemImplCopyWith<$Res> {
  __$$TimesheetItemImplCopyWithImpl(
      _$TimesheetItemImpl _value, $Res Function(_$TimesheetItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? workerId = null,
    Object? workerName = null,
    Object? date = null,
    Object? hours = null,
    Object? status = null,
    Object? clientName = freezed,
    Object? serviceName = freezed,
  }) {
    return _then(_$TimesheetItemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      workerId: null == workerId
          ? _value.workerId
          : workerId // ignore: cast_nullable_to_non_nullable
              as String,
      workerName: null == workerName
          ? _value.workerName
          : workerName // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      hours: null == hours
          ? _value.hours
          : hours // ignore: cast_nullable_to_non_nullable
              as double,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      clientName: freezed == clientName
          ? _value.clientName
          : clientName // ignore: cast_nullable_to_non_nullable
              as String?,
      serviceName: freezed == serviceName
          ? _value.serviceName
          : serviceName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TimesheetItemImpl implements _TimesheetItem {
  const _$TimesheetItemImpl(
      {required this.id,
      required this.workerId,
      required this.workerName,
      required this.date,
      required this.hours,
      required this.status,
      this.clientName,
      this.serviceName});

  factory _$TimesheetItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$TimesheetItemImplFromJson(json);

  @override
  final String id;
  @override
  final String workerId;
  @override
  final String workerName;
  @override
  final DateTime date;
  @override
  final double hours;
  @override
  final String status;
  @override
  final String? clientName;
  @override
  final String? serviceName;

  @override
  String toString() {
    return 'TimesheetItem(id: $id, workerId: $workerId, workerName: $workerName, date: $date, hours: $hours, status: $status, clientName: $clientName, serviceName: $serviceName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimesheetItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.workerId, workerId) ||
                other.workerId == workerId) &&
            (identical(other.workerName, workerName) ||
                other.workerName == workerName) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.hours, hours) || other.hours == hours) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.clientName, clientName) ||
                other.clientName == clientName) &&
            (identical(other.serviceName, serviceName) ||
                other.serviceName == serviceName));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, workerId, workerName, date,
      hours, status, clientName, serviceName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TimesheetItemImplCopyWith<_$TimesheetItemImpl> get copyWith =>
      __$$TimesheetItemImplCopyWithImpl<_$TimesheetItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TimesheetItemImplToJson(
      this,
    );
  }
}

abstract class _TimesheetItem implements TimesheetItem {
  const factory _TimesheetItem(
      {required final String id,
      required final String workerId,
      required final String workerName,
      required final DateTime date,
      required final double hours,
      required final String status,
      final String? clientName,
      final String? serviceName}) = _$TimesheetItemImpl;

  factory _TimesheetItem.fromJson(Map<String, dynamic> json) =
      _$TimesheetItemImpl.fromJson;

  @override
  String get id;
  @override
  String get workerId;
  @override
  String get workerName;
  @override
  DateTime get date;
  @override
  double get hours;
  @override
  String get status;
  @override
  String? get clientName;
  @override
  String? get serviceName;
  @override
  @JsonKey(ignore: true)
  _$$TimesheetItemImplCopyWith<_$TimesheetItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BulkTimesheetResult _$BulkTimesheetResultFromJson(Map<String, dynamic> json) {
  return _BulkTimesheetResult.fromJson(json);
}

/// @nodoc
mixin _$BulkTimesheetResult {
  int get approvedCount => throw _privateConstructorUsedError;
  int get rejectedCount => throw _privateConstructorUsedError;
  int get totalRequested => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BulkTimesheetResultCopyWith<BulkTimesheetResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BulkTimesheetResultCopyWith<$Res> {
  factory $BulkTimesheetResultCopyWith(
          BulkTimesheetResult value, $Res Function(BulkTimesheetResult) then) =
      _$BulkTimesheetResultCopyWithImpl<$Res, BulkTimesheetResult>;
  @useResult
  $Res call({int approvedCount, int rejectedCount, int totalRequested});
}

/// @nodoc
class _$BulkTimesheetResultCopyWithImpl<$Res, $Val extends BulkTimesheetResult>
    implements $BulkTimesheetResultCopyWith<$Res> {
  _$BulkTimesheetResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? approvedCount = null,
    Object? rejectedCount = null,
    Object? totalRequested = null,
  }) {
    return _then(_value.copyWith(
      approvedCount: null == approvedCount
          ? _value.approvedCount
          : approvedCount // ignore: cast_nullable_to_non_nullable
              as int,
      rejectedCount: null == rejectedCount
          ? _value.rejectedCount
          : rejectedCount // ignore: cast_nullable_to_non_nullable
              as int,
      totalRequested: null == totalRequested
          ? _value.totalRequested
          : totalRequested // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BulkTimesheetResultImplCopyWith<$Res>
    implements $BulkTimesheetResultCopyWith<$Res> {
  factory _$$BulkTimesheetResultImplCopyWith(_$BulkTimesheetResultImpl value,
          $Res Function(_$BulkTimesheetResultImpl) then) =
      __$$BulkTimesheetResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int approvedCount, int rejectedCount, int totalRequested});
}

/// @nodoc
class __$$BulkTimesheetResultImplCopyWithImpl<$Res>
    extends _$BulkTimesheetResultCopyWithImpl<$Res, _$BulkTimesheetResultImpl>
    implements _$$BulkTimesheetResultImplCopyWith<$Res> {
  __$$BulkTimesheetResultImplCopyWithImpl(_$BulkTimesheetResultImpl _value,
      $Res Function(_$BulkTimesheetResultImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? approvedCount = null,
    Object? rejectedCount = null,
    Object? totalRequested = null,
  }) {
    return _then(_$BulkTimesheetResultImpl(
      approvedCount: null == approvedCount
          ? _value.approvedCount
          : approvedCount // ignore: cast_nullable_to_non_nullable
              as int,
      rejectedCount: null == rejectedCount
          ? _value.rejectedCount
          : rejectedCount // ignore: cast_nullable_to_non_nullable
              as int,
      totalRequested: null == totalRequested
          ? _value.totalRequested
          : totalRequested // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BulkTimesheetResultImpl implements _BulkTimesheetResult {
  const _$BulkTimesheetResultImpl(
      {required this.approvedCount,
      required this.rejectedCount,
      required this.totalRequested});

  factory _$BulkTimesheetResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$BulkTimesheetResultImplFromJson(json);

  @override
  final int approvedCount;
  @override
  final int rejectedCount;
  @override
  final int totalRequested;

  @override
  String toString() {
    return 'BulkTimesheetResult(approvedCount: $approvedCount, rejectedCount: $rejectedCount, totalRequested: $totalRequested)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BulkTimesheetResultImpl &&
            (identical(other.approvedCount, approvedCount) ||
                other.approvedCount == approvedCount) &&
            (identical(other.rejectedCount, rejectedCount) ||
                other.rejectedCount == rejectedCount) &&
            (identical(other.totalRequested, totalRequested) ||
                other.totalRequested == totalRequested));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, approvedCount, rejectedCount, totalRequested);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BulkTimesheetResultImplCopyWith<_$BulkTimesheetResultImpl> get copyWith =>
      __$$BulkTimesheetResultImplCopyWithImpl<_$BulkTimesheetResultImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BulkTimesheetResultImplToJson(
      this,
    );
  }
}

abstract class _BulkTimesheetResult implements BulkTimesheetResult {
  const factory _BulkTimesheetResult(
      {required final int approvedCount,
      required final int rejectedCount,
      required final int totalRequested}) = _$BulkTimesheetResultImpl;

  factory _BulkTimesheetResult.fromJson(Map<String, dynamic> json) =
      _$BulkTimesheetResultImpl.fromJson;

  @override
  int get approvedCount;
  @override
  int get rejectedCount;
  @override
  int get totalRequested;
  @override
  @JsonKey(ignore: true)
  _$$BulkTimesheetResultImplCopyWith<_$BulkTimesheetResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

InvoicePreviewItem _$InvoicePreviewItemFromJson(Map<String, dynamic> json) {
  return _InvoicePreviewItem.fromJson(json);
}

/// @nodoc
mixin _$InvoicePreviewItem {
  String get clientId => throw _privateConstructorUsedError;
  String get clientName => throw _privateConstructorUsedError;
  String get clientEmail => throw _privateConstructorUsedError;
  List<AppointmentLineItem> get appointments =>
      throw _privateConstructorUsedError;
  double get totalAmount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InvoicePreviewItemCopyWith<InvoicePreviewItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InvoicePreviewItemCopyWith<$Res> {
  factory $InvoicePreviewItemCopyWith(
          InvoicePreviewItem value, $Res Function(InvoicePreviewItem) then) =
      _$InvoicePreviewItemCopyWithImpl<$Res, InvoicePreviewItem>;
  @useResult
  $Res call(
      {String clientId,
      String clientName,
      String clientEmail,
      List<AppointmentLineItem> appointments,
      double totalAmount});
}

/// @nodoc
class _$InvoicePreviewItemCopyWithImpl<$Res, $Val extends InvoicePreviewItem>
    implements $InvoicePreviewItemCopyWith<$Res> {
  _$InvoicePreviewItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clientId = null,
    Object? clientName = null,
    Object? clientEmail = null,
    Object? appointments = null,
    Object? totalAmount = null,
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
      clientEmail: null == clientEmail
          ? _value.clientEmail
          : clientEmail // ignore: cast_nullable_to_non_nullable
              as String,
      appointments: null == appointments
          ? _value.appointments
          : appointments // ignore: cast_nullable_to_non_nullable
              as List<AppointmentLineItem>,
      totalAmount: null == totalAmount
          ? _value.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InvoicePreviewItemImplCopyWith<$Res>
    implements $InvoicePreviewItemCopyWith<$Res> {
  factory _$$InvoicePreviewItemImplCopyWith(_$InvoicePreviewItemImpl value,
          $Res Function(_$InvoicePreviewItemImpl) then) =
      __$$InvoicePreviewItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String clientId,
      String clientName,
      String clientEmail,
      List<AppointmentLineItem> appointments,
      double totalAmount});
}

/// @nodoc
class __$$InvoicePreviewItemImplCopyWithImpl<$Res>
    extends _$InvoicePreviewItemCopyWithImpl<$Res, _$InvoicePreviewItemImpl>
    implements _$$InvoicePreviewItemImplCopyWith<$Res> {
  __$$InvoicePreviewItemImplCopyWithImpl(_$InvoicePreviewItemImpl _value,
      $Res Function(_$InvoicePreviewItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clientId = null,
    Object? clientName = null,
    Object? clientEmail = null,
    Object? appointments = null,
    Object? totalAmount = null,
  }) {
    return _then(_$InvoicePreviewItemImpl(
      clientId: null == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      clientName: null == clientName
          ? _value.clientName
          : clientName // ignore: cast_nullable_to_non_nullable
              as String,
      clientEmail: null == clientEmail
          ? _value.clientEmail
          : clientEmail // ignore: cast_nullable_to_non_nullable
              as String,
      appointments: null == appointments
          ? _value._appointments
          : appointments // ignore: cast_nullable_to_non_nullable
              as List<AppointmentLineItem>,
      totalAmount: null == totalAmount
          ? _value.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InvoicePreviewItemImpl implements _InvoicePreviewItem {
  const _$InvoicePreviewItemImpl(
      {required this.clientId,
      required this.clientName,
      required this.clientEmail,
      required final List<AppointmentLineItem> appointments,
      required this.totalAmount})
      : _appointments = appointments;

  factory _$InvoicePreviewItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$InvoicePreviewItemImplFromJson(json);

  @override
  final String clientId;
  @override
  final String clientName;
  @override
  final String clientEmail;
  final List<AppointmentLineItem> _appointments;
  @override
  List<AppointmentLineItem> get appointments {
    if (_appointments is EqualUnmodifiableListView) return _appointments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_appointments);
  }

  @override
  final double totalAmount;

  @override
  String toString() {
    return 'InvoicePreviewItem(clientId: $clientId, clientName: $clientName, clientEmail: $clientEmail, appointments: $appointments, totalAmount: $totalAmount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InvoicePreviewItemImpl &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.clientName, clientName) ||
                other.clientName == clientName) &&
            (identical(other.clientEmail, clientEmail) ||
                other.clientEmail == clientEmail) &&
            const DeepCollectionEquality()
                .equals(other._appointments, _appointments) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      clientId,
      clientName,
      clientEmail,
      const DeepCollectionEquality().hash(_appointments),
      totalAmount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InvoicePreviewItemImplCopyWith<_$InvoicePreviewItemImpl> get copyWith =>
      __$$InvoicePreviewItemImplCopyWithImpl<_$InvoicePreviewItemImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InvoicePreviewItemImplToJson(
      this,
    );
  }
}

abstract class _InvoicePreviewItem implements InvoicePreviewItem {
  const factory _InvoicePreviewItem(
      {required final String clientId,
      required final String clientName,
      required final String clientEmail,
      required final List<AppointmentLineItem> appointments,
      required final double totalAmount}) = _$InvoicePreviewItemImpl;

  factory _InvoicePreviewItem.fromJson(Map<String, dynamic> json) =
      _$InvoicePreviewItemImpl.fromJson;

  @override
  String get clientId;
  @override
  String get clientName;
  @override
  String get clientEmail;
  @override
  List<AppointmentLineItem> get appointments;
  @override
  double get totalAmount;
  @override
  @JsonKey(ignore: true)
  _$$InvoicePreviewItemImplCopyWith<_$InvoicePreviewItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AppointmentLineItem _$AppointmentLineItemFromJson(Map<String, dynamic> json) {
  return _AppointmentLineItem.fromJson(json);
}

/// @nodoc
mixin _$AppointmentLineItem {
  String get appointmentId => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  String get service => throw _privateConstructorUsedError;
  double get duration => throw _privateConstructorUsedError;
  double get rate => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppointmentLineItemCopyWith<AppointmentLineItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppointmentLineItemCopyWith<$Res> {
  factory $AppointmentLineItemCopyWith(
          AppointmentLineItem value, $Res Function(AppointmentLineItem) then) =
      _$AppointmentLineItemCopyWithImpl<$Res, AppointmentLineItem>;
  @useResult
  $Res call(
      {String appointmentId,
      DateTime date,
      String service,
      double duration,
      double rate,
      double amount});
}

/// @nodoc
class _$AppointmentLineItemCopyWithImpl<$Res, $Val extends AppointmentLineItem>
    implements $AppointmentLineItemCopyWith<$Res> {
  _$AppointmentLineItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appointmentId = null,
    Object? date = null,
    Object? service = null,
    Object? duration = null,
    Object? rate = null,
    Object? amount = null,
  }) {
    return _then(_value.copyWith(
      appointmentId: null == appointmentId
          ? _value.appointmentId
          : appointmentId // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      service: null == service
          ? _value.service
          : service // ignore: cast_nullable_to_non_nullable
              as String,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as double,
      rate: null == rate
          ? _value.rate
          : rate // ignore: cast_nullable_to_non_nullable
              as double,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppointmentLineItemImplCopyWith<$Res>
    implements $AppointmentLineItemCopyWith<$Res> {
  factory _$$AppointmentLineItemImplCopyWith(_$AppointmentLineItemImpl value,
          $Res Function(_$AppointmentLineItemImpl) then) =
      __$$AppointmentLineItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String appointmentId,
      DateTime date,
      String service,
      double duration,
      double rate,
      double amount});
}

/// @nodoc
class __$$AppointmentLineItemImplCopyWithImpl<$Res>
    extends _$AppointmentLineItemCopyWithImpl<$Res, _$AppointmentLineItemImpl>
    implements _$$AppointmentLineItemImplCopyWith<$Res> {
  __$$AppointmentLineItemImplCopyWithImpl(_$AppointmentLineItemImpl _value,
      $Res Function(_$AppointmentLineItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appointmentId = null,
    Object? date = null,
    Object? service = null,
    Object? duration = null,
    Object? rate = null,
    Object? amount = null,
  }) {
    return _then(_$AppointmentLineItemImpl(
      appointmentId: null == appointmentId
          ? _value.appointmentId
          : appointmentId // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      service: null == service
          ? _value.service
          : service // ignore: cast_nullable_to_non_nullable
              as String,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as double,
      rate: null == rate
          ? _value.rate
          : rate // ignore: cast_nullable_to_non_nullable
              as double,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppointmentLineItemImpl implements _AppointmentLineItem {
  const _$AppointmentLineItemImpl(
      {required this.appointmentId,
      required this.date,
      required this.service,
      required this.duration,
      required this.rate,
      required this.amount});

  factory _$AppointmentLineItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppointmentLineItemImplFromJson(json);

  @override
  final String appointmentId;
  @override
  final DateTime date;
  @override
  final String service;
  @override
  final double duration;
  @override
  final double rate;
  @override
  final double amount;

  @override
  String toString() {
    return 'AppointmentLineItem(appointmentId: $appointmentId, date: $date, service: $service, duration: $duration, rate: $rate, amount: $amount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppointmentLineItemImpl &&
            (identical(other.appointmentId, appointmentId) ||
                other.appointmentId == appointmentId) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.service, service) || other.service == service) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.rate, rate) || other.rate == rate) &&
            (identical(other.amount, amount) || other.amount == amount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, appointmentId, date, service, duration, rate, amount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppointmentLineItemImplCopyWith<_$AppointmentLineItemImpl> get copyWith =>
      __$$AppointmentLineItemImplCopyWithImpl<_$AppointmentLineItemImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppointmentLineItemImplToJson(
      this,
    );
  }
}

abstract class _AppointmentLineItem implements AppointmentLineItem {
  const factory _AppointmentLineItem(
      {required final String appointmentId,
      required final DateTime date,
      required final String service,
      required final double duration,
      required final double rate,
      required final double amount}) = _$AppointmentLineItemImpl;

  factory _AppointmentLineItem.fromJson(Map<String, dynamic> json) =
      _$AppointmentLineItemImpl.fromJson;

  @override
  String get appointmentId;
  @override
  DateTime get date;
  @override
  String get service;
  @override
  double get duration;
  @override
  double get rate;
  @override
  double get amount;
  @override
  @JsonKey(ignore: true)
  _$$AppointmentLineItemImplCopyWith<_$AppointmentLineItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

InvoicePreview _$InvoicePreviewFromJson(Map<String, dynamic> json) {
  return _InvoicePreview.fromJson(json);
}

/// @nodoc
mixin _$InvoicePreview {
  int get invoiceCount => throw _privateConstructorUsedError;
  int get totalAppointments => throw _privateConstructorUsedError;
  double get totalAmount => throw _privateConstructorUsedError;
  List<InvoicePreviewItem> get invoices => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InvoicePreviewCopyWith<InvoicePreview> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InvoicePreviewCopyWith<$Res> {
  factory $InvoicePreviewCopyWith(
          InvoicePreview value, $Res Function(InvoicePreview) then) =
      _$InvoicePreviewCopyWithImpl<$Res, InvoicePreview>;
  @useResult
  $Res call(
      {int invoiceCount,
      int totalAppointments,
      double totalAmount,
      List<InvoicePreviewItem> invoices});
}

/// @nodoc
class _$InvoicePreviewCopyWithImpl<$Res, $Val extends InvoicePreview>
    implements $InvoicePreviewCopyWith<$Res> {
  _$InvoicePreviewCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? invoiceCount = null,
    Object? totalAppointments = null,
    Object? totalAmount = null,
    Object? invoices = null,
  }) {
    return _then(_value.copyWith(
      invoiceCount: null == invoiceCount
          ? _value.invoiceCount
          : invoiceCount // ignore: cast_nullable_to_non_nullable
              as int,
      totalAppointments: null == totalAppointments
          ? _value.totalAppointments
          : totalAppointments // ignore: cast_nullable_to_non_nullable
              as int,
      totalAmount: null == totalAmount
          ? _value.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as double,
      invoices: null == invoices
          ? _value.invoices
          : invoices // ignore: cast_nullable_to_non_nullable
              as List<InvoicePreviewItem>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InvoicePreviewImplCopyWith<$Res>
    implements $InvoicePreviewCopyWith<$Res> {
  factory _$$InvoicePreviewImplCopyWith(_$InvoicePreviewImpl value,
          $Res Function(_$InvoicePreviewImpl) then) =
      __$$InvoicePreviewImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int invoiceCount,
      int totalAppointments,
      double totalAmount,
      List<InvoicePreviewItem> invoices});
}

/// @nodoc
class __$$InvoicePreviewImplCopyWithImpl<$Res>
    extends _$InvoicePreviewCopyWithImpl<$Res, _$InvoicePreviewImpl>
    implements _$$InvoicePreviewImplCopyWith<$Res> {
  __$$InvoicePreviewImplCopyWithImpl(
      _$InvoicePreviewImpl _value, $Res Function(_$InvoicePreviewImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? invoiceCount = null,
    Object? totalAppointments = null,
    Object? totalAmount = null,
    Object? invoices = null,
  }) {
    return _then(_$InvoicePreviewImpl(
      invoiceCount: null == invoiceCount
          ? _value.invoiceCount
          : invoiceCount // ignore: cast_nullable_to_non_nullable
              as int,
      totalAppointments: null == totalAppointments
          ? _value.totalAppointments
          : totalAppointments // ignore: cast_nullable_to_non_nullable
              as int,
      totalAmount: null == totalAmount
          ? _value.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as double,
      invoices: null == invoices
          ? _value._invoices
          : invoices // ignore: cast_nullable_to_non_nullable
              as List<InvoicePreviewItem>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InvoicePreviewImpl implements _InvoicePreview {
  const _$InvoicePreviewImpl(
      {required this.invoiceCount,
      required this.totalAppointments,
      required this.totalAmount,
      required final List<InvoicePreviewItem> invoices})
      : _invoices = invoices;

  factory _$InvoicePreviewImpl.fromJson(Map<String, dynamic> json) =>
      _$$InvoicePreviewImplFromJson(json);

  @override
  final int invoiceCount;
  @override
  final int totalAppointments;
  @override
  final double totalAmount;
  final List<InvoicePreviewItem> _invoices;
  @override
  List<InvoicePreviewItem> get invoices {
    if (_invoices is EqualUnmodifiableListView) return _invoices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_invoices);
  }

  @override
  String toString() {
    return 'InvoicePreview(invoiceCount: $invoiceCount, totalAppointments: $totalAppointments, totalAmount: $totalAmount, invoices: $invoices)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InvoicePreviewImpl &&
            (identical(other.invoiceCount, invoiceCount) ||
                other.invoiceCount == invoiceCount) &&
            (identical(other.totalAppointments, totalAppointments) ||
                other.totalAppointments == totalAppointments) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount) &&
            const DeepCollectionEquality().equals(other._invoices, _invoices));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, invoiceCount, totalAppointments,
      totalAmount, const DeepCollectionEquality().hash(_invoices));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InvoicePreviewImplCopyWith<_$InvoicePreviewImpl> get copyWith =>
      __$$InvoicePreviewImplCopyWithImpl<_$InvoicePreviewImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InvoicePreviewImplToJson(
      this,
    );
  }
}

abstract class _InvoicePreview implements InvoicePreview {
  const factory _InvoicePreview(
      {required final int invoiceCount,
      required final int totalAppointments,
      required final double totalAmount,
      required final List<InvoicePreviewItem> invoices}) = _$InvoicePreviewImpl;

  factory _InvoicePreview.fromJson(Map<String, dynamic> json) =
      _$InvoicePreviewImpl.fromJson;

  @override
  int get invoiceCount;
  @override
  int get totalAppointments;
  @override
  double get totalAmount;
  @override
  List<InvoicePreviewItem> get invoices;
  @override
  @JsonKey(ignore: true)
  _$$InvoicePreviewImplCopyWith<_$InvoicePreviewImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BulkInvoiceResult _$BulkInvoiceResultFromJson(Map<String, dynamic> json) {
  return _BulkInvoiceResult.fromJson(json);
}

/// @nodoc
mixin _$BulkInvoiceResult {
  int get invoiceCount => throw _privateConstructorUsedError;
  int get appointmentCount => throw _privateConstructorUsedError;
  double get totalAmount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BulkInvoiceResultCopyWith<BulkInvoiceResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BulkInvoiceResultCopyWith<$Res> {
  factory $BulkInvoiceResultCopyWith(
          BulkInvoiceResult value, $Res Function(BulkInvoiceResult) then) =
      _$BulkInvoiceResultCopyWithImpl<$Res, BulkInvoiceResult>;
  @useResult
  $Res call({int invoiceCount, int appointmentCount, double totalAmount});
}

/// @nodoc
class _$BulkInvoiceResultCopyWithImpl<$Res, $Val extends BulkInvoiceResult>
    implements $BulkInvoiceResultCopyWith<$Res> {
  _$BulkInvoiceResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? invoiceCount = null,
    Object? appointmentCount = null,
    Object? totalAmount = null,
  }) {
    return _then(_value.copyWith(
      invoiceCount: null == invoiceCount
          ? _value.invoiceCount
          : invoiceCount // ignore: cast_nullable_to_non_nullable
              as int,
      appointmentCount: null == appointmentCount
          ? _value.appointmentCount
          : appointmentCount // ignore: cast_nullable_to_non_nullable
              as int,
      totalAmount: null == totalAmount
          ? _value.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BulkInvoiceResultImplCopyWith<$Res>
    implements $BulkInvoiceResultCopyWith<$Res> {
  factory _$$BulkInvoiceResultImplCopyWith(_$BulkInvoiceResultImpl value,
          $Res Function(_$BulkInvoiceResultImpl) then) =
      __$$BulkInvoiceResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int invoiceCount, int appointmentCount, double totalAmount});
}

/// @nodoc
class __$$BulkInvoiceResultImplCopyWithImpl<$Res>
    extends _$BulkInvoiceResultCopyWithImpl<$Res, _$BulkInvoiceResultImpl>
    implements _$$BulkInvoiceResultImplCopyWith<$Res> {
  __$$BulkInvoiceResultImplCopyWithImpl(_$BulkInvoiceResultImpl _value,
      $Res Function(_$BulkInvoiceResultImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? invoiceCount = null,
    Object? appointmentCount = null,
    Object? totalAmount = null,
  }) {
    return _then(_$BulkInvoiceResultImpl(
      invoiceCount: null == invoiceCount
          ? _value.invoiceCount
          : invoiceCount // ignore: cast_nullable_to_non_nullable
              as int,
      appointmentCount: null == appointmentCount
          ? _value.appointmentCount
          : appointmentCount // ignore: cast_nullable_to_non_nullable
              as int,
      totalAmount: null == totalAmount
          ? _value.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BulkInvoiceResultImpl implements _BulkInvoiceResult {
  const _$BulkInvoiceResultImpl(
      {required this.invoiceCount,
      required this.appointmentCount,
      required this.totalAmount});

  factory _$BulkInvoiceResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$BulkInvoiceResultImplFromJson(json);

  @override
  final int invoiceCount;
  @override
  final int appointmentCount;
  @override
  final double totalAmount;

  @override
  String toString() {
    return 'BulkInvoiceResult(invoiceCount: $invoiceCount, appointmentCount: $appointmentCount, totalAmount: $totalAmount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BulkInvoiceResultImpl &&
            (identical(other.invoiceCount, invoiceCount) ||
                other.invoiceCount == invoiceCount) &&
            (identical(other.appointmentCount, appointmentCount) ||
                other.appointmentCount == appointmentCount) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, invoiceCount, appointmentCount, totalAmount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BulkInvoiceResultImplCopyWith<_$BulkInvoiceResultImpl> get copyWith =>
      __$$BulkInvoiceResultImplCopyWithImpl<_$BulkInvoiceResultImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BulkInvoiceResultImplToJson(
      this,
    );
  }
}

abstract class _BulkInvoiceResult implements BulkInvoiceResult {
  const factory _BulkInvoiceResult(
      {required final int invoiceCount,
      required final int appointmentCount,
      required final double totalAmount}) = _$BulkInvoiceResultImpl;

  factory _BulkInvoiceResult.fromJson(Map<String, dynamic> json) =
      _$BulkInvoiceResultImpl.fromJson;

  @override
  int get invoiceCount;
  @override
  int get appointmentCount;
  @override
  double get totalAmount;
  @override
  @JsonKey(ignore: true)
  _$$BulkInvoiceResultImplCopyWith<_$BulkInvoiceResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ShiftAssignment _$ShiftAssignmentFromJson(Map<String, dynamic> json) {
  return _ShiftAssignment.fromJson(json);
}

/// @nodoc
mixin _$ShiftAssignment {
  String get shiftId => throw _privateConstructorUsedError;
  String? get workerId => throw _privateConstructorUsedError;
  DateTime? get shiftDate => throw _privateConstructorUsedError;
  String? get shiftTime => throw _privateConstructorUsedError;
  String? get service => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ShiftAssignmentCopyWith<ShiftAssignment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShiftAssignmentCopyWith<$Res> {
  factory $ShiftAssignmentCopyWith(
          ShiftAssignment value, $Res Function(ShiftAssignment) then) =
      _$ShiftAssignmentCopyWithImpl<$Res, ShiftAssignment>;
  @useResult
  $Res call(
      {String shiftId,
      String? workerId,
      DateTime? shiftDate,
      String? shiftTime,
      String? service});
}

/// @nodoc
class _$ShiftAssignmentCopyWithImpl<$Res, $Val extends ShiftAssignment>
    implements $ShiftAssignmentCopyWith<$Res> {
  _$ShiftAssignmentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? shiftId = null,
    Object? workerId = freezed,
    Object? shiftDate = freezed,
    Object? shiftTime = freezed,
    Object? service = freezed,
  }) {
    return _then(_value.copyWith(
      shiftId: null == shiftId
          ? _value.shiftId
          : shiftId // ignore: cast_nullable_to_non_nullable
              as String,
      workerId: freezed == workerId
          ? _value.workerId
          : workerId // ignore: cast_nullable_to_non_nullable
              as String?,
      shiftDate: freezed == shiftDate
          ? _value.shiftDate
          : shiftDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      shiftTime: freezed == shiftTime
          ? _value.shiftTime
          : shiftTime // ignore: cast_nullable_to_non_nullable
              as String?,
      service: freezed == service
          ? _value.service
          : service // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ShiftAssignmentImplCopyWith<$Res>
    implements $ShiftAssignmentCopyWith<$Res> {
  factory _$$ShiftAssignmentImplCopyWith(_$ShiftAssignmentImpl value,
          $Res Function(_$ShiftAssignmentImpl) then) =
      __$$ShiftAssignmentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String shiftId,
      String? workerId,
      DateTime? shiftDate,
      String? shiftTime,
      String? service});
}

/// @nodoc
class __$$ShiftAssignmentImplCopyWithImpl<$Res>
    extends _$ShiftAssignmentCopyWithImpl<$Res, _$ShiftAssignmentImpl>
    implements _$$ShiftAssignmentImplCopyWith<$Res> {
  __$$ShiftAssignmentImplCopyWithImpl(
      _$ShiftAssignmentImpl _value, $Res Function(_$ShiftAssignmentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? shiftId = null,
    Object? workerId = freezed,
    Object? shiftDate = freezed,
    Object? shiftTime = freezed,
    Object? service = freezed,
  }) {
    return _then(_$ShiftAssignmentImpl(
      shiftId: null == shiftId
          ? _value.shiftId
          : shiftId // ignore: cast_nullable_to_non_nullable
              as String,
      workerId: freezed == workerId
          ? _value.workerId
          : workerId // ignore: cast_nullable_to_non_nullable
              as String?,
      shiftDate: freezed == shiftDate
          ? _value.shiftDate
          : shiftDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      shiftTime: freezed == shiftTime
          ? _value.shiftTime
          : shiftTime // ignore: cast_nullable_to_non_nullable
              as String?,
      service: freezed == service
          ? _value.service
          : service // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ShiftAssignmentImpl implements _ShiftAssignment {
  const _$ShiftAssignmentImpl(
      {required this.shiftId,
      required this.workerId,
      this.shiftDate,
      this.shiftTime,
      this.service});

  factory _$ShiftAssignmentImpl.fromJson(Map<String, dynamic> json) =>
      _$$ShiftAssignmentImplFromJson(json);

  @override
  final String shiftId;
  @override
  final String? workerId;
  @override
  final DateTime? shiftDate;
  @override
  final String? shiftTime;
  @override
  final String? service;

  @override
  String toString() {
    return 'ShiftAssignment(shiftId: $shiftId, workerId: $workerId, shiftDate: $shiftDate, shiftTime: $shiftTime, service: $service)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShiftAssignmentImpl &&
            (identical(other.shiftId, shiftId) || other.shiftId == shiftId) &&
            (identical(other.workerId, workerId) ||
                other.workerId == workerId) &&
            (identical(other.shiftDate, shiftDate) ||
                other.shiftDate == shiftDate) &&
            (identical(other.shiftTime, shiftTime) ||
                other.shiftTime == shiftTime) &&
            (identical(other.service, service) || other.service == service));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, shiftId, workerId, shiftDate, shiftTime, service);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ShiftAssignmentImplCopyWith<_$ShiftAssignmentImpl> get copyWith =>
      __$$ShiftAssignmentImplCopyWithImpl<_$ShiftAssignmentImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ShiftAssignmentImplToJson(
      this,
    );
  }
}

abstract class _ShiftAssignment implements ShiftAssignment {
  const factory _ShiftAssignment(
      {required final String shiftId,
      required final String? workerId,
      final DateTime? shiftDate,
      final String? shiftTime,
      final String? service}) = _$ShiftAssignmentImpl;

  factory _ShiftAssignment.fromJson(Map<String, dynamic> json) =
      _$ShiftAssignmentImpl.fromJson;

  @override
  String get shiftId;
  @override
  String? get workerId;
  @override
  DateTime? get shiftDate;
  @override
  String? get shiftTime;
  @override
  String? get service;
  @override
  @JsonKey(ignore: true)
  _$$ShiftAssignmentImplCopyWith<_$ShiftAssignmentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WorkerSuggestion _$WorkerSuggestionFromJson(Map<String, dynamic> json) {
  return _WorkerSuggestion.fromJson(json);
}

/// @nodoc
mixin _$WorkerSuggestion {
  String get workerId => throw _privateConstructorUsedError;
  String get workerName => throw _privateConstructorUsedError;
  String get workerEmail => throw _privateConstructorUsedError;
  double get score => throw _privateConstructorUsedError;
  String get matchReason => throw _privateConstructorUsedError;
  List<String> get conflicts => throw _privateConstructorUsedError;
  double get rating => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WorkerSuggestionCopyWith<WorkerSuggestion> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkerSuggestionCopyWith<$Res> {
  factory $WorkerSuggestionCopyWith(
          WorkerSuggestion value, $Res Function(WorkerSuggestion) then) =
      _$WorkerSuggestionCopyWithImpl<$Res, WorkerSuggestion>;
  @useResult
  $Res call(
      {String workerId,
      String workerName,
      String workerEmail,
      double score,
      String matchReason,
      List<String> conflicts,
      double rating});
}

/// @nodoc
class _$WorkerSuggestionCopyWithImpl<$Res, $Val extends WorkerSuggestion>
    implements $WorkerSuggestionCopyWith<$Res> {
  _$WorkerSuggestionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? workerId = null,
    Object? workerName = null,
    Object? workerEmail = null,
    Object? score = null,
    Object? matchReason = null,
    Object? conflicts = null,
    Object? rating = null,
  }) {
    return _then(_value.copyWith(
      workerId: null == workerId
          ? _value.workerId
          : workerId // ignore: cast_nullable_to_non_nullable
              as String,
      workerName: null == workerName
          ? _value.workerName
          : workerName // ignore: cast_nullable_to_non_nullable
              as String,
      workerEmail: null == workerEmail
          ? _value.workerEmail
          : workerEmail // ignore: cast_nullable_to_non_nullable
              as String,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as double,
      matchReason: null == matchReason
          ? _value.matchReason
          : matchReason // ignore: cast_nullable_to_non_nullable
              as String,
      conflicts: null == conflicts
          ? _value.conflicts
          : conflicts // ignore: cast_nullable_to_non_nullable
              as List<String>,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WorkerSuggestionImplCopyWith<$Res>
    implements $WorkerSuggestionCopyWith<$Res> {
  factory _$$WorkerSuggestionImplCopyWith(_$WorkerSuggestionImpl value,
          $Res Function(_$WorkerSuggestionImpl) then) =
      __$$WorkerSuggestionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String workerId,
      String workerName,
      String workerEmail,
      double score,
      String matchReason,
      List<String> conflicts,
      double rating});
}

/// @nodoc
class __$$WorkerSuggestionImplCopyWithImpl<$Res>
    extends _$WorkerSuggestionCopyWithImpl<$Res, _$WorkerSuggestionImpl>
    implements _$$WorkerSuggestionImplCopyWith<$Res> {
  __$$WorkerSuggestionImplCopyWithImpl(_$WorkerSuggestionImpl _value,
      $Res Function(_$WorkerSuggestionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? workerId = null,
    Object? workerName = null,
    Object? workerEmail = null,
    Object? score = null,
    Object? matchReason = null,
    Object? conflicts = null,
    Object? rating = null,
  }) {
    return _then(_$WorkerSuggestionImpl(
      workerId: null == workerId
          ? _value.workerId
          : workerId // ignore: cast_nullable_to_non_nullable
              as String,
      workerName: null == workerName
          ? _value.workerName
          : workerName // ignore: cast_nullable_to_non_nullable
              as String,
      workerEmail: null == workerEmail
          ? _value.workerEmail
          : workerEmail // ignore: cast_nullable_to_non_nullable
              as String,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as double,
      matchReason: null == matchReason
          ? _value.matchReason
          : matchReason // ignore: cast_nullable_to_non_nullable
              as String,
      conflicts: null == conflicts
          ? _value._conflicts
          : conflicts // ignore: cast_nullable_to_non_nullable
              as List<String>,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WorkerSuggestionImpl implements _WorkerSuggestion {
  const _$WorkerSuggestionImpl(
      {required this.workerId,
      required this.workerName,
      required this.workerEmail,
      required this.score,
      required this.matchReason,
      required final List<String> conflicts,
      required this.rating})
      : _conflicts = conflicts;

  factory _$WorkerSuggestionImpl.fromJson(Map<String, dynamic> json) =>
      _$$WorkerSuggestionImplFromJson(json);

  @override
  final String workerId;
  @override
  final String workerName;
  @override
  final String workerEmail;
  @override
  final double score;
  @override
  final String matchReason;
  final List<String> _conflicts;
  @override
  List<String> get conflicts {
    if (_conflicts is EqualUnmodifiableListView) return _conflicts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_conflicts);
  }

  @override
  final double rating;

  @override
  String toString() {
    return 'WorkerSuggestion(workerId: $workerId, workerName: $workerName, workerEmail: $workerEmail, score: $score, matchReason: $matchReason, conflicts: $conflicts, rating: $rating)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkerSuggestionImpl &&
            (identical(other.workerId, workerId) ||
                other.workerId == workerId) &&
            (identical(other.workerName, workerName) ||
                other.workerName == workerName) &&
            (identical(other.workerEmail, workerEmail) ||
                other.workerEmail == workerEmail) &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.matchReason, matchReason) ||
                other.matchReason == matchReason) &&
            const DeepCollectionEquality()
                .equals(other._conflicts, _conflicts) &&
            (identical(other.rating, rating) || other.rating == rating));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      workerId,
      workerName,
      workerEmail,
      score,
      matchReason,
      const DeepCollectionEquality().hash(_conflicts),
      rating);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkerSuggestionImplCopyWith<_$WorkerSuggestionImpl> get copyWith =>
      __$$WorkerSuggestionImplCopyWithImpl<_$WorkerSuggestionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WorkerSuggestionImplToJson(
      this,
    );
  }
}

abstract class _WorkerSuggestion implements WorkerSuggestion {
  const factory _WorkerSuggestion(
      {required final String workerId,
      required final String workerName,
      required final String workerEmail,
      required final double score,
      required final String matchReason,
      required final List<String> conflicts,
      required final double rating}) = _$WorkerSuggestionImpl;

  factory _WorkerSuggestion.fromJson(Map<String, dynamic> json) =
      _$WorkerSuggestionImpl.fromJson;

  @override
  String get workerId;
  @override
  String get workerName;
  @override
  String get workerEmail;
  @override
  double get score;
  @override
  String get matchReason;
  @override
  List<String> get conflicts;
  @override
  double get rating;
  @override
  @JsonKey(ignore: true)
  _$$WorkerSuggestionImplCopyWith<_$WorkerSuggestionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ShiftSuggestion _$ShiftSuggestionFromJson(Map<String, dynamic> json) {
  return _ShiftSuggestion.fromJson(json);
}

/// @nodoc
mixin _$ShiftSuggestion {
  String get shiftId => throw _privateConstructorUsedError;
  DateTime get shiftDate => throw _privateConstructorUsedError;
  String get shiftTime => throw _privateConstructorUsedError;
  String get service => throw _privateConstructorUsedError;
  List<WorkerSuggestion> get suggestedWorkers =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ShiftSuggestionCopyWith<ShiftSuggestion> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShiftSuggestionCopyWith<$Res> {
  factory $ShiftSuggestionCopyWith(
          ShiftSuggestion value, $Res Function(ShiftSuggestion) then) =
      _$ShiftSuggestionCopyWithImpl<$Res, ShiftSuggestion>;
  @useResult
  $Res call(
      {String shiftId,
      DateTime shiftDate,
      String shiftTime,
      String service,
      List<WorkerSuggestion> suggestedWorkers});
}

/// @nodoc
class _$ShiftSuggestionCopyWithImpl<$Res, $Val extends ShiftSuggestion>
    implements $ShiftSuggestionCopyWith<$Res> {
  _$ShiftSuggestionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? shiftId = null,
    Object? shiftDate = null,
    Object? shiftTime = null,
    Object? service = null,
    Object? suggestedWorkers = null,
  }) {
    return _then(_value.copyWith(
      shiftId: null == shiftId
          ? _value.shiftId
          : shiftId // ignore: cast_nullable_to_non_nullable
              as String,
      shiftDate: null == shiftDate
          ? _value.shiftDate
          : shiftDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      shiftTime: null == shiftTime
          ? _value.shiftTime
          : shiftTime // ignore: cast_nullable_to_non_nullable
              as String,
      service: null == service
          ? _value.service
          : service // ignore: cast_nullable_to_non_nullable
              as String,
      suggestedWorkers: null == suggestedWorkers
          ? _value.suggestedWorkers
          : suggestedWorkers // ignore: cast_nullable_to_non_nullable
              as List<WorkerSuggestion>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ShiftSuggestionImplCopyWith<$Res>
    implements $ShiftSuggestionCopyWith<$Res> {
  factory _$$ShiftSuggestionImplCopyWith(_$ShiftSuggestionImpl value,
          $Res Function(_$ShiftSuggestionImpl) then) =
      __$$ShiftSuggestionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String shiftId,
      DateTime shiftDate,
      String shiftTime,
      String service,
      List<WorkerSuggestion> suggestedWorkers});
}

/// @nodoc
class __$$ShiftSuggestionImplCopyWithImpl<$Res>
    extends _$ShiftSuggestionCopyWithImpl<$Res, _$ShiftSuggestionImpl>
    implements _$$ShiftSuggestionImplCopyWith<$Res> {
  __$$ShiftSuggestionImplCopyWithImpl(
      _$ShiftSuggestionImpl _value, $Res Function(_$ShiftSuggestionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? shiftId = null,
    Object? shiftDate = null,
    Object? shiftTime = null,
    Object? service = null,
    Object? suggestedWorkers = null,
  }) {
    return _then(_$ShiftSuggestionImpl(
      shiftId: null == shiftId
          ? _value.shiftId
          : shiftId // ignore: cast_nullable_to_non_nullable
              as String,
      shiftDate: null == shiftDate
          ? _value.shiftDate
          : shiftDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      shiftTime: null == shiftTime
          ? _value.shiftTime
          : shiftTime // ignore: cast_nullable_to_non_nullable
              as String,
      service: null == service
          ? _value.service
          : service // ignore: cast_nullable_to_non_nullable
              as String,
      suggestedWorkers: null == suggestedWorkers
          ? _value._suggestedWorkers
          : suggestedWorkers // ignore: cast_nullable_to_non_nullable
              as List<WorkerSuggestion>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ShiftSuggestionImpl implements _ShiftSuggestion {
  const _$ShiftSuggestionImpl(
      {required this.shiftId,
      required this.shiftDate,
      required this.shiftTime,
      required this.service,
      required final List<WorkerSuggestion> suggestedWorkers})
      : _suggestedWorkers = suggestedWorkers;

  factory _$ShiftSuggestionImpl.fromJson(Map<String, dynamic> json) =>
      _$$ShiftSuggestionImplFromJson(json);

  @override
  final String shiftId;
  @override
  final DateTime shiftDate;
  @override
  final String shiftTime;
  @override
  final String service;
  final List<WorkerSuggestion> _suggestedWorkers;
  @override
  List<WorkerSuggestion> get suggestedWorkers {
    if (_suggestedWorkers is EqualUnmodifiableListView)
      return _suggestedWorkers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_suggestedWorkers);
  }

  @override
  String toString() {
    return 'ShiftSuggestion(shiftId: $shiftId, shiftDate: $shiftDate, shiftTime: $shiftTime, service: $service, suggestedWorkers: $suggestedWorkers)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShiftSuggestionImpl &&
            (identical(other.shiftId, shiftId) || other.shiftId == shiftId) &&
            (identical(other.shiftDate, shiftDate) ||
                other.shiftDate == shiftDate) &&
            (identical(other.shiftTime, shiftTime) ||
                other.shiftTime == shiftTime) &&
            (identical(other.service, service) || other.service == service) &&
            const DeepCollectionEquality()
                .equals(other._suggestedWorkers, _suggestedWorkers));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, shiftId, shiftDate, shiftTime,
      service, const DeepCollectionEquality().hash(_suggestedWorkers));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ShiftSuggestionImplCopyWith<_$ShiftSuggestionImpl> get copyWith =>
      __$$ShiftSuggestionImplCopyWithImpl<_$ShiftSuggestionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ShiftSuggestionImplToJson(
      this,
    );
  }
}

abstract class _ShiftSuggestion implements ShiftSuggestion {
  const factory _ShiftSuggestion(
          {required final String shiftId,
          required final DateTime shiftDate,
          required final String shiftTime,
          required final String service,
          required final List<WorkerSuggestion> suggestedWorkers}) =
      _$ShiftSuggestionImpl;

  factory _ShiftSuggestion.fromJson(Map<String, dynamic> json) =
      _$ShiftSuggestionImpl.fromJson;

  @override
  String get shiftId;
  @override
  DateTime get shiftDate;
  @override
  String get shiftTime;
  @override
  String get service;
  @override
  List<WorkerSuggestion> get suggestedWorkers;
  @override
  @JsonKey(ignore: true)
  _$$ShiftSuggestionImplCopyWith<_$ShiftSuggestionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AssignmentResult _$AssignmentResultFromJson(Map<String, dynamic> json) {
  return _AssignmentResult.fromJson(json);
}

/// @nodoc
mixin _$AssignmentResult {
  String get shiftId => throw _privateConstructorUsedError;
  String get workerId => throw _privateConstructorUsedError;
  String? get workerName => throw _privateConstructorUsedError;
  String? get reason => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AssignmentResultCopyWith<AssignmentResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AssignmentResultCopyWith<$Res> {
  factory $AssignmentResultCopyWith(
          AssignmentResult value, $Res Function(AssignmentResult) then) =
      _$AssignmentResultCopyWithImpl<$Res, AssignmentResult>;
  @useResult
  $Res call(
      {String shiftId, String workerId, String? workerName, String? reason});
}

/// @nodoc
class _$AssignmentResultCopyWithImpl<$Res, $Val extends AssignmentResult>
    implements $AssignmentResultCopyWith<$Res> {
  _$AssignmentResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? shiftId = null,
    Object? workerId = null,
    Object? workerName = freezed,
    Object? reason = freezed,
  }) {
    return _then(_value.copyWith(
      shiftId: null == shiftId
          ? _value.shiftId
          : shiftId // ignore: cast_nullable_to_non_nullable
              as String,
      workerId: null == workerId
          ? _value.workerId
          : workerId // ignore: cast_nullable_to_non_nullable
              as String,
      workerName: freezed == workerName
          ? _value.workerName
          : workerName // ignore: cast_nullable_to_non_nullable
              as String?,
      reason: freezed == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AssignmentResultImplCopyWith<$Res>
    implements $AssignmentResultCopyWith<$Res> {
  factory _$$AssignmentResultImplCopyWith(_$AssignmentResultImpl value,
          $Res Function(_$AssignmentResultImpl) then) =
      __$$AssignmentResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String shiftId, String workerId, String? workerName, String? reason});
}

/// @nodoc
class __$$AssignmentResultImplCopyWithImpl<$Res>
    extends _$AssignmentResultCopyWithImpl<$Res, _$AssignmentResultImpl>
    implements _$$AssignmentResultImplCopyWith<$Res> {
  __$$AssignmentResultImplCopyWithImpl(_$AssignmentResultImpl _value,
      $Res Function(_$AssignmentResultImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? shiftId = null,
    Object? workerId = null,
    Object? workerName = freezed,
    Object? reason = freezed,
  }) {
    return _then(_$AssignmentResultImpl(
      shiftId: null == shiftId
          ? _value.shiftId
          : shiftId // ignore: cast_nullable_to_non_nullable
              as String,
      workerId: null == workerId
          ? _value.workerId
          : workerId // ignore: cast_nullable_to_non_nullable
              as String,
      workerName: freezed == workerName
          ? _value.workerName
          : workerName // ignore: cast_nullable_to_non_nullable
              as String?,
      reason: freezed == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AssignmentResultImpl implements _AssignmentResult {
  const _$AssignmentResultImpl(
      {required this.shiftId,
      required this.workerId,
      this.workerName,
      this.reason});

  factory _$AssignmentResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$AssignmentResultImplFromJson(json);

  @override
  final String shiftId;
  @override
  final String workerId;
  @override
  final String? workerName;
  @override
  final String? reason;

  @override
  String toString() {
    return 'AssignmentResult(shiftId: $shiftId, workerId: $workerId, workerName: $workerName, reason: $reason)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AssignmentResultImpl &&
            (identical(other.shiftId, shiftId) || other.shiftId == shiftId) &&
            (identical(other.workerId, workerId) ||
                other.workerId == workerId) &&
            (identical(other.workerName, workerName) ||
                other.workerName == workerName) &&
            (identical(other.reason, reason) || other.reason == reason));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, shiftId, workerId, workerName, reason);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AssignmentResultImplCopyWith<_$AssignmentResultImpl> get copyWith =>
      __$$AssignmentResultImplCopyWithImpl<_$AssignmentResultImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AssignmentResultImplToJson(
      this,
    );
  }
}

abstract class _AssignmentResult implements AssignmentResult {
  const factory _AssignmentResult(
      {required final String shiftId,
      required final String workerId,
      final String? workerName,
      final String? reason}) = _$AssignmentResultImpl;

  factory _AssignmentResult.fromJson(Map<String, dynamic> json) =
      _$AssignmentResultImpl.fromJson;

  @override
  String get shiftId;
  @override
  String get workerId;
  @override
  String? get workerName;
  @override
  String? get reason;
  @override
  @JsonKey(ignore: true)
  _$$AssignmentResultImplCopyWith<_$AssignmentResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BulkAssignmentResult _$BulkAssignmentResultFromJson(Map<String, dynamic> json) {
  return _BulkAssignmentResult.fromJson(json);
}

/// @nodoc
mixin _$BulkAssignmentResult {
  int get successfulCount => throw _privateConstructorUsedError;
  int get failedCount => throw _privateConstructorUsedError;
  List<AssignmentResult> get successful => throw _privateConstructorUsedError;
  List<AssignmentResult> get failed => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BulkAssignmentResultCopyWith<BulkAssignmentResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BulkAssignmentResultCopyWith<$Res> {
  factory $BulkAssignmentResultCopyWith(BulkAssignmentResult value,
          $Res Function(BulkAssignmentResult) then) =
      _$BulkAssignmentResultCopyWithImpl<$Res, BulkAssignmentResult>;
  @useResult
  $Res call(
      {int successfulCount,
      int failedCount,
      List<AssignmentResult> successful,
      List<AssignmentResult> failed});
}

/// @nodoc
class _$BulkAssignmentResultCopyWithImpl<$Res,
        $Val extends BulkAssignmentResult>
    implements $BulkAssignmentResultCopyWith<$Res> {
  _$BulkAssignmentResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? successfulCount = null,
    Object? failedCount = null,
    Object? successful = null,
    Object? failed = null,
  }) {
    return _then(_value.copyWith(
      successfulCount: null == successfulCount
          ? _value.successfulCount
          : successfulCount // ignore: cast_nullable_to_non_nullable
              as int,
      failedCount: null == failedCount
          ? _value.failedCount
          : failedCount // ignore: cast_nullable_to_non_nullable
              as int,
      successful: null == successful
          ? _value.successful
          : successful // ignore: cast_nullable_to_non_nullable
              as List<AssignmentResult>,
      failed: null == failed
          ? _value.failed
          : failed // ignore: cast_nullable_to_non_nullable
              as List<AssignmentResult>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BulkAssignmentResultImplCopyWith<$Res>
    implements $BulkAssignmentResultCopyWith<$Res> {
  factory _$$BulkAssignmentResultImplCopyWith(_$BulkAssignmentResultImpl value,
          $Res Function(_$BulkAssignmentResultImpl) then) =
      __$$BulkAssignmentResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int successfulCount,
      int failedCount,
      List<AssignmentResult> successful,
      List<AssignmentResult> failed});
}

/// @nodoc
class __$$BulkAssignmentResultImplCopyWithImpl<$Res>
    extends _$BulkAssignmentResultCopyWithImpl<$Res, _$BulkAssignmentResultImpl>
    implements _$$BulkAssignmentResultImplCopyWith<$Res> {
  __$$BulkAssignmentResultImplCopyWithImpl(_$BulkAssignmentResultImpl _value,
      $Res Function(_$BulkAssignmentResultImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? successfulCount = null,
    Object? failedCount = null,
    Object? successful = null,
    Object? failed = null,
  }) {
    return _then(_$BulkAssignmentResultImpl(
      successfulCount: null == successfulCount
          ? _value.successfulCount
          : successfulCount // ignore: cast_nullable_to_non_nullable
              as int,
      failedCount: null == failedCount
          ? _value.failedCount
          : failedCount // ignore: cast_nullable_to_non_nullable
              as int,
      successful: null == successful
          ? _value._successful
          : successful // ignore: cast_nullable_to_non_nullable
              as List<AssignmentResult>,
      failed: null == failed
          ? _value._failed
          : failed // ignore: cast_nullable_to_non_nullable
              as List<AssignmentResult>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BulkAssignmentResultImpl implements _BulkAssignmentResult {
  const _$BulkAssignmentResultImpl(
      {required this.successfulCount,
      required this.failedCount,
      required final List<AssignmentResult> successful,
      required final List<AssignmentResult> failed})
      : _successful = successful,
        _failed = failed;

  factory _$BulkAssignmentResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$BulkAssignmentResultImplFromJson(json);

  @override
  final int successfulCount;
  @override
  final int failedCount;
  final List<AssignmentResult> _successful;
  @override
  List<AssignmentResult> get successful {
    if (_successful is EqualUnmodifiableListView) return _successful;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_successful);
  }

  final List<AssignmentResult> _failed;
  @override
  List<AssignmentResult> get failed {
    if (_failed is EqualUnmodifiableListView) return _failed;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_failed);
  }

  @override
  String toString() {
    return 'BulkAssignmentResult(successfulCount: $successfulCount, failedCount: $failedCount, successful: $successful, failed: $failed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BulkAssignmentResultImpl &&
            (identical(other.successfulCount, successfulCount) ||
                other.successfulCount == successfulCount) &&
            (identical(other.failedCount, failedCount) ||
                other.failedCount == failedCount) &&
            const DeepCollectionEquality()
                .equals(other._successful, _successful) &&
            const DeepCollectionEquality().equals(other._failed, _failed));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      successfulCount,
      failedCount,
      const DeepCollectionEquality().hash(_successful),
      const DeepCollectionEquality().hash(_failed));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BulkAssignmentResultImplCopyWith<_$BulkAssignmentResultImpl>
      get copyWith =>
          __$$BulkAssignmentResultImplCopyWithImpl<_$BulkAssignmentResultImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BulkAssignmentResultImplToJson(
      this,
    );
  }
}

abstract class _BulkAssignmentResult implements BulkAssignmentResult {
  const factory _BulkAssignmentResult(
          {required final int successfulCount,
          required final int failedCount,
          required final List<AssignmentResult> successful,
          required final List<AssignmentResult> failed}) =
      _$BulkAssignmentResultImpl;

  factory _BulkAssignmentResult.fromJson(Map<String, dynamic> json) =
      _$BulkAssignmentResultImpl.fromJson;

  @override
  int get successfulCount;
  @override
  int get failedCount;
  @override
  List<AssignmentResult> get successful;
  @override
  List<AssignmentResult> get failed;
  @override
  @JsonKey(ignore: true)
  _$$BulkAssignmentResultImplCopyWith<_$BulkAssignmentResultImpl>
      get copyWith => throw _privateConstructorUsedError;
}

MessageRecipient _$MessageRecipientFromJson(Map<String, dynamic> json) {
  return _MessageRecipient.fromJson(json);
}

/// @nodoc
mixin _$MessageRecipient {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get role => throw _privateConstructorUsedError;
  bool get selected => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MessageRecipientCopyWith<MessageRecipient> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageRecipientCopyWith<$Res> {
  factory $MessageRecipientCopyWith(
          MessageRecipient value, $Res Function(MessageRecipient) then) =
      _$MessageRecipientCopyWithImpl<$Res, MessageRecipient>;
  @useResult
  $Res call({String id, String name, String email, String role, bool selected});
}

/// @nodoc
class _$MessageRecipientCopyWithImpl<$Res, $Val extends MessageRecipient>
    implements $MessageRecipientCopyWith<$Res> {
  _$MessageRecipientCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? email = null,
    Object? role = null,
    Object? selected = null,
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
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      selected: null == selected
          ? _value.selected
          : selected // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MessageRecipientImplCopyWith<$Res>
    implements $MessageRecipientCopyWith<$Res> {
  factory _$$MessageRecipientImplCopyWith(_$MessageRecipientImpl value,
          $Res Function(_$MessageRecipientImpl) then) =
      __$$MessageRecipientImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, String email, String role, bool selected});
}

/// @nodoc
class __$$MessageRecipientImplCopyWithImpl<$Res>
    extends _$MessageRecipientCopyWithImpl<$Res, _$MessageRecipientImpl>
    implements _$$MessageRecipientImplCopyWith<$Res> {
  __$$MessageRecipientImplCopyWithImpl(_$MessageRecipientImpl _value,
      $Res Function(_$MessageRecipientImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? email = null,
    Object? role = null,
    Object? selected = null,
  }) {
    return _then(_$MessageRecipientImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      selected: null == selected
          ? _value.selected
          : selected // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MessageRecipientImpl implements _MessageRecipient {
  const _$MessageRecipientImpl(
      {required this.id,
      required this.name,
      required this.email,
      required this.role,
      required this.selected});

  factory _$MessageRecipientImpl.fromJson(Map<String, dynamic> json) =>
      _$$MessageRecipientImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String email;
  @override
  final String role;
  @override
  final bool selected;

  @override
  String toString() {
    return 'MessageRecipient(id: $id, name: $name, email: $email, role: $role, selected: $selected)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageRecipientImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.selected, selected) ||
                other.selected == selected));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, email, role, selected);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageRecipientImplCopyWith<_$MessageRecipientImpl> get copyWith =>
      __$$MessageRecipientImplCopyWithImpl<_$MessageRecipientImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MessageRecipientImplToJson(
      this,
    );
  }
}

abstract class _MessageRecipient implements MessageRecipient {
  const factory _MessageRecipient(
      {required final String id,
      required final String name,
      required final String email,
      required final String role,
      required final bool selected}) = _$MessageRecipientImpl;

  factory _MessageRecipient.fromJson(Map<String, dynamic> json) =
      _$MessageRecipientImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get email;
  @override
  String get role;
  @override
  bool get selected;
  @override
  @JsonKey(ignore: true)
  _$$MessageRecipientImplCopyWith<_$MessageRecipientImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MessageTemplate _$MessageTemplateFromJson(Map<String, dynamic> json) {
  return _MessageTemplate.fromJson(json);
}

/// @nodoc
mixin _$MessageTemplate {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get subject => throw _privateConstructorUsedError;
  String get body => throw _privateConstructorUsedError;
  List<String> get variables => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MessageTemplateCopyWith<MessageTemplate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageTemplateCopyWith<$Res> {
  factory $MessageTemplateCopyWith(
          MessageTemplate value, $Res Function(MessageTemplate) then) =
      _$MessageTemplateCopyWithImpl<$Res, MessageTemplate>;
  @useResult
  $Res call(
      {String id,
      String name,
      String subject,
      String body,
      List<String> variables});
}

/// @nodoc
class _$MessageTemplateCopyWithImpl<$Res, $Val extends MessageTemplate>
    implements $MessageTemplateCopyWith<$Res> {
  _$MessageTemplateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? subject = null,
    Object? body = null,
    Object? variables = null,
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
      subject: null == subject
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      variables: null == variables
          ? _value.variables
          : variables // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MessageTemplateImplCopyWith<$Res>
    implements $MessageTemplateCopyWith<$Res> {
  factory _$$MessageTemplateImplCopyWith(_$MessageTemplateImpl value,
          $Res Function(_$MessageTemplateImpl) then) =
      __$$MessageTemplateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String subject,
      String body,
      List<String> variables});
}

/// @nodoc
class __$$MessageTemplateImplCopyWithImpl<$Res>
    extends _$MessageTemplateCopyWithImpl<$Res, _$MessageTemplateImpl>
    implements _$$MessageTemplateImplCopyWith<$Res> {
  __$$MessageTemplateImplCopyWithImpl(
      _$MessageTemplateImpl _value, $Res Function(_$MessageTemplateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? subject = null,
    Object? body = null,
    Object? variables = null,
  }) {
    return _then(_$MessageTemplateImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      subject: null == subject
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      variables: null == variables
          ? _value._variables
          : variables // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MessageTemplateImpl implements _MessageTemplate {
  const _$MessageTemplateImpl(
      {required this.id,
      required this.name,
      required this.subject,
      required this.body,
      required final List<String> variables})
      : _variables = variables;

  factory _$MessageTemplateImpl.fromJson(Map<String, dynamic> json) =>
      _$$MessageTemplateImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String subject;
  @override
  final String body;
  final List<String> _variables;
  @override
  List<String> get variables {
    if (_variables is EqualUnmodifiableListView) return _variables;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_variables);
  }

  @override
  String toString() {
    return 'MessageTemplate(id: $id, name: $name, subject: $subject, body: $body, variables: $variables)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageTemplateImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.subject, subject) || other.subject == subject) &&
            (identical(other.body, body) || other.body == body) &&
            const DeepCollectionEquality()
                .equals(other._variables, _variables));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, subject, body,
      const DeepCollectionEquality().hash(_variables));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageTemplateImplCopyWith<_$MessageTemplateImpl> get copyWith =>
      __$$MessageTemplateImplCopyWithImpl<_$MessageTemplateImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MessageTemplateImplToJson(
      this,
    );
  }
}

abstract class _MessageTemplate implements MessageTemplate {
  const factory _MessageTemplate(
      {required final String id,
      required final String name,
      required final String subject,
      required final String body,
      required final List<String> variables}) = _$MessageTemplateImpl;

  factory _MessageTemplate.fromJson(Map<String, dynamic> json) =
      _$MessageTemplateImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get subject;
  @override
  String get body;
  @override
  List<String> get variables;
  @override
  @JsonKey(ignore: true)
  _$$MessageTemplateImplCopyWith<_$MessageTemplateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BulkMessage _$BulkMessageFromJson(Map<String, dynamic> json) {
  return _BulkMessage.fromJson(json);
}

/// @nodoc
mixin _$BulkMessage {
  List<String> get recipientIds => throw _privateConstructorUsedError;
  String get subject => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  List<MessageChannel> get channels => throw _privateConstructorUsedError;
  DateTime? get scheduledFor => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BulkMessageCopyWith<BulkMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BulkMessageCopyWith<$Res> {
  factory $BulkMessageCopyWith(
          BulkMessage value, $Res Function(BulkMessage) then) =
      _$BulkMessageCopyWithImpl<$Res, BulkMessage>;
  @useResult
  $Res call(
      {List<String> recipientIds,
      String subject,
      String message,
      List<MessageChannel> channels,
      DateTime? scheduledFor});
}

/// @nodoc
class _$BulkMessageCopyWithImpl<$Res, $Val extends BulkMessage>
    implements $BulkMessageCopyWith<$Res> {
  _$BulkMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? recipientIds = null,
    Object? subject = null,
    Object? message = null,
    Object? channels = null,
    Object? scheduledFor = freezed,
  }) {
    return _then(_value.copyWith(
      recipientIds: null == recipientIds
          ? _value.recipientIds
          : recipientIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      subject: null == subject
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      channels: null == channels
          ? _value.channels
          : channels // ignore: cast_nullable_to_non_nullable
              as List<MessageChannel>,
      scheduledFor: freezed == scheduledFor
          ? _value.scheduledFor
          : scheduledFor // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BulkMessageImplCopyWith<$Res>
    implements $BulkMessageCopyWith<$Res> {
  factory _$$BulkMessageImplCopyWith(
          _$BulkMessageImpl value, $Res Function(_$BulkMessageImpl) then) =
      __$$BulkMessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<String> recipientIds,
      String subject,
      String message,
      List<MessageChannel> channels,
      DateTime? scheduledFor});
}

/// @nodoc
class __$$BulkMessageImplCopyWithImpl<$Res>
    extends _$BulkMessageCopyWithImpl<$Res, _$BulkMessageImpl>
    implements _$$BulkMessageImplCopyWith<$Res> {
  __$$BulkMessageImplCopyWithImpl(
      _$BulkMessageImpl _value, $Res Function(_$BulkMessageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? recipientIds = null,
    Object? subject = null,
    Object? message = null,
    Object? channels = null,
    Object? scheduledFor = freezed,
  }) {
    return _then(_$BulkMessageImpl(
      recipientIds: null == recipientIds
          ? _value._recipientIds
          : recipientIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      subject: null == subject
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      channels: null == channels
          ? _value._channels
          : channels // ignore: cast_nullable_to_non_nullable
              as List<MessageChannel>,
      scheduledFor: freezed == scheduledFor
          ? _value.scheduledFor
          : scheduledFor // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BulkMessageImpl implements _BulkMessage {
  const _$BulkMessageImpl(
      {required final List<String> recipientIds,
      required this.subject,
      required this.message,
      required final List<MessageChannel> channels,
      this.scheduledFor})
      : _recipientIds = recipientIds,
        _channels = channels;

  factory _$BulkMessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$BulkMessageImplFromJson(json);

  final List<String> _recipientIds;
  @override
  List<String> get recipientIds {
    if (_recipientIds is EqualUnmodifiableListView) return _recipientIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recipientIds);
  }

  @override
  final String subject;
  @override
  final String message;
  final List<MessageChannel> _channels;
  @override
  List<MessageChannel> get channels {
    if (_channels is EqualUnmodifiableListView) return _channels;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_channels);
  }

  @override
  final DateTime? scheduledFor;

  @override
  String toString() {
    return 'BulkMessage(recipientIds: $recipientIds, subject: $subject, message: $message, channels: $channels, scheduledFor: $scheduledFor)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BulkMessageImpl &&
            const DeepCollectionEquality()
                .equals(other._recipientIds, _recipientIds) &&
            (identical(other.subject, subject) || other.subject == subject) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other._channels, _channels) &&
            (identical(other.scheduledFor, scheduledFor) ||
                other.scheduledFor == scheduledFor));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_recipientIds),
      subject,
      message,
      const DeepCollectionEquality().hash(_channels),
      scheduledFor);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BulkMessageImplCopyWith<_$BulkMessageImpl> get copyWith =>
      __$$BulkMessageImplCopyWithImpl<_$BulkMessageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BulkMessageImplToJson(
      this,
    );
  }
}

abstract class _BulkMessage implements BulkMessage {
  const factory _BulkMessage(
      {required final List<String> recipientIds,
      required final String subject,
      required final String message,
      required final List<MessageChannel> channels,
      final DateTime? scheduledFor}) = _$BulkMessageImpl;

  factory _BulkMessage.fromJson(Map<String, dynamic> json) =
      _$BulkMessageImpl.fromJson;

  @override
  List<String> get recipientIds;
  @override
  String get subject;
  @override
  String get message;
  @override
  List<MessageChannel> get channels;
  @override
  DateTime? get scheduledFor;
  @override
  @JsonKey(ignore: true)
  _$$BulkMessageImplCopyWith<_$BulkMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BulkMessageResult _$BulkMessageResultFromJson(Map<String, dynamic> json) {
  return _BulkMessageResult.fromJson(json);
}

/// @nodoc
mixin _$BulkMessageResult {
  int get sentCount => throw _privateConstructorUsedError;
  int get scheduledCount => throw _privateConstructorUsedError;
  int get totalRequested => throw _privateConstructorUsedError;
  DateTime? get scheduledFor => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BulkMessageResultCopyWith<BulkMessageResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BulkMessageResultCopyWith<$Res> {
  factory $BulkMessageResultCopyWith(
          BulkMessageResult value, $Res Function(BulkMessageResult) then) =
      _$BulkMessageResultCopyWithImpl<$Res, BulkMessageResult>;
  @useResult
  $Res call(
      {int sentCount,
      int scheduledCount,
      int totalRequested,
      DateTime? scheduledFor});
}

/// @nodoc
class _$BulkMessageResultCopyWithImpl<$Res, $Val extends BulkMessageResult>
    implements $BulkMessageResultCopyWith<$Res> {
  _$BulkMessageResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sentCount = null,
    Object? scheduledCount = null,
    Object? totalRequested = null,
    Object? scheduledFor = freezed,
  }) {
    return _then(_value.copyWith(
      sentCount: null == sentCount
          ? _value.sentCount
          : sentCount // ignore: cast_nullable_to_non_nullable
              as int,
      scheduledCount: null == scheduledCount
          ? _value.scheduledCount
          : scheduledCount // ignore: cast_nullable_to_non_nullable
              as int,
      totalRequested: null == totalRequested
          ? _value.totalRequested
          : totalRequested // ignore: cast_nullable_to_non_nullable
              as int,
      scheduledFor: freezed == scheduledFor
          ? _value.scheduledFor
          : scheduledFor // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BulkMessageResultImplCopyWith<$Res>
    implements $BulkMessageResultCopyWith<$Res> {
  factory _$$BulkMessageResultImplCopyWith(_$BulkMessageResultImpl value,
          $Res Function(_$BulkMessageResultImpl) then) =
      __$$BulkMessageResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int sentCount,
      int scheduledCount,
      int totalRequested,
      DateTime? scheduledFor});
}

/// @nodoc
class __$$BulkMessageResultImplCopyWithImpl<$Res>
    extends _$BulkMessageResultCopyWithImpl<$Res, _$BulkMessageResultImpl>
    implements _$$BulkMessageResultImplCopyWith<$Res> {
  __$$BulkMessageResultImplCopyWithImpl(_$BulkMessageResultImpl _value,
      $Res Function(_$BulkMessageResultImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sentCount = null,
    Object? scheduledCount = null,
    Object? totalRequested = null,
    Object? scheduledFor = freezed,
  }) {
    return _then(_$BulkMessageResultImpl(
      sentCount: null == sentCount
          ? _value.sentCount
          : sentCount // ignore: cast_nullable_to_non_nullable
              as int,
      scheduledCount: null == scheduledCount
          ? _value.scheduledCount
          : scheduledCount // ignore: cast_nullable_to_non_nullable
              as int,
      totalRequested: null == totalRequested
          ? _value.totalRequested
          : totalRequested // ignore: cast_nullable_to_non_nullable
              as int,
      scheduledFor: freezed == scheduledFor
          ? _value.scheduledFor
          : scheduledFor // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BulkMessageResultImpl implements _BulkMessageResult {
  const _$BulkMessageResultImpl(
      {required this.sentCount,
      required this.scheduledCount,
      required this.totalRequested,
      this.scheduledFor});

  factory _$BulkMessageResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$BulkMessageResultImplFromJson(json);

  @override
  final int sentCount;
  @override
  final int scheduledCount;
  @override
  final int totalRequested;
  @override
  final DateTime? scheduledFor;

  @override
  String toString() {
    return 'BulkMessageResult(sentCount: $sentCount, scheduledCount: $scheduledCount, totalRequested: $totalRequested, scheduledFor: $scheduledFor)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BulkMessageResultImpl &&
            (identical(other.sentCount, sentCount) ||
                other.sentCount == sentCount) &&
            (identical(other.scheduledCount, scheduledCount) ||
                other.scheduledCount == scheduledCount) &&
            (identical(other.totalRequested, totalRequested) ||
                other.totalRequested == totalRequested) &&
            (identical(other.scheduledFor, scheduledFor) ||
                other.scheduledFor == scheduledFor));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, sentCount, scheduledCount, totalRequested, scheduledFor);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BulkMessageResultImplCopyWith<_$BulkMessageResultImpl> get copyWith =>
      __$$BulkMessageResultImplCopyWithImpl<_$BulkMessageResultImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BulkMessageResultImplToJson(
      this,
    );
  }
}

abstract class _BulkMessageResult implements BulkMessageResult {
  const factory _BulkMessageResult(
      {required final int sentCount,
      required final int scheduledCount,
      required final int totalRequested,
      final DateTime? scheduledFor}) = _$BulkMessageResultImpl;

  factory _BulkMessageResult.fromJson(Map<String, dynamic> json) =
      _$BulkMessageResultImpl.fromJson;

  @override
  int get sentCount;
  @override
  int get scheduledCount;
  @override
  int get totalRequested;
  @override
  DateTime? get scheduledFor;
  @override
  @JsonKey(ignore: true)
  _$$BulkMessageResultImplCopyWith<_$BulkMessageResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
