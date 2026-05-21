// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bulk_action_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TimesheetItem {
  String get id;
  String get workerId;
  String get workerName;
  DateTime get date;
  double get hours;
  String get status;
  String? get clientName;
  String? get serviceName;

  /// Create a copy of TimesheetItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TimesheetItemCopyWith<TimesheetItem> get copyWith =>
      _$TimesheetItemCopyWithImpl<TimesheetItem>(
          this as TimesheetItem, _$identity);

  /// Serializes this TimesheetItem to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TimesheetItem &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, workerId, workerName, date,
      hours, status, clientName, serviceName);

  @override
  String toString() {
    return 'TimesheetItem(id: $id, workerId: $workerId, workerName: $workerName, date: $date, hours: $hours, status: $status, clientName: $clientName, serviceName: $serviceName)';
  }
}

/// @nodoc
abstract mixin class $TimesheetItemCopyWith<$Res> {
  factory $TimesheetItemCopyWith(
          TimesheetItem value, $Res Function(TimesheetItem) _then) =
      _$TimesheetItemCopyWithImpl;
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
class _$TimesheetItemCopyWithImpl<$Res>
    implements $TimesheetItemCopyWith<$Res> {
  _$TimesheetItemCopyWithImpl(this._self, this._then);

  final TimesheetItem _self;
  final $Res Function(TimesheetItem) _then;

  /// Create a copy of TimesheetItem
  /// with the given fields replaced by the non-null parameter values.
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
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      workerId: null == workerId
          ? _self.workerId
          : workerId // ignore: cast_nullable_to_non_nullable
              as String,
      workerName: null == workerName
          ? _self.workerName
          : workerName // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      hours: null == hours
          ? _self.hours
          : hours // ignore: cast_nullable_to_non_nullable
              as double,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      clientName: freezed == clientName
          ? _self.clientName
          : clientName // ignore: cast_nullable_to_non_nullable
              as String?,
      serviceName: freezed == serviceName
          ? _self.serviceName
          : serviceName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [TimesheetItem].
extension TimesheetItemPatterns on TimesheetItem {
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
    TResult Function(_TimesheetItem value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TimesheetItem() when $default != null:
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
    TResult Function(_TimesheetItem value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TimesheetItem():
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
    TResult? Function(_TimesheetItem value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TimesheetItem() when $default != null:
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
            String workerId,
            String workerName,
            DateTime date,
            double hours,
            String status,
            String? clientName,
            String? serviceName)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TimesheetItem() when $default != null:
        return $default(_that.id, _that.workerId, _that.workerName, _that.date,
            _that.hours, _that.status, _that.clientName, _that.serviceName);
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
            String workerId,
            String workerName,
            DateTime date,
            double hours,
            String status,
            String? clientName,
            String? serviceName)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TimesheetItem():
        return $default(_that.id, _that.workerId, _that.workerName, _that.date,
            _that.hours, _that.status, _that.clientName, _that.serviceName);
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
            String workerId,
            String workerName,
            DateTime date,
            double hours,
            String status,
            String? clientName,
            String? serviceName)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TimesheetItem() when $default != null:
        return $default(_that.id, _that.workerId, _that.workerName, _that.date,
            _that.hours, _that.status, _that.clientName, _that.serviceName);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _TimesheetItem implements TimesheetItem {
  const _TimesheetItem(
      {required this.id,
      required this.workerId,
      required this.workerName,
      required this.date,
      required this.hours,
      required this.status,
      this.clientName,
      this.serviceName});
  factory _TimesheetItem.fromJson(Map<String, dynamic> json) =>
      _$TimesheetItemFromJson(json);

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

  /// Create a copy of TimesheetItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TimesheetItemCopyWith<_TimesheetItem> get copyWith =>
      __$TimesheetItemCopyWithImpl<_TimesheetItem>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TimesheetItemToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TimesheetItem &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, workerId, workerName, date,
      hours, status, clientName, serviceName);

  @override
  String toString() {
    return 'TimesheetItem(id: $id, workerId: $workerId, workerName: $workerName, date: $date, hours: $hours, status: $status, clientName: $clientName, serviceName: $serviceName)';
  }
}

/// @nodoc
abstract mixin class _$TimesheetItemCopyWith<$Res>
    implements $TimesheetItemCopyWith<$Res> {
  factory _$TimesheetItemCopyWith(
          _TimesheetItem value, $Res Function(_TimesheetItem) _then) =
      __$TimesheetItemCopyWithImpl;
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
class __$TimesheetItemCopyWithImpl<$Res>
    implements _$TimesheetItemCopyWith<$Res> {
  __$TimesheetItemCopyWithImpl(this._self, this._then);

  final _TimesheetItem _self;
  final $Res Function(_TimesheetItem) _then;

  /// Create a copy of TimesheetItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
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
    return _then(_TimesheetItem(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      workerId: null == workerId
          ? _self.workerId
          : workerId // ignore: cast_nullable_to_non_nullable
              as String,
      workerName: null == workerName
          ? _self.workerName
          : workerName // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      hours: null == hours
          ? _self.hours
          : hours // ignore: cast_nullable_to_non_nullable
              as double,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      clientName: freezed == clientName
          ? _self.clientName
          : clientName // ignore: cast_nullable_to_non_nullable
              as String?,
      serviceName: freezed == serviceName
          ? _self.serviceName
          : serviceName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$BulkTimesheetResult {
  int get approvedCount;
  int get rejectedCount;
  int get totalRequested;

  /// Create a copy of BulkTimesheetResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BulkTimesheetResultCopyWith<BulkTimesheetResult> get copyWith =>
      _$BulkTimesheetResultCopyWithImpl<BulkTimesheetResult>(
          this as BulkTimesheetResult, _$identity);

  /// Serializes this BulkTimesheetResult to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BulkTimesheetResult &&
            (identical(other.approvedCount, approvedCount) ||
                other.approvedCount == approvedCount) &&
            (identical(other.rejectedCount, rejectedCount) ||
                other.rejectedCount == rejectedCount) &&
            (identical(other.totalRequested, totalRequested) ||
                other.totalRequested == totalRequested));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, approvedCount, rejectedCount, totalRequested);

  @override
  String toString() {
    return 'BulkTimesheetResult(approvedCount: $approvedCount, rejectedCount: $rejectedCount, totalRequested: $totalRequested)';
  }
}

/// @nodoc
abstract mixin class $BulkTimesheetResultCopyWith<$Res> {
  factory $BulkTimesheetResultCopyWith(
          BulkTimesheetResult value, $Res Function(BulkTimesheetResult) _then) =
      _$BulkTimesheetResultCopyWithImpl;
  @useResult
  $Res call({int approvedCount, int rejectedCount, int totalRequested});
}

/// @nodoc
class _$BulkTimesheetResultCopyWithImpl<$Res>
    implements $BulkTimesheetResultCopyWith<$Res> {
  _$BulkTimesheetResultCopyWithImpl(this._self, this._then);

  final BulkTimesheetResult _self;
  final $Res Function(BulkTimesheetResult) _then;

  /// Create a copy of BulkTimesheetResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? approvedCount = null,
    Object? rejectedCount = null,
    Object? totalRequested = null,
  }) {
    return _then(_self.copyWith(
      approvedCount: null == approvedCount
          ? _self.approvedCount
          : approvedCount // ignore: cast_nullable_to_non_nullable
              as int,
      rejectedCount: null == rejectedCount
          ? _self.rejectedCount
          : rejectedCount // ignore: cast_nullable_to_non_nullable
              as int,
      totalRequested: null == totalRequested
          ? _self.totalRequested
          : totalRequested // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [BulkTimesheetResult].
extension BulkTimesheetResultPatterns on BulkTimesheetResult {
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
    TResult Function(_BulkTimesheetResult value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BulkTimesheetResult() when $default != null:
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
    TResult Function(_BulkTimesheetResult value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BulkTimesheetResult():
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
    TResult? Function(_BulkTimesheetResult value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BulkTimesheetResult() when $default != null:
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
    TResult Function(int approvedCount, int rejectedCount, int totalRequested)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BulkTimesheetResult() when $default != null:
        return $default(
            _that.approvedCount, _that.rejectedCount, _that.totalRequested);
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
    TResult Function(int approvedCount, int rejectedCount, int totalRequested)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BulkTimesheetResult():
        return $default(
            _that.approvedCount, _that.rejectedCount, _that.totalRequested);
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
    TResult? Function(int approvedCount, int rejectedCount, int totalRequested)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BulkTimesheetResult() when $default != null:
        return $default(
            _that.approvedCount, _that.rejectedCount, _that.totalRequested);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _BulkTimesheetResult implements BulkTimesheetResult {
  const _BulkTimesheetResult(
      {required this.approvedCount,
      required this.rejectedCount,
      required this.totalRequested});
  factory _BulkTimesheetResult.fromJson(Map<String, dynamic> json) =>
      _$BulkTimesheetResultFromJson(json);

  @override
  final int approvedCount;
  @override
  final int rejectedCount;
  @override
  final int totalRequested;

  /// Create a copy of BulkTimesheetResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BulkTimesheetResultCopyWith<_BulkTimesheetResult> get copyWith =>
      __$BulkTimesheetResultCopyWithImpl<_BulkTimesheetResult>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$BulkTimesheetResultToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BulkTimesheetResult &&
            (identical(other.approvedCount, approvedCount) ||
                other.approvedCount == approvedCount) &&
            (identical(other.rejectedCount, rejectedCount) ||
                other.rejectedCount == rejectedCount) &&
            (identical(other.totalRequested, totalRequested) ||
                other.totalRequested == totalRequested));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, approvedCount, rejectedCount, totalRequested);

  @override
  String toString() {
    return 'BulkTimesheetResult(approvedCount: $approvedCount, rejectedCount: $rejectedCount, totalRequested: $totalRequested)';
  }
}

/// @nodoc
abstract mixin class _$BulkTimesheetResultCopyWith<$Res>
    implements $BulkTimesheetResultCopyWith<$Res> {
  factory _$BulkTimesheetResultCopyWith(_BulkTimesheetResult value,
          $Res Function(_BulkTimesheetResult) _then) =
      __$BulkTimesheetResultCopyWithImpl;
  @override
  @useResult
  $Res call({int approvedCount, int rejectedCount, int totalRequested});
}

/// @nodoc
class __$BulkTimesheetResultCopyWithImpl<$Res>
    implements _$BulkTimesheetResultCopyWith<$Res> {
  __$BulkTimesheetResultCopyWithImpl(this._self, this._then);

  final _BulkTimesheetResult _self;
  final $Res Function(_BulkTimesheetResult) _then;

  /// Create a copy of BulkTimesheetResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? approvedCount = null,
    Object? rejectedCount = null,
    Object? totalRequested = null,
  }) {
    return _then(_BulkTimesheetResult(
      approvedCount: null == approvedCount
          ? _self.approvedCount
          : approvedCount // ignore: cast_nullable_to_non_nullable
              as int,
      rejectedCount: null == rejectedCount
          ? _self.rejectedCount
          : rejectedCount // ignore: cast_nullable_to_non_nullable
              as int,
      totalRequested: null == totalRequested
          ? _self.totalRequested
          : totalRequested // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$InvoicePreviewItem {
  String get clientId;
  String get clientName;
  String get clientEmail;
  List<AppointmentLineItem> get appointments;
  double get totalAmount;

  /// Create a copy of InvoicePreviewItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $InvoicePreviewItemCopyWith<InvoicePreviewItem> get copyWith =>
      _$InvoicePreviewItemCopyWithImpl<InvoicePreviewItem>(
          this as InvoicePreviewItem, _$identity);

  /// Serializes this InvoicePreviewItem to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is InvoicePreviewItem &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.clientName, clientName) ||
                other.clientName == clientName) &&
            (identical(other.clientEmail, clientEmail) ||
                other.clientEmail == clientEmail) &&
            const DeepCollectionEquality()
                .equals(other.appointments, appointments) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      clientId,
      clientName,
      clientEmail,
      const DeepCollectionEquality().hash(appointments),
      totalAmount);

  @override
  String toString() {
    return 'InvoicePreviewItem(clientId: $clientId, clientName: $clientName, clientEmail: $clientEmail, appointments: $appointments, totalAmount: $totalAmount)';
  }
}

/// @nodoc
abstract mixin class $InvoicePreviewItemCopyWith<$Res> {
  factory $InvoicePreviewItemCopyWith(
          InvoicePreviewItem value, $Res Function(InvoicePreviewItem) _then) =
      _$InvoicePreviewItemCopyWithImpl;
  @useResult
  $Res call(
      {String clientId,
      String clientName,
      String clientEmail,
      List<AppointmentLineItem> appointments,
      double totalAmount});
}

/// @nodoc
class _$InvoicePreviewItemCopyWithImpl<$Res>
    implements $InvoicePreviewItemCopyWith<$Res> {
  _$InvoicePreviewItemCopyWithImpl(this._self, this._then);

  final InvoicePreviewItem _self;
  final $Res Function(InvoicePreviewItem) _then;

  /// Create a copy of InvoicePreviewItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clientId = null,
    Object? clientName = null,
    Object? clientEmail = null,
    Object? appointments = null,
    Object? totalAmount = null,
  }) {
    return _then(_self.copyWith(
      clientId: null == clientId
          ? _self.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      clientName: null == clientName
          ? _self.clientName
          : clientName // ignore: cast_nullable_to_non_nullable
              as String,
      clientEmail: null == clientEmail
          ? _self.clientEmail
          : clientEmail // ignore: cast_nullable_to_non_nullable
              as String,
      appointments: null == appointments
          ? _self.appointments
          : appointments // ignore: cast_nullable_to_non_nullable
              as List<AppointmentLineItem>,
      totalAmount: null == totalAmount
          ? _self.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// Adds pattern-matching-related methods to [InvoicePreviewItem].
extension InvoicePreviewItemPatterns on InvoicePreviewItem {
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
    TResult Function(_InvoicePreviewItem value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _InvoicePreviewItem() when $default != null:
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
    TResult Function(_InvoicePreviewItem value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _InvoicePreviewItem():
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
    TResult? Function(_InvoicePreviewItem value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _InvoicePreviewItem() when $default != null:
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
    TResult Function(String clientId, String clientName, String clientEmail,
            List<AppointmentLineItem> appointments, double totalAmount)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _InvoicePreviewItem() when $default != null:
        return $default(_that.clientId, _that.clientName, _that.clientEmail,
            _that.appointments, _that.totalAmount);
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
    TResult Function(String clientId, String clientName, String clientEmail,
            List<AppointmentLineItem> appointments, double totalAmount)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _InvoicePreviewItem():
        return $default(_that.clientId, _that.clientName, _that.clientEmail,
            _that.appointments, _that.totalAmount);
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
    TResult? Function(String clientId, String clientName, String clientEmail,
            List<AppointmentLineItem> appointments, double totalAmount)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _InvoicePreviewItem() when $default != null:
        return $default(_that.clientId, _that.clientName, _that.clientEmail,
            _that.appointments, _that.totalAmount);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _InvoicePreviewItem implements InvoicePreviewItem {
  const _InvoicePreviewItem(
      {required this.clientId,
      required this.clientName,
      required this.clientEmail,
      required final List<AppointmentLineItem> appointments,
      required this.totalAmount})
      : _appointments = appointments;
  factory _InvoicePreviewItem.fromJson(Map<String, dynamic> json) =>
      _$InvoicePreviewItemFromJson(json);

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

  /// Create a copy of InvoicePreviewItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$InvoicePreviewItemCopyWith<_InvoicePreviewItem> get copyWith =>
      __$InvoicePreviewItemCopyWithImpl<_InvoicePreviewItem>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$InvoicePreviewItemToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _InvoicePreviewItem &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      clientId,
      clientName,
      clientEmail,
      const DeepCollectionEquality().hash(_appointments),
      totalAmount);

  @override
  String toString() {
    return 'InvoicePreviewItem(clientId: $clientId, clientName: $clientName, clientEmail: $clientEmail, appointments: $appointments, totalAmount: $totalAmount)';
  }
}

/// @nodoc
abstract mixin class _$InvoicePreviewItemCopyWith<$Res>
    implements $InvoicePreviewItemCopyWith<$Res> {
  factory _$InvoicePreviewItemCopyWith(
          _InvoicePreviewItem value, $Res Function(_InvoicePreviewItem) _then) =
      __$InvoicePreviewItemCopyWithImpl;
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
class __$InvoicePreviewItemCopyWithImpl<$Res>
    implements _$InvoicePreviewItemCopyWith<$Res> {
  __$InvoicePreviewItemCopyWithImpl(this._self, this._then);

  final _InvoicePreviewItem _self;
  final $Res Function(_InvoicePreviewItem) _then;

  /// Create a copy of InvoicePreviewItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? clientId = null,
    Object? clientName = null,
    Object? clientEmail = null,
    Object? appointments = null,
    Object? totalAmount = null,
  }) {
    return _then(_InvoicePreviewItem(
      clientId: null == clientId
          ? _self.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      clientName: null == clientName
          ? _self.clientName
          : clientName // ignore: cast_nullable_to_non_nullable
              as String,
      clientEmail: null == clientEmail
          ? _self.clientEmail
          : clientEmail // ignore: cast_nullable_to_non_nullable
              as String,
      appointments: null == appointments
          ? _self._appointments
          : appointments // ignore: cast_nullable_to_non_nullable
              as List<AppointmentLineItem>,
      totalAmount: null == totalAmount
          ? _self.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
mixin _$AppointmentLineItem {
  String get appointmentId;
  DateTime get date;
  String get service;
  double get duration;
  double get rate;
  double get amount;

  /// Create a copy of AppointmentLineItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AppointmentLineItemCopyWith<AppointmentLineItem> get copyWith =>
      _$AppointmentLineItemCopyWithImpl<AppointmentLineItem>(
          this as AppointmentLineItem, _$identity);

  /// Serializes this AppointmentLineItem to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AppointmentLineItem &&
            (identical(other.appointmentId, appointmentId) ||
                other.appointmentId == appointmentId) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.service, service) || other.service == service) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.rate, rate) || other.rate == rate) &&
            (identical(other.amount, amount) || other.amount == amount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, appointmentId, date, service, duration, rate, amount);

  @override
  String toString() {
    return 'AppointmentLineItem(appointmentId: $appointmentId, date: $date, service: $service, duration: $duration, rate: $rate, amount: $amount)';
  }
}

/// @nodoc
abstract mixin class $AppointmentLineItemCopyWith<$Res> {
  factory $AppointmentLineItemCopyWith(
          AppointmentLineItem value, $Res Function(AppointmentLineItem) _then) =
      _$AppointmentLineItemCopyWithImpl;
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
class _$AppointmentLineItemCopyWithImpl<$Res>
    implements $AppointmentLineItemCopyWith<$Res> {
  _$AppointmentLineItemCopyWithImpl(this._self, this._then);

  final AppointmentLineItem _self;
  final $Res Function(AppointmentLineItem) _then;

  /// Create a copy of AppointmentLineItem
  /// with the given fields replaced by the non-null parameter values.
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
    return _then(_self.copyWith(
      appointmentId: null == appointmentId
          ? _self.appointmentId
          : appointmentId // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      service: null == service
          ? _self.service
          : service // ignore: cast_nullable_to_non_nullable
              as String,
      duration: null == duration
          ? _self.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as double,
      rate: null == rate
          ? _self.rate
          : rate // ignore: cast_nullable_to_non_nullable
              as double,
      amount: null == amount
          ? _self.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// Adds pattern-matching-related methods to [AppointmentLineItem].
extension AppointmentLineItemPatterns on AppointmentLineItem {
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
    TResult Function(_AppointmentLineItem value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AppointmentLineItem() when $default != null:
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
    TResult Function(_AppointmentLineItem value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AppointmentLineItem():
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
    TResult? Function(_AppointmentLineItem value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AppointmentLineItem() when $default != null:
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
    TResult Function(String appointmentId, DateTime date, String service,
            double duration, double rate, double amount)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AppointmentLineItem() when $default != null:
        return $default(_that.appointmentId, _that.date, _that.service,
            _that.duration, _that.rate, _that.amount);
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
    TResult Function(String appointmentId, DateTime date, String service,
            double duration, double rate, double amount)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AppointmentLineItem():
        return $default(_that.appointmentId, _that.date, _that.service,
            _that.duration, _that.rate, _that.amount);
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
    TResult? Function(String appointmentId, DateTime date, String service,
            double duration, double rate, double amount)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AppointmentLineItem() when $default != null:
        return $default(_that.appointmentId, _that.date, _that.service,
            _that.duration, _that.rate, _that.amount);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _AppointmentLineItem implements AppointmentLineItem {
  const _AppointmentLineItem(
      {required this.appointmentId,
      required this.date,
      required this.service,
      required this.duration,
      required this.rate,
      required this.amount});
  factory _AppointmentLineItem.fromJson(Map<String, dynamic> json) =>
      _$AppointmentLineItemFromJson(json);

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

  /// Create a copy of AppointmentLineItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AppointmentLineItemCopyWith<_AppointmentLineItem> get copyWith =>
      __$AppointmentLineItemCopyWithImpl<_AppointmentLineItem>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AppointmentLineItemToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AppointmentLineItem &&
            (identical(other.appointmentId, appointmentId) ||
                other.appointmentId == appointmentId) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.service, service) || other.service == service) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.rate, rate) || other.rate == rate) &&
            (identical(other.amount, amount) || other.amount == amount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, appointmentId, date, service, duration, rate, amount);

  @override
  String toString() {
    return 'AppointmentLineItem(appointmentId: $appointmentId, date: $date, service: $service, duration: $duration, rate: $rate, amount: $amount)';
  }
}

/// @nodoc
abstract mixin class _$AppointmentLineItemCopyWith<$Res>
    implements $AppointmentLineItemCopyWith<$Res> {
  factory _$AppointmentLineItemCopyWith(_AppointmentLineItem value,
          $Res Function(_AppointmentLineItem) _then) =
      __$AppointmentLineItemCopyWithImpl;
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
class __$AppointmentLineItemCopyWithImpl<$Res>
    implements _$AppointmentLineItemCopyWith<$Res> {
  __$AppointmentLineItemCopyWithImpl(this._self, this._then);

  final _AppointmentLineItem _self;
  final $Res Function(_AppointmentLineItem) _then;

  /// Create a copy of AppointmentLineItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? appointmentId = null,
    Object? date = null,
    Object? service = null,
    Object? duration = null,
    Object? rate = null,
    Object? amount = null,
  }) {
    return _then(_AppointmentLineItem(
      appointmentId: null == appointmentId
          ? _self.appointmentId
          : appointmentId // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      service: null == service
          ? _self.service
          : service // ignore: cast_nullable_to_non_nullable
              as String,
      duration: null == duration
          ? _self.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as double,
      rate: null == rate
          ? _self.rate
          : rate // ignore: cast_nullable_to_non_nullable
              as double,
      amount: null == amount
          ? _self.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
mixin _$InvoicePreview {
  int get invoiceCount;
  int get totalAppointments;
  double get totalAmount;
  List<InvoicePreviewItem> get invoices;

  /// Create a copy of InvoicePreview
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $InvoicePreviewCopyWith<InvoicePreview> get copyWith =>
      _$InvoicePreviewCopyWithImpl<InvoicePreview>(
          this as InvoicePreview, _$identity);

  /// Serializes this InvoicePreview to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is InvoicePreview &&
            (identical(other.invoiceCount, invoiceCount) ||
                other.invoiceCount == invoiceCount) &&
            (identical(other.totalAppointments, totalAppointments) ||
                other.totalAppointments == totalAppointments) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount) &&
            const DeepCollectionEquality().equals(other.invoices, invoices));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, invoiceCount, totalAppointments,
      totalAmount, const DeepCollectionEquality().hash(invoices));

  @override
  String toString() {
    return 'InvoicePreview(invoiceCount: $invoiceCount, totalAppointments: $totalAppointments, totalAmount: $totalAmount, invoices: $invoices)';
  }
}

/// @nodoc
abstract mixin class $InvoicePreviewCopyWith<$Res> {
  factory $InvoicePreviewCopyWith(
          InvoicePreview value, $Res Function(InvoicePreview) _then) =
      _$InvoicePreviewCopyWithImpl;
  @useResult
  $Res call(
      {int invoiceCount,
      int totalAppointments,
      double totalAmount,
      List<InvoicePreviewItem> invoices});
}

/// @nodoc
class _$InvoicePreviewCopyWithImpl<$Res>
    implements $InvoicePreviewCopyWith<$Res> {
  _$InvoicePreviewCopyWithImpl(this._self, this._then);

  final InvoicePreview _self;
  final $Res Function(InvoicePreview) _then;

  /// Create a copy of InvoicePreview
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? invoiceCount = null,
    Object? totalAppointments = null,
    Object? totalAmount = null,
    Object? invoices = null,
  }) {
    return _then(_self.copyWith(
      invoiceCount: null == invoiceCount
          ? _self.invoiceCount
          : invoiceCount // ignore: cast_nullable_to_non_nullable
              as int,
      totalAppointments: null == totalAppointments
          ? _self.totalAppointments
          : totalAppointments // ignore: cast_nullable_to_non_nullable
              as int,
      totalAmount: null == totalAmount
          ? _self.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as double,
      invoices: null == invoices
          ? _self.invoices
          : invoices // ignore: cast_nullable_to_non_nullable
              as List<InvoicePreviewItem>,
    ));
  }
}

/// Adds pattern-matching-related methods to [InvoicePreview].
extension InvoicePreviewPatterns on InvoicePreview {
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
    TResult Function(_InvoicePreview value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _InvoicePreview() when $default != null:
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
    TResult Function(_InvoicePreview value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _InvoicePreview():
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
    TResult? Function(_InvoicePreview value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _InvoicePreview() when $default != null:
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
    TResult Function(int invoiceCount, int totalAppointments,
            double totalAmount, List<InvoicePreviewItem> invoices)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _InvoicePreview() when $default != null:
        return $default(_that.invoiceCount, _that.totalAppointments,
            _that.totalAmount, _that.invoices);
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
    TResult Function(int invoiceCount, int totalAppointments,
            double totalAmount, List<InvoicePreviewItem> invoices)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _InvoicePreview():
        return $default(_that.invoiceCount, _that.totalAppointments,
            _that.totalAmount, _that.invoices);
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
    TResult? Function(int invoiceCount, int totalAppointments,
            double totalAmount, List<InvoicePreviewItem> invoices)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _InvoicePreview() when $default != null:
        return $default(_that.invoiceCount, _that.totalAppointments,
            _that.totalAmount, _that.invoices);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _InvoicePreview implements InvoicePreview {
  const _InvoicePreview(
      {required this.invoiceCount,
      required this.totalAppointments,
      required this.totalAmount,
      required final List<InvoicePreviewItem> invoices})
      : _invoices = invoices;
  factory _InvoicePreview.fromJson(Map<String, dynamic> json) =>
      _$InvoicePreviewFromJson(json);

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

  /// Create a copy of InvoicePreview
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$InvoicePreviewCopyWith<_InvoicePreview> get copyWith =>
      __$InvoicePreviewCopyWithImpl<_InvoicePreview>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$InvoicePreviewToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _InvoicePreview &&
            (identical(other.invoiceCount, invoiceCount) ||
                other.invoiceCount == invoiceCount) &&
            (identical(other.totalAppointments, totalAppointments) ||
                other.totalAppointments == totalAppointments) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount) &&
            const DeepCollectionEquality().equals(other._invoices, _invoices));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, invoiceCount, totalAppointments,
      totalAmount, const DeepCollectionEquality().hash(_invoices));

  @override
  String toString() {
    return 'InvoicePreview(invoiceCount: $invoiceCount, totalAppointments: $totalAppointments, totalAmount: $totalAmount, invoices: $invoices)';
  }
}

/// @nodoc
abstract mixin class _$InvoicePreviewCopyWith<$Res>
    implements $InvoicePreviewCopyWith<$Res> {
  factory _$InvoicePreviewCopyWith(
          _InvoicePreview value, $Res Function(_InvoicePreview) _then) =
      __$InvoicePreviewCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int invoiceCount,
      int totalAppointments,
      double totalAmount,
      List<InvoicePreviewItem> invoices});
}

/// @nodoc
class __$InvoicePreviewCopyWithImpl<$Res>
    implements _$InvoicePreviewCopyWith<$Res> {
  __$InvoicePreviewCopyWithImpl(this._self, this._then);

  final _InvoicePreview _self;
  final $Res Function(_InvoicePreview) _then;

  /// Create a copy of InvoicePreview
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? invoiceCount = null,
    Object? totalAppointments = null,
    Object? totalAmount = null,
    Object? invoices = null,
  }) {
    return _then(_InvoicePreview(
      invoiceCount: null == invoiceCount
          ? _self.invoiceCount
          : invoiceCount // ignore: cast_nullable_to_non_nullable
              as int,
      totalAppointments: null == totalAppointments
          ? _self.totalAppointments
          : totalAppointments // ignore: cast_nullable_to_non_nullable
              as int,
      totalAmount: null == totalAmount
          ? _self.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as double,
      invoices: null == invoices
          ? _self._invoices
          : invoices // ignore: cast_nullable_to_non_nullable
              as List<InvoicePreviewItem>,
    ));
  }
}

/// @nodoc
mixin _$BulkInvoiceResult {
  int get invoiceCount;
  int get appointmentCount;
  double get totalAmount;

  /// Create a copy of BulkInvoiceResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BulkInvoiceResultCopyWith<BulkInvoiceResult> get copyWith =>
      _$BulkInvoiceResultCopyWithImpl<BulkInvoiceResult>(
          this as BulkInvoiceResult, _$identity);

  /// Serializes this BulkInvoiceResult to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BulkInvoiceResult &&
            (identical(other.invoiceCount, invoiceCount) ||
                other.invoiceCount == invoiceCount) &&
            (identical(other.appointmentCount, appointmentCount) ||
                other.appointmentCount == appointmentCount) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, invoiceCount, appointmentCount, totalAmount);

  @override
  String toString() {
    return 'BulkInvoiceResult(invoiceCount: $invoiceCount, appointmentCount: $appointmentCount, totalAmount: $totalAmount)';
  }
}

/// @nodoc
abstract mixin class $BulkInvoiceResultCopyWith<$Res> {
  factory $BulkInvoiceResultCopyWith(
          BulkInvoiceResult value, $Res Function(BulkInvoiceResult) _then) =
      _$BulkInvoiceResultCopyWithImpl;
  @useResult
  $Res call({int invoiceCount, int appointmentCount, double totalAmount});
}

/// @nodoc
class _$BulkInvoiceResultCopyWithImpl<$Res>
    implements $BulkInvoiceResultCopyWith<$Res> {
  _$BulkInvoiceResultCopyWithImpl(this._self, this._then);

  final BulkInvoiceResult _self;
  final $Res Function(BulkInvoiceResult) _then;

  /// Create a copy of BulkInvoiceResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? invoiceCount = null,
    Object? appointmentCount = null,
    Object? totalAmount = null,
  }) {
    return _then(_self.copyWith(
      invoiceCount: null == invoiceCount
          ? _self.invoiceCount
          : invoiceCount // ignore: cast_nullable_to_non_nullable
              as int,
      appointmentCount: null == appointmentCount
          ? _self.appointmentCount
          : appointmentCount // ignore: cast_nullable_to_non_nullable
              as int,
      totalAmount: null == totalAmount
          ? _self.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// Adds pattern-matching-related methods to [BulkInvoiceResult].
extension BulkInvoiceResultPatterns on BulkInvoiceResult {
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
    TResult Function(_BulkInvoiceResult value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BulkInvoiceResult() when $default != null:
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
    TResult Function(_BulkInvoiceResult value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BulkInvoiceResult():
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
    TResult? Function(_BulkInvoiceResult value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BulkInvoiceResult() when $default != null:
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
            int invoiceCount, int appointmentCount, double totalAmount)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BulkInvoiceResult() when $default != null:
        return $default(
            _that.invoiceCount, _that.appointmentCount, _that.totalAmount);
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
    TResult Function(int invoiceCount, int appointmentCount, double totalAmount)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BulkInvoiceResult():
        return $default(
            _that.invoiceCount, _that.appointmentCount, _that.totalAmount);
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
            int invoiceCount, int appointmentCount, double totalAmount)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BulkInvoiceResult() when $default != null:
        return $default(
            _that.invoiceCount, _that.appointmentCount, _that.totalAmount);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _BulkInvoiceResult implements BulkInvoiceResult {
  const _BulkInvoiceResult(
      {required this.invoiceCount,
      required this.appointmentCount,
      required this.totalAmount});
  factory _BulkInvoiceResult.fromJson(Map<String, dynamic> json) =>
      _$BulkInvoiceResultFromJson(json);

  @override
  final int invoiceCount;
  @override
  final int appointmentCount;
  @override
  final double totalAmount;

  /// Create a copy of BulkInvoiceResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BulkInvoiceResultCopyWith<_BulkInvoiceResult> get copyWith =>
      __$BulkInvoiceResultCopyWithImpl<_BulkInvoiceResult>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$BulkInvoiceResultToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BulkInvoiceResult &&
            (identical(other.invoiceCount, invoiceCount) ||
                other.invoiceCount == invoiceCount) &&
            (identical(other.appointmentCount, appointmentCount) ||
                other.appointmentCount == appointmentCount) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, invoiceCount, appointmentCount, totalAmount);

  @override
  String toString() {
    return 'BulkInvoiceResult(invoiceCount: $invoiceCount, appointmentCount: $appointmentCount, totalAmount: $totalAmount)';
  }
}

/// @nodoc
abstract mixin class _$BulkInvoiceResultCopyWith<$Res>
    implements $BulkInvoiceResultCopyWith<$Res> {
  factory _$BulkInvoiceResultCopyWith(
          _BulkInvoiceResult value, $Res Function(_BulkInvoiceResult) _then) =
      __$BulkInvoiceResultCopyWithImpl;
  @override
  @useResult
  $Res call({int invoiceCount, int appointmentCount, double totalAmount});
}

/// @nodoc
class __$BulkInvoiceResultCopyWithImpl<$Res>
    implements _$BulkInvoiceResultCopyWith<$Res> {
  __$BulkInvoiceResultCopyWithImpl(this._self, this._then);

  final _BulkInvoiceResult _self;
  final $Res Function(_BulkInvoiceResult) _then;

  /// Create a copy of BulkInvoiceResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? invoiceCount = null,
    Object? appointmentCount = null,
    Object? totalAmount = null,
  }) {
    return _then(_BulkInvoiceResult(
      invoiceCount: null == invoiceCount
          ? _self.invoiceCount
          : invoiceCount // ignore: cast_nullable_to_non_nullable
              as int,
      appointmentCount: null == appointmentCount
          ? _self.appointmentCount
          : appointmentCount // ignore: cast_nullable_to_non_nullable
              as int,
      totalAmount: null == totalAmount
          ? _self.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
mixin _$ShiftAssignment {
  String get shiftId;
  String? get workerId;
  DateTime? get shiftDate;
  String? get shiftTime;
  String? get service;

  /// Create a copy of ShiftAssignment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ShiftAssignmentCopyWith<ShiftAssignment> get copyWith =>
      _$ShiftAssignmentCopyWithImpl<ShiftAssignment>(
          this as ShiftAssignment, _$identity);

  /// Serializes this ShiftAssignment to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ShiftAssignment &&
            (identical(other.shiftId, shiftId) || other.shiftId == shiftId) &&
            (identical(other.workerId, workerId) ||
                other.workerId == workerId) &&
            (identical(other.shiftDate, shiftDate) ||
                other.shiftDate == shiftDate) &&
            (identical(other.shiftTime, shiftTime) ||
                other.shiftTime == shiftTime) &&
            (identical(other.service, service) || other.service == service));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, shiftId, workerId, shiftDate, shiftTime, service);

  @override
  String toString() {
    return 'ShiftAssignment(shiftId: $shiftId, workerId: $workerId, shiftDate: $shiftDate, shiftTime: $shiftTime, service: $service)';
  }
}

/// @nodoc
abstract mixin class $ShiftAssignmentCopyWith<$Res> {
  factory $ShiftAssignmentCopyWith(
          ShiftAssignment value, $Res Function(ShiftAssignment) _then) =
      _$ShiftAssignmentCopyWithImpl;
  @useResult
  $Res call(
      {String shiftId,
      String? workerId,
      DateTime? shiftDate,
      String? shiftTime,
      String? service});
}

/// @nodoc
class _$ShiftAssignmentCopyWithImpl<$Res>
    implements $ShiftAssignmentCopyWith<$Res> {
  _$ShiftAssignmentCopyWithImpl(this._self, this._then);

  final ShiftAssignment _self;
  final $Res Function(ShiftAssignment) _then;

  /// Create a copy of ShiftAssignment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? shiftId = null,
    Object? workerId = freezed,
    Object? shiftDate = freezed,
    Object? shiftTime = freezed,
    Object? service = freezed,
  }) {
    return _then(_self.copyWith(
      shiftId: null == shiftId
          ? _self.shiftId
          : shiftId // ignore: cast_nullable_to_non_nullable
              as String,
      workerId: freezed == workerId
          ? _self.workerId
          : workerId // ignore: cast_nullable_to_non_nullable
              as String?,
      shiftDate: freezed == shiftDate
          ? _self.shiftDate
          : shiftDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      shiftTime: freezed == shiftTime
          ? _self.shiftTime
          : shiftTime // ignore: cast_nullable_to_non_nullable
              as String?,
      service: freezed == service
          ? _self.service
          : service // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [ShiftAssignment].
extension ShiftAssignmentPatterns on ShiftAssignment {
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
    TResult Function(_ShiftAssignment value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ShiftAssignment() when $default != null:
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
    TResult Function(_ShiftAssignment value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ShiftAssignment():
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
    TResult? Function(_ShiftAssignment value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ShiftAssignment() when $default != null:
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
    TResult Function(String shiftId, String? workerId, DateTime? shiftDate,
            String? shiftTime, String? service)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ShiftAssignment() when $default != null:
        return $default(_that.shiftId, _that.workerId, _that.shiftDate,
            _that.shiftTime, _that.service);
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
    TResult Function(String shiftId, String? workerId, DateTime? shiftDate,
            String? shiftTime, String? service)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ShiftAssignment():
        return $default(_that.shiftId, _that.workerId, _that.shiftDate,
            _that.shiftTime, _that.service);
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
    TResult? Function(String shiftId, String? workerId, DateTime? shiftDate,
            String? shiftTime, String? service)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ShiftAssignment() when $default != null:
        return $default(_that.shiftId, _that.workerId, _that.shiftDate,
            _that.shiftTime, _that.service);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ShiftAssignment implements ShiftAssignment {
  const _ShiftAssignment(
      {required this.shiftId,
      required this.workerId,
      this.shiftDate,
      this.shiftTime,
      this.service});
  factory _ShiftAssignment.fromJson(Map<String, dynamic> json) =>
      _$ShiftAssignmentFromJson(json);

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

  /// Create a copy of ShiftAssignment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ShiftAssignmentCopyWith<_ShiftAssignment> get copyWith =>
      __$ShiftAssignmentCopyWithImpl<_ShiftAssignment>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ShiftAssignmentToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ShiftAssignment &&
            (identical(other.shiftId, shiftId) || other.shiftId == shiftId) &&
            (identical(other.workerId, workerId) ||
                other.workerId == workerId) &&
            (identical(other.shiftDate, shiftDate) ||
                other.shiftDate == shiftDate) &&
            (identical(other.shiftTime, shiftTime) ||
                other.shiftTime == shiftTime) &&
            (identical(other.service, service) || other.service == service));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, shiftId, workerId, shiftDate, shiftTime, service);

  @override
  String toString() {
    return 'ShiftAssignment(shiftId: $shiftId, workerId: $workerId, shiftDate: $shiftDate, shiftTime: $shiftTime, service: $service)';
  }
}

/// @nodoc
abstract mixin class _$ShiftAssignmentCopyWith<$Res>
    implements $ShiftAssignmentCopyWith<$Res> {
  factory _$ShiftAssignmentCopyWith(
          _ShiftAssignment value, $Res Function(_ShiftAssignment) _then) =
      __$ShiftAssignmentCopyWithImpl;
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
class __$ShiftAssignmentCopyWithImpl<$Res>
    implements _$ShiftAssignmentCopyWith<$Res> {
  __$ShiftAssignmentCopyWithImpl(this._self, this._then);

  final _ShiftAssignment _self;
  final $Res Function(_ShiftAssignment) _then;

  /// Create a copy of ShiftAssignment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? shiftId = null,
    Object? workerId = freezed,
    Object? shiftDate = freezed,
    Object? shiftTime = freezed,
    Object? service = freezed,
  }) {
    return _then(_ShiftAssignment(
      shiftId: null == shiftId
          ? _self.shiftId
          : shiftId // ignore: cast_nullable_to_non_nullable
              as String,
      workerId: freezed == workerId
          ? _self.workerId
          : workerId // ignore: cast_nullable_to_non_nullable
              as String?,
      shiftDate: freezed == shiftDate
          ? _self.shiftDate
          : shiftDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      shiftTime: freezed == shiftTime
          ? _self.shiftTime
          : shiftTime // ignore: cast_nullable_to_non_nullable
              as String?,
      service: freezed == service
          ? _self.service
          : service // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$WorkerSuggestion {
  String get workerId;
  String get workerName;
  String get workerEmail;
  double get score;
  String get matchReason;
  List<String> get conflicts;
  double get rating;

  /// Create a copy of WorkerSuggestion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WorkerSuggestionCopyWith<WorkerSuggestion> get copyWith =>
      _$WorkerSuggestionCopyWithImpl<WorkerSuggestion>(
          this as WorkerSuggestion, _$identity);

  /// Serializes this WorkerSuggestion to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WorkerSuggestion &&
            (identical(other.workerId, workerId) ||
                other.workerId == workerId) &&
            (identical(other.workerName, workerName) ||
                other.workerName == workerName) &&
            (identical(other.workerEmail, workerEmail) ||
                other.workerEmail == workerEmail) &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.matchReason, matchReason) ||
                other.matchReason == matchReason) &&
            const DeepCollectionEquality().equals(other.conflicts, conflicts) &&
            (identical(other.rating, rating) || other.rating == rating));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      workerId,
      workerName,
      workerEmail,
      score,
      matchReason,
      const DeepCollectionEquality().hash(conflicts),
      rating);

  @override
  String toString() {
    return 'WorkerSuggestion(workerId: $workerId, workerName: $workerName, workerEmail: $workerEmail, score: $score, matchReason: $matchReason, conflicts: $conflicts, rating: $rating)';
  }
}

/// @nodoc
abstract mixin class $WorkerSuggestionCopyWith<$Res> {
  factory $WorkerSuggestionCopyWith(
          WorkerSuggestion value, $Res Function(WorkerSuggestion) _then) =
      _$WorkerSuggestionCopyWithImpl;
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
class _$WorkerSuggestionCopyWithImpl<$Res>
    implements $WorkerSuggestionCopyWith<$Res> {
  _$WorkerSuggestionCopyWithImpl(this._self, this._then);

  final WorkerSuggestion _self;
  final $Res Function(WorkerSuggestion) _then;

  /// Create a copy of WorkerSuggestion
  /// with the given fields replaced by the non-null parameter values.
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
    return _then(_self.copyWith(
      workerId: null == workerId
          ? _self.workerId
          : workerId // ignore: cast_nullable_to_non_nullable
              as String,
      workerName: null == workerName
          ? _self.workerName
          : workerName // ignore: cast_nullable_to_non_nullable
              as String,
      workerEmail: null == workerEmail
          ? _self.workerEmail
          : workerEmail // ignore: cast_nullable_to_non_nullable
              as String,
      score: null == score
          ? _self.score
          : score // ignore: cast_nullable_to_non_nullable
              as double,
      matchReason: null == matchReason
          ? _self.matchReason
          : matchReason // ignore: cast_nullable_to_non_nullable
              as String,
      conflicts: null == conflicts
          ? _self.conflicts
          : conflicts // ignore: cast_nullable_to_non_nullable
              as List<String>,
      rating: null == rating
          ? _self.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// Adds pattern-matching-related methods to [WorkerSuggestion].
extension WorkerSuggestionPatterns on WorkerSuggestion {
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
    TResult Function(_WorkerSuggestion value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _WorkerSuggestion() when $default != null:
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
    TResult Function(_WorkerSuggestion value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WorkerSuggestion():
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
    TResult? Function(_WorkerSuggestion value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WorkerSuggestion() when $default != null:
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
            String workerId,
            String workerName,
            String workerEmail,
            double score,
            String matchReason,
            List<String> conflicts,
            double rating)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _WorkerSuggestion() when $default != null:
        return $default(_that.workerId, _that.workerName, _that.workerEmail,
            _that.score, _that.matchReason, _that.conflicts, _that.rating);
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
            String workerId,
            String workerName,
            String workerEmail,
            double score,
            String matchReason,
            List<String> conflicts,
            double rating)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WorkerSuggestion():
        return $default(_that.workerId, _that.workerName, _that.workerEmail,
            _that.score, _that.matchReason, _that.conflicts, _that.rating);
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
            String workerId,
            String workerName,
            String workerEmail,
            double score,
            String matchReason,
            List<String> conflicts,
            double rating)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WorkerSuggestion() when $default != null:
        return $default(_that.workerId, _that.workerName, _that.workerEmail,
            _that.score, _that.matchReason, _that.conflicts, _that.rating);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _WorkerSuggestion implements WorkerSuggestion {
  const _WorkerSuggestion(
      {required this.workerId,
      required this.workerName,
      required this.workerEmail,
      required this.score,
      required this.matchReason,
      required final List<String> conflicts,
      required this.rating})
      : _conflicts = conflicts;
  factory _WorkerSuggestion.fromJson(Map<String, dynamic> json) =>
      _$WorkerSuggestionFromJson(json);

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

  /// Create a copy of WorkerSuggestion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WorkerSuggestionCopyWith<_WorkerSuggestion> get copyWith =>
      __$WorkerSuggestionCopyWithImpl<_WorkerSuggestion>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$WorkerSuggestionToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WorkerSuggestion &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
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

  @override
  String toString() {
    return 'WorkerSuggestion(workerId: $workerId, workerName: $workerName, workerEmail: $workerEmail, score: $score, matchReason: $matchReason, conflicts: $conflicts, rating: $rating)';
  }
}

/// @nodoc
abstract mixin class _$WorkerSuggestionCopyWith<$Res>
    implements $WorkerSuggestionCopyWith<$Res> {
  factory _$WorkerSuggestionCopyWith(
          _WorkerSuggestion value, $Res Function(_WorkerSuggestion) _then) =
      __$WorkerSuggestionCopyWithImpl;
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
class __$WorkerSuggestionCopyWithImpl<$Res>
    implements _$WorkerSuggestionCopyWith<$Res> {
  __$WorkerSuggestionCopyWithImpl(this._self, this._then);

  final _WorkerSuggestion _self;
  final $Res Function(_WorkerSuggestion) _then;

  /// Create a copy of WorkerSuggestion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? workerId = null,
    Object? workerName = null,
    Object? workerEmail = null,
    Object? score = null,
    Object? matchReason = null,
    Object? conflicts = null,
    Object? rating = null,
  }) {
    return _then(_WorkerSuggestion(
      workerId: null == workerId
          ? _self.workerId
          : workerId // ignore: cast_nullable_to_non_nullable
              as String,
      workerName: null == workerName
          ? _self.workerName
          : workerName // ignore: cast_nullable_to_non_nullable
              as String,
      workerEmail: null == workerEmail
          ? _self.workerEmail
          : workerEmail // ignore: cast_nullable_to_non_nullable
              as String,
      score: null == score
          ? _self.score
          : score // ignore: cast_nullable_to_non_nullable
              as double,
      matchReason: null == matchReason
          ? _self.matchReason
          : matchReason // ignore: cast_nullable_to_non_nullable
              as String,
      conflicts: null == conflicts
          ? _self._conflicts
          : conflicts // ignore: cast_nullable_to_non_nullable
              as List<String>,
      rating: null == rating
          ? _self.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
mixin _$ShiftSuggestion {
  String get shiftId;
  DateTime get shiftDate;
  String get shiftTime;
  String get service;
  List<WorkerSuggestion> get suggestedWorkers;

  /// Create a copy of ShiftSuggestion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ShiftSuggestionCopyWith<ShiftSuggestion> get copyWith =>
      _$ShiftSuggestionCopyWithImpl<ShiftSuggestion>(
          this as ShiftSuggestion, _$identity);

  /// Serializes this ShiftSuggestion to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ShiftSuggestion &&
            (identical(other.shiftId, shiftId) || other.shiftId == shiftId) &&
            (identical(other.shiftDate, shiftDate) ||
                other.shiftDate == shiftDate) &&
            (identical(other.shiftTime, shiftTime) ||
                other.shiftTime == shiftTime) &&
            (identical(other.service, service) || other.service == service) &&
            const DeepCollectionEquality()
                .equals(other.suggestedWorkers, suggestedWorkers));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, shiftId, shiftDate, shiftTime,
      service, const DeepCollectionEquality().hash(suggestedWorkers));

  @override
  String toString() {
    return 'ShiftSuggestion(shiftId: $shiftId, shiftDate: $shiftDate, shiftTime: $shiftTime, service: $service, suggestedWorkers: $suggestedWorkers)';
  }
}

/// @nodoc
abstract mixin class $ShiftSuggestionCopyWith<$Res> {
  factory $ShiftSuggestionCopyWith(
          ShiftSuggestion value, $Res Function(ShiftSuggestion) _then) =
      _$ShiftSuggestionCopyWithImpl;
  @useResult
  $Res call(
      {String shiftId,
      DateTime shiftDate,
      String shiftTime,
      String service,
      List<WorkerSuggestion> suggestedWorkers});
}

/// @nodoc
class _$ShiftSuggestionCopyWithImpl<$Res>
    implements $ShiftSuggestionCopyWith<$Res> {
  _$ShiftSuggestionCopyWithImpl(this._self, this._then);

  final ShiftSuggestion _self;
  final $Res Function(ShiftSuggestion) _then;

  /// Create a copy of ShiftSuggestion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? shiftId = null,
    Object? shiftDate = null,
    Object? shiftTime = null,
    Object? service = null,
    Object? suggestedWorkers = null,
  }) {
    return _then(_self.copyWith(
      shiftId: null == shiftId
          ? _self.shiftId
          : shiftId // ignore: cast_nullable_to_non_nullable
              as String,
      shiftDate: null == shiftDate
          ? _self.shiftDate
          : shiftDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      shiftTime: null == shiftTime
          ? _self.shiftTime
          : shiftTime // ignore: cast_nullable_to_non_nullable
              as String,
      service: null == service
          ? _self.service
          : service // ignore: cast_nullable_to_non_nullable
              as String,
      suggestedWorkers: null == suggestedWorkers
          ? _self.suggestedWorkers
          : suggestedWorkers // ignore: cast_nullable_to_non_nullable
              as List<WorkerSuggestion>,
    ));
  }
}

/// Adds pattern-matching-related methods to [ShiftSuggestion].
extension ShiftSuggestionPatterns on ShiftSuggestion {
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
    TResult Function(_ShiftSuggestion value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ShiftSuggestion() when $default != null:
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
    TResult Function(_ShiftSuggestion value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ShiftSuggestion():
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
    TResult? Function(_ShiftSuggestion value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ShiftSuggestion() when $default != null:
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
    TResult Function(String shiftId, DateTime shiftDate, String shiftTime,
            String service, List<WorkerSuggestion> suggestedWorkers)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ShiftSuggestion() when $default != null:
        return $default(_that.shiftId, _that.shiftDate, _that.shiftTime,
            _that.service, _that.suggestedWorkers);
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
    TResult Function(String shiftId, DateTime shiftDate, String shiftTime,
            String service, List<WorkerSuggestion> suggestedWorkers)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ShiftSuggestion():
        return $default(_that.shiftId, _that.shiftDate, _that.shiftTime,
            _that.service, _that.suggestedWorkers);
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
    TResult? Function(String shiftId, DateTime shiftDate, String shiftTime,
            String service, List<WorkerSuggestion> suggestedWorkers)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ShiftSuggestion() when $default != null:
        return $default(_that.shiftId, _that.shiftDate, _that.shiftTime,
            _that.service, _that.suggestedWorkers);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ShiftSuggestion implements ShiftSuggestion {
  const _ShiftSuggestion(
      {required this.shiftId,
      required this.shiftDate,
      required this.shiftTime,
      required this.service,
      required final List<WorkerSuggestion> suggestedWorkers})
      : _suggestedWorkers = suggestedWorkers;
  factory _ShiftSuggestion.fromJson(Map<String, dynamic> json) =>
      _$ShiftSuggestionFromJson(json);

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

  /// Create a copy of ShiftSuggestion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ShiftSuggestionCopyWith<_ShiftSuggestion> get copyWith =>
      __$ShiftSuggestionCopyWithImpl<_ShiftSuggestion>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ShiftSuggestionToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ShiftSuggestion &&
            (identical(other.shiftId, shiftId) || other.shiftId == shiftId) &&
            (identical(other.shiftDate, shiftDate) ||
                other.shiftDate == shiftDate) &&
            (identical(other.shiftTime, shiftTime) ||
                other.shiftTime == shiftTime) &&
            (identical(other.service, service) || other.service == service) &&
            const DeepCollectionEquality()
                .equals(other._suggestedWorkers, _suggestedWorkers));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, shiftId, shiftDate, shiftTime,
      service, const DeepCollectionEquality().hash(_suggestedWorkers));

  @override
  String toString() {
    return 'ShiftSuggestion(shiftId: $shiftId, shiftDate: $shiftDate, shiftTime: $shiftTime, service: $service, suggestedWorkers: $suggestedWorkers)';
  }
}

/// @nodoc
abstract mixin class _$ShiftSuggestionCopyWith<$Res>
    implements $ShiftSuggestionCopyWith<$Res> {
  factory _$ShiftSuggestionCopyWith(
          _ShiftSuggestion value, $Res Function(_ShiftSuggestion) _then) =
      __$ShiftSuggestionCopyWithImpl;
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
class __$ShiftSuggestionCopyWithImpl<$Res>
    implements _$ShiftSuggestionCopyWith<$Res> {
  __$ShiftSuggestionCopyWithImpl(this._self, this._then);

  final _ShiftSuggestion _self;
  final $Res Function(_ShiftSuggestion) _then;

  /// Create a copy of ShiftSuggestion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? shiftId = null,
    Object? shiftDate = null,
    Object? shiftTime = null,
    Object? service = null,
    Object? suggestedWorkers = null,
  }) {
    return _then(_ShiftSuggestion(
      shiftId: null == shiftId
          ? _self.shiftId
          : shiftId // ignore: cast_nullable_to_non_nullable
              as String,
      shiftDate: null == shiftDate
          ? _self.shiftDate
          : shiftDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      shiftTime: null == shiftTime
          ? _self.shiftTime
          : shiftTime // ignore: cast_nullable_to_non_nullable
              as String,
      service: null == service
          ? _self.service
          : service // ignore: cast_nullable_to_non_nullable
              as String,
      suggestedWorkers: null == suggestedWorkers
          ? _self._suggestedWorkers
          : suggestedWorkers // ignore: cast_nullable_to_non_nullable
              as List<WorkerSuggestion>,
    ));
  }
}

/// @nodoc
mixin _$AssignmentResult {
  String get shiftId;
  String get workerId;
  String? get workerName;
  String? get reason;

  /// Create a copy of AssignmentResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AssignmentResultCopyWith<AssignmentResult> get copyWith =>
      _$AssignmentResultCopyWithImpl<AssignmentResult>(
          this as AssignmentResult, _$identity);

  /// Serializes this AssignmentResult to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AssignmentResult &&
            (identical(other.shiftId, shiftId) || other.shiftId == shiftId) &&
            (identical(other.workerId, workerId) ||
                other.workerId == workerId) &&
            (identical(other.workerName, workerName) ||
                other.workerName == workerName) &&
            (identical(other.reason, reason) || other.reason == reason));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, shiftId, workerId, workerName, reason);

  @override
  String toString() {
    return 'AssignmentResult(shiftId: $shiftId, workerId: $workerId, workerName: $workerName, reason: $reason)';
  }
}

/// @nodoc
abstract mixin class $AssignmentResultCopyWith<$Res> {
  factory $AssignmentResultCopyWith(
          AssignmentResult value, $Res Function(AssignmentResult) _then) =
      _$AssignmentResultCopyWithImpl;
  @useResult
  $Res call(
      {String shiftId, String workerId, String? workerName, String? reason});
}

/// @nodoc
class _$AssignmentResultCopyWithImpl<$Res>
    implements $AssignmentResultCopyWith<$Res> {
  _$AssignmentResultCopyWithImpl(this._self, this._then);

  final AssignmentResult _self;
  final $Res Function(AssignmentResult) _then;

  /// Create a copy of AssignmentResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? shiftId = null,
    Object? workerId = null,
    Object? workerName = freezed,
    Object? reason = freezed,
  }) {
    return _then(_self.copyWith(
      shiftId: null == shiftId
          ? _self.shiftId
          : shiftId // ignore: cast_nullable_to_non_nullable
              as String,
      workerId: null == workerId
          ? _self.workerId
          : workerId // ignore: cast_nullable_to_non_nullable
              as String,
      workerName: freezed == workerName
          ? _self.workerName
          : workerName // ignore: cast_nullable_to_non_nullable
              as String?,
      reason: freezed == reason
          ? _self.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [AssignmentResult].
extension AssignmentResultPatterns on AssignmentResult {
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
    TResult Function(_AssignmentResult value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AssignmentResult() when $default != null:
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
    TResult Function(_AssignmentResult value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AssignmentResult():
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
    TResult? Function(_AssignmentResult value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AssignmentResult() when $default != null:
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
    TResult Function(String shiftId, String workerId, String? workerName,
            String? reason)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AssignmentResult() when $default != null:
        return $default(
            _that.shiftId, _that.workerId, _that.workerName, _that.reason);
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
            String shiftId, String workerId, String? workerName, String? reason)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AssignmentResult():
        return $default(
            _that.shiftId, _that.workerId, _that.workerName, _that.reason);
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
    TResult? Function(String shiftId, String workerId, String? workerName,
            String? reason)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AssignmentResult() when $default != null:
        return $default(
            _that.shiftId, _that.workerId, _that.workerName, _that.reason);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _AssignmentResult implements AssignmentResult {
  const _AssignmentResult(
      {required this.shiftId,
      required this.workerId,
      this.workerName,
      this.reason});
  factory _AssignmentResult.fromJson(Map<String, dynamic> json) =>
      _$AssignmentResultFromJson(json);

  @override
  final String shiftId;
  @override
  final String workerId;
  @override
  final String? workerName;
  @override
  final String? reason;

  /// Create a copy of AssignmentResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AssignmentResultCopyWith<_AssignmentResult> get copyWith =>
      __$AssignmentResultCopyWithImpl<_AssignmentResult>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AssignmentResultToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AssignmentResult &&
            (identical(other.shiftId, shiftId) || other.shiftId == shiftId) &&
            (identical(other.workerId, workerId) ||
                other.workerId == workerId) &&
            (identical(other.workerName, workerName) ||
                other.workerName == workerName) &&
            (identical(other.reason, reason) || other.reason == reason));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, shiftId, workerId, workerName, reason);

  @override
  String toString() {
    return 'AssignmentResult(shiftId: $shiftId, workerId: $workerId, workerName: $workerName, reason: $reason)';
  }
}

/// @nodoc
abstract mixin class _$AssignmentResultCopyWith<$Res>
    implements $AssignmentResultCopyWith<$Res> {
  factory _$AssignmentResultCopyWith(
          _AssignmentResult value, $Res Function(_AssignmentResult) _then) =
      __$AssignmentResultCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String shiftId, String workerId, String? workerName, String? reason});
}

/// @nodoc
class __$AssignmentResultCopyWithImpl<$Res>
    implements _$AssignmentResultCopyWith<$Res> {
  __$AssignmentResultCopyWithImpl(this._self, this._then);

  final _AssignmentResult _self;
  final $Res Function(_AssignmentResult) _then;

  /// Create a copy of AssignmentResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? shiftId = null,
    Object? workerId = null,
    Object? workerName = freezed,
    Object? reason = freezed,
  }) {
    return _then(_AssignmentResult(
      shiftId: null == shiftId
          ? _self.shiftId
          : shiftId // ignore: cast_nullable_to_non_nullable
              as String,
      workerId: null == workerId
          ? _self.workerId
          : workerId // ignore: cast_nullable_to_non_nullable
              as String,
      workerName: freezed == workerName
          ? _self.workerName
          : workerName // ignore: cast_nullable_to_non_nullable
              as String?,
      reason: freezed == reason
          ? _self.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$BulkAssignmentResult {
  int get successfulCount;
  int get failedCount;
  List<AssignmentResult> get successful;
  List<AssignmentResult> get failed;

  /// Create a copy of BulkAssignmentResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BulkAssignmentResultCopyWith<BulkAssignmentResult> get copyWith =>
      _$BulkAssignmentResultCopyWithImpl<BulkAssignmentResult>(
          this as BulkAssignmentResult, _$identity);

  /// Serializes this BulkAssignmentResult to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BulkAssignmentResult &&
            (identical(other.successfulCount, successfulCount) ||
                other.successfulCount == successfulCount) &&
            (identical(other.failedCount, failedCount) ||
                other.failedCount == failedCount) &&
            const DeepCollectionEquality()
                .equals(other.successful, successful) &&
            const DeepCollectionEquality().equals(other.failed, failed));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      successfulCount,
      failedCount,
      const DeepCollectionEquality().hash(successful),
      const DeepCollectionEquality().hash(failed));

  @override
  String toString() {
    return 'BulkAssignmentResult(successfulCount: $successfulCount, failedCount: $failedCount, successful: $successful, failed: $failed)';
  }
}

/// @nodoc
abstract mixin class $BulkAssignmentResultCopyWith<$Res> {
  factory $BulkAssignmentResultCopyWith(BulkAssignmentResult value,
          $Res Function(BulkAssignmentResult) _then) =
      _$BulkAssignmentResultCopyWithImpl;
  @useResult
  $Res call(
      {int successfulCount,
      int failedCount,
      List<AssignmentResult> successful,
      List<AssignmentResult> failed});
}

/// @nodoc
class _$BulkAssignmentResultCopyWithImpl<$Res>
    implements $BulkAssignmentResultCopyWith<$Res> {
  _$BulkAssignmentResultCopyWithImpl(this._self, this._then);

  final BulkAssignmentResult _self;
  final $Res Function(BulkAssignmentResult) _then;

  /// Create a copy of BulkAssignmentResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? successfulCount = null,
    Object? failedCount = null,
    Object? successful = null,
    Object? failed = null,
  }) {
    return _then(_self.copyWith(
      successfulCount: null == successfulCount
          ? _self.successfulCount
          : successfulCount // ignore: cast_nullable_to_non_nullable
              as int,
      failedCount: null == failedCount
          ? _self.failedCount
          : failedCount // ignore: cast_nullable_to_non_nullable
              as int,
      successful: null == successful
          ? _self.successful
          : successful // ignore: cast_nullable_to_non_nullable
              as List<AssignmentResult>,
      failed: null == failed
          ? _self.failed
          : failed // ignore: cast_nullable_to_non_nullable
              as List<AssignmentResult>,
    ));
  }
}

/// Adds pattern-matching-related methods to [BulkAssignmentResult].
extension BulkAssignmentResultPatterns on BulkAssignmentResult {
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
    TResult Function(_BulkAssignmentResult value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BulkAssignmentResult() when $default != null:
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
    TResult Function(_BulkAssignmentResult value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BulkAssignmentResult():
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
    TResult? Function(_BulkAssignmentResult value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BulkAssignmentResult() when $default != null:
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
    TResult Function(int successfulCount, int failedCount,
            List<AssignmentResult> successful, List<AssignmentResult> failed)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BulkAssignmentResult() when $default != null:
        return $default(_that.successfulCount, _that.failedCount,
            _that.successful, _that.failed);
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
    TResult Function(int successfulCount, int failedCount,
            List<AssignmentResult> successful, List<AssignmentResult> failed)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BulkAssignmentResult():
        return $default(_that.successfulCount, _that.failedCount,
            _that.successful, _that.failed);
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
    TResult? Function(int successfulCount, int failedCount,
            List<AssignmentResult> successful, List<AssignmentResult> failed)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BulkAssignmentResult() when $default != null:
        return $default(_that.successfulCount, _that.failedCount,
            _that.successful, _that.failed);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _BulkAssignmentResult implements BulkAssignmentResult {
  const _BulkAssignmentResult(
      {required this.successfulCount,
      required this.failedCount,
      required final List<AssignmentResult> successful,
      required final List<AssignmentResult> failed})
      : _successful = successful,
        _failed = failed;
  factory _BulkAssignmentResult.fromJson(Map<String, dynamic> json) =>
      _$BulkAssignmentResultFromJson(json);

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

  /// Create a copy of BulkAssignmentResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BulkAssignmentResultCopyWith<_BulkAssignmentResult> get copyWith =>
      __$BulkAssignmentResultCopyWithImpl<_BulkAssignmentResult>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$BulkAssignmentResultToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BulkAssignmentResult &&
            (identical(other.successfulCount, successfulCount) ||
                other.successfulCount == successfulCount) &&
            (identical(other.failedCount, failedCount) ||
                other.failedCount == failedCount) &&
            const DeepCollectionEquality()
                .equals(other._successful, _successful) &&
            const DeepCollectionEquality().equals(other._failed, _failed));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      successfulCount,
      failedCount,
      const DeepCollectionEquality().hash(_successful),
      const DeepCollectionEquality().hash(_failed));

  @override
  String toString() {
    return 'BulkAssignmentResult(successfulCount: $successfulCount, failedCount: $failedCount, successful: $successful, failed: $failed)';
  }
}

/// @nodoc
abstract mixin class _$BulkAssignmentResultCopyWith<$Res>
    implements $BulkAssignmentResultCopyWith<$Res> {
  factory _$BulkAssignmentResultCopyWith(_BulkAssignmentResult value,
          $Res Function(_BulkAssignmentResult) _then) =
      __$BulkAssignmentResultCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int successfulCount,
      int failedCount,
      List<AssignmentResult> successful,
      List<AssignmentResult> failed});
}

/// @nodoc
class __$BulkAssignmentResultCopyWithImpl<$Res>
    implements _$BulkAssignmentResultCopyWith<$Res> {
  __$BulkAssignmentResultCopyWithImpl(this._self, this._then);

  final _BulkAssignmentResult _self;
  final $Res Function(_BulkAssignmentResult) _then;

  /// Create a copy of BulkAssignmentResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? successfulCount = null,
    Object? failedCount = null,
    Object? successful = null,
    Object? failed = null,
  }) {
    return _then(_BulkAssignmentResult(
      successfulCount: null == successfulCount
          ? _self.successfulCount
          : successfulCount // ignore: cast_nullable_to_non_nullable
              as int,
      failedCount: null == failedCount
          ? _self.failedCount
          : failedCount // ignore: cast_nullable_to_non_nullable
              as int,
      successful: null == successful
          ? _self._successful
          : successful // ignore: cast_nullable_to_non_nullable
              as List<AssignmentResult>,
      failed: null == failed
          ? _self._failed
          : failed // ignore: cast_nullable_to_non_nullable
              as List<AssignmentResult>,
    ));
  }
}

/// @nodoc
mixin _$MessageRecipient {
  String get id;
  String get name;
  String get email;
  String get role;
  bool get selected;

  /// Create a copy of MessageRecipient
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MessageRecipientCopyWith<MessageRecipient> get copyWith =>
      _$MessageRecipientCopyWithImpl<MessageRecipient>(
          this as MessageRecipient, _$identity);

  /// Serializes this MessageRecipient to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MessageRecipient &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.selected, selected) ||
                other.selected == selected));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, email, role, selected);

  @override
  String toString() {
    return 'MessageRecipient(id: $id, name: $name, email: $email, role: $role, selected: $selected)';
  }
}

/// @nodoc
abstract mixin class $MessageRecipientCopyWith<$Res> {
  factory $MessageRecipientCopyWith(
          MessageRecipient value, $Res Function(MessageRecipient) _then) =
      _$MessageRecipientCopyWithImpl;
  @useResult
  $Res call({String id, String name, String email, String role, bool selected});
}

/// @nodoc
class _$MessageRecipientCopyWithImpl<$Res>
    implements $MessageRecipientCopyWith<$Res> {
  _$MessageRecipientCopyWithImpl(this._self, this._then);

  final MessageRecipient _self;
  final $Res Function(MessageRecipient) _then;

  /// Create a copy of MessageRecipient
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? email = null,
    Object? role = null,
    Object? selected = null,
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
      role: null == role
          ? _self.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      selected: null == selected
          ? _self.selected
          : selected // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [MessageRecipient].
extension MessageRecipientPatterns on MessageRecipient {
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
    TResult Function(_MessageRecipient value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MessageRecipient() when $default != null:
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
    TResult Function(_MessageRecipient value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MessageRecipient():
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
    TResult? Function(_MessageRecipient value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MessageRecipient() when $default != null:
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
            String id, String name, String email, String role, bool selected)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MessageRecipient() when $default != null:
        return $default(
            _that.id, _that.name, _that.email, _that.role, _that.selected);
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
            String id, String name, String email, String role, bool selected)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MessageRecipient():
        return $default(
            _that.id, _that.name, _that.email, _that.role, _that.selected);
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
            String id, String name, String email, String role, bool selected)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MessageRecipient() when $default != null:
        return $default(
            _that.id, _that.name, _that.email, _that.role, _that.selected);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _MessageRecipient implements MessageRecipient {
  const _MessageRecipient(
      {required this.id,
      required this.name,
      required this.email,
      required this.role,
      required this.selected});
  factory _MessageRecipient.fromJson(Map<String, dynamic> json) =>
      _$MessageRecipientFromJson(json);

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

  /// Create a copy of MessageRecipient
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MessageRecipientCopyWith<_MessageRecipient> get copyWith =>
      __$MessageRecipientCopyWithImpl<_MessageRecipient>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$MessageRecipientToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MessageRecipient &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.selected, selected) ||
                other.selected == selected));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, email, role, selected);

  @override
  String toString() {
    return 'MessageRecipient(id: $id, name: $name, email: $email, role: $role, selected: $selected)';
  }
}

/// @nodoc
abstract mixin class _$MessageRecipientCopyWith<$Res>
    implements $MessageRecipientCopyWith<$Res> {
  factory _$MessageRecipientCopyWith(
          _MessageRecipient value, $Res Function(_MessageRecipient) _then) =
      __$MessageRecipientCopyWithImpl;
  @override
  @useResult
  $Res call({String id, String name, String email, String role, bool selected});
}

/// @nodoc
class __$MessageRecipientCopyWithImpl<$Res>
    implements _$MessageRecipientCopyWith<$Res> {
  __$MessageRecipientCopyWithImpl(this._self, this._then);

  final _MessageRecipient _self;
  final $Res Function(_MessageRecipient) _then;

  /// Create a copy of MessageRecipient
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? email = null,
    Object? role = null,
    Object? selected = null,
  }) {
    return _then(_MessageRecipient(
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
      role: null == role
          ? _self.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      selected: null == selected
          ? _self.selected
          : selected // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
mixin _$MessageTemplate {
  String get id;
  String get name;
  String get subject;
  String get body;
  List<String> get variables;

  /// Create a copy of MessageTemplate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MessageTemplateCopyWith<MessageTemplate> get copyWith =>
      _$MessageTemplateCopyWithImpl<MessageTemplate>(
          this as MessageTemplate, _$identity);

  /// Serializes this MessageTemplate to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MessageTemplate &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.subject, subject) || other.subject == subject) &&
            (identical(other.body, body) || other.body == body) &&
            const DeepCollectionEquality().equals(other.variables, variables));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, subject, body,
      const DeepCollectionEquality().hash(variables));

  @override
  String toString() {
    return 'MessageTemplate(id: $id, name: $name, subject: $subject, body: $body, variables: $variables)';
  }
}

/// @nodoc
abstract mixin class $MessageTemplateCopyWith<$Res> {
  factory $MessageTemplateCopyWith(
          MessageTemplate value, $Res Function(MessageTemplate) _then) =
      _$MessageTemplateCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String name,
      String subject,
      String body,
      List<String> variables});
}

/// @nodoc
class _$MessageTemplateCopyWithImpl<$Res>
    implements $MessageTemplateCopyWith<$Res> {
  _$MessageTemplateCopyWithImpl(this._self, this._then);

  final MessageTemplate _self;
  final $Res Function(MessageTemplate) _then;

  /// Create a copy of MessageTemplate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? subject = null,
    Object? body = null,
    Object? variables = null,
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
      subject: null == subject
          ? _self.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _self.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      variables: null == variables
          ? _self.variables
          : variables // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// Adds pattern-matching-related methods to [MessageTemplate].
extension MessageTemplatePatterns on MessageTemplate {
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
    TResult Function(_MessageTemplate value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MessageTemplate() when $default != null:
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
    TResult Function(_MessageTemplate value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MessageTemplate():
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
    TResult? Function(_MessageTemplate value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MessageTemplate() when $default != null:
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
    TResult Function(String id, String name, String subject, String body,
            List<String> variables)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MessageTemplate() when $default != null:
        return $default(
            _that.id, _that.name, _that.subject, _that.body, _that.variables);
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
    TResult Function(String id, String name, String subject, String body,
            List<String> variables)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MessageTemplate():
        return $default(
            _that.id, _that.name, _that.subject, _that.body, _that.variables);
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
    TResult? Function(String id, String name, String subject, String body,
            List<String> variables)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MessageTemplate() when $default != null:
        return $default(
            _that.id, _that.name, _that.subject, _that.body, _that.variables);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _MessageTemplate implements MessageTemplate {
  const _MessageTemplate(
      {required this.id,
      required this.name,
      required this.subject,
      required this.body,
      required final List<String> variables})
      : _variables = variables;
  factory _MessageTemplate.fromJson(Map<String, dynamic> json) =>
      _$MessageTemplateFromJson(json);

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

  /// Create a copy of MessageTemplate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MessageTemplateCopyWith<_MessageTemplate> get copyWith =>
      __$MessageTemplateCopyWithImpl<_MessageTemplate>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$MessageTemplateToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MessageTemplate &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.subject, subject) || other.subject == subject) &&
            (identical(other.body, body) || other.body == body) &&
            const DeepCollectionEquality()
                .equals(other._variables, _variables));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, subject, body,
      const DeepCollectionEquality().hash(_variables));

  @override
  String toString() {
    return 'MessageTemplate(id: $id, name: $name, subject: $subject, body: $body, variables: $variables)';
  }
}

/// @nodoc
abstract mixin class _$MessageTemplateCopyWith<$Res>
    implements $MessageTemplateCopyWith<$Res> {
  factory _$MessageTemplateCopyWith(
          _MessageTemplate value, $Res Function(_MessageTemplate) _then) =
      __$MessageTemplateCopyWithImpl;
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
class __$MessageTemplateCopyWithImpl<$Res>
    implements _$MessageTemplateCopyWith<$Res> {
  __$MessageTemplateCopyWithImpl(this._self, this._then);

  final _MessageTemplate _self;
  final $Res Function(_MessageTemplate) _then;

  /// Create a copy of MessageTemplate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? subject = null,
    Object? body = null,
    Object? variables = null,
  }) {
    return _then(_MessageTemplate(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      subject: null == subject
          ? _self.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _self.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      variables: null == variables
          ? _self._variables
          : variables // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
mixin _$BulkMessage {
  List<String> get recipientIds;
  String get subject;
  String get message;
  List<MessageChannel> get channels;
  DateTime? get scheduledFor;

  /// Create a copy of BulkMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BulkMessageCopyWith<BulkMessage> get copyWith =>
      _$BulkMessageCopyWithImpl<BulkMessage>(this as BulkMessage, _$identity);

  /// Serializes this BulkMessage to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BulkMessage &&
            const DeepCollectionEquality()
                .equals(other.recipientIds, recipientIds) &&
            (identical(other.subject, subject) || other.subject == subject) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other.channels, channels) &&
            (identical(other.scheduledFor, scheduledFor) ||
                other.scheduledFor == scheduledFor));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(recipientIds),
      subject,
      message,
      const DeepCollectionEquality().hash(channels),
      scheduledFor);

  @override
  String toString() {
    return 'BulkMessage(recipientIds: $recipientIds, subject: $subject, message: $message, channels: $channels, scheduledFor: $scheduledFor)';
  }
}

/// @nodoc
abstract mixin class $BulkMessageCopyWith<$Res> {
  factory $BulkMessageCopyWith(
          BulkMessage value, $Res Function(BulkMessage) _then) =
      _$BulkMessageCopyWithImpl;
  @useResult
  $Res call(
      {List<String> recipientIds,
      String subject,
      String message,
      List<MessageChannel> channels,
      DateTime? scheduledFor});
}

/// @nodoc
class _$BulkMessageCopyWithImpl<$Res> implements $BulkMessageCopyWith<$Res> {
  _$BulkMessageCopyWithImpl(this._self, this._then);

  final BulkMessage _self;
  final $Res Function(BulkMessage) _then;

  /// Create a copy of BulkMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? recipientIds = null,
    Object? subject = null,
    Object? message = null,
    Object? channels = null,
    Object? scheduledFor = freezed,
  }) {
    return _then(_self.copyWith(
      recipientIds: null == recipientIds
          ? _self.recipientIds
          : recipientIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      subject: null == subject
          ? _self.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      channels: null == channels
          ? _self.channels
          : channels // ignore: cast_nullable_to_non_nullable
              as List<MessageChannel>,
      scheduledFor: freezed == scheduledFor
          ? _self.scheduledFor
          : scheduledFor // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// Adds pattern-matching-related methods to [BulkMessage].
extension BulkMessagePatterns on BulkMessage {
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
    TResult Function(_BulkMessage value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BulkMessage() when $default != null:
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
    TResult Function(_BulkMessage value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BulkMessage():
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
    TResult? Function(_BulkMessage value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BulkMessage() when $default != null:
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
    TResult Function(List<String> recipientIds, String subject, String message,
            List<MessageChannel> channels, DateTime? scheduledFor)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BulkMessage() when $default != null:
        return $default(_that.recipientIds, _that.subject, _that.message,
            _that.channels, _that.scheduledFor);
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
    TResult Function(List<String> recipientIds, String subject, String message,
            List<MessageChannel> channels, DateTime? scheduledFor)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BulkMessage():
        return $default(_that.recipientIds, _that.subject, _that.message,
            _that.channels, _that.scheduledFor);
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
    TResult? Function(List<String> recipientIds, String subject, String message,
            List<MessageChannel> channels, DateTime? scheduledFor)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BulkMessage() when $default != null:
        return $default(_that.recipientIds, _that.subject, _that.message,
            _that.channels, _that.scheduledFor);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _BulkMessage implements BulkMessage {
  const _BulkMessage(
      {required final List<String> recipientIds,
      required this.subject,
      required this.message,
      required final List<MessageChannel> channels,
      this.scheduledFor})
      : _recipientIds = recipientIds,
        _channels = channels;
  factory _BulkMessage.fromJson(Map<String, dynamic> json) =>
      _$BulkMessageFromJson(json);

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

  /// Create a copy of BulkMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BulkMessageCopyWith<_BulkMessage> get copyWith =>
      __$BulkMessageCopyWithImpl<_BulkMessage>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$BulkMessageToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BulkMessage &&
            const DeepCollectionEquality()
                .equals(other._recipientIds, _recipientIds) &&
            (identical(other.subject, subject) || other.subject == subject) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other._channels, _channels) &&
            (identical(other.scheduledFor, scheduledFor) ||
                other.scheduledFor == scheduledFor));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_recipientIds),
      subject,
      message,
      const DeepCollectionEquality().hash(_channels),
      scheduledFor);

  @override
  String toString() {
    return 'BulkMessage(recipientIds: $recipientIds, subject: $subject, message: $message, channels: $channels, scheduledFor: $scheduledFor)';
  }
}

/// @nodoc
abstract mixin class _$BulkMessageCopyWith<$Res>
    implements $BulkMessageCopyWith<$Res> {
  factory _$BulkMessageCopyWith(
          _BulkMessage value, $Res Function(_BulkMessage) _then) =
      __$BulkMessageCopyWithImpl;
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
class __$BulkMessageCopyWithImpl<$Res> implements _$BulkMessageCopyWith<$Res> {
  __$BulkMessageCopyWithImpl(this._self, this._then);

  final _BulkMessage _self;
  final $Res Function(_BulkMessage) _then;

  /// Create a copy of BulkMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? recipientIds = null,
    Object? subject = null,
    Object? message = null,
    Object? channels = null,
    Object? scheduledFor = freezed,
  }) {
    return _then(_BulkMessage(
      recipientIds: null == recipientIds
          ? _self._recipientIds
          : recipientIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      subject: null == subject
          ? _self.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      channels: null == channels
          ? _self._channels
          : channels // ignore: cast_nullable_to_non_nullable
              as List<MessageChannel>,
      scheduledFor: freezed == scheduledFor
          ? _self.scheduledFor
          : scheduledFor // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
mixin _$BulkMessageResult {
  int get sentCount;
  int get scheduledCount;
  int get totalRequested;
  DateTime? get scheduledFor;

  /// Create a copy of BulkMessageResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BulkMessageResultCopyWith<BulkMessageResult> get copyWith =>
      _$BulkMessageResultCopyWithImpl<BulkMessageResult>(
          this as BulkMessageResult, _$identity);

  /// Serializes this BulkMessageResult to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BulkMessageResult &&
            (identical(other.sentCount, sentCount) ||
                other.sentCount == sentCount) &&
            (identical(other.scheduledCount, scheduledCount) ||
                other.scheduledCount == scheduledCount) &&
            (identical(other.totalRequested, totalRequested) ||
                other.totalRequested == totalRequested) &&
            (identical(other.scheduledFor, scheduledFor) ||
                other.scheduledFor == scheduledFor));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, sentCount, scheduledCount, totalRequested, scheduledFor);

  @override
  String toString() {
    return 'BulkMessageResult(sentCount: $sentCount, scheduledCount: $scheduledCount, totalRequested: $totalRequested, scheduledFor: $scheduledFor)';
  }
}

/// @nodoc
abstract mixin class $BulkMessageResultCopyWith<$Res> {
  factory $BulkMessageResultCopyWith(
          BulkMessageResult value, $Res Function(BulkMessageResult) _then) =
      _$BulkMessageResultCopyWithImpl;
  @useResult
  $Res call(
      {int sentCount,
      int scheduledCount,
      int totalRequested,
      DateTime? scheduledFor});
}

/// @nodoc
class _$BulkMessageResultCopyWithImpl<$Res>
    implements $BulkMessageResultCopyWith<$Res> {
  _$BulkMessageResultCopyWithImpl(this._self, this._then);

  final BulkMessageResult _self;
  final $Res Function(BulkMessageResult) _then;

  /// Create a copy of BulkMessageResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sentCount = null,
    Object? scheduledCount = null,
    Object? totalRequested = null,
    Object? scheduledFor = freezed,
  }) {
    return _then(_self.copyWith(
      sentCount: null == sentCount
          ? _self.sentCount
          : sentCount // ignore: cast_nullable_to_non_nullable
              as int,
      scheduledCount: null == scheduledCount
          ? _self.scheduledCount
          : scheduledCount // ignore: cast_nullable_to_non_nullable
              as int,
      totalRequested: null == totalRequested
          ? _self.totalRequested
          : totalRequested // ignore: cast_nullable_to_non_nullable
              as int,
      scheduledFor: freezed == scheduledFor
          ? _self.scheduledFor
          : scheduledFor // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// Adds pattern-matching-related methods to [BulkMessageResult].
extension BulkMessageResultPatterns on BulkMessageResult {
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
    TResult Function(_BulkMessageResult value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BulkMessageResult() when $default != null:
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
    TResult Function(_BulkMessageResult value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BulkMessageResult():
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
    TResult? Function(_BulkMessageResult value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BulkMessageResult() when $default != null:
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
    TResult Function(int sentCount, int scheduledCount, int totalRequested,
            DateTime? scheduledFor)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BulkMessageResult() when $default != null:
        return $default(_that.sentCount, _that.scheduledCount,
            _that.totalRequested, _that.scheduledFor);
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
    TResult Function(int sentCount, int scheduledCount, int totalRequested,
            DateTime? scheduledFor)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BulkMessageResult():
        return $default(_that.sentCount, _that.scheduledCount,
            _that.totalRequested, _that.scheduledFor);
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
    TResult? Function(int sentCount, int scheduledCount, int totalRequested,
            DateTime? scheduledFor)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BulkMessageResult() when $default != null:
        return $default(_that.sentCount, _that.scheduledCount,
            _that.totalRequested, _that.scheduledFor);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _BulkMessageResult implements BulkMessageResult {
  const _BulkMessageResult(
      {required this.sentCount,
      required this.scheduledCount,
      required this.totalRequested,
      this.scheduledFor});
  factory _BulkMessageResult.fromJson(Map<String, dynamic> json) =>
      _$BulkMessageResultFromJson(json);

  @override
  final int sentCount;
  @override
  final int scheduledCount;
  @override
  final int totalRequested;
  @override
  final DateTime? scheduledFor;

  /// Create a copy of BulkMessageResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BulkMessageResultCopyWith<_BulkMessageResult> get copyWith =>
      __$BulkMessageResultCopyWithImpl<_BulkMessageResult>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$BulkMessageResultToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BulkMessageResult &&
            (identical(other.sentCount, sentCount) ||
                other.sentCount == sentCount) &&
            (identical(other.scheduledCount, scheduledCount) ||
                other.scheduledCount == scheduledCount) &&
            (identical(other.totalRequested, totalRequested) ||
                other.totalRequested == totalRequested) &&
            (identical(other.scheduledFor, scheduledFor) ||
                other.scheduledFor == scheduledFor));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, sentCount, scheduledCount, totalRequested, scheduledFor);

  @override
  String toString() {
    return 'BulkMessageResult(sentCount: $sentCount, scheduledCount: $scheduledCount, totalRequested: $totalRequested, scheduledFor: $scheduledFor)';
  }
}

/// @nodoc
abstract mixin class _$BulkMessageResultCopyWith<$Res>
    implements $BulkMessageResultCopyWith<$Res> {
  factory _$BulkMessageResultCopyWith(
          _BulkMessageResult value, $Res Function(_BulkMessageResult) _then) =
      __$BulkMessageResultCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int sentCount,
      int scheduledCount,
      int totalRequested,
      DateTime? scheduledFor});
}

/// @nodoc
class __$BulkMessageResultCopyWithImpl<$Res>
    implements _$BulkMessageResultCopyWith<$Res> {
  __$BulkMessageResultCopyWithImpl(this._self, this._then);

  final _BulkMessageResult _self;
  final $Res Function(_BulkMessageResult) _then;

  /// Create a copy of BulkMessageResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? sentCount = null,
    Object? scheduledCount = null,
    Object? totalRequested = null,
    Object? scheduledFor = freezed,
  }) {
    return _then(_BulkMessageResult(
      sentCount: null == sentCount
          ? _self.sentCount
          : sentCount // ignore: cast_nullable_to_non_nullable
              as int,
      scheduledCount: null == scheduledCount
          ? _self.scheduledCount
          : scheduledCount // ignore: cast_nullable_to_non_nullable
              as int,
      totalRequested: null == totalRequested
          ? _self.totalRequested
          : totalRequested // ignore: cast_nullable_to_non_nullable
              as int,
      scheduledFor: freezed == scheduledFor
          ? _self.scheduledFor
          : scheduledFor // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

// dart format on
