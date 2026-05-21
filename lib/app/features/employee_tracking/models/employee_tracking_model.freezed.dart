// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'employee_tracking_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EmployeeTrackingData {
  List<EmployeeStatus> get employees;
  List<ShiftDetail> get shifts;
  List<ClientAssignment> get assignments;
  int get totalEmployees;
  int get activeEmployees;
  int get onBreakEmployees;
  int get offlineEmployees;

  /// Create a copy of EmployeeTrackingData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $EmployeeTrackingDataCopyWith<EmployeeTrackingData> get copyWith =>
      _$EmployeeTrackingDataCopyWithImpl<EmployeeTrackingData>(
          this as EmployeeTrackingData, _$identity);

  /// Serializes this EmployeeTrackingData to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is EmployeeTrackingData &&
            const DeepCollectionEquality().equals(other.employees, employees) &&
            const DeepCollectionEquality().equals(other.shifts, shifts) &&
            const DeepCollectionEquality()
                .equals(other.assignments, assignments) &&
            (identical(other.totalEmployees, totalEmployees) ||
                other.totalEmployees == totalEmployees) &&
            (identical(other.activeEmployees, activeEmployees) ||
                other.activeEmployees == activeEmployees) &&
            (identical(other.onBreakEmployees, onBreakEmployees) ||
                other.onBreakEmployees == onBreakEmployees) &&
            (identical(other.offlineEmployees, offlineEmployees) ||
                other.offlineEmployees == offlineEmployees));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(employees),
      const DeepCollectionEquality().hash(shifts),
      const DeepCollectionEquality().hash(assignments),
      totalEmployees,
      activeEmployees,
      onBreakEmployees,
      offlineEmployees);

  @override
  String toString() {
    return 'EmployeeTrackingData(employees: $employees, shifts: $shifts, assignments: $assignments, totalEmployees: $totalEmployees, activeEmployees: $activeEmployees, onBreakEmployees: $onBreakEmployees, offlineEmployees: $offlineEmployees)';
  }
}

/// @nodoc
abstract mixin class $EmployeeTrackingDataCopyWith<$Res> {
  factory $EmployeeTrackingDataCopyWith(EmployeeTrackingData value,
          $Res Function(EmployeeTrackingData) _then) =
      _$EmployeeTrackingDataCopyWithImpl;
  @useResult
  $Res call(
      {List<EmployeeStatus> employees,
      List<ShiftDetail> shifts,
      List<ClientAssignment> assignments,
      int totalEmployees,
      int activeEmployees,
      int onBreakEmployees,
      int offlineEmployees});
}

/// @nodoc
class _$EmployeeTrackingDataCopyWithImpl<$Res>
    implements $EmployeeTrackingDataCopyWith<$Res> {
  _$EmployeeTrackingDataCopyWithImpl(this._self, this._then);

  final EmployeeTrackingData _self;
  final $Res Function(EmployeeTrackingData) _then;

  /// Create a copy of EmployeeTrackingData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? employees = null,
    Object? shifts = null,
    Object? assignments = null,
    Object? totalEmployees = null,
    Object? activeEmployees = null,
    Object? onBreakEmployees = null,
    Object? offlineEmployees = null,
  }) {
    return _then(_self.copyWith(
      employees: null == employees
          ? _self.employees
          : employees // ignore: cast_nullable_to_non_nullable
              as List<EmployeeStatus>,
      shifts: null == shifts
          ? _self.shifts
          : shifts // ignore: cast_nullable_to_non_nullable
              as List<ShiftDetail>,
      assignments: null == assignments
          ? _self.assignments
          : assignments // ignore: cast_nullable_to_non_nullable
              as List<ClientAssignment>,
      totalEmployees: null == totalEmployees
          ? _self.totalEmployees
          : totalEmployees // ignore: cast_nullable_to_non_nullable
              as int,
      activeEmployees: null == activeEmployees
          ? _self.activeEmployees
          : activeEmployees // ignore: cast_nullable_to_non_nullable
              as int,
      onBreakEmployees: null == onBreakEmployees
          ? _self.onBreakEmployees
          : onBreakEmployees // ignore: cast_nullable_to_non_nullable
              as int,
      offlineEmployees: null == offlineEmployees
          ? _self.offlineEmployees
          : offlineEmployees // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [EmployeeTrackingData].
extension EmployeeTrackingDataPatterns on EmployeeTrackingData {
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
    TResult Function(_EmployeeTrackingData value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _EmployeeTrackingData() when $default != null:
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
    TResult Function(_EmployeeTrackingData value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EmployeeTrackingData():
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
    TResult? Function(_EmployeeTrackingData value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EmployeeTrackingData() when $default != null:
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
            List<EmployeeStatus> employees,
            List<ShiftDetail> shifts,
            List<ClientAssignment> assignments,
            int totalEmployees,
            int activeEmployees,
            int onBreakEmployees,
            int offlineEmployees)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _EmployeeTrackingData() when $default != null:
        return $default(
            _that.employees,
            _that.shifts,
            _that.assignments,
            _that.totalEmployees,
            _that.activeEmployees,
            _that.onBreakEmployees,
            _that.offlineEmployees);
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
            List<EmployeeStatus> employees,
            List<ShiftDetail> shifts,
            List<ClientAssignment> assignments,
            int totalEmployees,
            int activeEmployees,
            int onBreakEmployees,
            int offlineEmployees)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EmployeeTrackingData():
        return $default(
            _that.employees,
            _that.shifts,
            _that.assignments,
            _that.totalEmployees,
            _that.activeEmployees,
            _that.onBreakEmployees,
            _that.offlineEmployees);
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
            List<EmployeeStatus> employees,
            List<ShiftDetail> shifts,
            List<ClientAssignment> assignments,
            int totalEmployees,
            int activeEmployees,
            int onBreakEmployees,
            int offlineEmployees)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EmployeeTrackingData() when $default != null:
        return $default(
            _that.employees,
            _that.shifts,
            _that.assignments,
            _that.totalEmployees,
            _that.activeEmployees,
            _that.onBreakEmployees,
            _that.offlineEmployees);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _EmployeeTrackingData implements EmployeeTrackingData {
  const _EmployeeTrackingData(
      {final List<EmployeeStatus> employees = const [],
      final List<ShiftDetail> shifts = const [],
      final List<ClientAssignment> assignments = const [],
      this.totalEmployees = 0,
      this.activeEmployees = 0,
      this.onBreakEmployees = 0,
      this.offlineEmployees = 0})
      : _employees = employees,
        _shifts = shifts,
        _assignments = assignments;
  factory _EmployeeTrackingData.fromJson(Map<String, dynamic> json) =>
      _$EmployeeTrackingDataFromJson(json);

  final List<EmployeeStatus> _employees;
  @override
  @JsonKey()
  List<EmployeeStatus> get employees {
    if (_employees is EqualUnmodifiableListView) return _employees;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_employees);
  }

  final List<ShiftDetail> _shifts;
  @override
  @JsonKey()
  List<ShiftDetail> get shifts {
    if (_shifts is EqualUnmodifiableListView) return _shifts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_shifts);
  }

  final List<ClientAssignment> _assignments;
  @override
  @JsonKey()
  List<ClientAssignment> get assignments {
    if (_assignments is EqualUnmodifiableListView) return _assignments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_assignments);
  }

  @override
  @JsonKey()
  final int totalEmployees;
  @override
  @JsonKey()
  final int activeEmployees;
  @override
  @JsonKey()
  final int onBreakEmployees;
  @override
  @JsonKey()
  final int offlineEmployees;

  /// Create a copy of EmployeeTrackingData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$EmployeeTrackingDataCopyWith<_EmployeeTrackingData> get copyWith =>
      __$EmployeeTrackingDataCopyWithImpl<_EmployeeTrackingData>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$EmployeeTrackingDataToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _EmployeeTrackingData &&
            const DeepCollectionEquality()
                .equals(other._employees, _employees) &&
            const DeepCollectionEquality().equals(other._shifts, _shifts) &&
            const DeepCollectionEquality()
                .equals(other._assignments, _assignments) &&
            (identical(other.totalEmployees, totalEmployees) ||
                other.totalEmployees == totalEmployees) &&
            (identical(other.activeEmployees, activeEmployees) ||
                other.activeEmployees == activeEmployees) &&
            (identical(other.onBreakEmployees, onBreakEmployees) ||
                other.onBreakEmployees == onBreakEmployees) &&
            (identical(other.offlineEmployees, offlineEmployees) ||
                other.offlineEmployees == offlineEmployees));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_employees),
      const DeepCollectionEquality().hash(_shifts),
      const DeepCollectionEquality().hash(_assignments),
      totalEmployees,
      activeEmployees,
      onBreakEmployees,
      offlineEmployees);

  @override
  String toString() {
    return 'EmployeeTrackingData(employees: $employees, shifts: $shifts, assignments: $assignments, totalEmployees: $totalEmployees, activeEmployees: $activeEmployees, onBreakEmployees: $onBreakEmployees, offlineEmployees: $offlineEmployees)';
  }
}

