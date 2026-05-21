// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'training_viewmodel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TrainingState {
  bool get isLoading;
  List<TrainingModule> get modules;
  String? get errorMessage;

  /// Create a copy of TrainingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TrainingStateCopyWith<TrainingState> get copyWith =>
      _$TrainingStateCopyWithImpl<TrainingState>(
          this as TrainingState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TrainingState &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality().equals(other.modules, modules) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading,
      const DeepCollectionEquality().hash(modules), errorMessage);

  @override
  String toString() {
    return 'TrainingState(isLoading: $isLoading, modules: $modules, errorMessage: $errorMessage)';
  }
}

/// @nodoc
abstract mixin class $TrainingStateCopyWith<$Res> {
  factory $TrainingStateCopyWith(
          TrainingState value, $Res Function(TrainingState) _then) =
      _$TrainingStateCopyWithImpl;
  @useResult
  $Res call(
      {bool isLoading, List<TrainingModule> modules, String? errorMessage});
}

/// @nodoc
class _$TrainingStateCopyWithImpl<$Res>
    implements $TrainingStateCopyWith<$Res> {
  _$TrainingStateCopyWithImpl(this._self, this._then);

  final TrainingState _self;
  final $Res Function(TrainingState) _then;

  /// Create a copy of TrainingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? modules = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_self.copyWith(
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      modules: null == modules
          ? _self.modules
          : modules // ignore: cast_nullable_to_non_nullable
              as List<TrainingModule>,
      errorMessage: freezed == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [TrainingState].
extension TrainingStatePatterns on TrainingState {
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
    TResult Function(_TrainingState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TrainingState() when $default != null:
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
    TResult Function(_TrainingState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TrainingState():
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
    TResult? Function(_TrainingState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TrainingState() when $default != null:
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
            bool isLoading, List<TrainingModule> modules, String? errorMessage)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TrainingState() when $default != null:
        return $default(_that.isLoading, _that.modules, _that.errorMessage);
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
            bool isLoading, List<TrainingModule> modules, String? errorMessage)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TrainingState():
        return $default(_that.isLoading, _that.modules, _that.errorMessage);
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
            bool isLoading, List<TrainingModule> modules, String? errorMessage)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TrainingState() when $default != null:
        return $default(_that.isLoading, _that.modules, _that.errorMessage);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _TrainingState implements TrainingState {
  const _TrainingState(
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

  /// Create a copy of TrainingState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TrainingStateCopyWith<_TrainingState> get copyWith =>
      __$TrainingStateCopyWithImpl<_TrainingState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TrainingState &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality().equals(other._modules, _modules) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading,
      const DeepCollectionEquality().hash(_modules), errorMessage);

  @override
  String toString() {
    return 'TrainingState(isLoading: $isLoading, modules: $modules, errorMessage: $errorMessage)';
  }
}

/// @nodoc
abstract mixin class _$TrainingStateCopyWith<$Res>
    implements $TrainingStateCopyWith<$Res> {
  factory _$TrainingStateCopyWith(
          _TrainingState value, $Res Function(_TrainingState) _then) =
      __$TrainingStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {bool isLoading, List<TrainingModule> modules, String? errorMessage});
}

/// @nodoc
class __$TrainingStateCopyWithImpl<$Res>
    implements _$TrainingStateCopyWith<$Res> {
  __$TrainingStateCopyWithImpl(this._self, this._then);

  final _TrainingState _self;
  final $Res Function(_TrainingState) _then;

  /// Create a copy of TrainingState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? isLoading = null,
    Object? modules = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_TrainingState(
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      modules: null == modules
          ? _self._modules
          : modules // ignore: cast_nullable_to_non_nullable
              as List<TrainingModule>,
      errorMessage: freezed == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
