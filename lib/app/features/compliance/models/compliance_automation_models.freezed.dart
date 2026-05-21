// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'compliance_automation_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ComplianceScan {
  String get organizationId;
  String get scanDate;
  ComplianceScore get complianceScore;
  List<ComplianceIssue> get issues;
  List<ComplianceIssue> get warnings;
  ComplianceSummary get summary;

  /// Create a copy of ComplianceScan
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ComplianceScanCopyWith<ComplianceScan> get copyWith =>
      _$ComplianceScanCopyWithImpl<ComplianceScan>(
          this as ComplianceScan, _$identity);

  /// Serializes this ComplianceScan to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ComplianceScan &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.scanDate, scanDate) ||
                other.scanDate == scanDate) &&
            (identical(other.complianceScore, complianceScore) ||
                other.complianceScore == complianceScore) &&
            const DeepCollectionEquality().equals(other.issues, issues) &&
            const DeepCollectionEquality().equals(other.warnings, warnings) &&
            (identical(other.summary, summary) || other.summary == summary));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      organizationId,
      scanDate,
      complianceScore,
      const DeepCollectionEquality().hash(issues),
      const DeepCollectionEquality().hash(warnings),
      summary);

  @override
  String toString() {
    return 'ComplianceScan(organizationId: $organizationId, scanDate: $scanDate, complianceScore: $complianceScore, issues: $issues, warnings: $warnings, summary: $summary)';
  }
}

/// @nodoc
abstract mixin class $ComplianceScanCopyWith<$Res> {
  factory $ComplianceScanCopyWith(
          ComplianceScan value, $Res Function(ComplianceScan) _then) =
      _$ComplianceScanCopyWithImpl;
  @useResult
  $Res call(
      {String organizationId,
      String scanDate,
      ComplianceScore complianceScore,
      List<ComplianceIssue> issues,
      List<ComplianceIssue> warnings,
      ComplianceSummary summary});

  $ComplianceScoreCopyWith<$Res> get complianceScore;
  $ComplianceSummaryCopyWith<$Res> get summary;
}

/// @nodoc
class _$ComplianceScanCopyWithImpl<$Res>
    implements $ComplianceScanCopyWith<$Res> {
  _$ComplianceScanCopyWithImpl(this._self, this._then);

  final ComplianceScan _self;
  final $Res Function(ComplianceScan) _then;

  /// Create a copy of ComplianceScan
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? organizationId = null,
    Object? scanDate = null,
    Object? complianceScore = null,
    Object? issues = null,
    Object? warnings = null,
    Object? summary = null,
  }) {
    return _then(_self.copyWith(
      organizationId: null == organizationId
          ? _self.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      scanDate: null == scanDate
          ? _self.scanDate
          : scanDate // ignore: cast_nullable_to_non_nullable
              as String,
      complianceScore: null == complianceScore
          ? _self.complianceScore
          : complianceScore // ignore: cast_nullable_to_non_nullable
              as ComplianceScore,
      issues: null == issues
          ? _self.issues
          : issues // ignore: cast_nullable_to_non_nullable
              as List<ComplianceIssue>,
      warnings: null == warnings
          ? _self.warnings
          : warnings // ignore: cast_nullable_to_non_nullable
              as List<ComplianceIssue>,
      summary: null == summary
          ? _self.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as ComplianceSummary,
    ));
  }

  /// Create a copy of ComplianceScan
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ComplianceScoreCopyWith<$Res> get complianceScore {
    return $ComplianceScoreCopyWith<$Res>(_self.complianceScore, (value) {
      return _then(_self.copyWith(complianceScore: value));
    });
  }

  /// Create a copy of ComplianceScan
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ComplianceSummaryCopyWith<$Res> get summary {
    return $ComplianceSummaryCopyWith<$Res>(_self.summary, (value) {
      return _then(_self.copyWith(summary: value));
    });
  }
}

/// Adds pattern-matching-related methods to [ComplianceScan].
extension ComplianceScanPatterns on ComplianceScan {
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
    TResult Function(_ComplianceScan value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ComplianceScan() when $default != null:
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
    TResult Function(_ComplianceScan value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ComplianceScan():
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
    TResult? Function(_ComplianceScan value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ComplianceScan() when $default != null:
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
            String scanDate,
            ComplianceScore complianceScore,
            List<ComplianceIssue> issues,
            List<ComplianceIssue> warnings,
            ComplianceSummary summary)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ComplianceScan() when $default != null:
        return $default(_that.organizationId, _that.scanDate,
            _that.complianceScore, _that.issues, _that.warnings, _that.summary);
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
            String scanDate,
            ComplianceScore complianceScore,
            List<ComplianceIssue> issues,
            List<ComplianceIssue> warnings,
            ComplianceSummary summary)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ComplianceScan():
        return $default(_that.organizationId, _that.scanDate,
            _that.complianceScore, _that.issues, _that.warnings, _that.summary);
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
            String scanDate,
            ComplianceScore complianceScore,
            List<ComplianceIssue> issues,
            List<ComplianceIssue> warnings,
            ComplianceSummary summary)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ComplianceScan() when $default != null:
        return $default(_that.organizationId, _that.scanDate,
            _that.complianceScore, _that.issues, _that.warnings, _that.summary);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ComplianceScan implements ComplianceScan {
  const _ComplianceScan(
      {required this.organizationId,
      required this.scanDate,
      required this.complianceScore,
      required final List<ComplianceIssue> issues,
      required final List<ComplianceIssue> warnings,
      required this.summary})
      : _issues = issues,
        _warnings = warnings;
  factory _ComplianceScan.fromJson(Map<String, dynamic> json) =>
      _$ComplianceScanFromJson(json);

  @override
  final String organizationId;
  @override
  final String scanDate;
  @override
  final ComplianceScore complianceScore;
  final List<ComplianceIssue> _issues;
  @override
  List<ComplianceIssue> get issues {
    if (_issues is EqualUnmodifiableListView) return _issues;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_issues);
  }

  final List<ComplianceIssue> _warnings;
  @override
  List<ComplianceIssue> get warnings {
    if (_warnings is EqualUnmodifiableListView) return _warnings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_warnings);
  }

  @override
  final ComplianceSummary summary;

  /// Create a copy of ComplianceScan
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ComplianceScanCopyWith<_ComplianceScan> get copyWith =>
      __$ComplianceScanCopyWithImpl<_ComplianceScan>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ComplianceScanToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ComplianceScan &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.scanDate, scanDate) ||
                other.scanDate == scanDate) &&
            (identical(other.complianceScore, complianceScore) ||
                other.complianceScore == complianceScore) &&
            const DeepCollectionEquality().equals(other._issues, _issues) &&
            const DeepCollectionEquality().equals(other._warnings, _warnings) &&
            (identical(other.summary, summary) || other.summary == summary));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      organizationId,
      scanDate,
      complianceScore,
      const DeepCollectionEquality().hash(_issues),
      const DeepCollectionEquality().hash(_warnings),
      summary);

  @override
  String toString() {
    return 'ComplianceScan(organizationId: $organizationId, scanDate: $scanDate, complianceScore: $complianceScore, issues: $issues, warnings: $warnings, summary: $summary)';
  }
}

/// @nodoc
abstract mixin class _$ComplianceScanCopyWith<$Res>
    implements $ComplianceScanCopyWith<$Res> {
  factory _$ComplianceScanCopyWith(
          _ComplianceScan value, $Res Function(_ComplianceScan) _then) =
      __$ComplianceScanCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String organizationId,
      String scanDate,
      ComplianceScore complianceScore,
      List<ComplianceIssue> issues,
      List<ComplianceIssue> warnings,
      ComplianceSummary summary});

  @override
  $ComplianceScoreCopyWith<$Res> get complianceScore;
  @override
  $ComplianceSummaryCopyWith<$Res> get summary;
}

/// @nodoc
class __$ComplianceScanCopyWithImpl<$Res>
    implements _$ComplianceScanCopyWith<$Res> {
  __$ComplianceScanCopyWithImpl(this._self, this._then);

  final _ComplianceScan _self;
  final $Res Function(_ComplianceScan) _then;

  /// Create a copy of ComplianceScan
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? organizationId = null,
    Object? scanDate = null,
    Object? complianceScore = null,
    Object? issues = null,
    Object? warnings = null,
    Object? summary = null,
  }) {
    return _then(_ComplianceScan(
      organizationId: null == organizationId
          ? _self.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      scanDate: null == scanDate
          ? _self.scanDate
          : scanDate // ignore: cast_nullable_to_non_nullable
              as String,
      complianceScore: null == complianceScore
          ? _self.complianceScore
          : complianceScore // ignore: cast_nullable_to_non_nullable
              as ComplianceScore,
      issues: null == issues
          ? _self._issues
          : issues // ignore: cast_nullable_to_non_nullable
              as List<ComplianceIssue>,
      warnings: null == warnings
          ? _self._warnings
          : warnings // ignore: cast_nullable_to_non_nullable
              as List<ComplianceIssue>,
      summary: null == summary
          ? _self.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as ComplianceSummary,
    ));
  }

  /// Create a copy of ComplianceScan
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ComplianceScoreCopyWith<$Res> get complianceScore {
    return $ComplianceScoreCopyWith<$Res>(_self.complianceScore, (value) {
      return _then(_self.copyWith(complianceScore: value));
    });
  }

  /// Create a copy of ComplianceScan
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ComplianceSummaryCopyWith<$Res> get summary {
    return $ComplianceSummaryCopyWith<$Res>(_self.summary, (value) {
      return _then(_self.copyWith(summary: value));
    });
  }
}

/// @nodoc
mixin _$ComplianceScore {
  int get score;
  String get riskLevel;
  ScoreBreakdown get breakdown;

  /// Create a copy of ComplianceScore
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ComplianceScoreCopyWith<ComplianceScore> get copyWith =>
      _$ComplianceScoreCopyWithImpl<ComplianceScore>(
          this as ComplianceScore, _$identity);

  /// Serializes this ComplianceScore to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ComplianceScore &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.riskLevel, riskLevel) ||
                other.riskLevel == riskLevel) &&
            (identical(other.breakdown, breakdown) ||
                other.breakdown == breakdown));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, score, riskLevel, breakdown);

  @override
  String toString() {
    return 'ComplianceScore(score: $score, riskLevel: $riskLevel, breakdown: $breakdown)';
  }
}

/// @nodoc
abstract mixin class $ComplianceScoreCopyWith<$Res> {
  factory $ComplianceScoreCopyWith(
          ComplianceScore value, $Res Function(ComplianceScore) _then) =
      _$ComplianceScoreCopyWithImpl;
  @useResult
  $Res call({int score, String riskLevel, ScoreBreakdown breakdown});

  $ScoreBreakdownCopyWith<$Res> get breakdown;
}

/// @nodoc
class _$ComplianceScoreCopyWithImpl<$Res>
    implements $ComplianceScoreCopyWith<$Res> {
  _$ComplianceScoreCopyWithImpl(this._self, this._then);

  final ComplianceScore _self;
  final $Res Function(ComplianceScore) _then;

  /// Create a copy of ComplianceScore
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? score = null,
    Object? riskLevel = null,
    Object? breakdown = null,
  }) {
    return _then(_self.copyWith(
      score: null == score
          ? _self.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
      riskLevel: null == riskLevel
          ? _self.riskLevel
          : riskLevel // ignore: cast_nullable_to_non_nullable
              as String,
      breakdown: null == breakdown
          ? _self.breakdown
          : breakdown // ignore: cast_nullable_to_non_nullable
              as ScoreBreakdown,
    ));
  }

  /// Create a copy of ComplianceScore
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ScoreBreakdownCopyWith<$Res> get breakdown {
    return $ScoreBreakdownCopyWith<$Res>(_self.breakdown, (value) {
      return _then(_self.copyWith(breakdown: value));
    });
  }
}