/// @nodoc
abstract mixin class _$EmployeeTrackingDataCopyWith<$Res>
    implements $EmployeeTrackingDataCopyWith<$Res> {
  factory _$EmployeeTrackingDataCopyWith(_EmployeeTrackingData value,
          $Res Function(_EmployeeTrackingData) _then) =
      __$EmployeeTrackingDataCopyWithImpl;
  @override
  @useResult
  $Res call(
      {List<EmployeeStatus> employees,
      List<ShiftDetail> shifts,
      List<ClientAssignment> assignments,
      int totalEmployees,
      int activeEmployees,
      int onBreakEmployees,
      int offlineEmployees});
}

/// @nodoc
class __$EmployeeTrackingDataCopyWithImpl<$Res>
    implements _$EmployeeTrackingDataCopyWith<$Res> {
  __$EmployeeTrackingDataCopyWithImpl(this._self, this._then);

  final _EmployeeTrackingData _self;
  final $Res Function(_EmployeeTrackingData) _then;

  /// Create a copy of EmployeeTrackingData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? employees = null,
    Object? shifts = null,
    Object? assignments = null,
    Object? totalEmployees = null,
    Object? activeEmployees = null,
    Object? onBreakEmployees = null,
    Object? offlineEmployees = null,
  }) {
    return _then(_EmployeeTrackingData(
      employees: null == employees
          ? _self._employees
          : employees // ignore: cast_nullable_to_non_nullable
              as List<EmployeeStatus>,
      shifts: null == shifts
          ? _self._shifts
          : shifts // ignore: cast_nullable_to_non_nullable
              as List<ShiftDetail>,
      assignments: null == assignments
          ? _self._assignments
          : assignments // ignore: cast_nullable_to_non_nullable
              as List<ClientAssignment>,
      totalEmployees: null == totalEmployees
          ? _self.totalEmployees
          : totalEmployees // ignore: cast_nullable_to_non_nullable
              as int,
      activeEmployees: null == activeEmployees
          ? _self.activeEmployees
          : activeEmployees // ignore: cast_nullable_to_non_nullable
              as int,
      onBreakEmployees: null == onBreakEmployees
          ? _self.onBreakEmployees
          : onBreakEmployees // ignore: cast_nullable_to_non_nullable
              as int,
      offlineEmployees: null == offlineEmployees
          ? _self.offlineEmployees
          : offlineEmployees // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$EmployeeStatus {
  String get id;
  String get name;
  String get email;
  WorkStatus get status;
  String? get profileImage;
  String? get filename;
  @JsonKey(includeFromJson: false, includeToJson: false)
  Uint8List? get photoData;
  String? get currentLocation;
  DateTime? get lastSeen;
  String? get currentShiftId;
  String? get assignedClientId;
  double? get liveLatitude;
  double? get liveLongitude;
  double? get liveAccuracy;
  DateTime? get liveUpdatedAt;
  String? get liveAppointmentId;
  String? get liveClientName;
  double? get liveDistanceMeters;
  double? get liveGeofenceRadiusMeters;
  bool? get liveInsideGeofence;
  double get hoursWorked;
  bool get isOnBreak;

  /// Create a copy of EmployeeStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $EmployeeStatusCopyWith<EmployeeStatus> get copyWith =>
      _$EmployeeStatusCopyWithImpl<EmployeeStatus>(
          this as EmployeeStatus, _$identity);

  /// Serializes this EmployeeStatus to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is EmployeeStatus &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.profileImage, profileImage) ||
                other.profileImage == profileImage) &&
            (identical(other.filename, filename) ||
                other.filename == filename) &&
            const DeepCollectionEquality().equals(other.photoData, photoData) &&
            (identical(other.currentLocation, currentLocation) ||
                other.currentLocation == currentLocation) &&
            (identical(other.lastSeen, lastSeen) ||
                other.lastSeen == lastSeen) &&
            (identical(other.currentShiftId, currentShiftId) ||
                other.currentShiftId == currentShiftId) &&
            (identical(other.assignedClientId, assignedClientId) ||
                other.assignedClientId == assignedClientId) &&
            (identical(other.liveLatitude, liveLatitude) ||
                other.liveLatitude == liveLatitude) &&
            (identical(other.liveLongitude, liveLongitude) ||
                other.liveLongitude == liveLongitude) &&
            (identical(other.liveAccuracy, liveAccuracy) ||
                other.liveAccuracy == liveAccuracy) &&
            (identical(other.liveUpdatedAt, liveUpdatedAt) ||
                other.liveUpdatedAt == liveUpdatedAt) &&
            (identical(other.liveAppointmentId, liveAppointmentId) ||
                other.liveAppointmentId == liveAppointmentId) &&
            (identical(other.liveClientName, liveClientName) ||
                other.liveClientName == liveClientName) &&
            (identical(other.liveDistanceMeters, liveDistanceMeters) ||
                other.liveDistanceMeters == liveDistanceMeters) &&
            (identical(
                    other.liveGeofenceRadiusMeters, liveGeofenceRadiusMeters) ||
                other.liveGeofenceRadiusMeters == liveGeofenceRadiusMeters) &&
            (identical(other.liveInsideGeofence, liveInsideGeofence) ||
                other.liveInsideGeofence == liveInsideGeofence) &&
            (identical(other.hoursWorked, hoursWorked) ||
                other.hoursWorked == hoursWorked) &&
            (identical(other.isOnBreak, isOnBreak) ||
                other.isOnBreak == isOnBreak));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        name,
        email,
        status,
        profileImage,
        filename,
        const DeepCollectionEquality().hash(photoData),
        currentLocation,
        lastSeen,
        currentShiftId,
        assignedClientId,
        liveLatitude,
        liveLongitude,
        liveAccuracy,
        liveUpdatedAt,
        liveAppointmentId,
        liveClientName,
        liveDistanceMeters,
        liveGeofenceRadiusMeters,
        liveInsideGeofence,
        hoursWorked,
        isOnBreak
      ]);

  @override
  String toString() {
    return 'EmployeeStatus(id: $id, name: $name, email: $email, status: $status, profileImage: $profileImage, filename: $filename, photoData: $photoData, currentLocation: $currentLocation, lastSeen: $lastSeen, currentShiftId: $currentShiftId, assignedClientId: $assignedClientId, liveLatitude: $liveLatitude, liveLongitude: $liveLongitude, liveAccuracy: $liveAccuracy, liveUpdatedAt: $liveUpdatedAt, liveAppointmentId: $liveAppointmentId, liveClientName: $liveClientName, liveDistanceMeters: $liveDistanceMeters, liveGeofenceRadiusMeters: $liveGeofenceRadiusMeters, liveInsideGeofence: $liveInsideGeofence, hoursWorked: $hoursWorked, isOnBreak: $isOnBreak)';
  }
}

