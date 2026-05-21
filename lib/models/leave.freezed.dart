// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'leave.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LeaveBalance {
  double get annualLeave;
  double get sickLeave;
  double get personalLeave;
  double get longServiceLeave;

  /// Create a copy of LeaveBalance
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LeaveBalanceCopyWith<LeaveBalance> get copyWith =>
      _$LeaveBalanceCopyWithImpl<LeaveBalance>(
          this as LeaveBalance, _$identity);

  /// Serializes this LeaveBalance to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LeaveBalance &&
            (identical(other.annualLeave, annualLeave) ||
                other.annualLeave == annualLeave) &&
            (identical(other.sickLeave, sickLeave) ||
                other.sickLeave == sickLeave) &&
            (identical(other.personalLeave, personalLeave) ||
                other.personalLeave == personalLeave) &&
            (identical(other.longServiceLeave, longServiceLeave) ||
                other.longServiceLeave == longServiceLeave));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, annualLeave, sickLeave, personalLeave, longServiceLeave);

  @override
  String toString() {
    return 'LeaveBalance(annualLeave: $annualLeave, sickLeave: $sickLeave, personalLeave: $personalLeave, longServiceLeave: $longServiceLeave)';
  }
}

/// @nodoc
abstract mixin class $LeaveBalanceCopyWith<$Res> {
  factory $LeaveBalanceCopyWith(
          LeaveBalance value, $Res Function(LeaveBalance) _then) =
      _$LeaveBalanceCopyWithImpl;
  @useResult
  $Res call(
      {double annualLeave,
      double sickLeave,
      double personalLeave,
      double longServiceLeave});
}

/// @nodoc
class _$LeaveBalanceCopyWithImpl<$Res> implements $LeaveBalanceCopyWith<$Res> {
  _$LeaveBalanceCopyWithImpl(this._self, this._then);

  final LeaveBalance _self;
  final $Res Function(LeaveBalance) _then;