/// Adds pattern-matching-related methods to [ComplianceScore].
extension ComplianceScorePatterns on ComplianceScore {
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
    TResult Function(_ComplianceScore value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ComplianceScore() when $default != null:
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
    TResult Function(_ComplianceScore value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ComplianceScore():
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
    TResult? Function(_ComplianceScore value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ComplianceScore() when $default != null:
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
    TResult Function(int score, String riskLevel, ScoreBreakdown breakdown)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ComplianceScore() when $default != null:
        return $default(_that.score, _that.riskLevel, _that.breakdown);
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
    TResult Function(int score, String riskLevel, ScoreBreakdown breakdown)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ComplianceScore():
        return $default(_that.score, _that.riskLevel, _that.breakdown);
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
    TResult? Function(int score, String riskLevel, ScoreBreakdown breakdown)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ComplianceScore() when $default != null:
        return $default(_that.score, _that.riskLevel, _that.breakdown);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ComplianceScore implements ComplianceScore {
  const _ComplianceScore(
      {required this.score, required this.riskLevel, required this.breakdown});
  factory _ComplianceScore.fromJson(Map<String, dynamic> json) =>
      _$ComplianceScoreFromJson(json);

  @override
  final int score;
  @override
  final String riskLevel;
  @override
  final ScoreBreakdown breakdown;

  /// Create a copy of ComplianceScore
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ComplianceScoreCopyWith<_ComplianceScore> get copyWith =>
      __$ComplianceScoreCopyWithImpl<_ComplianceScore>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ComplianceScoreToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ComplianceScore &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.riskLevel, riskLevel) ||
                other.riskLevel == riskLevel) &&
            (identical(other.breakdown, breakdown) ||
                other.breakdown == breakdown));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, score, riskLevel, breakdown);

  @override
  String toString() {
    return 'ComplianceScore(score: $score, riskLevel: $riskLevel, breakdown: $breakdown)';
  }
}

/// @nodoc
abstract mixin class _$ComplianceScoreCopyWith<$Res>
    implements $ComplianceScoreCopyWith<$Res> {
  factory _$ComplianceScoreCopyWith(
          _ComplianceScore value, $Res Function(_ComplianceScore) _then) =
      __$ComplianceScoreCopyWithImpl;
  @override
  @useResult
  $Res call({int score, String riskLevel, ScoreBreakdown breakdown});

  @override
  $ScoreBreakdownCopyWith<$Res> get breakdown;
}

/// @nodoc
class __$ComplianceScoreCopyWithImpl<$Res>
    implements _$ComplianceScoreCopyWith<$Res> {
  __$ComplianceScoreCopyWithImpl(this._self, this._then);

  final _ComplianceScore _self;
  final $Res Function(_ComplianceScore) _then;

  /// Create a copy of ComplianceScore
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? score = null,
    Object? riskLevel = null,
    Object? breakdown = null,
  }) {
    return _then(_ComplianceScore(
      score: null == score
          ? _self.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
      riskLevel: null == riskLevel
          ? _self.riskLevel
          : riskLevel // ignore: cast_nullable_to_non_nullable
              as String,
      breakdown: null == breakdown
          ? _self.breakdown
          : breakdown // ignore: cast_nullable_to_non_nullable
              as ScoreBreakdown,
    ));
  }

  /// Create a copy of ComplianceScore
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ScoreBreakdownCopyWith<$Res> get breakdown {
    return $ScoreBreakdownCopyWith<$Res>(_self.breakdown, (value) {
      return _then(_self.copyWith(breakdown: value));
    });
  }
}

/// @nodoc
mixin _$ScoreBreakdown {
  int get baseScore;
  int get issueDeduction;
  int get warningDeduction;
  int get compliantWorkers;
  int get totalWorkers;
  int get complianceRate;

  /// Create a copy of ScoreBreakdown
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ScoreBreakdownCopyWith<ScoreBreakdown> get copyWith =>
      _$ScoreBreakdownCopyWithImpl<ScoreBreakdown>(
          this as ScoreBreakdown, _$identity);

  /// Serializes this ScoreBreakdown to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ScoreBreakdown &&
            (identical(other.baseScore, baseScore) ||
                other.baseScore == baseScore) &&
            (identical(other.issueDeduction, issueDeduction) ||
                other.issueDeduction == issueDeduction) &&
            (identical(other.warningDeduction, warningDeduction) ||
                other.warningDeduction == warningDeduction) &&
            (identical(other.compliantWorkers, compliantWorkers) ||
                other.compliantWorkers == compliantWorkers) &&
            (identical(other.totalWorkers, totalWorkers) ||
                other.totalWorkers == totalWorkers) &&
            (identical(other.complianceRate, complianceRate) ||
                other.complianceRate == complianceRate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, baseScore, issueDeduction,
      warningDeduction, compliantWorkers, totalWorkers, complianceRate);

  @override
  String toString() {
    return 'ScoreBreakdown(baseScore: $baseScore, issueDeduction: $issueDeduction, warningDeduction: $warningDeduction, compliantWorkers: $compliantWorkers, totalWorkers: $totalWorkers, complianceRate: $complianceRate)';
  }
}

/// @nodoc
abstract mixin class $ScoreBreakdownCopyWith<$Res> {
  factory $ScoreBreakdownCopyWith(
          ScoreBreakdown value, $Res Function(ScoreBreakdown) _then) =
      _$ScoreBreakdownCopyWithImpl;
  @useResult
  $Res call(
      {int baseScore,
      int issueDeduction,
      int warningDeduction,
      int compliantWorkers,
      int totalWorkers,
      int complianceRate});
}

