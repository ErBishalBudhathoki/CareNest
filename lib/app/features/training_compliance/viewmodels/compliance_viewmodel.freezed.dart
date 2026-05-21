// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'compliance_viewmodel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ComplianceState {
  bool get isLoading;
  List<ComplianceChecklist> get checklists;
  String? get errorMessage;

  /// Create a copy of ComplianceState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ComplianceStateCopyWith<ComplianceState> get copyWith =>
      _$ComplianceStateCopyWithImpl<ComplianceState>(
          this as ComplianceState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ComplianceState &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality()
                .equals(other.checklists, checklists) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading,
      const DeepCollectionEquality().hash(checklists), errorMessage);

  @override
  String toString() {
    return 'ComplianceState(isLoading: $isLoading, checklists: $checklists, errorMessage: $errorMessage)';
  }
}

/// @nodoc
abstract mixin class $ComplianceStateCopyWith<$Res> {
  factory $ComplianceStateCopyWith(
          ComplianceState value, $Res Function(ComplianceState) _then) =
      _$ComplianceStateCopyWithImpl;
  @useResult
  $Res call(
      {bool isLoading,
      List<ComplianceChecklist> checklists,
      String? errorMessage});
}

/// @nodoc
class _$ComplianceStateCopyWithImpl<$Res>
    implements $ComplianceStateCopyWith<$Res> {
  _$ComplianceStateCopyWithImpl(this._self, this._then);

  final ComplianceState _self;
  final $Res Function(ComplianceState) _then;

  /// Create a copy of ComplianceState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? checklists = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_self.copyWith(
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      checklists: null == checklists
          ? _self.checklists
          : checklists // ignore: cast_nullable_to_non_nullable
              as List<ComplianceChecklist>,
      errorMessage: freezed == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [ComplianceState].
extension ComplianceStatePatterns on ComplianceState {
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
    TResult Function(_ComplianceState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ComplianceState() when $default != null:
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
    TResult Function(_ComplianceState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ComplianceState():
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
    TResult? Function(_ComplianceState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ComplianceState() when $default != null:
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
    TResult Function(bool isLoading, List<ComplianceChecklist> checklists,
            String? errorMessage)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ComplianceState() when $default != null:
        return $default(_that.isLoading, _that.checklists, _that.errorMessage);
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
    TResult Function(bool isLoading, List<ComplianceChecklist> checklists,
            String? errorMessage)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ComplianceState():
        return $default(_that.isLoading, _that.checklists, _that.errorMessage);
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
    TResult? Function(bool isLoading, List<ComplianceChecklist> checklists,
            String? errorMessage)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ComplianceState() when $default != null:
        return $default(_that.isLoading, _that.checklists, _that.errorMessage);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ComplianceState implements ComplianceState {
  const _ComplianceState(
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

  /// Create a copy of ComplianceState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ComplianceStateCopyWith<_ComplianceState> get copyWith =>
      __$ComplianceStateCopyWithImpl<_ComplianceState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ComplianceState &&
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

  @override
  String toString() {
    return 'ComplianceState(isLoading: $isLoading, checklists: $checklists, errorMessage: $errorMessage)';
  }
}

/// @nodoc
abstract mixin class _$ComplianceStateCopyWith<$Res>
    implements $ComplianceStateCopyWith<$Res> {
  factory _$ComplianceStateCopyWith(
          _ComplianceState value, $Res Function(_ComplianceState) _then) =
      __$ComplianceStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      List<ComplianceChecklist> checklists,
      String? errorMessage});
}

/// @nodoc
class __$ComplianceStateCopyWithImpl<$Res>
    implements _$ComplianceStateCopyWith<$Res> {
  __$ComplianceStateCopyWithImpl(this._self, this._then);

  final _ComplianceState _self;
  final $Res Function(_ComplianceState) _then;

  /// Create a copy of ComplianceState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? isLoading = null,
    Object? checklists = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_ComplianceState(
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      checklists: null == checklists
          ? _self._checklists
          : checklists // ignore: cast_nullable_to_non_nullable
              as List<ComplianceChecklist>,
      errorMessage: freezed == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