/// @nodoc
abstract mixin class $EmployeeStatusCopyWith<$Res> {
  factory $EmployeeStatusCopyWith(
          EmployeeStatus value, $Res Function(EmployeeStatus) _then) =
      _$EmployeeStatusCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String name,
      String email,
      WorkStatus status,
      String? profileImage,
      String? filename,
      @JsonKey(includeFromJson: false, includeToJson: false)
      Uint8List? photoData,
      String? currentLocation,
      DateTime? lastSeen,
      String? currentShiftId,
      String? assignedClientId,
      double? liveLatitude,
      double? liveLongitude,
      double? liveAccuracy,
      DateTime? liveUpdatedAt,
      String? liveAppointmentId,
      String? liveClientName,
      double? liveDistanceMeters,
      double? liveGeofenceRadiusMeters,
      bool? liveInsideGeofence,
      double hoursWorked,
      bool isOnBreak});
}

/// @nodoc
class _$EmployeeStatusCopyWithImpl<$Res>
    implements $EmployeeStatusCopyWith<$Res> {
  _$EmployeeStatusCopyWithImpl(this._self, this._then);

  final EmployeeStatus _self;
  final $Res Function(EmployeeStatus) _then;

  /// Create a copy of EmployeeStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? email = null,
    Object? status = null,
    Object? profileImage = freezed,
    Object? filename = freezed,
    Object? photoData = freezed,
    Object? currentLocation = freezed,
    Object? lastSeen = freezed,
    Object? currentShiftId = freezed,
    Object? assignedClientId = freezed,
    Object? liveLatitude = freezed,
    Object? liveLongitude = freezed,
    Object? liveAccuracy = freezed,
    Object? liveUpdatedAt = freezed,
    Object? liveAppointmentId = freezed,
    Object? liveClientName = freezed,
    Object? liveDistanceMeters = freezed,
    Object? liveGeofenceRadiusMeters = freezed,
    Object? liveInsideGeofence = freezed,
    Object? hoursWorked = null,
    Object? isOnBreak = null,
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
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as WorkStatus,
      profileImage: freezed == profileImage
          ? _self.profileImage
          : profileImage // ignore: cast_nullable_to_non_nullable
              as String?,
      filename: freezed == filename
          ? _self.filename
          : filename // ignore: cast_nullable_to_non_nullable
              as String?,
      photoData: freezed == photoData
          ? _self.photoData
          : photoData // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
      currentLocation: freezed == currentLocation
          ? _self.currentLocation
          : currentLocation // ignore: cast_nullable_to_non_nullable
              as String?,
      lastSeen: freezed == lastSeen
          ? _self.lastSeen
          : lastSeen // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      currentShiftId: freezed == currentShiftId
          ? _self.currentShiftId
          : currentShiftId // ignore: cast_nullable_to_non_nullable
              as String?,
      assignedClientId: freezed == assignedClientId
          ? _self.assignedClientId
          : assignedClientId // ignore: cast_nullable_to_non_nullable
              as String?,
      liveLatitude: freezed == liveLatitude
          ? _self.liveLatitude
          : liveLatitude // ignore: cast_nullable_to_non_nullable
              as double?,
      liveLongitude: freezed == liveLongitude
          ? _self.liveLongitude
          : liveLongitude // ignore: cast_nullable_to_non_nullable
              as double?,
      liveAccuracy: freezed == liveAccuracy
          ? _self.liveAccuracy
          : liveAccuracy // ignore: cast_nullable_to_non_nullable
              as double?,
      liveUpdatedAt: freezed == liveUpdatedAt
          ? _self.liveUpdatedAt
          : liveUpdatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      liveAppointmentId: freezed == liveAppointmentId
          ? _self.liveAppointmentId
          : liveAppointmentId // ignore: cast_nullable_to_non_nullable
              as String?,
      liveClientName: freezed == liveClientName
          ? _self.liveClientName
          : liveClientName // ignore: cast_nullable_to_non_nullable
              as String?,
      liveDistanceMeters: freezed == liveDistanceMeters
          ? _self.liveDistanceMeters
          : liveDistanceMeters // ignore: cast_nullable_to_non_nullable
              as double?,
      liveGeofenceRadiusMeters: freezed == liveGeofenceRadiusMeters
          ? _self.liveGeofenceRadiusMeters
          : liveGeofenceRadiusMeters // ignore: cast_nullable_to_non_nullable
              as double?,
      liveInsideGeofence: freezed == liveInsideGeofence
          ? _self.liveInsideGeofence
          : liveInsideGeofence // ignore: cast_nullable_to_non_nullable
              as bool?,
      hoursWorked: null == hoursWorked
          ? _self.hoursWorked
          : hoursWorked // ignore: cast_nullable_to_non_nullable
              as double,
      isOnBreak: null == isOnBreak
          ? _self.isOnBreak
          : isOnBreak // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [EmployeeStatus].
extension EmployeeStatusPatterns on EmployeeStatus {
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
    TResult Function(_EmployeeStatus value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _EmployeeStatus() when $default != null:
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
    TResult Function(_EmployeeStatus value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EmployeeStatus():
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
    TResult? Function(_EmployeeStatus value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EmployeeStatus() when $default != null:
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
            String name,
            String email,
            WorkStatus status,
            String? profileImage,
            String? filename,
            @JsonKey(includeFromJson: false, includeToJson: false)
            Uint8List? photoData,
            String? currentLocation,
            DateTime? lastSeen,
            String? currentShiftId,
            String? assignedClientId,
            double? liveLatitude,
            double? liveLongitude,
            double? liveAccuracy,
            DateTime? liveUpdatedAt,
            String? liveAppointmentId,
            String? liveClientName,
            double? liveDistanceMeters,
            double? liveGeofenceRadiusMeters,
            bool? liveInsideGeofence,
            double hoursWorked,
            bool isOnBreak)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _EmployeeStatus() when $default != null:
        return $default(
            _that.id,
            _that.name,
            _that.email,
            _that.status,
            _that.profileImage,
            _that.filename,
            _that.photoData,
            _that.currentLocation,
            _that.lastSeen,
            _that.currentShiftId,
            _that.assignedClientId,
            _that.liveLatitude,
            _that.liveLongitude,
            _that.liveAccuracy,
            _that.liveUpdatedAt,
            _that.liveAppointmentId,
            _that.liveClientName,
            _that.liveDistanceMeters,
            _that.liveGeofenceRadiusMeters,
            _that.liveInsideGeofence,
            _that.hoursWorked,
            _that.isOnBreak);
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
            String name,
            String email,
            WorkStatus status,
            String? profileImage,
            String? filename,
            @JsonKey(includeFromJson: false, includeToJson: false)
            Uint8List? photoData,
            String? currentLocation,
            DateTime? lastSeen,
            String? currentShiftId,
            String? assignedClientId,
            double? liveLatitude,
            double? liveLongitude,
            double? liveAccuracy,
            DateTime? liveUpdatedAt,
            String? liveAppointmentId,
            String? liveClientName,
            double? liveDistanceMeters,
            double? liveGeofenceRadiusMeters,
            bool? liveInsideGeofence,
            double hoursWorked,
            bool isOnBreak)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EmployeeStatus():
        return $default(
            _that.id,
            _that.name,
            _that.email,
            _that.status,
            _that.profileImage,
            _that.filename,
            _that.photoData,
            _that.currentLocation,
            _that.lastSeen,
            _that.currentShiftId,
            _that.assignedClientId,
            _that.liveLatitude,
            _that.liveLongitude,
            _that.liveAccuracy,
            _that.liveUpdatedAt,
            _that.liveAppointmentId,
            _that.liveClientName,
            _that.liveDistanceMeters,
            _that.liveGeofenceRadiusMeters,
            _that.liveInsideGeofence,
            _that.hoursWorked,
            _that.isOnBreak);
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
            String name,
            String email,
            WorkStatus status,
            String? profileImage,
            String? filename,
            @JsonKey(includeFromJson: false, includeToJson: false)
            Uint8List? photoData,
            String? currentLocation,
            DateTime? lastSeen,
            String? currentShiftId,
            String? assignedClientId,
            double? liveLatitude,
            double? liveLongitude,
            double? liveAccuracy,
            DateTime? liveUpdatedAt,
            String? liveAppointmentId,
            String? liveClientName,
            double? liveDistanceMeters,
            double? liveGeofenceRadiusMeters,
            bool? liveInsideGeofence,
            double hoursWorked,
            bool isOnBreak)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EmployeeStatus() when $default != null:
        return $default(
            _that.id,
            _that.name,
            _that.email,
            _that.status,
            _that.profileImage,
            _that.filename,
            _that.photoData,
            _that.currentLocation,
            _that.lastSeen,
            _that.currentShiftId,
            _that.assignedClientId,
            _that.liveLatitude,
            _that.liveLongitude,
            _that.liveAccuracy,
            _that.liveUpdatedAt,
            _that.liveAppointmentId,
            _that.liveClientName,
            _that.liveDistanceMeters,
            _that.liveGeofenceRadiusMeters,
            _that.liveInsideGeofence,
            _that.hoursWorked,
            _that.isOnBreak);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _EmployeeStatus implements EmployeeStatus {
  const _EmployeeStatus(
      {required this.id,
      required this.name,
      required this.email,
      required this.status,
      this.profileImage,
      this.filename,
      @JsonKey(includeFromJson: false, includeToJson: false) this.photoData,
      this.currentLocation,
      this.lastSeen,
      this.currentShiftId,
      this.assignedClientId,
      this.liveLatitude,
      this.liveLongitude,
      this.liveAccuracy,
      this.liveUpdatedAt,
      this.liveAppointmentId,
      this.liveClientName,
      this.liveDistanceMeters,
      this.liveGeofenceRadiusMeters,
      this.liveInsideGeofence,
      this.hoursWorked = 0.0,
      this.isOnBreak = false});
  factory _EmployeeStatus.fromJson(Map<String, dynamic> json) =>
      _$EmployeeStatusFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String email;
  @override
  final WorkStatus status;
  @override
  final String? profileImage;
  @override
  final String? filename;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Uint8List? photoData;
  @override
  final String? currentLocation;
  @override
  final DateTime? lastSeen;
  @override
  final String? currentShiftId;
  @override
  final String? assignedClientId;
  @override
  final double? liveLatitude;
  @override
  final double? liveLongitude;
  @override
  final double? liveAccuracy;
  @override
  final DateTime? liveUpdatedAt;
  @override
  final String? liveAppointmentId;
  @override
  final String? liveClientName;
  @override
  final double? liveDistanceMeters;
  @override
  final double? liveGeofenceRadiusMeters;
  @override
  final bool? liveInsideGeofence;
  @override
  @JsonKey()
  final double hoursWorked;
  @override
  @JsonKey()
  final bool isOnBreak;

  /// Create a copy of EmployeeStatus
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$EmployeeStatusCopyWith<_EmployeeStatus> get copyWith =>
      __$EmployeeStatusCopyWithImpl<_EmployeeStatus>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$EmployeeStatusToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _EmployeeStatus &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.profileImage, profileImage) ||
                other.profileImage == profileImage) &&
            (identical(other.filename, filename) ||
                other.filename == filename) &&
            const DeepCollectionEquality().equals(other.photoData, photoData) &&
            (identical(other.currentLocation, currentLocation) ||
                other.currentLocation == currentLocation) &&
            (identical(other.lastSeen, lastSeen) ||
                other.lastSeen == lastSeen) &&
            (identical(other.currentShiftId, currentShiftId) ||
                other.currentShiftId == currentShiftId) &&
            (identical(other.assignedClientId, assignedClientId) ||
                other.assignedClientId == assignedClientId) &&
            (identical(other.liveLatitude, liveLatitude) ||
                other.liveLatitude == liveLatitude) &&
            (identical(other.liveLongitude, liveLongitude) ||
                other.liveLongitude == liveLongitude) &&
            (identical(other.liveAccuracy, liveAccuracy) ||
                other.liveAccuracy == liveAccuracy) &&
            (identical(other.liveUpdatedAt, liveUpdatedAt) ||
                other.liveUpdatedAt == liveUpdatedAt) &&
            (identical(other.liveAppointmentId, liveAppointmentId) ||
                other.liveAppointmentId == liveAppointmentId) &&
            (identical(other.liveClientName, liveClientName) ||
                other.liveClientName == liveClientName) &&
            (identical(other.liveDistanceMeters, liveDistanceMeters) ||
                other.liveDistanceMeters == liveDistanceMeters) &&
            (identical(
                    other.liveGeofenceRadiusMeters, liveGeofenceRadiusMeters) ||
                other.liveGeofenceRadiusMeters == liveGeofenceRadiusMeters) &&
            (identical(other.liveInsideGeofence, liveInsideGeofence) ||
                other.liveInsideGeofence == liveInsideGeofence) &&
            (identical(other.hoursWorked, hoursWorked) ||
                other.hoursWorked == hoursWorked) &&
            (identical(other.isOnBreak, isOnBreak) ||
                other.isOnBreak == isOnBreak));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        name,
        email,
        status,
        profileImage,
        filename,
        const DeepCollectionEquality().hash(photoData),
        currentLocation,
        lastSeen,
        currentShiftId,
        assignedClientId,
        liveLatitude,
        liveLongitude,
        liveAccuracy,
        liveUpdatedAt,
        liveAppointmentId,
        liveClientName,
        liveDistanceMeters,
        liveGeofenceRadiusMeters,
        liveInsideGeofence,
        hoursWorked,
        isOnBreak
      ]);

  @override
  String toString() {
    return 'EmployeeStatus(id: $id, name: $name, email: $email, status: $status, profileImage: $profileImage, filename: $filename, photoData: $photoData, currentLocation: $currentLocation, lastSeen: $lastSeen, currentShiftId: $currentShiftId, assignedClientId: $assignedClientId, liveLatitude: $liveLatitude, liveLongitude: $liveLongitude, liveAccuracy: $liveAccuracy, liveUpdatedAt: $liveUpdatedAt, liveAppointmentId: $liveAppointmentId, liveClientName: $liveClientName, liveDistanceMeters: $liveDistanceMeters, liveGeofenceRadiusMeters: $liveGeofenceRadiusMeters, liveInsideGeofence: $liveInsideGeofence, hoursWorked: $hoursWorked, isOnBreak: $isOnBreak)';
  }
}