/// @nodoc
class _$ScoreBreakdownCopyWithImpl<$Res>
    implements $ScoreBreakdownCopyWith<$Res> {
  _$ScoreBreakdownCopyWithImpl(this._self, this._then);

  final ScoreBreakdown _self;
  final $Res Function(ScoreBreakdown) _then;

  /// Create a copy of ScoreBreakdown
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? baseScore = null,
    Object? issueDeduction = null,
    Object? warningDeduction = null,
    Object? compliantWorkers = null,
    Object? totalWorkers = null,
    Object? complianceRate = null,
  }) {
    return _then(_self.copyWith(
      baseScore: null == baseScore
          ? _self.baseScore
          : baseScore // ignore: cast_nullable_to_non_nullable
              as int,
      issueDeduction: null == issueDeduction
          ? _self.issueDeduction
          : issueDeduction // ignore: cast_nullable_to_non_nullable
              as int,
      warningDeduction: null == warningDeduction
          ? _self.warningDeduction
          : warningDeduction // ignore: cast_nullable_to_non_nullable
              as int,
      compliantWorkers: null == compliantWorkers
          ? _self.compliantWorkers
          : compliantWorkers // ignore: cast_nullable_to_non_nullable
              as int,
      totalWorkers: null == totalWorkers
          ? _self.totalWorkers
          : totalWorkers // ignore: cast_nullable_to_non_nullable
              as int,
      complianceRate: null == complianceRate
          ? _self.complianceRate
          : complianceRate // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [ScoreBreakdown].
extension ScoreBreakdownPatterns on ScoreBreakdown {
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
    TResult Function(_ScoreBreakdown value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ScoreBreakdown() when $default != null:
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
    TResult Function(_ScoreBreakdown value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ScoreBreakdown():
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
    TResult? Function(_ScoreBreakdown value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ScoreBreakdown() when $default != null:
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
    TResult Function(int baseScore, int issueDeduction, int warningDeduction,
            int compliantWorkers, int totalWorkers, int complianceRate)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ScoreBreakdown() when $default != null:
        return $default(
            _that.baseScore,
            _that.issueDeduction,
            _that.warningDeduction,
            _that.compliantWorkers,
            _that.totalWorkers,
            _that.complianceRate);
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
    TResult Function(int baseScore, int issueDeduction, int warningDeduction,
            int compliantWorkers, int totalWorkers, int complianceRate)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ScoreBreakdown():
        return $default(
            _that.baseScore,
            _that.issueDeduction,
            _that.warningDeduction,
            _that.compliantWorkers,
            _that.totalWorkers,
            _that.complianceRate);
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
    TResult? Function(int baseScore, int issueDeduction, int warningDeduction,
            int compliantWorkers, int totalWorkers, int complianceRate)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ScoreBreakdown() when $default != null:
        return $default(
            _that.baseScore,
            _that.issueDeduction,
            _that.warningDeduction,
            _that.compliantWorkers,
            _that.totalWorkers,
            _that.complianceRate);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ScoreBreakdown implements ScoreBreakdown {
  const _ScoreBreakdown(
      {required this.baseScore,
      required this.issueDeduction,
      required this.warningDeduction,
      required this.compliantWorkers,
      required this.totalWorkers,
      required this.complianceRate});
  factory _ScoreBreakdown.fromJson(Map<String, dynamic> json) =>
      _$ScoreBreakdownFromJson(json);

  @override
  final int baseScore;
  @override
  final int issueDeduction;
  @override
  final int warningDeduction;
  @override
  final int compliantWorkers;
  @override
  final int totalWorkers;
  @override
  final int complianceRate;

  /// Create a copy of ScoreBreakdown
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ScoreBreakdownCopyWith<_ScoreBreakdown> get copyWith =>
      __$ScoreBreakdownCopyWithImpl<_ScoreBreakdown>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ScoreBreakdownToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ScoreBreakdown &&
            (identical(other.baseScore, baseScore) ||
                other.baseScore == baseScore) &&
            (identical(other.issueDeduction, issueDeduction) ||
                other.issueDeduction == issueDeduction) &&
            (identical(other.warningDeduction, warningDeduction) ||
                other.warningDeduction == warningDeduction) &&
            (identical(other.compliantWorkers, compliantWorkers) ||
                other.compliantWorkers == compliantWorkers) &&
            (identical(other.totalWorkers, totalWorkers) ||
                other.totalWorkers == totalWorkers) &&
            (identical(other.complianceRate, complianceRate) ||
                other.complianceRate == complianceRate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, baseScore, issueDeduction,
      warningDeduction, compliantWorkers, totalWorkers, complianceRate);

  @override
  String toString() {
    return 'ScoreBreakdown(baseScore: $baseScore, issueDeduction: $issueDeduction, warningDeduction: $warningDeduction, compliantWorkers: $compliantWorkers, totalWorkers: $totalWorkers, complianceRate: $complianceRate)';
  }
}

/// @nodoc
abstract mixin class _$ScoreBreakdownCopyWith<$Res>
    implements $ScoreBreakdownCopyWith<$Res> {
  factory _$ScoreBreakdownCopyWith(
          _ScoreBreakdown value, $Res Function(_ScoreBreakdown) _then) =
      __$ScoreBreakdownCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int baseScore,
      int issueDeduction,
      int warningDeduction,
      int compliantWorkers,
      int totalWorkers,
      int complianceRate});
}

/// @nodoc
class __$ScoreBreakdownCopyWithImpl<$Res>
    implements _$ScoreBreakdownCopyWith<$Res> {
  __$ScoreBreakdownCopyWithImpl(this._self, this._then);

  final _ScoreBreakdown _self;
  final $Res Function(_ScoreBreakdown) _then;

  /// Create a copy of ScoreBreakdown
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? baseScore = null,
    Object? issueDeduction = null,
    Object? warningDeduction = null,
    Object? compliantWorkers = null,
    Object? totalWorkers = null,
    Object? complianceRate = null,
  }) {
    return _then(_ScoreBreakdown(
      baseScore: null == baseScore
          ? _self.baseScore
          : baseScore // ignore: cast_nullable_to_non_nullable
              as int,
      issueDeduction: null == issueDeduction
          ? _self.issueDeduction
          : issueDeduction // ignore: cast_nullable_to_non_nullable
              as int,
      warningDeduction: null == warningDeduction
          ? _self.warningDeduction
          : warningDeduction // ignore: cast_nullable_to_non_nullable
              as int,
      compliantWorkers: null == compliantWorkers
          ? _self.compliantWorkers
          : compliantWorkers // ignore: cast_nullable_to_non_nullable
              as int,
      totalWorkers: null == totalWorkers
          ? _self.totalWorkers
          : totalWorkers // ignore: cast_nullable_to_non_nullable
              as int,
      complianceRate: null == complianceRate
          ? _self.complianceRate
          : complianceRate // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$ComplianceIssue {
  String get type;
  int get count;
  String get message;
  String get severity;

  /// Create a copy of ComplianceIssue
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ComplianceIssueCopyWith<ComplianceIssue> get copyWith =>
      _$ComplianceIssueCopyWithImpl<ComplianceIssue>(
          this as ComplianceIssue, _$identity);

  /// Serializes this ComplianceIssue to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ComplianceIssue &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.severity, severity) ||
                other.severity == severity));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, type, count, message, severity);

  @override
  String toString() {
    return 'ComplianceIssue(type: $type, count: $count, message: $message, severity: $severity)';
  }
}

/// @nodoc
abstract mixin class $ComplianceIssueCopyWith<$Res> {
  factory $ComplianceIssueCopyWith(
          ComplianceIssue value, $Res Function(ComplianceIssue) _then) =
      _$ComplianceIssueCopyWithImpl;
  @useResult
  $Res call({String type, int count, String message, String severity});
}

/// @nodoc
class _$ComplianceIssueCopyWithImpl<$Res>
    implements $ComplianceIssueCopyWith<$Res> {
  _$ComplianceIssueCopyWithImpl(this._self, this._then);

  final ComplianceIssue _self;
  final $Res Function(ComplianceIssue) _then;

  /// Create a copy of ComplianceIssue
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? count = null,
    Object? message = null,
    Object? severity = null,
  }) {
    return _then(_self.copyWith(
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      count: null == count
          ? _self.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      severity: null == severity
          ? _self.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [ComplianceIssue].
extension ComplianceIssuePatterns on ComplianceIssue {
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
    TResult Function(_ComplianceIssue value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ComplianceIssue() when $default != null:
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
    TResult Function(_ComplianceIssue value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ComplianceIssue():
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
    TResult? Function(_ComplianceIssue value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ComplianceIssue() when $default != null:
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
    TResult Function(String type, int count, String message, String severity)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ComplianceIssue() when $default != null:
        return $default(_that.type, _that.count, _that.message, _that.severity);
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
    TResult Function(String type, int count, String message, String severity)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ComplianceIssue():
        return $default(_that.type, _that.count, _that.message, _that.severity);
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
    TResult? Function(String type, int count, String message, String severity)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ComplianceIssue() when $default != null:
        return $default(_that.type, _that.count, _that.message, _that.severity);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ComplianceIssue implements ComplianceIssue {
  const _ComplianceIssue(
      {required this.type,
      required this.count,
      required this.message,
      required this.severity});
  factory _ComplianceIssue.fromJson(Map<String, dynamic> json) =>
      _$ComplianceIssueFromJson(json);

  @override
  final String type;
  @override
  final int count;
  @override
  final String message;
  @override
  final String severity;

  /// Create a copy of ComplianceIssue
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ComplianceIssueCopyWith<_ComplianceIssue> get copyWith =>
      __$ComplianceIssueCopyWithImpl<_ComplianceIssue>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ComplianceIssueToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ComplianceIssue &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.severity, severity) ||
                other.severity == severity));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, type, count, message, severity);

  @override
  String toString() {
    return 'ComplianceIssue(type: $type, count: $count, message: $message, severity: $severity)';
  }
}

/// @nodoc
abstract mixin class _$ComplianceIssueCopyWith<$Res>
    implements $ComplianceIssueCopyWith<$Res> {
  factory _$ComplianceIssueCopyWith(
          _ComplianceIssue value, $Res Function(_ComplianceIssue) _then) =
      __$ComplianceIssueCopyWithImpl;
  @override
  @useResult
  $Res call({String type, int count, String message, String severity});
}

/// @nodoc
class __$ComplianceIssueCopyWithImpl<$Res>
    implements _$ComplianceIssueCopyWith<$Res> {
  __$ComplianceIssueCopyWithImpl(this._self, this._then);

  final _ComplianceIssue _self;
  final $Res Function(_ComplianceIssue) _then;

  /// Create a copy of ComplianceIssue
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? type = null,
    Object? count = null,
    Object? message = null,
    Object? severity = null,
  }) {
    return _then(_ComplianceIssue(
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      count: null == count
          ? _self.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      severity: null == severity
          ? _self.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$ComplianceSummary {
  int get totalIssues;
  int get totalWarnings;
  int get criticalCount;
  int get highCount;
  int get mediumCount;

  /// Create a copy of ComplianceSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ComplianceSummaryCopyWith<ComplianceSummary> get copyWith =>
      _$ComplianceSummaryCopyWithImpl<ComplianceSummary>(
          this as ComplianceSummary, _$identity);

  /// Serializes this ComplianceSummary to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ComplianceSummary &&
            (identical(other.totalIssues, totalIssues) ||
                other.totalIssues == totalIssues) &&
            (identical(other.totalWarnings, totalWarnings) ||
                other.totalWarnings == totalWarnings) &&
            (identical(other.criticalCount, criticalCount) ||
                other.criticalCount == criticalCount) &&
            (identical(other.highCount, highCount) ||
                other.highCount == highCount) &&
            (identical(other.mediumCount, mediumCount) ||
                other.mediumCount == mediumCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, totalIssues, totalWarnings,
      criticalCount, highCount, mediumCount);

  @override
  String toString() {
    return 'ComplianceSummary(totalIssues: $totalIssues, totalWarnings: $totalWarnings, criticalCount: $criticalCount, highCount: $highCount, mediumCount: $mediumCount)';
  }
}

/// @nodoc
abstract mixin class $ComplianceSummaryCopyWith<$Res> {
  factory $ComplianceSummaryCopyWith(
          ComplianceSummary value, $Res Function(ComplianceSummary) _then) =
      _$ComplianceSummaryCopyWithImpl;
  @useResult
  $Res call(
      {int totalIssues,
      int totalWarnings,
      int criticalCount,
      int highCount,
      int mediumCount});
}

/// @nodoc
class _$ComplianceSummaryCopyWithImpl<$Res>
    implements $ComplianceSummaryCopyWith<$Res> {
  _$ComplianceSummaryCopyWithImpl(this._self, this._then);

  final ComplianceSummary _self;
  final $Res Function(ComplianceSummary) _then;

  /// Create a copy of ComplianceSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalIssues = null,
    Object? totalWarnings = null,
    Object? criticalCount = null,
    Object? highCount = null,
    Object? mediumCount = null,
  }) {
    return _then(_self.copyWith(
      totalIssues: null == totalIssues
          ? _self.totalIssues
          : totalIssues // ignore: cast_nullable_to_non_nullable
              as int,
      totalWarnings: null == totalWarnings
          ? _self.totalWarnings
          : totalWarnings // ignore: cast_nullable_to_non_nullable
              as int,
      criticalCount: null == criticalCount
          ? _self.criticalCount
          : criticalCount // ignore: cast_nullable_to_non_nullable
              as int,
      highCount: null == highCount
          ? _self.highCount
          : highCount // ignore: cast_nullable_to_non_nullable
              as int,
      mediumCount: null == mediumCount
          ? _self.mediumCount
          : mediumCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [ComplianceSummary].
extension ComplianceSummaryPatterns on ComplianceSummary {
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
    TResult Function(_ComplianceSummary value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ComplianceSummary() when $default != null:
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
    TResult Function(_ComplianceSummary value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ComplianceSummary():
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
    TResult? Function(_ComplianceSummary value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ComplianceSummary() when $default != null:
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
    TResult Function(int totalIssues, int totalWarnings, int criticalCount,
            int highCount, int mediumCount)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ComplianceSummary() when $default != null:
        return $default(_that.totalIssues, _that.totalWarnings,
            _that.criticalCount, _that.highCount, _that.mediumCount);
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
    TResult Function(int totalIssues, int totalWarnings, int criticalCount,
            int highCount, int mediumCount)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ComplianceSummary():
        return $default(_that.totalIssues, _that.totalWarnings,
            _that.criticalCount, _that.highCount, _that.mediumCount);
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
    TResult? Function(int totalIssues, int totalWarnings, int criticalCount,
            int highCount, int mediumCount)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ComplianceSummary() when $default != null:
        return $default(_that.totalIssues, _that.totalWarnings,
            _that.criticalCount, _that.highCount, _that.mediumCount);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ComplianceSummary implements ComplianceSummary {
  const _ComplianceSummary(
      {required this.totalIssues,
      required this.totalWarnings,
      required this.criticalCount,
      required this.highCount,
      required this.mediumCount});
  factory _ComplianceSummary.fromJson(Map<String, dynamic> json) =>
      _$ComplianceSummaryFromJson(json);

  @override
  final int totalIssues;
  @override
  final int totalWarnings;
  @override
  final int criticalCount;
  @override
  final int highCount;
  @override
  final int mediumCount;

  /// Create a copy of ComplianceSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ComplianceSummaryCopyWith<_ComplianceSummary> get copyWith =>
      __$ComplianceSummaryCopyWithImpl<_ComplianceSummary>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ComplianceSummaryToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ComplianceSummary &&
            (identical(other.totalIssues, totalIssues) ||
                other.totalIssues == totalIssues) &&
            (identical(other.totalWarnings, totalWarnings) ||
                other.totalWarnings == totalWarnings) &&
            (identical(other.criticalCount, criticalCount) ||
                other.criticalCount == criticalCount) &&
            (identical(other.highCount, highCount) ||
                other.highCount == highCount) &&
            (identical(other.mediumCount, mediumCount) ||
                other.mediumCount == mediumCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, totalIssues, totalWarnings,
      criticalCount, highCount, mediumCount);

  @override
  String toString() {
    return 'ComplianceSummary(totalIssues: $totalIssues, totalWarnings: $totalWarnings, criticalCount: $criticalCount, highCount: $highCount, mediumCount: $mediumCount)';
  }
}

/// @nodoc
abstract mixin class _$ComplianceSummaryCopyWith<$Res>
    implements $ComplianceSummaryCopyWith<$Res> {
  factory _$ComplianceSummaryCopyWith(
          _ComplianceSummary value, $Res Function(_ComplianceSummary) _then) =
      __$ComplianceSummaryCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int totalIssues,
      int totalWarnings,
      int criticalCount,
      int highCount,
      int mediumCount});
}

/// @nodoc
class __$ComplianceSummaryCopyWithImpl<$Res>
    implements _$ComplianceSummaryCopyWith<$Res> {
  __$ComplianceSummaryCopyWithImpl(this._self, this._then);

  final _ComplianceSummary _self;
  final $Res Function(_ComplianceSummary) _then;

  /// Create a copy of ComplianceSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? totalIssues = null,
    Object? totalWarnings = null,
    Object? criticalCount = null,
    Object? highCount = null,
    Object? mediumCount = null,
  }) {
    return _then(_ComplianceSummary(
      totalIssues: null == totalIssues
          ? _self.totalIssues
          : totalIssues // ignore: cast_nullable_to_non_nullable
              as int,
      totalWarnings: null == totalWarnings
          ? _self.totalWarnings
          : totalWarnings // ignore: cast_nullable_to_non_nullable
              as int,
      criticalCount: null == criticalCount
          ? _self.criticalCount
          : criticalCount // ignore: cast_nullable_to_non_nullable
              as int,
      highCount: null == highCount
          ? _self.highCount
          : highCount // ignore: cast_nullable_to_non_nullable
              as int,
      mediumCount: null == mediumCount
          ? _self.mediumCount
          : mediumCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$ExpiringDocument {
  String get workerId;
  String get workerName;
  String get documentType;
  String get expiryDate;
  int get daysUntilExpiry;
  String get severity;

  /// Create a copy of ExpiringDocument
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ExpiringDocumentCopyWith<ExpiringDocument> get copyWith =>
      _$ExpiringDocumentCopyWithImpl<ExpiringDocument>(
          this as ExpiringDocument, _$identity);

  /// Serializes this ExpiringDocument to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ExpiringDocument &&
            (identical(other.workerId, workerId) ||
                other.workerId == workerId) &&
            (identical(other.workerName, workerName) ||
                other.workerName == workerName) &&
            (identical(other.documentType, documentType) ||
                other.documentType == documentType) &&
            (identical(other.expiryDate, expiryDate) ||
                other.expiryDate == expiryDate) &&
            (identical(other.daysUntilExpiry, daysUntilExpiry) ||
                other.daysUntilExpiry == daysUntilExpiry) &&
            (identical(other.severity, severity) ||
                other.severity == severity));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, workerId, workerName,
      documentType, expiryDate, daysUntilExpiry, severity);

  @override
  String toString() {
    return 'ExpiringDocument(workerId: $workerId, workerName: $workerName, documentType: $documentType, expiryDate: $expiryDate, daysUntilExpiry: $daysUntilExpiry, severity: $severity)';
  }
}

/// @nodoc
abstract mixin class $ExpiringDocumentCopyWith<$Res> {
  factory $ExpiringDocumentCopyWith(
          ExpiringDocument value, $Res Function(ExpiringDocument) _then) =
      _$ExpiringDocumentCopyWithImpl;
  @useResult
  $Res call(
      {String workerId,
      String workerName,
      String documentType,
      String expiryDate,
      int daysUntilExpiry,
      String severity});
}

/// @nodoc
class _$ExpiringDocumentCopyWithImpl<$Res>
    implements $ExpiringDocumentCopyWith<$Res> {
  _$ExpiringDocumentCopyWithImpl(this._self, this._then);

  final ExpiringDocument _self;
  final $Res Function(ExpiringDocument) _then;

  /// Create a copy of ExpiringDocument
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? workerId = null,
    Object? workerName = null,
    Object? documentType = null,
    Object? expiryDate = null,
    Object? daysUntilExpiry = null,
    Object? severity = null,
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
      documentType: null == documentType
          ? _self.documentType
          : documentType // ignore: cast_nullable_to_non_nullable
              as String,
      expiryDate: null == expiryDate
          ? _self.expiryDate
          : expiryDate // ignore: cast_nullable_to_non_nullable
              as String,
      daysUntilExpiry: null == daysUntilExpiry
          ? _self.daysUntilExpiry
          : daysUntilExpiry // ignore: cast_nullable_to_non_nullable
              as int,
      severity: null == severity
          ? _self.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [ExpiringDocument].
extension ExpiringDocumentPatterns on ExpiringDocument {
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
    TResult Function(_ExpiringDocument value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ExpiringDocument() when $default != null:
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
    TResult Function(_ExpiringDocument value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExpiringDocument():
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
    TResult? Function(_ExpiringDocument value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExpiringDocument() when $default != null:
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
    TResult Function(String workerId, String workerName, String documentType,
            String expiryDate, int daysUntilExpiry, String severity)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ExpiringDocument() when $default != null:
        return $default(_that.workerId, _that.workerName, _that.documentType,
            _that.expiryDate, _that.daysUntilExpiry, _that.severity);
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
    TResult Function(String workerId, String workerName, String documentType,
            String expiryDate, int daysUntilExpiry, String severity)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExpiringDocument():
        return $default(_that.workerId, _that.workerName, _that.documentType,
            _that.expiryDate, _that.daysUntilExpiry, _that.severity);
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
    TResult? Function(String workerId, String workerName, String documentType,
            String expiryDate, int daysUntilExpiry, String severity)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExpiringDocument() when $default != null:
        return $default(_that.workerId, _that.workerName, _that.documentType,
            _that.expiryDate, _that.daysUntilExpiry, _that.severity);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ExpiringDocument implements ExpiringDocument {
  const _ExpiringDocument(
      {required this.workerId,
      required this.workerName,
      required this.documentType,
      required this.expiryDate,
      required this.daysUntilExpiry,
      required this.severity});
  factory _ExpiringDocument.fromJson(Map<String, dynamic> json) =>
      _$ExpiringDocumentFromJson(json);

  @override
  final String workerId;
  @override
  final String workerName;
  @override
  final String documentType;
  @override
  final String expiryDate;
  @override
  final int daysUntilExpiry;
  @override
  final String severity;

  /// Create a copy of ExpiringDocument
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ExpiringDocumentCopyWith<_ExpiringDocument> get copyWith =>
      __$ExpiringDocumentCopyWithImpl<_ExpiringDocument>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ExpiringDocumentToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ExpiringDocument &&
            (identical(other.workerId, workerId) ||
                other.workerId == workerId) &&
            (identical(other.workerName, workerName) ||
                other.workerName == workerName) &&
            (identical(other.documentType, documentType) ||
                other.documentType == documentType) &&
            (identical(other.expiryDate, expiryDate) ||
                other.expiryDate == expiryDate) &&
            (identical(other.daysUntilExpiry, daysUntilExpiry) ||
                other.daysUntilExpiry == daysUntilExpiry) &&
            (identical(other.severity, severity) ||
                other.severity == severity));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, workerId, workerName,
      documentType, expiryDate, daysUntilExpiry, severity);

  @override
  String toString() {
    return 'ExpiringDocument(workerId: $workerId, workerName: $workerName, documentType: $documentType, expiryDate: $expiryDate, daysUntilExpiry: $daysUntilExpiry, severity: $severity)';
  }
}

/// @nodoc
abstract mixin class _$ExpiringDocumentCopyWith<$Res>
    implements $ExpiringDocumentCopyWith<$Res> {
  factory _$ExpiringDocumentCopyWith(
          _ExpiringDocument value, $Res Function(_ExpiringDocument) _then) =
      __$ExpiringDocumentCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String workerId,
      String workerName,
      String documentType,
      String expiryDate,
      int daysUntilExpiry,
      String severity});
}

/// @nodoc
class __$ExpiringDocumentCopyWithImpl<$Res>
    implements _$ExpiringDocumentCopyWith<$Res> {
  __$ExpiringDocumentCopyWithImpl(this._self, this._then);

  final _ExpiringDocument _self;
  final $Res Function(_ExpiringDocument) _then;

  /// Create a copy of ExpiringDocument
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? workerId = null,
    Object? workerName = null,
    Object? documentType = null,
    Object? expiryDate = null,
    Object? daysUntilExpiry = null,
    Object? severity = null,
  }) {
    return _then(_ExpiringDocument(
      workerId: null == workerId
          ? _self.workerId
          : workerId // ignore: cast_nullable_to_non_nullable
              as String,
      workerName: null == workerName
          ? _self.workerName
          : workerName // ignore: cast_nullable_to_non_nullable
              as String,
      documentType: null == documentType
          ? _self.documentType
          : documentType // ignore: cast_nullable_to_non_nullable
              as String,
      expiryDate: null == expiryDate
          ? _self.expiryDate
          : expiryDate // ignore: cast_nullable_to_non_nullable
              as String,
      daysUntilExpiry: null == daysUntilExpiry
          ? _self.daysUntilExpiry
          : daysUntilExpiry // ignore: cast_nullable_to_non_nullable
              as int,
      severity: null == severity
          ? _self.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$ComplianceAlert {
  String get alertId;
  String get type;
  String get message;
  String get severity;
  String get createdAt;
  String? get sentDate;
  String? get status;

  /// Create a copy of ComplianceAlert
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ComplianceAlertCopyWith<ComplianceAlert> get copyWith =>
      _$ComplianceAlertCopyWithImpl<ComplianceAlert>(
          this as ComplianceAlert, _$identity);

  /// Serializes this ComplianceAlert to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ComplianceAlert &&
            (identical(other.alertId, alertId) || other.alertId == alertId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.severity, severity) ||
                other.severity == severity) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.sentDate, sentDate) ||
                other.sentDate == sentDate) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, alertId, type, message, severity,
      createdAt, sentDate, status);

  @override
  String toString() {
    return 'ComplianceAlert(alertId: $alertId, type: $type, message: $message, severity: $severity, createdAt: $createdAt, sentDate: $sentDate, status: $status)';
  }
}

/// @nodoc
abstract mixin class $ComplianceAlertCopyWith<$Res> {
  factory $ComplianceAlertCopyWith(
          ComplianceAlert value, $Res Function(ComplianceAlert) _then) =
      _$ComplianceAlertCopyWithImpl;
  @useResult
  $Res call(
      {String alertId,
      String type,
      String message,
      String severity,
      String createdAt,
      String? sentDate,
      String? status});
}

/// @nodoc
class _$ComplianceAlertCopyWithImpl<$Res>
    implements $ComplianceAlertCopyWith<$Res> {
  _$ComplianceAlertCopyWithImpl(this._self, this._then);

  final ComplianceAlert _self;
  final $Res Function(ComplianceAlert) _then;

  /// Create a copy of ComplianceAlert
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? alertId = null,
    Object? type = null,
    Object? message = null,
    Object? severity = null,
    Object? createdAt = null,
    Object? sentDate = freezed,
    Object? status = freezed,
  }) {
    return _then(_self.copyWith(
      alertId: null == alertId
          ? _self.alertId
          : alertId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      severity: null == severity
          ? _self.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      sentDate: freezed == sentDate
          ? _self.sentDate
          : sentDate // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [ComplianceAlert].
extension ComplianceAlertPatterns on ComplianceAlert {
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
    TResult Function(_ComplianceAlert value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ComplianceAlert() when $default != null:
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
    TResult Function(_ComplianceAlert value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ComplianceAlert():
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
    TResult? Function(_ComplianceAlert value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ComplianceAlert() when $default != null:
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
            String alertId,
            String type,
            String message,
            String severity,
            String createdAt,
            String? sentDate,
            String? status)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ComplianceAlert() when $default != null:
        return $default(_that.alertId, _that.type, _that.message,
            _that.severity, _that.createdAt, _that.sentDate, _that.status);
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
    TResult Function(String alertId, String type, String message,
            String severity, String createdAt, String? sentDate, String? status)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ComplianceAlert():
        return $default(_that.alertId, _that.type, _that.message,
            _that.severity, _that.createdAt, _that.sentDate, _that.status);
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
            String alertId,
            String type,
            String message,
            String severity,
            String createdAt,
            String? sentDate,
            String? status)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ComplianceAlert() when $default != null:
        return $default(_that.alertId, _that.type, _that.message,
            _that.severity, _that.createdAt, _that.sentDate, _that.status);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ComplianceAlert implements ComplianceAlert {
  const _ComplianceAlert(
      {required this.alertId,
      required this.type,
      required this.message,
      required this.severity,
      required this.createdAt,
      this.sentDate,
      this.status});
  factory _ComplianceAlert.fromJson(Map<String, dynamic> json) =>
      _$ComplianceAlertFromJson(json);

  @override
  final String alertId;
  @override
  final String type;
  @override
  final String message;
  @override
  final String severity;
  @override
  final String createdAt;
  @override
  final String? sentDate;
  @override
  final String? status;

  /// Create a copy of ComplianceAlert
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ComplianceAlertCopyWith<_ComplianceAlert> get copyWith =>
      __$ComplianceAlertCopyWithImpl<_ComplianceAlert>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ComplianceAlertToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ComplianceAlert &&
            (identical(other.alertId, alertId) || other.alertId == alertId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.severity, severity) ||
                other.severity == severity) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.sentDate, sentDate) ||
                other.sentDate == sentDate) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, alertId, type, message, severity,
      createdAt, sentDate, status);

  @override
  String toString() {
    return 'ComplianceAlert(alertId: $alertId, type: $type, message: $message, severity: $severity, createdAt: $createdAt, sentDate: $sentDate, status: $status)';
  }
}

/// @nodoc
abstract mixin class _$ComplianceAlertCopyWith<$Res>
    implements $ComplianceAlertCopyWith<$Res> {
  factory _$ComplianceAlertCopyWith(
          _ComplianceAlert value, $Res Function(_ComplianceAlert) _then) =
      __$ComplianceAlertCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String alertId,
      String type,
      String message,
      String severity,
      String createdAt,
      String? sentDate,
      String? status});
}

/// @nodoc
class __$ComplianceAlertCopyWithImpl<$Res>
    implements _$ComplianceAlertCopyWith<$Res> {
  __$ComplianceAlertCopyWithImpl(this._self, this._then);

  final _ComplianceAlert _self;
  final $Res Function(_ComplianceAlert) _then;

  /// Create a copy of ComplianceAlert
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? alertId = null,
    Object? type = null,
    Object? message = null,
    Object? severity = null,
    Object? createdAt = null,
    Object? sentDate = freezed,
    Object? status = freezed,
  }) {
    return _then(_ComplianceAlert(
      alertId: null == alertId
          ? _self.alertId
          : alertId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      severity: null == severity
          ? _self.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      sentDate: freezed == sentDate
          ? _self.sentDate
          : sentDate // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$ComplianceReport {
  String get reportId;
  String get organizationId;
  String get reportType;
  String get generatedDate;
  ComplianceScore get complianceScore;
  ComplianceSummary get summary;
  List<ExpiringDocument> get expiringDocuments;
  List<ComplianceRecommendation> get recommendations;
  List<ComplianceIssue>? get issues;
  List<ComplianceIssue>? get warnings;
  AuditTrail? get auditTrail;

  /// Create a copy of ComplianceReport
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ComplianceReportCopyWith<ComplianceReport> get copyWith =>
      _$ComplianceReportCopyWithImpl<ComplianceReport>(
          this as ComplianceReport, _$identity);

  /// Serializes this ComplianceReport to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ComplianceReport &&
            (identical(other.reportId, reportId) ||
                other.reportId == reportId) &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.reportType, reportType) ||
                other.reportType == reportType) &&
            (identical(other.generatedDate, generatedDate) ||
                other.generatedDate == generatedDate) &&
            (identical(other.complianceScore, complianceScore) ||
                other.complianceScore == complianceScore) &&
            (identical(other.summary, summary) || other.summary == summary) &&
            const DeepCollectionEquality()
                .equals(other.expiringDocuments, expiringDocuments) &&
            const DeepCollectionEquality()
                .equals(other.recommendations, recommendations) &&
            const DeepCollectionEquality().equals(other.issues, issues) &&
            const DeepCollectionEquality().equals(other.warnings, warnings) &&
            (identical(other.auditTrail, auditTrail) ||
                other.auditTrail == auditTrail));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      reportId,
      organizationId,
      reportType,
      generatedDate,
      complianceScore,
      summary,
      const DeepCollectionEquality().hash(expiringDocuments),
      const DeepCollectionEquality().hash(recommendations),
      const DeepCollectionEquality().hash(issues),
      const DeepCollectionEquality().hash(warnings),
      auditTrail);

  @override
  String toString() {
    return 'ComplianceReport(reportId: $reportId, organizationId: $organizationId, reportType: $reportType, generatedDate: $generatedDate, complianceScore: $complianceScore, summary: $summary, expiringDocuments: $expiringDocuments, recommendations: $recommendations, issues: $issues, warnings: $warnings, auditTrail: $auditTrail)';
  }
}

/// @nodoc
abstract mixin class $ComplianceReportCopyWith<$Res> {
  factory $ComplianceReportCopyWith(
          ComplianceReport value, $Res Function(ComplianceReport) _then) =
      _$ComplianceReportCopyWithImpl;
  @useResult
  $Res call(
      {String reportId,
      String organizationId,
      String reportType,
      String generatedDate,
      ComplianceScore complianceScore,
      ComplianceSummary summary,
      List<ExpiringDocument> expiringDocuments,
      List<ComplianceRecommendation> recommendations,
      List<ComplianceIssue>? issues,
      List<ComplianceIssue>? warnings,
      AuditTrail? auditTrail});

  $ComplianceScoreCopyWith<$Res> get complianceScore;
  $ComplianceSummaryCopyWith<$Res> get summary;
  $AuditTrailCopyWith<$Res>? get auditTrail;
}

/// @nodoc
class _$ComplianceReportCopyWithImpl<$Res>
    implements $ComplianceReportCopyWith<$Res> {
  _$ComplianceReportCopyWithImpl(this._self, this._then);

  final ComplianceReport _self;
  final $Res Function(ComplianceReport) _then;

  /// Create a copy of ComplianceReport
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reportId = null,
    Object? organizationId = null,
    Object? reportType = null,
    Object? generatedDate = null,
    Object? complianceScore = null,
    Object? summary = null,
    Object? expiringDocuments = null,
    Object? recommendations = null,
    Object? issues = freezed,
    Object? warnings = freezed,
    Object? auditTrail = freezed,
  }) {
    return _then(_self.copyWith(
      reportId: null == reportId
          ? _self.reportId
          : reportId // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: null == organizationId
          ? _self.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      reportType: null == reportType
          ? _self.reportType
          : reportType // ignore: cast_nullable_to_non_nullable
              as String,
      generatedDate: null == generatedDate
          ? _self.generatedDate
          : generatedDate // ignore: cast_nullable_to_non_nullable
              as String,
      complianceScore: null == complianceScore
          ? _self.complianceScore
          : complianceScore // ignore: cast_nullable_to_non_nullable
              as ComplianceScore,
      summary: null == summary
          ? _self.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as ComplianceSummary,
      expiringDocuments: null == expiringDocuments
          ? _self.expiringDocuments
          : expiringDocuments // ignore: cast_nullable_to_non_nullable
              as List<ExpiringDocument>,
      recommendations: null == recommendations
          ? _self.recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as List<ComplianceRecommendation>,
      issues: freezed == issues
          ? _self.issues
          : issues // ignore: cast_nullable_to_non_nullable
              as List<ComplianceIssue>?,
      warnings: freezed == warnings
          ? _self.warnings
          : warnings // ignore: cast_nullable_to_non_nullable
              as List<ComplianceIssue>?,
      auditTrail: freezed == auditTrail
          ? _self.auditTrail
          : auditTrail // ignore: cast_nullable_to_non_nullable
              as AuditTrail?,
    ));
  }

  /// Create a copy of ComplianceReport
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ComplianceScoreCopyWith<$Res> get complianceScore {
    return $ComplianceScoreCopyWith<$Res>(_self.complianceScore, (value) {
      return _then(_self.copyWith(complianceScore: value));
    });
  }

  /// Create a copy of ComplianceReport
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ComplianceSummaryCopyWith<$Res> get summary {
    return $ComplianceSummaryCopyWith<$Res>(_self.summary, (value) {
      return _then(_self.copyWith(summary: value));
    });
  }

  /// Create a copy of ComplianceReport
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AuditTrailCopyWith<$Res>? get auditTrail {
    if (_self.auditTrail == null) {
      return null;
    }

    return $AuditTrailCopyWith<$Res>(_self.auditTrail!, (value) {
      return _then(_self.copyWith(auditTrail: value));
    });
  }
}

/// Adds pattern-matching-related methods to [ComplianceReport].
extension ComplianceReportPatterns on ComplianceReport {
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
    TResult Function(_ComplianceReport value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ComplianceReport() when $default != null:
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
    TResult Function(_ComplianceReport value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ComplianceReport():
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
    TResult? Function(_ComplianceReport value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ComplianceReport() when $default != null:
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
            String reportId,
            String organizationId,
            String reportType,
            String generatedDate,
            ComplianceScore complianceScore,
            ComplianceSummary summary,
            List<ExpiringDocument> expiringDocuments,
            List<ComplianceRecommendation> recommendations,
            List<ComplianceIssue>? issues,
            List<ComplianceIssue>? warnings,
            AuditTrail? auditTrail)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ComplianceReport() when $default != null:
        return $default(
            _that.reportId,
            _that.organizationId,
            _that.reportType,
            _that.generatedDate,
            _that.complianceScore,
            _that.summary,
            _that.expiringDocuments,
            _that.recommendations,
            _that.issues,
            _that.warnings,
            _that.auditTrail);
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
            String reportId,
            String organizationId,
            String reportType,
            String generatedDate,
            ComplianceScore complianceScore,
            ComplianceSummary summary,
            List<ExpiringDocument> expiringDocuments,
            List<ComplianceRecommendation> recommendations,
            List<ComplianceIssue>? issues,
            List<ComplianceIssue>? warnings,
            AuditTrail? auditTrail)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ComplianceReport():
        return $default(
            _that.reportId,
            _that.organizationId,
            _that.reportType,
            _that.generatedDate,
            _that.complianceScore,
            _that.summary,
            _that.expiringDocuments,
            _that.recommendations,
            _that.issues,
            _that.warnings,
            _that.auditTrail);
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
            String reportId,
            String organizationId,
            String reportType,
            String generatedDate,
            ComplianceScore complianceScore,
            ComplianceSummary summary,
            List<ExpiringDocument> expiringDocuments,
            List<ComplianceRecommendation> recommendations,
            List<ComplianceIssue>? issues,
            List<ComplianceIssue>? warnings,
            AuditTrail? auditTrail)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ComplianceReport() when $default != null:
        return $default(
            _that.reportId,
            _that.organizationId,
            _that.reportType,
            _that.generatedDate,
            _that.complianceScore,
            _that.summary,
            _that.expiringDocuments,
            _that.recommendations,
            _that.issues,
            _that.warnings,
            _that.auditTrail);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ComplianceReport implements ComplianceReport {
  const _ComplianceReport(
      {required this.reportId,
      required this.organizationId,
      required this.reportType,
      required this.generatedDate,
      required this.complianceScore,
      required this.summary,
      required final List<ExpiringDocument> expiringDocuments,
      required final List<ComplianceRecommendation> recommendations,
      final List<ComplianceIssue>? issues,
      final List<ComplianceIssue>? warnings,
      this.auditTrail})
      : _expiringDocuments = expiringDocuments,
        _recommendations = recommendations,
        _issues = issues,
        _warnings = warnings;
  factory _ComplianceReport.fromJson(Map<String, dynamic> json) =>
      _$ComplianceReportFromJson(json);

  @override
  final String reportId;
  @override
  final String organizationId;
  @override
  final String reportType;
  @override
  final String generatedDate;
  @override
  final ComplianceScore complianceScore;
  @override
  final ComplianceSummary summary;
  final List<ExpiringDocument> _expiringDocuments;
  @override
  List<ExpiringDocument> get expiringDocuments {
    if (_expiringDocuments is EqualUnmodifiableListView)
      return _expiringDocuments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_expiringDocuments);
  }

  final List<ComplianceRecommendation> _recommendations;
  @override
  List<ComplianceRecommendation> get recommendations {
    if (_recommendations is EqualUnmodifiableListView) return _recommendations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recommendations);
  }

  final List<ComplianceIssue>? _issues;
  @override
  List<ComplianceIssue>? get issues {
    final value = _issues;
    if (value == null) return null;
    if (_issues is EqualUnmodifiableListView) return _issues;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<ComplianceIssue>? _warnings;
  @override
  List<ComplianceIssue>? get warnings {
    final value = _warnings;
    if (value == null) return null;
    if (_warnings is EqualUnmodifiableListView) return _warnings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final AuditTrail? auditTrail;

  /// Create a copy of ComplianceReport
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ComplianceReportCopyWith<_ComplianceReport> get copyWith =>
      __$ComplianceReportCopyWithImpl<_ComplianceReport>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ComplianceReportToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ComplianceReport &&
            (identical(other.reportId, reportId) ||
                other.reportId == reportId) &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.reportType, reportType) ||
                other.reportType == reportType) &&
            (identical(other.generatedDate, generatedDate) ||
                other.generatedDate == generatedDate) &&
            (identical(other.complianceScore, complianceScore) ||
                other.complianceScore == complianceScore) &&
            (identical(other.summary, summary) || other.summary == summary) &&
            const DeepCollectionEquality()
                .equals(other._expiringDocuments, _expiringDocuments) &&
            const DeepCollectionEquality()
                .equals(other._recommendations, _recommendations) &&
            const DeepCollectionEquality().equals(other._issues, _issues) &&
            const DeepCollectionEquality().equals(other._warnings, _warnings) &&
            (identical(other.auditTrail, auditTrail) ||
                other.auditTrail == auditTrail));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      reportId,
      organizationId,
      reportType,
      generatedDate,
      complianceScore,
      summary,
      const DeepCollectionEquality().hash(_expiringDocuments),
      const DeepCollectionEquality().hash(_recommendations),
      const DeepCollectionEquality().hash(_issues),
      const DeepCollectionEquality().hash(_warnings),
      auditTrail);

  @override
  String toString() {
    return 'ComplianceReport(reportId: $reportId, organizationId: $organizationId, reportType: $reportType, generatedDate: $generatedDate, complianceScore: $complianceScore, summary: $summary, expiringDocuments: $expiringDocuments, recommendations: $recommendations, issues: $issues, warnings: $warnings, auditTrail: $auditTrail)';
  }
}

