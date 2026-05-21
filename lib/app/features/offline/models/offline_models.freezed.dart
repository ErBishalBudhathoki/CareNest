// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'offline_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OfflineQueueItem {
  String get queueId;
  String get userId;
  String get dataType;
  String get action;
  Map<String, dynamic> get payload;
  String get timestamp;
  String get status;
  int get retryCount;

  /// Create a copy of OfflineQueueItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $OfflineQueueItemCopyWith<OfflineQueueItem> get copyWith =>
      _$OfflineQueueItemCopyWithImpl<OfflineQueueItem>(
          this as OfflineQueueItem, _$identity);

  /// Serializes this OfflineQueueItem to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is OfflineQueueItem &&
            (identical(other.queueId, queueId) || other.queueId == queueId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.dataType, dataType) ||
                other.dataType == dataType) &&
            (identical(other.action, action) || other.action == action) &&
            const DeepCollectionEquality().equals(other.payload, payload) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.retryCount, retryCount) ||
                other.retryCount == retryCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      queueId,
      userId,
      dataType,
      action,
      const DeepCollectionEquality().hash(payload),
      timestamp,
      status,
      retryCount);

  @override
  String toString() {
    return 'OfflineQueueItem(queueId: $queueId, userId: $userId, dataType: $dataType, action: $action, payload: $payload, timestamp: $timestamp, status: $status, retryCount: $retryCount)';
  }
}

