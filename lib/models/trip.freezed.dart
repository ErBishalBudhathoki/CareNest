// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trip.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Trip _$TripFromJson(Map<String, dynamic> json) {
  return _Trip.fromJson(json);
}

/// @nodoc
mixin _$Trip {
  @JsonKey(name: '_id')
  String get id => throw _privateConstructorUsedError;
  String get organizationId => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String? get clientId => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  String get startLocation => throw _privateConstructorUsedError;
  String get endLocation => throw _privateConstructorUsedError;
  double get distance => throw _privateConstructorUsedError;
  String get tripType =>
      throw _privateConstructorUsedError; // 'BETWEEN_CLIENTS', 'WITH_CLIENT', 'COMMUTE'
  String get status =>
      throw _privateConstructorUsedError; // 'PENDING', 'APPROVED', 'REJECTED'
  String? get adminApprovalStatus => throw _privateConstructorUsedError;
  bool get isReimbursable => throw _privateConstructorUsedError;
  bool get isBillable => throw _privateConstructorUsedError; // Joined fields
  EmployeeInfo? get employee => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TripCopyWith<Trip> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TripCopyWith<$Res> {
  factory $TripCopyWith(Trip value, $Res Function(Trip) then) =
      _$TripCopyWithImpl<$Res, Trip>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String organizationId,
      String userId,
      String? clientId,
      DateTime date,
      String startLocation,
      String endLocation,
      double distance,
      String tripType,
      String status,
      String? adminApprovalStatus,
      bool isReimbursable,
      bool isBillable,
      EmployeeInfo? employee});

  $EmployeeInfoCopyWith<$Res>? get employee;
}