/// @nodoc
abstract mixin class _$ComplianceReportCopyWith<$Res>
    implements $ComplianceReportCopyWith<$Res> {
  factory _$ComplianceReportCopyWith(
          _ComplianceReport value, $Res Function(_ComplianceReport) _then) =
      __$ComplianceReportCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String reportId,
      String organizationId,
      String reportType,
      String generatedDate,
      ComplianceScore complianceScore,
      ComplianceSummary summary,
      List<ExpiringDocument> expiringDocuments,
      List<ComplianceRecommendation> recommendations,
      List<ComplianceIssue>? issues,
      List<ComplianceIssue>? warnings,
      AuditTrail? auditTrail});

  @override
  $ComplianceScoreCopyWith<$Res> get complianceScore;
  @override
  $ComplianceSummaryCopyWith<$Res> get summary;
  @override
  $AuditTrailCopyWith<$Res>? get auditTrail;
}

/// @nodoc
class __$ComplianceReportCopyWithImpl<$Res>
    implements _$ComplianceReportCopyWith<$Res> {
  __$ComplianceReportCopyWithImpl(this._self, this._then);

  final _ComplianceReport _self;
  final $Res Function(_ComplianceReport) _then;

  /// Create a copy of ComplianceReport
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? reportId = null,
    Object? organizationId = null,
    Object? reportType = null,
    Object? generatedDate = null,
    Object? complianceScore = null,
    Object? summary = null,
    Object? expiringDocuments = null,
    Object? recommendations = null,
    Object? issues = freezed,
    Object? warnings = freezed,
    Object? auditTrail = freezed,
  }) {
    return _then(_ComplianceReport(
      reportId: null == reportId
          ? _self.reportId
          : reportId // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: null == organizationId
          ? _self.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      reportType: null == reportType
          ? _self.reportType
          : reportType // ignore: cast_nullable_to_non_nullable
              as String,
      generatedDate: null == generatedDate
          ? _self.generatedDate
          : generatedDate // ignore: cast_nullable_to_non_nullable
              as String,
      complianceScore: null == complianceScore
          ? _self.complianceScore
          : complianceScore // ignore: cast_nullable_to_non_nullable
              as ComplianceScore,
      summary: null == summary
          ? _self.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as ComplianceSummary,
      expiringDocuments: null == expiringDocuments
          ? _self._expiringDocuments
          : expiringDocuments // ignore: cast_nullable_to_non_nullable
              as List<ExpiringDocument>,
      recommendations: null == recommendations
          ? _self._recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as List<ComplianceRecommendation>,
      issues: freezed == issues
          ? _self._issues
          : issues // ignore: cast_nullable_to_non_nullable
              as List<ComplianceIssue>?,
      warnings: freezed == warnings
          ? _self._warnings
          : warnings // ignore: cast_nullable_to_non_nullable
              as List<ComplianceIssue>?,
      auditTrail: freezed == auditTrail
          ? _self.auditTrail
          : auditTrail // ignore: cast_nullable_to_non_nullable
              as AuditTrail?,
    ));
  }

  /// Create a copy of ComplianceReport
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ComplianceScoreCopyWith<$Res> get complianceScore {
    return $ComplianceScoreCopyWith<$Res>(_self.complianceScore, (value) {
      return _then(_self.copyWith(complianceScore: value));
    });
  }

  /// Create a copy of ComplianceReport
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ComplianceSummaryCopyWith<$Res> get summary {
    return $ComplianceSummaryCopyWith<$Res>(_self.summary, (value) {
      return _then(_self.copyWith(summary: value));
    });
  }

  /// Create a copy of ComplianceReport
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AuditTrailCopyWith<$Res>? get auditTrail {
    if (_self.auditTrail == null) {
      return null;
    }

    return $AuditTrailCopyWith<$Res>(_self.auditTrail!, (value) {
      return _then(_self.copyWith(auditTrail: value));
    });
  }
}