/// @nodoc
abstract mixin class _$EmployeeStatusCopyWith<$Res>
    implements $EmployeeStatusCopyWith<$Res> {
  factory _$EmployeeStatusCopyWith(
          _EmployeeStatus value, $Res Function(_EmployeeStatus) _then) =
      __$EmployeeStatusCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String email,
      WorkStatus status,
      String? profileImage,
      String? filename,
      @JsonKey(includeFromJson: false, includeToJson: false)
      Uint8List? photoData,
      String? currentLocation,
      DateTime? lastSeen,
      String? currentShiftId,
      String? assignedClientId,
      double? liveLatitude,
      double? liveLongitude,
      double? liveAccuracy,
      DateTime? liveUpdatedAt,
      String? liveAppointmentId,
      String? liveClientName,
      double? liveDistanceMeters,
      double? liveGeofenceRadiusMeters,
      bool? liveInsideGeofence,
      double hoursWorked,
      bool isOnBreak});
}

/// @nodoc
class __$EmployeeStatusCopyWithImpl<$Res>
    implements _$EmployeeStatusCopyWith<$Res> {
  __$EmployeeStatusCopyWithImpl(this._self, this._then);

  final _EmployeeStatus _self;
  final $Res Function(_EmployeeStatus) _then;

  /// Create a copy of EmployeeStatus
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? email = null,
    Object? status = null,
    Object? profileImage = freezed,
    Object? filename = freezed,
    Object? photoData = freezed,
    Object? currentLocation = freezed,
    Object? lastSeen = freezed,
    Object? currentShiftId = freezed,
    Object? assignedClientId = freezed,
    Object? liveLatitude = freezed,
    Object? liveLongitude = freezed,
    Object? liveAccuracy = freezed,
    Object? liveUpdatedAt = freezed,
    Object? liveAppointmentId = freezed,
    Object? liveClientName = freezed,
    Object? liveDistanceMeters = freezed,
    Object? liveGeofenceRadiusMeters = freezed,
    Object? liveInsideGeofence = freezed,
    Object? hoursWorked = null,
    Object? isOnBreak = null,
  }) {
    return _then(_EmployeeStatus(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as WorkStatus,
      profileImage: freezed == profileImage
          ? _self.profileImage
          : profileImage // ignore: cast_nullable_to_non_nullable
              as String?,
      filename: freezed == filename
          ? _self.filename
          : filename // ignore: cast_nullable_to_non_nullable
              as String?,
      photoData: freezed == photoData
          ? _self.photoData
          : photoData // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
      currentLocation: freezed == currentLocation
          ? _self.currentLocation
          : currentLocation // ignore: cast_nullable_to_non_nullable
              as String?,
      lastSeen: freezed == lastSeen
          ? _self.lastSeen
          : lastSeen // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      currentShiftId: freezed == currentShiftId
          ? _self.currentShiftId
          : currentShiftId // ignore: cast_nullable_to_non_nullable
              as String?,
      assignedClientId: freezed == assignedClientId
          ? _self.assignedClientId
          : assignedClientId // ignore: cast_nullable_to_non_nullable
              as String?,
      liveLatitude: freezed == liveLatitude
          ? _self.liveLatitude
          : liveLatitude // ignore: cast_nullable_to_non_nullable
              as double?,
      liveLongitude: freezed == liveLongitude
          ? _self.liveLongitude
          : liveLongitude // ignore: cast_nullable_to_non_nullable
              as double?,
      liveAccuracy: freezed == liveAccuracy
          ? _self.liveAccuracy
          : liveAccuracy // ignore: cast_nullable_to_non_nullable
              as double?,
      liveUpdatedAt: freezed == liveUpdatedAt
          ? _self.liveUpdatedAt
          : liveUpdatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      liveAppointmentId: freezed == liveAppointmentId
          ? _self.liveAppointmentId
          : liveAppointmentId // ignore: cast_nullable_to_non_nullable
              as String?,
      liveClientName: freezed == liveClientName
          ? _self.liveClientName
          : liveClientName // ignore: cast_nullable_to_non_nullable
              as String?,
      liveDistanceMeters: freezed == liveDistanceMeters
          ? _self.liveDistanceMeters
          : liveDistanceMeters // ignore: cast_nullable_to_non_nullable
              as double?,
      liveGeofenceRadiusMeters: freezed == liveGeofenceRadiusMeters
          ? _self.liveGeofenceRadiusMeters
          : liveGeofenceRadiusMeters // ignore: cast_nullable_to_non_nullable
              as double?,
      liveInsideGeofence: freezed == liveInsideGeofence
          ? _self.liveInsideGeofence
          : liveInsideGeofence // ignore: cast_nullable_to_non_nullable
              as bool?,
      hoursWorked: null == hoursWorked
          ? _self.hoursWorked
          : hoursWorked // ignore: cast_nullable_to_non_nullable
              as double,
      isOnBreak: null == isOnBreak
          ? _self.isOnBreak
          : isOnBreak // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
mixin _$ShiftDetail {
  String get id;
  String get title;
  DateTime get startTime;
  DateTime get endTime;
  String get employeeId;
  String get employeeName;
  String? get clientId;
  String? get clientName;
  String? get location;
  ShiftStatus get status;
  String? get notes;

  /// Create a copy of ShiftDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ShiftDetailCopyWith<ShiftDetail> get copyWith =>
      _$ShiftDetailCopyWithImpl<ShiftDetail>(this as ShiftDetail, _$identity);

  /// Serializes this ShiftDetail to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ShiftDetail &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.employeeId, employeeId) ||
                other.employeeId == employeeId) &&
            (identical(other.employeeName, employeeName) ||
                other.employeeName == employeeName) &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.clientName, clientName) ||
                other.clientName == clientName) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, startTime, endTime,
      employeeId, employeeName, clientId, clientName, location, status, notes);

  @override
  String toString() {
    return 'ShiftDetail(id: $id, title: $title, startTime: $startTime, endTime: $endTime, employeeId: $employeeId, employeeName: $employeeName, clientId: $clientId, clientName: $clientName, location: $location, status: $status, notes: $notes)';
  }
}

