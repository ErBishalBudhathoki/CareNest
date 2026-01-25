// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'leave.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LeaveBalance _$LeaveBalanceFromJson(Map<String, dynamic> json) {
  return _LeaveBalance.fromJson(json);
}

/// @nodoc
mixin _$LeaveBalance {
  double get annualLeave => throw _privateConstructorUsedError;
  double get sickLeave => throw _privateConstructorUsedError;
  double get personalLeave => throw _privateConstructorUsedError;
  double get longServiceLeave => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LeaveBalanceCopyWith<LeaveBalance> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LeaveBalanceCopyWith<$Res> {
  factory $LeaveBalanceCopyWith(
          LeaveBalance value, $Res Function(LeaveBalance) then) =
      _$LeaveBalanceCopyWithImpl<$Res, LeaveBalance>;
  @useResult
  $Res call(
      {double annualLeave,
      double sickLeave,
      double personalLeave,
      double longServiceLeave});
}

/// @nodoc
class _$LeaveBalanceCopyWithImpl<$Res, $Val extends LeaveBalance>
    implements $LeaveBalanceCopyWith<$Res> {
  _$LeaveBalanceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? annualLeave = null,
    Object? sickLeave = null,
    Object? personalLeave = null,
    Object? longServiceLeave = null,
  }) {
    return _then(_value.copyWith(
      annualLeave: null == annualLeave
          ? _value.annualLeave
          : annualLeave // ignore: cast_nullable_to_non_nullable
              as double,
      sickLeave: null == sickLeave
          ? _value.sickLeave
          : sickLeave // ignore: cast_nullable_to_non_nullable
              as double,
      personalLeave: null == personalLeave
          ? _value.personalLeave
          : personalLeave // ignore: cast_nullable_to_non_nullable
              as double,
      longServiceLeave: null == longServiceLeave
          ? _value.longServiceLeave
          : longServiceLeave // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LeaveBalanceImplCopyWith<$Res>
    implements $LeaveBalanceCopyWith<$Res> {
  factory _$$LeaveBalanceImplCopyWith(
          _$LeaveBalanceImpl value, $Res Function(_$LeaveBalanceImpl) then) =
      __$$LeaveBalanceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double annualLeave,
      double sickLeave,
      double personalLeave,
      double longServiceLeave});
}

/// @nodoc
class __$$LeaveBalanceImplCopyWithImpl<$Res>
    extends _$LeaveBalanceCopyWithImpl<$Res, _$LeaveBalanceImpl>
    implements _$$LeaveBalanceImplCopyWith<$Res> {
  __$$LeaveBalanceImplCopyWithImpl(
      _$LeaveBalanceImpl _value, $Res Function(_$LeaveBalanceImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? annualLeave = null,
    Object? sickLeave = null,
    Object? personalLeave = null,
    Object? longServiceLeave = null,
  }) {
    return _then(_$LeaveBalanceImpl(
      annualLeave: null == annualLeave
          ? _value.annualLeave
          : annualLeave // ignore: cast_nullable_to_non_nullable
              as double,
      sickLeave: null == sickLeave
          ? _value.sickLeave
          : sickLeave // ignore: cast_nullable_to_non_nullable
              as double,
      personalLeave: null == personalLeave
          ? _value.personalLeave
          : personalLeave // ignore: cast_nullable_to_non_nullable
              as double,
      longServiceLeave: null == longServiceLeave
          ? _value.longServiceLeave
          : longServiceLeave // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LeaveBalanceImpl implements _LeaveBalance {
  const _$LeaveBalanceImpl(
      {required this.annualLeave,
      required this.sickLeave,
      required this.personalLeave,
      required this.longServiceLeave});

  factory _$LeaveBalanceImpl.fromJson(Map<String, dynamic> json) =>
      _$$LeaveBalanceImplFromJson(json);

  @override
  final double annualLeave;
  @override
  final double sickLeave;
  @override
  final double personalLeave;
  @override
  final double longServiceLeave;

  @override
  String toString() {
    return 'LeaveBalance(annualLeave: $annualLeave, sickLeave: $sickLeave, personalLeave: $personalLeave, longServiceLeave: $longServiceLeave)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LeaveBalanceImpl &&
            (identical(other.annualLeave, annualLeave) ||
                other.annualLeave == annualLeave) &&
            (identical(other.sickLeave, sickLeave) ||
                other.sickLeave == sickLeave) &&
            (identical(other.personalLeave, personalLeave) ||
                other.personalLeave == personalLeave) &&
            (identical(other.longServiceLeave, longServiceLeave) ||
                other.longServiceLeave == longServiceLeave));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, annualLeave, sickLeave, personalLeave, longServiceLeave);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LeaveBalanceImplCopyWith<_$LeaveBalanceImpl> get copyWith =>
      __$$LeaveBalanceImplCopyWithImpl<_$LeaveBalanceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LeaveBalanceImplToJson(
      this,
    );
  }
}

abstract class _LeaveBalance implements LeaveBalance {
  const factory _LeaveBalance(
      {required final double annualLeave,
      required final double sickLeave,
      required final double personalLeave,
      required final double longServiceLeave}) = _$LeaveBalanceImpl;

  factory _LeaveBalance.fromJson(Map<String, dynamic> json) =
      _$LeaveBalanceImpl.fromJson;

  @override
  double get annualLeave;
  @override
  double get sickLeave;
  @override
  double get personalLeave;
  @override
  double get longServiceLeave;
  @override
  @JsonKey(ignore: true)
  _$$LeaveBalanceImplCopyWith<_$LeaveBalanceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LeaveRequest _$LeaveRequestFromJson(Map<String, dynamic> json) {
  return _LeaveRequest.fromJson(json);
}

/// @nodoc
mixin _$LeaveRequest {
  @JsonKey(name: '_id')
  String? get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get organizationId => throw _privateConstructorUsedError;
  String get createdBy => throw _privateConstructorUsedError;
  String get leaveType => throw _privateConstructorUsedError;
  DateTime get startDate => throw _privateConstructorUsedError;
  DateTime get endDate => throw _privateConstructorUsedError;
  double get totalHours => throw _privateConstructorUsedError;
  String get reason => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String? get approverId => throw _privateConstructorUsedError;
  DateTime? get approvedAt => throw _privateConstructorUsedError;
  String? get rejectionReason => throw _privateConstructorUsedError;
  List<LeaveAttachment>? get attachments => throw _privateConstructorUsedError;
  List<LeaveHistory>? get history => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LeaveRequestCopyWith<LeaveRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LeaveRequestCopyWith<$Res> {
  factory $LeaveRequestCopyWith(
          LeaveRequest value, $Res Function(LeaveRequest) then) =
      _$LeaveRequestCopyWithImpl<$Res, LeaveRequest>;
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
class _$LeaveRequestCopyWithImpl<$Res, $Val extends LeaveRequest>
    implements $LeaveRequestCopyWith<$Res> {
  _$LeaveRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      leaveType: null == leaveType
          ? _value.leaveType
          : leaveType // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      totalHours: null == totalHours
          ? _value.totalHours
          : totalHours // ignore: cast_nullable_to_non_nullable
              as double,
      reason: null == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      approverId: freezed == approverId
          ? _value.approverId
          : approverId // ignore: cast_nullable_to_non_nullable
              as String?,
      approvedAt: freezed == approvedAt
          ? _value.approvedAt
          : approvedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      rejectionReason: freezed == rejectionReason
          ? _value.rejectionReason
          : rejectionReason // ignore: cast_nullable_to_non_nullable
              as String?,
      attachments: freezed == attachments
          ? _value.attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<LeaveAttachment>?,
      history: freezed == history
          ? _value.history
          : history // ignore: cast_nullable_to_non_nullable
              as List<LeaveHistory>?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LeaveRequestImplCopyWith<$Res>
    implements $LeaveRequestCopyWith<$Res> {
  factory _$$LeaveRequestImplCopyWith(
          _$LeaveRequestImpl value, $Res Function(_$LeaveRequestImpl) then) =
      __$$LeaveRequestImplCopyWithImpl<$Res>;
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
class __$$LeaveRequestImplCopyWithImpl<$Res>
    extends _$LeaveRequestCopyWithImpl<$Res, _$LeaveRequestImpl>
    implements _$$LeaveRequestImplCopyWith<$Res> {
  __$$LeaveRequestImplCopyWithImpl(
      _$LeaveRequestImpl _value, $Res Function(_$LeaveRequestImpl) _then)
      : super(_value, _then);

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
    return _then(_$LeaveRequestImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      leaveType: null == leaveType
          ? _value.leaveType
          : leaveType // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      totalHours: null == totalHours
          ? _value.totalHours
          : totalHours // ignore: cast_nullable_to_non_nullable
              as double,
      reason: null == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      approverId: freezed == approverId
          ? _value.approverId
          : approverId // ignore: cast_nullable_to_non_nullable
              as String?,
      approvedAt: freezed == approvedAt
          ? _value.approvedAt
          : approvedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      rejectionReason: freezed == rejectionReason
          ? _value.rejectionReason
          : rejectionReason // ignore: cast_nullable_to_non_nullable
              as String?,
      attachments: freezed == attachments
          ? _value._attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<LeaveAttachment>?,
      history: freezed == history
          ? _value._history
          : history // ignore: cast_nullable_to_non_nullable
              as List<LeaveHistory>?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LeaveRequestImpl implements _LeaveRequest {
  const _$LeaveRequestImpl(
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

  factory _$LeaveRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$LeaveRequestImplFromJson(json);

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

  @override
  String toString() {
    return 'LeaveRequest(id: $id, userId: $userId, organizationId: $organizationId, createdBy: $createdBy, leaveType: $leaveType, startDate: $startDate, endDate: $endDate, totalHours: $totalHours, reason: $reason, status: $status, approverId: $approverId, approvedAt: $approvedAt, rejectionReason: $rejectionReason, attachments: $attachments, history: $history, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LeaveRequestImpl &&
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

  @JsonKey(ignore: true)
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

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LeaveRequestImplCopyWith<_$LeaveRequestImpl> get copyWith =>
      __$$LeaveRequestImplCopyWithImpl<_$LeaveRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LeaveRequestImplToJson(
      this,
    );
  }
}

abstract class _LeaveRequest implements LeaveRequest {
  const factory _LeaveRequest(
      {@JsonKey(name: '_id') final String? id,
      required final String userId,
      required final String organizationId,
      required final String createdBy,
      required final String leaveType,
      required final DateTime startDate,
      required final DateTime endDate,
      required final double totalHours,
      required final String reason,
      final String status,
      final String? approverId,
      final DateTime? approvedAt,
      final String? rejectionReason,
      final List<LeaveAttachment>? attachments,
      final List<LeaveHistory>? history,
      final DateTime? createdAt,
      final DateTime? updatedAt}) = _$LeaveRequestImpl;

  factory _LeaveRequest.fromJson(Map<String, dynamic> json) =
      _$LeaveRequestImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String? get id;
  @override
  String get userId;
  @override
  String get organizationId;
  @override
  String get createdBy;
  @override
  String get leaveType;
  @override
  DateTime get startDate;
  @override
  DateTime get endDate;
  @override
  double get totalHours;
  @override
  String get reason;
  @override
  String get status;
  @override
  String? get approverId;
  @override
  DateTime? get approvedAt;
  @override
  String? get rejectionReason;
  @override
  List<LeaveAttachment>? get attachments;
  @override
  List<LeaveHistory>? get history;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$LeaveRequestImplCopyWith<_$LeaveRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LeaveAttachment _$LeaveAttachmentFromJson(Map<String, dynamic> json) {
  return _LeaveAttachment.fromJson(json);
}

/// @nodoc
mixin _$LeaveAttachment {
  String get filename => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  DateTime get uploadedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LeaveAttachmentCopyWith<LeaveAttachment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LeaveAttachmentCopyWith<$Res> {
  factory $LeaveAttachmentCopyWith(
          LeaveAttachment value, $Res Function(LeaveAttachment) then) =
      _$LeaveAttachmentCopyWithImpl<$Res, LeaveAttachment>;
  @useResult
  $Res call({String filename, String url, DateTime uploadedAt});
}

/// @nodoc
class _$LeaveAttachmentCopyWithImpl<$Res, $Val extends LeaveAttachment>
    implements $LeaveAttachmentCopyWith<$Res> {
  _$LeaveAttachmentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? filename = null,
    Object? url = null,
    Object? uploadedAt = null,
  }) {
    return _then(_value.copyWith(
      filename: null == filename
          ? _value.filename
          : filename // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      uploadedAt: null == uploadedAt
          ? _value.uploadedAt
          : uploadedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LeaveAttachmentImplCopyWith<$Res>
    implements $LeaveAttachmentCopyWith<$Res> {
  factory _$$LeaveAttachmentImplCopyWith(_$LeaveAttachmentImpl value,
          $Res Function(_$LeaveAttachmentImpl) then) =
      __$$LeaveAttachmentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String filename, String url, DateTime uploadedAt});
}

/// @nodoc
class __$$LeaveAttachmentImplCopyWithImpl<$Res>
    extends _$LeaveAttachmentCopyWithImpl<$Res, _$LeaveAttachmentImpl>
    implements _$$LeaveAttachmentImplCopyWith<$Res> {
  __$$LeaveAttachmentImplCopyWithImpl(
      _$LeaveAttachmentImpl _value, $Res Function(_$LeaveAttachmentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? filename = null,
    Object? url = null,
    Object? uploadedAt = null,
  }) {
    return _then(_$LeaveAttachmentImpl(
      filename: null == filename
          ? _value.filename
          : filename // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      uploadedAt: null == uploadedAt
          ? _value.uploadedAt
          : uploadedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LeaveAttachmentImpl implements _LeaveAttachment {
  const _$LeaveAttachmentImpl(
      {required this.filename, required this.url, required this.uploadedAt});

  factory _$LeaveAttachmentImpl.fromJson(Map<String, dynamic> json) =>
      _$$LeaveAttachmentImplFromJson(json);

  @override
  final String filename;
  @override
  final String url;
  @override
  final DateTime uploadedAt;

  @override
  String toString() {
    return 'LeaveAttachment(filename: $filename, url: $url, uploadedAt: $uploadedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LeaveAttachmentImpl &&
            (identical(other.filename, filename) ||
                other.filename == filename) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.uploadedAt, uploadedAt) ||
                other.uploadedAt == uploadedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, filename, url, uploadedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LeaveAttachmentImplCopyWith<_$LeaveAttachmentImpl> get copyWith =>
      __$$LeaveAttachmentImplCopyWithImpl<_$LeaveAttachmentImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LeaveAttachmentImplToJson(
      this,
    );
  }
}

abstract class _LeaveAttachment implements LeaveAttachment {
  const factory _LeaveAttachment(
      {required final String filename,
      required final String url,
      required final DateTime uploadedAt}) = _$LeaveAttachmentImpl;

  factory _LeaveAttachment.fromJson(Map<String, dynamic> json) =
      _$LeaveAttachmentImpl.fromJson;

  @override
  String get filename;
  @override
  String get url;
  @override
  DateTime get uploadedAt;
  @override
  @JsonKey(ignore: true)
  _$$LeaveAttachmentImplCopyWith<_$LeaveAttachmentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LeaveHistory _$LeaveHistoryFromJson(Map<String, dynamic> json) {
  return _LeaveHistory.fromJson(json);
}

/// @nodoc
mixin _$LeaveHistory {
  String get action => throw _privateConstructorUsedError;
  String get performedBy => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  String? get reason => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LeaveHistoryCopyWith<LeaveHistory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LeaveHistoryCopyWith<$Res> {
  factory $LeaveHistoryCopyWith(
          LeaveHistory value, $Res Function(LeaveHistory) then) =
      _$LeaveHistoryCopyWithImpl<$Res, LeaveHistory>;
  @useResult
  $Res call(
      {String action,
      String performedBy,
      DateTime timestamp,
      String? status,
      String? reason});
}

/// @nodoc
class _$LeaveHistoryCopyWithImpl<$Res, $Val extends LeaveHistory>
    implements $LeaveHistoryCopyWith<$Res> {
  _$LeaveHistoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? action = null,
    Object? performedBy = null,
    Object? timestamp = null,
    Object? status = freezed,
    Object? reason = freezed,
  }) {
    return _then(_value.copyWith(
      action: null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as String,
      performedBy: null == performedBy
          ? _value.performedBy
          : performedBy // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      reason: freezed == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LeaveHistoryImplCopyWith<$Res>
    implements $LeaveHistoryCopyWith<$Res> {
  factory _$$LeaveHistoryImplCopyWith(
          _$LeaveHistoryImpl value, $Res Function(_$LeaveHistoryImpl) then) =
      __$$LeaveHistoryImplCopyWithImpl<$Res>;
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
class __$$LeaveHistoryImplCopyWithImpl<$Res>
    extends _$LeaveHistoryCopyWithImpl<$Res, _$LeaveHistoryImpl>
    implements _$$LeaveHistoryImplCopyWith<$Res> {
  __$$LeaveHistoryImplCopyWithImpl(
      _$LeaveHistoryImpl _value, $Res Function(_$LeaveHistoryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? action = null,
    Object? performedBy = null,
    Object? timestamp = null,
    Object? status = freezed,
    Object? reason = freezed,
  }) {
    return _then(_$LeaveHistoryImpl(
      action: null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as String,
      performedBy: null == performedBy
          ? _value.performedBy
          : performedBy // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
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
class _$LeaveHistoryImpl implements _LeaveHistory {
  const _$LeaveHistoryImpl(
      {required this.action,
      required this.performedBy,
      required this.timestamp,
      this.status,
      this.reason});

  factory _$LeaveHistoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$LeaveHistoryImplFromJson(json);

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

  @override
  String toString() {
    return 'LeaveHistory(action: $action, performedBy: $performedBy, timestamp: $timestamp, status: $status, reason: $reason)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LeaveHistoryImpl &&
            (identical(other.action, action) || other.action == action) &&
            (identical(other.performedBy, performedBy) ||
                other.performedBy == performedBy) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.reason, reason) || other.reason == reason));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, action, performedBy, timestamp, status, reason);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LeaveHistoryImplCopyWith<_$LeaveHistoryImpl> get copyWith =>
      __$$LeaveHistoryImplCopyWithImpl<_$LeaveHistoryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LeaveHistoryImplToJson(
      this,
    );
  }
}

abstract class _LeaveHistory implements LeaveHistory {
  const factory _LeaveHistory(
      {required final String action,
      required final String performedBy,
      required final DateTime timestamp,
      final String? status,
      final String? reason}) = _$LeaveHistoryImpl;

  factory _LeaveHistory.fromJson(Map<String, dynamic> json) =
      _$LeaveHistoryImpl.fromJson;

  @override
  String get action;
  @override
  String get performedBy;
  @override
  DateTime get timestamp;
  @override
  String? get status;
  @override
  String? get reason;
  @override
  @JsonKey(ignore: true)
  _$$LeaveHistoryImplCopyWith<_$LeaveHistoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PublicHoliday _$PublicHolidayFromJson(Map<String, dynamic> json) {
  return _PublicHoliday.fromJson(json);
}

/// @nodoc
mixin _$PublicHoliday {
  @JsonKey(name: '_id')
  String? get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  String get day => throw _privateConstructorUsedError;
  String? get organizationId => throw _privateConstructorUsedError;
  bool get isCustom => throw _privateConstructorUsedError;
  String? get state => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PublicHolidayCopyWith<PublicHoliday> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PublicHolidayCopyWith<$Res> {
  factory $PublicHolidayCopyWith(
          PublicHoliday value, $Res Function(PublicHoliday) then) =
      _$PublicHolidayCopyWithImpl<$Res, PublicHoliday>;
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
class _$PublicHolidayCopyWithImpl<$Res, $Val extends PublicHoliday>
    implements $PublicHolidayCopyWith<$Res> {
  _$PublicHolidayCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      day: null == day
          ? _value.day
          : day // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: freezed == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String?,
      isCustom: null == isCustom
          ? _value.isCustom
          : isCustom // ignore: cast_nullable_to_non_nullable
              as bool,
      state: freezed == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PublicHolidayImplCopyWith<$Res>
    implements $PublicHolidayCopyWith<$Res> {
  factory _$$PublicHolidayImplCopyWith(
          _$PublicHolidayImpl value, $Res Function(_$PublicHolidayImpl) then) =
      __$$PublicHolidayImplCopyWithImpl<$Res>;
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
class __$$PublicHolidayImplCopyWithImpl<$Res>
    extends _$PublicHolidayCopyWithImpl<$Res, _$PublicHolidayImpl>
    implements _$$PublicHolidayImplCopyWith<$Res> {
  __$$PublicHolidayImplCopyWithImpl(
      _$PublicHolidayImpl _value, $Res Function(_$PublicHolidayImpl) _then)
      : super(_value, _then);

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
    return _then(_$PublicHolidayImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      day: null == day
          ? _value.day
          : day // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: freezed == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String?,
      isCustom: null == isCustom
          ? _value.isCustom
          : isCustom // ignore: cast_nullable_to_non_nullable
              as bool,
      state: freezed == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PublicHolidayImpl implements _PublicHoliday {
  const _$PublicHolidayImpl(
      {@JsonKey(name: '_id') this.id,
      required this.name,
      required this.date,
      required this.day,
      this.organizationId,
      this.isCustom = false,
      this.state});

  factory _$PublicHolidayImpl.fromJson(Map<String, dynamic> json) =>
      _$$PublicHolidayImplFromJson(json);

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

  @override
  String toString() {
    return 'PublicHoliday(id: $id, name: $name, date: $date, day: $day, organizationId: $organizationId, isCustom: $isCustom, state: $state)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PublicHolidayImpl &&
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

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, date, day, organizationId, isCustom, state);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PublicHolidayImplCopyWith<_$PublicHolidayImpl> get copyWith =>
      __$$PublicHolidayImplCopyWithImpl<_$PublicHolidayImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PublicHolidayImplToJson(
      this,
    );
  }
}

abstract class _PublicHoliday implements PublicHoliday {
  const factory _PublicHoliday(
      {@JsonKey(name: '_id') final String? id,
      required final String name,
      required final DateTime date,
      required final String day,
      final String? organizationId,
      final bool isCustom,
      final String? state}) = _$PublicHolidayImpl;

  factory _PublicHoliday.fromJson(Map<String, dynamic> json) =
      _$PublicHolidayImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String? get id;
  @override
  String get name;
  @override
  DateTime get date;
  @override
  String get day;
  @override
  String? get organizationId;
  @override
  bool get isCustom;
  @override
  String? get state;
  @override
  @JsonKey(ignore: true)
  _$$PublicHolidayImplCopyWith<_$PublicHolidayImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LeaveForecast _$LeaveForecastFromJson(Map<String, dynamic> json) {
  return _LeaveForecast.fromJson(json);
}

/// @nodoc
mixin _$LeaveForecast {
  LeaveBalance get forecast => throw _privateConstructorUsedError;
  Map<String, double> get accrualRate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LeaveForecastCopyWith<LeaveForecast> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LeaveForecastCopyWith<$Res> {
  factory $LeaveForecastCopyWith(
          LeaveForecast value, $Res Function(LeaveForecast) then) =
      _$LeaveForecastCopyWithImpl<$Res, LeaveForecast>;
  @useResult
  $Res call({LeaveBalance forecast, Map<String, double> accrualRate});

  $LeaveBalanceCopyWith<$Res> get forecast;
}

/// @nodoc
class _$LeaveForecastCopyWithImpl<$Res, $Val extends LeaveForecast>
    implements $LeaveForecastCopyWith<$Res> {
  _$LeaveForecastCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? forecast = null,
    Object? accrualRate = null,
  }) {
    return _then(_value.copyWith(
      forecast: null == forecast
          ? _value.forecast
          : forecast // ignore: cast_nullable_to_non_nullable
              as LeaveBalance,
      accrualRate: null == accrualRate
          ? _value.accrualRate
          : accrualRate // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $LeaveBalanceCopyWith<$Res> get forecast {
    return $LeaveBalanceCopyWith<$Res>(_value.forecast, (value) {
      return _then(_value.copyWith(forecast: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LeaveForecastImplCopyWith<$Res>
    implements $LeaveForecastCopyWith<$Res> {
  factory _$$LeaveForecastImplCopyWith(
          _$LeaveForecastImpl value, $Res Function(_$LeaveForecastImpl) then) =
      __$$LeaveForecastImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({LeaveBalance forecast, Map<String, double> accrualRate});

  @override
  $LeaveBalanceCopyWith<$Res> get forecast;
}

/// @nodoc
class __$$LeaveForecastImplCopyWithImpl<$Res>
    extends _$LeaveForecastCopyWithImpl<$Res, _$LeaveForecastImpl>
    implements _$$LeaveForecastImplCopyWith<$Res> {
  __$$LeaveForecastImplCopyWithImpl(
      _$LeaveForecastImpl _value, $Res Function(_$LeaveForecastImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? forecast = null,
    Object? accrualRate = null,
  }) {
    return _then(_$LeaveForecastImpl(
      forecast: null == forecast
          ? _value.forecast
          : forecast // ignore: cast_nullable_to_non_nullable
              as LeaveBalance,
      accrualRate: null == accrualRate
          ? _value._accrualRate
          : accrualRate // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LeaveForecastImpl implements _LeaveForecast {
  const _$LeaveForecastImpl(
      {required this.forecast, required final Map<String, double> accrualRate})
      : _accrualRate = accrualRate;

  factory _$LeaveForecastImpl.fromJson(Map<String, dynamic> json) =>
      _$$LeaveForecastImplFromJson(json);

  @override
  final LeaveBalance forecast;
  final Map<String, double> _accrualRate;
  @override
  Map<String, double> get accrualRate {
    if (_accrualRate is EqualUnmodifiableMapView) return _accrualRate;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_accrualRate);
  }

  @override
  String toString() {
    return 'LeaveForecast(forecast: $forecast, accrualRate: $accrualRate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LeaveForecastImpl &&
            (identical(other.forecast, forecast) ||
                other.forecast == forecast) &&
            const DeepCollectionEquality()
                .equals(other._accrualRate, _accrualRate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, forecast, const DeepCollectionEquality().hash(_accrualRate));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LeaveForecastImplCopyWith<_$LeaveForecastImpl> get copyWith =>
      __$$LeaveForecastImplCopyWithImpl<_$LeaveForecastImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LeaveForecastImplToJson(
      this,
    );
  }
}

abstract class _LeaveForecast implements LeaveForecast {
  const factory _LeaveForecast(
      {required final LeaveBalance forecast,
      required final Map<String, double> accrualRate}) = _$LeaveForecastImpl;

  factory _LeaveForecast.fromJson(Map<String, dynamic> json) =
      _$LeaveForecastImpl.fromJson;

  @override
  LeaveBalance get forecast;
  @override
  Map<String, double> get accrualRate;
  @override
  @JsonKey(ignore: true)
  _$$LeaveForecastImplCopyWith<_$LeaveForecastImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