/// @nodoc
mixin _$ComplianceRecommendation {
  String get priority;
  String get action;
  String get description;

  /// Create a copy of ComplianceRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ComplianceRecommendationCopyWith<ComplianceRecommendation> get copyWith =>
      _$ComplianceRecommendationCopyWithImpl<ComplianceRecommendation>(
          this as ComplianceRecommendation, _$identity);

  /// Serializes this ComplianceRecommendation to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ComplianceRecommendation &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.action, action) || other.action == action) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, priority, action, description);

  @override
  String toString() {
    return 'ComplianceRecommendation(priority: $priority, action: $action, description: $description)';
  }
}

/// @nodoc
abstract mixin class $ComplianceRecommendationCopyWith<$Res> {
  factory $ComplianceRecommendationCopyWith(ComplianceRecommendation value,
          $Res Function(ComplianceRecommendation) _then) =
      _$ComplianceRecommendationCopyWithImpl;
  @useResult
  $Res call({String priority, String action, String description});
}

/// @nodoc
class _$ComplianceRecommendationCopyWithImpl<$Res>
    implements $ComplianceRecommendationCopyWith<$Res> {
  _$ComplianceRecommendationCopyWithImpl(this._self, this._then);

  final ComplianceRecommendation _self;
  final $Res Function(ComplianceRecommendation) _then;

  /// Create a copy of ComplianceRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? priority = null,
    Object? action = null,
    Object? description = null,
  }) {
    return _then(_self.copyWith(
      priority: null == priority
          ? _self.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as String,
      action: null == action
          ? _self.action
          : action // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [ComplianceRecommendation].
extension ComplianceRecommendationPatterns on ComplianceRecommendation {
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
    TResult Function(_ComplianceRecommendation value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ComplianceRecommendation() when $default != null:
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
    TResult Function(_ComplianceRecommendation value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ComplianceRecommendation():
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
    TResult? Function(_ComplianceRecommendation value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ComplianceRecommendation() when $default != null:
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
    TResult Function(String priority, String action, String description)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ComplianceRecommendation() when $default != null:
        return $default(_that.priority, _that.action, _that.description);
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
    TResult Function(String priority, String action, String description)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ComplianceRecommendation():
        return $default(_that.priority, _that.action, _that.description);
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
    TResult? Function(String priority, String action, String description)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ComplianceRecommendation() when $default != null:
        return $default(_that.priority, _that.action, _that.description);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ComplianceRecommendation implements ComplianceRecommendation {
  const _ComplianceRecommendation(
      {required this.priority,
      required this.action,
      required this.description});
  factory _ComplianceRecommendation.fromJson(Map<String, dynamic> json) =>
      _$ComplianceRecommendationFromJson(json);

  @override
  final String priority;
  @override
  final String action;
  @override
  final String description;

  /// Create a copy of ComplianceRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ComplianceRecommendationCopyWith<_ComplianceRecommendation> get copyWith =>
      __$ComplianceRecommendationCopyWithImpl<_ComplianceRecommendation>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ComplianceRecommendationToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ComplianceRecommendation &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.action, action) || other.action == action) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, priority, action, description);

  @override
  String toString() {
    return 'ComplianceRecommendation(priority: $priority, action: $action, description: $description)';
  }
}

/// @nodoc
abstract mixin class _$ComplianceRecommendationCopyWith<$Res>
    implements $ComplianceRecommendationCopyWith<$Res> {
  factory _$ComplianceRecommendationCopyWith(_ComplianceRecommendation value,
          $Res Function(_ComplianceRecommendation) _then) =
      __$ComplianceRecommendationCopyWithImpl;
  @override
  @useResult
  $Res call({String priority, String action, String description});
}

/// @nodoc
class __$ComplianceRecommendationCopyWithImpl<$Res>
    implements _$ComplianceRecommendationCopyWith<$Res> {
  __$ComplianceRecommendationCopyWithImpl(this._self, this._then);

  final _ComplianceRecommendation _self;
  final $Res Function(_ComplianceRecommendation) _then;

  /// Create a copy of ComplianceRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? priority = null,
    Object? action = null,
    Object? description = null,
  }) {
    return _then(_ComplianceRecommendation(
      priority: null == priority
          ? _self.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as String,
      action: null == action
          ? _self.action
          : action // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$AuditTrail {
  String get lastAuditDate;
  String get nextAuditDate;
  List<dynamic> get complianceHistory;

  /// Create a copy of AuditTrail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AuditTrailCopyWith<AuditTrail> get copyWith =>
      _$AuditTrailCopyWithImpl<AuditTrail>(this as AuditTrail, _$identity);

  /// Serializes this AuditTrail to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AuditTrail &&
            (identical(other.lastAuditDate, lastAuditDate) ||
                other.lastAuditDate == lastAuditDate) &&
            (identical(other.nextAuditDate, nextAuditDate) ||
                other.nextAuditDate == nextAuditDate) &&
            const DeepCollectionEquality()
                .equals(other.complianceHistory, complianceHistory));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, lastAuditDate, nextAuditDate,
      const DeepCollectionEquality().hash(complianceHistory));

  @override
  String toString() {
    return 'AuditTrail(lastAuditDate: $lastAuditDate, nextAuditDate: $nextAuditDate, complianceHistory: $complianceHistory)';
  }
}

/// @nodoc
abstract mixin class $AuditTrailCopyWith<$Res> {
  factory $AuditTrailCopyWith(
          AuditTrail value, $Res Function(AuditTrail) _then) =
      _$AuditTrailCopyWithImpl;
  @useResult
  $Res call(
      {String lastAuditDate,
      String nextAuditDate,
      List<dynamic> complianceHistory});
}

/// @nodoc
class _$AuditTrailCopyWithImpl<$Res> implements $AuditTrailCopyWith<$Res> {
  _$AuditTrailCopyWithImpl(this._self, this._then);

  final AuditTrail _self;
  final $Res Function(AuditTrail) _then;

  /// Create a copy of AuditTrail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lastAuditDate = null,
    Object? nextAuditDate = null,
    Object? complianceHistory = null,
  }) {
    return _then(_self.copyWith(
      lastAuditDate: null == lastAuditDate
          ? _self.lastAuditDate
          : lastAuditDate // ignore: cast_nullable_to_non_nullable
              as String,
      nextAuditDate: null == nextAuditDate
          ? _self.nextAuditDate
          : nextAuditDate // ignore: cast_nullable_to_non_nullable
              as String,
      complianceHistory: null == complianceHistory
          ? _self.complianceHistory
          : complianceHistory // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
    ));
  }
}

/// Adds pattern-matching-related methods to [AuditTrail].
extension AuditTrailPatterns on AuditTrail {
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
    TResult Function(_AuditTrail value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AuditTrail() when $default != null:
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
    TResult Function(_AuditTrail value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AuditTrail():
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
    TResult? Function(_AuditTrail value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AuditTrail() when $default != null:
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
    TResult Function(String lastAuditDate, String nextAuditDate,
            List<dynamic> complianceHistory)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AuditTrail() when $default != null:
        return $default(
            _that.lastAuditDate, _that.nextAuditDate, _that.complianceHistory);
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
    TResult Function(String lastAuditDate, String nextAuditDate,
            List<dynamic> complianceHistory)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AuditTrail():
        return $default(
            _that.lastAuditDate, _that.nextAuditDate, _that.complianceHistory);
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
    TResult? Function(String lastAuditDate, String nextAuditDate,
            List<dynamic> complianceHistory)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AuditTrail() when $default != null:
        return $default(
            _that.lastAuditDate, _that.nextAuditDate, _that.complianceHistory);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _AuditTrail implements AuditTrail {
  const _AuditTrail(
      {required this.lastAuditDate,
      required this.nextAuditDate,
      required final List<dynamic> complianceHistory})
      : _complianceHistory = complianceHistory;
  factory _AuditTrail.fromJson(Map<String, dynamic> json) =>
      _$AuditTrailFromJson(json);

  @override
  final String lastAuditDate;
  @override
  final String nextAuditDate;
  final List<dynamic> _complianceHistory;
  @override
  List<dynamic> get complianceHistory {
    if (_complianceHistory is EqualUnmodifiableListView)
      return _complianceHistory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_complianceHistory);
  }

  /// Create a copy of AuditTrail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AuditTrailCopyWith<_AuditTrail> get copyWith =>
      __$AuditTrailCopyWithImpl<_AuditTrail>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AuditTrailToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AuditTrail &&
            (identical(other.lastAuditDate, lastAuditDate) ||
                other.lastAuditDate == lastAuditDate) &&
            (identical(other.nextAuditDate, nextAuditDate) ||
                other.nextAuditDate == nextAuditDate) &&
            const DeepCollectionEquality()
                .equals(other._complianceHistory, _complianceHistory));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, lastAuditDate, nextAuditDate,
      const DeepCollectionEquality().hash(_complianceHistory));

  @override
  String toString() {
    return 'AuditTrail(lastAuditDate: $lastAuditDate, nextAuditDate: $nextAuditDate, complianceHistory: $complianceHistory)';
  }
}

/// @nodoc
abstract mixin class _$AuditTrailCopyWith<$Res>
    implements $AuditTrailCopyWith<$Res> {
  factory _$AuditTrailCopyWith(
          _AuditTrail value, $Res Function(_AuditTrail) _then) =
      __$AuditTrailCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String lastAuditDate,
      String nextAuditDate,
      List<dynamic> complianceHistory});
}