/// @nodoc
abstract mixin class $OfflineQueueItemCopyWith<$Res> {
  factory $OfflineQueueItemCopyWith(
          OfflineQueueItem value, $Res Function(OfflineQueueItem) _then) =
      _$OfflineQueueItemCopyWithImpl;
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
class _$OfflineQueueItemCopyWithImpl<$Res>
    implements $OfflineQueueItemCopyWith<$Res> {
  _$OfflineQueueItemCopyWithImpl(this._self, this._then);

  final OfflineQueueItem _self;
  final $Res Function(OfflineQueueItem) _then;

  /// Create a copy of OfflineQueueItem
  /// with the given fields replaced by the non-null parameter values.
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
    return _then(_self.copyWith(
      queueId: null == queueId
          ? _self.queueId
          : queueId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      dataType: null == dataType
          ? _self.dataType
          : dataType // ignore: cast_nullable_to_non_nullable
              as String,
      action: null == action
          ? _self.action
          : action // ignore: cast_nullable_to_non_nullable
              as String,
      payload: null == payload
          ? _self.payload
          : payload // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      timestamp: null == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      retryCount: null == retryCount
          ? _self.retryCount
          : retryCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [OfflineQueueItem].
extension OfflineQueueItemPatterns on OfflineQueueItem {
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
    TResult Function(_OfflineQueueItem value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _OfflineQueueItem() when $default != null:
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
    TResult Function(_OfflineQueueItem value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OfflineQueueItem():
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
    TResult? Function(_OfflineQueueItem value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OfflineQueueItem() when $default != null:
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
            String queueId,
            String userId,
            String dataType,
            String action,
            Map<String, dynamic> payload,
            String timestamp,
            String status,
            int retryCount)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _OfflineQueueItem() when $default != null:
        return $default(
            _that.queueId,
            _that.userId,
            _that.dataType,
            _that.action,
            _that.payload,
            _that.timestamp,
            _that.status,
            _that.retryCount);
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
            String queueId,
            String userId,
            String dataType,
            String action,
            Map<String, dynamic> payload,
            String timestamp,
            String status,
            int retryCount)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OfflineQueueItem():
        return $default(
            _that.queueId,
            _that.userId,
            _that.dataType,
            _that.action,
            _that.payload,
            _that.timestamp,
            _that.status,
            _that.retryCount);
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
            String queueId,
            String userId,
            String dataType,
            String action,
            Map<String, dynamic> payload,
            String timestamp,
            String status,
            int retryCount)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OfflineQueueItem() when $default != null:
        return $default(
            _that.queueId,
            _that.userId,
            _that.dataType,
            _that.action,
            _that.payload,
            _that.timestamp,
            _that.status,
            _that.retryCount);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _OfflineQueueItem implements OfflineQueueItem {
  const _OfflineQueueItem(
      {required this.queueId,
      required this.userId,
      required this.dataType,
      required this.action,
      required final Map<String, dynamic> payload,
      required this.timestamp,
      required this.status,
      required this.retryCount})
      : _payload = payload;
  factory _OfflineQueueItem.fromJson(Map<String, dynamic> json) =>
      _$OfflineQueueItemFromJson(json);

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

  /// Create a copy of OfflineQueueItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$OfflineQueueItemCopyWith<_OfflineQueueItem> get copyWith =>
      __$OfflineQueueItemCopyWithImpl<_OfflineQueueItem>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$OfflineQueueItemToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _OfflineQueueItem &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
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

  @override
  String toString() {
    return 'OfflineQueueItem(queueId: $queueId, userId: $userId, dataType: $dataType, action: $action, payload: $payload, timestamp: $timestamp, status: $status, retryCount: $retryCount)';
  }
}

/// @nodoc
abstract mixin class _$OfflineQueueItemCopyWith<$Res>
    implements $OfflineQueueItemCopyWith<$Res> {
  factory _$OfflineQueueItemCopyWith(
          _OfflineQueueItem value, $Res Function(_OfflineQueueItem) _then) =
      __$OfflineQueueItemCopyWithImpl;
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
class __$OfflineQueueItemCopyWithImpl<$Res>
    implements _$OfflineQueueItemCopyWith<$Res> {
  __$OfflineQueueItemCopyWithImpl(this._self, this._then);

  final _OfflineQueueItem _self;
  final $Res Function(_OfflineQueueItem) _then;

  /// Create a copy of OfflineQueueItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
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
    return _then(_OfflineQueueItem(
      queueId: null == queueId
          ? _self.queueId
          : queueId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      dataType: null == dataType
          ? _self.dataType
          : dataType // ignore: cast_nullable_to_non_nullable
              as String,
      action: null == action
          ? _self.action
          : action // ignore: cast_nullable_to_non_nullable
              as String,
      payload: null == payload
          ? _self._payload
          : payload // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      timestamp: null == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      retryCount: null == retryCount
          ? _self.retryCount
          : retryCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$SyncStatus {
  int get total;
  int get successful;
  int get failed;
  int get conflicts;
  List<SyncItemResult> get items;

  /// Create a copy of SyncStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SyncStatusCopyWith<SyncStatus> get copyWith =>
      _$SyncStatusCopyWithImpl<SyncStatus>(this as SyncStatus, _$identity);

  /// Serializes this SyncStatus to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SyncStatus &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.successful, successful) ||
                other.successful == successful) &&
            (identical(other.failed, failed) || other.failed == failed) &&
            (identical(other.conflicts, conflicts) ||
                other.conflicts == conflicts) &&
            const DeepCollectionEquality().equals(other.items, items));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, total, successful, failed,
      conflicts, const DeepCollectionEquality().hash(items));

  @override
  String toString() {
    return 'SyncStatus(total: $total, successful: $successful, failed: $failed, conflicts: $conflicts, items: $items)';
  }
}

/// @nodoc
abstract mixin class $SyncStatusCopyWith<$Res> {
  factory $SyncStatusCopyWith(
          SyncStatus value, $Res Function(SyncStatus) _then) =
      _$SyncStatusCopyWithImpl;
  @useResult
  $Res call(
      {int total,
      int successful,
      int failed,
      int conflicts,
      List<SyncItemResult> items});
}

/// @nodoc
class _$SyncStatusCopyWithImpl<$Res> implements $SyncStatusCopyWith<$Res> {
  _$SyncStatusCopyWithImpl(this._self, this._then);

  final SyncStatus _self;
  final $Res Function(SyncStatus) _then;

  /// Create a copy of SyncStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? total = null,
    Object? successful = null,
    Object? failed = null,
    Object? conflicts = null,
    Object? items = null,
  }) {
    return _then(_self.copyWith(
      total: null == total
          ? _self.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      successful: null == successful
          ? _self.successful
          : successful // ignore: cast_nullable_to_non_nullable
              as int,
      failed: null == failed
          ? _self.failed
          : failed // ignore: cast_nullable_to_non_nullable
              as int,
      conflicts: null == conflicts
          ? _self.conflicts
          : conflicts // ignore: cast_nullable_to_non_nullable
              as int,
      items: null == items
          ? _self.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<SyncItemResult>,
    ));
  }
}

/// Adds pattern-matching-related methods to [SyncStatus].
extension SyncStatusPatterns on SyncStatus {
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
    TResult Function(_SyncStatus value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SyncStatus() when $default != null:
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
    TResult Function(_SyncStatus value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SyncStatus():
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
    TResult? Function(_SyncStatus value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SyncStatus() when $default != null:
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
    TResult Function(int total, int successful, int failed, int conflicts,
            List<SyncItemResult> items)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SyncStatus() when $default != null:
        return $default(_that.total, _that.successful, _that.failed,
            _that.conflicts, _that.items);
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
    TResult Function(int total, int successful, int failed, int conflicts,
            List<SyncItemResult> items)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SyncStatus():
        return $default(_that.total, _that.successful, _that.failed,
            _that.conflicts, _that.items);
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
    TResult? Function(int total, int successful, int failed, int conflicts,
            List<SyncItemResult> items)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SyncStatus() when $default != null:
        return $default(_that.total, _that.successful, _that.failed,
            _that.conflicts, _that.items);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _SyncStatus implements SyncStatus {
  const _SyncStatus(
      {required this.total,
      required this.successful,
      required this.failed,
      required this.conflicts,
      required final List<SyncItemResult> items})
      : _items = items;
  factory _SyncStatus.fromJson(Map<String, dynamic> json) =>
      _$SyncStatusFromJson(json);

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

  /// Create a copy of SyncStatus
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SyncStatusCopyWith<_SyncStatus> get copyWith =>
      __$SyncStatusCopyWithImpl<_SyncStatus>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SyncStatusToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SyncStatus &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.successful, successful) ||
                other.successful == successful) &&
            (identical(other.failed, failed) || other.failed == failed) &&
            (identical(other.conflicts, conflicts) ||
                other.conflicts == conflicts) &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, total, successful, failed,
      conflicts, const DeepCollectionEquality().hash(_items));

  @override
  String toString() {
    return 'SyncStatus(total: $total, successful: $successful, failed: $failed, conflicts: $conflicts, items: $items)';
  }
}

/// @nodoc
abstract mixin class _$SyncStatusCopyWith<$Res>
    implements $SyncStatusCopyWith<$Res> {
  factory _$SyncStatusCopyWith(
          _SyncStatus value, $Res Function(_SyncStatus) _then) =
      __$SyncStatusCopyWithImpl;
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
class __$SyncStatusCopyWithImpl<$Res> implements _$SyncStatusCopyWith<$Res> {
  __$SyncStatusCopyWithImpl(this._self, this._then);

  final _SyncStatus _self;
  final $Res Function(_SyncStatus) _then;

  /// Create a copy of SyncStatus
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? total = null,
    Object? successful = null,
    Object? failed = null,
    Object? conflicts = null,
    Object? items = null,
  }) {
    return _then(_SyncStatus(
      total: null == total
          ? _self.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      successful: null == successful
          ? _self.successful
          : successful // ignore: cast_nullable_to_non_nullable
              as int,
      failed: null == failed
          ? _self.failed
          : failed // ignore: cast_nullable_to_non_nullable
              as int,
      conflicts: null == conflicts
          ? _self.conflicts
          : conflicts // ignore: cast_nullable_to_non_nullable
              as int,
      items: null == items
          ? _self._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<SyncItemResult>,
    ));
  }
}

/// @nodoc
mixin _$SyncItemResult {
  String get queueId;
  String get status;
  String? get reason;
  String? get syncedAt;
  ConflictData? get conflictData;

  /// Create a copy of SyncItemResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SyncItemResultCopyWith<SyncItemResult> get copyWith =>
      _$SyncItemResultCopyWithImpl<SyncItemResult>(
          this as SyncItemResult, _$identity);

  /// Serializes this SyncItemResult to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SyncItemResult &&
            (identical(other.queueId, queueId) || other.queueId == queueId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.syncedAt, syncedAt) ||
                other.syncedAt == syncedAt) &&
            (identical(other.conflictData, conflictData) ||
                other.conflictData == conflictData));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, queueId, status, reason, syncedAt, conflictData);

  @override
  String toString() {
    return 'SyncItemResult(queueId: $queueId, status: $status, reason: $reason, syncedAt: $syncedAt, conflictData: $conflictData)';
  }
}

/// @nodoc
abstract mixin class $SyncItemResultCopyWith<$Res> {
  factory $SyncItemResultCopyWith(
          SyncItemResult value, $Res Function(SyncItemResult) _then) =
      _$SyncItemResultCopyWithImpl;
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
class _$SyncItemResultCopyWithImpl<$Res>
    implements $SyncItemResultCopyWith<$Res> {
  _$SyncItemResultCopyWithImpl(this._self, this._then);

  final SyncItemResult _self;
  final $Res Function(SyncItemResult) _then;

  /// Create a copy of SyncItemResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? queueId = null,
    Object? status = null,
    Object? reason = freezed,
    Object? syncedAt = freezed,
    Object? conflictData = freezed,
  }) {
    return _then(_self.copyWith(
      queueId: null == queueId
          ? _self.queueId
          : queueId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      reason: freezed == reason
          ? _self.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String?,
      syncedAt: freezed == syncedAt
          ? _self.syncedAt
          : syncedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      conflictData: freezed == conflictData
          ? _self.conflictData
          : conflictData // ignore: cast_nullable_to_non_nullable
              as ConflictData?,
    ));
  }

  /// Create a copy of SyncItemResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ConflictDataCopyWith<$Res>? get conflictData {
    if (_self.conflictData == null) {
      return null;
    }

    return $ConflictDataCopyWith<$Res>(_self.conflictData!, (value) {
      return _then(_self.copyWith(conflictData: value));
    });
  }
}