/// @nodoc
abstract mixin class $ShiftDetailCopyWith<$Res> {
  factory $ShiftDetailCopyWith(
          ShiftDetail value, $Res Function(ShiftDetail) _then) =
      _$ShiftDetailCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String title,
      DateTime startTime,
      DateTime endTime,
      String employeeId,
      String employeeName,
      String? clientId,
      String? clientName,
      String? location,
      ShiftStatus status,
      String? notes});
}

/// @nodoc
class _$ShiftDetailCopyWithImpl<$Res> implements $ShiftDetailCopyWith<$Res> {
  _$ShiftDetailCopyWithImpl(this._self, this._then);

  final ShiftDetail _self;
  final $Res Function(ShiftDetail) _then;

  /// Create a copy of ShiftDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? employeeId = null,
    Object? employeeName = null,
    Object? clientId = freezed,
    Object? clientName = freezed,
    Object? location = freezed,
    Object? status = null,
    Object? notes = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _self.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: null == endTime
          ? _self.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      employeeId: null == employeeId
          ? _self.employeeId
          : employeeId // ignore: cast_nullable_to_non_nullable
              as String,
      employeeName: null == employeeName
          ? _self.employeeName
          : employeeName // ignore: cast_nullable_to_non_nullable
              as String,
      clientId: freezed == clientId
          ? _self.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String?,
      clientName: freezed == clientName
          ? _self.clientName
          : clientName // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _self.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as ShiftStatus,
      notes: freezed == notes
          ? _self.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [ShiftDetail].
extension ShiftDetailPatterns on ShiftDetail {
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
    TResult Function(_ShiftDetail value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ShiftDetail() when $default != null:
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
    TResult Function(_ShiftDetail value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ShiftDetail():
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
    TResult? Function(_ShiftDetail value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ShiftDetail() when $default != null:
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
            String title,
            DateTime startTime,
            DateTime endTime,
            String employeeId,
            String employeeName,
            String? clientId,
            String? clientName,
            String? location,
            ShiftStatus status,
            String? notes)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ShiftDetail() when $default != null:
        return $default(
            _that.id,
            _that.title,
            _that.startTime,
            _that.endTime,
            _that.employeeId,
            _that.employeeName,
            _that.clientId,
            _that.clientName,
            _that.location,
            _that.status,
            _that.notes);
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
            String title,
            DateTime startTime,
            DateTime endTime,
            String employeeId,
            String employeeName,
            String? clientId,
            String? clientName,
            String? location,
            ShiftStatus status,
            String? notes)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ShiftDetail():
        return $default(
            _that.id,
            _that.title,
            _that.startTime,
            _that.endTime,
            _that.employeeId,
            _that.employeeName,
            _that.clientId,
            _that.clientName,
            _that.location,
            _that.status,
            _that.notes);
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
            String title,
            DateTime startTime,
            DateTime endTime,
            String employeeId,
            String employeeName,
            String? clientId,
            String? clientName,
            String? location,
            ShiftStatus status,
            String? notes)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ShiftDetail() when $default != null:
        return $default(
            _that.id,
            _that.title,
            _that.startTime,
            _that.endTime,
            _that.employeeId,
            _that.employeeName,
            _that.clientId,
            _that.clientName,
            _that.location,
            _that.status,
            _that.notes);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ShiftDetail implements ShiftDetail {
  const _ShiftDetail(
      {required this.id,
      required this.title,
      required this.startTime,
      required this.endTime,
      required this.employeeId,
      required this.employeeName,
      this.clientId,
      this.clientName,
      this.location,
      required this.status,
      this.notes});
  factory _ShiftDetail.fromJson(Map<String, dynamic> json) =>
      _$ShiftDetailFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final DateTime startTime;
  @override
  final DateTime endTime;
  @override
  final String employeeId;
  @override
  final String employeeName;
  @override
  final String? clientId;
  @override
  final String? clientName;
  @override
  final String? location;
  @override
  final ShiftStatus status;
  @override
  final String? notes;

  /// Create a copy of ShiftDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ShiftDetailCopyWith<_ShiftDetail> get copyWith =>
      __$ShiftDetailCopyWithImpl<_ShiftDetail>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ShiftDetailToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ShiftDetail &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.employeeId, employeeId) ||
                other.employeeId == employeeId) &&
            (identical(other.employeeName, employeeName) ||
                other.employeeName == employeeName) &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.clientName, clientName) ||
                other.clientName == clientName) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, startTime, endTime,
      employeeId, employeeName, clientId, clientName, location, status, notes);

  @override
  String toString() {
    return 'ShiftDetail(id: $id, title: $title, startTime: $startTime, endTime: $endTime, employeeId: $employeeId, employeeName: $employeeName, clientId: $clientId, clientName: $clientName, location: $location, status: $status, notes: $notes)';
  }
}