/// @nodoc
class __$AuditTrailCopyWithImpl<$Res> implements _$AuditTrailCopyWith<$Res> {
  __$AuditTrailCopyWithImpl(this._self, this._then);

  final _AuditTrail _self;
  final $Res Function(_AuditTrail) _then;

  /// Create a copy of AuditTrail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? lastAuditDate = null,
    Object? nextAuditDate = null,
    Object? complianceHistory = null,
  }) {
    return _then(_AuditTrail(
      lastAuditDate: null == lastAuditDate
          ? _self.lastAuditDate
          : lastAuditDate // ignore: cast_nullable_to_non_nullable
              as String,
      nextAuditDate: null == nextAuditDate
          ? _self.nextAuditDate
          : nextAuditDate // ignore: cast_nullable_to_non_nullable
              as String,
      complianceHistory: null == complianceHistory
          ? _self._complianceHistory
          : complianceHistory // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
    ));
  }
}

/// @nodoc
mixin _$ComplianceTrend {
  String get month;
  int get score;
  int get issues;
  int get warnings;
  int get compliantWorkers;

  /// Create a copy of ComplianceTrend
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ComplianceTrendCopyWith<ComplianceTrend> get copyWith =>
      _$ComplianceTrendCopyWithImpl<ComplianceTrend>(
          this as ComplianceTrend, _$identity);

  /// Serializes this ComplianceTrend to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ComplianceTrend &&
            (identical(other.month, month) || other.month == month) &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.issues, issues) || other.issues == issues) &&
            (identical(other.warnings, warnings) ||
                other.warnings == warnings) &&
            (identical(other.compliantWorkers, compliantWorkers) ||
                other.compliantWorkers == compliantWorkers));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, month, score, issues, warnings, compliantWorkers);

  @override
  String toString() {
    return 'ComplianceTrend(month: $month, score: $score, issues: $issues, warnings: $warnings, compliantWorkers: $compliantWorkers)';
  }
}