/// Adds pattern-matching-related methods to [SyncItemResult].
extension SyncItemResultPatterns on SyncItemResult {
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
    TResult Function(_SyncItemResult value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SyncItemResult() when $default != null:
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
    TResult Function(_SyncItemResult value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SyncItemResult():
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
    TResult? Function(_SyncItemResult value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SyncItemResult() when $default != null:
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
    TResult Function(String queueId, String status, String? reason,
            String? syncedAt, ConflictData? conflictData)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SyncItemResult() when $default != null:
        return $default(_that.queueId, _that.status, _that.reason,
            _that.syncedAt, _that.conflictData);
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
    TResult Function(String queueId, String status, String? reason,
            String? syncedAt, ConflictData? conflictData)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SyncItemResult():
        return $default(_that.queueId, _that.status, _that.reason,
            _that.syncedAt, _that.conflictData);
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
    TResult? Function(String queueId, String status, String? reason,
            String? syncedAt, ConflictData? conflictData)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SyncItemResult() when $default != null:
        return $default(_that.queueId, _that.status, _that.reason,
            _that.syncedAt, _that.conflictData);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _SyncItemResult implements SyncItemResult {
  const _SyncItemResult(
      {required this.queueId,
      required this.status,
      this.reason,
      this.syncedAt,
      this.conflictData});
  factory _SyncItemResult.fromJson(Map<String, dynamic> json) =>
      _$SyncItemResultFromJson(json);

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

  /// Create a copy of SyncItemResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SyncItemResultCopyWith<_SyncItemResult> get copyWith =>
      __$SyncItemResultCopyWithImpl<_SyncItemResult>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SyncItemResultToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SyncItemResult &&
            (identical(other.queueId, queueId) || other.queueId == queueId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.syncedAt, syncedAt) ||
                other.syncedAt == syncedAt) &&
            (identical(other.conflictData, conflictData) ||
                other.conflictData == conflictData));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, queueId, status, reason, syncedAt, conflictData);

  @override
  String toString() {
    return 'SyncItemResult(queueId: $queueId, status: $status, reason: $reason, syncedAt: $syncedAt, conflictData: $conflictData)';
  }
}

/// @nodoc
abstract mixin class _$SyncItemResultCopyWith<$Res>
    implements $SyncItemResultCopyWith<$Res> {
  factory _$SyncItemResultCopyWith(
          _SyncItemResult value, $Res Function(_SyncItemResult) _then) =
      __$SyncItemResultCopyWithImpl;
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
class __$SyncItemResultCopyWithImpl<$Res>
    implements _$SyncItemResultCopyWith<$Res> {
  __$SyncItemResultCopyWithImpl(this._self, this._then);

  final _SyncItemResult _self;
  final $Res Function(_SyncItemResult) _then;

  /// Create a copy of SyncItemResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? queueId = null,
    Object? status = null,
    Object? reason = freezed,
    Object? syncedAt = freezed,
    Object? conflictData = freezed,
  }) {
    return _then(_SyncItemResult(
      queueId: null == queueId
          ? _self.queueId
          : queueId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      reason: freezed == reason
          ? _self.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String?,
      syncedAt: freezed == syncedAt
          ? _self.syncedAt
          : syncedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      conflictData: freezed == conflictData
          ? _self.conflictData
          : conflictData // ignore: cast_nullable_to_non_nullable
              as ConflictData?,
    ));
  }

  /// Create a copy of SyncItemResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ConflictDataCopyWith<$Res>? get conflictData {
    if (_self.conflictData == null) {
      return null;
    }

    return $ConflictDataCopyWith<$Res>(_self.conflictData!, (value) {
      return _then(_self.copyWith(conflictData: value));
    });
  }
}

/// @nodoc
mixin _$ConflictData {
  String get conflictType;
  int get localVersion;
  int get serverVersion;
  List<String> get conflictFields;
  String get resolution;

  /// Create a copy of ConflictData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ConflictDataCopyWith<ConflictData> get copyWith =>
      _$ConflictDataCopyWithImpl<ConflictData>(
          this as ConflictData, _$identity);

  /// Serializes this ConflictData to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ConflictData &&
            (identical(other.conflictType, conflictType) ||
                other.conflictType == conflictType) &&
            (identical(other.localVersion, localVersion) ||
                other.localVersion == localVersion) &&
            (identical(other.serverVersion, serverVersion) ||
                other.serverVersion == serverVersion) &&
            const DeepCollectionEquality()
                .equals(other.conflictFields, conflictFields) &&
            (identical(other.resolution, resolution) ||
                other.resolution == resolution));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      conflictType,
      localVersion,
      serverVersion,
      const DeepCollectionEquality().hash(conflictFields),
      resolution);

  @override
  String toString() {
    return 'ConflictData(conflictType: $conflictType, localVersion: $localVersion, serverVersion: $serverVersion, conflictFields: $conflictFields, resolution: $resolution)';
  }
}

/// @nodoc
abstract mixin class $ConflictDataCopyWith<$Res> {
  factory $ConflictDataCopyWith(
          ConflictData value, $Res Function(ConflictData) _then) =
      _$ConflictDataCopyWithImpl;
  @useResult
  $Res call(
      {String conflictType,
      int localVersion,
      int serverVersion,
      List<String> conflictFields,
      String resolution});
}

/// @nodoc
class _$ConflictDataCopyWithImpl<$Res> implements $ConflictDataCopyWith<$Res> {
  _$ConflictDataCopyWithImpl(this._self, this._then);

  final ConflictData _self;
  final $Res Function(ConflictData) _then;

