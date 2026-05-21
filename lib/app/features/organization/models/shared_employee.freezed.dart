// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shared_employee.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SharedEmployeeAssignment {
  String get id;
  String get employeeId;
  String get organizationId;
  String get assignmentType;
  double get costAllocation;
  double get hourlyRate;
  DateTime get startDate;
  DateTime? get endDate;
  String get status;
  String? get notes;

  /// Create a copy of SharedEmployeeAssignment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SharedEmployeeAssignmentCopyWith<SharedEmployeeAssignment> get copyWith =>
      _$SharedEmployeeAssignmentCopyWithImpl<SharedEmployeeAssignment>(
          this as SharedEmployeeAssignment, _$identity);

  /// Serializes this SharedEmployeeAssignment to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SharedEmployeeAssignment &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.employeeId, employeeId) ||
                other.employeeId == employeeId) &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.assignmentType, assignmentType) ||
                other.assignmentType == assignmentType) &&
            (identical(other.costAllocation, costAllocation) ||
                other.costAllocation == costAllocation) &&
            (identical(other.hourlyRate, hourlyRate) ||
                other.hourlyRate == hourlyRate) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      employeeId,
      organizationId,
      assignmentType,
      costAllocation,
      hourlyRate,
      startDate,
      endDate,
      status,
      notes);

  @override
  String toString() {
    return 'SharedEmployeeAssignment(id: $id, employeeId: $employeeId, organizationId: $organizationId, assignmentType: $assignmentType, costAllocation: $costAllocation, hourlyRate: $hourlyRate, startDate: $startDate, endDate: $endDate, status: $status, notes: $notes)';
  }
}

/// @nodoc
abstract mixin class $SharedEmployeeAssignmentCopyWith<$Res> {
  factory $SharedEmployeeAssignmentCopyWith(SharedEmployeeAssignment value,
          $Res Function(SharedEmployeeAssignment) _then) =
      _$SharedEmployeeAssignmentCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String employeeId,
      String organizationId,
      String assignmentType,
      double costAllocation,
      double hourlyRate,
      DateTime startDate,
      DateTime? endDate,
      String status,
      String? notes});
}

