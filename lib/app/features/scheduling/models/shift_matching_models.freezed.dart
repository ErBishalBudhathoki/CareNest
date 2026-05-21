// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shift_matching_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WorkerMatch {
  String get workerId;
  String get workerName;
  String get workerEmail;
  double get matchScore;
  String get matchLevel;
  List<MatchFactor> get factors;
  List<String> get conflicts;
  double? get distance;
  double? get travelTime;
  double? get noShowProbability;
  Map<String, dynamic>? get workerProfile;

  /// Create a copy of WorkerMatch
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WorkerMatchCopyWith<WorkerMatch> get copyWith =>
      _$WorkerMatchCopyWithImpl<WorkerMatch>(this as WorkerMatch, _$identity);

  /// Serializes this WorkerMatch to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WorkerMatch &&
            (identical(other.workerId, workerId) ||
                other.workerId == workerId) &&
            (identical(other.workerName, workerName) ||
                other.workerName == workerName) &&
            (identical(other.workerEmail, workerEmail) ||
                other.workerEmail == workerEmail) &&
            (identical(other.matchScore, matchScore) ||
                other.matchScore == matchScore) &&
            (identical(other.matchLevel, matchLevel) ||
                other.matchLevel == matchLevel) &&
            const DeepCollectionEquality().equals(other.factors, factors) &&
            const DeepCollectionEquality().equals(other.conflicts, conflicts) &&
            (identical(other.distance, distance) ||
                other.distance == distance) &&
            (identical(other.travelTime, travelTime) ||
                other.travelTime == travelTime) &&
            (identical(other.noShowProbability, noShowProbability) ||
                other.noShowProbability == noShowProbability) &&
            const DeepCollectionEquality()
                .equals(other.workerProfile, workerProfile));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      workerId,
      workerName,
      workerEmail,
      matchScore,
      matchLevel,
      const DeepCollectionEquality().hash(factors),
      const DeepCollectionEquality().hash(conflicts),
      distance,
      travelTime,
      noShowProbability,
      const DeepCollectionEquality().hash(workerProfile));

  @override
  String toString() {
    return 'WorkerMatch(workerId: $workerId, workerName: $workerName, workerEmail: $workerEmail, matchScore: $matchScore, matchLevel: $matchLevel, factors: $factors, conflicts: $conflicts, distance: $distance, travelTime: $travelTime, noShowProbability: $noShowProbability, workerProfile: $workerProfile)';
  }
}

/// @nodoc
abstract mixin class $WorkerMatchCopyWith<$Res> {
  factory $WorkerMatchCopyWith(
          WorkerMatch value, $Res Function(WorkerMatch) _then) =
      _$WorkerMatchCopyWithImpl;
  @useResult
  $Res call(
      {String workerId,
      String workerName,
      String workerEmail,
      double matchScore,
      String matchLevel,
      List<MatchFactor> factors,
      List<String> conflicts,
      double? distance,
      double? travelTime,
      double? noShowProbability,
      Map<String, dynamic>? workerProfile});
}

/// @nodoc
class _$WorkerMatchCopyWithImpl<$Res> implements $WorkerMatchCopyWith<$Res> {
  _$WorkerMatchCopyWithImpl(this._self, this._then);

  final WorkerMatch _self;
  final $Res Function(WorkerMatch) _then;

  /// Create a copy of WorkerMatch
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? workerId = null,
    Object? workerName = null,
    Object? workerEmail = null,
    Object? matchScore = null,
    Object? matchLevel = null,
    Object? factors = null,
    Object? conflicts = null,
    Object? distance = freezed,
    Object? travelTime = freezed,
    Object? noShowProbability = freezed,
    Object? workerProfile = freezed,
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
      matchScore: null == matchScore
          ? _self.matchScore
          : matchScore // ignore: cast_nullable_to_non_nullable
              as double,
      matchLevel: null == matchLevel
          ? _self.matchLevel
          : matchLevel // ignore: cast_nullable_to_non_nullable
              as String,
      factors: null == factors
          ? _self.factors
          : factors // ignore: cast_nullable_to_non_nullable
              as List<MatchFactor>,
      conflicts: null == conflicts
          ? _self.conflicts
          : conflicts // ignore: cast_nullable_to_non_nullable
              as List<String>,
      distance: freezed == distance
          ? _self.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double?,
      travelTime: freezed == travelTime
          ? _self.travelTime
          : travelTime // ignore: cast_nullable_to_non_nullable
              as double?,
      noShowProbability: freezed == noShowProbability
          ? _self.noShowProbability
          : noShowProbability // ignore: cast_nullable_to_non_nullable
              as double?,
      workerProfile: freezed == workerProfile
          ? _self.workerProfile
          : workerProfile // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// Adds pattern-matching-related methods to [WorkerMatch].
extension WorkerMatchPatterns on WorkerMatch {
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
    TResult Function(_WorkerMatch value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _WorkerMatch() when $default != null:
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
    TResult Function(_WorkerMatch value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WorkerMatch():
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
    TResult? Function(_WorkerMatch value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WorkerMatch() when $default != null:
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
            double matchScore,
            String matchLevel,
            List<MatchFactor> factors,
            List<String> conflicts,
            double? distance,
            double? travelTime,
            double? noShowProbability,
            Map<String, dynamic>? workerProfile)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _WorkerMatch() when $default != null:
        return $default(
            _that.workerId,
            _that.workerName,
            _that.workerEmail,
            _that.matchScore,
            _that.matchLevel,
            _that.factors,
            _that.conflicts,
            _that.distance,
            _that.travelTime,
            _that.noShowProbability,
            _that.workerProfile);
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
            double matchScore,
            String matchLevel,
            List<MatchFactor> factors,
            List<String> conflicts,
            double? distance,
            double? travelTime,
            double? noShowProbability,
            Map<String, dynamic>? workerProfile)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WorkerMatch():
        return $default(
            _that.workerId,
            _that.workerName,
            _that.workerEmail,
            _that.matchScore,
            _that.matchLevel,
            _that.factors,
            _that.conflicts,
            _that.distance,
            _that.travelTime,
            _that.noShowProbability,
            _that.workerProfile);
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
            double matchScore,
            String matchLevel,
            List<MatchFactor> factors,
            List<String> conflicts,
            double? distance,
            double? travelTime,
            double? noShowProbability,
            Map<String, dynamic>? workerProfile)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WorkerMatch() when $default != null:
        return $default(
            _that.workerId,
            _that.workerName,
            _that.workerEmail,
            _that.matchScore,
            _that.matchLevel,
            _that.factors,
            _that.conflicts,
            _that.distance,
            _that.travelTime,
            _that.noShowProbability,
            _that.workerProfile);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _WorkerMatch implements WorkerMatch {
  const _WorkerMatch(
      {required this.workerId,
      required this.workerName,
      required this.workerEmail,
      required this.matchScore,
      required this.matchLevel,
      required final List<MatchFactor> factors,
      required final List<String> conflicts,
      this.distance,
      this.travelTime,
      this.noShowProbability,
      final Map<String, dynamic>? workerProfile})
      : _factors = factors,
        _conflicts = conflicts,
        _workerProfile = workerProfile;
  factory _WorkerMatch.fromJson(Map<String, dynamic> json) =>
      _$WorkerMatchFromJson(json);

  @override
  final String workerId;
  @override
  final String workerName;
  @override
  final String workerEmail;
  @override
  final double matchScore;
  @override
  final String matchLevel;
  final List<MatchFactor> _factors;
  @override
  List<MatchFactor> get factors {
    if (_factors is EqualUnmodifiableListView) return _factors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_factors);
  }

  final List<String> _conflicts;
  @override
  List<String> get conflicts {
    if (_conflicts is EqualUnmodifiableListView) return _conflicts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_conflicts);
  }

  @override
  final double? distance;
  @override
  final double? travelTime;
  @override
  final double? noShowProbability;
  final Map<String, dynamic>? _workerProfile;
  @override
  Map<String, dynamic>? get workerProfile {
    final value = _workerProfile;
    if (value == null) return null;
    if (_workerProfile is EqualUnmodifiableMapView) return _workerProfile;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  /// Create a copy of WorkerMatch
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WorkerMatchCopyWith<_WorkerMatch> get copyWith =>
      __$WorkerMatchCopyWithImpl<_WorkerMatch>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$WorkerMatchToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WorkerMatch &&
            (identical(other.workerId, workerId) ||
                other.workerId == workerId) &&
            (identical(other.workerName, workerName) ||
                other.workerName == workerName) &&
            (identical(other.workerEmail, workerEmail) ||
                other.workerEmail == workerEmail) &&
            (identical(other.matchScore, matchScore) ||
                other.matchScore == matchScore) &&
            (identical(other.matchLevel, matchLevel) ||
                other.matchLevel == matchLevel) &&
            const DeepCollectionEquality().equals(other._factors, _factors) &&
            const DeepCollectionEquality()
                .equals(other._conflicts, _conflicts) &&
            (identical(other.distance, distance) ||
                other.distance == distance) &&
            (identical(other.travelTime, travelTime) ||
                other.travelTime == travelTime) &&
            (identical(other.noShowProbability, noShowProbability) ||
                other.noShowProbability == noShowProbability) &&
            const DeepCollectionEquality()
                .equals(other._workerProfile, _workerProfile));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      workerId,
      workerName,
      workerEmail,
      matchScore,
      matchLevel,
      const DeepCollectionEquality().hash(_factors),
      const DeepCollectionEquality().hash(_conflicts),
      distance,
      travelTime,
      noShowProbability,
      const DeepCollectionEquality().hash(_workerProfile));

  @override
  String toString() {
    return 'WorkerMatch(workerId: $workerId, workerName: $workerName, workerEmail: $workerEmail, matchScore: $matchScore, matchLevel: $matchLevel, factors: $factors, conflicts: $conflicts, distance: $distance, travelTime: $travelTime, noShowProbability: $noShowProbability, workerProfile: $workerProfile)';
  }
}

/// @nodoc
abstract mixin class _$WorkerMatchCopyWith<$Res>
    implements $WorkerMatchCopyWith<$Res> {
  factory _$WorkerMatchCopyWith(
          _WorkerMatch value, $Res Function(_WorkerMatch) _then) =
      __$WorkerMatchCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String workerId,
      String workerName,
      String workerEmail,
      double matchScore,
      String matchLevel,
      List<MatchFactor> factors,
      List<String> conflicts,
      double? distance,
      double? travelTime,
      double? noShowProbability,
      Map<String, dynamic>? workerProfile});
}

/// @nodoc
class __$WorkerMatchCopyWithImpl<$Res> implements _$WorkerMatchCopyWith<$Res> {
  __$WorkerMatchCopyWithImpl(this._self, this._then);

  final _WorkerMatch _self;
  final $Res Function(_WorkerMatch) _then;

  /// Create a copy of WorkerMatch
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? workerId = null,
    Object? workerName = null,
    Object? workerEmail = null,
    Object? matchScore = null,
    Object? matchLevel = null,
    Object? factors = null,
    Object? conflicts = null,
    Object? distance = freezed,
    Object? travelTime = freezed,
    Object? noShowProbability = freezed,
    Object? workerProfile = freezed,
  }) {
    return _then(_WorkerMatch(
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
      matchScore: null == matchScore
          ? _self.matchScore
          : matchScore // ignore: cast_nullable_to_non_nullable
              as double,
      matchLevel: null == matchLevel
          ? _self.matchLevel
          : matchLevel // ignore: cast_nullable_to_non_nullable
              as String,
      factors: null == factors
          ? _self._factors
          : factors // ignore: cast_nullable_to_non_nullable
              as List<MatchFactor>,
      conflicts: null == conflicts
          ? _self._conflicts
          : conflicts // ignore: cast_nullable_to_non_nullable
              as List<String>,
      distance: freezed == distance
          ? _self.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double?,
      travelTime: freezed == travelTime
          ? _self.travelTime
          : travelTime // ignore: cast_nullable_to_non_nullable
              as double?,
      noShowProbability: freezed == noShowProbability
          ? _self.noShowProbability
          : noShowProbability // ignore: cast_nullable_to_non_nullable
              as double?,
      workerProfile: freezed == workerProfile
          ? _self._workerProfile
          : workerProfile // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
mixin _$MatchFactor {
  String get factor;
  double get score;
  double get weight;
  String get description;

  /// Create a copy of MatchFactor
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MatchFactorCopyWith<MatchFactor> get copyWith =>
      _$MatchFactorCopyWithImpl<MatchFactor>(this as MatchFactor, _$identity);

  /// Serializes this MatchFactor to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MatchFactor &&
            (identical(other.factor, factor) || other.factor == factor) &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.weight, weight) || other.weight == weight) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, factor, score, weight, description);

  @override
  String toString() {
    return 'MatchFactor(factor: $factor, score: $score, weight: $weight, description: $description)';
  }
}