  /// Create a copy of ConflictData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? conflictType = null,
    Object? localVersion = null,
    Object? serverVersion = null,
    Object? conflictFields = null,
    Object? resolution = null,
  }) {
    return _then(_self.copyWith(
      conflictType: null == conflictType
          ? _self.conflictType
          : conflictType // ignore: cast_nullable_to_non_nullable
              as String,
      localVersion: null == localVersion
          ? _self.localVersion
          : localVersion // ignore: cast_nullable_to_non_nullable
              as int,
      serverVersion: null == serverVersion
          ? _self.serverVersion
          : serverVersion // ignore: cast_nullable_to_non_nullable
              as int,
      conflictFields: null == conflictFields
          ? _self.conflictFields
          : conflictFields // ignore: cast_nullable_to_non_nullable
              as List<String>,
      resolution: null == resolution
          ? _self.resolution
          : resolution // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [ConflictData].
extension ConflictDataPatterns on ConflictData {
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
    TResult Function(_ConflictData value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ConflictData() when $default != null:
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
    TResult Function(_ConflictData value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ConflictData():
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
    TResult? Function(_ConflictData value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ConflictData() when $default != null:
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
    TResult Function(String conflictType, int localVersion, int serverVersion,
            List<String> conflictFields, String resolution)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ConflictData() when $default != null:
        return $default(_that.conflictType, _that.localVersion,
            _that.serverVersion, _that.conflictFields, _that.resolution);
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
    TResult Function(String conflictType, int localVersion, int serverVersion,
            List<String> conflictFields, String resolution)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ConflictData():
        return $default(_that.conflictType, _that.localVersion,
            _that.serverVersion, _that.conflictFields, _that.resolution);
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
    TResult? Function(String conflictType, int localVersion, int serverVersion,
            List<String> conflictFields, String resolution)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ConflictData() when $default != null:
        return $default(_that.conflictType, _that.localVersion,
            _that.serverVersion, _that.conflictFields, _that.resolution);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ConflictData implements ConflictData {
  const _ConflictData(
      {required this.conflictType,
      required this.localVersion,
      required this.serverVersion,
      required final List<String> conflictFields,
      required this.resolution})
      : _conflictFields = conflictFields;
  factory _ConflictData.fromJson(Map<String, dynamic> json) =>
      _$ConflictDataFromJson(json);

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

  /// Create a copy of ConflictData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ConflictDataCopyWith<_ConflictData> get copyWith =>
      __$ConflictDataCopyWithImpl<_ConflictData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ConflictDataToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ConflictData &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      conflictType,
      localVersion,
      serverVersion,
      const DeepCollectionEquality().hash(_conflictFields),
      resolution);

  @override
  String toString() {
    return 'ConflictData(conflictType: $conflictType, localVersion: $localVersion, serverVersion: $serverVersion, conflictFields: $conflictFields, resolution: $resolution)';
  }
}

/// @nodoc
abstract mixin class _$ConflictDataCopyWith<$Res>
    implements $ConflictDataCopyWith<$Res> {
  factory _$ConflictDataCopyWith(
          _ConflictData value, $Res Function(_ConflictData) _then) =
      __$ConflictDataCopyWithImpl;
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
class __$ConflictDataCopyWithImpl<$Res>
    implements _$ConflictDataCopyWith<$Res> {
  __$ConflictDataCopyWithImpl(this._self, this._then);

  final _ConflictData _self;
  final $Res Function(_ConflictData) _then;

  /// Create a copy of ConflictData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? conflictType = null,
    Object? localVersion = null,
    Object? serverVersion = null,
    Object? conflictFields = null,
    Object? resolution = null,
  }) {
    return _then(_ConflictData(
      conflictType: null == conflictType
          ? _self.conflictType
          : conflictType // ignore: cast_nullable_to_non_nullable
              as String,
      localVersion: null == localVersion
          ? _self.localVersion
          : localVersion // ignore: cast_nullable_to_non_nullable
              as int,
      serverVersion: null == serverVersion
          ? _self.serverVersion
          : serverVersion // ignore: cast_nullable_to_non_nullable
              as int,
      conflictFields: null == conflictFields
          ? _self._conflictFields
          : conflictFields // ignore: cast_nullable_to_non_nullable
              as List<String>,
      resolution: null == resolution
          ? _self.resolution
          : resolution // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$ConflictResolution {
  String get conflictId;
  String get resolution;
  String get resolvedAt;
  Map<String, dynamic> get finalData;

  /// Create a copy of ConflictResolution
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ConflictResolutionCopyWith<ConflictResolution> get copyWith =>
      _$ConflictResolutionCopyWithImpl<ConflictResolution>(
          this as ConflictResolution, _$identity);

  /// Serializes this ConflictResolution to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ConflictResolution &&
            (identical(other.conflictId, conflictId) ||
                other.conflictId == conflictId) &&
            (identical(other.resolution, resolution) ||
                other.resolution == resolution) &&
            (identical(other.resolvedAt, resolvedAt) ||
                other.resolvedAt == resolvedAt) &&
            const DeepCollectionEquality().equals(other.finalData, finalData));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, conflictId, resolution,
      resolvedAt, const DeepCollectionEquality().hash(finalData));

  @override
  String toString() {
    return 'ConflictResolution(conflictId: $conflictId, resolution: $resolution, resolvedAt: $resolvedAt, finalData: $finalData)';
  }
}

/// @nodoc
abstract mixin class $ConflictResolutionCopyWith<$Res> {
  factory $ConflictResolutionCopyWith(
          ConflictResolution value, $Res Function(ConflictResolution) _then) =
      _$ConflictResolutionCopyWithImpl;
  @useResult
  $Res call(
      {String conflictId,
      String resolution,
      String resolvedAt,
      Map<String, dynamic> finalData});
}

/// @nodoc
class _$ConflictResolutionCopyWithImpl<$Res>
    implements $ConflictResolutionCopyWith<$Res> {
  _$ConflictResolutionCopyWithImpl(this._self, this._then);

  final ConflictResolution _self;
  final $Res Function(ConflictResolution) _then;

  /// Create a copy of ConflictResolution
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? conflictId = null,
    Object? resolution = null,
    Object? resolvedAt = null,
    Object? finalData = null,
  }) {
    return _then(_self.copyWith(
      conflictId: null == conflictId
          ? _self.conflictId
          : conflictId // ignore: cast_nullable_to_non_nullable
              as String,
      resolution: null == resolution
          ? _self.resolution
          : resolution // ignore: cast_nullable_to_non_nullable
              as String,
      resolvedAt: null == resolvedAt
          ? _self.resolvedAt
          : resolvedAt // ignore: cast_nullable_to_non_nullable
              as String,
      finalData: null == finalData
          ? _self.finalData
          : finalData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// Adds pattern-matching-related methods to [ConflictResolution].
extension ConflictResolutionPatterns on ConflictResolution {
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
    TResult Function(_ConflictResolution value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ConflictResolution() when $default != null:
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
    TResult Function(_ConflictResolution value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ConflictResolution():
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
    TResult? Function(_ConflictResolution value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ConflictResolution() when $default != null:
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
    TResult Function(String conflictId, String resolution, String resolvedAt,
            Map<String, dynamic> finalData)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ConflictResolution() when $default != null:
        return $default(_that.conflictId, _that.resolution, _that.resolvedAt,
            _that.finalData);
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
    TResult Function(String conflictId, String resolution, String resolvedAt,
            Map<String, dynamic> finalData)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ConflictResolution():
        return $default(_that.conflictId, _that.resolution, _that.resolvedAt,
            _that.finalData);
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
    TResult? Function(String conflictId, String resolution, String resolvedAt,
            Map<String, dynamic> finalData)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ConflictResolution() when $default != null:
        return $default(_that.conflictId, _that.resolution, _that.resolvedAt,
            _that.finalData);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ConflictResolution implements ConflictResolution {
  const _ConflictResolution(
      {required this.conflictId,
      required this.resolution,
      required this.resolvedAt,
      required final Map<String, dynamic> finalData})
      : _finalData = finalData;
  factory _ConflictResolution.fromJson(Map<String, dynamic> json) =>
      _$ConflictResolutionFromJson(json);

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

  /// Create a copy of ConflictResolution
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ConflictResolutionCopyWith<_ConflictResolution> get copyWith =>
      __$ConflictResolutionCopyWithImpl<_ConflictResolution>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ConflictResolutionToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ConflictResolution &&
            (identical(other.conflictId, conflictId) ||
                other.conflictId == conflictId) &&
            (identical(other.resolution, resolution) ||
                other.resolution == resolution) &&
            (identical(other.resolvedAt, resolvedAt) ||
                other.resolvedAt == resolvedAt) &&
            const DeepCollectionEquality()
                .equals(other._finalData, _finalData));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, conflictId, resolution,
      resolvedAt, const DeepCollectionEquality().hash(_finalData));

  @override
  String toString() {
    return 'ConflictResolution(conflictId: $conflictId, resolution: $resolution, resolvedAt: $resolvedAt, finalData: $finalData)';
  }
}

/// @nodoc
abstract mixin class _$ConflictResolutionCopyWith<$Res>
    implements $ConflictResolutionCopyWith<$Res> {
  factory _$ConflictResolutionCopyWith(
          _ConflictResolution value, $Res Function(_ConflictResolution) _then) =
      __$ConflictResolutionCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String conflictId,
      String resolution,
      String resolvedAt,
      Map<String, dynamic> finalData});
}

/// @nodoc
class __$ConflictResolutionCopyWithImpl<$Res>
    implements _$ConflictResolutionCopyWith<$Res> {
  __$ConflictResolutionCopyWithImpl(this._self, this._then);

  final _ConflictResolution _self;
  final $Res Function(_ConflictResolution) _then;

  /// Create a copy of ConflictResolution
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? conflictId = null,
    Object? resolution = null,
    Object? resolvedAt = null,
    Object? finalData = null,
  }) {
    return _then(_ConflictResolution(
      conflictId: null == conflictId
          ? _self.conflictId
          : conflictId // ignore: cast_nullable_to_non_nullable
              as String,
      resolution: null == resolution
          ? _self.resolution
          : resolution // ignore: cast_nullable_to_non_nullable
              as String,
      resolvedAt: null == resolvedAt
          ? _self.resolvedAt
          : resolvedAt // ignore: cast_nullable_to_non_nullable
              as String,
      finalData: null == finalData
          ? _self._finalData
          : finalData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
mixin _$OfflineCapableData {
  String get userId;
  String get downloadedAt;
  String get expiresAt;
  OfflineDataPackage get data;

  /// Create a copy of OfflineCapableData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $OfflineCapableDataCopyWith<OfflineCapableData> get copyWith =>
      _$OfflineCapableDataCopyWithImpl<OfflineCapableData>(
          this as OfflineCapableData, _$identity);

  /// Serializes this OfflineCapableData to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is OfflineCapableData &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.downloadedAt, downloadedAt) ||
                other.downloadedAt == downloadedAt) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, userId, downloadedAt, expiresAt, data);

  @override
  String toString() {
    return 'OfflineCapableData(userId: $userId, downloadedAt: $downloadedAt, expiresAt: $expiresAt, data: $data)';
  }
}

/// @nodoc
abstract mixin class $OfflineCapableDataCopyWith<$Res> {
  factory $OfflineCapableDataCopyWith(
          OfflineCapableData value, $Res Function(OfflineCapableData) _then) =
      _$OfflineCapableDataCopyWithImpl;
  @useResult
  $Res call(
      {String userId,
      String downloadedAt,
      String expiresAt,
      OfflineDataPackage data});

  $OfflineDataPackageCopyWith<$Res> get data;
}

/// @nodoc
class _$OfflineCapableDataCopyWithImpl<$Res>
    implements $OfflineCapableDataCopyWith<$Res> {
  _$OfflineCapableDataCopyWithImpl(this._self, this._then);

  final OfflineCapableData _self;
  final $Res Function(OfflineCapableData) _then;

  /// Create a copy of OfflineCapableData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? downloadedAt = null,
    Object? expiresAt = null,
    Object? data = null,
  }) {
    return _then(_self.copyWith(
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      downloadedAt: null == downloadedAt
          ? _self.downloadedAt
          : downloadedAt // ignore: cast_nullable_to_non_nullable
              as String,
      expiresAt: null == expiresAt
          ? _self.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as OfflineDataPackage,
    ));
  }

  /// Create a copy of OfflineCapableData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OfflineDataPackageCopyWith<$Res> get data {
    return $OfflineDataPackageCopyWith<$Res>(_self.data, (value) {
      return _then(_self.copyWith(data: value));
    });
  }
}

/// Adds pattern-matching-related methods to [OfflineCapableData].
extension OfflineCapableDataPatterns on OfflineCapableData {
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
    TResult Function(_OfflineCapableData value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _OfflineCapableData() when $default != null:
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
    TResult Function(_OfflineCapableData value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OfflineCapableData():
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
    TResult? Function(_OfflineCapableData value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OfflineCapableData() when $default != null:
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
    TResult Function(String userId, String downloadedAt, String expiresAt,
            OfflineDataPackage data)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _OfflineCapableData() when $default != null:
        return $default(
            _that.userId, _that.downloadedAt, _that.expiresAt, _that.data);
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
    TResult Function(String userId, String downloadedAt, String expiresAt,
            OfflineDataPackage data)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OfflineCapableData():
        return $default(
            _that.userId, _that.downloadedAt, _that.expiresAt, _that.data);
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
    TResult? Function(String userId, String downloadedAt, String expiresAt,
            OfflineDataPackage data)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OfflineCapableData() when $default != null:
        return $default(
            _that.userId, _that.downloadedAt, _that.expiresAt, _that.data);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _OfflineCapableData implements OfflineCapableData {
  const _OfflineCapableData(
      {required this.userId,
      required this.downloadedAt,
      required this.expiresAt,
      required this.data});
  factory _OfflineCapableData.fromJson(Map<String, dynamic> json) =>
      _$OfflineCapableDataFromJson(json);

  @override
  final String userId;
  @override
  final String downloadedAt;
  @override
  final String expiresAt;
  @override
  final OfflineDataPackage data;

  /// Create a copy of OfflineCapableData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$OfflineCapableDataCopyWith<_OfflineCapableData> get copyWith =>
      __$OfflineCapableDataCopyWithImpl<_OfflineCapableData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$OfflineCapableDataToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _OfflineCapableData &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.downloadedAt, downloadedAt) ||
                other.downloadedAt == downloadedAt) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, userId, downloadedAt, expiresAt, data);

  @override
  String toString() {
    return 'OfflineCapableData(userId: $userId, downloadedAt: $downloadedAt, expiresAt: $expiresAt, data: $data)';
  }
}

/// @nodoc
abstract mixin class _$OfflineCapableDataCopyWith<$Res>
    implements $OfflineCapableDataCopyWith<$Res> {
  factory _$OfflineCapableDataCopyWith(
          _OfflineCapableData value, $Res Function(_OfflineCapableData) _then) =
      __$OfflineCapableDataCopyWithImpl;
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
class __$OfflineCapableDataCopyWithImpl<$Res>
    implements _$OfflineCapableDataCopyWith<$Res> {
  __$OfflineCapableDataCopyWithImpl(this._self, this._then);

  final _OfflineCapableData _self;
  final $Res Function(_OfflineCapableData) _then;

  /// Create a copy of OfflineCapableData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? userId = null,
    Object? downloadedAt = null,
    Object? expiresAt = null,
    Object? data = null,
  }) {
    return _then(_OfflineCapableData(
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      downloadedAt: null == downloadedAt
          ? _self.downloadedAt
          : downloadedAt // ignore: cast_nullable_to_non_nullable
              as String,
      expiresAt: null == expiresAt
          ? _self.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as OfflineDataPackage,
    ));
  }

  /// Create a copy of OfflineCapableData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OfflineDataPackageCopyWith<$Res> get data {
    return $OfflineDataPackageCopyWith<$Res>(_self.data, (value) {
      return _then(_self.copyWith(data: value));
    });
  }
}

/// @nodoc
mixin _$OfflineDataPackage {
  List<OfflineAppointment> get appointments;
  List<OfflineClient> get clients;
  List<OfflineForm> get forms;

  /// Create a copy of OfflineDataPackage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $OfflineDataPackageCopyWith<OfflineDataPackage> get copyWith =>
      _$OfflineDataPackageCopyWithImpl<OfflineDataPackage>(
          this as OfflineDataPackage, _$identity);

  /// Serializes this OfflineDataPackage to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is OfflineDataPackage &&
            const DeepCollectionEquality()
                .equals(other.appointments, appointments) &&
            const DeepCollectionEquality().equals(other.clients, clients) &&
            const DeepCollectionEquality().equals(other.forms, forms));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(appointments),
      const DeepCollectionEquality().hash(clients),
      const DeepCollectionEquality().hash(forms));

  @override
  String toString() {
    return 'OfflineDataPackage(appointments: $appointments, clients: $clients, forms: $forms)';
  }
}

/// @nodoc
abstract mixin class $OfflineDataPackageCopyWith<$Res> {
  factory $OfflineDataPackageCopyWith(
          OfflineDataPackage value, $Res Function(OfflineDataPackage) _then) =
      _$OfflineDataPackageCopyWithImpl;
  @useResult
  $Res call(
      {List<OfflineAppointment> appointments,
      List<OfflineClient> clients,
      List<OfflineForm> forms});
}

/// @nodoc
class _$OfflineDataPackageCopyWithImpl<$Res>
    implements $OfflineDataPackageCopyWith<$Res> {
  _$OfflineDataPackageCopyWithImpl(this._self, this._then);

  final OfflineDataPackage _self;
  final $Res Function(OfflineDataPackage) _then;

  /// Create a copy of OfflineDataPackage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appointments = null,
    Object? clients = null,
    Object? forms = null,
  }) {
    return _then(_self.copyWith(
      appointments: null == appointments
          ? _self.appointments
          : appointments // ignore: cast_nullable_to_non_nullable
              as List<OfflineAppointment>,
      clients: null == clients
          ? _self.clients
          : clients // ignore: cast_nullable_to_non_nullable
              as List<OfflineClient>,
      forms: null == forms
          ? _self.forms
          : forms // ignore: cast_nullable_to_non_nullable
              as List<OfflineForm>,
    ));
  }
}

