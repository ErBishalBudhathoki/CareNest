// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trip.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Trip {
  @JsonKey(name: '_id')
  String get id;
  String get organizationId;
  String get userId;
  String? get clientId;
  DateTime get date;
  String get startLocation;
  String get endLocation;
  double get distance;
  String get tripType; // 'BETWEEN_CLIENTS', 'WITH_CLIENT', 'COMMUTE'
  String get status; // 'PENDING', 'APPROVED', 'REJECTED'
  String? get adminApprovalStatus;
  bool get isReimbursable;
  bool get isBillable; // Joined fields
  EmployeeInfo? get employee;

  /// Create a copy of Trip
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TripCopyWith<Trip> get copyWith =>
      _$TripCopyWithImpl<Trip>(this as Trip, _$identity);

  /// Serializes this Trip to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Trip &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
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

  @override
  String toString() {
    return 'Trip(id: $id, organizationId: $organizationId, userId: $userId, clientId: $clientId, date: $date, startLocation: $startLocation, endLocation: $endLocation, distance: $distance, tripType: $tripType, status: $status, adminApprovalStatus: $adminApprovalStatus, isReimbursable: $isReimbursable, isBillable: $isBillable, employee: $employee)';
  }
}

/// @nodoc
abstract mixin class $TripCopyWith<$Res> {
  factory $TripCopyWith(Trip value, $Res Function(Trip) _then) =
      _$TripCopyWithImpl;
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
class _$TripCopyWithImpl<$Res> implements $TripCopyWith<$Res> {
  _$TripCopyWithImpl(this._self, this._then);

  final Trip _self;
  final $Res Function(Trip) _then;

  /// Create a copy of Trip
  /// with the given fields replaced by the non-null parameter values.
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
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: null == organizationId
          ? _self.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      clientId: freezed == clientId
          ? _self.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String?,
      date: null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      startLocation: null == startLocation
          ? _self.startLocation
          : startLocation // ignore: cast_nullable_to_non_nullable
              as String,
      endLocation: null == endLocation
          ? _self.endLocation
          : endLocation // ignore: cast_nullable_to_non_nullable
              as String,
      distance: null == distance
          ? _self.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double,
      tripType: null == tripType
          ? _self.tripType
          : tripType // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      adminApprovalStatus: freezed == adminApprovalStatus
          ? _self.adminApprovalStatus
          : adminApprovalStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      isReimbursable: null == isReimbursable
          ? _self.isReimbursable
          : isReimbursable // ignore: cast_nullable_to_non_nullable
              as bool,
      isBillable: null == isBillable
          ? _self.isBillable
          : isBillable // ignore: cast_nullable_to_non_nullable
              as bool,
      employee: freezed == employee
          ? _self.employee
          : employee // ignore: cast_nullable_to_non_nullable
              as EmployeeInfo?,
    ));
  }

  /// Create a copy of Trip
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $EmployeeInfoCopyWith<$Res>? get employee {
    if (_self.employee == null) {
      return null;
    }

    return $EmployeeInfoCopyWith<$Res>(_self.employee!, (value) {
      return _then(_self.copyWith(employee: value));
    });
  }
}