/// @nodoc
abstract mixin class $MatchFactorCopyWith<$Res> {
  factory $MatchFactorCopyWith(
          MatchFactor value, $Res Function(MatchFactor) _then) =
      _$MatchFactorCopyWithImpl;
  @useResult
  $Res call({String factor, double score, double weight, String description});
}

/// @nodoc
class _$MatchFactorCopyWithImpl<$Res> implements $MatchFactorCopyWith<$Res> {
  _$MatchFactorCopyWithImpl(this._self, this._then);

  final MatchFactor _self;
  final $Res Function(MatchFactor) _then;

  /// Create a copy of MatchFactor
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? factor = null,
    Object? score = null,
    Object? weight = null,
    Object? description = null,
  }) {
    return _then(_self.copyWith(
      factor: null == factor
          ? _self.factor
          : factor // ignore: cast_nullable_to_non_nullable
              as String,
      score: null == score
          ? _self.score
          : score // ignore: cast_nullable_to_non_nullable
              as double,
      weight: null == weight
          ? _self.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as double,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [MatchFactor].
extension MatchFactorPatterns on MatchFactor {
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
    TResult Function(_MatchFactor value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MatchFactor() when $default != null:
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
    TResult Function(_MatchFactor value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MatchFactor():
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
    TResult? Function(_MatchFactor value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MatchFactor() when $default != null:
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
            String factor, double score, double weight, String description)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MatchFactor() when $default != null:
        return $default(
            _that.factor, _that.score, _that.weight, _that.description);
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
            String factor, double score, double weight, String description)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MatchFactor():
        return $default(
            _that.factor, _that.score, _that.weight, _that.description);
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
            String factor, double score, double weight, String description)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MatchFactor() when $default != null:
        return $default(
            _that.factor, _that.score, _that.weight, _that.description);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _MatchFactor implements MatchFactor {
  const _MatchFactor(
      {required this.factor,
      required this.score,
      required this.weight,
      required this.description});
  factory _MatchFactor.fromJson(Map<String, dynamic> json) =>
      _$MatchFactorFromJson(json);

  @override
  final String factor;
  @override
  final double score;
  @override
  final double weight;
  @override
  final String description;

  /// Create a copy of MatchFactor
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MatchFactorCopyWith<_MatchFactor> get copyWith =>
      __$MatchFactorCopyWithImpl<_MatchFactor>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$MatchFactorToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MatchFactor &&
            (identical(other.factor, factor) || other.factor == factor) &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.weight, weight) || other.weight == weight) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, factor, score, weight, description);

  @override
  String toString() {
    return 'MatchFactor(factor: $factor, score: $score, weight: $weight, description: $description)';
  }
}

/// @nodoc
abstract mixin class _$MatchFactorCopyWith<$Res>
    implements $MatchFactorCopyWith<$Res> {
  factory _$MatchFactorCopyWith(
          _MatchFactor value, $Res Function(_MatchFactor) _then) =
      __$MatchFactorCopyWithImpl;
  @override
  @useResult
  $Res call({String factor, double score, double weight, String description});
}

/// @nodoc
class __$MatchFactorCopyWithImpl<$Res> implements _$MatchFactorCopyWith<$Res> {
  __$MatchFactorCopyWithImpl(this._self, this._then);

  final _MatchFactor _self;
  final $Res Function(_MatchFactor) _then;

  /// Create a copy of MatchFactor
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? factor = null,
    Object? score = null,
    Object? weight = null,
    Object? description = null,
  }) {
    return _then(_MatchFactor(
      factor: null == factor
          ? _self.factor
          : factor // ignore: cast_nullable_to_non_nullable
              as String,
      score: null == score
          ? _self.score
          : score // ignore: cast_nullable_to_non_nullable
              as double,
      weight: null == weight
          ? _self.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as double,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$ShiftRecommendation {
  String get shiftId;
  DateTime get shiftDate;
  String get shiftTime;
  String get service;
  String get clientName;
  List<WorkerMatch> get recommendedWorkers;
  String? get currentAssignment;
  bool? get isUrgent;

  /// Create a copy of ShiftRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ShiftRecommendationCopyWith<ShiftRecommendation> get copyWith =>
      _$ShiftRecommendationCopyWithImpl<ShiftRecommendation>(
          this as ShiftRecommendation, _$identity);

  /// Serializes this ShiftRecommendation to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ShiftRecommendation &&
            (identical(other.shiftId, shiftId) || other.shiftId == shiftId) &&
            (identical(other.shiftDate, shiftDate) ||
                other.shiftDate == shiftDate) &&
            (identical(other.shiftTime, shiftTime) ||
                other.shiftTime == shiftTime) &&
            (identical(other.service, service) || other.service == service) &&
            (identical(other.clientName, clientName) ||
                other.clientName == clientName) &&
            const DeepCollectionEquality()
                .equals(other.recommendedWorkers, recommendedWorkers) &&
            (identical(other.currentAssignment, currentAssignment) ||
                other.currentAssignment == currentAssignment) &&
            (identical(other.isUrgent, isUrgent) ||
                other.isUrgent == isUrgent));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      shiftId,
      shiftDate,
      shiftTime,
      service,
      clientName,
      const DeepCollectionEquality().hash(recommendedWorkers),
      currentAssignment,
      isUrgent);

  @override
  String toString() {
    return 'ShiftRecommendation(shiftId: $shiftId, shiftDate: $shiftDate, shiftTime: $shiftTime, service: $service, clientName: $clientName, recommendedWorkers: $recommendedWorkers, currentAssignment: $currentAssignment, isUrgent: $isUrgent)';
  }
}

/// @nodoc
abstract mixin class $ShiftRecommendationCopyWith<$Res> {
  factory $ShiftRecommendationCopyWith(
          ShiftRecommendation value, $Res Function(ShiftRecommendation) _then) =
      _$ShiftRecommendationCopyWithImpl;
  @useResult
  $Res call(
      {String shiftId,
      DateTime shiftDate,
      String shiftTime,
      String service,
      String clientName,
      List<WorkerMatch> recommendedWorkers,
      String? currentAssignment,
      bool? isUrgent});
}

/// @nodoc
class _$ShiftRecommendationCopyWithImpl<$Res>
    implements $ShiftRecommendationCopyWith<$Res> {
  _$ShiftRecommendationCopyWithImpl(this._self, this._then);

  final ShiftRecommendation _self;
  final $Res Function(ShiftRecommendation) _then;

  /// Create a copy of ShiftRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? shiftId = null,
    Object? shiftDate = null,
    Object? shiftTime = null,
    Object? service = null,
    Object? clientName = null,
    Object? recommendedWorkers = null,
    Object? currentAssignment = freezed,
    Object? isUrgent = freezed,
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
      clientName: null == clientName
          ? _self.clientName
          : clientName // ignore: cast_nullable_to_non_nullable
              as String,
      recommendedWorkers: null == recommendedWorkers
          ? _self.recommendedWorkers
          : recommendedWorkers // ignore: cast_nullable_to_non_nullable
              as List<WorkerMatch>,
      currentAssignment: freezed == currentAssignment
          ? _self.currentAssignment
          : currentAssignment // ignore: cast_nullable_to_non_nullable
              as String?,
      isUrgent: freezed == isUrgent
          ? _self.isUrgent
          : isUrgent // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// Adds pattern-matching-related methods to [ShiftRecommendation].
extension ShiftRecommendationPatterns on ShiftRecommendation {
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
    TResult Function(_ShiftRecommendation value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ShiftRecommendation() when $default != null:
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
    TResult Function(_ShiftRecommendation value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ShiftRecommendation():
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
    TResult? Function(_ShiftRecommendation value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ShiftRecommendation() when $default != null:
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
            String shiftId,
            DateTime shiftDate,
            String shiftTime,
            String service,
            String clientName,
            List<WorkerMatch> recommendedWorkers,
            String? currentAssignment,
            bool? isUrgent)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ShiftRecommendation() when $default != null:
        return $default(
            _that.shiftId,
            _that.shiftDate,
            _that.shiftTime,
            _that.service,
            _that.clientName,
            _that.recommendedWorkers,
            _that.currentAssignment,
            _that.isUrgent);
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
            String shiftId,
            DateTime shiftDate,
            String shiftTime,
            String service,
            String clientName,
            List<WorkerMatch> recommendedWorkers,
            String? currentAssignment,
            bool? isUrgent)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ShiftRecommendation():
        return $default(
            _that.shiftId,
            _that.shiftDate,
            _that.shiftTime,
            _that.service,
            _that.clientName,
            _that.recommendedWorkers,
            _that.currentAssignment,
            _that.isUrgent);
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
            String shiftId,
            DateTime shiftDate,
            String shiftTime,
            String service,
            String clientName,
            List<WorkerMatch> recommendedWorkers,
            String? currentAssignment,
            bool? isUrgent)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ShiftRecommendation() when $default != null:
        return $default(
            _that.shiftId,
            _that.shiftDate,
            _that.shiftTime,
            _that.service,
            _that.clientName,
            _that.recommendedWorkers,
            _that.currentAssignment,
            _that.isUrgent);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ShiftRecommendation implements ShiftRecommendation {
  const _ShiftRecommendation(
      {required this.shiftId,
      required this.shiftDate,
      required this.shiftTime,
      required this.service,
      required this.clientName,
      required final List<WorkerMatch> recommendedWorkers,
      this.currentAssignment,
      this.isUrgent})
      : _recommendedWorkers = recommendedWorkers;
  factory _ShiftRecommendation.fromJson(Map<String, dynamic> json) =>
      _$ShiftRecommendationFromJson(json);

  @override
  final String shiftId;
  @override
  final DateTime shiftDate;
  @override
  final String shiftTime;
  @override
  final String service;
  @override
  final String clientName;
  final List<WorkerMatch> _recommendedWorkers;
  @override
  List<WorkerMatch> get recommendedWorkers {
    if (_recommendedWorkers is EqualUnmodifiableListView)
      return _recommendedWorkers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recommendedWorkers);
  }

  @override
  final String? currentAssignment;
  @override
  final bool? isUrgent;

  /// Create a copy of ShiftRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ShiftRecommendationCopyWith<_ShiftRecommendation> get copyWith =>
      __$ShiftRecommendationCopyWithImpl<_ShiftRecommendation>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ShiftRecommendationToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ShiftRecommendation &&
            (identical(other.shiftId, shiftId) || other.shiftId == shiftId) &&
            (identical(other.shiftDate, shiftDate) ||
                other.shiftDate == shiftDate) &&
            (identical(other.shiftTime, shiftTime) ||
                other.shiftTime == shiftTime) &&
            (identical(other.service, service) || other.service == service) &&
            (identical(other.clientName, clientName) ||
                other.clientName == clientName) &&
            const DeepCollectionEquality()
                .equals(other._recommendedWorkers, _recommendedWorkers) &&
            (identical(other.currentAssignment, currentAssignment) ||
                other.currentAssignment == currentAssignment) &&
            (identical(other.isUrgent, isUrgent) ||
                other.isUrgent == isUrgent));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      shiftId,
      shiftDate,
      shiftTime,
      service,
      clientName,
      const DeepCollectionEquality().hash(_recommendedWorkers),
      currentAssignment,
      isUrgent);

  @override
  String toString() {
    return 'ShiftRecommendation(shiftId: $shiftId, shiftDate: $shiftDate, shiftTime: $shiftTime, service: $service, clientName: $clientName, recommendedWorkers: $recommendedWorkers, currentAssignment: $currentAssignment, isUrgent: $isUrgent)';
  }
}

