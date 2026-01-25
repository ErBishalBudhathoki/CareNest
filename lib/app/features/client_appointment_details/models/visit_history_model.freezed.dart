// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'visit_history_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

VisitHistoryModel _$VisitHistoryModelFromJson(Map<String, dynamic> json) {
  return _VisitHistoryModel.fromJson(json);
}

/// @nodoc
mixin _$VisitHistoryModel {
  String get id => throw _privateConstructorUsedError;
  String get shiftDate => throw _privateConstructorUsedError;
  String get shiftStartTime => throw _privateConstructorUsedError;
  String get shiftEndTime => throw _privateConstructorUsedError;
  List<String>? get timeWorked =>
      throw _privateConstructorUsedError; // Assuming timeList is List<String>
  String? get notes =>
      throw _privateConstructorUsedError; // If we store per-visit notes
  DateTime? get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VisitHistoryModelCopyWith<VisitHistoryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VisitHistoryModelCopyWith<$Res> {
  factory $VisitHistoryModelCopyWith(
          VisitHistoryModel value, $Res Function(VisitHistoryModel) then) =
      _$VisitHistoryModelCopyWithImpl<$Res, VisitHistoryModel>;
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
class _$VisitHistoryModelCopyWithImpl<$Res, $Val extends VisitHistoryModel>
    implements $VisitHistoryModelCopyWith<$Res> {
  _$VisitHistoryModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      shiftDate: null == shiftDate
          ? _value.shiftDate
          : shiftDate // ignore: cast_nullable_to_non_nullable
              as String,
      shiftStartTime: null == shiftStartTime
          ? _value.shiftStartTime
          : shiftStartTime // ignore: cast_nullable_to_non_nullable
              as String,
      shiftEndTime: null == shiftEndTime
          ? _value.shiftEndTime
          : shiftEndTime // ignore: cast_nullable_to_non_nullable
              as String,
      timeWorked: freezed == timeWorked
          ? _value.timeWorked
          : timeWorked // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VisitHistoryModelImplCopyWith<$Res>
    implements $VisitHistoryModelCopyWith<$Res> {
  factory _$$VisitHistoryModelImplCopyWith(_$VisitHistoryModelImpl value,
          $Res Function(_$VisitHistoryModelImpl) then) =
      __$$VisitHistoryModelImplCopyWithImpl<$Res>;
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
class __$$VisitHistoryModelImplCopyWithImpl<$Res>
    extends _$VisitHistoryModelCopyWithImpl<$Res, _$VisitHistoryModelImpl>
    implements _$$VisitHistoryModelImplCopyWith<$Res> {
  __$$VisitHistoryModelImplCopyWithImpl(_$VisitHistoryModelImpl _value,
      $Res Function(_$VisitHistoryModelImpl) _then)
      : super(_value, _then);

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
    return _then(_$VisitHistoryModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      shiftDate: null == shiftDate
          ? _value.shiftDate
          : shiftDate // ignore: cast_nullable_to_non_nullable
              as String,
      shiftStartTime: null == shiftStartTime
          ? _value.shiftStartTime
          : shiftStartTime // ignore: cast_nullable_to_non_nullable
              as String,
      shiftEndTime: null == shiftEndTime
          ? _value.shiftEndTime
          : shiftEndTime // ignore: cast_nullable_to_non_nullable
              as String,
      timeWorked: freezed == timeWorked
          ? _value._timeWorked
          : timeWorked // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VisitHistoryModelImpl implements _VisitHistoryModel {
  const _$VisitHistoryModelImpl(
      {required this.id,
      required this.shiftDate,
      required this.shiftStartTime,
      required this.shiftEndTime,
      final List<String>? timeWorked,
      this.notes,
      this.createdAt})
      : _timeWorked = timeWorked;

  factory _$VisitHistoryModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$VisitHistoryModelImplFromJson(json);

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

  @override
  String toString() {
    return 'VisitHistoryModel(id: $id, shiftDate: $shiftDate, shiftStartTime: $shiftStartTime, shiftEndTime: $shiftEndTime, timeWorked: $timeWorked, notes: $notes, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VisitHistoryModelImpl &&
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

  @JsonKey(ignore: true)
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

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VisitHistoryModelImplCopyWith<_$VisitHistoryModelImpl> get copyWith =>
      __$$VisitHistoryModelImplCopyWithImpl<_$VisitHistoryModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VisitHistoryModelImplToJson(
      this,
    );
  }
}

abstract class _VisitHistoryModel implements VisitHistoryModel {
  const factory _VisitHistoryModel(
      {required final String id,
      required final String shiftDate,
      required final String shiftStartTime,
      required final String shiftEndTime,
      final List<String>? timeWorked,
      final String? notes,
      final DateTime? createdAt}) = _$VisitHistoryModelImpl;

  factory _VisitHistoryModel.fromJson(Map<String, dynamic> json) =
      _$VisitHistoryModelImpl.fromJson;

  @override
  String get id;
  @override
  String get shiftDate;
  @override
  String get shiftStartTime;
  @override
  String get shiftEndTime;
  @override
  List<String>? get timeWorked;
  @override // Assuming timeList is List<String>
  String? get notes;
  @override // If we store per-visit notes
  DateTime? get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$VisitHistoryModelImplCopyWith<_$VisitHistoryModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