/// Adds pattern-matching-related methods to [OfflineDataPackage].
extension OfflineDataPackagePatterns on OfflineDataPackage {
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
    TResult Function(_OfflineDataPackage value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _OfflineDataPackage() when $default != null:
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
    TResult Function(_OfflineDataPackage value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OfflineDataPackage():
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
    TResult? Function(_OfflineDataPackage value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OfflineDataPackage() when $default != null:
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
    TResult Function(List<OfflineAppointment> appointments,
            List<OfflineClient> clients, List<OfflineForm> forms)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _OfflineDataPackage() when $default != null:
        return $default(_that.appointments, _that.clients, _that.forms);
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
    TResult Function(List<OfflineAppointment> appointments,
            List<OfflineClient> clients, List<OfflineForm> forms)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OfflineDataPackage():
        return $default(_that.appointments, _that.clients, _that.forms);
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
    TResult? Function(List<OfflineAppointment> appointments,
            List<OfflineClient> clients, List<OfflineForm> forms)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OfflineDataPackage() when $default != null:
        return $default(_that.appointments, _that.clients, _that.forms);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _OfflineDataPackage implements OfflineDataPackage {
  const _OfflineDataPackage(
      {required final List<OfflineAppointment> appointments,
      required final List<OfflineClient> clients,
      required final List<OfflineForm> forms})
      : _appointments = appointments,
        _clients = clients,
        _forms = forms;
  factory _OfflineDataPackage.fromJson(Map<String, dynamic> json) =>
      _$OfflineDataPackageFromJson(json);

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

  /// Create a copy of OfflineDataPackage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$OfflineDataPackageCopyWith<_OfflineDataPackage> get copyWith =>
      __$OfflineDataPackageCopyWithImpl<_OfflineDataPackage>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$OfflineDataPackageToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _OfflineDataPackage &&
            const DeepCollectionEquality()
                .equals(other._appointments, _appointments) &&
            const DeepCollectionEquality().equals(other._clients, _clients) &&
            const DeepCollectionEquality().equals(other._forms, _forms));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_appointments),
      const DeepCollectionEquality().hash(_clients),
      const DeepCollectionEquality().hash(_forms));

  @override
  String toString() {
    return 'OfflineDataPackage(appointments: $appointments, clients: $clients, forms: $forms)';
  }
}

/// @nodoc
abstract mixin class _$OfflineDataPackageCopyWith<$Res>
    implements $OfflineDataPackageCopyWith<$Res> {
  factory _$OfflineDataPackageCopyWith(
          _OfflineDataPackage value, $Res Function(_OfflineDataPackage) _then) =
      __$OfflineDataPackageCopyWithImpl;
  @override
  @useResult
  $Res call(
      {List<OfflineAppointment> appointments,
      List<OfflineClient> clients,
      List<OfflineForm> forms});
}

/// @nodoc
class __$OfflineDataPackageCopyWithImpl<$Res>
    implements _$OfflineDataPackageCopyWith<$Res> {
  __$OfflineDataPackageCopyWithImpl(this._self, this._then);

  final _OfflineDataPackage _self;
  final $Res Function(_OfflineDataPackage) _then;

  /// Create a copy of OfflineDataPackage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? appointments = null,
    Object? clients = null,
    Object? forms = null,
  }) {
    return _then(_OfflineDataPackage(
      appointments: null == appointments
          ? _self._appointments
          : appointments // ignore: cast_nullable_to_non_nullable
              as List<OfflineAppointment>,
      clients: null == clients
          ? _self._clients
          : clients // ignore: cast_nullable_to_non_nullable
              as List<OfflineClient>,
      forms: null == forms
          ? _self._forms
          : forms // ignore: cast_nullable_to_non_nullable
              as List<OfflineForm>,
    ));
  }
}