/// @nodoc
abstract mixin class _$ShiftRecommendationCopyWith<$Res>
    implements $ShiftRecommendationCopyWith<$Res> {
  factory _$ShiftRecommendationCopyWith(_ShiftRecommendation value,
          $Res Function(_ShiftRecommendation) _then) =
      __$ShiftRecommendationCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String shiftId,
      DateTime shiftDate,
      String shiftTime,
      String service,
      String clientName,
      List<WorkerMatch> recommendedWorkers,
      String? currentAssignment,
      bool? isUrgent});
}

/// @nodoc
class __$ShiftRecommendationCopyWithImpl<$Res>
    implements _$ShiftRecommendationCopyWith<$Res> {
  __$ShiftRecommendationCopyWithImpl(this._self, this._then);

  final _ShiftRecommendation _self;
  final $Res Function(_ShiftRecommendation) _then;

  /// Create a copy of ShiftRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? shiftId = null,
    Object? shiftDate = null,
    Object? shiftTime = null,
    Object? service = null,
    Object? clientName = null,
    Object? recommendedWorkers = null,
    Object? currentAssignment = freezed,
    Object? isUrgent = freezed,
  }) {
    return _then(_ShiftRecommendation(
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
      clientName: null == clientName
          ? _self.clientName
          : clientName // ignore: cast_nullable_to_non_nullable
              as String,
      recommendedWorkers: null == recommendedWorkers
          ? _self._recommendedWorkers
          : recommendedWorkers // ignore: cast_nullable_to_non_nullable
              as List<WorkerMatch>,
      currentAssignment: freezed == currentAssignment
          ? _self.currentAssignment
          : currentAssignment // ignore: cast_nullable_to_non_nullable
              as String?,
      isUrgent: freezed == isUrgent
          ? _self.isUrgent
          : isUrgent // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
mixin _$AutoFillRequest {
  String get organizationId;
  List<String> get shiftIds;
  MatchingCriteria get criteria;
  bool? get allowConflicts;
  bool? get optimizeRoute;

  /// Create a copy of AutoFillRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AutoFillRequestCopyWith<AutoFillRequest> get copyWith =>
      _$AutoFillRequestCopyWithImpl<AutoFillRequest>(
          this as AutoFillRequest, _$identity);

  /// Serializes this AutoFillRequest to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AutoFillRequest &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            const DeepCollectionEquality().equals(other.shiftIds, shiftIds) &&
            (identical(other.criteria, criteria) ||
                other.criteria == criteria) &&
            (identical(other.allowConflicts, allowConflicts) ||
                other.allowConflicts == allowConflicts) &&
            (identical(other.optimizeRoute, optimizeRoute) ||
                other.optimizeRoute == optimizeRoute));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      organizationId,
      const DeepCollectionEquality().hash(shiftIds),
      criteria,
      allowConflicts,
      optimizeRoute);

  @override
  String toString() {
    return 'AutoFillRequest(organizationId: $organizationId, shiftIds: $shiftIds, criteria: $criteria, allowConflicts: $allowConflicts, optimizeRoute: $optimizeRoute)';
  }
}

/// @nodoc
abstract mixin class $AutoFillRequestCopyWith<$Res> {
  factory $AutoFillRequestCopyWith(
          AutoFillRequest value, $Res Function(AutoFillRequest) _then) =
      _$AutoFillRequestCopyWithImpl;
  @useResult
  $Res call(
      {String organizationId,
      List<String> shiftIds,
      MatchingCriteria criteria,
      bool? allowConflicts,
      bool? optimizeRoute});

  $MatchingCriteriaCopyWith<$Res> get criteria;
}

/// @nodoc
class _$AutoFillRequestCopyWithImpl<$Res>
    implements $AutoFillRequestCopyWith<$Res> {
  _$AutoFillRequestCopyWithImpl(this._self, this._then);

  final AutoFillRequest _self;
  final $Res Function(AutoFillRequest) _then;

  /// Create a copy of AutoFillRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? organizationId = null,
    Object? shiftIds = null,
    Object? criteria = null,
    Object? allowConflicts = freezed,
    Object? optimizeRoute = freezed,
  }) {
    return _then(_self.copyWith(
      organizationId: null == organizationId
          ? _self.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      shiftIds: null == shiftIds
          ? _self.shiftIds
          : shiftIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      criteria: null == criteria
          ? _self.criteria
          : criteria // ignore: cast_nullable_to_non_nullable
              as MatchingCriteria,
      allowConflicts: freezed == allowConflicts
          ? _self.allowConflicts
          : allowConflicts // ignore: cast_nullable_to_non_nullable
              as bool?,
      optimizeRoute: freezed == optimizeRoute
          ? _self.optimizeRoute
          : optimizeRoute // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }

  /// Create a copy of AutoFillRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MatchingCriteriaCopyWith<$Res> get criteria {
    return $MatchingCriteriaCopyWith<$Res>(_self.criteria, (value) {
      return _then(_self.copyWith(criteria: value));
    });
  }
}

/// Adds pattern-matching-related methods to [AutoFillRequest].
extension AutoFillRequestPatterns on AutoFillRequest {
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
    TResult Function(_AutoFillRequest value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AutoFillRequest() when $default != null:
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
    TResult Function(_AutoFillRequest value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AutoFillRequest():
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
    TResult? Function(_AutoFillRequest value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AutoFillRequest() when $default != null:
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
            String organizationId,
            List<String> shiftIds,
            MatchingCriteria criteria,
            bool? allowConflicts,
            bool? optimizeRoute)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AutoFillRequest() when $default != null:
        return $default(_that.organizationId, _that.shiftIds, _that.criteria,
            _that.allowConflicts, _that.optimizeRoute);
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
            String organizationId,
            List<String> shiftIds,
            MatchingCriteria criteria,
            bool? allowConflicts,
            bool? optimizeRoute)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AutoFillRequest():
        return $default(_that.organizationId, _that.shiftIds, _that.criteria,
            _that.allowConflicts, _that.optimizeRoute);
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
            String organizationId,
            List<String> shiftIds,
            MatchingCriteria criteria,
            bool? allowConflicts,
            bool? optimizeRoute)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AutoFillRequest() when $default != null:
        return $default(_that.organizationId, _that.shiftIds, _that.criteria,
            _that.allowConflicts, _that.optimizeRoute);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _AutoFillRequest implements AutoFillRequest {
  const _AutoFillRequest(
      {required this.organizationId,
      required final List<String> shiftIds,
      required this.criteria,
      this.allowConflicts,
      this.optimizeRoute})
      : _shiftIds = shiftIds;
  factory _AutoFillRequest.fromJson(Map<String, dynamic> json) =>
      _$AutoFillRequestFromJson(json);

  @override
  final String organizationId;
  final List<String> _shiftIds;
  @override
  List<String> get shiftIds {
    if (_shiftIds is EqualUnmodifiableListView) return _shiftIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_shiftIds);
  }

  @override
  final MatchingCriteria criteria;
  @override
  final bool? allowConflicts;
  @override
  final bool? optimizeRoute;

  /// Create a copy of AutoFillRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AutoFillRequestCopyWith<_AutoFillRequest> get copyWith =>
      __$AutoFillRequestCopyWithImpl<_AutoFillRequest>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AutoFillRequestToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AutoFillRequest &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            const DeepCollectionEquality().equals(other._shiftIds, _shiftIds) &&
            (identical(other.criteria, criteria) ||
                other.criteria == criteria) &&
            (identical(other.allowConflicts, allowConflicts) ||
                other.allowConflicts == allowConflicts) &&
            (identical(other.optimizeRoute, optimizeRoute) ||
                other.optimizeRoute == optimizeRoute));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      organizationId,
      const DeepCollectionEquality().hash(_shiftIds),
      criteria,
      allowConflicts,
      optimizeRoute);

  @override
  String toString() {
    return 'AutoFillRequest(organizationId: $organizationId, shiftIds: $shiftIds, criteria: $criteria, allowConflicts: $allowConflicts, optimizeRoute: $optimizeRoute)';
  }
}

/// @nodoc
abstract mixin class _$AutoFillRequestCopyWith<$Res>
    implements $AutoFillRequestCopyWith<$Res> {
  factory _$AutoFillRequestCopyWith(
          _AutoFillRequest value, $Res Function(_AutoFillRequest) _then) =
      __$AutoFillRequestCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String organizationId,
      List<String> shiftIds,
      MatchingCriteria criteria,
      bool? allowConflicts,
      bool? optimizeRoute});

  @override
  $MatchingCriteriaCopyWith<$Res> get criteria;
}

/// @nodoc
class __$AutoFillRequestCopyWithImpl<$Res>
    implements _$AutoFillRequestCopyWith<$Res> {
  __$AutoFillRequestCopyWithImpl(this._self, this._then);

  final _AutoFillRequest _self;
  final $Res Function(_AutoFillRequest) _then;

  /// Create a copy of AutoFillRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? organizationId = null,
    Object? shiftIds = null,
    Object? criteria = null,
    Object? allowConflicts = freezed,
    Object? optimizeRoute = freezed,
  }) {
    return _then(_AutoFillRequest(
      organizationId: null == organizationId
          ? _self.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      shiftIds: null == shiftIds
          ? _self._shiftIds
          : shiftIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      criteria: null == criteria
          ? _self.criteria
          : criteria // ignore: cast_nullable_to_non_nullable
              as MatchingCriteria,
      allowConflicts: freezed == allowConflicts
          ? _self.allowConflicts
          : allowConflicts // ignore: cast_nullable_to_non_nullable
              as bool?,
      optimizeRoute: freezed == optimizeRoute
          ? _self.optimizeRoute
          : optimizeRoute // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }

  /// Create a copy of AutoFillRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MatchingCriteriaCopyWith<$Res> get criteria {
    return $MatchingCriteriaCopyWith<$Res>(_self.criteria, (value) {
      return _then(_self.copyWith(criteria: value));
    });
  }
}

/// @nodoc
mixin _$AutoFillResult {
  int get totalShifts;
  int get filledShifts;
  int get unfilledShifts;
  List<ShiftAssignment> get assignments;
  List<String> get unfilledShiftIds;
  String? get optimizationSummary;

  /// Create a copy of AutoFillResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AutoFillResultCopyWith<AutoFillResult> get copyWith =>
      _$AutoFillResultCopyWithImpl<AutoFillResult>(
          this as AutoFillResult, _$identity);

  /// Serializes this AutoFillResult to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AutoFillResult &&
            (identical(other.totalShifts, totalShifts) ||
                other.totalShifts == totalShifts) &&
            (identical(other.filledShifts, filledShifts) ||
                other.filledShifts == filledShifts) &&
            (identical(other.unfilledShifts, unfilledShifts) ||
                other.unfilledShifts == unfilledShifts) &&
            const DeepCollectionEquality()
                .equals(other.assignments, assignments) &&
            const DeepCollectionEquality()
                .equals(other.unfilledShiftIds, unfilledShiftIds) &&
            (identical(other.optimizationSummary, optimizationSummary) ||
                other.optimizationSummary == optimizationSummary));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      totalShifts,
      filledShifts,
      unfilledShifts,
      const DeepCollectionEquality().hash(assignments),
      const DeepCollectionEquality().hash(unfilledShiftIds),
      optimizationSummary);

  @override
  String toString() {
    return 'AutoFillResult(totalShifts: $totalShifts, filledShifts: $filledShifts, unfilledShifts: $unfilledShifts, assignments: $assignments, unfilledShiftIds: $unfilledShiftIds, optimizationSummary: $optimizationSummary)';
  }
}

