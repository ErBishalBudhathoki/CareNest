// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'compliance_viewmodel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ComplianceState {
  bool get isLoading => throw _privateConstructorUsedError;
  List<ComplianceChecklist> get checklists =>
      throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ComplianceStateCopyWith<ComplianceState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ComplianceStateCopyWith<$Res> {
  factory $ComplianceStateCopyWith(
          ComplianceState value, $Res Function(ComplianceState) then) =
      _$ComplianceStateCopyWithImpl<$Res, ComplianceState>;
  @useResult
  $Res call(
      {bool isLoading,
      List<ComplianceChecklist> checklists,
      String? errorMessage});
}

/// @nodoc
class _$ComplianceStateCopyWithImpl<$Res, $Val extends ComplianceState>
    implements $ComplianceStateCopyWith<$Res> {
  _$ComplianceStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? checklists = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      checklists: null == checklists
          ? _value.checklists
          : checklists // ignore: cast_nullable_to_non_nullable
              as List<ComplianceChecklist>,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ComplianceStateImplCopyWith<$Res>
    implements $ComplianceStateCopyWith<$Res> {
  factory _$$ComplianceStateImplCopyWith(_$ComplianceStateImpl value,
          $Res Function(_$ComplianceStateImpl) then) =
      __$$ComplianceStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      List<ComplianceChecklist> checklists,
      String? errorMessage});
}

/// @nodoc
class __$$ComplianceStateImplCopyWithImpl<$Res>
    extends _$ComplianceStateCopyWithImpl<$Res, _$ComplianceStateImpl>
    implements _$$ComplianceStateImplCopyWith<$Res> {
  __$$ComplianceStateImplCopyWithImpl(
      _$ComplianceStateImpl _value, $Res Function(_$ComplianceStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? checklists = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_$ComplianceStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      checklists: null == checklists
          ? _value._checklists
          : checklists // ignore: cast_nullable_to_non_nullable
              as List<ComplianceChecklist>,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$ComplianceStateImpl implements _ComplianceState {
  const _$ComplianceStateImpl(
      {this.isLoading = false,
      final List<ComplianceChecklist> checklists = const [],
      this.errorMessage})
      : _checklists = checklists;

  @override
  @JsonKey()
  final bool isLoading;
  final List<ComplianceChecklist> _checklists;
  @override
  @JsonKey()
  List<ComplianceChecklist> get checklists {
    if (_checklists is EqualUnmodifiableListView) return _checklists;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_checklists);
  }

  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'ComplianceState(isLoading: $isLoading, checklists: $checklists, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ComplianceStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality()
                .equals(other._checklists, _checklists) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading,
      const DeepCollectionEquality().hash(_checklists), errorMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ComplianceStateImplCopyWith<_$ComplianceStateImpl> get copyWith =>
      __$$ComplianceStateImplCopyWithImpl<_$ComplianceStateImpl>(
          this, _$identity);
}

abstract class _ComplianceState implements ComplianceState {
  const factory _ComplianceState(
      {final bool isLoading,
      final List<ComplianceChecklist> checklists,
      final String? errorMessage}) = _$ComplianceStateImpl;

  @override
  bool get isLoading;
  @override
  List<ComplianceChecklist> get checklists;
  @override
  String? get errorMessage;
  @override
  @JsonKey(ignore: true)
  _$$ComplianceStateImplCopyWith<_$ComplianceStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