/// @nodoc
mixin _$OfflineAppointment {
  String get id;
  String get clientName;
  String get date;
  String get startTime;
  String get endTime;
  String get address;
  String get notes;

  /// Create a copy of OfflineAppointment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $OfflineAppointmentCopyWith<OfflineAppointment> get copyWith =>
      _$OfflineAppointmentCopyWithImpl<OfflineAppointment>(
          this as OfflineAppointment, _$identity);

  /// Serializes this OfflineAppointment to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is OfflineAppointment &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, clientName, date, startTime, endTime, address, notes);

  @override
  String toString() {
    return 'OfflineAppointment(id: $id, clientName: $clientName, date: $date, startTime: $startTime, endTime: $endTime, address: $address, notes: $notes)';
  }
}

/// @nodoc
abstract mixin class $OfflineAppointmentCopyWith<$Res> {
  factory $OfflineAppointmentCopyWith(
          OfflineAppointment value, $Res Function(OfflineAppointment) _then) =
      _$OfflineAppointmentCopyWithImpl;
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
class _$OfflineAppointmentCopyWithImpl<$Res>
    implements $OfflineAppointmentCopyWith<$Res> {
  _$OfflineAppointmentCopyWithImpl(this._self, this._then);

  final OfflineAppointment _self;
  final $Res Function(OfflineAppointment) _then;

  /// Create a copy of OfflineAppointment
  /// with the given fields replaced by the non-null parameter values.
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
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      clientName: null == clientName
          ? _self.clientName
          : clientName // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _self.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as String,
      endTime: null == endTime
          ? _self.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _self.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      notes: null == notes
          ? _self.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [OfflineAppointment].
extension OfflineAppointmentPatterns on OfflineAppointment {
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
    TResult Function(_OfflineAppointment value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _OfflineAppointment() when $default != null:
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
    TResult Function(_OfflineAppointment value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OfflineAppointment():
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
    TResult? Function(_OfflineAppointment value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OfflineAppointment() when $default != null:
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
    TResult Function(String id, String clientName, String date,
            String startTime, String endTime, String address, String notes)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _OfflineAppointment() when $default != null:
        return $default(_that.id, _that.clientName, _that.date, _that.startTime,
            _that.endTime, _that.address, _that.notes);
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
    TResult Function(String id, String clientName, String date,
            String startTime, String endTime, String address, String notes)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OfflineAppointment():
        return $default(_that.id, _that.clientName, _that.date, _that.startTime,
            _that.endTime, _that.address, _that.notes);
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
    TResult? Function(String id, String clientName, String date,
            String startTime, String endTime, String address, String notes)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OfflineAppointment() when $default != null:
        return $default(_that.id, _that.clientName, _that.date, _that.startTime,
            _that.endTime, _that.address, _that.notes);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _OfflineAppointment implements OfflineAppointment {
  const _OfflineAppointment(
      {required this.id,
      required this.clientName,
      required this.date,
      required this.startTime,
      required this.endTime,
      required this.address,
      required this.notes});
  factory _OfflineAppointment.fromJson(Map<String, dynamic> json) =>
      _$OfflineAppointmentFromJson(json);

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

  /// Create a copy of OfflineAppointment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$OfflineAppointmentCopyWith<_OfflineAppointment> get copyWith =>
      __$OfflineAppointmentCopyWithImpl<_OfflineAppointment>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$OfflineAppointmentToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _OfflineAppointment &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, clientName, date, startTime, endTime, address, notes);

  @override
  String toString() {
    return 'OfflineAppointment(id: $id, clientName: $clientName, date: $date, startTime: $startTime, endTime: $endTime, address: $address, notes: $notes)';
  }
}

/// @nodoc
abstract mixin class _$OfflineAppointmentCopyWith<$Res>
    implements $OfflineAppointmentCopyWith<$Res> {
  factory _$OfflineAppointmentCopyWith(
          _OfflineAppointment value, $Res Function(_OfflineAppointment) _then) =
      __$OfflineAppointmentCopyWithImpl;
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
class __$OfflineAppointmentCopyWithImpl<$Res>
    implements _$OfflineAppointmentCopyWith<$Res> {
  __$OfflineAppointmentCopyWithImpl(this._self, this._then);

  final _OfflineAppointment _self;
  final $Res Function(_OfflineAppointment) _then;

  /// Create a copy of OfflineAppointment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? clientName = null,
    Object? date = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? address = null,
    Object? notes = null,
  }) {
    return _then(_OfflineAppointment(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      clientName: null == clientName
          ? _self.clientName
          : clientName // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _self.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as String,
      endTime: null == endTime
          ? _self.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _self.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      notes: null == notes
          ? _self.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$OfflineClient {
  String get id;
  String get name;
  String get address;
  String get phone;
  String get emergencyContact;

  /// Create a copy of OfflineClient
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $OfflineClientCopyWith<OfflineClient> get copyWith =>
      _$OfflineClientCopyWithImpl<OfflineClient>(
          this as OfflineClient, _$identity);

  /// Serializes this OfflineClient to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is OfflineClient &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.emergencyContact, emergencyContact) ||
                other.emergencyContact == emergencyContact));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, address, phone, emergencyContact);

  @override
  String toString() {
    return 'OfflineClient(id: $id, name: $name, address: $address, phone: $phone, emergencyContact: $emergencyContact)';
  }
}

/// @nodoc
abstract mixin class $OfflineClientCopyWith<$Res> {
  factory $OfflineClientCopyWith(
          OfflineClient value, $Res Function(OfflineClient) _then) =
      _$OfflineClientCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String name,
      String address,
      String phone,
      String emergencyContact});
}

/// @nodoc
class _$OfflineClientCopyWithImpl<$Res>
    implements $OfflineClientCopyWith<$Res> {
  _$OfflineClientCopyWithImpl(this._self, this._then);

  final OfflineClient _self;
  final $Res Function(OfflineClient) _then;

  /// Create a copy of OfflineClient
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? address = null,
    Object? phone = null,
    Object? emergencyContact = null,
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
      address: null == address
          ? _self.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _self.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      emergencyContact: null == emergencyContact
          ? _self.emergencyContact
          : emergencyContact // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [OfflineClient].
extension OfflineClientPatterns on OfflineClient {
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
    TResult Function(_OfflineClient value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _OfflineClient() when $default != null:
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
    TResult Function(_OfflineClient value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OfflineClient():
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
    TResult? Function(_OfflineClient value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OfflineClient() when $default != null:
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
    TResult Function(String id, String name, String address, String phone,
            String emergencyContact)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _OfflineClient() when $default != null:
        return $default(_that.id, _that.name, _that.address, _that.phone,
            _that.emergencyContact);
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
    TResult Function(String id, String name, String address, String phone,
            String emergencyContact)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OfflineClient():
        return $default(_that.id, _that.name, _that.address, _that.phone,
            _that.emergencyContact);
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
    TResult? Function(String id, String name, String address, String phone,
            String emergencyContact)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OfflineClient() when $default != null:
        return $default(_that.id, _that.name, _that.address, _that.phone,
            _that.emergencyContact);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _OfflineClient implements OfflineClient {
  const _OfflineClient(
      {required this.id,
      required this.name,
      required this.address,
      required this.phone,
      required this.emergencyContact});
  factory _OfflineClient.fromJson(Map<String, dynamic> json) =>
      _$OfflineClientFromJson(json);

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

  /// Create a copy of OfflineClient
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$OfflineClientCopyWith<_OfflineClient> get copyWith =>
      __$OfflineClientCopyWithImpl<_OfflineClient>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$OfflineClientToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _OfflineClient &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.emergencyContact, emergencyContact) ||
                other.emergencyContact == emergencyContact));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, address, phone, emergencyContact);

  @override
  String toString() {
    return 'OfflineClient(id: $id, name: $name, address: $address, phone: $phone, emergencyContact: $emergencyContact)';
  }
}

/// @nodoc
abstract mixin class _$OfflineClientCopyWith<$Res>
    implements $OfflineClientCopyWith<$Res> {
  factory _$OfflineClientCopyWith(
          _OfflineClient value, $Res Function(_OfflineClient) _then) =
      __$OfflineClientCopyWithImpl;
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
class __$OfflineClientCopyWithImpl<$Res>
    implements _$OfflineClientCopyWith<$Res> {
  __$OfflineClientCopyWithImpl(this._self, this._then);

  final _OfflineClient _self;
  final $Res Function(_OfflineClient) _then;

  /// Create a copy of OfflineClient
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? address = null,
    Object? phone = null,
    Object? emergencyContact = null,
  }) {
    return _then(_OfflineClient(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _self.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _self.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      emergencyContact: null == emergencyContact
          ? _self.emergencyContact
          : emergencyContact // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$OfflineForm {
  String get id;
  String get name;
  List<String> get fields;

  /// Create a copy of OfflineForm
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $OfflineFormCopyWith<OfflineForm> get copyWith =>
      _$OfflineFormCopyWithImpl<OfflineForm>(this as OfflineForm, _$identity);

  /// Serializes this OfflineForm to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is OfflineForm &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other.fields, fields));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, const DeepCollectionEquality().hash(fields));

  @override
  String toString() {
    return 'OfflineForm(id: $id, name: $name, fields: $fields)';
  }
}

/// @nodoc
abstract mixin class $OfflineFormCopyWith<$Res> {
  factory $OfflineFormCopyWith(
          OfflineForm value, $Res Function(OfflineForm) _then) =
      _$OfflineFormCopyWithImpl;
  @useResult
  $Res call({String id, String name, List<String> fields});
}

/// @nodoc
class _$OfflineFormCopyWithImpl<$Res> implements $OfflineFormCopyWith<$Res> {
  _$OfflineFormCopyWithImpl(this._self, this._then);

  final OfflineForm _self;
  final $Res Function(OfflineForm) _then;

  /// Create a copy of OfflineForm
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? fields = null,
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
      fields: null == fields
          ? _self.fields
          : fields // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// Adds pattern-matching-related methods to [OfflineForm].
extension OfflineFormPatterns on OfflineForm {
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
    TResult Function(_OfflineForm value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _OfflineForm() when $default != null:
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
    TResult Function(_OfflineForm value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OfflineForm():
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
    TResult? Function(_OfflineForm value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OfflineForm() when $default != null:
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
    TResult Function(String id, String name, List<String> fields)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _OfflineForm() when $default != null:
        return $default(_that.id, _that.name, _that.fields);
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
    TResult Function(String id, String name, List<String> fields) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OfflineForm():
        return $default(_that.id, _that.name, _that.fields);
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
    TResult? Function(String id, String name, List<String> fields)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OfflineForm() when $default != null:
        return $default(_that.id, _that.name, _that.fields);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _OfflineForm implements OfflineForm {
  const _OfflineForm(
      {required this.id,
      required this.name,
      required final List<String> fields})
      : _fields = fields;
  factory _OfflineForm.fromJson(Map<String, dynamic> json) =>
      _$OfflineFormFromJson(json);

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

  /// Create a copy of OfflineForm
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$OfflineFormCopyWith<_OfflineForm> get copyWith =>
      __$OfflineFormCopyWithImpl<_OfflineForm>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$OfflineFormToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _OfflineForm &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other._fields, _fields));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, const DeepCollectionEquality().hash(_fields));

  @override
  String toString() {
    return 'OfflineForm(id: $id, name: $name, fields: $fields)';
  }
}

/// @nodoc
abstract mixin class _$OfflineFormCopyWith<$Res>
    implements $OfflineFormCopyWith<$Res> {
  factory _$OfflineFormCopyWith(
          _OfflineForm value, $Res Function(_OfflineForm) _then) =
      __$OfflineFormCopyWithImpl;
  @override
  @useResult
  $Res call({String id, String name, List<String> fields});
}

/// @nodoc
class __$OfflineFormCopyWithImpl<$Res> implements _$OfflineFormCopyWith<$Res> {
  __$OfflineFormCopyWithImpl(this._self, this._then);

  final _OfflineForm _self;
  final $Res Function(_OfflineForm) _then;

  /// Create a copy of OfflineForm
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? fields = null,
  }) {
    return _then(_OfflineForm(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      fields: null == fields
          ? _self._fields
          : fields // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

// dart format on