/// @nodoc
abstract mixin class $AutoFillResultCopyWith<$Res> {
  factory $AutoFillResultCopyWith(
          AutoFillResult value, $Res Function(AutoFillResult) _then) =
      _$AutoFillResultCopyWithImpl;
  @useResult
  $Res call(
      {int totalShifts,
      int filledShifts,
      int unfilledShifts,
      List<ShiftAssignment> assignments,
      List<String> unfilledShiftIds,
      String? optimizationSummary});
}

/// @nodoc
class _$AutoFillResultCopyWithImpl<$Res>
    implements $AutoFillResultCopyWith<$Res> {
  _$AutoFillResultCopyWithImpl(this._self, this._then);

  final AutoFillResult _self;
  final $Res Function(AutoFillResult) _then;

  /// Create a copy of AutoFillResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalShifts = null,
    Object? filledShifts = null,
    Object? unfilledShifts = null,
    Object? assignments = null,
    Object? unfilledShiftIds = null,
    Object? optimizationSummary = freezed,
  }) {
    return _then(_self.copyWith(
      totalShifts: null == totalShifts
          ? _self.totalShifts
          : totalShifts // ignore: cast_nullable_to_non_nullable
              as int,
      filledShifts: null == filledShifts
          ? _self.filledShifts
          : filledShifts // ignore: cast_nullable_to_non_nullable
              as int,
      unfilledShifts: null == unfilledShifts
          ? _self.unfilledShifts
          : unfilledShifts // ignore: cast_nullable_to_non_nullable
              as int,
      assignments: null == assignments
          ? _self.assignments
          : assignments // ignore: cast_nullable_to_non_nullable
              as List<ShiftAssignment>,
      unfilledShiftIds: null == unfilledShiftIds
          ? _self.unfilledShiftIds
          : unfilledShiftIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      optimizationSummary: freezed == optimizationSummary
          ? _self.optimizationSummary
          : optimizationSummary // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [AutoFillResult].
extension AutoFillResultPatterns on AutoFillResult {
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
    TResult Function(_AutoFillResult value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AutoFillResult() when $default != null:
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
    TResult Function(_AutoFillResult value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AutoFillResult():
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
    TResult? Function(_AutoFillResult value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AutoFillResult() when $default != null:
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
            int totalShifts,
            int filledShifts,
            int unfilledShifts,
            List<ShiftAssignment> assignments,
            List<String> unfilledShiftIds,
            String? optimizationSummary)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AutoFillResult() when $default != null:
        return $default(
            _that.totalShifts,
            _that.filledShifts,
            _that.unfilledShifts,
            _that.assignments,
            _that.unfilledShiftIds,
            _that.optimizationSummary);
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
            int totalShifts,
            int filledShifts,
            int unfilledShifts,
            List<ShiftAssignment> assignments,
            List<String> unfilledShiftIds,
            String? optimizationSummary)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AutoFillResult():
        return $default(
            _that.totalShifts,
            _that.filledShifts,
            _that.unfilledShifts,
            _that.assignments,
            _that.unfilledShiftIds,
            _that.optimizationSummary);
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
            int totalShifts,
            int filledShifts,
            int unfilledShifts,
            List<ShiftAssignment> assignments,
            List<String> unfilledShiftIds,
            String? optimizationSummary)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AutoFillResult() when $default != null:
        return $default(
            _that.totalShifts,
            _that.filledShifts,
            _that.unfilledShifts,
            _that.assignments,
            _that.unfilledShiftIds,
            _that.optimizationSummary);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _AutoFillResult implements AutoFillResult {
  const _AutoFillResult(
      {required this.totalShifts,
      required this.filledShifts,
      required this.unfilledShifts,
      required final List<ShiftAssignment> assignments,
      required final List<String> unfilledShiftIds,
      this.optimizationSummary})
      : _assignments = assignments,
        _unfilledShiftIds = unfilledShiftIds;
  factory _AutoFillResult.fromJson(Map<String, dynamic> json) =>
      _$AutoFillResultFromJson(json);

  @override
  final int totalShifts;
  @override
  final int filledShifts;
  @override
  final int unfilledShifts;
  final List<ShiftAssignment> _assignments;
  @override
  List<ShiftAssignment> get assignments {
    if (_assignments is EqualUnmodifiableListView) return _assignments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_assignments);
  }

  final List<String> _unfilledShiftIds;
  @override
  List<String> get unfilledShiftIds {
    if (_unfilledShiftIds is EqualUnmodifiableListView)
      return _unfilledShiftIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_unfilledShiftIds);
  }

  @override
  final String? optimizationSummary;

  /// Create a copy of AutoFillResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AutoFillResultCopyWith<_AutoFillResult> get copyWith =>
      __$AutoFillResultCopyWithImpl<_AutoFillResult>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AutoFillResultToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AutoFillResult &&
            (identical(other.totalShifts, totalShifts) ||
                other.totalShifts == totalShifts) &&
            (identical(other.filledShifts, filledShifts) ||
                other.filledShifts == filledShifts) &&
            (identical(other.unfilledShifts, unfilledShifts) ||
                other.unfilledShifts == unfilledShifts) &&
            const DeepCollectionEquality()
                .equals(other._assignments, _assignments) &&
            const DeepCollectionEquality()
                .equals(other._unfilledShiftIds, _unfilledShiftIds) &&
            (identical(other.optimizationSummary, optimizationSummary) ||
                other.optimizationSummary == optimizationSummary));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      totalShifts,
      filledShifts,
      unfilledShifts,
      const DeepCollectionEquality().hash(_assignments),
      const DeepCollectionEquality().hash(_unfilledShiftIds),
      optimizationSummary);

  @override
  String toString() {
    return 'AutoFillResult(totalShifts: $totalShifts, filledShifts: $filledShifts, unfilledShifts: $unfilledShifts, assignments: $assignments, unfilledShiftIds: $unfilledShiftIds, optimizationSummary: $optimizationSummary)';
  }
}

/// @nodoc
abstract mixin class _$AutoFillResultCopyWith<$Res>
    implements $AutoFillResultCopyWith<$Res> {
  factory _$AutoFillResultCopyWith(
          _AutoFillResult value, $Res Function(_AutoFillResult) _then) =
      __$AutoFillResultCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int totalShifts,
      int filledShifts,
      int unfilledShifts,
      List<ShiftAssignment> assignments,
      List<String> unfilledShiftIds,
      String? optimizationSummary});
}