/// @nodoc
class _$SharedEmployeeAssignmentCopyWithImpl<$Res>
    implements $SharedEmployeeAssignmentCopyWith<$Res> {
  _$SharedEmployeeAssignmentCopyWithImpl(this._self, this._then);

  final SharedEmployeeAssignment _self;
  final $Res Function(SharedEmployeeAssignment) _then;

  /// Create a copy of SharedEmployeeAssignment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? employeeId = null,
    Object? organizationId = null,
    Object? assignmentType = null,
    Object? costAllocation = null,
    Object? hourlyRate = null,
    Object? startDate = null,
    Object? endDate = freezed,
    Object? status = null,
    Object? notes = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      employeeId: null == employeeId
          ? _self.employeeId
          : employeeId // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: null == organizationId
          ? _self.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      assignmentType: null == assignmentType
          ? _self.assignmentType
          : assignmentType // ignore: cast_nullable_to_non_nullable
              as String,
      costAllocation: null == costAllocation
          ? _self.costAllocation
          : costAllocation // ignore: cast_nullable_to_non_nullable
              as double,
      hourlyRate: null == hourlyRate
          ? _self.hourlyRate
          : hourlyRate // ignore: cast_nullable_to_non_nullable
              as double,
      startDate: null == startDate
          ? _self.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: freezed == endDate
          ? _self.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      notes: freezed == notes
          ? _self.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [SharedEmployeeAssignment].
extension SharedEmployeeAssignmentPatterns on SharedEmployeeAssignment {
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
    TResult Function(_SharedEmployeeAssignment value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SharedEmployeeAssignment() when $default != null:
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
    TResult Function(_SharedEmployeeAssignment value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SharedEmployeeAssignment():
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
    TResult? Function(_SharedEmployeeAssignment value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SharedEmployeeAssignment() when $default != null:
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
            String employeeId,
            String organizationId,
            String assignmentType,
            double costAllocation,
            double hourlyRate,
            DateTime startDate,
            DateTime? endDate,
            String status,
            String? notes)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SharedEmployeeAssignment() when $default != null:
        return $default(
            _that.id,
            _that.employeeId,
            _that.organizationId,
            _that.assignmentType,
            _that.costAllocation,
            _that.hourlyRate,
            _that.startDate,
            _that.endDate,
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
            String employeeId,
            String organizationId,
            String assignmentType,
            double costAllocation,
            double hourlyRate,
            DateTime startDate,
            DateTime? endDate,
            String status,
            String? notes)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SharedEmployeeAssignment():
        return $default(
            _that.id,
            _that.employeeId,
            _that.organizationId,
            _that.assignmentType,
            _that.costAllocation,
            _that.hourlyRate,
            _that.startDate,
            _that.endDate,
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
            String employeeId,
            String organizationId,
            String assignmentType,
            double costAllocation,
            double hourlyRate,
            DateTime startDate,
            DateTime? endDate,
            String status,
            String? notes)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SharedEmployeeAssignment() when $default != null:
        return $default(
            _that.id,
            _that.employeeId,
            _that.organizationId,
            _that.assignmentType,
            _that.costAllocation,
            _that.hourlyRate,
            _that.startDate,
            _that.endDate,
            _that.status,
            _that.notes);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _SharedEmployeeAssignment implements SharedEmployeeAssignment {
  const _SharedEmployeeAssignment(
      {required this.id,
      required this.employeeId,
      required this.organizationId,
      required this.assignmentType,
      this.costAllocation = 100,
      this.hourlyRate = 0,
      required this.startDate,
      this.endDate,
      this.status = 'active',
      this.notes});
  factory _SharedEmployeeAssignment.fromJson(Map<String, dynamic> json) =>
      _$SharedEmployeeAssignmentFromJson(json);

  @override
  final String id;
  @override
  final String employeeId;
  @override
  final String organizationId;
  @override
  final String assignmentType;
  @override
  @JsonKey()
  final double costAllocation;
  @override
  @JsonKey()
  final double hourlyRate;
  @override
  final DateTime startDate;
  @override
  final DateTime? endDate;
  @override
  @JsonKey()
  final String status;
  @override
  final String? notes;

  /// Create a copy of SharedEmployeeAssignment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SharedEmployeeAssignmentCopyWith<_SharedEmployeeAssignment> get copyWith =>
      __$SharedEmployeeAssignmentCopyWithImpl<_SharedEmployeeAssignment>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SharedEmployeeAssignmentToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SharedEmployeeAssignment &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.employeeId, employeeId) ||
                other.employeeId == employeeId) &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.assignmentType, assignmentType) ||
                other.assignmentType == assignmentType) &&
            (identical(other.costAllocation, costAllocation) ||
                other.costAllocation == costAllocation) &&
            (identical(other.hourlyRate, hourlyRate) ||
                other.hourlyRate == hourlyRate) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      employeeId,
      organizationId,
      assignmentType,
      costAllocation,
      hourlyRate,
      startDate,
      endDate,
      status,
      notes);

  @override
  String toString() {
    return 'SharedEmployeeAssignment(id: $id, employeeId: $employeeId, organizationId: $organizationId, assignmentType: $assignmentType, costAllocation: $costAllocation, hourlyRate: $hourlyRate, startDate: $startDate, endDate: $endDate, status: $status, notes: $notes)';
  }
}

/// @nodoc
abstract mixin class _$SharedEmployeeAssignmentCopyWith<$Res>
    implements $SharedEmployeeAssignmentCopyWith<$Res> {
  factory _$SharedEmployeeAssignmentCopyWith(_SharedEmployeeAssignment value,
          $Res Function(_SharedEmployeeAssignment) _then) =
      __$SharedEmployeeAssignmentCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String employeeId,
      String organizationId,
      String assignmentType,
      double costAllocation,
      double hourlyRate,
      DateTime startDate,
      DateTime? endDate,
      String status,
      String? notes});
}

/// @nodoc
class __$SharedEmployeeAssignmentCopyWithImpl<$Res>
    implements _$SharedEmployeeAssignmentCopyWith<$Res> {
  __$SharedEmployeeAssignmentCopyWithImpl(this._self, this._then);

  final _SharedEmployeeAssignment _self;
  final $Res Function(_SharedEmployeeAssignment) _then;

  /// Create a copy of SharedEmployeeAssignment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? employeeId = null,
    Object? organizationId = null,
    Object? assignmentType = null,
    Object? costAllocation = null,
    Object? hourlyRate = null,
    Object? startDate = null,
    Object? endDate = freezed,
    Object? status = null,
    Object? notes = freezed,
  }) {
    return _then(_SharedEmployeeAssignment(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      employeeId: null == employeeId
          ? _self.employeeId
          : employeeId // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: null == organizationId
          ? _self.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      assignmentType: null == assignmentType
          ? _self.assignmentType
          : assignmentType // ignore: cast_nullable_to_non_nullable
              as String,
      costAllocation: null == costAllocation
          ? _self.costAllocation
          : costAllocation // ignore: cast_nullable_to_non_nullable
              as double,
      hourlyRate: null == hourlyRate
          ? _self.hourlyRate
          : hourlyRate // ignore: cast_nullable_to_non_nullable
              as double,
      startDate: null == startDate
          ? _self.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: freezed == endDate
          ? _self.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      notes: freezed == notes
          ? _self.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