/// Adds pattern-matching-related methods to [Trip].
extension TripPatterns on Trip {
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
    TResult Function(_Trip value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Trip() when $default != null:
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
    TResult Function(_Trip value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Trip():
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
    TResult? Function(_Trip value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Trip() when $default != null:
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
            @JsonKey(name: '_id') String id,
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
            EmployeeInfo? employee)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Trip() when $default != null:
        return $default(
            _that.id,
            _that.organizationId,
            _that.userId,
            _that.clientId,
            _that.date,
            _that.startLocation,
            _that.endLocation,
            _that.distance,
            _that.tripType,
            _that.status,
            _that.adminApprovalStatus,
            _that.isReimbursable,
            _that.isBillable,
            _that.employee);
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
            @JsonKey(name: '_id') String id,
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
            EmployeeInfo? employee)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Trip():
        return $default(
            _that.id,
            _that.organizationId,
            _that.userId,
            _that.clientId,
            _that.date,
            _that.startLocation,
            _that.endLocation,
            _that.distance,
            _that.tripType,
            _that.status,
            _that.adminApprovalStatus,
            _that.isReimbursable,
            _that.isBillable,
            _that.employee);
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
            @JsonKey(name: '_id') String id,
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
            EmployeeInfo? employee)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Trip() when $default != null:
        return $default(
            _that.id,
            _that.organizationId,
            _that.userId,
            _that.clientId,
            _that.date,
            _that.startLocation,
            _that.endLocation,
            _that.distance,
            _that.tripType,
            _that.status,
            _that.adminApprovalStatus,
            _that.isReimbursable,
            _that.isBillable,
            _that.employee);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Trip implements Trip {
  const _Trip(
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
  factory _Trip.fromJson(Map<String, dynamic> json) => _$TripFromJson(json);

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

  /// Create a copy of Trip
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TripCopyWith<_Trip> get copyWith =>
      __$TripCopyWithImpl<_Trip>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TripToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Trip &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
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

  @override
  String toString() {
    return 'Trip(id: $id, organizationId: $organizationId, userId: $userId, clientId: $clientId, date: $date, startLocation: $startLocation, endLocation: $endLocation, distance: $distance, tripType: $tripType, status: $status, adminApprovalStatus: $adminApprovalStatus, isReimbursable: $isReimbursable, isBillable: $isBillable, employee: $employee)';
  }
}

/// @nodoc
abstract mixin class _$TripCopyWith<$Res> implements $TripCopyWith<$Res> {
  factory _$TripCopyWith(_Trip value, $Res Function(_Trip) _then) =
      __$TripCopyWithImpl;
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
class __$TripCopyWithImpl<$Res> implements _$TripCopyWith<$Res> {
  __$TripCopyWithImpl(this._self, this._then);

  final _Trip _self;
  final $Res Function(_Trip) _then;

  /// Create a copy of Trip
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
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
    return _then(_Trip(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: null == organizationId
          ? _self.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      clientId: freezed == clientId
          ? _self.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String?,
      date: null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      startLocation: null == startLocation
          ? _self.startLocation
          : startLocation // ignore: cast_nullable_to_non_nullable
              as String,
      endLocation: null == endLocation
          ? _self.endLocation
          : endLocation // ignore: cast_nullable_to_non_nullable
              as String,
      distance: null == distance
          ? _self.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double,
      tripType: null == tripType
          ? _self.tripType
          : tripType // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      adminApprovalStatus: freezed == adminApprovalStatus
          ? _self.adminApprovalStatus
          : adminApprovalStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      isReimbursable: null == isReimbursable
          ? _self.isReimbursable
          : isReimbursable // ignore: cast_nullable_to_non_nullable
              as bool,
      isBillable: null == isBillable
          ? _self.isBillable
          : isBillable // ignore: cast_nullable_to_non_nullable
              as bool,
      employee: freezed == employee
          ? _self.employee
          : employee // ignore: cast_nullable_to_non_nullable
              as EmployeeInfo?,
    ));
  }

  /// Create a copy of Trip
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $EmployeeInfoCopyWith<$Res>? get employee {
    if (_self.employee == null) {
      return null;
    }

    return $EmployeeInfoCopyWith<$Res>(_self.employee!, (value) {
      return _then(_self.copyWith(employee: value));
    });
  }
}

/// @nodoc
mixin _$EmployeeInfo {
  String? get firstName;
  String? get lastName;
  String? get email;

  /// Create a copy of EmployeeInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $EmployeeInfoCopyWith<EmployeeInfo> get copyWith =>
      _$EmployeeInfoCopyWithImpl<EmployeeInfo>(
          this as EmployeeInfo, _$identity);

  /// Serializes this EmployeeInfo to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is EmployeeInfo &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.email, email) || other.email == email));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, firstName, lastName, email);

  @override
  String toString() {
    return 'EmployeeInfo(firstName: $firstName, lastName: $lastName, email: $email)';
  }
}

/// @nodoc
abstract mixin class $EmployeeInfoCopyWith<$Res> {
  factory $EmployeeInfoCopyWith(
          EmployeeInfo value, $Res Function(EmployeeInfo) _then) =
      _$EmployeeInfoCopyWithImpl;
  @useResult
  $Res call({String? firstName, String? lastName, String? email});
}

/// @nodoc
class _$EmployeeInfoCopyWithImpl<$Res> implements $EmployeeInfoCopyWith<$Res> {
  _$EmployeeInfoCopyWithImpl(this._self, this._then);

  final EmployeeInfo _self;
  final $Res Function(EmployeeInfo) _then;

  /// Create a copy of EmployeeInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? email = freezed,
  }) {
    return _then(_self.copyWith(
      firstName: freezed == firstName
          ? _self.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _self.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [EmployeeInfo].
extension EmployeeInfoPatterns on EmployeeInfo {
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
    TResult Function(_EmployeeInfo value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _EmployeeInfo() when $default != null:
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
    TResult Function(_EmployeeInfo value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EmployeeInfo():
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
    TResult? Function(_EmployeeInfo value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EmployeeInfo() when $default != null:
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
    TResult Function(String? firstName, String? lastName, String? email)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _EmployeeInfo() when $default != null:
        return $default(_that.firstName, _that.lastName, _that.email);
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
    TResult Function(String? firstName, String? lastName, String? email)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EmployeeInfo():
        return $default(_that.firstName, _that.lastName, _that.email);
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
    TResult? Function(String? firstName, String? lastName, String? email)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EmployeeInfo() when $default != null:
        return $default(_that.firstName, _that.lastName, _that.email);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _EmployeeInfo implements EmployeeInfo {
  const _EmployeeInfo({this.firstName, this.lastName, this.email});
  factory _EmployeeInfo.fromJson(Map<String, dynamic> json) =>
      _$EmployeeInfoFromJson(json);

  @override
  final String? firstName;
  @override
  final String? lastName;
  @override
  final String? email;

  /// Create a copy of EmployeeInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$EmployeeInfoCopyWith<_EmployeeInfo> get copyWith =>
      __$EmployeeInfoCopyWithImpl<_EmployeeInfo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$EmployeeInfoToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _EmployeeInfo &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.email, email) || other.email == email));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, firstName, lastName, email);

  @override
  String toString() {
    return 'EmployeeInfo(firstName: $firstName, lastName: $lastName, email: $email)';
  }
}

/// @nodoc
abstract mixin class _$EmployeeInfoCopyWith<$Res>
    implements $EmployeeInfoCopyWith<$Res> {
  factory _$EmployeeInfoCopyWith(
          _EmployeeInfo value, $Res Function(_EmployeeInfo) _then) =
      __$EmployeeInfoCopyWithImpl;
  @override
  @useResult
  $Res call({String? firstName, String? lastName, String? email});
}

/// @nodoc
class __$EmployeeInfoCopyWithImpl<$Res>
    implements _$EmployeeInfoCopyWith<$Res> {
  __$EmployeeInfoCopyWithImpl(this._self, this._then);

  final _EmployeeInfo _self;
  final $Res Function(_EmployeeInfo) _then;

  /// Create a copy of EmployeeInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? email = freezed,
  }) {
    return _then(_EmployeeInfo(
      firstName: freezed == firstName
          ? _self.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _self.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