  /// Create a copy of LeaveBalance
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? annualLeave = null,
    Object? sickLeave = null,
    Object? personalLeave = null,
    Object? longServiceLeave = null,
  }) {
    return _then(_self.copyWith(
      annualLeave: null == annualLeave
          ? _self.annualLeave
          : annualLeave // ignore: cast_nullable_to_non_nullable
              as double,
      sickLeave: null == sickLeave
          ? _self.sickLeave
          : sickLeave // ignore: cast_nullable_to_non_nullable
              as double,
      personalLeave: null == personalLeave
          ? _self.personalLeave
          : personalLeave // ignore: cast_nullable_to_non_nullable
              as double,
      longServiceLeave: null == longServiceLeave
          ? _self.longServiceLeave
          : longServiceLeave // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// Adds pattern-matching-related methods to [LeaveBalance].
extension LeaveBalancePatterns on LeaveBalance {
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
    TResult Function(_LeaveBalance value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LeaveBalance() when $default != null:
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
    TResult Function(_LeaveBalance value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LeaveBalance():
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
    TResult? Function(_LeaveBalance value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LeaveBalance() when $default != null:
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
    TResult Function(double annualLeave, double sickLeave, double personalLeave,
            double longServiceLeave)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LeaveBalance() when $default != null:
        return $default(_that.annualLeave, _that.sickLeave, _that.personalLeave,
            _that.longServiceLeave);
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
    TResult Function(double annualLeave, double sickLeave, double personalLeave,
            double longServiceLeave)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LeaveBalance():
        return $default(_that.annualLeave, _that.sickLeave, _that.personalLeave,
            _that.longServiceLeave);
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
    TResult? Function(double annualLeave, double sickLeave,
            double personalLeave, double longServiceLeave)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LeaveBalance() when $default != null:
        return $default(_that.annualLeave, _that.sickLeave, _that.personalLeave,
            _that.longServiceLeave);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _LeaveBalance implements LeaveBalance {
  const _LeaveBalance(
      {required this.annualLeave,
      required this.sickLeave,
      required this.personalLeave,
      required this.longServiceLeave});
  factory _LeaveBalance.fromJson(Map<String, dynamic> json) =>
      _$LeaveBalanceFromJson(json);

  @override
  final double annualLeave;
  @override
  final double sickLeave;
  @override
  final double personalLeave;
  @override
  final double longServiceLeave;

  /// Create a copy of LeaveBalance
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LeaveBalanceCopyWith<_LeaveBalance> get copyWith =>
      __$LeaveBalanceCopyWithImpl<_LeaveBalance>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$LeaveBalanceToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LeaveBalance &&
            (identical(other.annualLeave, annualLeave) ||
                other.annualLeave == annualLeave) &&
            (identical(other.sickLeave, sickLeave) ||
                other.sickLeave == sickLeave) &&
            (identical(other.personalLeave, personalLeave) ||
                other.personalLeave == personalLeave) &&
            (identical(other.longServiceLeave, longServiceLeave) ||
                other.longServiceLeave == longServiceLeave));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, annualLeave, sickLeave, personalLeave, longServiceLeave);

  @override
  String toString() {
    return 'LeaveBalance(annualLeave: $annualLeave, sickLeave: $sickLeave, personalLeave: $personalLeave, longServiceLeave: $longServiceLeave)';
  }
}

/// @nodoc
abstract mixin class _$LeaveBalanceCopyWith<$Res>
    implements $LeaveBalanceCopyWith<$Res> {
  factory _$LeaveBalanceCopyWith(
          _LeaveBalance value, $Res Function(_LeaveBalance) _then) =
      __$LeaveBalanceCopyWithImpl;
  @override
  @useResult
  $Res call(
      {double annualLeave,
      double sickLeave,
      double personalLeave,
      double longServiceLeave});
}

/// @nodoc
class __$LeaveBalanceCopyWithImpl<$Res>
    implements _$LeaveBalanceCopyWith<$Res> {
  __$LeaveBalanceCopyWithImpl(this._self, this._then);

  final _LeaveBalance _self;
  final $Res Function(_LeaveBalance) _then;

  /// Create a copy of LeaveBalance
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? annualLeave = null,
    Object? sickLeave = null,
    Object? personalLeave = null,
    Object? longServiceLeave = null,
  }) {
    return _then(_LeaveBalance(
      annualLeave: null == annualLeave
          ? _self.annualLeave
          : annualLeave // ignore: cast_nullable_to_non_nullable
              as double,
      sickLeave: null == sickLeave
          ? _self.sickLeave
          : sickLeave // ignore: cast_nullable_to_non_nullable
              as double,
      personalLeave: null == personalLeave
          ? _self.personalLeave
          : personalLeave // ignore: cast_nullable_to_non_nullable
              as double,
      longServiceLeave: null == longServiceLeave
          ? _self.longServiceLeave
          : longServiceLeave // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
mixin _$LeaveRequest {
  @JsonKey(name: '_id')
  String? get id;
  String get userId;
  String get organizationId;
  String get createdBy;
  String get leaveType;
  DateTime get startDate;
  DateTime get endDate;
  double get totalHours;
  String get reason;
  String get status;
  String? get approverId;
  DateTime? get approvedAt;
  String? get rejectionReason;
  List<LeaveAttachment>? get attachments;
  List<LeaveHistory>? get history;
  DateTime? get createdAt;
  DateTime? get updatedAt;

  /// Create a copy of LeaveRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LeaveRequestCopyWith<LeaveRequest> get copyWith =>
      _$LeaveRequestCopyWithImpl<LeaveRequest>(
          this as LeaveRequest, _$identity);

  /// Serializes this LeaveRequest to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LeaveRequest &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.leaveType, leaveType) ||
                other.leaveType == leaveType) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.totalHours, totalHours) ||
                other.totalHours == totalHours) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.approverId, approverId) ||
                other.approverId == approverId) &&
            (identical(other.approvedAt, approvedAt) ||
                other.approvedAt == approvedAt) &&
            (identical(other.rejectionReason, rejectionReason) ||
                other.rejectionReason == rejectionReason) &&
            const DeepCollectionEquality()
                .equals(other.attachments, attachments) &&
            const DeepCollectionEquality().equals(other.history, history) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      organizationId,
      createdBy,
      leaveType,
      startDate,
      endDate,
      totalHours,
      reason,
      status,
      approverId,
      approvedAt,
      rejectionReason,
      const DeepCollectionEquality().hash(attachments),
      const DeepCollectionEquality().hash(history),
      createdAt,
      updatedAt);

  @override
  String toString() {
    return 'LeaveRequest(id: $id, userId: $userId, organizationId: $organizationId, createdBy: $createdBy, leaveType: $leaveType, startDate: $startDate, endDate: $endDate, totalHours: $totalHours, reason: $reason, status: $status, approverId: $approverId, approvedAt: $approvedAt, rejectionReason: $rejectionReason, attachments: $attachments, history: $history, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class $LeaveRequestCopyWith<$Res> {
  factory $LeaveRequestCopyWith(
          LeaveRequest value, $Res Function(LeaveRequest) _then) =
      _$LeaveRequestCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      String userId,
      String organizationId,
      String createdBy,
      String leaveType,
      DateTime startDate,
      DateTime endDate,
      double totalHours,
      String reason,
      String status,
      String? approverId,
      DateTime? approvedAt,
      String? rejectionReason,
      List<LeaveAttachment>? attachments,
      List<LeaveHistory>? history,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$LeaveRequestCopyWithImpl<$Res> implements $LeaveRequestCopyWith<$Res> {
  _$LeaveRequestCopyWithImpl(this._self, this._then);

  final LeaveRequest _self;
  final $Res Function(LeaveRequest) _then;

  /// Create a copy of LeaveRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? userId = null,
    Object? organizationId = null,
    Object? createdBy = null,
    Object? leaveType = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? totalHours = null,
    Object? reason = null,
    Object? status = null,
    Object? approverId = freezed,
    Object? approvedAt = freezed,
    Object? rejectionReason = freezed,
    Object? attachments = freezed,
    Object? history = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_self.copyWith(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: null == organizationId
          ? _self.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      createdBy: null == createdBy
          ? _self.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      leaveType: null == leaveType
          ? _self.leaveType
          : leaveType // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _self.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _self.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      totalHours: null == totalHours
          ? _self.totalHours
          : totalHours // ignore: cast_nullable_to_non_nullable
              as double,
      reason: null == reason
          ? _self.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      approverId: freezed == approverId
          ? _self.approverId
          : approverId // ignore: cast_nullable_to_non_nullable
              as String?,
      approvedAt: freezed == approvedAt
          ? _self.approvedAt
          : approvedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      rejectionReason: freezed == rejectionReason
          ? _self.rejectionReason
          : rejectionReason // ignore: cast_nullable_to_non_nullable
              as String?,
      attachments: freezed == attachments
          ? _self.attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<LeaveAttachment>?,
      history: freezed == history
          ? _self.history
          : history // ignore: cast_nullable_to_non_nullable
              as List<LeaveHistory>?,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// Adds pattern-matching-related methods to [LeaveRequest].
extension LeaveRequestPatterns on LeaveRequest {
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
    TResult Function(_LeaveRequest value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LeaveRequest() when $default != null:
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
    TResult Function(_LeaveRequest value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LeaveRequest():
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
    TResult? Function(_LeaveRequest value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LeaveRequest() when $default != null:
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
            @JsonKey(name: '_id') String? id,
            String userId,
            String organizationId,
            String createdBy,
            String leaveType,
            DateTime startDate,
            DateTime endDate,
            double totalHours,
            String reason,
            String status,
            String? approverId,
            DateTime? approvedAt,
            String? rejectionReason,
            List<LeaveAttachment>? attachments,
            List<LeaveHistory>? history,
            DateTime? createdAt,
            DateTime? updatedAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LeaveRequest() when $default != null:
        return $default(
            _that.id,
            _that.userId,
            _that.organizationId,
            _that.createdBy,
            _that.leaveType,
            _that.startDate,
            _that.endDate,
            _that.totalHours,
            _that.reason,
            _that.status,
            _that.approverId,
            _that.approvedAt,
            _that.rejectionReason,
            _that.attachments,
            _that.history,
            _that.createdAt,
            _that.updatedAt);
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
            @JsonKey(name: '_id') String? id,
            String userId,
            String organizationId,
            String createdBy,
            String leaveType,
            DateTime startDate,
            DateTime endDate,
            double totalHours,
            String reason,
            String status,
            String? approverId,
            DateTime? approvedAt,
            String? rejectionReason,
            List<LeaveAttachment>? attachments,
            List<LeaveHistory>? history,
            DateTime? createdAt,
            DateTime? updatedAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LeaveRequest():
        return $default(
            _that.id,
            _that.userId,
            _that.organizationId,
            _that.createdBy,
            _that.leaveType,
            _that.startDate,
            _that.endDate,
            _that.totalHours,
            _that.reason,
            _that.status,
            _that.approverId,
            _that.approvedAt,
            _that.rejectionReason,
            _that.attachments,
            _that.history,
            _that.createdAt,
            _that.updatedAt);
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
            @JsonKey(name: '_id') String? id,
            String userId,
            String organizationId,
            String createdBy,
            String leaveType,
            DateTime startDate,
            DateTime endDate,
            double totalHours,
            String reason,
            String status,
            String? approverId,
            DateTime? approvedAt,
            String? rejectionReason,
            List<LeaveAttachment>? attachments,
            List<LeaveHistory>? history,
            DateTime? createdAt,
            DateTime? updatedAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LeaveRequest() when $default != null:
        return $default(
            _that.id,
            _that.userId,
            _that.organizationId,
            _that.createdBy,
            _that.leaveType,
            _that.startDate,
            _that.endDate,
            _that.totalHours,
            _that.reason,
            _that.status,
            _that.approverId,
            _that.approvedAt,
            _that.rejectionReason,
            _that.attachments,
            _that.history,
            _that.createdAt,
            _that.updatedAt);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _LeaveRequest implements LeaveRequest {
  const _LeaveRequest(
      {@JsonKey(name: '_id') this.id,
      required this.userId,
      required this.organizationId,
      required this.createdBy,
      required this.leaveType,
      required this.startDate,
      required this.endDate,
      required this.totalHours,
      required this.reason,
      this.status = 'Pending',
      this.approverId,
      this.approvedAt,
      this.rejectionReason,
      final List<LeaveAttachment>? attachments,
      final List<LeaveHistory>? history,
      this.createdAt,
      this.updatedAt})
      : _attachments = attachments,
        _history = history;
  factory _LeaveRequest.fromJson(Map<String, dynamic> json) =>
      _$LeaveRequestFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String? id;
  @override
  final String userId;
  @override
  final String organizationId;
  @override
  final String createdBy;
  @override
  final String leaveType;
  @override
  final DateTime startDate;
  @override
  final DateTime endDate;
  @override
  final double totalHours;
  @override
  final String reason;
  @override
  @JsonKey()
  final String status;
  @override
  final String? approverId;
  @override
  final DateTime? approvedAt;
  @override
  final String? rejectionReason;
  final List<LeaveAttachment>? _attachments;
  @override
  List<LeaveAttachment>? get attachments {
    final value = _attachments;
    if (value == null) return null;
    if (_attachments is EqualUnmodifiableListView) return _attachments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<LeaveHistory>? _history;
  @override
  List<LeaveHistory>? get history {
    final value = _history;
    if (value == null) return null;
    if (_history is EqualUnmodifiableListView) return _history;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  /// Create a copy of LeaveRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LeaveRequestCopyWith<_LeaveRequest> get copyWith =>
      __$LeaveRequestCopyWithImpl<_LeaveRequest>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$LeaveRequestToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LeaveRequest &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.leaveType, leaveType) ||
                other.leaveType == leaveType) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.totalHours, totalHours) ||
                other.totalHours == totalHours) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.approverId, approverId) ||
                other.approverId == approverId) &&
            (identical(other.approvedAt, approvedAt) ||
                other.approvedAt == approvedAt) &&
            (identical(other.rejectionReason, rejectionReason) ||
                other.rejectionReason == rejectionReason) &&
            const DeepCollectionEquality()
                .equals(other._attachments, _attachments) &&
            const DeepCollectionEquality().equals(other._history, _history) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      organizationId,
      createdBy,
      leaveType,
      startDate,
      endDate,
      totalHours,
      reason,
      status,
      approverId,
      approvedAt,
      rejectionReason,
      const DeepCollectionEquality().hash(_attachments),
      const DeepCollectionEquality().hash(_history),
      createdAt,
      updatedAt);

  @override
  String toString() {
    return 'LeaveRequest(id: $id, userId: $userId, organizationId: $organizationId, createdBy: $createdBy, leaveType: $leaveType, startDate: $startDate, endDate: $endDate, totalHours: $totalHours, reason: $reason, status: $status, approverId: $approverId, approvedAt: $approvedAt, rejectionReason: $rejectionReason, attachments: $attachments, history: $history, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class _$LeaveRequestCopyWith<$Res>
    implements $LeaveRequestCopyWith<$Res> {
  factory _$LeaveRequestCopyWith(
          _LeaveRequest value, $Res Function(_LeaveRequest) _then) =
      __$LeaveRequestCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      String userId,
      String organizationId,
      String createdBy,
      String leaveType,
      DateTime startDate,
      DateTime endDate,
      double totalHours,
      String reason,
      String status,
      String? approverId,
      DateTime? approvedAt,
      String? rejectionReason,
      List<LeaveAttachment>? attachments,
      List<LeaveHistory>? history,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$LeaveRequestCopyWithImpl<$Res>
    implements _$LeaveRequestCopyWith<$Res> {
  __$LeaveRequestCopyWithImpl(this._self, this._then);

  final _LeaveRequest _self;
  final $Res Function(_LeaveRequest) _then;

  /// Create a copy of LeaveRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = freezed,
    Object? userId = null,
    Object? organizationId = null,
    Object? createdBy = null,
    Object? leaveType = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? totalHours = null,
    Object? reason = null,
    Object? status = null,
    Object? approverId = freezed,
    Object? approvedAt = freezed,
    Object? rejectionReason = freezed,
    Object? attachments = freezed,
    Object? history = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_LeaveRequest(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: null == organizationId
          ? _self.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      createdBy: null == createdBy
          ? _self.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      leaveType: null == leaveType
          ? _self.leaveType
          : leaveType // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _self.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _self.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      totalHours: null == totalHours
          ? _self.totalHours
          : totalHours // ignore: cast_nullable_to_non_nullable
              as double,
      reason: null == reason
          ? _self.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      approverId: freezed == approverId
          ? _self.approverId
          : approverId // ignore: cast_nullable_to_non_nullable
              as String?,
      approvedAt: freezed == approvedAt
          ? _self.approvedAt
          : approvedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      rejectionReason: freezed == rejectionReason
          ? _self.rejectionReason
          : rejectionReason // ignore: cast_nullable_to_non_nullable
              as String?,
      attachments: freezed == attachments
          ? _self._attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<LeaveAttachment>?,
      history: freezed == history
          ? _self._history
          : history // ignore: cast_nullable_to_non_nullable
              as List<LeaveHistory>?,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
mixin _$LeaveAttachment {
  String get filename;
  String get url;
  DateTime get uploadedAt;

  /// Create a copy of LeaveAttachment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LeaveAttachmentCopyWith<LeaveAttachment> get copyWith =>
      _$LeaveAttachmentCopyWithImpl<LeaveAttachment>(
          this as LeaveAttachment, _$identity);

  /// Serializes this LeaveAttachment to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LeaveAttachment &&
            (identical(other.filename, filename) ||
                other.filename == filename) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.uploadedAt, uploadedAt) ||
                other.uploadedAt == uploadedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, filename, url, uploadedAt);

  @override
  String toString() {
    return 'LeaveAttachment(filename: $filename, url: $url, uploadedAt: $uploadedAt)';
  }
}

/// @nodoc
abstract mixin class $LeaveAttachmentCopyWith<$Res> {
  factory $LeaveAttachmentCopyWith(
          LeaveAttachment value, $Res Function(LeaveAttachment) _then) =
      _$LeaveAttachmentCopyWithImpl;
  @useResult
  $Res call({String filename, String url, DateTime uploadedAt});
}

/// @nodoc
class _$LeaveAttachmentCopyWithImpl<$Res>
    implements $LeaveAttachmentCopyWith<$Res> {
  _$LeaveAttachmentCopyWithImpl(this._self, this._then);

  final LeaveAttachment _self;
  final $Res Function(LeaveAttachment) _then;

  /// Create a copy of LeaveAttachment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? filename = null,
    Object? url = null,
    Object? uploadedAt = null,
  }) {
    return _then(_self.copyWith(
      filename: null == filename
          ? _self.filename
          : filename // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _self.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      uploadedAt: null == uploadedAt
          ? _self.uploadedAt
          : uploadedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// Adds pattern-matching-related methods to [LeaveAttachment].
extension LeaveAttachmentPatterns on LeaveAttachment {
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
    TResult Function(_LeaveAttachment value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LeaveAttachment() when $default != null:
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
    TResult Function(_LeaveAttachment value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LeaveAttachment():
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
    TResult? Function(_LeaveAttachment value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LeaveAttachment() when $default != null:
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
    TResult Function(String filename, String url, DateTime uploadedAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LeaveAttachment() when $default != null:
        return $default(_that.filename, _that.url, _that.uploadedAt);
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
    TResult Function(String filename, String url, DateTime uploadedAt) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LeaveAttachment():
        return $default(_that.filename, _that.url, _that.uploadedAt);
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
    TResult? Function(String filename, String url, DateTime uploadedAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LeaveAttachment() when $default != null:
        return $default(_that.filename, _that.url, _that.uploadedAt);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _LeaveAttachment implements LeaveAttachment {
  const _LeaveAttachment(
      {required this.filename, required this.url, required this.uploadedAt});
  factory _LeaveAttachment.fromJson(Map<String, dynamic> json) =>
      _$LeaveAttachmentFromJson(json);

  @override
  final String filename;
  @override
  final String url;
  @override
  final DateTime uploadedAt;

  /// Create a copy of LeaveAttachment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LeaveAttachmentCopyWith<_LeaveAttachment> get copyWith =>
      __$LeaveAttachmentCopyWithImpl<_LeaveAttachment>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$LeaveAttachmentToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LeaveAttachment &&
            (identical(other.filename, filename) ||
                other.filename == filename) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.uploadedAt, uploadedAt) ||
                other.uploadedAt == uploadedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, filename, url, uploadedAt);

  @override
  String toString() {
    return 'LeaveAttachment(filename: $filename, url: $url, uploadedAt: $uploadedAt)';
  }
}

/// @nodoc
abstract mixin class _$LeaveAttachmentCopyWith<$Res>
    implements $LeaveAttachmentCopyWith<$Res> {
  factory _$LeaveAttachmentCopyWith(
          _LeaveAttachment value, $Res Function(_LeaveAttachment) _then) =
      __$LeaveAttachmentCopyWithImpl;
  @override
  @useResult
  $Res call({String filename, String url, DateTime uploadedAt});
}

/// @nodoc
class __$LeaveAttachmentCopyWithImpl<$Res>
    implements _$LeaveAttachmentCopyWith<$Res> {
  __$LeaveAttachmentCopyWithImpl(this._self, this._then);

  final _LeaveAttachment _self;
  final $Res Function(_LeaveAttachment) _then;

  /// Create a copy of LeaveAttachment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? filename = null,
    Object? url = null,
    Object? uploadedAt = null,
  }) {
    return _then(_LeaveAttachment(
      filename: null == filename
          ? _self.filename
          : filename // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _self.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      uploadedAt: null == uploadedAt
          ? _self.uploadedAt
          : uploadedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
mixin _$LeaveHistory {
  String get action;
  String get performedBy;
  DateTime get timestamp;
  String? get status;
  String? get reason;

  /// Create a copy of LeaveHistory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LeaveHistoryCopyWith<LeaveHistory> get copyWith =>
      _$LeaveHistoryCopyWithImpl<LeaveHistory>(
          this as LeaveHistory, _$identity);

  /// Serializes this LeaveHistory to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LeaveHistory &&
            (identical(other.action, action) || other.action == action) &&
            (identical(other.performedBy, performedBy) ||
                other.performedBy == performedBy) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.reason, reason) || other.reason == reason));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, action, performedBy, timestamp, status, reason);

  @override
  String toString() {
    return 'LeaveHistory(action: $action, performedBy: $performedBy, timestamp: $timestamp, status: $status, reason: $reason)';
  }
}

/// @nodoc
abstract mixin class $LeaveHistoryCopyWith<$Res> {
  factory $LeaveHistoryCopyWith(
          LeaveHistory value, $Res Function(LeaveHistory) _then) =
      _$LeaveHistoryCopyWithImpl;
  @useResult
  $Res call(
      {String action,
      String performedBy,
      DateTime timestamp,
      String? status,
      String? reason});
}

/// @nodoc
class _$LeaveHistoryCopyWithImpl<$Res> implements $LeaveHistoryCopyWith<$Res> {
  _$LeaveHistoryCopyWithImpl(this._self, this._then);

  final LeaveHistory _self;
  final $Res Function(LeaveHistory) _then;

  /// Create a copy of LeaveHistory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? action = null,
    Object? performedBy = null,
    Object? timestamp = null,
    Object? status = freezed,
    Object? reason = freezed,
  }) {
    return _then(_self.copyWith(
      action: null == action
          ? _self.action
          : action // ignore: cast_nullable_to_non_nullable
              as String,
      performedBy: null == performedBy
          ? _self.performedBy
          : performedBy // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: freezed == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      reason: freezed == reason
          ? _self.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [LeaveHistory].
extension LeaveHistoryPatterns on LeaveHistory {
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
    TResult Function(_LeaveHistory value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LeaveHistory() when $default != null:
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
    TResult Function(_LeaveHistory value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LeaveHistory():
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
    TResult? Function(_LeaveHistory value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LeaveHistory() when $default != null:
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
    TResult Function(String action, String performedBy, DateTime timestamp,
            String? status, String? reason)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LeaveHistory() when $default != null:
        return $default(_that.action, _that.performedBy, _that.timestamp,
            _that.status, _that.reason);
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
    TResult Function(String action, String performedBy, DateTime timestamp,
            String? status, String? reason)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LeaveHistory():
        return $default(_that.action, _that.performedBy, _that.timestamp,
            _that.status, _that.reason);
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
    TResult? Function(String action, String performedBy, DateTime timestamp,
            String? status, String? reason)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LeaveHistory() when $default != null:
        return $default(_that.action, _that.performedBy, _that.timestamp,
            _that.status, _that.reason);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _LeaveHistory implements LeaveHistory {
  const _LeaveHistory(
      {required this.action,
      required this.performedBy,
      required this.timestamp,
      this.status,
      this.reason});
  factory _LeaveHistory.fromJson(Map<String, dynamic> json) =>
      _$LeaveHistoryFromJson(json);

  @override
  final String action;
  @override
  final String performedBy;
  @override
  final DateTime timestamp;
  @override
  final String? status;
  @override
  final String? reason;

  /// Create a copy of LeaveHistory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LeaveHistoryCopyWith<_LeaveHistory> get copyWith =>
      __$LeaveHistoryCopyWithImpl<_LeaveHistory>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$LeaveHistoryToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LeaveHistory &&
            (identical(other.action, action) || other.action == action) &&
            (identical(other.performedBy, performedBy) ||
                other.performedBy == performedBy) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.reason, reason) || other.reason == reason));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, action, performedBy, timestamp, status, reason);

  @override
  String toString() {
    return 'LeaveHistory(action: $action, performedBy: $performedBy, timestamp: $timestamp, status: $status, reason: $reason)';
  }
}

/// @nodoc
abstract mixin class _$LeaveHistoryCopyWith<$Res>
    implements $LeaveHistoryCopyWith<$Res> {
  factory _$LeaveHistoryCopyWith(
          _LeaveHistory value, $Res Function(_LeaveHistory) _then) =
      __$LeaveHistoryCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String action,
      String performedBy,
      DateTime timestamp,
      String? status,
      String? reason});
}

/// @nodoc
class __$LeaveHistoryCopyWithImpl<$Res>
    implements _$LeaveHistoryCopyWith<$Res> {
  __$LeaveHistoryCopyWithImpl(this._self, this._then);

  final _LeaveHistory _self;
  final $Res Function(_LeaveHistory) _then;

  /// Create a copy of LeaveHistory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? action = null,
    Object? performedBy = null,
    Object? timestamp = null,
    Object? status = freezed,
    Object? reason = freezed,
  }) {
    return _then(_LeaveHistory(
      action: null == action
          ? _self.action
          : action // ignore: cast_nullable_to_non_nullable
              as String,
      performedBy: null == performedBy
          ? _self.performedBy
          : performedBy // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: freezed == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      reason: freezed == reason
          ? _self.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$PublicHoliday {
  @JsonKey(name: '_id')
  String? get id;
  String get name;
  DateTime get date;
  String get day;
  String? get organizationId;
  bool get isCustom;
  String? get state;

  /// Create a copy of PublicHoliday
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PublicHolidayCopyWith<PublicHoliday> get copyWith =>
      _$PublicHolidayCopyWithImpl<PublicHoliday>(
          this as PublicHoliday, _$identity);

  /// Serializes this PublicHoliday to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PublicHoliday &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.day, day) || other.day == day) &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.isCustom, isCustom) ||
                other.isCustom == isCustom) &&
            (identical(other.state, state) || other.state == state));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, date, day, organizationId, isCustom, state);

  @override
  String toString() {
    return 'PublicHoliday(id: $id, name: $name, date: $date, day: $day, organizationId: $organizationId, isCustom: $isCustom, state: $state)';
  }
}

/// @nodoc
abstract mixin class $PublicHolidayCopyWith<$Res> {
  factory $PublicHolidayCopyWith(
          PublicHoliday value, $Res Function(PublicHoliday) _then) =
      _$PublicHolidayCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      String name,
      DateTime date,
      String day,
      String? organizationId,
      bool isCustom,
      String? state});
}

/// @nodoc
class _$PublicHolidayCopyWithImpl<$Res>
    implements $PublicHolidayCopyWith<$Res> {
  _$PublicHolidayCopyWithImpl(this._self, this._then);

  final PublicHoliday _self;
  final $Res Function(PublicHoliday) _then;

  /// Create a copy of PublicHoliday
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? date = null,
    Object? day = null,
    Object? organizationId = freezed,
    Object? isCustom = null,
    Object? state = freezed,
  }) {
    return _then(_self.copyWith(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      day: null == day
          ? _self.day
          : day // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: freezed == organizationId
          ? _self.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String?,
      isCustom: null == isCustom
          ? _self.isCustom
          : isCustom // ignore: cast_nullable_to_non_nullable
              as bool,
      state: freezed == state
          ? _self.state
          : state // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [PublicHoliday].
extension PublicHolidayPatterns on PublicHoliday {
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
    TResult Function(_PublicHoliday value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PublicHoliday() when $default != null:
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
    TResult Function(_PublicHoliday value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PublicHoliday():
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
    TResult? Function(_PublicHoliday value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PublicHoliday() when $default != null:
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
            @JsonKey(name: '_id') String? id,
            String name,
            DateTime date,
            String day,
            String? organizationId,
            bool isCustom,
            String? state)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PublicHoliday() when $default != null:
        return $default(_that.id, _that.name, _that.date, _that.day,
            _that.organizationId, _that.isCustom, _that.state);
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
            @JsonKey(name: '_id') String? id,
            String name,
            DateTime date,
            String day,
            String? organizationId,
            bool isCustom,
            String? state)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PublicHoliday():
        return $default(_that.id, _that.name, _that.date, _that.day,
            _that.organizationId, _that.isCustom, _that.state);
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
            @JsonKey(name: '_id') String? id,
            String name,
            DateTime date,
            String day,
            String? organizationId,
            bool isCustom,
            String? state)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PublicHoliday() when $default != null:
        return $default(_that.id, _that.name, _that.date, _that.day,
            _that.organizationId, _that.isCustom, _that.state);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _PublicHoliday implements PublicHoliday {
  const _PublicHoliday(
      {@JsonKey(name: '_id') this.id,
      required this.name,
      required this.date,
      required this.day,
      this.organizationId,
      this.isCustom = false,
      this.state});
  factory _PublicHoliday.fromJson(Map<String, dynamic> json) =>
      _$PublicHolidayFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String? id;
  @override
  final String name;
  @override
  final DateTime date;
  @override
  final String day;
  @override
  final String? organizationId;
  @override
  @JsonKey()
  final bool isCustom;
  @override
  final String? state;

  /// Create a copy of PublicHoliday
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PublicHolidayCopyWith<_PublicHoliday> get copyWith =>
      __$PublicHolidayCopyWithImpl<_PublicHoliday>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PublicHolidayToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PublicHoliday &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.day, day) || other.day == day) &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.isCustom, isCustom) ||
                other.isCustom == isCustom) &&
            (identical(other.state, state) || other.state == state));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, date, day, organizationId, isCustom, state);

  @override
  String toString() {
    return 'PublicHoliday(id: $id, name: $name, date: $date, day: $day, organizationId: $organizationId, isCustom: $isCustom, state: $state)';
  }
}

/// @nodoc
abstract mixin class _$PublicHolidayCopyWith<$Res>
    implements $PublicHolidayCopyWith<$Res> {
  factory _$PublicHolidayCopyWith(
          _PublicHoliday value, $Res Function(_PublicHoliday) _then) =
      __$PublicHolidayCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      String name,
      DateTime date,
      String day,
      String? organizationId,
      bool isCustom,
      String? state});
}

/// @nodoc
class __$PublicHolidayCopyWithImpl<$Res>
    implements _$PublicHolidayCopyWith<$Res> {
  __$PublicHolidayCopyWithImpl(this._self, this._then);

  final _PublicHoliday _self;
  final $Res Function(_PublicHoliday) _then;

  /// Create a copy of PublicHoliday
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? date = null,
    Object? day = null,
    Object? organizationId = freezed,
    Object? isCustom = null,
    Object? state = freezed,
  }) {
    return _then(_PublicHoliday(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      day: null == day
          ? _self.day
          : day // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: freezed == organizationId
          ? _self.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String?,
      isCustom: null == isCustom
          ? _self.isCustom
          : isCustom // ignore: cast_nullable_to_non_nullable
              as bool,
      state: freezed == state
          ? _self.state
          : state // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$LeaveForecast {
  LeaveBalance get forecast;
  Map<String, double> get accrualRate;

  /// Create a copy of LeaveForecast
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LeaveForecastCopyWith<LeaveForecast> get copyWith =>
      _$LeaveForecastCopyWithImpl<LeaveForecast>(
          this as LeaveForecast, _$identity);

  /// Serializes this LeaveForecast to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LeaveForecast &&
            (identical(other.forecast, forecast) ||
                other.forecast == forecast) &&
            const DeepCollectionEquality()
                .equals(other.accrualRate, accrualRate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, forecast, const DeepCollectionEquality().hash(accrualRate));

  @override
  String toString() {
    return 'LeaveForecast(forecast: $forecast, accrualRate: $accrualRate)';
  }
}

/// @nodoc
abstract mixin class $LeaveForecastCopyWith<$Res> {
  factory $LeaveForecastCopyWith(
          LeaveForecast value, $Res Function(LeaveForecast) _then) =
      _$LeaveForecastCopyWithImpl;
  @useResult
  $Res call({LeaveBalance forecast, Map<String, double> accrualRate});

  $LeaveBalanceCopyWith<$Res> get forecast;
}

/// @nodoc
class _$LeaveForecastCopyWithImpl<$Res>
    implements $LeaveForecastCopyWith<$Res> {
  _$LeaveForecastCopyWithImpl(this._self, this._then);

  final LeaveForecast _self;
  final $Res Function(LeaveForecast) _then;

  /// Create a copy of LeaveForecast
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? forecast = null,
    Object? accrualRate = null,
  }) {
    return _then(_self.copyWith(
      forecast: null == forecast
          ? _self.forecast
          : forecast // ignore: cast_nullable_to_non_nullable
              as LeaveBalance,
      accrualRate: null == accrualRate
          ? _self.accrualRate
          : accrualRate // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
    ));
  }

  /// Create a copy of LeaveForecast
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LeaveBalanceCopyWith<$Res> get forecast {
    return $LeaveBalanceCopyWith<$Res>(_self.forecast, (value) {
      return _then(_self.copyWith(forecast: value));
    });
  }
}

/// Adds pattern-matching-related methods to [LeaveForecast].
extension LeaveForecastPatterns on LeaveForecast {
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
    TResult Function(_LeaveForecast value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LeaveForecast() when $default != null:
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
    TResult Function(_LeaveForecast value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LeaveForecast():
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
    TResult? Function(_LeaveForecast value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LeaveForecast() when $default != null:
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
    TResult Function(LeaveBalance forecast, Map<String, double> accrualRate)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LeaveForecast() when $default != null:
        return $default(_that.forecast, _that.accrualRate);
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
    TResult Function(LeaveBalance forecast, Map<String, double> accrualRate)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LeaveForecast():
        return $default(_that.forecast, _that.accrualRate);
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
    TResult? Function(LeaveBalance forecast, Map<String, double> accrualRate)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LeaveForecast() when $default != null:
        return $default(_that.forecast, _that.accrualRate);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _LeaveForecast implements LeaveForecast {
  const _LeaveForecast(
      {required this.forecast, required final Map<String, double> accrualRate})
      : _accrualRate = accrualRate;
  factory _LeaveForecast.fromJson(Map<String, dynamic> json) =>
      _$LeaveForecastFromJson(json);

  @override
  final LeaveBalance forecast;
  final Map<String, double> _accrualRate;
  @override
  Map<String, double> get accrualRate {
    if (_accrualRate is EqualUnmodifiableMapView) return _accrualRate;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_accrualRate);
  }

  /// Create a copy of LeaveForecast
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LeaveForecastCopyWith<_LeaveForecast> get copyWith =>
      __$LeaveForecastCopyWithImpl<_LeaveForecast>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$LeaveForecastToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LeaveForecast &&
            (identical(other.forecast, forecast) ||
                other.forecast == forecast) &&
            const DeepCollectionEquality()
                .equals(other._accrualRate, _accrualRate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, forecast, const DeepCollectionEquality().hash(_accrualRate));

  @override
  String toString() {
    return 'LeaveForecast(forecast: $forecast, accrualRate: $accrualRate)';
  }
}

/// @nodoc
abstract mixin class _$LeaveForecastCopyWith<$Res>
    implements $LeaveForecastCopyWith<$Res> {
  factory _$LeaveForecastCopyWith(
          _LeaveForecast value, $Res Function(_LeaveForecast) _then) =
      __$LeaveForecastCopyWithImpl;
  @override
  @useResult
  $Res call({LeaveBalance forecast, Map<String, double> accrualRate});

  @override
  $LeaveBalanceCopyWith<$Res> get forecast;
}

/// @nodoc
class __$LeaveForecastCopyWithImpl<$Res>
    implements _$LeaveForecastCopyWith<$Res> {
  __$LeaveForecastCopyWithImpl(this._self, this._then);

  final _LeaveForecast _self;
  final $Res Function(_LeaveForecast) _then;

  /// Create a copy of LeaveForecast
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? forecast = null,
    Object? accrualRate = null,
  }) {
    return _then(_LeaveForecast(
      forecast: null == forecast
          ? _self.forecast
          : forecast // ignore: cast_nullable_to_non_nullable
              as LeaveBalance,
      accrualRate: null == accrualRate
          ? _self._accrualRate
          : accrualRate // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
    ));
  }

  /// Create a copy of LeaveForecast
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LeaveBalanceCopyWith<$Res> get forecast {
    return $LeaveBalanceCopyWith<$Res>(_self.forecast, (value) {
      return _then(_self.copyWith(forecast: value));
    });
  }
}

// dart format on