/// @nodoc
class __$AutoFillResultCopyWithImpl<$Res>
    implements _$AutoFillResultCopyWith<$Res> {
  __$AutoFillResultCopyWithImpl(this._self, this._then);

  final _AutoFillResult _self;
  final $Res Function(_AutoFillResult) _then;

  /// Create a copy of AutoFillResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? totalShifts = null,
    Object? filledShifts = null,
    Object? unfilledShifts = null,
    Object? assignments = null,
    Object? unfilledShiftIds = null,
    Object? optimizationSummary = freezed,
  }) {
    return _then(_AutoFillResult(
      totalShifts: null == totalShifts
          ? _self.totalShifts
          : totalShifts // ignore: cast_nullable_to_non_nullable
              as int,
      filledShifts: null == filledShifts
          ? _self.filledShifts
          : filledShifts // ignore: cast_nullable_to_non_nullable
              as int,
      unfilledShifts: null == unfilledShifts
          ? _self.unfilledShifts
          : unfilledShifts // ignore: cast_nullable_to_non_nullable
              as int,
      assignments: null == assignments
          ? _self._assignments
          : assignments // ignore: cast_nullable_to_non_nullable
              as List<ShiftAssignment>,
      unfilledShiftIds: null == unfilledShiftIds
          ? _self._unfilledShiftIds
          : unfilledShiftIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      optimizationSummary: freezed == optimizationSummary
          ? _self.optimizationSummary
          : optimizationSummary // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$ShiftAssignment {
  String get shiftId;
  String get workerId;
  String get workerName;
  double get matchScore;
  String get reason;
  List<String>? get warnings;

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
            (identical(other.workerName, workerName) ||
                other.workerName == workerName) &&
            (identical(other.matchScore, matchScore) ||
                other.matchScore == matchScore) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            const DeepCollectionEquality().equals(other.warnings, warnings));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, shiftId, workerId, workerName,
      matchScore, reason, const DeepCollectionEquality().hash(warnings));

  @override
  String toString() {
    return 'ShiftAssignment(shiftId: $shiftId, workerId: $workerId, workerName: $workerName, matchScore: $matchScore, reason: $reason, warnings: $warnings)';
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
      String workerId,
      String workerName,
      double matchScore,
      String reason,
      List<String>? warnings});
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
    Object? workerId = null,
    Object? workerName = null,
    Object? matchScore = null,
    Object? reason = null,
    Object? warnings = freezed,
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
      workerName: null == workerName
          ? _self.workerName
          : workerName // ignore: cast_nullable_to_non_nullable
              as String,
      matchScore: null == matchScore
          ? _self.matchScore
          : matchScore // ignore: cast_nullable_to_non_nullable
              as double,
      reason: null == reason
          ? _self.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
      warnings: freezed == warnings
          ? _self.warnings
          : warnings // ignore: cast_nullable_to_non_nullable
              as List<String>?,
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
    TResult Function(String shiftId, String workerId, String workerName,
            double matchScore, String reason, List<String>? warnings)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ShiftAssignment() when $default != null:
        return $default(_that.shiftId, _that.workerId, _that.workerName,
            _that.matchScore, _that.reason, _that.warnings);
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
    TResult Function(String shiftId, String workerId, String workerName,
            double matchScore, String reason, List<String>? warnings)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ShiftAssignment():
        return $default(_that.shiftId, _that.workerId, _that.workerName,
            _that.matchScore, _that.reason, _that.warnings);
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
    TResult? Function(String shiftId, String workerId, String workerName,
            double matchScore, String reason, List<String>? warnings)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ShiftAssignment() when $default != null:
        return $default(_that.shiftId, _that.workerId, _that.workerName,
            _that.matchScore, _that.reason, _that.warnings);
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
      required this.workerName,
      required this.matchScore,
      required this.reason,
      final List<String>? warnings})
      : _warnings = warnings;
  factory _ShiftAssignment.fromJson(Map<String, dynamic> json) =>
      _$ShiftAssignmentFromJson(json);

  @override
  final String shiftId;
  @override
  final String workerId;
  @override
  final String workerName;
  @override
  final double matchScore;
  @override
  final String reason;
  final List<String>? _warnings;
  @override
  List<String>? get warnings {
    final value = _warnings;
    if (value == null) return null;
    if (_warnings is EqualUnmodifiableListView) return _warnings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

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
            (identical(other.workerName, workerName) ||
                other.workerName == workerName) &&
            (identical(other.matchScore, matchScore) ||
                other.matchScore == matchScore) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            const DeepCollectionEquality().equals(other._warnings, _warnings));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, shiftId, workerId, workerName,
      matchScore, reason, const DeepCollectionEquality().hash(_warnings));

  @override
  String toString() {
    return 'ShiftAssignment(shiftId: $shiftId, workerId: $workerId, workerName: $workerName, matchScore: $matchScore, reason: $reason, warnings: $warnings)';
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
      String workerId,
      String workerName,
      double matchScore,
      String reason,
      List<String>? warnings});
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
    Object? workerId = null,
    Object? workerName = null,
    Object? matchScore = null,
    Object? reason = null,
    Object? warnings = freezed,
  }) {
    return _then(_ShiftAssignment(
      shiftId: null == shiftId
          ? _self.shiftId
          : shiftId // ignore: cast_nullable_to_non_nullable
              as String,
      workerId: null == workerId
          ? _self.workerId
          : workerId // ignore: cast_nullable_to_non_nullable
              as String,
      workerName: null == workerName
          ? _self.workerName
          : workerName // ignore: cast_nullable_to_non_nullable
              as String,
      matchScore: null == matchScore
          ? _self.matchScore
          : matchScore // ignore: cast_nullable_to_non_nullable
              as double,
      reason: null == reason
          ? _self.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
      warnings: freezed == warnings
          ? _self._warnings
          : warnings // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
mixin _$MatchingCriteria {
  bool get requireSkillMatch;
  bool get checkAvailability;
  bool get considerDistance;
  bool get checkPreferences;
  bool get allowOvertime;
  double get maxDistance;
  double get minMatchScore;
  List<String>? get priorityFactors;

  /// Create a copy of MatchingCriteria
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MatchingCriteriaCopyWith<MatchingCriteria> get copyWith =>
      _$MatchingCriteriaCopyWithImpl<MatchingCriteria>(
          this as MatchingCriteria, _$identity);

  /// Serializes this MatchingCriteria to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MatchingCriteria &&
            (identical(other.requireSkillMatch, requireSkillMatch) ||
                other.requireSkillMatch == requireSkillMatch) &&
            (identical(other.checkAvailability, checkAvailability) ||
                other.checkAvailability == checkAvailability) &&
            (identical(other.considerDistance, considerDistance) ||
                other.considerDistance == considerDistance) &&
            (identical(other.checkPreferences, checkPreferences) ||
                other.checkPreferences == checkPreferences) &&
            (identical(other.allowOvertime, allowOvertime) ||
                other.allowOvertime == allowOvertime) &&
            (identical(other.maxDistance, maxDistance) ||
                other.maxDistance == maxDistance) &&
            (identical(other.minMatchScore, minMatchScore) ||
                other.minMatchScore == minMatchScore) &&
            const DeepCollectionEquality()
                .equals(other.priorityFactors, priorityFactors));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      requireSkillMatch,
      checkAvailability,
      considerDistance,
      checkPreferences,
      allowOvertime,
      maxDistance,
      minMatchScore,
      const DeepCollectionEquality().hash(priorityFactors));

  @override
  String toString() {
    return 'MatchingCriteria(requireSkillMatch: $requireSkillMatch, checkAvailability: $checkAvailability, considerDistance: $considerDistance, checkPreferences: $checkPreferences, allowOvertime: $allowOvertime, maxDistance: $maxDistance, minMatchScore: $minMatchScore, priorityFactors: $priorityFactors)';
  }
}

/// @nodoc
abstract mixin class $MatchingCriteriaCopyWith<$Res> {
  factory $MatchingCriteriaCopyWith(
          MatchingCriteria value, $Res Function(MatchingCriteria) _then) =
      _$MatchingCriteriaCopyWithImpl;
  @useResult
  $Res call(
      {bool requireSkillMatch,
      bool checkAvailability,
      bool considerDistance,
      bool checkPreferences,
      bool allowOvertime,
      double maxDistance,
      double minMatchScore,
      List<String>? priorityFactors});
}

/// @nodoc
class _$MatchingCriteriaCopyWithImpl<$Res>
    implements $MatchingCriteriaCopyWith<$Res> {
  _$MatchingCriteriaCopyWithImpl(this._self, this._then);

  final MatchingCriteria _self;
  final $Res Function(MatchingCriteria) _then;

  /// Create a copy of MatchingCriteria
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? requireSkillMatch = null,
    Object? checkAvailability = null,
    Object? considerDistance = null,
    Object? checkPreferences = null,
    Object? allowOvertime = null,
    Object? maxDistance = null,
    Object? minMatchScore = null,
    Object? priorityFactors = freezed,
  }) {
    return _then(_self.copyWith(
      requireSkillMatch: null == requireSkillMatch
          ? _self.requireSkillMatch
          : requireSkillMatch // ignore: cast_nullable_to_non_nullable
              as bool,
      checkAvailability: null == checkAvailability
          ? _self.checkAvailability
          : checkAvailability // ignore: cast_nullable_to_non_nullable
              as bool,
      considerDistance: null == considerDistance
          ? _self.considerDistance
          : considerDistance // ignore: cast_nullable_to_non_nullable
              as bool,
      checkPreferences: null == checkPreferences
          ? _self.checkPreferences
          : checkPreferences // ignore: cast_nullable_to_non_nullable
              as bool,
      allowOvertime: null == allowOvertime
          ? _self.allowOvertime
          : allowOvertime // ignore: cast_nullable_to_non_nullable
              as bool,
      maxDistance: null == maxDistance
          ? _self.maxDistance
          : maxDistance // ignore: cast_nullable_to_non_nullable
              as double,
      minMatchScore: null == minMatchScore
          ? _self.minMatchScore
          : minMatchScore // ignore: cast_nullable_to_non_nullable
              as double,
      priorityFactors: freezed == priorityFactors
          ? _self.priorityFactors
          : priorityFactors // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// Adds pattern-matching-related methods to [MatchingCriteria].
extension MatchingCriteriaPatterns on MatchingCriteria {
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
    TResult Function(_MatchingCriteria value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MatchingCriteria() when $default != null:
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
    TResult Function(_MatchingCriteria value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MatchingCriteria():
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
    TResult? Function(_MatchingCriteria value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MatchingCriteria() when $default != null:
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
            bool requireSkillMatch,
            bool checkAvailability,
            bool considerDistance,
            bool checkPreferences,
            bool allowOvertime,
            double maxDistance,
            double minMatchScore,
            List<String>? priorityFactors)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MatchingCriteria() when $default != null:
        return $default(
            _that.requireSkillMatch,
            _that.checkAvailability,
            _that.considerDistance,
            _that.checkPreferences,
            _that.allowOvertime,
            _that.maxDistance,
            _that.minMatchScore,
            _that.priorityFactors);
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
            bool requireSkillMatch,
            bool checkAvailability,
            bool considerDistance,
            bool checkPreferences,
            bool allowOvertime,
            double maxDistance,
            double minMatchScore,
            List<String>? priorityFactors)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MatchingCriteria():
        return $default(
            _that.requireSkillMatch,
            _that.checkAvailability,
            _that.considerDistance,
            _that.checkPreferences,
            _that.allowOvertime,
            _that.maxDistance,
            _that.minMatchScore,
            _that.priorityFactors);
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
            bool requireSkillMatch,
            bool checkAvailability,
            bool considerDistance,
            bool checkPreferences,
            bool allowOvertime,
            double maxDistance,
            double minMatchScore,
            List<String>? priorityFactors)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MatchingCriteria() when $default != null:
        return $default(
            _that.requireSkillMatch,
            _that.checkAvailability,
            _that.considerDistance,
            _that.checkPreferences,
            _that.allowOvertime,
            _that.maxDistance,
            _that.minMatchScore,
            _that.priorityFactors);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _MatchingCriteria implements MatchingCriteria {
  const _MatchingCriteria(
      {this.requireSkillMatch = true,
      this.checkAvailability = true,
      this.considerDistance = true,
      this.checkPreferences = true,
      this.allowOvertime = false,
      this.maxDistance = 30.0,
      this.minMatchScore = 0.6,
      final List<String>? priorityFactors})
      : _priorityFactors = priorityFactors;
  factory _MatchingCriteria.fromJson(Map<String, dynamic> json) =>
      _$MatchingCriteriaFromJson(json);

  @override
  @JsonKey()
  final bool requireSkillMatch;
  @override
  @JsonKey()
  final bool checkAvailability;
  @override
  @JsonKey()
  final bool considerDistance;
  @override
  @JsonKey()
  final bool checkPreferences;
  @override
  @JsonKey()
  final bool allowOvertime;
  @override
  @JsonKey()
  final double maxDistance;
  @override
  @JsonKey()
  final double minMatchScore;
  final List<String>? _priorityFactors;
  @override
  List<String>? get priorityFactors {
    final value = _priorityFactors;
    if (value == null) return null;
    if (_priorityFactors is EqualUnmodifiableListView) return _priorityFactors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// Create a copy of MatchingCriteria
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MatchingCriteriaCopyWith<_MatchingCriteria> get copyWith =>
      __$MatchingCriteriaCopyWithImpl<_MatchingCriteria>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$MatchingCriteriaToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MatchingCriteria &&
            (identical(other.requireSkillMatch, requireSkillMatch) ||
                other.requireSkillMatch == requireSkillMatch) &&
            (identical(other.checkAvailability, checkAvailability) ||
                other.checkAvailability == checkAvailability) &&
            (identical(other.considerDistance, considerDistance) ||
                other.considerDistance == considerDistance) &&
            (identical(other.checkPreferences, checkPreferences) ||
                other.checkPreferences == checkPreferences) &&
            (identical(other.allowOvertime, allowOvertime) ||
                other.allowOvertime == allowOvertime) &&
            (identical(other.maxDistance, maxDistance) ||
                other.maxDistance == maxDistance) &&
            (identical(other.minMatchScore, minMatchScore) ||
                other.minMatchScore == minMatchScore) &&
            const DeepCollectionEquality()
                .equals(other._priorityFactors, _priorityFactors));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      requireSkillMatch,
      checkAvailability,
      considerDistance,
      checkPreferences,
      allowOvertime,
      maxDistance,
      minMatchScore,
      const DeepCollectionEquality().hash(_priorityFactors));

  @override
  String toString() {
    return 'MatchingCriteria(requireSkillMatch: $requireSkillMatch, checkAvailability: $checkAvailability, considerDistance: $considerDistance, checkPreferences: $checkPreferences, allowOvertime: $allowOvertime, maxDistance: $maxDistance, minMatchScore: $minMatchScore, priorityFactors: $priorityFactors)';
  }
}

/// @nodoc
abstract mixin class _$MatchingCriteriaCopyWith<$Res>
    implements $MatchingCriteriaCopyWith<$Res> {
  factory _$MatchingCriteriaCopyWith(
          _MatchingCriteria value, $Res Function(_MatchingCriteria) _then) =
      __$MatchingCriteriaCopyWithImpl;
  @override
  @useResult
  $Res call(
      {bool requireSkillMatch,
      bool checkAvailability,
      bool considerDistance,
      bool checkPreferences,
      bool allowOvertime,
      double maxDistance,
      double minMatchScore,
      List<String>? priorityFactors});
}

/// @nodoc
class __$MatchingCriteriaCopyWithImpl<$Res>
    implements _$MatchingCriteriaCopyWith<$Res> {
  __$MatchingCriteriaCopyWithImpl(this._self, this._then);

  final _MatchingCriteria _self;
  final $Res Function(_MatchingCriteria) _then;

  /// Create a copy of MatchingCriteria
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? requireSkillMatch = null,
    Object? checkAvailability = null,
    Object? considerDistance = null,
    Object? checkPreferences = null,
    Object? allowOvertime = null,
    Object? maxDistance = null,
    Object? minMatchScore = null,
    Object? priorityFactors = freezed,
  }) {
    return _then(_MatchingCriteria(
      requireSkillMatch: null == requireSkillMatch
          ? _self.requireSkillMatch
          : requireSkillMatch // ignore: cast_nullable_to_non_nullable
              as bool,
      checkAvailability: null == checkAvailability
          ? _self.checkAvailability
          : checkAvailability // ignore: cast_nullable_to_non_nullable
              as bool,
      considerDistance: null == considerDistance
          ? _self.considerDistance
          : considerDistance // ignore: cast_nullable_to_non_nullable
              as bool,
      checkPreferences: null == checkPreferences
          ? _self.checkPreferences
          : checkPreferences // ignore: cast_nullable_to_non_nullable
              as bool,
      allowOvertime: null == allowOvertime
          ? _self.allowOvertime
          : allowOvertime // ignore: cast_nullable_to_non_nullable
              as bool,
      maxDistance: null == maxDistance
          ? _self.maxDistance
          : maxDistance // ignore: cast_nullable_to_non_nullable
              as double,
      minMatchScore: null == minMatchScore
          ? _self.minMatchScore
          : minMatchScore // ignore: cast_nullable_to_non_nullable
              as double,
      priorityFactors: freezed == priorityFactors
          ? _self._priorityFactors
          : priorityFactors // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
mixin _$RouteOptimization {
  String get workerId;
  String get workerName;
  List<OptimizedShift> get shifts;
  double get totalDistance;
  double get totalTravelTime;
  double get efficiencyScore;
  String? get recommendations;

  /// Create a copy of RouteOptimization
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RouteOptimizationCopyWith<RouteOptimization> get copyWith =>
      _$RouteOptimizationCopyWithImpl<RouteOptimization>(
          this as RouteOptimization, _$identity);

  /// Serializes this RouteOptimization to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RouteOptimization &&
            (identical(other.workerId, workerId) ||
                other.workerId == workerId) &&
            (identical(other.workerName, workerName) ||
                other.workerName == workerName) &&
            const DeepCollectionEquality().equals(other.shifts, shifts) &&
            (identical(other.totalDistance, totalDistance) ||
                other.totalDistance == totalDistance) &&
            (identical(other.totalTravelTime, totalTravelTime) ||
                other.totalTravelTime == totalTravelTime) &&
            (identical(other.efficiencyScore, efficiencyScore) ||
                other.efficiencyScore == efficiencyScore) &&
            (identical(other.recommendations, recommendations) ||
                other.recommendations == recommendations));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      workerId,
      workerName,
      const DeepCollectionEquality().hash(shifts),
      totalDistance,
      totalTravelTime,
      efficiencyScore,
      recommendations);

  @override
  String toString() {
    return 'RouteOptimization(workerId: $workerId, workerName: $workerName, shifts: $shifts, totalDistance: $totalDistance, totalTravelTime: $totalTravelTime, efficiencyScore: $efficiencyScore, recommendations: $recommendations)';
  }
}

/// @nodoc
abstract mixin class $RouteOptimizationCopyWith<$Res> {
  factory $RouteOptimizationCopyWith(
          RouteOptimization value, $Res Function(RouteOptimization) _then) =
      _$RouteOptimizationCopyWithImpl;
  @useResult
  $Res call(
      {String workerId,
      String workerName,
      List<OptimizedShift> shifts,
      double totalDistance,
      double totalTravelTime,
      double efficiencyScore,
      String? recommendations});
}

/// @nodoc
class _$RouteOptimizationCopyWithImpl<$Res>
    implements $RouteOptimizationCopyWith<$Res> {
  _$RouteOptimizationCopyWithImpl(this._self, this._then);

  final RouteOptimization _self;
  final $Res Function(RouteOptimization) _then;

  /// Create a copy of RouteOptimization
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? workerId = null,
    Object? workerName = null,
    Object? shifts = null,
    Object? totalDistance = null,
    Object? totalTravelTime = null,
    Object? efficiencyScore = null,
    Object? recommendations = freezed,
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
      shifts: null == shifts
          ? _self.shifts
          : shifts // ignore: cast_nullable_to_non_nullable
              as List<OptimizedShift>,
      totalDistance: null == totalDistance
          ? _self.totalDistance
          : totalDistance // ignore: cast_nullable_to_non_nullable
              as double,
      totalTravelTime: null == totalTravelTime
          ? _self.totalTravelTime
          : totalTravelTime // ignore: cast_nullable_to_non_nullable
              as double,
      efficiencyScore: null == efficiencyScore
          ? _self.efficiencyScore
          : efficiencyScore // ignore: cast_nullable_to_non_nullable
              as double,
      recommendations: freezed == recommendations
          ? _self.recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [RouteOptimization].
extension RouteOptimizationPatterns on RouteOptimization {
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
    TResult Function(_RouteOptimization value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RouteOptimization() when $default != null:
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
    TResult Function(_RouteOptimization value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RouteOptimization():
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
    TResult? Function(_RouteOptimization value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RouteOptimization() when $default != null:
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
            List<OptimizedShift> shifts,
            double totalDistance,
            double totalTravelTime,
            double efficiencyScore,
            String? recommendations)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RouteOptimization() when $default != null:
        return $default(
            _that.workerId,
            _that.workerName,
            _that.shifts,
            _that.totalDistance,
            _that.totalTravelTime,
            _that.efficiencyScore,
            _that.recommendations);
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
            List<OptimizedShift> shifts,
            double totalDistance,
            double totalTravelTime,
            double efficiencyScore,
            String? recommendations)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RouteOptimization():
        return $default(
            _that.workerId,
            _that.workerName,
            _that.shifts,
            _that.totalDistance,
            _that.totalTravelTime,
            _that.efficiencyScore,
            _that.recommendations);
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
            List<OptimizedShift> shifts,
            double totalDistance,
            double totalTravelTime,
            double efficiencyScore,
            String? recommendations)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RouteOptimization() when $default != null:
        return $default(
            _that.workerId,
            _that.workerName,
            _that.shifts,
            _that.totalDistance,
            _that.totalTravelTime,
            _that.efficiencyScore,
            _that.recommendations);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _RouteOptimization implements RouteOptimization {
  const _RouteOptimization(
      {required this.workerId,
      required this.workerName,
      required final List<OptimizedShift> shifts,
      required this.totalDistance,
      required this.totalTravelTime,
      required this.efficiencyScore,
      this.recommendations})
      : _shifts = shifts;
  factory _RouteOptimization.fromJson(Map<String, dynamic> json) =>
      _$RouteOptimizationFromJson(json);

  @override
  final String workerId;
  @override
  final String workerName;
  final List<OptimizedShift> _shifts;
  @override
  List<OptimizedShift> get shifts {
    if (_shifts is EqualUnmodifiableListView) return _shifts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_shifts);
  }

  @override
  final double totalDistance;
  @override
  final double totalTravelTime;
  @override
  final double efficiencyScore;
  @override
  final String? recommendations;

  /// Create a copy of RouteOptimization
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RouteOptimizationCopyWith<_RouteOptimization> get copyWith =>
      __$RouteOptimizationCopyWithImpl<_RouteOptimization>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$RouteOptimizationToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RouteOptimization &&
            (identical(other.workerId, workerId) ||
                other.workerId == workerId) &&
            (identical(other.workerName, workerName) ||
                other.workerName == workerName) &&
            const DeepCollectionEquality().equals(other._shifts, _shifts) &&
            (identical(other.totalDistance, totalDistance) ||
                other.totalDistance == totalDistance) &&
            (identical(other.totalTravelTime, totalTravelTime) ||
                other.totalTravelTime == totalTravelTime) &&
            (identical(other.efficiencyScore, efficiencyScore) ||
                other.efficiencyScore == efficiencyScore) &&
            (identical(other.recommendations, recommendations) ||
                other.recommendations == recommendations));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      workerId,
      workerName,
      const DeepCollectionEquality().hash(_shifts),
      totalDistance,
      totalTravelTime,
      efficiencyScore,
      recommendations);

  @override
  String toString() {
    return 'RouteOptimization(workerId: $workerId, workerName: $workerName, shifts: $shifts, totalDistance: $totalDistance, totalTravelTime: $totalTravelTime, efficiencyScore: $efficiencyScore, recommendations: $recommendations)';
  }
}

/// @nodoc
abstract mixin class _$RouteOptimizationCopyWith<$Res>
    implements $RouteOptimizationCopyWith<$Res> {
  factory _$RouteOptimizationCopyWith(
          _RouteOptimization value, $Res Function(_RouteOptimization) _then) =
      __$RouteOptimizationCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String workerId,
      String workerName,
      List<OptimizedShift> shifts,
      double totalDistance,
      double totalTravelTime,
      double efficiencyScore,
      String? recommendations});
}

