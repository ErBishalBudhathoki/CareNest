// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'training_viewmodel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TrainingState {
  bool get isLoading => throw _privateConstructorUsedError;
  List<TrainingModule> get modules => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TrainingStateCopyWith<TrainingState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrainingStateCopyWith<$Res> {
  factory $TrainingStateCopyWith(
          TrainingState value, $Res Function(TrainingState) then) =
      _$TrainingStateCopyWithImpl<$Res, TrainingState>;
  @useResult
  $Res call(
      {bool isLoading, List<TrainingModule> modules, String? errorMessage});
}

/// @nodoc
class _$TrainingStateCopyWithImpl<$Res, $Val extends TrainingState>
    implements $TrainingStateCopyWith<$Res> {
  _$TrainingStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? modules = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      modules: null == modules
          ? _value.modules
          : modules // ignore: cast_nullable_to_non_nullable
              as List<TrainingModule>,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TrainingStateImplCopyWith<$Res>
    implements $TrainingStateCopyWith<$Res> {
  factory _$$TrainingStateImplCopyWith(
          _$TrainingStateImpl value, $Res Function(_$TrainingStateImpl) then) =
      __$$TrainingStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading, List<TrainingModule> modules, String? errorMessage});
}

/// @nodoc
class __$$TrainingStateImplCopyWithImpl<$Res>
    extends _$TrainingStateCopyWithImpl<$Res, _$TrainingStateImpl>
    implements _$$TrainingStateImplCopyWith<$Res> {
  __$$TrainingStateImplCopyWithImpl(
      _$TrainingStateImpl _value, $Res Function(_$TrainingStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? modules = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_$TrainingStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      modules: null == modules
          ? _value._modules
          : modules // ignore: cast_nullable_to_non_nullable
              as List<TrainingModule>,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$TrainingStateImpl implements _TrainingState {
  const _$TrainingStateImpl(
      {this.isLoading = false,
      final List<TrainingModule> modules = const [],
      this.errorMessage})
      : _modules = modules;

  @override
  @JsonKey()
  final bool isLoading;
  final List<TrainingModule> _modules;
  @override
  @JsonKey()
  List<TrainingModule> get modules {
    if (_modules is EqualUnmodifiableListView) return _modules;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_modules);
  }

  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'TrainingState(isLoading: $isLoading, modules: $modules, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TrainingStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality().equals(other._modules, _modules) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading,
      const DeepCollectionEquality().hash(_modules), errorMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TrainingStateImplCopyWith<_$TrainingStateImpl> get copyWith =>
      __$$TrainingStateImplCopyWithImpl<_$TrainingStateImpl>(this, _$identity);
}

abstract class _TrainingState implements TrainingState {
  const factory _TrainingState(
      {final bool isLoading,
      final List<TrainingModule> modules,
      final String? errorMessage}) = _$TrainingStateImpl;

  @override
  bool get isLoading;
  @override
  List<TrainingModule> get modules;
  @override
  String? get errorMessage;
  @override
  @JsonKey(ignore: true)
  _$$TrainingStateImplCopyWith<_$TrainingStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