/// @nodoc
class _$TripCopyWithImpl<$Res, $Val extends Trip>
    implements $TripCopyWith<$Res> {
  _$TripCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? organizationId = null,
    Object? userId = null,
    Object? clientId = freezed,
    Object? date = null,
    Object? startLocation = null,
    Object? endLocation = null,
    Object? distance = null,
    Object? tripType = null,
    Object? status = null,
    Object? adminApprovalStatus = freezed,
    Object? isReimbursable = null,
    Object? isBillable = null,
    Object? employee = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      clientId: freezed == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String?,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      startLocation: null == startLocation
          ? _value.startLocation
          : startLocation // ignore: cast_nullable_to_non_nullable
              as String,
      endLocation: null == endLocation
          ? _value.endLocation
          : endLocation // ignore: cast_nullable_to_non_nullable
              as String,
      distance: null == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double,
      tripType: null == tripType
          ? _value.tripType
          : tripType // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      adminApprovalStatus: freezed == adminApprovalStatus
          ? _value.adminApprovalStatus
          : adminApprovalStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      isReimbursable: null == isReimbursable
          ? _value.isReimbursable
          : isReimbursable // ignore: cast_nullable_to_non_nullable
              as bool,
      isBillable: null == isBillable
          ? _value.isBillable
          : isBillable // ignore: cast_nullable_to_non_nullable
              as bool,
      employee: freezed == employee
          ? _value.employee
          : employee // ignore: cast_nullable_to_non_nullable
              as EmployeeInfo?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $EmployeeInfoCopyWith<$Res>? get employee {
    if (_value.employee == null) {
      return null;
    }

    return $EmployeeInfoCopyWith<$Res>(_value.employee!, (value) {
      return _then(_value.copyWith(employee: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TripImplCopyWith<$Res> implements $TripCopyWith<$Res> {
  factory _$$TripImplCopyWith(
          _$TripImpl value, $Res Function(_$TripImpl) then) =
      __$$TripImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String organizationId,
      String userId,
      String? clientId,
      DateTime date,
      String startLocation,
      String endLocation,
      double distance,
      String tripType,
      String status,
      String? adminApprovalStatus,
      bool isReimbursable,
      bool isBillable,
      EmployeeInfo? employee});

  @override
  $EmployeeInfoCopyWith<$Res>? get employee;
}

/// @nodoc
class __$$TripImplCopyWithImpl<$Res>
    extends _$TripCopyWithImpl<$Res, _$TripImpl>
    implements _$$TripImplCopyWith<$Res> {
  __$$TripImplCopyWithImpl(_$TripImpl _value, $Res Function(_$TripImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? organizationId = null,
    Object? userId = null,
    Object? clientId = freezed,
    Object? date = null,
    Object? startLocation = null,
    Object? endLocation = null,
    Object? distance = null,
    Object? tripType = null,
    Object? status = null,
    Object? adminApprovalStatus = freezed,
    Object? isReimbursable = null,
    Object? isBillable = null,
    Object? employee = freezed,
  }) {
    return _then(_$TripImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      clientId: freezed == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String?,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      startLocation: null == startLocation
          ? _value.startLocation
          : startLocation // ignore: cast_nullable_to_non_nullable
              as String,
      endLocation: null == endLocation
          ? _value.endLocation
          : endLocation // ignore: cast_nullable_to_non_nullable
              as String,
      distance: null == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double,
      tripType: null == tripType
          ? _value.tripType
          : tripType // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      adminApprovalStatus: freezed == adminApprovalStatus
          ? _value.adminApprovalStatus
          : adminApprovalStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      isReimbursable: null == isReimbursable
          ? _value.isReimbursable
          : isReimbursable // ignore: cast_nullable_to_non_nullable
              as bool,
      isBillable: null == isBillable
          ? _value.isBillable
          : isBillable // ignore: cast_nullable_to_non_nullable
              as bool,
      employee: freezed == employee
          ? _value.employee
          : employee // ignore: cast_nullable_to_non_nullable
              as EmployeeInfo?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TripImpl implements _Trip {
  const _$TripImpl(
      {@JsonKey(name: '_id') required this.id,
      required this.organizationId,
      required this.userId,
      this.clientId,
      required this.date,
      required this.startLocation,
      required this.endLocation,
      required this.distance,
      required this.tripType,
      required this.status,
      this.adminApprovalStatus,
      this.isReimbursable = false,
      this.isBillable = false,
      this.employee});

  factory _$TripImpl.fromJson(Map<String, dynamic> json) =>
      _$$TripImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String id;
  @override
  final String organizationId;
  @override
  final String userId;
  @override
  final String? clientId;
  @override
  final DateTime date;
  @override
  final String startLocation;
  @override
  final String endLocation;
  @override
  final double distance;
  @override
  final String tripType;
// 'BETWEEN_CLIENTS', 'WITH_CLIENT', 'COMMUTE'
  @override
  final String status;
// 'PENDING', 'APPROVED', 'REJECTED'
  @override
  final String? adminApprovalStatus;
  @override
  @JsonKey()
  final bool isReimbursable;
  @override
  @JsonKey()
  final bool isBillable;
// Joined fields
  @override
  final EmployeeInfo? employee;

  @override
  String toString() {
    return 'Trip(id: $id, organizationId: $organizationId, userId: $userId, clientId: $clientId, date: $date, startLocation: $startLocation, endLocation: $endLocation, distance: $distance, tripType: $tripType, status: $status, adminApprovalStatus: $adminApprovalStatus, isReimbursable: $isReimbursable, isBillable: $isBillable, employee: $employee)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TripImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.startLocation, startLocation) ||
                other.startLocation == startLocation) &&
            (identical(other.endLocation, endLocation) ||
                other.endLocation == endLocation) &&
            (identical(other.distance, distance) ||
                other.distance == distance) &&
            (identical(other.tripType, tripType) ||
                other.tripType == tripType) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.adminApprovalStatus, adminApprovalStatus) ||
                other.adminApprovalStatus == adminApprovalStatus) &&
            (identical(other.isReimbursable, isReimbursable) ||
                other.isReimbursable == isReimbursable) &&
            (identical(other.isBillable, isBillable) ||
                other.isBillable == isBillable) &&
            (identical(other.employee, employee) ||
                other.employee == employee));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      organizationId,
      userId,
      clientId,
      date,
      startLocation,
      endLocation,
      distance,
      tripType,
      status,
      adminApprovalStatus,
      isReimbursable,
      isBillable,
      employee);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TripImplCopyWith<_$TripImpl> get copyWith =>
      __$$TripImplCopyWithImpl<_$TripImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TripImplToJson(
      this,
    );
  }
}

abstract class _Trip implements Trip {
  const factory _Trip(
      {@JsonKey(name: '_id') required final String id,
      required final String organizationId,
      required final String userId,
      final String? clientId,
      required final DateTime date,
      required final String startLocation,
      required final String endLocation,
      required final double distance,
      required final String tripType,
      required final String status,
      final String? adminApprovalStatus,
      final bool isReimbursable,
      final bool isBillable,
      final EmployeeInfo? employee}) = _$TripImpl;

  factory _Trip.fromJson(Map<String, dynamic> json) = _$TripImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String get id;
  @override
  String get organizationId;
  @override
  String get userId;
  @override
  String? get clientId;
  @override
  DateTime get date;
  @override
  String get startLocation;
  @override
  String get endLocation;
  @override
  double get distance;
  @override
  String get tripType;
  @override // 'BETWEEN_CLIENTS', 'WITH_CLIENT', 'COMMUTE'
  String get status;
  @override // 'PENDING', 'APPROVED', 'REJECTED'
  String? get adminApprovalStatus;
  @override
  bool get isReimbursable;
  @override
  bool get isBillable;
  @override // Joined fields
  EmployeeInfo? get employee;
  @override
  @JsonKey(ignore: true)
  _$$TripImplCopyWith<_$TripImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EmployeeInfo _$EmployeeInfoFromJson(Map<String, dynamic> json) {
  return _EmployeeInfo.fromJson(json);
}

/// @nodoc
mixin _$EmployeeInfo {
  String? get firstName => throw _privateConstructorUsedError;
  String? get lastName => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EmployeeInfoCopyWith<EmployeeInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmployeeInfoCopyWith<$Res> {
  factory $EmployeeInfoCopyWith(
          EmployeeInfo value, $Res Function(EmployeeInfo) then) =
      _$EmployeeInfoCopyWithImpl<$Res, EmployeeInfo>;
  @useResult
  $Res call({String? firstName, String? lastName, String? email});
}

/// @nodoc
class _$EmployeeInfoCopyWithImpl<$Res, $Val extends EmployeeInfo>
    implements $EmployeeInfoCopyWith<$Res> {
  _$EmployeeInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? email = freezed,
  }) {
    return _then(_value.copyWith(
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EmployeeInfoImplCopyWith<$Res>
    implements $EmployeeInfoCopyWith<$Res> {
  factory _$$EmployeeInfoImplCopyWith(
          _$EmployeeInfoImpl value, $Res Function(_$EmployeeInfoImpl) then) =
      __$$EmployeeInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? firstName, String? lastName, String? email});
}

/// @nodoc
class __$$EmployeeInfoImplCopyWithImpl<$Res>
    extends _$EmployeeInfoCopyWithImpl<$Res, _$EmployeeInfoImpl>
    implements _$$EmployeeInfoImplCopyWith<$Res> {
  __$$EmployeeInfoImplCopyWithImpl(
      _$EmployeeInfoImpl _value, $Res Function(_$EmployeeInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? email = freezed,
  }) {
    return _then(_$EmployeeInfoImpl(
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EmployeeInfoImpl implements _EmployeeInfo {
  const _$EmployeeInfoImpl({this.firstName, this.lastName, this.email});

  factory _$EmployeeInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$EmployeeInfoImplFromJson(json);

  @override
  final String? firstName;
  @override
  final String? lastName;
  @override
  final String? email;

  @override
  String toString() {
    return 'EmployeeInfo(firstName: $firstName, lastName: $lastName, email: $email)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmployeeInfoImpl &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.email, email) || other.email == email));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, firstName, lastName, email);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EmployeeInfoImplCopyWith<_$EmployeeInfoImpl> get copyWith =>
      __$$EmployeeInfoImplCopyWithImpl<_$EmployeeInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EmployeeInfoImplToJson(
      this,
    );
  }
}

abstract class _EmployeeInfo implements EmployeeInfo {
  const factory _EmployeeInfo(
      {final String? firstName,
      final String? lastName,
      final String? email}) = _$EmployeeInfoImpl;

  factory _EmployeeInfo.fromJson(Map<String, dynamic> json) =
      _$EmployeeInfoImpl.fromJson;

  @override
  String? get firstName;
  @override
  String? get lastName;
  @override
  String? get email;
  @override
  @JsonKey(ignore: true)
  _$$EmployeeInfoImplCopyWith<_$EmployeeInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