/// @nodoc
class __$RouteOptimizationCopyWithImpl<$Res>
    implements _$RouteOptimizationCopyWith<$Res> {
  __$RouteOptimizationCopyWithImpl(this._self, this._then);

  final _RouteOptimization _self;
  final $Res Function(_RouteOptimization) _then;

  /// Create a copy of RouteOptimization
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? workerId = null,
    Object? workerName = null,
    Object? shifts = null,
    Object? totalDistance = null,
    Object? totalTravelTime = null,
    Object? efficiencyScore = null,
    Object? recommendations = freezed,
  }) {
    return _then(_RouteOptimization(
      workerId: null == workerId
          ? _self.workerId
          : workerId // ignore: cast_nullable_to_non_nullable
              as String,
      workerName: null == workerName
          ? _self.workerName
          : workerName // ignore: cast_nullable_to_non_nullable
              as String,
      shifts: null == shifts
          ? _self._shifts
          : shifts // ignore: cast_nullable_to_non_nullable
              as List<OptimizedShift>,
      totalDistance: null == totalDistance
          ? _self.totalDistance
          : totalDistance // ignore: cast_nullable_to_non_nullable
              as double,
      totalTravelTime: null == totalTravelTime
          ? _self.totalTravelTime
          : totalTravelTime // ignore: cast_nullable_to_non_nullable
              as double,
      efficiencyScore: null == efficiencyScore
          ? _self.efficiencyScore
          : efficiencyScore // ignore: cast_nullable_to_non_nullable
              as double,
      recommendations: freezed == recommendations
          ? _self.recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$OptimizedShift {
  String get shiftId;
  DateTime get startTime;
  DateTime get endTime;
  String get location;
  double get latitude;
  double get longitude;
  double? get distanceFromPrevious;
  double? get travelTimeFromPrevious;
  int? get sequenceOrder;

  /// Create a copy of OptimizedShift
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $OptimizedShiftCopyWith<OptimizedShift> get copyWith =>
      _$OptimizedShiftCopyWithImpl<OptimizedShift>(
          this as OptimizedShift, _$identity);

  /// Serializes this OptimizedShift to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is OptimizedShift &&
            (identical(other.shiftId, shiftId) || other.shiftId == shiftId) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.distanceFromPrevious, distanceFromPrevious) ||
                other.distanceFromPrevious == distanceFromPrevious) &&
            (identical(other.travelTimeFromPrevious, travelTimeFromPrevious) ||
                other.travelTimeFromPrevious == travelTimeFromPrevious) &&
            (identical(other.sequenceOrder, sequenceOrder) ||
                other.sequenceOrder == sequenceOrder));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      shiftId,
      startTime,
      endTime,
      location,
      latitude,
      longitude,
      distanceFromPrevious,
      travelTimeFromPrevious,
      sequenceOrder);

  @override
  String toString() {
    return 'OptimizedShift(shiftId: $shiftId, startTime: $startTime, endTime: $endTime, location: $location, latitude: $latitude, longitude: $longitude, distanceFromPrevious: $distanceFromPrevious, travelTimeFromPrevious: $travelTimeFromPrevious, sequenceOrder: $sequenceOrder)';
  }
}

/// @nodoc
abstract mixin class $OptimizedShiftCopyWith<$Res> {
  factory $OptimizedShiftCopyWith(
          OptimizedShift value, $Res Function(OptimizedShift) _then) =
      _$OptimizedShiftCopyWithImpl;
  @useResult
  $Res call(
      {String shiftId,
      DateTime startTime,
      DateTime endTime,
      String location,
      double latitude,
      double longitude,
      double? distanceFromPrevious,
      double? travelTimeFromPrevious,
      int? sequenceOrder});
}

