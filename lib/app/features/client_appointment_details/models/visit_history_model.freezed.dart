// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'visit_history_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VisitHistoryModel {
  String get id;
  String get shiftDate;
  String get shiftStartTime;
  String get shiftEndTime;
  List<String>? get timeWorked; // Assuming timeList is List<String>
  String? get notes; // If we store per-visit notes
  DateTime? get createdAt;

  /// Create a copy of VisitHistoryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $VisitHistoryModelCopyWith<VisitHistoryModel> get copyWith =>
      _$VisitHistoryModelCopyWithImpl<VisitHistoryModel>(
          this as VisitHistoryModel, _$identity);

  /// Serializes this VisitHistoryModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is VisitHistoryModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.shiftDate, shiftDate) ||
                other.shiftDate == shiftDate) &&
            (identical(other.shiftStartTime, shiftStartTime) ||
                other.shiftStartTime == shiftStartTime) &&
            (identical(other.shiftEndTime, shiftEndTime) ||
                other.shiftEndTime == shiftEndTime) &&
            const DeepCollectionEquality()
                .equals(other.timeWorked, timeWorked) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      shiftDate,
      shiftStartTime,
      shiftEndTime,
      const DeepCollectionEquality().hash(timeWorked),
      notes,
      createdAt);

  @override
  String toString() {
    return 'VisitHistoryModel(id: $id, shiftDate: $shiftDate, shiftStartTime: $shiftStartTime, shiftEndTime: $shiftEndTime, timeWorked: $timeWorked, notes: $notes, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class $VisitHistoryModelCopyWith<$Res> {
  factory $VisitHistoryModelCopyWith(
          VisitHistoryModel value, $Res Function(VisitHistoryModel) _then) =
      _$VisitHistoryModelCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String shiftDate,
      String shiftStartTime,
      String shiftEndTime,
      List<String>? timeWorked,
      String? notes,
      DateTime? createdAt});
}

