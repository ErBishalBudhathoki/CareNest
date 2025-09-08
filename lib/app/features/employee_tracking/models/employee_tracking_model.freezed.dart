// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'employee_tracking_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

EmployeeTrackingData _$EmployeeTrackingDataFromJson(Map<String, dynamic> json) {
  return _EmployeeTrackingData.fromJson(json);
}

/// @nodoc
mixin _$EmployeeTrackingData {
  List<EmployeeStatus> get employees => throw _privateConstructorUsedError;
  List<ShiftDetail> get shifts => throw _privateConstructorUsedError;
  List<ClientAssignment> get assignments => throw _privateConstructorUsedError;
  int get totalEmployees => throw _privateConstructorUsedError;
  int get activeEmployees => throw _privateConstructorUsedError;
  int get onBreakEmployees => throw _privateConstructorUsedError;
  int get offlineEmployees => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EmployeeTrackingDataCopyWith<EmployeeTrackingData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmployeeTrackingDataCopyWith<$Res> {
  factory $EmployeeTrackingDataCopyWith(EmployeeTrackingData value,
          $Res Function(EmployeeTrackingData) then) =
      _$EmployeeTrackingDataCopyWithImpl<$Res, EmployeeTrackingData>;
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
class _$EmployeeTrackingDataCopyWithImpl<$Res,
        $Val extends EmployeeTrackingData>
    implements $EmployeeTrackingDataCopyWith<$Res> {
  _$EmployeeTrackingDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      employees: null == employees
          ? _value.employees
          : employees // ignore: cast_nullable_to_non_nullable
              as List<EmployeeStatus>,
      shifts: null == shifts
          ? _value.shifts
          : shifts // ignore: cast_nullable_to_non_nullable
              as List<ShiftDetail>,
      assignments: null == assignments
          ? _value.assignments
          : assignments // ignore: cast_nullable_to_non_nullable
              as List<ClientAssignment>,
      totalEmployees: null == totalEmployees
          ? _value.totalEmployees
          : totalEmployees // ignore: cast_nullable_to_non_nullable
              as int,
      activeEmployees: null == activeEmployees
          ? _value.activeEmployees
          : activeEmployees // ignore: cast_nullable_to_non_nullable
              as int,
      onBreakEmployees: null == onBreakEmployees
          ? _value.onBreakEmployees
          : onBreakEmployees // ignore: cast_nullable_to_non_nullable
              as int,
      offlineEmployees: null == offlineEmployees
          ? _value.offlineEmployees
          : offlineEmployees // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EmployeeTrackingDataImplCopyWith<$Res>
    implements $EmployeeTrackingDataCopyWith<$Res> {
  factory _$$EmployeeTrackingDataImplCopyWith(_$EmployeeTrackingDataImpl value,
          $Res Function(_$EmployeeTrackingDataImpl) then) =
      __$$EmployeeTrackingDataImplCopyWithImpl<$Res>;
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
class __$$EmployeeTrackingDataImplCopyWithImpl<$Res>
    extends _$EmployeeTrackingDataCopyWithImpl<$Res, _$EmployeeTrackingDataImpl>
    implements _$$EmployeeTrackingDataImplCopyWith<$Res> {
  __$$EmployeeTrackingDataImplCopyWithImpl(_$EmployeeTrackingDataImpl _value,
      $Res Function(_$EmployeeTrackingDataImpl) _then)
      : super(_value, _then);

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
    return _then(_$EmployeeTrackingDataImpl(
      employees: null == employees
          ? _value._employees
          : employees // ignore: cast_nullable_to_non_nullable
              as List<EmployeeStatus>,
      shifts: null == shifts
          ? _value._shifts
          : shifts // ignore: cast_nullable_to_non_nullable
              as List<ShiftDetail>,
      assignments: null == assignments
          ? _value._assignments
          : assignments // ignore: cast_nullable_to_non_nullable
              as List<ClientAssignment>,
      totalEmployees: null == totalEmployees
          ? _value.totalEmployees
          : totalEmployees // ignore: cast_nullable_to_non_nullable
              as int,
      activeEmployees: null == activeEmployees
          ? _value.activeEmployees
          : activeEmployees // ignore: cast_nullable_to_non_nullable
              as int,
      onBreakEmployees: null == onBreakEmployees
          ? _value.onBreakEmployees
          : onBreakEmployees // ignore: cast_nullable_to_non_nullable
              as int,
      offlineEmployees: null == offlineEmployees
          ? _value.offlineEmployees
          : offlineEmployees // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EmployeeTrackingDataImpl implements _EmployeeTrackingData {
  const _$EmployeeTrackingDataImpl(
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

  factory _$EmployeeTrackingDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$EmployeeTrackingDataImplFromJson(json);

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

  @override
  String toString() {
    return 'EmployeeTrackingData(employees: $employees, shifts: $shifts, assignments: $assignments, totalEmployees: $totalEmployees, activeEmployees: $activeEmployees, onBreakEmployees: $onBreakEmployees, offlineEmployees: $offlineEmployees)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmployeeTrackingDataImpl &&
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

  @JsonKey(ignore: true)
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

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EmployeeTrackingDataImplCopyWith<_$EmployeeTrackingDataImpl>
      get copyWith =>
          __$$EmployeeTrackingDataImplCopyWithImpl<_$EmployeeTrackingDataImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EmployeeTrackingDataImplToJson(
      this,
    );
  }
}

abstract class _EmployeeTrackingData implements EmployeeTrackingData {
  const factory _EmployeeTrackingData(
      {final List<EmployeeStatus> employees,
      final List<ShiftDetail> shifts,
      final List<ClientAssignment> assignments,
      final int totalEmployees,
      final int activeEmployees,
      final int onBreakEmployees,
      final int offlineEmployees}) = _$EmployeeTrackingDataImpl;

  factory _EmployeeTrackingData.fromJson(Map<String, dynamic> json) =
      _$EmployeeTrackingDataImpl.fromJson;

  @override
  List<EmployeeStatus> get employees;
  @override
  List<ShiftDetail> get shifts;
  @override
  List<ClientAssignment> get assignments;
  @override
  int get totalEmployees;
  @override
  int get activeEmployees;
  @override
  int get onBreakEmployees;
  @override
  int get offlineEmployees;
  @override
  @JsonKey(ignore: true)
  _$$EmployeeTrackingDataImplCopyWith<_$EmployeeTrackingDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}

EmployeeStatus _$EmployeeStatusFromJson(Map<String, dynamic> json) {
  return _EmployeeStatus.fromJson(json);
}

/// @nodoc
mixin _$EmployeeStatus {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  WorkStatus get status => throw _privateConstructorUsedError;
  String? get profileImage => throw _privateConstructorUsedError;
  String? get filename => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  Uint8List? get photoData => throw _privateConstructorUsedError;
  String? get currentLocation => throw _privateConstructorUsedError;
  DateTime? get lastSeen => throw _privateConstructorUsedError;
  String? get currentShiftId => throw _privateConstructorUsedError;
  String? get assignedClientId => throw _privateConstructorUsedError;
  double get hoursWorked => throw _privateConstructorUsedError;
  bool get isOnBreak => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EmployeeStatusCopyWith<EmployeeStatus> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmployeeStatusCopyWith<$Res> {
  factory $EmployeeStatusCopyWith(
          EmployeeStatus value, $Res Function(EmployeeStatus) then) =
      _$EmployeeStatusCopyWithImpl<$Res, EmployeeStatus>;
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
      double hoursWorked,
      bool isOnBreak});
}

/// @nodoc
class _$EmployeeStatusCopyWithImpl<$Res, $Val extends EmployeeStatus>
    implements $EmployeeStatusCopyWith<$Res> {
  _$EmployeeStatusCopyWithImpl(this._value, this._then);

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
    Object? status = null,
    Object? profileImage = freezed,
    Object? filename = freezed,
    Object? photoData = freezed,
    Object? currentLocation = freezed,
    Object? lastSeen = freezed,
    Object? currentShiftId = freezed,
    Object? assignedClientId = freezed,
    Object? hoursWorked = null,
    Object? isOnBreak = null,
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
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as WorkStatus,
      profileImage: freezed == profileImage
          ? _value.profileImage
          : profileImage // ignore: cast_nullable_to_non_nullable
              as String?,
      filename: freezed == filename
          ? _value.filename
          : filename // ignore: cast_nullable_to_non_nullable
              as String?,
      photoData: freezed == photoData
          ? _value.photoData
          : photoData // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
      currentLocation: freezed == currentLocation
          ? _value.currentLocation
          : currentLocation // ignore: cast_nullable_to_non_nullable
              as String?,
      lastSeen: freezed == lastSeen
          ? _value.lastSeen
          : lastSeen // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      currentShiftId: freezed == currentShiftId
          ? _value.currentShiftId
          : currentShiftId // ignore: cast_nullable_to_non_nullable
              as String?,
      assignedClientId: freezed == assignedClientId
          ? _value.assignedClientId
          : assignedClientId // ignore: cast_nullable_to_non_nullable
              as String?,
      hoursWorked: null == hoursWorked
          ? _value.hoursWorked
          : hoursWorked // ignore: cast_nullable_to_non_nullable
              as double,
      isOnBreak: null == isOnBreak
          ? _value.isOnBreak
          : isOnBreak // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EmployeeStatusImplCopyWith<$Res>
    implements $EmployeeStatusCopyWith<$Res> {
  factory _$$EmployeeStatusImplCopyWith(_$EmployeeStatusImpl value,
          $Res Function(_$EmployeeStatusImpl) then) =
      __$$EmployeeStatusImplCopyWithImpl<$Res>;
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
      double hoursWorked,
      bool isOnBreak});
}

/// @nodoc
class __$$EmployeeStatusImplCopyWithImpl<$Res>
    extends _$EmployeeStatusCopyWithImpl<$Res, _$EmployeeStatusImpl>
    implements _$$EmployeeStatusImplCopyWith<$Res> {
  __$$EmployeeStatusImplCopyWithImpl(
      _$EmployeeStatusImpl _value, $Res Function(_$EmployeeStatusImpl) _then)
      : super(_value, _then);

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
    Object? hoursWorked = null,
    Object? isOnBreak = null,
  }) {
    return _then(_$EmployeeStatusImpl(
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
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as WorkStatus,
      profileImage: freezed == profileImage
          ? _value.profileImage
          : profileImage // ignore: cast_nullable_to_non_nullable
              as String?,
      filename: freezed == filename
          ? _value.filename
          : filename // ignore: cast_nullable_to_non_nullable
              as String?,
      photoData: freezed == photoData
          ? _value.photoData
          : photoData // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
      currentLocation: freezed == currentLocation
          ? _value.currentLocation
          : currentLocation // ignore: cast_nullable_to_non_nullable
              as String?,
      lastSeen: freezed == lastSeen
          ? _value.lastSeen
          : lastSeen // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      currentShiftId: freezed == currentShiftId
          ? _value.currentShiftId
          : currentShiftId // ignore: cast_nullable_to_non_nullable
              as String?,
      assignedClientId: freezed == assignedClientId
          ? _value.assignedClientId
          : assignedClientId // ignore: cast_nullable_to_non_nullable
              as String?,
      hoursWorked: null == hoursWorked
          ? _value.hoursWorked
          : hoursWorked // ignore: cast_nullable_to_non_nullable
              as double,
      isOnBreak: null == isOnBreak
          ? _value.isOnBreak
          : isOnBreak // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EmployeeStatusImpl implements _EmployeeStatus {
  const _$EmployeeStatusImpl(
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
      this.hoursWorked = 0.0,
      this.isOnBreak = false});

  factory _$EmployeeStatusImpl.fromJson(Map<String, dynamic> json) =>
      _$$EmployeeStatusImplFromJson(json);

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
  @JsonKey()
  final double hoursWorked;
  @override
  @JsonKey()
  final bool isOnBreak;

  @override
  String toString() {
    return 'EmployeeStatus(id: $id, name: $name, email: $email, status: $status, profileImage: $profileImage, filename: $filename, photoData: $photoData, currentLocation: $currentLocation, lastSeen: $lastSeen, currentShiftId: $currentShiftId, assignedClientId: $assignedClientId, hoursWorked: $hoursWorked, isOnBreak: $isOnBreak)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmployeeStatusImpl &&
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
            (identical(other.hoursWorked, hoursWorked) ||
                other.hoursWorked == hoursWorked) &&
            (identical(other.isOnBreak, isOnBreak) ||
                other.isOnBreak == isOnBreak));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
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
      hoursWorked,
      isOnBreak);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EmployeeStatusImplCopyWith<_$EmployeeStatusImpl> get copyWith =>
      __$$EmployeeStatusImplCopyWithImpl<_$EmployeeStatusImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EmployeeStatusImplToJson(
      this,
    );
  }
}

abstract class _EmployeeStatus implements EmployeeStatus {
  const factory _EmployeeStatus(
      {required final String id,
      required final String name,
      required final String email,
      required final WorkStatus status,
      final String? profileImage,
      final String? filename,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final Uint8List? photoData,
      final String? currentLocation,
      final DateTime? lastSeen,
      final String? currentShiftId,
      final String? assignedClientId,
      final double hoursWorked,
      final bool isOnBreak}) = _$EmployeeStatusImpl;

  factory _EmployeeStatus.fromJson(Map<String, dynamic> json) =
      _$EmployeeStatusImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get email;
  @override
  WorkStatus get status;
  @override
  String? get profileImage;
  @override
  String? get filename;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  Uint8List? get photoData;
  @override
  String? get currentLocation;
  @override
  DateTime? get lastSeen;
  @override
  String? get currentShiftId;
  @override
  String? get assignedClientId;
  @override
  double get hoursWorked;
  @override
  bool get isOnBreak;
  @override
  @JsonKey(ignore: true)
  _$$EmployeeStatusImplCopyWith<_$EmployeeStatusImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ShiftDetail _$ShiftDetailFromJson(Map<String, dynamic> json) {
  return _ShiftDetail.fromJson(json);
}

/// @nodoc
mixin _$ShiftDetail {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  DateTime get startTime => throw _privateConstructorUsedError;
  DateTime get endTime => throw _privateConstructorUsedError;
  String get employeeId => throw _privateConstructorUsedError;
  String get employeeName => throw _privateConstructorUsedError;
  String? get clientId => throw _privateConstructorUsedError;
  String? get clientName => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;
  ShiftStatus get status => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ShiftDetailCopyWith<ShiftDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShiftDetailCopyWith<$Res> {
  factory $ShiftDetailCopyWith(
          ShiftDetail value, $Res Function(ShiftDetail) then) =
      _$ShiftDetailCopyWithImpl<$Res, ShiftDetail>;
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
class _$ShiftDetailCopyWithImpl<$Res, $Val extends ShiftDetail>
    implements $ShiftDetailCopyWith<$Res> {
  _$ShiftDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      employeeId: null == employeeId
          ? _value.employeeId
          : employeeId // ignore: cast_nullable_to_non_nullable
              as String,
      employeeName: null == employeeName
          ? _value.employeeName
          : employeeName // ignore: cast_nullable_to_non_nullable
              as String,
      clientId: freezed == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String?,
      clientName: freezed == clientName
          ? _value.clientName
          : clientName // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ShiftStatus,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ShiftDetailImplCopyWith<$Res>
    implements $ShiftDetailCopyWith<$Res> {
  factory _$$ShiftDetailImplCopyWith(
          _$ShiftDetailImpl value, $Res Function(_$ShiftDetailImpl) then) =
      __$$ShiftDetailImplCopyWithImpl<$Res>;
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
class __$$ShiftDetailImplCopyWithImpl<$Res>
    extends _$ShiftDetailCopyWithImpl<$Res, _$ShiftDetailImpl>
    implements _$$ShiftDetailImplCopyWith<$Res> {
  __$$ShiftDetailImplCopyWithImpl(
      _$ShiftDetailImpl _value, $Res Function(_$ShiftDetailImpl) _then)
      : super(_value, _then);

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
    return _then(_$ShiftDetailImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      employeeId: null == employeeId
          ? _value.employeeId
          : employeeId // ignore: cast_nullable_to_non_nullable
              as String,
      employeeName: null == employeeName
          ? _value.employeeName
          : employeeName // ignore: cast_nullable_to_non_nullable
              as String,
      clientId: freezed == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String?,
      clientName: freezed == clientName
          ? _value.clientName
          : clientName // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ShiftStatus,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ShiftDetailImpl implements _ShiftDetail {
  const _$ShiftDetailImpl(
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

  factory _$ShiftDetailImpl.fromJson(Map<String, dynamic> json) =>
      _$$ShiftDetailImplFromJson(json);

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

  @override
  String toString() {
    return 'ShiftDetail(id: $id, title: $title, startTime: $startTime, endTime: $endTime, employeeId: $employeeId, employeeName: $employeeName, clientId: $clientId, clientName: $clientName, location: $location, status: $status, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShiftDetailImpl &&
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

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, startTime, endTime,
      employeeId, employeeName, clientId, clientName, location, status, notes);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ShiftDetailImplCopyWith<_$ShiftDetailImpl> get copyWith =>
      __$$ShiftDetailImplCopyWithImpl<_$ShiftDetailImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ShiftDetailImplToJson(
      this,
    );
  }
}

abstract class _ShiftDetail implements ShiftDetail {
  const factory _ShiftDetail(
      {required final String id,
      required final String title,
      required final DateTime startTime,
      required final DateTime endTime,
      required final String employeeId,
      required final String employeeName,
      final String? clientId,
      final String? clientName,
      final String? location,
      required final ShiftStatus status,
      final String? notes}) = _$ShiftDetailImpl;

  factory _ShiftDetail.fromJson(Map<String, dynamic> json) =
      _$ShiftDetailImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  DateTime get startTime;
  @override
  DateTime get endTime;
  @override
  String get employeeId;
  @override
  String get employeeName;
  @override
  String? get clientId;
  @override
  String? get clientName;
  @override
  String? get location;
  @override
  ShiftStatus get status;
  @override
  String? get notes;
  @override
  @JsonKey(ignore: true)
  _$$ShiftDetailImplCopyWith<_$ShiftDetailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ClientAssignment _$ClientAssignmentFromJson(Map<String, dynamic> json) {
  return _ClientAssignment.fromJson(json);
}

/// @nodoc
mixin _$ClientAssignment {
  String get id => throw _privateConstructorUsedError;
  String get clientName => throw _privateConstructorUsedError;
  String get employeeId => throw _privateConstructorUsedError;
  String get employeeName => throw _privateConstructorUsedError;
  DateTime get assignedDate => throw _privateConstructorUsedError;
  DateTime? get startDate => throw _privateConstructorUsedError;
  DateTime? get endDate => throw _privateConstructorUsedError;
  AssignmentStatus get status => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ClientAssignmentCopyWith<ClientAssignment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClientAssignmentCopyWith<$Res> {
  factory $ClientAssignmentCopyWith(
          ClientAssignment value, $Res Function(ClientAssignment) then) =
      _$ClientAssignmentCopyWithImpl<$Res, ClientAssignment>;
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
class _$ClientAssignmentCopyWithImpl<$Res, $Val extends ClientAssignment>
    implements $ClientAssignmentCopyWith<$Res> {
  _$ClientAssignmentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      clientName: null == clientName
          ? _value.clientName
          : clientName // ignore: cast_nullable_to_non_nullable
              as String,
      employeeId: null == employeeId
          ? _value.employeeId
          : employeeId // ignore: cast_nullable_to_non_nullable
              as String,
      employeeName: null == employeeName
          ? _value.employeeName
          : employeeName // ignore: cast_nullable_to_non_nullable
              as String,
      assignedDate: null == assignedDate
          ? _value.assignedDate
          : assignedDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as AssignmentStatus,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ClientAssignmentImplCopyWith<$Res>
    implements $ClientAssignmentCopyWith<$Res> {
  factory _$$ClientAssignmentImplCopyWith(_$ClientAssignmentImpl value,
          $Res Function(_$ClientAssignmentImpl) then) =
      __$$ClientAssignmentImplCopyWithImpl<$Res>;
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
class __$$ClientAssignmentImplCopyWithImpl<$Res>
    extends _$ClientAssignmentCopyWithImpl<$Res, _$ClientAssignmentImpl>
    implements _$$ClientAssignmentImplCopyWith<$Res> {
  __$$ClientAssignmentImplCopyWithImpl(_$ClientAssignmentImpl _value,
      $Res Function(_$ClientAssignmentImpl) _then)
      : super(_value, _then);

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
    return _then(_$ClientAssignmentImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      clientName: null == clientName
          ? _value.clientName
          : clientName // ignore: cast_nullable_to_non_nullable
              as String,
      employeeId: null == employeeId
          ? _value.employeeId
          : employeeId // ignore: cast_nullable_to_non_nullable
              as String,
      employeeName: null == employeeName
          ? _value.employeeName
          : employeeName // ignore: cast_nullable_to_non_nullable
              as String,
      assignedDate: null == assignedDate
          ? _value.assignedDate
          : assignedDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as AssignmentStatus,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ClientAssignmentImpl implements _ClientAssignment {
  const _$ClientAssignmentImpl(
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

  factory _$ClientAssignmentImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClientAssignmentImplFromJson(json);

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

  @override
  String toString() {
    return 'ClientAssignment(id: $id, clientName: $clientName, employeeId: $employeeId, employeeName: $employeeName, assignedDate: $assignedDate, startDate: $startDate, endDate: $endDate, status: $status, notes: $notes, location: $location)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClientAssignmentImpl &&
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

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, clientName, employeeId,
      employeeName, assignedDate, startDate, endDate, status, notes, location);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ClientAssignmentImplCopyWith<_$ClientAssignmentImpl> get copyWith =>
      __$$ClientAssignmentImplCopyWithImpl<_$ClientAssignmentImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClientAssignmentImplToJson(
      this,
    );
  }
}

abstract class _ClientAssignment implements ClientAssignment {
  const factory _ClientAssignment(
      {required final String id,
      required final String clientName,
      required final String employeeId,
      required final String employeeName,
      required final DateTime assignedDate,
      final DateTime? startDate,
      final DateTime? endDate,
      required final AssignmentStatus status,
      final String? notes,
      final String? location}) = _$ClientAssignmentImpl;

  factory _ClientAssignment.fromJson(Map<String, dynamic> json) =
      _$ClientAssignmentImpl.fromJson;

  @override
  String get id;
  @override
  String get clientName;
  @override
  String get employeeId;
  @override
  String get employeeName;
  @override
  DateTime get assignedDate;
  @override
  DateTime? get startDate;
  @override
  DateTime? get endDate;
  @override
  AssignmentStatus get status;
  @override
  String? get notes;
  @override
  String? get location;
  @override
  @JsonKey(ignore: true)
  _$$ClientAssignmentImplCopyWith<_$ClientAssignmentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