/// @nodoc
class _$OptimizedShiftCopyWithImpl<$Res>
    implements $OptimizedShiftCopyWith<$Res> {
  _$OptimizedShiftCopyWithImpl(this._self, this._then);

  final OptimizedShift _self;
  final $Res Function(OptimizedShift) _then;

  /// Create a copy of OptimizedShift
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? shiftId = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? location = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? distanceFromPrevious = freezed,
    Object? travelTimeFromPrevious = freezed,
    Object? sequenceOrder = freezed,
  }) {
    return _then(_self.copyWith(
      shiftId: null == shiftId
          ? _self.shiftId
          : shiftId // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _self.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: null == endTime
          ? _self.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      location: null == location
          ? _self.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: null == latitude
          ? _self.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _self.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      distanceFromPrevious: freezed == distanceFromPrevious
          ? _self.distanceFromPrevious
          : distanceFromPrevious // ignore: cast_nullable_to_non_nullable
              as double?,
      travelTimeFromPrevious: freezed == travelTimeFromPrevious
          ? _self.travelTimeFromPrevious
          : travelTimeFromPrevious // ignore: cast_nullable_to_non_nullable
              as double?,
      sequenceOrder: freezed == sequenceOrder
          ? _self.sequenceOrder
          : sequenceOrder // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// Adds pattern-matching-related methods to [OptimizedShift].
extension OptimizedShiftPatterns on OptimizedShift {
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
    TResult Function(_OptimizedShift value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _OptimizedShift() when $default != null:
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
    TResult Function(_OptimizedShift value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OptimizedShift():
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
    TResult? Function(_OptimizedShift value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OptimizedShift() when $default != null:
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
            String shiftId,
            DateTime startTime,
            DateTime endTime,
            String location,
            double latitude,
            double longitude,
            double? distanceFromPrevious,
            double? travelTimeFromPrevious,
            int? sequenceOrder)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _OptimizedShift() when $default != null:
        return $default(
            _that.shiftId,
            _that.startTime,
            _that.endTime,
            _that.location,
            _that.latitude,
            _that.longitude,
            _that.distanceFromPrevious,
            _that.travelTimeFromPrevious,
            _that.sequenceOrder);
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
            String shiftId,
            DateTime startTime,
            DateTime endTime,
            String location,
            double latitude,
            double longitude,
            double? distanceFromPrevious,
            double? travelTimeFromPrevious,
            int? sequenceOrder)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OptimizedShift():
        return $default(
            _that.shiftId,
            _that.startTime,
            _that.endTime,
            _that.location,
            _that.latitude,
            _that.longitude,
            _that.distanceFromPrevious,
            _that.travelTimeFromPrevious,
            _that.sequenceOrder);
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
            String shiftId,
            DateTime startTime,
            DateTime endTime,
            String location,
            double latitude,
            double longitude,
            double? distanceFromPrevious,
            double? travelTimeFromPrevious,
            int? sequenceOrder)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OptimizedShift() when $default != null:
        return $default(
            _that.shiftId,
            _that.startTime,
            _that.endTime,
            _that.location,
            _that.latitude,
            _that.longitude,
            _that.distanceFromPrevious,
            _that.travelTimeFromPrevious,
            _that.sequenceOrder);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _OptimizedShift implements OptimizedShift {
  const _OptimizedShift(
      {required this.shiftId,
      required this.startTime,
      required this.endTime,
      required this.location,
      required this.latitude,
      required this.longitude,
      this.distanceFromPrevious,
      this.travelTimeFromPrevious,
      this.sequenceOrder});
  factory _OptimizedShift.fromJson(Map<String, dynamic> json) =>
      _$OptimizedShiftFromJson(json);

  @override
  final String shiftId;
  @override
  final DateTime startTime;
  @override
  final DateTime endTime;
  @override
  final String location;
  @override
  final double latitude;
  @override
  final double longitude;
  @override
  final double? distanceFromPrevious;
  @override
  final double? travelTimeFromPrevious;
  @override
  final int? sequenceOrder;

  /// Create a copy of OptimizedShift
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$OptimizedShiftCopyWith<_OptimizedShift> get copyWith =>
      __$OptimizedShiftCopyWithImpl<_OptimizedShift>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$OptimizedShiftToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _OptimizedShift &&
            (identical(other.shiftId, shiftId) || other.shiftId == shiftId) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.distanceFromPrevious, distanceFromPrevious) ||
                other.distanceFromPrevious == distanceFromPrevious) &&
            (identical(other.travelTimeFromPrevious, travelTimeFromPrevious) ||
                other.travelTimeFromPrevious == travelTimeFromPrevious) &&
            (identical(other.sequenceOrder, sequenceOrder) ||
                other.sequenceOrder == sequenceOrder));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      shiftId,
      startTime,
      endTime,
      location,
      latitude,
      longitude,
      distanceFromPrevious,
      travelTimeFromPrevious,
      sequenceOrder);

  @override
  String toString() {
    return 'OptimizedShift(shiftId: $shiftId, startTime: $startTime, endTime: $endTime, location: $location, latitude: $latitude, longitude: $longitude, distanceFromPrevious: $distanceFromPrevious, travelTimeFromPrevious: $travelTimeFromPrevious, sequenceOrder: $sequenceOrder)';
  }
}

/// @nodoc
abstract mixin class _$OptimizedShiftCopyWith<$Res>
    implements $OptimizedShiftCopyWith<$Res> {
  factory _$OptimizedShiftCopyWith(
          _OptimizedShift value, $Res Function(_OptimizedShift) _then) =
      __$OptimizedShiftCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String shiftId,
      DateTime startTime,
      DateTime endTime,
      String location,
      double latitude,
      double longitude,
      double? distanceFromPrevious,
      double? travelTimeFromPrevious,
      int? sequenceOrder});
}

/// @nodoc
class __$OptimizedShiftCopyWithImpl<$Res>
    implements _$OptimizedShiftCopyWith<$Res> {
  __$OptimizedShiftCopyWithImpl(this._self, this._then);

  final _OptimizedShift _self;
  final $Res Function(_OptimizedShift) _then;

  /// Create a copy of OptimizedShift
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? shiftId = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? location = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? distanceFromPrevious = freezed,
    Object? travelTimeFromPrevious = freezed,
    Object? sequenceOrder = freezed,
  }) {
    return _then(_OptimizedShift(
      shiftId: null == shiftId
          ? _self.shiftId
          : shiftId // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _self.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: null == endTime
          ? _self.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      location: null == location
          ? _self.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: null == latitude
          ? _self.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _self.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      distanceFromPrevious: freezed == distanceFromPrevious
          ? _self.distanceFromPrevious
          : distanceFromPrevious // ignore: cast_nullable_to_non_nullable
              as double?,
      travelTimeFromPrevious: freezed == travelTimeFromPrevious
          ? _self.travelTimeFromPrevious
          : travelTimeFromPrevious // ignore: cast_nullable_to_non_nullable
              as double?,
      sequenceOrder: freezed == sequenceOrder
          ? _self.sequenceOrder
          : sequenceOrder // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
mixin _$ScheduleOptimization {
  String get organizationId;
  DateTime get date;
  int get totalShifts;
  int get assignedShifts;
  double get overallEfficiency;
  List<RouteOptimization> get workerRoutes;
  List<String> get warnings;
  String? get summary;

  /// Create a copy of ScheduleOptimization
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ScheduleOptimizationCopyWith<ScheduleOptimization> get copyWith =>
      _$ScheduleOptimizationCopyWithImpl<ScheduleOptimization>(
          this as ScheduleOptimization, _$identity);

  /// Serializes this ScheduleOptimization to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ScheduleOptimization &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.totalShifts, totalShifts) ||
                other.totalShifts == totalShifts) &&
            (identical(other.assignedShifts, assignedShifts) ||
                other.assignedShifts == assignedShifts) &&
            (identical(other.overallEfficiency, overallEfficiency) ||
                other.overallEfficiency == overallEfficiency) &&
            const DeepCollectionEquality()
                .equals(other.workerRoutes, workerRoutes) &&
            const DeepCollectionEquality().equals(other.warnings, warnings) &&
            (identical(other.summary, summary) || other.summary == summary));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      organizationId,
      date,
      totalShifts,
      assignedShifts,
      overallEfficiency,
      const DeepCollectionEquality().hash(workerRoutes),
      const DeepCollectionEquality().hash(warnings),
      summary);

  @override
  String toString() {
    return 'ScheduleOptimization(organizationId: $organizationId, date: $date, totalShifts: $totalShifts, assignedShifts: $assignedShifts, overallEfficiency: $overallEfficiency, workerRoutes: $workerRoutes, warnings: $warnings, summary: $summary)';
  }
}

/// @nodoc
abstract mixin class $ScheduleOptimizationCopyWith<$Res> {
  factory $ScheduleOptimizationCopyWith(ScheduleOptimization value,
          $Res Function(ScheduleOptimization) _then) =
      _$ScheduleOptimizationCopyWithImpl;
  @useResult
  $Res call(
      {String organizationId,
      DateTime date,
      int totalShifts,
      int assignedShifts,
      double overallEfficiency,
      List<RouteOptimization> workerRoutes,
      List<String> warnings,
      String? summary});
}

/// @nodoc
class _$ScheduleOptimizationCopyWithImpl<$Res>
    implements $ScheduleOptimizationCopyWith<$Res> {
  _$ScheduleOptimizationCopyWithImpl(this._self, this._then);

  final ScheduleOptimization _self;
  final $Res Function(ScheduleOptimization) _then;

  /// Create a copy of ScheduleOptimization
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? organizationId = null,
    Object? date = null,
    Object? totalShifts = null,
    Object? assignedShifts = null,
    Object? overallEfficiency = null,
    Object? workerRoutes = null,
    Object? warnings = null,
    Object? summary = freezed,
  }) {
    return _then(_self.copyWith(
      organizationId: null == organizationId
          ? _self.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      totalShifts: null == totalShifts
          ? _self.totalShifts
          : totalShifts // ignore: cast_nullable_to_non_nullable
              as int,
      assignedShifts: null == assignedShifts
          ? _self.assignedShifts
          : assignedShifts // ignore: cast_nullable_to_non_nullable
              as int,
      overallEfficiency: null == overallEfficiency
          ? _self.overallEfficiency
          : overallEfficiency // ignore: cast_nullable_to_non_nullable
              as double,
      workerRoutes: null == workerRoutes
          ? _self.workerRoutes
          : workerRoutes // ignore: cast_nullable_to_non_nullable
              as List<RouteOptimization>,
      warnings: null == warnings
          ? _self.warnings
          : warnings // ignore: cast_nullable_to_non_nullable
              as List<String>,
      summary: freezed == summary
          ? _self.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [ScheduleOptimization].
extension ScheduleOptimizationPatterns on ScheduleOptimization {
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
    TResult Function(_ScheduleOptimization value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ScheduleOptimization() when $default != null:
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
    TResult Function(_ScheduleOptimization value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ScheduleOptimization():
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
    TResult? Function(_ScheduleOptimization value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ScheduleOptimization() when $default != null:
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
            String organizationId,
            DateTime date,
            int totalShifts,
            int assignedShifts,
            double overallEfficiency,
            List<RouteOptimization> workerRoutes,
            List<String> warnings,
            String? summary)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ScheduleOptimization() when $default != null:
        return $default(
            _that.organizationId,
            _that.date,
            _that.totalShifts,
            _that.assignedShifts,
            _that.overallEfficiency,
            _that.workerRoutes,
            _that.warnings,
            _that.summary);
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
            String organizationId,
            DateTime date,
            int totalShifts,
            int assignedShifts,
            double overallEfficiency,
            List<RouteOptimization> workerRoutes,
            List<String> warnings,
            String? summary)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ScheduleOptimization():
        return $default(
            _that.organizationId,
            _that.date,
            _that.totalShifts,
            _that.assignedShifts,
            _that.overallEfficiency,
            _that.workerRoutes,
            _that.warnings,
            _that.summary);
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
            String organizationId,
            DateTime date,
            int totalShifts,
            int assignedShifts,
            double overallEfficiency,
            List<RouteOptimization> workerRoutes,
            List<String> warnings,
            String? summary)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ScheduleOptimization() when $default != null:
        return $default(
            _that.organizationId,
            _that.date,
            _that.totalShifts,
            _that.assignedShifts,
            _that.overallEfficiency,
            _that.workerRoutes,
            _that.warnings,
            _that.summary);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ScheduleOptimization implements ScheduleOptimization {
  const _ScheduleOptimization(
      {required this.organizationId,
      required this.date,
      required this.totalShifts,
      required this.assignedShifts,
      required this.overallEfficiency,
      required final List<RouteOptimization> workerRoutes,
      required final List<String> warnings,
      this.summary})
      : _workerRoutes = workerRoutes,
        _warnings = warnings;
  factory _ScheduleOptimization.fromJson(Map<String, dynamic> json) =>
      _$ScheduleOptimizationFromJson(json);

  @override
  final String organizationId;
  @override
  final DateTime date;
  @override
  final int totalShifts;
  @override
  final int assignedShifts;
  @override
  final double overallEfficiency;
  final List<RouteOptimization> _workerRoutes;
  @override
  List<RouteOptimization> get workerRoutes {
    if (_workerRoutes is EqualUnmodifiableListView) return _workerRoutes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_workerRoutes);
  }

  final List<String> _warnings;
  @override
  List<String> get warnings {
    if (_warnings is EqualUnmodifiableListView) return _warnings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_warnings);
  }

  @override
  final String? summary;

  /// Create a copy of ScheduleOptimization
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ScheduleOptimizationCopyWith<_ScheduleOptimization> get copyWith =>
      __$ScheduleOptimizationCopyWithImpl<_ScheduleOptimization>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ScheduleOptimizationToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ScheduleOptimization &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.totalShifts, totalShifts) ||
                other.totalShifts == totalShifts) &&
            (identical(other.assignedShifts, assignedShifts) ||
                other.assignedShifts == assignedShifts) &&
            (identical(other.overallEfficiency, overallEfficiency) ||
                other.overallEfficiency == overallEfficiency) &&
            const DeepCollectionEquality()
                .equals(other._workerRoutes, _workerRoutes) &&
            const DeepCollectionEquality().equals(other._warnings, _warnings) &&
            (identical(other.summary, summary) || other.summary == summary));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      organizationId,
      date,
      totalShifts,
      assignedShifts,
      overallEfficiency,
      const DeepCollectionEquality().hash(_workerRoutes),
      const DeepCollectionEquality().hash(_warnings),
      summary);

  @override
  String toString() {
    return 'ScheduleOptimization(organizationId: $organizationId, date: $date, totalShifts: $totalShifts, assignedShifts: $assignedShifts, overallEfficiency: $overallEfficiency, workerRoutes: $workerRoutes, warnings: $warnings, summary: $summary)';
  }
}