/// @nodoc
abstract mixin class _$ShiftDetailCopyWith<$Res>
    implements $ShiftDetailCopyWith<$Res> {
  factory _$ShiftDetailCopyWith(
          _ShiftDetail value, $Res Function(_ShiftDetail) _then) =
      __$ShiftDetailCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      DateTime startTime,
      DateTime endTime,
      String employeeId,
      String employeeName,
      String? clientId,
      String? clientName,
      String? location,
      ShiftStatus status,
      String? notes});
}

/// @nodoc
class __$ShiftDetailCopyWithImpl<$Res> implements _$ShiftDetailCopyWith<$Res> {
  __$ShiftDetailCopyWithImpl(this._self, this._then);

  final _ShiftDetail _self;
  final $Res Function(_ShiftDetail) _then;

  /// Create a copy of ShiftDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? employeeId = null,
    Object? employeeName = null,
    Object? clientId = freezed,
    Object? clientName = freezed,
    Object? location = freezed,
    Object? status = null,
    Object? notes = freezed,
  }) {
    return _then(_ShiftDetail(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _self.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: null == endTime
          ? _self.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      employeeId: null == employeeId
          ? _self.employeeId
          : employeeId // ignore: cast_nullable_to_non_nullable
              as String,
      employeeName: null == employeeName
          ? _self.employeeName
          : employeeName // ignore: cast_nullable_to_non_nullable
              as String,
      clientId: freezed == clientId
          ? _self.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String?,
      clientName: freezed == clientName
          ? _self.clientName
          : clientName // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _self.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as ShiftStatus,
      notes: freezed == notes
          ? _self.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$ClientAssignment {
  String get id;
  String get clientName;
  String get employeeId;
  String get employeeName;
  DateTime get assignedDate;
  DateTime? get startDate;
  DateTime? get endDate;
  AssignmentStatus get status;
  String? get notes;
  String? get location;

  /// Create a copy of ClientAssignment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ClientAssignmentCopyWith<ClientAssignment> get copyWith =>
      _$ClientAssignmentCopyWithImpl<ClientAssignment>(
          this as ClientAssignment, _$identity);

  /// Serializes this ClientAssignment to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ClientAssignment &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.clientName, clientName) ||
                other.clientName == clientName) &&
            (identical(other.employeeId, employeeId) ||
                other.employeeId == employeeId) &&
            (identical(other.employeeName, employeeName) ||
                other.employeeName == employeeName) &&
            (identical(other.assignedDate, assignedDate) ||
                other.assignedDate == assignedDate) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.location, location) ||
                other.location == location));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, clientName, employeeId,
      employeeName, assignedDate, startDate, endDate, status, notes, location);

  @override
  String toString() {
    return 'ClientAssignment(id: $id, clientName: $clientName, employeeId: $employeeId, employeeName: $employeeName, assignedDate: $assignedDate, startDate: $startDate, endDate: $endDate, status: $status, notes: $notes, location: $location)';
  }
}

