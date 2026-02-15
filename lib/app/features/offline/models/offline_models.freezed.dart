// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'offline_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

OfflineQueueItem _$OfflineQueueItemFromJson(Map<String, dynamic> json) {
  return _OfflineQueueItem.fromJson(json);
}

/// @nodoc
mixin _$OfflineQueueItem {
  String get queueId => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get dataType => throw _privateConstructorUsedError;
  String get action => throw _privateConstructorUsedError;
  Map<String, dynamic> get payload => throw _privateConstructorUsedError;
  String get timestamp => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  int get retryCount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OfflineQueueItemCopyWith<OfflineQueueItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OfflineQueueItemCopyWith<$Res> {
  factory $OfflineQueueItemCopyWith(
          OfflineQueueItem value, $Res Function(OfflineQueueItem) then) =
      _$OfflineQueueItemCopyWithImpl<$Res, OfflineQueueItem>;
  @useResult
  $Res call(
      {String queueId,
      String userId,
      String dataType,
      String action,
      Map<String, dynamic> payload,
      String timestamp,
      String status,
      int retryCount});
}

/// @nodoc
class _$OfflineQueueItemCopyWithImpl<$Res, $Val extends OfflineQueueItem>
    implements $OfflineQueueItemCopyWith<$Res> {
  _$OfflineQueueItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? queueId = null,
    Object? userId = null,
    Object? dataType = null,
    Object? action = null,
    Object? payload = null,
    Object? timestamp = null,
    Object? status = null,
    Object? retryCount = null,
  }) {
    return _then(_value.copyWith(
      queueId: null == queueId
          ? _value.queueId
          : queueId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      dataType: null == dataType
          ? _value.dataType
          : dataType // ignore: cast_nullable_to_non_nullable
              as String,
      action: null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as String,
      payload: null == payload
          ? _value.payload
          : payload // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      retryCount: null == retryCount
          ? _value.retryCount
          : retryCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OfflineQueueItemImplCopyWith<$Res>
    implements $OfflineQueueItemCopyWith<$Res> {
  factory _$$OfflineQueueItemImplCopyWith(_$OfflineQueueItemImpl value,
          $Res Function(_$OfflineQueueItemImpl) then) =
      __$$OfflineQueueItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String queueId,
      String userId,
      String dataType,
      String action,
      Map<String, dynamic> payload,
      String timestamp,
      String status,
      int retryCount});
}

/// @nodoc
class __$$OfflineQueueItemImplCopyWithImpl<$Res>
    extends _$OfflineQueueItemCopyWithImpl<$Res, _$OfflineQueueItemImpl>
    implements _$$OfflineQueueItemImplCopyWith<$Res> {
  __$$OfflineQueueItemImplCopyWithImpl(_$OfflineQueueItemImpl _value,
      $Res Function(_$OfflineQueueItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? queueId = null,
    Object? userId = null,
    Object? dataType = null,
    Object? action = null,
    Object? payload = null,
    Object? timestamp = null,
    Object? status = null,
    Object? retryCount = null,
  }) {
    return _then(_$OfflineQueueItemImpl(
      queueId: null == queueId
          ? _value.queueId
          : queueId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      dataType: null == dataType
          ? _value.dataType
          : dataType // ignore: cast_nullable_to_non_nullable
              as String,
      action: null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as String,
      payload: null == payload
          ? _value._payload
          : payload // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      retryCount: null == retryCount
          ? _value.retryCount
          : retryCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OfflineQueueItemImpl implements _OfflineQueueItem {
  const _$OfflineQueueItemImpl(
      {required this.queueId,
      required this.userId,
      required this.dataType,
      required this.action,
      required final Map<String, dynamic> payload,
      required this.timestamp,
      required this.status,
      required this.retryCount})
      : _payload = payload;

  factory _$OfflineQueueItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$OfflineQueueItemImplFromJson(json);

  @override
  final String queueId;
  @override
  final String userId;
  @override
  final String dataType;
  @override
  final String action;
  final Map<String, dynamic> _payload;
  @override
  Map<String, dynamic> get payload {
    if (_payload is EqualUnmodifiableMapView) return _payload;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_payload);
  }

  @override
  final String timestamp;
  @override
  final String status;
  @override
  final int retryCount;

  @override
  String toString() {
    return 'OfflineQueueItem(queueId: $queueId, userId: $userId, dataType: $dataType, action: $action, payload: $payload, timestamp: $timestamp, status: $status, retryCount: $retryCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OfflineQueueItemImpl &&
            (identical(other.queueId, queueId) || other.queueId == queueId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.dataType, dataType) ||
                other.dataType == dataType) &&
            (identical(other.action, action) || other.action == action) &&
            const DeepCollectionEquality().equals(other._payload, _payload) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.retryCount, retryCount) ||
                other.retryCount == retryCount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      queueId,
      userId,
      dataType,
      action,
      const DeepCollectionEquality().hash(_payload),
      timestamp,
      status,
      retryCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OfflineQueueItemImplCopyWith<_$OfflineQueueItemImpl> get copyWith =>
      __$$OfflineQueueItemImplCopyWithImpl<_$OfflineQueueItemImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OfflineQueueItemImplToJson(
      this,
    );
  }
}

abstract class _OfflineQueueItem implements OfflineQueueItem {
  const factory _OfflineQueueItem(
      {required final String queueId,
      required final String userId,
      required final String dataType,
      required final String action,
      required final Map<String, dynamic> payload,
      required final String timestamp,
      required final String status,
      required final int retryCount}) = _$OfflineQueueItemImpl;

  factory _OfflineQueueItem.fromJson(Map<String, dynamic> json) =
      _$OfflineQueueItemImpl.fromJson;

  @override
  String get queueId;
  @override
  String get userId;
  @override
  String get dataType;
  @override
  String get action;
  @override
  Map<String, dynamic> get payload;
  @override
  String get timestamp;
  @override
  String get status;
  @override
  int get retryCount;
  @override
  @JsonKey(ignore: true)
  _$$OfflineQueueItemImplCopyWith<_$OfflineQueueItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SyncStatus _$SyncStatusFromJson(Map<String, dynamic> json) {
  return _SyncStatus.fromJson(json);
}

/// @nodoc
mixin _$SyncStatus {
  int get total => throw _privateConstructorUsedError;
  int get successful => throw _privateConstructorUsedError;
  int get failed => throw _privateConstructorUsedError;
  int get conflicts => throw _privateConstructorUsedError;
  List<SyncItemResult> get items => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SyncStatusCopyWith<SyncStatus> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SyncStatusCopyWith<$Res> {
  factory $SyncStatusCopyWith(
          SyncStatus value, $Res Function(SyncStatus) then) =
      _$SyncStatusCopyWithImpl<$Res, SyncStatus>;
  @useResult
  $Res call(
      {int total,
      int successful,
      int failed,
      int conflicts,
      List<SyncItemResult> items});
}

/// @nodoc
class _$SyncStatusCopyWithImpl<$Res, $Val extends SyncStatus>
    implements $SyncStatusCopyWith<$Res> {
  _$SyncStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? total = null,
    Object? successful = null,
    Object? failed = null,
    Object? conflicts = null,
    Object? items = null,
  }) {
    return _then(_value.copyWith(
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      successful: null == successful
          ? _value.successful
          : successful // ignore: cast_nullable_to_non_nullable
              as int,
      failed: null == failed
          ? _value.failed
          : failed // ignore: cast_nullable_to_non_nullable
              as int,
      conflicts: null == conflicts
          ? _value.conflicts
          : conflicts // ignore: cast_nullable_to_non_nullable
              as int,
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<SyncItemResult>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SyncStatusImplCopyWith<$Res>
    implements $SyncStatusCopyWith<$Res> {
  factory _$$SyncStatusImplCopyWith(
          _$SyncStatusImpl value, $Res Function(_$SyncStatusImpl) then) =
      __$$SyncStatusImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int total,
      int successful,
      int failed,
      int conflicts,
      List<SyncItemResult> items});
}

/// @nodoc
class __$$SyncStatusImplCopyWithImpl<$Res>
    extends _$SyncStatusCopyWithImpl<$Res, _$SyncStatusImpl>
    implements _$$SyncStatusImplCopyWith<$Res> {
  __$$SyncStatusImplCopyWithImpl(
      _$SyncStatusImpl _value, $Res Function(_$SyncStatusImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? total = null,
    Object? successful = null,
    Object? failed = null,
    Object? conflicts = null,
    Object? items = null,
  }) {
    return _then(_$SyncStatusImpl(
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      successful: null == successful
          ? _value.successful
          : successful // ignore: cast_nullable_to_non_nullable
              as int,
      failed: null == failed
          ? _value.failed
          : failed // ignore: cast_nullable_to_non_nullable
              as int,
      conflicts: null == conflicts
          ? _value.conflicts
          : conflicts // ignore: cast_nullable_to_non_nullable
              as int,
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<SyncItemResult>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SyncStatusImpl implements _SyncStatus {
  const _$SyncStatusImpl(
      {required this.total,
      required this.successful,
      required this.failed,
      required this.conflicts,
      required final List<SyncItemResult> items})
      : _items = items;

  factory _$SyncStatusImpl.fromJson(Map<String, dynamic> json) =>
      _$$SyncStatusImplFromJson(json);

  @override
  final int total;
  @override
  final int successful;
  @override
  final int failed;
  @override
  final int conflicts;
  final List<SyncItemResult> _items;
  @override
  List<SyncItemResult> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  String toString() {
    return 'SyncStatus(total: $total, successful: $successful, failed: $failed, conflicts: $conflicts, items: $items)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SyncStatusImpl &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.successful, successful) ||
                other.successful == successful) &&
            (identical(other.failed, failed) || other.failed == failed) &&
            (identical(other.conflicts, conflicts) ||
                other.conflicts == conflicts) &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, total, successful, failed,
      conflicts, const DeepCollectionEquality().hash(_items));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SyncStatusImplCopyWith<_$SyncStatusImpl> get copyWith =>
      __$$SyncStatusImplCopyWithImpl<_$SyncStatusImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SyncStatusImplToJson(
      this,
    );
  }
}

abstract class _SyncStatus implements SyncStatus {
  const factory _SyncStatus(
      {required final int total,
      required final int successful,
      required final int failed,
      required final int conflicts,
      required final List<SyncItemResult> items}) = _$SyncStatusImpl;

  factory _SyncStatus.fromJson(Map<String, dynamic> json) =
      _$SyncStatusImpl.fromJson;

  @override
  int get total;
  @override
  int get successful;
  @override
  int get failed;
  @override
  int get conflicts;
  @override
  List<SyncItemResult> get items;
  @override
  @JsonKey(ignore: true)
  _$$SyncStatusImplCopyWith<_$SyncStatusImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SyncItemResult _$SyncItemResultFromJson(Map<String, dynamic> json) {
  return _SyncItemResult.fromJson(json);
}

/// @nodoc
mixin _$SyncItemResult {
  String get queueId => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String? get reason => throw _privateConstructorUsedError;
  String? get syncedAt => throw _privateConstructorUsedError;
  ConflictData? get conflictData => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SyncItemResultCopyWith<SyncItemResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SyncItemResultCopyWith<$Res> {
  factory $SyncItemResultCopyWith(
          SyncItemResult value, $Res Function(SyncItemResult) then) =
      _$SyncItemResultCopyWithImpl<$Res, SyncItemResult>;
  @useResult
  $Res call(
      {String queueId,
      String status,
      String? reason,
      String? syncedAt,
      ConflictData? conflictData});

  $ConflictDataCopyWith<$Res>? get conflictData;
}

/// @nodoc
class _$SyncItemResultCopyWithImpl<$Res, $Val extends SyncItemResult>
    implements $SyncItemResultCopyWith<$Res> {
  _$SyncItemResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? queueId = null,
    Object? status = null,
    Object? reason = freezed,
    Object? syncedAt = freezed,
    Object? conflictData = freezed,
  }) {
    return _then(_value.copyWith(
      queueId: null == queueId
          ? _value.queueId
          : queueId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      reason: freezed == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String?,
      syncedAt: freezed == syncedAt
          ? _value.syncedAt
          : syncedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      conflictData: freezed == conflictData
          ? _value.conflictData
          : conflictData // ignore: cast_nullable_to_non_nullable
              as ConflictData?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ConflictDataCopyWith<$Res>? get conflictData {
    if (_value.conflictData == null) {
      return null;
    }

    return $ConflictDataCopyWith<$Res>(_value.conflictData!, (value) {
      return _then(_value.copyWith(conflictData: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SyncItemResultImplCopyWith<$Res>
    implements $SyncItemResultCopyWith<$Res> {
  factory _$$SyncItemResultImplCopyWith(_$SyncItemResultImpl value,
          $Res Function(_$SyncItemResultImpl) then) =
      __$$SyncItemResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String queueId,
      String status,
      String? reason,
      String? syncedAt,
      ConflictData? conflictData});

  @override
  $ConflictDataCopyWith<$Res>? get conflictData;
}

/// @nodoc
class __$$SyncItemResultImplCopyWithImpl<$Res>
    extends _$SyncItemResultCopyWithImpl<$Res, _$SyncItemResultImpl>
    implements _$$SyncItemResultImplCopyWith<$Res> {
  __$$SyncItemResultImplCopyWithImpl(
      _$SyncItemResultImpl _value, $Res Function(_$SyncItemResultImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? queueId = null,
    Object? status = null,
    Object? reason = freezed,
    Object? syncedAt = freezed,
    Object? conflictData = freezed,
  }) {
    return _then(_$SyncItemResultImpl(
      queueId: null == queueId
          ? _value.queueId
          : queueId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      reason: freezed == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String?,
      syncedAt: freezed == syncedAt
          ? _value.syncedAt
          : syncedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      conflictData: freezed == conflictData
          ? _value.conflictData
          : conflictData // ignore: cast_nullable_to_non_nullable
              as ConflictData?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SyncItemResultImpl implements _SyncItemResult {
  const _$SyncItemResultImpl(
      {required this.queueId,
      required this.status,
      this.reason,
      this.syncedAt,
      this.conflictData});

  factory _$SyncItemResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$SyncItemResultImplFromJson(json);

  @override
  final String queueId;
  @override
  final String status;
  @override
  final String? reason;
  @override
  final String? syncedAt;
  @override
  final ConflictData? conflictData;

  @override
  String toString() {
    return 'SyncItemResult(queueId: $queueId, status: $status, reason: $reason, syncedAt: $syncedAt, conflictData: $conflictData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SyncItemResultImpl &&
            (identical(other.queueId, queueId) || other.queueId == queueId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.syncedAt, syncedAt) ||
                other.syncedAt == syncedAt) &&
            (identical(other.conflictData, conflictData) ||
                other.conflictData == conflictData));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, queueId, status, reason, syncedAt, conflictData);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SyncItemResultImplCopyWith<_$SyncItemResultImpl> get copyWith =>
      __$$SyncItemResultImplCopyWithImpl<_$SyncItemResultImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SyncItemResultImplToJson(
      this,
    );
  }
}

abstract class _SyncItemResult implements SyncItemResult {
  const factory _SyncItemResult(
      {required final String queueId,
      required final String status,
      final String? reason,
      final String? syncedAt,
      final ConflictData? conflictData}) = _$SyncItemResultImpl;

  factory _SyncItemResult.fromJson(Map<String, dynamic> json) =
      _$SyncItemResultImpl.fromJson;

  @override
  String get queueId;
  @override
  String get status;
  @override
  String? get reason;
  @override
  String? get syncedAt;
  @override
  ConflictData? get conflictData;
  @override
  @JsonKey(ignore: true)
  _$$SyncItemResultImplCopyWith<_$SyncItemResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ConflictData _$ConflictDataFromJson(Map<String, dynamic> json) {
  return _ConflictData.fromJson(json);
}

/// @nodoc
mixin _$ConflictData {
  String get conflictType => throw _privateConstructorUsedError;
  int get localVersion => throw _privateConstructorUsedError;
  int get serverVersion => throw _privateConstructorUsedError;
  List<String> get conflictFields => throw _privateConstructorUsedError;
  String get resolution => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ConflictDataCopyWith<ConflictData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConflictDataCopyWith<$Res> {
  factory $ConflictDataCopyWith(
          ConflictData value, $Res Function(ConflictData) then) =
      _$ConflictDataCopyWithImpl<$Res, ConflictData>;
  @useResult
  $Res call(
      {String conflictType,
      int localVersion,
      int serverVersion,
      List<String> conflictFields,
      String resolution});
}

/// @nodoc
class _$ConflictDataCopyWithImpl<$Res, $Val extends ConflictData>
    implements $ConflictDataCopyWith<$Res> {
  _$ConflictDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? conflictType = null,
    Object? localVersion = null,
    Object? serverVersion = null,
    Object? conflictFields = null,
    Object? resolution = null,
  }) {
    return _then(_value.copyWith(
      conflictType: null == conflictType
          ? _value.conflictType
          : conflictType // ignore: cast_nullable_to_non_nullable
              as String,
      localVersion: null == localVersion
          ? _value.localVersion
          : localVersion // ignore: cast_nullable_to_non_nullable
              as int,
      serverVersion: null == serverVersion
          ? _value.serverVersion
          : serverVersion // ignore: cast_nullable_to_non_nullable
              as int,
      conflictFields: null == conflictFields
          ? _value.conflictFields
          : conflictFields // ignore: cast_nullable_to_non_nullable
              as List<String>,
      resolution: null == resolution
          ? _value.resolution
          : resolution // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ConflictDataImplCopyWith<$Res>
    implements $ConflictDataCopyWith<$Res> {
  factory _$$ConflictDataImplCopyWith(
          _$ConflictDataImpl value, $Res Function(_$ConflictDataImpl) then) =
      __$$ConflictDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String conflictType,
      int localVersion,
      int serverVersion,
      List<String> conflictFields,
      String resolution});
}

/// @nodoc
class __$$ConflictDataImplCopyWithImpl<$Res>
    extends _$ConflictDataCopyWithImpl<$Res, _$ConflictDataImpl>
    implements _$$ConflictDataImplCopyWith<$Res> {
  __$$ConflictDataImplCopyWithImpl(
      _$ConflictDataImpl _value, $Res Function(_$ConflictDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? conflictType = null,
    Object? localVersion = null,
    Object? serverVersion = null,
    Object? conflictFields = null,
    Object? resolution = null,
  }) {
    return _then(_$ConflictDataImpl(
      conflictType: null == conflictType
          ? _value.conflictType
          : conflictType // ignore: cast_nullable_to_non_nullable
              as String,
      localVersion: null == localVersion
          ? _value.localVersion
          : localVersion // ignore: cast_nullable_to_non_nullable
              as int,
      serverVersion: null == serverVersion
          ? _value.serverVersion
          : serverVersion // ignore: cast_nullable_to_non_nullable
              as int,
      conflictFields: null == conflictFields
          ? _value._conflictFields
          : conflictFields // ignore: cast_nullable_to_non_nullable
              as List<String>,
      resolution: null == resolution
          ? _value.resolution
          : resolution // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ConflictDataImpl implements _ConflictData {
  const _$ConflictDataImpl(
      {required this.conflictType,
      required this.localVersion,
      required this.serverVersion,
      required final List<String> conflictFields,
      required this.resolution})
      : _conflictFields = conflictFields;

  factory _$ConflictDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConflictDataImplFromJson(json);

  @override
  final String conflictType;
  @override
  final int localVersion;
  @override
  final int serverVersion;
  final List<String> _conflictFields;
  @override
  List<String> get conflictFields {
    if (_conflictFields is EqualUnmodifiableListView) return _conflictFields;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_conflictFields);
  }

  @override
  final String resolution;

  @override
  String toString() {
    return 'ConflictData(conflictType: $conflictType, localVersion: $localVersion, serverVersion: $serverVersion, conflictFields: $conflictFields, resolution: $resolution)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConflictDataImpl &&
            (identical(other.conflictType, conflictType) ||
                other.conflictType == conflictType) &&
            (identical(other.localVersion, localVersion) ||
                other.localVersion == localVersion) &&
            (identical(other.serverVersion, serverVersion) ||
                other.serverVersion == serverVersion) &&
            const DeepCollectionEquality()
                .equals(other._conflictFields, _conflictFields) &&
            (identical(other.resolution, resolution) ||
                other.resolution == resolution));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      conflictType,
      localVersion,
      serverVersion,
      const DeepCollectionEquality().hash(_conflictFields),
      resolution);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ConflictDataImplCopyWith<_$ConflictDataImpl> get copyWith =>
      __$$ConflictDataImplCopyWithImpl<_$ConflictDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConflictDataImplToJson(
      this,
    );
  }
}

abstract class _ConflictData implements ConflictData {
  const factory _ConflictData(
      {required final String conflictType,
      required final int localVersion,
      required final int serverVersion,
      required final List<String> conflictFields,
      required final String resolution}) = _$ConflictDataImpl;

  factory _ConflictData.fromJson(Map<String, dynamic> json) =
      _$ConflictDataImpl.fromJson;

  @override
  String get conflictType;
  @override
  int get localVersion;
  @override
  int get serverVersion;
  @override
  List<String> get conflictFields;
  @override
  String get resolution;
  @override
  @JsonKey(ignore: true)
  _$$ConflictDataImplCopyWith<_$ConflictDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ConflictResolution _$ConflictResolutionFromJson(Map<String, dynamic> json) {
  return _ConflictResolution.fromJson(json);
}

/// @nodoc
mixin _$ConflictResolution {
  String get conflictId => throw _privateConstructorUsedError;
  String get resolution => throw _privateConstructorUsedError;
  String get resolvedAt => throw _privateConstructorUsedError;
  Map<String, dynamic> get finalData => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ConflictResolutionCopyWith<ConflictResolution> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConflictResolutionCopyWith<$Res> {
  factory $ConflictResolutionCopyWith(
          ConflictResolution value, $Res Function(ConflictResolution) then) =
      _$ConflictResolutionCopyWithImpl<$Res, ConflictResolution>;
  @useResult
  $Res call(
      {String conflictId,
      String resolution,
      String resolvedAt,
      Map<String, dynamic> finalData});
}

/// @nodoc
class _$ConflictResolutionCopyWithImpl<$Res, $Val extends ConflictResolution>
    implements $ConflictResolutionCopyWith<$Res> {
  _$ConflictResolutionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? conflictId = null,
    Object? resolution = null,
    Object? resolvedAt = null,
    Object? finalData = null,
  }) {
    return _then(_value.copyWith(
      conflictId: null == conflictId
          ? _value.conflictId
          : conflictId // ignore: cast_nullable_to_non_nullable
              as String,
      resolution: null == resolution
          ? _value.resolution
          : resolution // ignore: cast_nullable_to_non_nullable
              as String,
      resolvedAt: null == resolvedAt
          ? _value.resolvedAt
          : resolvedAt // ignore: cast_nullable_to_non_nullable
              as String,
      finalData: null == finalData
          ? _value.finalData
          : finalData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ConflictResolutionImplCopyWith<$Res>
    implements $ConflictResolutionCopyWith<$Res> {
  factory _$$ConflictResolutionImplCopyWith(_$ConflictResolutionImpl value,
          $Res Function(_$ConflictResolutionImpl) then) =
      __$$ConflictResolutionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String conflictId,
      String resolution,
      String resolvedAt,
      Map<String, dynamic> finalData});
}

/// @nodoc
class __$$ConflictResolutionImplCopyWithImpl<$Res>
    extends _$ConflictResolutionCopyWithImpl<$Res, _$ConflictResolutionImpl>
    implements _$$ConflictResolutionImplCopyWith<$Res> {
  __$$ConflictResolutionImplCopyWithImpl(_$ConflictResolutionImpl _value,
      $Res Function(_$ConflictResolutionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? conflictId = null,
    Object? resolution = null,
    Object? resolvedAt = null,
    Object? finalData = null,
  }) {
    return _then(_$ConflictResolutionImpl(
      conflictId: null == conflictId
          ? _value.conflictId
          : conflictId // ignore: cast_nullable_to_non_nullable
              as String,
      resolution: null == resolution
          ? _value.resolution
          : resolution // ignore: cast_nullable_to_non_nullable
              as String,
      resolvedAt: null == resolvedAt
          ? _value.resolvedAt
          : resolvedAt // ignore: cast_nullable_to_non_nullable
              as String,
      finalData: null == finalData
          ? _value._finalData
          : finalData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ConflictResolutionImpl implements _ConflictResolution {
  const _$ConflictResolutionImpl(
      {required this.conflictId,
      required this.resolution,
      required this.resolvedAt,
      required final Map<String, dynamic> finalData})
      : _finalData = finalData;

  factory _$ConflictResolutionImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConflictResolutionImplFromJson(json);

  @override
  final String conflictId;
  @override
  final String resolution;
  @override
  final String resolvedAt;
  final Map<String, dynamic> _finalData;
  @override
  Map<String, dynamic> get finalData {
    if (_finalData is EqualUnmodifiableMapView) return _finalData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_finalData);
  }

  @override
  String toString() {
    return 'ConflictResolution(conflictId: $conflictId, resolution: $resolution, resolvedAt: $resolvedAt, finalData: $finalData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConflictResolutionImpl &&
            (identical(other.conflictId, conflictId) ||
                other.conflictId == conflictId) &&
            (identical(other.resolution, resolution) ||
                other.resolution == resolution) &&
            (identical(other.resolvedAt, resolvedAt) ||
                other.resolvedAt == resolvedAt) &&
            const DeepCollectionEquality()
                .equals(other._finalData, _finalData));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, conflictId, resolution,
      resolvedAt, const DeepCollectionEquality().hash(_finalData));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ConflictResolutionImplCopyWith<_$ConflictResolutionImpl> get copyWith =>
      __$$ConflictResolutionImplCopyWithImpl<_$ConflictResolutionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConflictResolutionImplToJson(
      this,
    );
  }
}

abstract class _ConflictResolution implements ConflictResolution {
  const factory _ConflictResolution(
          {required final String conflictId,
          required final String resolution,
          required final String resolvedAt,
          required final Map<String, dynamic> finalData}) =
      _$ConflictResolutionImpl;

  factory _ConflictResolution.fromJson(Map<String, dynamic> json) =
      _$ConflictResolutionImpl.fromJson;

  @override
  String get conflictId;
  @override
  String get resolution;
  @override
  String get resolvedAt;
  @override
  Map<String, dynamic> get finalData;
  @override
  @JsonKey(ignore: true)
  _$$ConflictResolutionImplCopyWith<_$ConflictResolutionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OfflineCapableData _$OfflineCapableDataFromJson(Map<String, dynamic> json) {
  return _OfflineCapableData.fromJson(json);
}

/// @nodoc
mixin _$OfflineCapableData {
  String get userId => throw _privateConstructorUsedError;
  String get downloadedAt => throw _privateConstructorUsedError;
  String get expiresAt => throw _privateConstructorUsedError;
  OfflineDataPackage get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OfflineCapableDataCopyWith<OfflineCapableData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OfflineCapableDataCopyWith<$Res> {
  factory $OfflineCapableDataCopyWith(
          OfflineCapableData value, $Res Function(OfflineCapableData) then) =
      _$OfflineCapableDataCopyWithImpl<$Res, OfflineCapableData>;
  @useResult
  $Res call(
      {String userId,
      String downloadedAt,
      String expiresAt,
      OfflineDataPackage data});

  $OfflineDataPackageCopyWith<$Res> get data;
}

/// @nodoc
class _$OfflineCapableDataCopyWithImpl<$Res, $Val extends OfflineCapableData>
    implements $OfflineCapableDataCopyWith<$Res> {
  _$OfflineCapableDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? downloadedAt = null,
    Object? expiresAt = null,
    Object? data = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      downloadedAt: null == downloadedAt
          ? _value.downloadedAt
          : downloadedAt // ignore: cast_nullable_to_non_nullable
              as String,
      expiresAt: null == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as OfflineDataPackage,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $OfflineDataPackageCopyWith<$Res> get data {
    return $OfflineDataPackageCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$OfflineCapableDataImplCopyWith<$Res>
    implements $OfflineCapableDataCopyWith<$Res> {
  factory _$$OfflineCapableDataImplCopyWith(_$OfflineCapableDataImpl value,
          $Res Function(_$OfflineCapableDataImpl) then) =
      __$$OfflineCapableDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userId,
      String downloadedAt,
      String expiresAt,
      OfflineDataPackage data});

  @override
  $OfflineDataPackageCopyWith<$Res> get data;
}

/// @nodoc
class __$$OfflineCapableDataImplCopyWithImpl<$Res>
    extends _$OfflineCapableDataCopyWithImpl<$Res, _$OfflineCapableDataImpl>
    implements _$$OfflineCapableDataImplCopyWith<$Res> {
  __$$OfflineCapableDataImplCopyWithImpl(_$OfflineCapableDataImpl _value,
      $Res Function(_$OfflineCapableDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? downloadedAt = null,
    Object? expiresAt = null,
    Object? data = null,
  }) {
    return _then(_$OfflineCapableDataImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      downloadedAt: null == downloadedAt
          ? _value.downloadedAt
          : downloadedAt // ignore: cast_nullable_to_non_nullable
              as String,
      expiresAt: null == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as OfflineDataPackage,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OfflineCapableDataImpl implements _OfflineCapableData {
  const _$OfflineCapableDataImpl(
      {required this.userId,
      required this.downloadedAt,
      required this.expiresAt,
      required this.data});

  factory _$OfflineCapableDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$OfflineCapableDataImplFromJson(json);

  @override
  final String userId;
  @override
  final String downloadedAt;
  @override
  final String expiresAt;
  @override
  final OfflineDataPackage data;

  @override
  String toString() {
    return 'OfflineCapableData(userId: $userId, downloadedAt: $downloadedAt, expiresAt: $expiresAt, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OfflineCapableDataImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.downloadedAt, downloadedAt) ||
                other.downloadedAt == downloadedAt) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, userId, downloadedAt, expiresAt, data);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OfflineCapableDataImplCopyWith<_$OfflineCapableDataImpl> get copyWith =>
      __$$OfflineCapableDataImplCopyWithImpl<_$OfflineCapableDataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OfflineCapableDataImplToJson(
      this,
    );
  }
}

abstract class _OfflineCapableData implements OfflineCapableData {
  const factory _OfflineCapableData(
      {required final String userId,
      required final String downloadedAt,
      required final String expiresAt,
      required final OfflineDataPackage data}) = _$OfflineCapableDataImpl;

  factory _OfflineCapableData.fromJson(Map<String, dynamic> json) =
      _$OfflineCapableDataImpl.fromJson;

  @override
  String get userId;
  @override
  String get downloadedAt;
  @override
  String get expiresAt;
  @override
  OfflineDataPackage get data;
  @override
  @JsonKey(ignore: true)
  _$$OfflineCapableDataImplCopyWith<_$OfflineCapableDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OfflineDataPackage _$OfflineDataPackageFromJson(Map<String, dynamic> json) {
  return _OfflineDataPackage.fromJson(json);
}

/// @nodoc
mixin _$OfflineDataPackage {
  List<OfflineAppointment> get appointments =>
      throw _privateConstructorUsedError;
  List<OfflineClient> get clients => throw _privateConstructorUsedError;
  List<OfflineForm> get forms => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OfflineDataPackageCopyWith<OfflineDataPackage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OfflineDataPackageCopyWith<$Res> {
  factory $OfflineDataPackageCopyWith(
          OfflineDataPackage value, $Res Function(OfflineDataPackage) then) =
      _$OfflineDataPackageCopyWithImpl<$Res, OfflineDataPackage>;
  @useResult
  $Res call(
      {List<OfflineAppointment> appointments,
      List<OfflineClient> clients,
      List<OfflineForm> forms});
}

/// @nodoc
class _$OfflineDataPackageCopyWithImpl<$Res, $Val extends OfflineDataPackage>
    implements $OfflineDataPackageCopyWith<$Res> {
  _$OfflineDataPackageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appointments = null,
    Object? clients = null,
    Object? forms = null,
  }) {
    return _then(_value.copyWith(
      appointments: null == appointments
          ? _value.appointments
          : appointments // ignore: cast_nullable_to_non_nullable
              as List<OfflineAppointment>,
      clients: null == clients
          ? _value.clients
          : clients // ignore: cast_nullable_to_non_nullable
              as List<OfflineClient>,
      forms: null == forms
          ? _value.forms
          : forms // ignore: cast_nullable_to_non_nullable
              as List<OfflineForm>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OfflineDataPackageImplCopyWith<$Res>
    implements $OfflineDataPackageCopyWith<$Res> {
  factory _$$OfflineDataPackageImplCopyWith(_$OfflineDataPackageImpl value,
          $Res Function(_$OfflineDataPackageImpl) then) =
      __$$OfflineDataPackageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<OfflineAppointment> appointments,
      List<OfflineClient> clients,
      List<OfflineForm> forms});
}

/// @nodoc
class __$$OfflineDataPackageImplCopyWithImpl<$Res>
    extends _$OfflineDataPackageCopyWithImpl<$Res, _$OfflineDataPackageImpl>
    implements _$$OfflineDataPackageImplCopyWith<$Res> {
  __$$OfflineDataPackageImplCopyWithImpl(_$OfflineDataPackageImpl _value,
      $Res Function(_$OfflineDataPackageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appointments = null,
    Object? clients = null,
    Object? forms = null,
  }) {
    return _then(_$OfflineDataPackageImpl(
      appointments: null == appointments
          ? _value._appointments
          : appointments // ignore: cast_nullable_to_non_nullable
              as List<OfflineAppointment>,
      clients: null == clients
          ? _value._clients
          : clients // ignore: cast_nullable_to_non_nullable
              as List<OfflineClient>,
      forms: null == forms
          ? _value._forms
          : forms // ignore: cast_nullable_to_non_nullable
              as List<OfflineForm>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OfflineDataPackageImpl implements _OfflineDataPackage {
  const _$OfflineDataPackageImpl(
      {required final List<OfflineAppointment> appointments,
      required final List<OfflineClient> clients,
      required final List<OfflineForm> forms})
      : _appointments = appointments,
        _clients = clients,
        _forms = forms;

  factory _$OfflineDataPackageImpl.fromJson(Map<String, dynamic> json) =>
      _$$OfflineDataPackageImplFromJson(json);

  final List<OfflineAppointment> _appointments;
  @override
  List<OfflineAppointment> get appointments {
    if (_appointments is EqualUnmodifiableListView) return _appointments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_appointments);
  }

  final List<OfflineClient> _clients;
  @override
  List<OfflineClient> get clients {
    if (_clients is EqualUnmodifiableListView) return _clients;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_clients);
  }

  final List<OfflineForm> _forms;
  @override
  List<OfflineForm> get forms {
    if (_forms is EqualUnmodifiableListView) return _forms;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_forms);
  }

  @override
  String toString() {
    return 'OfflineDataPackage(appointments: $appointments, clients: $clients, forms: $forms)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OfflineDataPackageImpl &&
            const DeepCollectionEquality()
                .equals(other._appointments, _appointments) &&
            const DeepCollectionEquality().equals(other._clients, _clients) &&
            const DeepCollectionEquality().equals(other._forms, _forms));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_appointments),
      const DeepCollectionEquality().hash(_clients),
      const DeepCollectionEquality().hash(_forms));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OfflineDataPackageImplCopyWith<_$OfflineDataPackageImpl> get copyWith =>
      __$$OfflineDataPackageImplCopyWithImpl<_$OfflineDataPackageImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OfflineDataPackageImplToJson(
      this,
    );
  }
}

abstract class _OfflineDataPackage implements OfflineDataPackage {
  const factory _OfflineDataPackage(
      {required final List<OfflineAppointment> appointments,
      required final List<OfflineClient> clients,
      required final List<OfflineForm> forms}) = _$OfflineDataPackageImpl;

  factory _OfflineDataPackage.fromJson(Map<String, dynamic> json) =
      _$OfflineDataPackageImpl.fromJson;

  @override
  List<OfflineAppointment> get appointments;
  @override
  List<OfflineClient> get clients;
  @override
  List<OfflineForm> get forms;
  @override
  @JsonKey(ignore: true)
  _$$OfflineDataPackageImplCopyWith<_$OfflineDataPackageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OfflineAppointment _$OfflineAppointmentFromJson(Map<String, dynamic> json) {
  return _OfflineAppointment.fromJson(json);
}

/// @nodoc
mixin _$OfflineAppointment {
  String get id => throw _privateConstructorUsedError;
  String get clientName => throw _privateConstructorUsedError;
  String get date => throw _privateConstructorUsedError;
  String get startTime => throw _privateConstructorUsedError;
  String get endTime => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  String get notes => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OfflineAppointmentCopyWith<OfflineAppointment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OfflineAppointmentCopyWith<$Res> {
  factory $OfflineAppointmentCopyWith(
          OfflineAppointment value, $Res Function(OfflineAppointment) then) =
      _$OfflineAppointmentCopyWithImpl<$Res, OfflineAppointment>;
  @useResult
  $Res call(
      {String id,
      String clientName,
      String date,
      String startTime,
      String endTime,
      String address,
      String notes});
}

/// @nodoc
class _$OfflineAppointmentCopyWithImpl<$Res, $Val extends OfflineAppointment>
    implements $OfflineAppointmentCopyWith<$Res> {
  _$OfflineAppointmentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? clientName = null,
    Object? date = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? address = null,
    Object? notes = null,
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
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      notes: null == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OfflineAppointmentImplCopyWith<$Res>
    implements $OfflineAppointmentCopyWith<$Res> {
  factory _$$OfflineAppointmentImplCopyWith(_$OfflineAppointmentImpl value,
          $Res Function(_$OfflineAppointmentImpl) then) =
      __$$OfflineAppointmentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String clientName,
      String date,
      String startTime,
      String endTime,
      String address,
      String notes});
}

/// @nodoc
class __$$OfflineAppointmentImplCopyWithImpl<$Res>
    extends _$OfflineAppointmentCopyWithImpl<$Res, _$OfflineAppointmentImpl>
    implements _$$OfflineAppointmentImplCopyWith<$Res> {
  __$$OfflineAppointmentImplCopyWithImpl(_$OfflineAppointmentImpl _value,
      $Res Function(_$OfflineAppointmentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? clientName = null,
    Object? date = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? address = null,
    Object? notes = null,
  }) {
    return _then(_$OfflineAppointmentImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      clientName: null == clientName
          ? _value.clientName
          : clientName // ignore: cast_nullable_to_non_nullable
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
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      notes: null == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OfflineAppointmentImpl implements _OfflineAppointment {
  const _$OfflineAppointmentImpl(
      {required this.id,
      required this.clientName,
      required this.date,
      required this.startTime,
      required this.endTime,
      required this.address,
      required this.notes});

  factory _$OfflineAppointmentImpl.fromJson(Map<String, dynamic> json) =>
      _$$OfflineAppointmentImplFromJson(json);

  @override
  final String id;
  @override
  final String clientName;
  @override
  final String date;
  @override
  final String startTime;
  @override
  final String endTime;
  @override
  final String address;
  @override
  final String notes;

  @override
  String toString() {
    return 'OfflineAppointment(id: $id, clientName: $clientName, date: $date, startTime: $startTime, endTime: $endTime, address: $address, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OfflineAppointmentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.clientName, clientName) ||
                other.clientName == clientName) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, clientName, date, startTime, endTime, address, notes);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OfflineAppointmentImplCopyWith<_$OfflineAppointmentImpl> get copyWith =>
      __$$OfflineAppointmentImplCopyWithImpl<_$OfflineAppointmentImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OfflineAppointmentImplToJson(
      this,
    );
  }
}

abstract class _OfflineAppointment implements OfflineAppointment {
  const factory _OfflineAppointment(
      {required final String id,
      required final String clientName,
      required final String date,
      required final String startTime,
      required final String endTime,
      required final String address,
      required final String notes}) = _$OfflineAppointmentImpl;

  factory _OfflineAppointment.fromJson(Map<String, dynamic> json) =
      _$OfflineAppointmentImpl.fromJson;

  @override
  String get id;
  @override
  String get clientName;
  @override
  String get date;
  @override
  String get startTime;
  @override
  String get endTime;
  @override
  String get address;
  @override
  String get notes;
  @override
  @JsonKey(ignore: true)
  _$$OfflineAppointmentImplCopyWith<_$OfflineAppointmentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OfflineClient _$OfflineClientFromJson(Map<String, dynamic> json) {
  return _OfflineClient.fromJson(json);
}

/// @nodoc
mixin _$OfflineClient {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  String get emergencyContact => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OfflineClientCopyWith<OfflineClient> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OfflineClientCopyWith<$Res> {
  factory $OfflineClientCopyWith(
          OfflineClient value, $Res Function(OfflineClient) then) =
      _$OfflineClientCopyWithImpl<$Res, OfflineClient>;
  @useResult
  $Res call(
      {String id,
      String name,
      String address,
      String phone,
      String emergencyContact});
}

/// @nodoc
class _$OfflineClientCopyWithImpl<$Res, $Val extends OfflineClient>
    implements $OfflineClientCopyWith<$Res> {
  _$OfflineClientCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? address = null,
    Object? phone = null,
    Object? emergencyContact = null,
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
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      emergencyContact: null == emergencyContact
          ? _value.emergencyContact
          : emergencyContact // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OfflineClientImplCopyWith<$Res>
    implements $OfflineClientCopyWith<$Res> {
  factory _$$OfflineClientImplCopyWith(
          _$OfflineClientImpl value, $Res Function(_$OfflineClientImpl) then) =
      __$$OfflineClientImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String address,
      String phone,
      String emergencyContact});
}

/// @nodoc
class __$$OfflineClientImplCopyWithImpl<$Res>
    extends _$OfflineClientCopyWithImpl<$Res, _$OfflineClientImpl>
    implements _$$OfflineClientImplCopyWith<$Res> {
  __$$OfflineClientImplCopyWithImpl(
      _$OfflineClientImpl _value, $Res Function(_$OfflineClientImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? address = null,
    Object? phone = null,
    Object? emergencyContact = null,
  }) {
    return _then(_$OfflineClientImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      emergencyContact: null == emergencyContact
          ? _value.emergencyContact
          : emergencyContact // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OfflineClientImpl implements _OfflineClient {
  const _$OfflineClientImpl(
      {required this.id,
      required this.name,
      required this.address,
      required this.phone,
      required this.emergencyContact});

  factory _$OfflineClientImpl.fromJson(Map<String, dynamic> json) =>
      _$$OfflineClientImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String address;
  @override
  final String phone;
  @override
  final String emergencyContact;

  @override
  String toString() {
    return 'OfflineClient(id: $id, name: $name, address: $address, phone: $phone, emergencyContact: $emergencyContact)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OfflineClientImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.emergencyContact, emergencyContact) ||
                other.emergencyContact == emergencyContact));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, address, phone, emergencyContact);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OfflineClientImplCopyWith<_$OfflineClientImpl> get copyWith =>
      __$$OfflineClientImplCopyWithImpl<_$OfflineClientImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OfflineClientImplToJson(
      this,
    );
  }
}

abstract class _OfflineClient implements OfflineClient {
  const factory _OfflineClient(
      {required final String id,
      required final String name,
      required final String address,
      required final String phone,
      required final String emergencyContact}) = _$OfflineClientImpl;

  factory _OfflineClient.fromJson(Map<String, dynamic> json) =
      _$OfflineClientImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get address;
  @override
  String get phone;
  @override
  String get emergencyContact;
  @override
  @JsonKey(ignore: true)
  _$$OfflineClientImplCopyWith<_$OfflineClientImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OfflineForm _$OfflineFormFromJson(Map<String, dynamic> json) {
  return _OfflineForm.fromJson(json);
}

/// @nodoc
mixin _$OfflineForm {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  List<String> get fields => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OfflineFormCopyWith<OfflineForm> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OfflineFormCopyWith<$Res> {
  factory $OfflineFormCopyWith(
          OfflineForm value, $Res Function(OfflineForm) then) =
      _$OfflineFormCopyWithImpl<$Res, OfflineForm>;
  @useResult
  $Res call({String id, String name, List<String> fields});
}

/// @nodoc
class _$OfflineFormCopyWithImpl<$Res, $Val extends OfflineForm>
    implements $OfflineFormCopyWith<$Res> {
  _$OfflineFormCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? fields = null,
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
      fields: null == fields
          ? _value.fields
          : fields // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OfflineFormImplCopyWith<$Res>
    implements $OfflineFormCopyWith<$Res> {
  factory _$$OfflineFormImplCopyWith(
          _$OfflineFormImpl value, $Res Function(_$OfflineFormImpl) then) =
      __$$OfflineFormImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, List<String> fields});
}

/// @nodoc
class __$$OfflineFormImplCopyWithImpl<$Res>
    extends _$OfflineFormCopyWithImpl<$Res, _$OfflineFormImpl>
    implements _$$OfflineFormImplCopyWith<$Res> {
  __$$OfflineFormImplCopyWithImpl(
      _$OfflineFormImpl _value, $Res Function(_$OfflineFormImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? fields = null,
  }) {
    return _then(_$OfflineFormImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      fields: null == fields
          ? _value._fields
          : fields // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OfflineFormImpl implements _OfflineForm {
  const _$OfflineFormImpl(
      {required this.id,
      required this.name,
      required final List<String> fields})
      : _fields = fields;

  factory _$OfflineFormImpl.fromJson(Map<String, dynamic> json) =>
      _$$OfflineFormImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  final List<String> _fields;
  @override
  List<String> get fields {
    if (_fields is EqualUnmodifiableListView) return _fields;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_fields);
  }

  @override
  String toString() {
    return 'OfflineForm(id: $id, name: $name, fields: $fields)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OfflineFormImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other._fields, _fields));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, const DeepCollectionEquality().hash(_fields));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OfflineFormImplCopyWith<_$OfflineFormImpl> get copyWith =>
      __$$OfflineFormImplCopyWithImpl<_$OfflineFormImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OfflineFormImplToJson(
      this,
    );
  }
}

abstract class _OfflineForm implements OfflineForm {
  const factory _OfflineForm(
      {required final String id,
      required final String name,
      required final List<String> fields}) = _$OfflineFormImpl;

  factory _OfflineForm.fromJson(Map<String, dynamic> json) =
      _$OfflineFormImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  List<String> get fields;
  @override
  @JsonKey(ignore: true)
  _$$OfflineFormImplCopyWith<_$OfflineFormImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