/// @nodoc
abstract mixin class $ComplianceTrendCopyWith<$Res> {
  factory $ComplianceTrendCopyWith(
          ComplianceTrend value, $Res Function(ComplianceTrend) _then) =
      _$ComplianceTrendCopyWithImpl;
  @useResult
  $Res call(
      {String month,
      int score,
      int issues,
      int warnings,
      int compliantWorkers});
}

/// @nodoc
class _$ComplianceTrendCopyWithImpl<$Res>
    implements $ComplianceTrendCopyWith<$Res> {
  _$ComplianceTrendCopyWithImpl(this._self, this._then);

  final ComplianceTrend _self;
  final $Res Function(ComplianceTrend) _then;

  /// Create a copy of ComplianceTrend
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? month = null,
    Object? score = null,
    Object? issues = null,
    Object? warnings = null,
    Object? compliantWorkers = null,
  }) {
    return _then(_self.copyWith(
      month: null == month
          ? _self.month
          : month // ignore: cast_nullable_to_non_nullable
              as String,
      score: null == score
          ? _self.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
      issues: null == issues
          ? _self.issues
          : issues // ignore: cast_nullable_to_non_nullable
              as int,
      warnings: null == warnings
          ? _self.warnings
          : warnings // ignore: cast_nullable_to_non_nullable
              as int,
      compliantWorkers: null == compliantWorkers
          ? _self.compliantWorkers
          : compliantWorkers // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [ComplianceTrend].
extension ComplianceTrendPatterns on ComplianceTrend {
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
    TResult Function(_ComplianceTrend value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ComplianceTrend() when $default != null:
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
    TResult Function(_ComplianceTrend value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ComplianceTrend():
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
    TResult? Function(_ComplianceTrend value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ComplianceTrend() when $default != null:
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
    TResult Function(String month, int score, int issues, int warnings,
            int compliantWorkers)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ComplianceTrend() when $default != null:
        return $default(_that.month, _that.score, _that.issues, _that.warnings,
            _that.compliantWorkers);
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
    TResult Function(String month, int score, int issues, int warnings,
            int compliantWorkers)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ComplianceTrend():
        return $default(_that.month, _that.score, _that.issues, _that.warnings,
            _that.compliantWorkers);
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
    TResult? Function(String month, int score, int issues, int warnings,
            int compliantWorkers)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ComplianceTrend() when $default != null:
        return $default(_that.month, _that.score, _that.issues, _that.warnings,
            _that.compliantWorkers);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ComplianceTrend implements ComplianceTrend {
  const _ComplianceTrend(
      {required this.month,
      required this.score,
      required this.issues,
      required this.warnings,
      required this.compliantWorkers});
  factory _ComplianceTrend.fromJson(Map<String, dynamic> json) =>
      _$ComplianceTrendFromJson(json);

  @override
  final String month;
  @override
  final int score;
  @override
  final int issues;
  @override
  final int warnings;
  @override
  final int compliantWorkers;

  /// Create a copy of ComplianceTrend
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ComplianceTrendCopyWith<_ComplianceTrend> get copyWith =>
      __$ComplianceTrendCopyWithImpl<_ComplianceTrend>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ComplianceTrendToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ComplianceTrend &&
            (identical(other.month, month) || other.month == month) &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.issues, issues) || other.issues == issues) &&
            (identical(other.warnings, warnings) ||
                other.warnings == warnings) &&
            (identical(other.compliantWorkers, compliantWorkers) ||
                other.compliantWorkers == compliantWorkers));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, month, score, issues, warnings, compliantWorkers);

  @override
  String toString() {
    return 'ComplianceTrend(month: $month, score: $score, issues: $issues, warnings: $warnings, compliantWorkers: $compliantWorkers)';
  }
}

/// @nodoc
abstract mixin class _$ComplianceTrendCopyWith<$Res>
    implements $ComplianceTrendCopyWith<$Res> {
  factory _$ComplianceTrendCopyWith(
          _ComplianceTrend value, $Res Function(_ComplianceTrend) _then) =
      __$ComplianceTrendCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String month,
      int score,
      int issues,
      int warnings,
      int compliantWorkers});
}

/// @nodoc
class __$ComplianceTrendCopyWithImpl<$Res>
    implements _$ComplianceTrendCopyWith<$Res> {
  __$ComplianceTrendCopyWithImpl(this._self, this._then);

  final _ComplianceTrend _self;
  final $Res Function(_ComplianceTrend) _then;

  /// Create a copy of ComplianceTrend
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? month = null,
    Object? score = null,
    Object? issues = null,
    Object? warnings = null,
    Object? compliantWorkers = null,
  }) {
    return _then(_ComplianceTrend(
      month: null == month
          ? _self.month
          : month // ignore: cast_nullable_to_non_nullable
              as String,
      score: null == score
          ? _self.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
      issues: null == issues
          ? _self.issues
          : issues // ignore: cast_nullable_to_non_nullable
              as int,
      warnings: null == warnings
          ? _self.warnings
          : warnings // ignore: cast_nullable_to_non_nullable
              as int,
      compliantWorkers: null == compliantWorkers
          ? _self.compliantWorkers
          : compliantWorkers // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$ComplianceTrends {
  String get organizationId;
  String get period;
  String get trendDirection;
  List<ComplianceTrend> get trends;
  TrendSummary get summary;

  /// Create a copy of ComplianceTrends
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ComplianceTrendsCopyWith<ComplianceTrends> get copyWith =>
      _$ComplianceTrendsCopyWithImpl<ComplianceTrends>(
          this as ComplianceTrends, _$identity);

  /// Serializes this ComplianceTrends to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ComplianceTrends &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.period, period) || other.period == period) &&
            (identical(other.trendDirection, trendDirection) ||
                other.trendDirection == trendDirection) &&
            const DeepCollectionEquality().equals(other.trends, trends) &&
            (identical(other.summary, summary) || other.summary == summary));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, organizationId, period,
      trendDirection, const DeepCollectionEquality().hash(trends), summary);

  @override
  String toString() {
    return 'ComplianceTrends(organizationId: $organizationId, period: $period, trendDirection: $trendDirection, trends: $trends, summary: $summary)';
  }
}

/// @nodoc
abstract mixin class $ComplianceTrendsCopyWith<$Res> {
  factory $ComplianceTrendsCopyWith(
          ComplianceTrends value, $Res Function(ComplianceTrends) _then) =
      _$ComplianceTrendsCopyWithImpl;
  @useResult
  $Res call(
      {String organizationId,
      String period,
      String trendDirection,
      List<ComplianceTrend> trends,
      TrendSummary summary});

  $TrendSummaryCopyWith<$Res> get summary;
}