/// @nodoc
abstract mixin class $ClientAssignmentCopyWith<$Res> {
  factory $ClientAssignmentCopyWith(
          ClientAssignment value, $Res Function(ClientAssignment) _then) =
      _$ClientAssignmentCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String clientName,
      String employeeId,
      String employeeName,
      DateTime assignedDate,
      DateTime? startDate,
      DateTime? endDate,
      AssignmentStatus status,
      String? notes,
      String? location});
}

/// @nodoc
class _$ClientAssignmentCopyWithImpl<$Res>
    implements $ClientAssignmentCopyWith<$Res> {
  _$ClientAssignmentCopyWithImpl(this._self, this._then);

  final ClientAssignment _self;
  final $Res Function(ClientAssignment) _then;

  /// Create a copy of ClientAssignment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? clientName = null,
    Object? employeeId = null,
    Object? employeeName = null,
    Object? assignedDate = null,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? status = null,
    Object? notes = freezed,
    Object? location = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      clientName: null == clientName
          ? _self.clientName
          : clientName // ignore: cast_nullable_to_non_nullable
              as String,
      employeeId: null == employeeId
          ? _self.employeeId
          : employeeId // ignore: cast_nullable_to_non_nullable
              as String,
      employeeName: null == employeeName
          ? _self.employeeName
          : employeeName // ignore: cast_nullable_to_non_nullable
              as String,
      assignedDate: null == assignedDate
          ? _self.assignedDate
          : assignedDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      startDate: freezed == startDate
          ? _self.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endDate: freezed == endDate
          ? _self.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as AssignmentStatus,
      notes: freezed == notes
          ? _self.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _self.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [ClientAssignment].
extension ClientAssignmentPatterns on ClientAssignment {
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
    TResult Function(_ClientAssignment value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ClientAssignment() when $default != null:
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
    TResult Function(_ClientAssignment value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ClientAssignment():
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
    TResult? Function(_ClientAssignment value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ClientAssignment() when $default != null:
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
            String clientName,
            String employeeId,
            String employeeName,
            DateTime assignedDate,
            DateTime? startDate,
            DateTime? endDate,
            AssignmentStatus status,
            String? notes,
            String? location)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ClientAssignment() when $default != null:
        return $default(
            _that.id,
            _that.clientName,
            _that.employeeId,
            _that.employeeName,
            _that.assignedDate,
            _that.startDate,
            _that.endDate,
            _that.status,
            _that.notes,
            _that.location);
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
            String clientName,
            String employeeId,
            String employeeName,
            DateTime assignedDate,
            DateTime? startDate,
            DateTime? endDate,
            AssignmentStatus status,
            String? notes,
            String? location)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ClientAssignment():
        return $default(
            _that.id,
            _that.clientName,
            _that.employeeId,
            _that.employeeName,
            _that.assignedDate,
            _that.startDate,
            _that.endDate,
            _that.status,
            _that.notes,
            _that.location);
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
            String clientName,
            String employeeId,
            String employeeName,
            DateTime assignedDate,
            DateTime? startDate,
            DateTime? endDate,
            AssignmentStatus status,
            String? notes,
            String? location)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ClientAssignment() when $default != null:
        return $default(
            _that.id,
            _that.clientName,
            _that.employeeId,
            _that.employeeName,
            _that.assignedDate,
            _that.startDate,
            _that.endDate,
            _that.status,
            _that.notes,
            _that.location);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ClientAssignment implements ClientAssignment {
  const _ClientAssignment(
      {required this.id,
      required this.clientName,
      required this.employeeId,
      required this.employeeName,
      required this.assignedDate,
      this.startDate,
      this.endDate,
      required this.status,
      this.notes,
      this.location});
  factory _ClientAssignment.fromJson(Map<String, dynamic> json) =>
      _$ClientAssignmentFromJson(json);

  @override
  final String id;
  @override
  final String clientName;
  @override
  final String employeeId;
  @override
  final String employeeName;
  @override
  final DateTime assignedDate;
  @override
  final DateTime? startDate;
  @override
  final DateTime? endDate;
  @override
  final AssignmentStatus status;
  @override
  final String? notes;
  @override
  final String? location;

  /// Create a copy of ClientAssignment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ClientAssignmentCopyWith<_ClientAssignment> get copyWith =>
      __$ClientAssignmentCopyWithImpl<_ClientAssignment>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ClientAssignmentToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ClientAssignment &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.clientName, clientName) ||
                other.clientName == clientName) &&
            (identical(other.employeeId, employeeId) ||
                other.employeeId == employeeId) &&
            (identical(other.employeeName, employeeName) ||
                other.employeeName == employeeName) &&
            (identical(other.assignedDate, assignedDate) ||
                other.assignedDate == assignedDate) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.location, location) ||
                other.location == location));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, clientName, employeeId,
      employeeName, assignedDate, startDate, endDate, status, notes, location);

  @override
  String toString() {
    return 'ClientAssignment(id: $id, clientName: $clientName, employeeId: $employeeId, employeeName: $employeeName, assignedDate: $assignedDate, startDate: $startDate, endDate: $endDate, status: $status, notes: $notes, location: $location)';
  }
}