/// @nodoc
abstract mixin class _$ScheduleOptimizationCopyWith<$Res>
    implements $ScheduleOptimizationCopyWith<$Res> {
  factory _$ScheduleOptimizationCopyWith(_ScheduleOptimization value,
          $Res Function(_ScheduleOptimization) _then) =
      __$ScheduleOptimizationCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String organizationId,
      DateTime date,
      int totalShifts,
      int assignedShifts,
      double overallEfficiency,
      List<RouteOptimization> workerRoutes,
      List<String> warnings,
      String? summary});
}

/// @nodoc
class __$ScheduleOptimizationCopyWithImpl<$Res>
    implements _$ScheduleOptimizationCopyWith<$Res> {
  __$ScheduleOptimizationCopyWithImpl(this._self, this._then);

  final _ScheduleOptimization _self;
  final $Res Function(_ScheduleOptimization) _then;

  /// Create a copy of ScheduleOptimization
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? organizationId = null,
    Object? date = null,
    Object? totalShifts = null,
    Object? assignedShifts = null,
    Object? overallEfficiency = null,
    Object? workerRoutes = null,
    Object? warnings = null,
    Object? summary = freezed,
  }) {
    return _then(_ScheduleOptimization(
      organizationId: null == organizationId
          ? _self.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      totalShifts: null == totalShifts
          ? _self.totalShifts
          : totalShifts // ignore: cast_nullable_to_non_nullable
              as int,
      assignedShifts: null == assignedShifts
          ? _self.assignedShifts
          : assignedShifts // ignore: cast_nullable_to_non_nullable
              as int,
      overallEfficiency: null == overallEfficiency
          ? _self.overallEfficiency
          : overallEfficiency // ignore: cast_nullable_to_non_nullable
              as double,
      workerRoutes: null == workerRoutes
          ? _self._workerRoutes
          : workerRoutes // ignore: cast_nullable_to_non_nullable
              as List<RouteOptimization>,
      warnings: null == warnings
          ? _self._warnings
          : warnings // ignore: cast_nullable_to_non_nullable
              as List<String>,
      summary: freezed == summary
          ? _self.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$NoShowPrediction {
  String get workerId;
  String get shiftId;
  double get probability;
  String get riskLevel;
  List<String> get riskFactors;
  String? get recommendation;

  /// Create a copy of NoShowPrediction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $NoShowPredictionCopyWith<NoShowPrediction> get copyWith =>
      _$NoShowPredictionCopyWithImpl<NoShowPrediction>(
          this as NoShowPrediction, _$identity);

  /// Serializes this NoShowPrediction to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is NoShowPrediction &&
            (identical(other.workerId, workerId) ||
                other.workerId == workerId) &&
            (identical(other.shiftId, shiftId) || other.shiftId == shiftId) &&
            (identical(other.probability, probability) ||
                other.probability == probability) &&
            (identical(other.riskLevel, riskLevel) ||
                other.riskLevel == riskLevel) &&
            const DeepCollectionEquality()
                .equals(other.riskFactors, riskFactors) &&
            (identical(other.recommendation, recommendation) ||
                other.recommendation == recommendation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      workerId,
      shiftId,
      probability,
      riskLevel,
      const DeepCollectionEquality().hash(riskFactors),
      recommendation);

  @override
  String toString() {
    return 'NoShowPrediction(workerId: $workerId, shiftId: $shiftId, probability: $probability, riskLevel: $riskLevel, riskFactors: $riskFactors, recommendation: $recommendation)';
  }
}

/// @nodoc
abstract mixin class $NoShowPredictionCopyWith<$Res> {
  factory $NoShowPredictionCopyWith(
          NoShowPrediction value, $Res Function(NoShowPrediction) _then) =
      _$NoShowPredictionCopyWithImpl;
  @useResult
  $Res call(
      {String workerId,
      String shiftId,
      double probability,
      String riskLevel,
      List<String> riskFactors,
      String? recommendation});
}

/// @nodoc
class _$NoShowPredictionCopyWithImpl<$Res>
    implements $NoShowPredictionCopyWith<$Res> {
  _$NoShowPredictionCopyWithImpl(this._self, this._then);

  final NoShowPrediction _self;
  final $Res Function(NoShowPrediction) _then;

  /// Create a copy of NoShowPrediction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? workerId = null,
    Object? shiftId = null,
    Object? probability = null,
    Object? riskLevel = null,
    Object? riskFactors = null,
    Object? recommendation = freezed,
  }) {
    return _then(_self.copyWith(
      workerId: null == workerId
          ? _self.workerId
          : workerId // ignore: cast_nullable_to_non_nullable
              as String,
      shiftId: null == shiftId
          ? _self.shiftId
          : shiftId // ignore: cast_nullable_to_non_nullable
              as String,
      probability: null == probability
          ? _self.probability
          : probability // ignore: cast_nullable_to_non_nullable
              as double,
      riskLevel: null == riskLevel
          ? _self.riskLevel
          : riskLevel // ignore: cast_nullable_to_non_nullable
              as String,
      riskFactors: null == riskFactors
          ? _self.riskFactors
          : riskFactors // ignore: cast_nullable_to_non_nullable
              as List<String>,
      recommendation: freezed == recommendation
          ? _self.recommendation
          : recommendation // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [NoShowPrediction].
extension NoShowPredictionPatterns on NoShowPrediction {
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
    TResult Function(_NoShowPrediction value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _NoShowPrediction() when $default != null:
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
    TResult Function(_NoShowPrediction value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NoShowPrediction():
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
    TResult? Function(_NoShowPrediction value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NoShowPrediction() when $default != null:
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
    TResult Function(String workerId, String shiftId, double probability,
            String riskLevel, List<String> riskFactors, String? recommendation)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _NoShowPrediction() when $default != null:
        return $default(_that.workerId, _that.shiftId, _that.probability,
            _that.riskLevel, _that.riskFactors, _that.recommendation);
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
    TResult Function(String workerId, String shiftId, double probability,
            String riskLevel, List<String> riskFactors, String? recommendation)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NoShowPrediction():
        return $default(_that.workerId, _that.shiftId, _that.probability,
            _that.riskLevel, _that.riskFactors, _that.recommendation);
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
    TResult? Function(String workerId, String shiftId, double probability,
            String riskLevel, List<String> riskFactors, String? recommendation)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NoShowPrediction() when $default != null:
        return $default(_that.workerId, _that.shiftId, _that.probability,
            _that.riskLevel, _that.riskFactors, _that.recommendation);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _NoShowPrediction implements NoShowPrediction {
  const _NoShowPrediction(
      {required this.workerId,
      required this.shiftId,
      required this.probability,
      required this.riskLevel,
      required final List<String> riskFactors,
      this.recommendation})
      : _riskFactors = riskFactors;
  factory _NoShowPrediction.fromJson(Map<String, dynamic> json) =>
      _$NoShowPredictionFromJson(json);

  @override
  final String workerId;
  @override
  final String shiftId;
  @override
  final double probability;
  @override
  final String riskLevel;
  final List<String> _riskFactors;
  @override
  List<String> get riskFactors {
    if (_riskFactors is EqualUnmodifiableListView) return _riskFactors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_riskFactors);
  }

  @override
  final String? recommendation;

  /// Create a copy of NoShowPrediction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$NoShowPredictionCopyWith<_NoShowPrediction> get copyWith =>
      __$NoShowPredictionCopyWithImpl<_NoShowPrediction>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$NoShowPredictionToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _NoShowPrediction &&
            (identical(other.workerId, workerId) ||
                other.workerId == workerId) &&
            (identical(other.shiftId, shiftId) || other.shiftId == shiftId) &&
            (identical(other.probability, probability) ||
                other.probability == probability) &&
            (identical(other.riskLevel, riskLevel) ||
                other.riskLevel == riskLevel) &&
            const DeepCollectionEquality()
                .equals(other._riskFactors, _riskFactors) &&
            (identical(other.recommendation, recommendation) ||
                other.recommendation == recommendation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      workerId,
      shiftId,
      probability,
      riskLevel,
      const DeepCollectionEquality().hash(_riskFactors),
      recommendation);

  @override
  String toString() {
    return 'NoShowPrediction(workerId: $workerId, shiftId: $shiftId, probability: $probability, riskLevel: $riskLevel, riskFactors: $riskFactors, recommendation: $recommendation)';
  }
}

/// @nodoc
abstract mixin class _$NoShowPredictionCopyWith<$Res>
    implements $NoShowPredictionCopyWith<$Res> {
  factory _$NoShowPredictionCopyWith(
          _NoShowPrediction value, $Res Function(_NoShowPrediction) _then) =
      __$NoShowPredictionCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String workerId,
      String shiftId,
      double probability,
      String riskLevel,
      List<String> riskFactors,
      String? recommendation});
}

/// @nodoc
class __$NoShowPredictionCopyWithImpl<$Res>
    implements _$NoShowPredictionCopyWith<$Res> {
  __$NoShowPredictionCopyWithImpl(this._self, this._then);

  final _NoShowPrediction _self;
  final $Res Function(_NoShowPrediction) _then;

  /// Create a copy of NoShowPrediction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? workerId = null,
    Object? shiftId = null,
    Object? probability = null,
    Object? riskLevel = null,
    Object? riskFactors = null,
    Object? recommendation = freezed,
  }) {
    return _then(_NoShowPrediction(
      workerId: null == workerId
          ? _self.workerId
          : workerId // ignore: cast_nullable_to_non_nullable
              as String,
      shiftId: null == shiftId
          ? _self.shiftId
          : shiftId // ignore: cast_nullable_to_non_nullable
              as String,
      probability: null == probability
          ? _self.probability
          : probability // ignore: cast_nullable_to_non_nullable
              as double,
      riskLevel: null == riskLevel
          ? _self.riskLevel
          : riskLevel // ignore: cast_nullable_to_non_nullable
              as String,
      riskFactors: null == riskFactors
          ? _self._riskFactors
          : riskFactors // ignore: cast_nullable_to_non_nullable
              as List<String>,
      recommendation: freezed == recommendation
          ? _self.recommendation
          : recommendation // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