/// @nodoc
class _$ComplianceTrendsCopyWithImpl<$Res>
    implements $ComplianceTrendsCopyWith<$Res> {
  _$ComplianceTrendsCopyWithImpl(this._self, this._then);

  final ComplianceTrends _self;
  final $Res Function(ComplianceTrends) _then;

  /// Create a copy of ComplianceTrends
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? organizationId = null,
    Object? period = null,
    Object? trendDirection = null,
    Object? trends = null,
    Object? summary = null,
  }) {
    return _then(_self.copyWith(
      organizationId: null == organizationId
          ? _self.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      period: null == period
          ? _self.period
          : period // ignore: cast_nullable_to_non_nullable
              as String,
      trendDirection: null == trendDirection
          ? _self.trendDirection
          : trendDirection // ignore: cast_nullable_to_non_nullable
              as String,
      trends: null == trends
          ? _self.trends
          : trends // ignore: cast_nullable_to_non_nullable
              as List<ComplianceTrend>,
      summary: null == summary
          ? _self.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as TrendSummary,
    ));
  }

  /// Create a copy of ComplianceTrends
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TrendSummaryCopyWith<$Res> get summary {
    return $TrendSummaryCopyWith<$Res>(_self.summary, (value) {
      return _then(_self.copyWith(summary: value));
    });
  }
}

/// Adds pattern-matching-related methods to [ComplianceTrends].
extension ComplianceTrendsPatterns on ComplianceTrends {
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
    TResult Function(_ComplianceTrends value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ComplianceTrends() when $default != null:
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
    TResult Function(_ComplianceTrends value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ComplianceTrends():
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
    TResult? Function(_ComplianceTrends value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ComplianceTrends() when $default != null:
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
            String period,
            String trendDirection,
            List<ComplianceTrend> trends,
            TrendSummary summary)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ComplianceTrends() when $default != null:
        return $default(_that.organizationId, _that.period,
            _that.trendDirection, _that.trends, _that.summary);
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
            String period,
            String trendDirection,
            List<ComplianceTrend> trends,
            TrendSummary summary)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ComplianceTrends():
        return $default(_that.organizationId, _that.period,
            _that.trendDirection, _that.trends, _that.summary);
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
            String period,
            String trendDirection,
            List<ComplianceTrend> trends,
            TrendSummary summary)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ComplianceTrends() when $default != null:
        return $default(_that.organizationId, _that.period,
            _that.trendDirection, _that.trends, _that.summary);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ComplianceTrends implements ComplianceTrends {
  const _ComplianceTrends(
      {required this.organizationId,
      required this.period,
      required this.trendDirection,
      required final List<ComplianceTrend> trends,
      required this.summary})
      : _trends = trends;
  factory _ComplianceTrends.fromJson(Map<String, dynamic> json) =>
      _$ComplianceTrendsFromJson(json);

  @override
  final String organizationId;
  @override
  final String period;
  @override
  final String trendDirection;
  final List<ComplianceTrend> _trends;
  @override
  List<ComplianceTrend> get trends {
    if (_trends is EqualUnmodifiableListView) return _trends;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_trends);
  }

  @override
  final TrendSummary summary;

  /// Create a copy of ComplianceTrends
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ComplianceTrendsCopyWith<_ComplianceTrends> get copyWith =>
      __$ComplianceTrendsCopyWithImpl<_ComplianceTrends>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ComplianceTrendsToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ComplianceTrends &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.period, period) || other.period == period) &&
            (identical(other.trendDirection, trendDirection) ||
                other.trendDirection == trendDirection) &&
            const DeepCollectionEquality().equals(other._trends, _trends) &&
            (identical(other.summary, summary) || other.summary == summary));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, organizationId, period,
      trendDirection, const DeepCollectionEquality().hash(_trends), summary);

  @override
  String toString() {
    return 'ComplianceTrends(organizationId: $organizationId, period: $period, trendDirection: $trendDirection, trends: $trends, summary: $summary)';
  }
}

/// @nodoc
abstract mixin class _$ComplianceTrendsCopyWith<$Res>
    implements $ComplianceTrendsCopyWith<$Res> {
  factory _$ComplianceTrendsCopyWith(
          _ComplianceTrends value, $Res Function(_ComplianceTrends) _then) =
      __$ComplianceTrendsCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String organizationId,
      String period,
      String trendDirection,
      List<ComplianceTrend> trends,
      TrendSummary summary});

  @override
  $TrendSummaryCopyWith<$Res> get summary;
}

/// @nodoc
class __$ComplianceTrendsCopyWithImpl<$Res>
    implements _$ComplianceTrendsCopyWith<$Res> {
  __$ComplianceTrendsCopyWithImpl(this._self, this._then);

  final _ComplianceTrends _self;
  final $Res Function(_ComplianceTrends) _then;

  /// Create a copy of ComplianceTrends
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? organizationId = null,
    Object? period = null,
    Object? trendDirection = null,
    Object? trends = null,
    Object? summary = null,
  }) {
    return _then(_ComplianceTrends(
      organizationId: null == organizationId
          ? _self.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      period: null == period
          ? _self.period
          : period // ignore: cast_nullable_to_non_nullable
              as String,
      trendDirection: null == trendDirection
          ? _self.trendDirection
          : trendDirection // ignore: cast_nullable_to_non_nullable
              as String,
      trends: null == trends
          ? _self._trends
          : trends // ignore: cast_nullable_to_non_nullable
              as List<ComplianceTrend>,
      summary: null == summary
          ? _self.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as TrendSummary,
    ));
  }

  /// Create a copy of ComplianceTrends
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TrendSummaryCopyWith<$Res> get summary {
    return $TrendSummaryCopyWith<$Res>(_self.summary, (value) {
      return _then(_self.copyWith(summary: value));
    });
  }
}

/// @nodoc
mixin _$TrendSummary {
  int get averageScore;
  int get highestScore;
  int get lowestScore;
  int get improvement;

  /// Create a copy of TrendSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TrendSummaryCopyWith<TrendSummary> get copyWith =>
      _$TrendSummaryCopyWithImpl<TrendSummary>(
          this as TrendSummary, _$identity);

  /// Serializes this TrendSummary to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TrendSummary &&
            (identical(other.averageScore, averageScore) ||
                other.averageScore == averageScore) &&
            (identical(other.highestScore, highestScore) ||
                other.highestScore == highestScore) &&
            (identical(other.lowestScore, lowestScore) ||
                other.lowestScore == lowestScore) &&
            (identical(other.improvement, improvement) ||
                other.improvement == improvement));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, averageScore, highestScore, lowestScore, improvement);

  @override
  String toString() {
    return 'TrendSummary(averageScore: $averageScore, highestScore: $highestScore, lowestScore: $lowestScore, improvement: $improvement)';
  }
}

/// @nodoc
abstract mixin class $TrendSummaryCopyWith<$Res> {
  factory $TrendSummaryCopyWith(
          TrendSummary value, $Res Function(TrendSummary) _then) =
      _$TrendSummaryCopyWithImpl;
  @useResult
  $Res call(
      {int averageScore, int highestScore, int lowestScore, int improvement});
}

/// @nodoc
class _$TrendSummaryCopyWithImpl<$Res> implements $TrendSummaryCopyWith<$Res> {
  _$TrendSummaryCopyWithImpl(this._self, this._then);

  final TrendSummary _self;
  final $Res Function(TrendSummary) _then;

  /// Create a copy of TrendSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? averageScore = null,
    Object? highestScore = null,
    Object? lowestScore = null,
    Object? improvement = null,
  }) {
    return _then(_self.copyWith(
      averageScore: null == averageScore
          ? _self.averageScore
          : averageScore // ignore: cast_nullable_to_non_nullable
              as int,
      highestScore: null == highestScore
          ? _self.highestScore
          : highestScore // ignore: cast_nullable_to_non_nullable
              as int,
      lowestScore: null == lowestScore
          ? _self.lowestScore
          : lowestScore // ignore: cast_nullable_to_non_nullable
              as int,
      improvement: null == improvement
          ? _self.improvement
          : improvement // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [TrendSummary].
extension TrendSummaryPatterns on TrendSummary {
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
    TResult Function(_TrendSummary value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TrendSummary() when $default != null:
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
    TResult Function(_TrendSummary value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TrendSummary():
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
    TResult? Function(_TrendSummary value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TrendSummary() when $default != null:
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
    TResult Function(int averageScore, int highestScore, int lowestScore,
            int improvement)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TrendSummary() when $default != null:
        return $default(_that.averageScore, _that.highestScore,
            _that.lowestScore, _that.improvement);
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
    TResult Function(int averageScore, int highestScore, int lowestScore,
            int improvement)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TrendSummary():
        return $default(_that.averageScore, _that.highestScore,
            _that.lowestScore, _that.improvement);
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
    TResult? Function(int averageScore, int highestScore, int lowestScore,
            int improvement)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TrendSummary() when $default != null:
        return $default(_that.averageScore, _that.highestScore,
            _that.lowestScore, _that.improvement);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _TrendSummary implements TrendSummary {
  const _TrendSummary(
      {required this.averageScore,
      required this.highestScore,
      required this.lowestScore,
      required this.improvement});
  factory _TrendSummary.fromJson(Map<String, dynamic> json) =>
      _$TrendSummaryFromJson(json);

  @override
  final int averageScore;
  @override
  final int highestScore;
  @override
  final int lowestScore;
  @override
  final int improvement;

  /// Create a copy of TrendSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TrendSummaryCopyWith<_TrendSummary> get copyWith =>
      __$TrendSummaryCopyWithImpl<_TrendSummary>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TrendSummaryToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TrendSummary &&
            (identical(other.averageScore, averageScore) ||
                other.averageScore == averageScore) &&
            (identical(other.highestScore, highestScore) ||
                other.highestScore == highestScore) &&
            (identical(other.lowestScore, lowestScore) ||
                other.lowestScore == lowestScore) &&
            (identical(other.improvement, improvement) ||
                other.improvement == improvement));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, averageScore, highestScore, lowestScore, improvement);

  @override
  String toString() {
    return 'TrendSummary(averageScore: $averageScore, highestScore: $highestScore, lowestScore: $lowestScore, improvement: $improvement)';
  }
}

/// @nodoc
abstract mixin class _$TrendSummaryCopyWith<$Res>
    implements $TrendSummaryCopyWith<$Res> {
  factory _$TrendSummaryCopyWith(
          _TrendSummary value, $Res Function(_TrendSummary) _then) =
      __$TrendSummaryCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int averageScore, int highestScore, int lowestScore, int improvement});
}

/// @nodoc
class __$TrendSummaryCopyWithImpl<$Res>
    implements _$TrendSummaryCopyWith<$Res> {
  __$TrendSummaryCopyWithImpl(this._self, this._then);

  final _TrendSummary _self;
  final $Res Function(_TrendSummary) _then;

  /// Create a copy of TrendSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? averageScore = null,
    Object? highestScore = null,
    Object? lowestScore = null,
    Object? improvement = null,
  }) {
    return _then(_TrendSummary(
      averageScore: null == averageScore
          ? _self.averageScore
          : averageScore // ignore: cast_nullable_to_non_nullable
              as int,
      highestScore: null == highestScore
          ? _self.highestScore
          : highestScore // ignore: cast_nullable_to_non_nullable
              as int,
      lowestScore: null == lowestScore
          ? _self.lowestScore
          : lowestScore // ignore: cast_nullable_to_non_nullable
              as int,
      improvement: null == improvement
          ? _self.improvement
          : improvement // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