/// @nodoc
abstract mixin class _$ClientAssignmentCopyWith<$Res>
    implements $ClientAssignmentCopyWith<$Res> {
  factory _$ClientAssignmentCopyWith(
          _ClientAssignment value, $Res Function(_ClientAssignment) _then) =
      __$ClientAssignmentCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String clientName,
      String employeeId,
      String employeeName,
      DateTime assignedDate,
      DateTime? startDate,
      DateTime? endDate,
      AssignmentStatus status,
      String? notes,
      String? location});
}

/// @nodoc
class __$ClientAssignmentCopyWithImpl<$Res>
    implements _$ClientAssignmentCopyWith<$Res> {
  __$ClientAssignmentCopyWithImpl(this._self, this._then);

  final _ClientAssignment _self;
  final $Res Function(_ClientAssignment) _then;

  /// Create a copy of ClientAssignment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? clientName = null,
    Object? employeeId = null,
    Object? employeeName = null,
    Object? assignedDate = null,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? status = null,
    Object? notes = freezed,
    Object? location = freezed,
  }) {
    return _then(_ClientAssignment(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      clientName: null == clientName
          ? _self.clientName
          : clientName // ignore: cast_nullable_to_non_nullable
              as String,
      employeeId: null == employeeId
          ? _self.employeeId
          : employeeId // ignore: cast_nullable_to_non_nullable
              as String,
      employeeName: null == employeeName
          ? _self.employeeName
          : employeeName // ignore: cast_nullable_to_non_nullable
              as String,
      assignedDate: null == assignedDate
          ? _self.assignedDate
          : assignedDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      startDate: freezed == startDate
          ? _self.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endDate: freezed == endDate
          ? _self.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as AssignmentStatus,
      notes: freezed == notes
          ? _self.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _self.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