/// @nodoc
class _$VisitHistoryModelCopyWithImpl<$Res>
    implements $VisitHistoryModelCopyWith<$Res> {
  _$VisitHistoryModelCopyWithImpl(this._self, this._then);

  final VisitHistoryModel _self;
  final $Res Function(VisitHistoryModel) _then;

  /// Create a copy of VisitHistoryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? shiftDate = null,
    Object? shiftStartTime = null,
    Object? shiftEndTime = null,
    Object? timeWorked = freezed,
    Object? notes = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      shiftDate: null == shiftDate
          ? _self.shiftDate
          : shiftDate // ignore: cast_nullable_to_non_nullable
              as String,
      shiftStartTime: null == shiftStartTime
          ? _self.shiftStartTime
          : shiftStartTime // ignore: cast_nullable_to_non_nullable
              as String,
      shiftEndTime: null == shiftEndTime
          ? _self.shiftEndTime
          : shiftEndTime // ignore: cast_nullable_to_non_nullable
              as String,
      timeWorked: freezed == timeWorked
          ? _self.timeWorked
          : timeWorked // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      notes: freezed == notes
          ? _self.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// Adds pattern-matching-related methods to [VisitHistoryModel].
extension VisitHistoryModelPatterns on VisitHistoryModel {
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
    TResult Function(_VisitHistoryModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _VisitHistoryModel() when $default != null:
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
    TResult Function(_VisitHistoryModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VisitHistoryModel():
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
    TResult? Function(_VisitHistoryModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VisitHistoryModel() when $default != null:
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
            String shiftDate,
            String shiftStartTime,
            String shiftEndTime,
            List<String>? timeWorked,
            String? notes,
            DateTime? createdAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _VisitHistoryModel() when $default != null:
        return $default(_that.id, _that.shiftDate, _that.shiftStartTime,
            _that.shiftEndTime, _that.timeWorked, _that.notes, _that.createdAt);
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
            String shiftDate,
            String shiftStartTime,
            String shiftEndTime,
            List<String>? timeWorked,
            String? notes,
            DateTime? createdAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VisitHistoryModel():
        return $default(_that.id, _that.shiftDate, _that.shiftStartTime,
            _that.shiftEndTime, _that.timeWorked, _that.notes, _that.createdAt);
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
            String shiftDate,
            String shiftStartTime,
            String shiftEndTime,
            List<String>? timeWorked,
            String? notes,
            DateTime? createdAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VisitHistoryModel() when $default != null:
        return $default(_that.id, _that.shiftDate, _that.shiftStartTime,
            _that.shiftEndTime, _that.timeWorked, _that.notes, _that.createdAt);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _VisitHistoryModel implements VisitHistoryModel {
  const _VisitHistoryModel(
      {required this.id,
      required this.shiftDate,
      required this.shiftStartTime,
      required this.shiftEndTime,
      final List<String>? timeWorked,
      this.notes,
      this.createdAt})
      : _timeWorked = timeWorked;
  factory _VisitHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$VisitHistoryModelFromJson(json);

  @override
  final String id;
  @override
  final String shiftDate;
  @override
  final String shiftStartTime;
  @override
  final String shiftEndTime;
  final List<String>? _timeWorked;
  @override
  List<String>? get timeWorked {
    final value = _timeWorked;
    if (value == null) return null;
    if (_timeWorked is EqualUnmodifiableListView) return _timeWorked;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

// Assuming timeList is List<String>
  @override
  final String? notes;
// If we store per-visit notes
  @override
  final DateTime? createdAt;

  /// Create a copy of VisitHistoryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$VisitHistoryModelCopyWith<_VisitHistoryModel> get copyWith =>
      __$VisitHistoryModelCopyWithImpl<_VisitHistoryModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$VisitHistoryModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _VisitHistoryModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.shiftDate, shiftDate) ||
                other.shiftDate == shiftDate) &&
            (identical(other.shiftStartTime, shiftStartTime) ||
                other.shiftStartTime == shiftStartTime) &&
            (identical(other.shiftEndTime, shiftEndTime) ||
                other.shiftEndTime == shiftEndTime) &&
            const DeepCollectionEquality()
                .equals(other._timeWorked, _timeWorked) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      shiftDate,
      shiftStartTime,
      shiftEndTime,
      const DeepCollectionEquality().hash(_timeWorked),
      notes,
      createdAt);

  @override
  String toString() {
    return 'VisitHistoryModel(id: $id, shiftDate: $shiftDate, shiftStartTime: $shiftStartTime, shiftEndTime: $shiftEndTime, timeWorked: $timeWorked, notes: $notes, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class _$VisitHistoryModelCopyWith<$Res>
    implements $VisitHistoryModelCopyWith<$Res> {
  factory _$VisitHistoryModelCopyWith(
          _VisitHistoryModel value, $Res Function(_VisitHistoryModel) _then) =
      __$VisitHistoryModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String shiftDate,
      String shiftStartTime,
      String shiftEndTime,
      List<String>? timeWorked,
      String? notes,
      DateTime? createdAt});
}

/// @nodoc
class __$VisitHistoryModelCopyWithImpl<$Res>
    implements _$VisitHistoryModelCopyWith<$Res> {
  __$VisitHistoryModelCopyWithImpl(this._self, this._then);

  final _VisitHistoryModel _self;
  final $Res Function(_VisitHistoryModel) _then;

  /// Create a copy of VisitHistoryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? shiftDate = null,
    Object? shiftStartTime = null,
    Object? shiftEndTime = null,
    Object? timeWorked = freezed,
    Object? notes = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_VisitHistoryModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      shiftDate: null == shiftDate
          ? _self.shiftDate
          : shiftDate // ignore: cast_nullable_to_non_nullable
              as String,
      shiftStartTime: null == shiftStartTime
          ? _self.shiftStartTime
          : shiftStartTime // ignore: cast_nullable_to_non_nullable
              as String,
      shiftEndTime: null == shiftEndTime
          ? _self.shiftEndTime
          : shiftEndTime // ignore: cast_nullable_to_non_nullable
              as String,
      timeWorked: freezed == timeWorked
          ? _self._timeWorked
          : timeWorked // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      notes: freezed == notes
          ? _self.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

// dart format on
