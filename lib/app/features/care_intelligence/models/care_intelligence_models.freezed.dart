// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'care_intelligence_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$IntelligenceReport {
  String get clientId;
  String get organizationId;
  String get generatedAt;
  int get intelligenceScore;
  RiskSummary get riskSummary;
  List<Recommendation> get recommendations;
  OutcomePredictions get outcomePredictions;
  List<Alert> get alerts;
  List<NextAction> get nextActions;

  /// Create a copy of IntelligenceReport
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $IntelligenceReportCopyWith<IntelligenceReport> get copyWith =>
      _$IntelligenceReportCopyWithImpl<IntelligenceReport>(
          this as IntelligenceReport, _$identity);

  /// Serializes this IntelligenceReport to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is IntelligenceReport &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.generatedAt, generatedAt) ||
                other.generatedAt == generatedAt) &&
            (identical(other.intelligenceScore, intelligenceScore) ||
                other.intelligenceScore == intelligenceScore) &&
            (identical(other.riskSummary, riskSummary) ||
                other.riskSummary == riskSummary) &&
            const DeepCollectionEquality()
                .equals(other.recommendations, recommendations) &&
            (identical(other.outcomePredictions, outcomePredictions) ||
                other.outcomePredictions == outcomePredictions) &&
            const DeepCollectionEquality().equals(other.alerts, alerts) &&
            const DeepCollectionEquality()
                .equals(other.nextActions, nextActions));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      clientId,
      organizationId,
      generatedAt,
      intelligenceScore,
      riskSummary,
      const DeepCollectionEquality().hash(recommendations),
      outcomePredictions,
      const DeepCollectionEquality().hash(alerts),
      const DeepCollectionEquality().hash(nextActions));

  @override
  String toString() {
    return 'IntelligenceReport(clientId: $clientId, organizationId: $organizationId, generatedAt: $generatedAt, intelligenceScore: $intelligenceScore, riskSummary: $riskSummary, recommendations: $recommendations, outcomePredictions: $outcomePredictions, alerts: $alerts, nextActions: $nextActions)';
  }
}

/// @nodoc
abstract mixin class $IntelligenceReportCopyWith<$Res> {
  factory $IntelligenceReportCopyWith(
          IntelligenceReport value, $Res Function(IntelligenceReport) _then) =
      _$IntelligenceReportCopyWithImpl;
  @useResult
  $Res call(
      {String clientId,
      String organizationId,
      String generatedAt,
      int intelligenceScore,
      RiskSummary riskSummary,
      List<Recommendation> recommendations,
      OutcomePredictions outcomePredictions,
      List<Alert> alerts,
      List<NextAction> nextActions});

  $RiskSummaryCopyWith<$Res> get riskSummary;
  $OutcomePredictionsCopyWith<$Res> get outcomePredictions;
}

/// @nodoc
class _$IntelligenceReportCopyWithImpl<$Res>
    implements $IntelligenceReportCopyWith<$Res> {
  _$IntelligenceReportCopyWithImpl(this._self, this._then);

  final IntelligenceReport _self;
  final $Res Function(IntelligenceReport) _then;

  /// Create a copy of IntelligenceReport
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clientId = null,
    Object? organizationId = null,
    Object? generatedAt = null,
    Object? intelligenceScore = null,
    Object? riskSummary = null,
    Object? recommendations = null,
    Object? outcomePredictions = null,
    Object? alerts = null,
    Object? nextActions = null,
  }) {
    return _then(_self.copyWith(
      clientId: null == clientId
          ? _self.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: null == organizationId
          ? _self.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      generatedAt: null == generatedAt
          ? _self.generatedAt
          : generatedAt // ignore: cast_nullable_to_non_nullable
              as String,
      intelligenceScore: null == intelligenceScore
          ? _self.intelligenceScore
          : intelligenceScore // ignore: cast_nullable_to_non_nullable
              as int,
      riskSummary: null == riskSummary
          ? _self.riskSummary
          : riskSummary // ignore: cast_nullable_to_non_nullable
              as RiskSummary,
      recommendations: null == recommendations
          ? _self.recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as List<Recommendation>,
      outcomePredictions: null == outcomePredictions
          ? _self.outcomePredictions
          : outcomePredictions // ignore: cast_nullable_to_non_nullable
              as OutcomePredictions,
      alerts: null == alerts
          ? _self.alerts
          : alerts // ignore: cast_nullable_to_non_nullable
              as List<Alert>,
      nextActions: null == nextActions
          ? _self.nextActions
          : nextActions // ignore: cast_nullable_to_non_nullable
              as List<NextAction>,
    ));
  }

  /// Create a copy of IntelligenceReport
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RiskSummaryCopyWith<$Res> get riskSummary {
    return $RiskSummaryCopyWith<$Res>(_self.riskSummary, (value) {
      return _then(_self.copyWith(riskSummary: value));
    });
  }

  /// Create a copy of IntelligenceReport
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OutcomePredictionsCopyWith<$Res> get outcomePredictions {
    return $OutcomePredictionsCopyWith<$Res>(_self.outcomePredictions, (value) {
      return _then(_self.copyWith(outcomePredictions: value));
    });
  }
}

/// Adds pattern-matching-related methods to [IntelligenceReport].
extension IntelligenceReportPatterns on IntelligenceReport {
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
    TResult Function(_IntelligenceReport value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _IntelligenceReport() when $default != null:
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
    TResult Function(_IntelligenceReport value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _IntelligenceReport():
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
    TResult? Function(_IntelligenceReport value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _IntelligenceReport() when $default != null:
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
            String clientId,
            String organizationId,
            String generatedAt,
            int intelligenceScore,
            RiskSummary riskSummary,
            List<Recommendation> recommendations,
            OutcomePredictions outcomePredictions,
            List<Alert> alerts,
            List<NextAction> nextActions)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _IntelligenceReport() when $default != null:
        return $default(
            _that.clientId,
            _that.organizationId,
            _that.generatedAt,
            _that.intelligenceScore,
            _that.riskSummary,
            _that.recommendations,
            _that.outcomePredictions,
            _that.alerts,
            _that.nextActions);
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
            String clientId,
            String organizationId,
            String generatedAt,
            int intelligenceScore,
            RiskSummary riskSummary,
            List<Recommendation> recommendations,
            OutcomePredictions outcomePredictions,
            List<Alert> alerts,
            List<NextAction> nextActions)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _IntelligenceReport():
        return $default(
            _that.clientId,
            _that.organizationId,
            _that.generatedAt,
            _that.intelligenceScore,
            _that.riskSummary,
            _that.recommendations,
            _that.outcomePredictions,
            _that.alerts,
            _that.nextActions);
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
            String clientId,
            String organizationId,
            String generatedAt,
            int intelligenceScore,
            RiskSummary riskSummary,
            List<Recommendation> recommendations,
            OutcomePredictions outcomePredictions,
            List<Alert> alerts,
            List<NextAction> nextActions)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _IntelligenceReport() when $default != null:
        return $default(
            _that.clientId,
            _that.organizationId,
            _that.generatedAt,
            _that.intelligenceScore,
            _that.riskSummary,
            _that.recommendations,
            _that.outcomePredictions,
            _that.alerts,
            _that.nextActions);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _IntelligenceReport implements IntelligenceReport {
  const _IntelligenceReport(
      {required this.clientId,
      required this.organizationId,
      required this.generatedAt,
      required this.intelligenceScore,
      required this.riskSummary,
      required final List<Recommendation> recommendations,
      required this.outcomePredictions,
      required final List<Alert> alerts,
      required final List<NextAction> nextActions})
      : _recommendations = recommendations,
        _alerts = alerts,
        _nextActions = nextActions;
  factory _IntelligenceReport.fromJson(Map<String, dynamic> json) =>
      _$IntelligenceReportFromJson(json);

  @override
  final String clientId;
  @override
  final String organizationId;
  @override
  final String generatedAt;
  @override
  final int intelligenceScore;
  @override
  final RiskSummary riskSummary;
  final List<Recommendation> _recommendations;
  @override
  List<Recommendation> get recommendations {
    if (_recommendations is EqualUnmodifiableListView) return _recommendations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recommendations);
  }

  @override
  final OutcomePredictions outcomePredictions;
  final List<Alert> _alerts;
  @override
  List<Alert> get alerts {
    if (_alerts is EqualUnmodifiableListView) return _alerts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_alerts);
  }

  final List<NextAction> _nextActions;
  @override
  List<NextAction> get nextActions {
    if (_nextActions is EqualUnmodifiableListView) return _nextActions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_nextActions);
  }

  /// Create a copy of IntelligenceReport
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$IntelligenceReportCopyWith<_IntelligenceReport> get copyWith =>
      __$IntelligenceReportCopyWithImpl<_IntelligenceReport>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$IntelligenceReportToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _IntelligenceReport &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.generatedAt, generatedAt) ||
                other.generatedAt == generatedAt) &&
            (identical(other.intelligenceScore, intelligenceScore) ||
                other.intelligenceScore == intelligenceScore) &&
            (identical(other.riskSummary, riskSummary) ||
                other.riskSummary == riskSummary) &&
            const DeepCollectionEquality()
                .equals(other._recommendations, _recommendations) &&
            (identical(other.outcomePredictions, outcomePredictions) ||
                other.outcomePredictions == outcomePredictions) &&
            const DeepCollectionEquality().equals(other._alerts, _alerts) &&
            const DeepCollectionEquality()
                .equals(other._nextActions, _nextActions));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      clientId,
      organizationId,
      generatedAt,
      intelligenceScore,
      riskSummary,
      const DeepCollectionEquality().hash(_recommendations),
      outcomePredictions,
      const DeepCollectionEquality().hash(_alerts),
      const DeepCollectionEquality().hash(_nextActions));

  @override
  String toString() {
    return 'IntelligenceReport(clientId: $clientId, organizationId: $organizationId, generatedAt: $generatedAt, intelligenceScore: $intelligenceScore, riskSummary: $riskSummary, recommendations: $recommendations, outcomePredictions: $outcomePredictions, alerts: $alerts, nextActions: $nextActions)';
  }
}

/// @nodoc
abstract mixin class _$IntelligenceReportCopyWith<$Res>
    implements $IntelligenceReportCopyWith<$Res> {
  factory _$IntelligenceReportCopyWith(
          _IntelligenceReport value, $Res Function(_IntelligenceReport) _then) =
      __$IntelligenceReportCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String clientId,
      String organizationId,
      String generatedAt,
      int intelligenceScore,
      RiskSummary riskSummary,
      List<Recommendation> recommendations,
      OutcomePredictions outcomePredictions,
      List<Alert> alerts,
      List<NextAction> nextActions});

  @override
  $RiskSummaryCopyWith<$Res> get riskSummary;
  @override
  $OutcomePredictionsCopyWith<$Res> get outcomePredictions;
}

/// @nodoc
class __$IntelligenceReportCopyWithImpl<$Res>
    implements _$IntelligenceReportCopyWith<$Res> {
  __$IntelligenceReportCopyWithImpl(this._self, this._then);

  final _IntelligenceReport _self;
  final $Res Function(_IntelligenceReport) _then;

  /// Create a copy of IntelligenceReport
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? clientId = null,
    Object? organizationId = null,
    Object? generatedAt = null,
    Object? intelligenceScore = null,
    Object? riskSummary = null,
    Object? recommendations = null,
    Object? outcomePredictions = null,
    Object? alerts = null,
    Object? nextActions = null,
  }) {
    return _then(_IntelligenceReport(
      clientId: null == clientId
          ? _self.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: null == organizationId
          ? _self.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      generatedAt: null == generatedAt
          ? _self.generatedAt
          : generatedAt // ignore: cast_nullable_to_non_nullable
              as String,
      intelligenceScore: null == intelligenceScore
          ? _self.intelligenceScore
          : intelligenceScore // ignore: cast_nullable_to_non_nullable
              as int,
      riskSummary: null == riskSummary
          ? _self.riskSummary
          : riskSummary // ignore: cast_nullable_to_non_nullable
              as RiskSummary,
      recommendations: null == recommendations
          ? _self._recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as List<Recommendation>,
      outcomePredictions: null == outcomePredictions
          ? _self.outcomePredictions
          : outcomePredictions // ignore: cast_nullable_to_non_nullable
              as OutcomePredictions,
      alerts: null == alerts
          ? _self._alerts
          : alerts // ignore: cast_nullable_to_non_nullable
              as List<Alert>,
      nextActions: null == nextActions
          ? _self._nextActions
          : nextActions // ignore: cast_nullable_to_non_nullable
              as List<NextAction>,
    ));
  }

  /// Create a copy of IntelligenceReport
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RiskSummaryCopyWith<$Res> get riskSummary {
    return $RiskSummaryCopyWith<$Res>(_self.riskSummary, (value) {
      return _then(_self.copyWith(riskSummary: value));
    });
  }

  /// Create a copy of IntelligenceReport
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OutcomePredictionsCopyWith<$Res> get outcomePredictions {
    return $OutcomePredictionsCopyWith<$Res>(_self.outcomePredictions, (value) {
      return _then(_self.copyWith(outcomePredictions: value));
    });
  }
}

/// @nodoc
mixin _$RiskSummary {
  double get overallRisk;
  List<String> get highRiskAreas;
  String get trendDirection;
  String get lastAssessment;

  /// Create a copy of RiskSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RiskSummaryCopyWith<RiskSummary> get copyWith =>
      _$RiskSummaryCopyWithImpl<RiskSummary>(this as RiskSummary, _$identity);

  /// Serializes this RiskSummary to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RiskSummary &&
            (identical(other.overallRisk, overallRisk) ||
                other.overallRisk == overallRisk) &&
            const DeepCollectionEquality()
                .equals(other.highRiskAreas, highRiskAreas) &&
            (identical(other.trendDirection, trendDirection) ||
                other.trendDirection == trendDirection) &&
            (identical(other.lastAssessment, lastAssessment) ||
                other.lastAssessment == lastAssessment));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      overallRisk,
      const DeepCollectionEquality().hash(highRiskAreas),
      trendDirection,
      lastAssessment);

  @override
  String toString() {
    return 'RiskSummary(overallRisk: $overallRisk, highRiskAreas: $highRiskAreas, trendDirection: $trendDirection, lastAssessment: $lastAssessment)';
  }
}

/// @nodoc
abstract mixin class $RiskSummaryCopyWith<$Res> {
  factory $RiskSummaryCopyWith(
          RiskSummary value, $Res Function(RiskSummary) _then) =
      _$RiskSummaryCopyWithImpl;
  @useResult
  $Res call(
      {double overallRisk,
      List<String> highRiskAreas,
      String trendDirection,
      String lastAssessment});
}

/// @nodoc
class _$RiskSummaryCopyWithImpl<$Res> implements $RiskSummaryCopyWith<$Res> {
  _$RiskSummaryCopyWithImpl(this._self, this._then);

  final RiskSummary _self;
  final $Res Function(RiskSummary) _then;

  /// Create a copy of RiskSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? overallRisk = null,
    Object? highRiskAreas = null,
    Object? trendDirection = null,
    Object? lastAssessment = null,
  }) {
    return _then(_self.copyWith(
      overallRisk: null == overallRisk
          ? _self.overallRisk
          : overallRisk // ignore: cast_nullable_to_non_nullable
              as double,
      highRiskAreas: null == highRiskAreas
          ? _self.highRiskAreas
          : highRiskAreas // ignore: cast_nullable_to_non_nullable
              as List<String>,
      trendDirection: null == trendDirection
          ? _self.trendDirection
          : trendDirection // ignore: cast_nullable_to_non_nullable
              as String,
      lastAssessment: null == lastAssessment
          ? _self.lastAssessment
          : lastAssessment // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [RiskSummary].
extension RiskSummaryPatterns on RiskSummary {
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
    TResult Function(_RiskSummary value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RiskSummary() when $default != null:
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
    TResult Function(_RiskSummary value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RiskSummary():
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
    TResult? Function(_RiskSummary value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RiskSummary() when $default != null:
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
    TResult Function(double overallRisk, List<String> highRiskAreas,
            String trendDirection, String lastAssessment)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RiskSummary() when $default != null:
        return $default(_that.overallRisk, _that.highRiskAreas,
            _that.trendDirection, _that.lastAssessment);
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
    TResult Function(double overallRisk, List<String> highRiskAreas,
            String trendDirection, String lastAssessment)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RiskSummary():
        return $default(_that.overallRisk, _that.highRiskAreas,
            _that.trendDirection, _that.lastAssessment);
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
    TResult? Function(double overallRisk, List<String> highRiskAreas,
            String trendDirection, String lastAssessment)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RiskSummary() when $default != null:
        return $default(_that.overallRisk, _that.highRiskAreas,
            _that.trendDirection, _that.lastAssessment);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _RiskSummary implements RiskSummary {
  const _RiskSummary(
      {required this.overallRisk,
      required final List<String> highRiskAreas,
      required this.trendDirection,
      required this.lastAssessment})
      : _highRiskAreas = highRiskAreas;
  factory _RiskSummary.fromJson(Map<String, dynamic> json) =>
      _$RiskSummaryFromJson(json);

  @override
  final double overallRisk;
  final List<String> _highRiskAreas;
  @override
  List<String> get highRiskAreas {
    if (_highRiskAreas is EqualUnmodifiableListView) return _highRiskAreas;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_highRiskAreas);
  }

  @override
  final String trendDirection;
  @override
  final String lastAssessment;

  /// Create a copy of RiskSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RiskSummaryCopyWith<_RiskSummary> get copyWith =>
      __$RiskSummaryCopyWithImpl<_RiskSummary>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$RiskSummaryToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RiskSummary &&
            (identical(other.overallRisk, overallRisk) ||
                other.overallRisk == overallRisk) &&
            const DeepCollectionEquality()
                .equals(other._highRiskAreas, _highRiskAreas) &&
            (identical(other.trendDirection, trendDirection) ||
                other.trendDirection == trendDirection) &&
            (identical(other.lastAssessment, lastAssessment) ||
                other.lastAssessment == lastAssessment));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      overallRisk,
      const DeepCollectionEquality().hash(_highRiskAreas),
      trendDirection,
      lastAssessment);

  @override
  String toString() {
    return 'RiskSummary(overallRisk: $overallRisk, highRiskAreas: $highRiskAreas, trendDirection: $trendDirection, lastAssessment: $lastAssessment)';
  }
}

/// @nodoc
abstract mixin class _$RiskSummaryCopyWith<$Res>
    implements $RiskSummaryCopyWith<$Res> {
  factory _$RiskSummaryCopyWith(
          _RiskSummary value, $Res Function(_RiskSummary) _then) =
      __$RiskSummaryCopyWithImpl;
  @override
  @useResult
  $Res call(
      {double overallRisk,
      List<String> highRiskAreas,
      String trendDirection,
      String lastAssessment});
}

/// @nodoc
class __$RiskSummaryCopyWithImpl<$Res> implements _$RiskSummaryCopyWith<$Res> {
  __$RiskSummaryCopyWithImpl(this._self, this._then);

  final _RiskSummary _self;
  final $Res Function(_RiskSummary) _then;

  /// Create a copy of RiskSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? overallRisk = null,
    Object? highRiskAreas = null,
    Object? trendDirection = null,
    Object? lastAssessment = null,
  }) {
    return _then(_RiskSummary(
      overallRisk: null == overallRisk
          ? _self.overallRisk
          : overallRisk // ignore: cast_nullable_to_non_nullable
              as double,
      highRiskAreas: null == highRiskAreas
          ? _self._highRiskAreas
          : highRiskAreas // ignore: cast_nullable_to_non_nullable
              as List<String>,
      trendDirection: null == trendDirection
          ? _self.trendDirection
          : trendDirection // ignore: cast_nullable_to_non_nullable
              as String,
      lastAssessment: null == lastAssessment
          ? _self.lastAssessment
          : lastAssessment // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$Recommendation {
  String get category;
  String get recommendation;
  String get priority;
  String get expectedImpact;

  /// Create a copy of Recommendation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RecommendationCopyWith<Recommendation> get copyWith =>
      _$RecommendationCopyWithImpl<Recommendation>(
          this as Recommendation, _$identity);

  /// Serializes this Recommendation to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Recommendation &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.recommendation, recommendation) ||
                other.recommendation == recommendation) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.expectedImpact, expectedImpact) ||
                other.expectedImpact == expectedImpact));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, category, recommendation, priority, expectedImpact);

  @override
  String toString() {
    return 'Recommendation(category: $category, recommendation: $recommendation, priority: $priority, expectedImpact: $expectedImpact)';
  }
}

/// @nodoc
abstract mixin class $RecommendationCopyWith<$Res> {
  factory $RecommendationCopyWith(
          Recommendation value, $Res Function(Recommendation) _then) =
      _$RecommendationCopyWithImpl;
  @useResult
  $Res call(
      {String category,
      String recommendation,
      String priority,
      String expectedImpact});
}

/// @nodoc
class _$RecommendationCopyWithImpl<$Res>
    implements $RecommendationCopyWith<$Res> {
  _$RecommendationCopyWithImpl(this._self, this._then);

  final Recommendation _self;
  final $Res Function(Recommendation) _then;

  /// Create a copy of Recommendation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? category = null,
    Object? recommendation = null,
    Object? priority = null,
    Object? expectedImpact = null,
  }) {
    return _then(_self.copyWith(
      category: null == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      recommendation: null == recommendation
          ? _self.recommendation
          : recommendation // ignore: cast_nullable_to_non_nullable
              as String,
      priority: null == priority
          ? _self.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as String,
      expectedImpact: null == expectedImpact
          ? _self.expectedImpact
          : expectedImpact // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [Recommendation].
extension RecommendationPatterns on Recommendation {
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
    TResult Function(_Recommendation value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Recommendation() when $default != null:
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
    TResult Function(_Recommendation value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Recommendation():
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
    TResult? Function(_Recommendation value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Recommendation() when $default != null:
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
    TResult Function(String category, String recommendation, String priority,
            String expectedImpact)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Recommendation() when $default != null:
        return $default(_that.category, _that.recommendation, _that.priority,
            _that.expectedImpact);
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
    TResult Function(String category, String recommendation, String priority,
            String expectedImpact)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Recommendation():
        return $default(_that.category, _that.recommendation, _that.priority,
            _that.expectedImpact);
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
    TResult? Function(String category, String recommendation, String priority,
            String expectedImpact)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Recommendation() when $default != null:
        return $default(_that.category, _that.recommendation, _that.priority,
            _that.expectedImpact);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Recommendation implements Recommendation {
  const _Recommendation(
      {required this.category,
      required this.recommendation,
      required this.priority,
      required this.expectedImpact});
  factory _Recommendation.fromJson(Map<String, dynamic> json) =>
      _$RecommendationFromJson(json);

  @override
  final String category;
  @override
  final String recommendation;
  @override
  final String priority;
  @override
  final String expectedImpact;

  /// Create a copy of Recommendation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RecommendationCopyWith<_Recommendation> get copyWith =>
      __$RecommendationCopyWithImpl<_Recommendation>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$RecommendationToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Recommendation &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.recommendation, recommendation) ||
                other.recommendation == recommendation) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.expectedImpact, expectedImpact) ||
                other.expectedImpact == expectedImpact));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, category, recommendation, priority, expectedImpact);

  @override
  String toString() {
    return 'Recommendation(category: $category, recommendation: $recommendation, priority: $priority, expectedImpact: $expectedImpact)';
  }
}

/// @nodoc
abstract mixin class _$RecommendationCopyWith<$Res>
    implements $RecommendationCopyWith<$Res> {
  factory _$RecommendationCopyWith(
          _Recommendation value, $Res Function(_Recommendation) _then) =
      __$RecommendationCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String category,
      String recommendation,
      String priority,
      String expectedImpact});
}

/// @nodoc
class __$RecommendationCopyWithImpl<$Res>
    implements _$RecommendationCopyWith<$Res> {
  __$RecommendationCopyWithImpl(this._self, this._then);

  final _Recommendation _self;
  final $Res Function(_Recommendation) _then;

  /// Create a copy of Recommendation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? category = null,
    Object? recommendation = null,
    Object? priority = null,
    Object? expectedImpact = null,
  }) {
    return _then(_Recommendation(
      category: null == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      recommendation: null == recommendation
          ? _self.recommendation
          : recommendation // ignore: cast_nullable_to_non_nullable
              as String,
      priority: null == priority
          ? _self.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as String,
      expectedImpact: null == expectedImpact
          ? _self.expectedImpact
          : expectedImpact // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$OutcomePredictions {
  GoalAchievementPrediction get goalAchievement;
  HealthStabilityPrediction get healthStability;
  ServiceUtilizationPrediction get serviceUtilization;

  /// Create a copy of OutcomePredictions
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $OutcomePredictionsCopyWith<OutcomePredictions> get copyWith =>
      _$OutcomePredictionsCopyWithImpl<OutcomePredictions>(
          this as OutcomePredictions, _$identity);

  /// Serializes this OutcomePredictions to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is OutcomePredictions &&
            (identical(other.goalAchievement, goalAchievement) ||
                other.goalAchievement == goalAchievement) &&
            (identical(other.healthStability, healthStability) ||
                other.healthStability == healthStability) &&
            (identical(other.serviceUtilization, serviceUtilization) ||
                other.serviceUtilization == serviceUtilization));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, goalAchievement, healthStability, serviceUtilization);

  @override
  String toString() {
    return 'OutcomePredictions(goalAchievement: $goalAchievement, healthStability: $healthStability, serviceUtilization: $serviceUtilization)';
  }
}

/// @nodoc
abstract mixin class $OutcomePredictionsCopyWith<$Res> {
  factory $OutcomePredictionsCopyWith(
          OutcomePredictions value, $Res Function(OutcomePredictions) _then) =
      _$OutcomePredictionsCopyWithImpl;
  @useResult
  $Res call(
      {GoalAchievementPrediction goalAchievement,
      HealthStabilityPrediction healthStability,
      ServiceUtilizationPrediction serviceUtilization});

  $GoalAchievementPredictionCopyWith<$Res> get goalAchievement;
  $HealthStabilityPredictionCopyWith<$Res> get healthStability;
  $ServiceUtilizationPredictionCopyWith<$Res> get serviceUtilization;
}

/// @nodoc
class _$OutcomePredictionsCopyWithImpl<$Res>
    implements $OutcomePredictionsCopyWith<$Res> {
  _$OutcomePredictionsCopyWithImpl(this._self, this._then);

  final OutcomePredictions _self;
  final $Res Function(OutcomePredictions) _then;

  /// Create a copy of OutcomePredictions
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? goalAchievement = null,
    Object? healthStability = null,
    Object? serviceUtilization = null,
  }) {
    return _then(_self.copyWith(
      goalAchievement: null == goalAchievement
          ? _self.goalAchievement
          : goalAchievement // ignore: cast_nullable_to_non_nullable
              as GoalAchievementPrediction,
      healthStability: null == healthStability
          ? _self.healthStability
          : healthStability // ignore: cast_nullable_to_non_nullable
              as HealthStabilityPrediction,
      serviceUtilization: null == serviceUtilization
          ? _self.serviceUtilization
          : serviceUtilization // ignore: cast_nullable_to_non_nullable
              as ServiceUtilizationPrediction,
    ));
  }

  /// Create a copy of OutcomePredictions
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GoalAchievementPredictionCopyWith<$Res> get goalAchievement {
    return $GoalAchievementPredictionCopyWith<$Res>(_self.goalAchievement,
        (value) {
      return _then(_self.copyWith(goalAchievement: value));
    });
  }

  /// Create a copy of OutcomePredictions
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $HealthStabilityPredictionCopyWith<$Res> get healthStability {
    return $HealthStabilityPredictionCopyWith<$Res>(_self.healthStability,
        (value) {
      return _then(_self.copyWith(healthStability: value));
    });
  }

  /// Create a copy of OutcomePredictions
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ServiceUtilizationPredictionCopyWith<$Res> get serviceUtilization {
    return $ServiceUtilizationPredictionCopyWith<$Res>(_self.serviceUtilization,
        (value) {
      return _then(_self.copyWith(serviceUtilization: value));
    });
  }
}

/// Adds pattern-matching-related methods to [OutcomePredictions].
extension OutcomePredictionsPatterns on OutcomePredictions {
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
    TResult Function(_OutcomePredictions value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _OutcomePredictions() when $default != null:
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
    TResult Function(_OutcomePredictions value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OutcomePredictions():
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
    TResult? Function(_OutcomePredictions value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OutcomePredictions() when $default != null:
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
            GoalAchievementPrediction goalAchievement,
            HealthStabilityPrediction healthStability,
            ServiceUtilizationPrediction serviceUtilization)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _OutcomePredictions() when $default != null:
        return $default(_that.goalAchievement, _that.healthStability,
            _that.serviceUtilization);
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
            GoalAchievementPrediction goalAchievement,
            HealthStabilityPrediction healthStability,
            ServiceUtilizationPrediction serviceUtilization)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OutcomePredictions():
        return $default(_that.goalAchievement, _that.healthStability,
            _that.serviceUtilization);
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
            GoalAchievementPrediction goalAchievement,
            HealthStabilityPrediction healthStability,
            ServiceUtilizationPrediction serviceUtilization)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OutcomePredictions() when $default != null:
        return $default(_that.goalAchievement, _that.healthStability,
            _that.serviceUtilization);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _OutcomePredictions implements OutcomePredictions {
  const _OutcomePredictions(
      {required this.goalAchievement,
      required this.healthStability,
      required this.serviceUtilization});
  factory _OutcomePredictions.fromJson(Map<String, dynamic> json) =>
      _$OutcomePredictionsFromJson(json);

  @override
  final GoalAchievementPrediction goalAchievement;
  @override
  final HealthStabilityPrediction healthStability;
  @override
  final ServiceUtilizationPrediction serviceUtilization;

  /// Create a copy of OutcomePredictions
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$OutcomePredictionsCopyWith<_OutcomePredictions> get copyWith =>
      __$OutcomePredictionsCopyWithImpl<_OutcomePredictions>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$OutcomePredictionsToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _OutcomePredictions &&
            (identical(other.goalAchievement, goalAchievement) ||
                other.goalAchievement == goalAchievement) &&
            (identical(other.healthStability, healthStability) ||
                other.healthStability == healthStability) &&
            (identical(other.serviceUtilization, serviceUtilization) ||
                other.serviceUtilization == serviceUtilization));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, goalAchievement, healthStability, serviceUtilization);

  @override
  String toString() {
    return 'OutcomePredictions(goalAchievement: $goalAchievement, healthStability: $healthStability, serviceUtilization: $serviceUtilization)';
  }
}

/// @nodoc
abstract mixin class _$OutcomePredictionsCopyWith<$Res>
    implements $OutcomePredictionsCopyWith<$Res> {
  factory _$OutcomePredictionsCopyWith(
          _OutcomePredictions value, $Res Function(_OutcomePredictions) _then) =
      __$OutcomePredictionsCopyWithImpl;
  @override
  @useResult
  $Res call(
      {GoalAchievementPrediction goalAchievement,
      HealthStabilityPrediction healthStability,
      ServiceUtilizationPrediction serviceUtilization});

  @override
  $GoalAchievementPredictionCopyWith<$Res> get goalAchievement;
  @override
  $HealthStabilityPredictionCopyWith<$Res> get healthStability;
  @override
  $ServiceUtilizationPredictionCopyWith<$Res> get serviceUtilization;
}

/// @nodoc
class __$OutcomePredictionsCopyWithImpl<$Res>
    implements _$OutcomePredictionsCopyWith<$Res> {
  __$OutcomePredictionsCopyWithImpl(this._self, this._then);

  final _OutcomePredictions _self;
  final $Res Function(_OutcomePredictions) _then;

  /// Create a copy of OutcomePredictions
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? goalAchievement = null,
    Object? healthStability = null,
    Object? serviceUtilization = null,
  }) {
    return _then(_OutcomePredictions(
      goalAchievement: null == goalAchievement
          ? _self.goalAchievement
          : goalAchievement // ignore: cast_nullable_to_non_nullable
              as GoalAchievementPrediction,
      healthStability: null == healthStability
          ? _self.healthStability
          : healthStability // ignore: cast_nullable_to_non_nullable
              as HealthStabilityPrediction,
      serviceUtilization: null == serviceUtilization
          ? _self.serviceUtilization
          : serviceUtilization // ignore: cast_nullable_to_non_nullable
              as ServiceUtilizationPrediction,
    ));
  }

  /// Create a copy of OutcomePredictions
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GoalAchievementPredictionCopyWith<$Res> get goalAchievement {
    return $GoalAchievementPredictionCopyWith<$Res>(_self.goalAchievement,
        (value) {
      return _then(_self.copyWith(goalAchievement: value));
    });
  }

  /// Create a copy of OutcomePredictions
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $HealthStabilityPredictionCopyWith<$Res> get healthStability {
    return $HealthStabilityPredictionCopyWith<$Res>(_self.healthStability,
        (value) {
      return _then(_self.copyWith(healthStability: value));
    });
  }

  /// Create a copy of OutcomePredictions
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ServiceUtilizationPredictionCopyWith<$Res> get serviceUtilization {
    return $ServiceUtilizationPredictionCopyWith<$Res>(_self.serviceUtilization,
        (value) {
      return _then(_self.copyWith(serviceUtilization: value));
    });
  }
}

/// @nodoc
mixin _$GoalAchievementPrediction {
  double get probability;
  String get timeline;
  double get confidence;

  /// Create a copy of GoalAchievementPrediction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GoalAchievementPredictionCopyWith<GoalAchievementPrediction> get copyWith =>
      _$GoalAchievementPredictionCopyWithImpl<GoalAchievementPrediction>(
          this as GoalAchievementPrediction, _$identity);

  /// Serializes this GoalAchievementPrediction to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GoalAchievementPrediction &&
            (identical(other.probability, probability) ||
                other.probability == probability) &&
            (identical(other.timeline, timeline) ||
                other.timeline == timeline) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, probability, timeline, confidence);

  @override
  String toString() {
    return 'GoalAchievementPrediction(probability: $probability, timeline: $timeline, confidence: $confidence)';
  }
}

/// @nodoc
abstract mixin class $GoalAchievementPredictionCopyWith<$Res> {
  factory $GoalAchievementPredictionCopyWith(GoalAchievementPrediction value,
          $Res Function(GoalAchievementPrediction) _then) =
      _$GoalAchievementPredictionCopyWithImpl;
  @useResult
  $Res call({double probability, String timeline, double confidence});
}

/// @nodoc
class _$GoalAchievementPredictionCopyWithImpl<$Res>
    implements $GoalAchievementPredictionCopyWith<$Res> {
  _$GoalAchievementPredictionCopyWithImpl(this._self, this._then);

  final GoalAchievementPrediction _self;
  final $Res Function(GoalAchievementPrediction) _then;

  /// Create a copy of GoalAchievementPrediction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? probability = null,
    Object? timeline = null,
    Object? confidence = null,
  }) {
    return _then(_self.copyWith(
      probability: null == probability
          ? _self.probability
          : probability // ignore: cast_nullable_to_non_nullable
              as double,
      timeline: null == timeline
          ? _self.timeline
          : timeline // ignore: cast_nullable_to_non_nullable
              as String,
      confidence: null == confidence
          ? _self.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// Adds pattern-matching-related methods to [GoalAchievementPrediction].
extension GoalAchievementPredictionPatterns on GoalAchievementPrediction {
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
    TResult Function(_GoalAchievementPrediction value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GoalAchievementPrediction() when $default != null:
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
    TResult Function(_GoalAchievementPrediction value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GoalAchievementPrediction():
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
    TResult? Function(_GoalAchievementPrediction value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GoalAchievementPrediction() when $default != null:
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
    TResult Function(double probability, String timeline, double confidence)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GoalAchievementPrediction() when $default != null:
        return $default(_that.probability, _that.timeline, _that.confidence);
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
    TResult Function(double probability, String timeline, double confidence)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GoalAchievementPrediction():
        return $default(_that.probability, _that.timeline, _that.confidence);
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
    TResult? Function(double probability, String timeline, double confidence)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GoalAchievementPrediction() when $default != null:
        return $default(_that.probability, _that.timeline, _that.confidence);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _GoalAchievementPrediction implements GoalAchievementPrediction {
  const _GoalAchievementPrediction(
      {required this.probability,
      required this.timeline,
      required this.confidence});
  factory _GoalAchievementPrediction.fromJson(Map<String, dynamic> json) =>
      _$GoalAchievementPredictionFromJson(json);

  @override
  final double probability;
  @override
  final String timeline;
  @override
  final double confidence;

  /// Create a copy of GoalAchievementPrediction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GoalAchievementPredictionCopyWith<_GoalAchievementPrediction>
      get copyWith =>
          __$GoalAchievementPredictionCopyWithImpl<_GoalAchievementPrediction>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$GoalAchievementPredictionToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GoalAchievementPrediction &&
            (identical(other.probability, probability) ||
                other.probability == probability) &&
            (identical(other.timeline, timeline) ||
                other.timeline == timeline) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, probability, timeline, confidence);

  @override
  String toString() {
    return 'GoalAchievementPrediction(probability: $probability, timeline: $timeline, confidence: $confidence)';
  }
}

/// @nodoc
abstract mixin class _$GoalAchievementPredictionCopyWith<$Res>
    implements $GoalAchievementPredictionCopyWith<$Res> {
  factory _$GoalAchievementPredictionCopyWith(_GoalAchievementPrediction value,
          $Res Function(_GoalAchievementPrediction) _then) =
      __$GoalAchievementPredictionCopyWithImpl;
  @override
  @useResult
  $Res call({double probability, String timeline, double confidence});
}

/// @nodoc
class __$GoalAchievementPredictionCopyWithImpl<$Res>
    implements _$GoalAchievementPredictionCopyWith<$Res> {
  __$GoalAchievementPredictionCopyWithImpl(this._self, this._then);

  final _GoalAchievementPrediction _self;
  final $Res Function(_GoalAchievementPrediction) _then;

  /// Create a copy of GoalAchievementPrediction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? probability = null,
    Object? timeline = null,
    Object? confidence = null,
  }) {
    return _then(_GoalAchievementPrediction(
      probability: null == probability
          ? _self.probability
          : probability // ignore: cast_nullable_to_non_nullable
              as double,
      timeline: null == timeline
          ? _self.timeline
          : timeline // ignore: cast_nullable_to_non_nullable
              as String,
      confidence: null == confidence
          ? _self.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
mixin _$HealthStabilityPrediction {
  double get probability;
  List<String> get factors;
  double get confidence;

  /// Create a copy of HealthStabilityPrediction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $HealthStabilityPredictionCopyWith<HealthStabilityPrediction> get copyWith =>
      _$HealthStabilityPredictionCopyWithImpl<HealthStabilityPrediction>(
          this as HealthStabilityPrediction, _$identity);

  /// Serializes this HealthStabilityPrediction to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is HealthStabilityPrediction &&
            (identical(other.probability, probability) ||
                other.probability == probability) &&
            const DeepCollectionEquality().equals(other.factors, factors) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, probability,
      const DeepCollectionEquality().hash(factors), confidence);

  @override
  String toString() {
    return 'HealthStabilityPrediction(probability: $probability, factors: $factors, confidence: $confidence)';
  }
}

/// @nodoc
abstract mixin class $HealthStabilityPredictionCopyWith<$Res> {
  factory $HealthStabilityPredictionCopyWith(HealthStabilityPrediction value,
          $Res Function(HealthStabilityPrediction) _then) =
      _$HealthStabilityPredictionCopyWithImpl;
  @useResult
  $Res call({double probability, List<String> factors, double confidence});
}

/// @nodoc
class _$HealthStabilityPredictionCopyWithImpl<$Res>
    implements $HealthStabilityPredictionCopyWith<$Res> {
  _$HealthStabilityPredictionCopyWithImpl(this._self, this._then);

  final HealthStabilityPrediction _self;
  final $Res Function(HealthStabilityPrediction) _then;

  /// Create a copy of HealthStabilityPrediction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? probability = null,
    Object? factors = null,
    Object? confidence = null,
  }) {
    return _then(_self.copyWith(
      probability: null == probability
          ? _self.probability
          : probability // ignore: cast_nullable_to_non_nullable
              as double,
      factors: null == factors
          ? _self.factors
          : factors // ignore: cast_nullable_to_non_nullable
              as List<String>,
      confidence: null == confidence
          ? _self.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// Adds pattern-matching-related methods to [HealthStabilityPrediction].
extension HealthStabilityPredictionPatterns on HealthStabilityPrediction {
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
    TResult Function(_HealthStabilityPrediction value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _HealthStabilityPrediction() when $default != null:
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
    TResult Function(_HealthStabilityPrediction value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HealthStabilityPrediction():
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
    TResult? Function(_HealthStabilityPrediction value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HealthStabilityPrediction() when $default != null:
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
            double probability, List<String> factors, double confidence)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _HealthStabilityPrediction() when $default != null:
        return $default(_that.probability, _that.factors, _that.confidence);
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
            double probability, List<String> factors, double confidence)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HealthStabilityPrediction():
        return $default(_that.probability, _that.factors, _that.confidence);
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
            double probability, List<String> factors, double confidence)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HealthStabilityPrediction() when $default != null:
        return $default(_that.probability, _that.factors, _that.confidence);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _HealthStabilityPrediction implements HealthStabilityPrediction {
  const _HealthStabilityPrediction(
      {required this.probability,
      required final List<String> factors,
      required this.confidence})
      : _factors = factors;
  factory _HealthStabilityPrediction.fromJson(Map<String, dynamic> json) =>
      _$HealthStabilityPredictionFromJson(json);

  @override
  final double probability;
  final List<String> _factors;
  @override
  List<String> get factors {
    if (_factors is EqualUnmodifiableListView) return _factors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_factors);
  }

  @override
  final double confidence;

  /// Create a copy of HealthStabilityPrediction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$HealthStabilityPredictionCopyWith<_HealthStabilityPrediction>
      get copyWith =>
          __$HealthStabilityPredictionCopyWithImpl<_HealthStabilityPrediction>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$HealthStabilityPredictionToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _HealthStabilityPrediction &&
            (identical(other.probability, probability) ||
                other.probability == probability) &&
            const DeepCollectionEquality().equals(other._factors, _factors) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, probability,
      const DeepCollectionEquality().hash(_factors), confidence);

  @override
  String toString() {
    return 'HealthStabilityPrediction(probability: $probability, factors: $factors, confidence: $confidence)';
  }
}

/// @nodoc
abstract mixin class _$HealthStabilityPredictionCopyWith<$Res>
    implements $HealthStabilityPredictionCopyWith<$Res> {
  factory _$HealthStabilityPredictionCopyWith(_HealthStabilityPrediction value,
          $Res Function(_HealthStabilityPrediction) _then) =
      __$HealthStabilityPredictionCopyWithImpl;
  @override
  @useResult
  $Res call({double probability, List<String> factors, double confidence});
}

/// @nodoc
class __$HealthStabilityPredictionCopyWithImpl<$Res>
    implements _$HealthStabilityPredictionCopyWith<$Res> {
  __$HealthStabilityPredictionCopyWithImpl(this._self, this._then);

  final _HealthStabilityPrediction _self;
  final $Res Function(_HealthStabilityPrediction) _then;

  /// Create a copy of HealthStabilityPrediction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? probability = null,
    Object? factors = null,
    Object? confidence = null,
  }) {
    return _then(_HealthStabilityPrediction(
      probability: null == probability
          ? _self.probability
          : probability // ignore: cast_nullable_to_non_nullable
              as double,
      factors: null == factors
          ? _self._factors
          : factors // ignore: cast_nullable_to_non_nullable
              as List<String>,
      confidence: null == confidence
          ? _self.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
mixin _$ServiceUtilizationPrediction {
  String get predictedChange;
  int get percentage;
  double get confidence;

  /// Create a copy of ServiceUtilizationPrediction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ServiceUtilizationPredictionCopyWith<ServiceUtilizationPrediction>
      get copyWith => _$ServiceUtilizationPredictionCopyWithImpl<
              ServiceUtilizationPrediction>(
          this as ServiceUtilizationPrediction, _$identity);

  /// Serializes this ServiceUtilizationPrediction to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ServiceUtilizationPrediction &&
            (identical(other.predictedChange, predictedChange) ||
                other.predictedChange == predictedChange) &&
            (identical(other.percentage, percentage) ||
                other.percentage == percentage) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, predictedChange, percentage, confidence);

  @override
  String toString() {
    return 'ServiceUtilizationPrediction(predictedChange: $predictedChange, percentage: $percentage, confidence: $confidence)';
  }
}

/// @nodoc
abstract mixin class $ServiceUtilizationPredictionCopyWith<$Res> {
  factory $ServiceUtilizationPredictionCopyWith(
          ServiceUtilizationPrediction value,
          $Res Function(ServiceUtilizationPrediction) _then) =
      _$ServiceUtilizationPredictionCopyWithImpl;
  @useResult
  $Res call({String predictedChange, int percentage, double confidence});
}

/// @nodoc
class _$ServiceUtilizationPredictionCopyWithImpl<$Res>
    implements $ServiceUtilizationPredictionCopyWith<$Res> {
  _$ServiceUtilizationPredictionCopyWithImpl(this._self, this._then);

  final ServiceUtilizationPrediction _self;
  final $Res Function(ServiceUtilizationPrediction) _then;

  /// Create a copy of ServiceUtilizationPrediction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? predictedChange = null,
    Object? percentage = null,
    Object? confidence = null,
  }) {
    return _then(_self.copyWith(
      predictedChange: null == predictedChange
          ? _self.predictedChange
          : predictedChange // ignore: cast_nullable_to_non_nullable
              as String,
      percentage: null == percentage
          ? _self.percentage
          : percentage // ignore: cast_nullable_to_non_nullable
              as int,
      confidence: null == confidence
          ? _self.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// Adds pattern-matching-related methods to [ServiceUtilizationPrediction].
extension ServiceUtilizationPredictionPatterns on ServiceUtilizationPrediction {
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
    TResult Function(_ServiceUtilizationPrediction value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ServiceUtilizationPrediction() when $default != null:
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
    TResult Function(_ServiceUtilizationPrediction value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ServiceUtilizationPrediction():
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
    TResult? Function(_ServiceUtilizationPrediction value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ServiceUtilizationPrediction() when $default != null:
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
    TResult Function(String predictedChange, int percentage, double confidence)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ServiceUtilizationPrediction() when $default != null:
        return $default(
            _that.predictedChange, _that.percentage, _that.confidence);
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
    TResult Function(String predictedChange, int percentage, double confidence)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ServiceUtilizationPrediction():
        return $default(
            _that.predictedChange, _that.percentage, _that.confidence);
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
            String predictedChange, int percentage, double confidence)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ServiceUtilizationPrediction() when $default != null:
        return $default(
            _that.predictedChange, _that.percentage, _that.confidence);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ServiceUtilizationPrediction implements ServiceUtilizationPrediction {
  const _ServiceUtilizationPrediction(
      {required this.predictedChange,
      required this.percentage,
      required this.confidence});
  factory _ServiceUtilizationPrediction.fromJson(Map<String, dynamic> json) =>
      _$ServiceUtilizationPredictionFromJson(json);

  @override
  final String predictedChange;
  @override
  final int percentage;
  @override
  final double confidence;

  /// Create a copy of ServiceUtilizationPrediction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ServiceUtilizationPredictionCopyWith<_ServiceUtilizationPrediction>
      get copyWith => __$ServiceUtilizationPredictionCopyWithImpl<
          _ServiceUtilizationPrediction>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ServiceUtilizationPredictionToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ServiceUtilizationPrediction &&
            (identical(other.predictedChange, predictedChange) ||
                other.predictedChange == predictedChange) &&
            (identical(other.percentage, percentage) ||
                other.percentage == percentage) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, predictedChange, percentage, confidence);

  @override
  String toString() {
    return 'ServiceUtilizationPrediction(predictedChange: $predictedChange, percentage: $percentage, confidence: $confidence)';
  }
}

/// @nodoc
abstract mixin class _$ServiceUtilizationPredictionCopyWith<$Res>
    implements $ServiceUtilizationPredictionCopyWith<$Res> {
  factory _$ServiceUtilizationPredictionCopyWith(
          _ServiceUtilizationPrediction value,
          $Res Function(_ServiceUtilizationPrediction) _then) =
      __$ServiceUtilizationPredictionCopyWithImpl;
  @override
  @useResult
  $Res call({String predictedChange, int percentage, double confidence});
}

/// @nodoc
class __$ServiceUtilizationPredictionCopyWithImpl<$Res>
    implements _$ServiceUtilizationPredictionCopyWith<$Res> {
  __$ServiceUtilizationPredictionCopyWithImpl(this._self, this._then);

  final _ServiceUtilizationPrediction _self;
  final $Res Function(_ServiceUtilizationPrediction) _then;

  /// Create a copy of ServiceUtilizationPrediction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? predictedChange = null,
    Object? percentage = null,
    Object? confidence = null,
  }) {
    return _then(_ServiceUtilizationPrediction(
      predictedChange: null == predictedChange
          ? _self.predictedChange
          : predictedChange // ignore: cast_nullable_to_non_nullable
              as String,
      percentage: null == percentage
          ? _self.percentage
          : percentage // ignore: cast_nullable_to_non_nullable
              as int,
      confidence: null == confidence
          ? _self.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
mixin _$Alert {
  String get severity;
  String get type;
  String get message;
  String get action;

  /// Create a copy of Alert
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AlertCopyWith<Alert> get copyWith =>
      _$AlertCopyWithImpl<Alert>(this as Alert, _$identity);

  /// Serializes this Alert to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Alert &&
            (identical(other.severity, severity) ||
                other.severity == severity) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.action, action) || other.action == action));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, severity, type, message, action);

  @override
  String toString() {
    return 'Alert(severity: $severity, type: $type, message: $message, action: $action)';
  }
}

/// @nodoc
abstract mixin class $AlertCopyWith<$Res> {
  factory $AlertCopyWith(Alert value, $Res Function(Alert) _then) =
      _$AlertCopyWithImpl;
  @useResult
  $Res call({String severity, String type, String message, String action});
}

/// @nodoc
class _$AlertCopyWithImpl<$Res> implements $AlertCopyWith<$Res> {
  _$AlertCopyWithImpl(this._self, this._then);

  final Alert _self;
  final $Res Function(Alert) _then;

  /// Create a copy of Alert
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? severity = null,
    Object? type = null,
    Object? message = null,
    Object? action = null,
  }) {
    return _then(_self.copyWith(
      severity: null == severity
          ? _self.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      action: null == action
          ? _self.action
          : action // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [Alert].
extension AlertPatterns on Alert {
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
    TResult Function(_Alert value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Alert() when $default != null:
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
    TResult Function(_Alert value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Alert():
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
    TResult? Function(_Alert value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Alert() when $default != null:
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
            String severity, String type, String message, String action)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Alert() when $default != null:
        return $default(
            _that.severity, _that.type, _that.message, _that.action);
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
            String severity, String type, String message, String action)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Alert():
        return $default(
            _that.severity, _that.type, _that.message, _that.action);
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
            String severity, String type, String message, String action)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Alert() when $default != null:
        return $default(
            _that.severity, _that.type, _that.message, _that.action);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Alert implements Alert {
  const _Alert(
      {required this.severity,
      required this.type,
      required this.message,
      required this.action});
  factory _Alert.fromJson(Map<String, dynamic> json) => _$AlertFromJson(json);

  @override
  final String severity;
  @override
  final String type;
  @override
  final String message;
  @override
  final String action;

  /// Create a copy of Alert
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AlertCopyWith<_Alert> get copyWith =>
      __$AlertCopyWithImpl<_Alert>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AlertToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Alert &&
            (identical(other.severity, severity) ||
                other.severity == severity) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.action, action) || other.action == action));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, severity, type, message, action);

  @override
  String toString() {
    return 'Alert(severity: $severity, type: $type, message: $message, action: $action)';
  }
}

/// @nodoc
abstract mixin class _$AlertCopyWith<$Res> implements $AlertCopyWith<$Res> {
  factory _$AlertCopyWith(_Alert value, $Res Function(_Alert) _then) =
      __$AlertCopyWithImpl;
  @override
  @useResult
  $Res call({String severity, String type, String message, String action});
}

/// @nodoc
class __$AlertCopyWithImpl<$Res> implements _$AlertCopyWith<$Res> {
  __$AlertCopyWithImpl(this._self, this._then);

  final _Alert _self;
  final $Res Function(_Alert) _then;

  /// Create a copy of Alert
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? severity = null,
    Object? type = null,
    Object? message = null,
    Object? action = null,
  }) {
    return _then(_Alert(
      severity: null == severity
          ? _self.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      action: null == action
          ? _self.action
          : action // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$NextAction {
  String get action;
  String get priority;
  String get deadline;
  String get assignedTo;

  /// Create a copy of NextAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $NextActionCopyWith<NextAction> get copyWith =>
      _$NextActionCopyWithImpl<NextAction>(this as NextAction, _$identity);

  /// Serializes this NextAction to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is NextAction &&
            (identical(other.action, action) || other.action == action) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.deadline, deadline) ||
                other.deadline == deadline) &&
            (identical(other.assignedTo, assignedTo) ||
                other.assignedTo == assignedTo));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, action, priority, deadline, assignedTo);

  @override
  String toString() {
    return 'NextAction(action: $action, priority: $priority, deadline: $deadline, assignedTo: $assignedTo)';
  }
}

/// @nodoc
abstract mixin class $NextActionCopyWith<$Res> {
  factory $NextActionCopyWith(
          NextAction value, $Res Function(NextAction) _then) =
      _$NextActionCopyWithImpl;
  @useResult
  $Res call(
      {String action, String priority, String deadline, String assignedTo});
}

/// @nodoc
class _$NextActionCopyWithImpl<$Res> implements $NextActionCopyWith<$Res> {
  _$NextActionCopyWithImpl(this._self, this._then);

  final NextAction _self;
  final $Res Function(NextAction) _then;

  /// Create a copy of NextAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? action = null,
    Object? priority = null,
    Object? deadline = null,
    Object? assignedTo = null,
  }) {
    return _then(_self.copyWith(
      action: null == action
          ? _self.action
          : action // ignore: cast_nullable_to_non_nullable
              as String,
      priority: null == priority
          ? _self.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as String,
      deadline: null == deadline
          ? _self.deadline
          : deadline // ignore: cast_nullable_to_non_nullable
              as String,
      assignedTo: null == assignedTo
          ? _self.assignedTo
          : assignedTo // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [NextAction].
extension NextActionPatterns on NextAction {
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
    TResult Function(_NextAction value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _NextAction() when $default != null:
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
    TResult Function(_NextAction value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NextAction():
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
    TResult? Function(_NextAction value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NextAction() when $default != null:
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
            String action, String priority, String deadline, String assignedTo)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _NextAction() when $default != null:
        return $default(
            _that.action, _that.priority, _that.deadline, _that.assignedTo);
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
            String action, String priority, String deadline, String assignedTo)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NextAction():
        return $default(
            _that.action, _that.priority, _that.deadline, _that.assignedTo);
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
            String action, String priority, String deadline, String assignedTo)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NextAction() when $default != null:
        return $default(
            _that.action, _that.priority, _that.deadline, _that.assignedTo);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _NextAction implements NextAction {
  const _NextAction(
      {required this.action,
      required this.priority,
      required this.deadline,
      required this.assignedTo});
  factory _NextAction.fromJson(Map<String, dynamic> json) =>
      _$NextActionFromJson(json);

  @override
  final String action;
  @override
  final String priority;
  @override
  final String deadline;
  @override
  final String assignedTo;

  /// Create a copy of NextAction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$NextActionCopyWith<_NextAction> get copyWith =>
      __$NextActionCopyWithImpl<_NextAction>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$NextActionToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _NextAction &&
            (identical(other.action, action) || other.action == action) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.deadline, deadline) ||
                other.deadline == deadline) &&
            (identical(other.assignedTo, assignedTo) ||
                other.assignedTo == assignedTo));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, action, priority, deadline, assignedTo);

  @override
  String toString() {
    return 'NextAction(action: $action, priority: $priority, deadline: $deadline, assignedTo: $assignedTo)';
  }
}

/// @nodoc
abstract mixin class _$NextActionCopyWith<$Res>
    implements $NextActionCopyWith<$Res> {
  factory _$NextActionCopyWith(
          _NextAction value, $Res Function(_NextAction) _then) =
      __$NextActionCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String action, String priority, String deadline, String assignedTo});
}

/// @nodoc
class __$NextActionCopyWithImpl<$Res> implements _$NextActionCopyWith<$Res> {
  __$NextActionCopyWithImpl(this._self, this._then);

  final _NextAction _self;
  final $Res Function(_NextAction) _then;

  /// Create a copy of NextAction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? action = null,
    Object? priority = null,
    Object? deadline = null,
    Object? assignedTo = null,
  }) {
    return _then(_NextAction(
      action: null == action
          ? _self.action
          : action // ignore: cast_nullable_to_non_nullable
              as String,
      priority: null == priority
          ? _self.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as String,
      deadline: null == deadline
          ? _self.deadline
          : deadline // ignore: cast_nullable_to_non_nullable
              as String,
      assignedTo: null == assignedTo
          ? _self.assignedTo
          : assignedTo // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$CarePatterns {
  ServiceUtilization get serviceUtilization;
  HealthTrends get healthTrends;
  BehaviorPatterns get behaviorPatterns;
  GoalProgress get goalProgress;
  FamilyEngagement get familyEngagement;

  /// Create a copy of CarePatterns
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CarePatternsCopyWith<CarePatterns> get copyWith =>
      _$CarePatternsCopyWithImpl<CarePatterns>(
          this as CarePatterns, _$identity);

  /// Serializes this CarePatterns to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CarePatterns &&
            (identical(other.serviceUtilization, serviceUtilization) ||
                other.serviceUtilization == serviceUtilization) &&
            (identical(other.healthTrends, healthTrends) ||
                other.healthTrends == healthTrends) &&
            (identical(other.behaviorPatterns, behaviorPatterns) ||
                other.behaviorPatterns == behaviorPatterns) &&
            (identical(other.goalProgress, goalProgress) ||
                other.goalProgress == goalProgress) &&
            (identical(other.familyEngagement, familyEngagement) ||
                other.familyEngagement == familyEngagement));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, serviceUtilization, healthTrends,
      behaviorPatterns, goalProgress, familyEngagement);

  @override
  String toString() {
    return 'CarePatterns(serviceUtilization: $serviceUtilization, healthTrends: $healthTrends, behaviorPatterns: $behaviorPatterns, goalProgress: $goalProgress, familyEngagement: $familyEngagement)';
  }
}

/// @nodoc
abstract mixin class $CarePatternsCopyWith<$Res> {
  factory $CarePatternsCopyWith(
          CarePatterns value, $Res Function(CarePatterns) _then) =
      _$CarePatternsCopyWithImpl;
  @useResult
  $Res call(
      {ServiceUtilization serviceUtilization,
      HealthTrends healthTrends,
      BehaviorPatterns behaviorPatterns,
      GoalProgress goalProgress,
      FamilyEngagement familyEngagement});

  $ServiceUtilizationCopyWith<$Res> get serviceUtilization;
  $HealthTrendsCopyWith<$Res> get healthTrends;
  $BehaviorPatternsCopyWith<$Res> get behaviorPatterns;
  $GoalProgressCopyWith<$Res> get goalProgress;
  $FamilyEngagementCopyWith<$Res> get familyEngagement;
}

/// @nodoc
class _$CarePatternsCopyWithImpl<$Res> implements $CarePatternsCopyWith<$Res> {
  _$CarePatternsCopyWithImpl(this._self, this._then);

  final CarePatterns _self;
  final $Res Function(CarePatterns) _then;

  /// Create a copy of CarePatterns
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? serviceUtilization = null,
    Object? healthTrends = null,
    Object? behaviorPatterns = null,
    Object? goalProgress = null,
    Object? familyEngagement = null,
  }) {
    return _then(_self.copyWith(
      serviceUtilization: null == serviceUtilization
          ? _self.serviceUtilization
          : serviceUtilization // ignore: cast_nullable_to_non_nullable
              as ServiceUtilization,
      healthTrends: null == healthTrends
          ? _self.healthTrends
          : healthTrends // ignore: cast_nullable_to_non_nullable
              as HealthTrends,
      behaviorPatterns: null == behaviorPatterns
          ? _self.behaviorPatterns
          : behaviorPatterns // ignore: cast_nullable_to_non_nullable
              as BehaviorPatterns,
      goalProgress: null == goalProgress
          ? _self.goalProgress
          : goalProgress // ignore: cast_nullable_to_non_nullable
              as GoalProgress,
      familyEngagement: null == familyEngagement
          ? _self.familyEngagement
          : familyEngagement // ignore: cast_nullable_to_non_nullable
              as FamilyEngagement,
    ));
  }

  /// Create a copy of CarePatterns
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ServiceUtilizationCopyWith<$Res> get serviceUtilization {
    return $ServiceUtilizationCopyWith<$Res>(_self.serviceUtilization, (value) {
      return _then(_self.copyWith(serviceUtilization: value));
    });
  }

  /// Create a copy of CarePatterns
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $HealthTrendsCopyWith<$Res> get healthTrends {
    return $HealthTrendsCopyWith<$Res>(_self.healthTrends, (value) {
      return _then(_self.copyWith(healthTrends: value));
    });
  }

  /// Create a copy of CarePatterns
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BehaviorPatternsCopyWith<$Res> get behaviorPatterns {
    return $BehaviorPatternsCopyWith<$Res>(_self.behaviorPatterns, (value) {
      return _then(_self.copyWith(behaviorPatterns: value));
    });
  }

  /// Create a copy of CarePatterns
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GoalProgressCopyWith<$Res> get goalProgress {
    return $GoalProgressCopyWith<$Res>(_self.goalProgress, (value) {
      return _then(_self.copyWith(goalProgress: value));
    });
  }

  /// Create a copy of CarePatterns
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FamilyEngagementCopyWith<$Res> get familyEngagement {
    return $FamilyEngagementCopyWith<$Res>(_self.familyEngagement, (value) {
      return _then(_self.copyWith(familyEngagement: value));
    });
  }
}

/// Adds pattern-matching-related methods to [CarePatterns].
extension CarePatternsPatterns on CarePatterns {
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
    TResult Function(_CarePatterns value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CarePatterns() when $default != null:
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
    TResult Function(_CarePatterns value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CarePatterns():
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
    TResult? Function(_CarePatterns value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CarePatterns() when $default != null:
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
            ServiceUtilization serviceUtilization,
            HealthTrends healthTrends,
            BehaviorPatterns behaviorPatterns,
            GoalProgress goalProgress,
            FamilyEngagement familyEngagement)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CarePatterns() when $default != null:
        return $default(_that.serviceUtilization, _that.healthTrends,
            _that.behaviorPatterns, _that.goalProgress, _that.familyEngagement);
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
            ServiceUtilization serviceUtilization,
            HealthTrends healthTrends,
            BehaviorPatterns behaviorPatterns,
            GoalProgress goalProgress,
            FamilyEngagement familyEngagement)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CarePatterns():
        return $default(_that.serviceUtilization, _that.healthTrends,
            _that.behaviorPatterns, _that.goalProgress, _that.familyEngagement);
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
            ServiceUtilization serviceUtilization,
            HealthTrends healthTrends,
            BehaviorPatterns behaviorPatterns,
            GoalProgress goalProgress,
            FamilyEngagement familyEngagement)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CarePatterns() when $default != null:
        return $default(_that.serviceUtilization, _that.healthTrends,
            _that.behaviorPatterns, _that.goalProgress, _that.familyEngagement);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _CarePatterns implements CarePatterns {
  const _CarePatterns(
      {required this.serviceUtilization,
      required this.healthTrends,
      required this.behaviorPatterns,
      required this.goalProgress,
      required this.familyEngagement});
  factory _CarePatterns.fromJson(Map<String, dynamic> json) =>
      _$CarePatternsFromJson(json);

  @override
  final ServiceUtilization serviceUtilization;
  @override
  final HealthTrends healthTrends;
  @override
  final BehaviorPatterns behaviorPatterns;
  @override
  final GoalProgress goalProgress;
  @override
  final FamilyEngagement familyEngagement;

  /// Create a copy of CarePatterns
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CarePatternsCopyWith<_CarePatterns> get copyWith =>
      __$CarePatternsCopyWithImpl<_CarePatterns>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CarePatternsToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CarePatterns &&
            (identical(other.serviceUtilization, serviceUtilization) ||
                other.serviceUtilization == serviceUtilization) &&
            (identical(other.healthTrends, healthTrends) ||
                other.healthTrends == healthTrends) &&
            (identical(other.behaviorPatterns, behaviorPatterns) ||
                other.behaviorPatterns == behaviorPatterns) &&
            (identical(other.goalProgress, goalProgress) ||
                other.goalProgress == goalProgress) &&
            (identical(other.familyEngagement, familyEngagement) ||
                other.familyEngagement == familyEngagement));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, serviceUtilization, healthTrends,
      behaviorPatterns, goalProgress, familyEngagement);

  @override
  String toString() {
    return 'CarePatterns(serviceUtilization: $serviceUtilization, healthTrends: $healthTrends, behaviorPatterns: $behaviorPatterns, goalProgress: $goalProgress, familyEngagement: $familyEngagement)';
  }
}

/// @nodoc
abstract mixin class _$CarePatternsCopyWith<$Res>
    implements $CarePatternsCopyWith<$Res> {
  factory _$CarePatternsCopyWith(
          _CarePatterns value, $Res Function(_CarePatterns) _then) =
      __$CarePatternsCopyWithImpl;
  @override
  @useResult
  $Res call(
      {ServiceUtilization serviceUtilization,
      HealthTrends healthTrends,
      BehaviorPatterns behaviorPatterns,
      GoalProgress goalProgress,
      FamilyEngagement familyEngagement});

  @override
  $ServiceUtilizationCopyWith<$Res> get serviceUtilization;
  @override
  $HealthTrendsCopyWith<$Res> get healthTrends;
  @override
  $BehaviorPatternsCopyWith<$Res> get behaviorPatterns;
  @override
  $GoalProgressCopyWith<$Res> get goalProgress;
  @override
  $FamilyEngagementCopyWith<$Res> get familyEngagement;
}

/// @nodoc
class __$CarePatternsCopyWithImpl<$Res>
    implements _$CarePatternsCopyWith<$Res> {
  __$CarePatternsCopyWithImpl(this._self, this._then);

  final _CarePatterns _self;
  final $Res Function(_CarePatterns) _then;

  /// Create a copy of CarePatterns
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? serviceUtilization = null,
    Object? healthTrends = null,
    Object? behaviorPatterns = null,
    Object? goalProgress = null,
    Object? familyEngagement = null,
  }) {
    return _then(_CarePatterns(
      serviceUtilization: null == serviceUtilization
          ? _self.serviceUtilization
          : serviceUtilization // ignore: cast_nullable_to_non_nullable
              as ServiceUtilization,
      healthTrends: null == healthTrends
          ? _self.healthTrends
          : healthTrends // ignore: cast_nullable_to_non_nullable
              as HealthTrends,
      behaviorPatterns: null == behaviorPatterns
          ? _self.behaviorPatterns
          : behaviorPatterns // ignore: cast_nullable_to_non_nullable
              as BehaviorPatterns,
      goalProgress: null == goalProgress
          ? _self.goalProgress
          : goalProgress // ignore: cast_nullable_to_non_nullable
              as GoalProgress,
      familyEngagement: null == familyEngagement
          ? _self.familyEngagement
          : familyEngagement // ignore: cast_nullable_to_non_nullable
              as FamilyEngagement,
    ));
  }

  /// Create a copy of CarePatterns
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ServiceUtilizationCopyWith<$Res> get serviceUtilization {
    return $ServiceUtilizationCopyWith<$Res>(_self.serviceUtilization, (value) {
      return _then(_self.copyWith(serviceUtilization: value));
    });
  }

  /// Create a copy of CarePatterns
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $HealthTrendsCopyWith<$Res> get healthTrends {
    return $HealthTrendsCopyWith<$Res>(_self.healthTrends, (value) {
      return _then(_self.copyWith(healthTrends: value));
    });
  }

  /// Create a copy of CarePatterns
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BehaviorPatternsCopyWith<$Res> get behaviorPatterns {
    return $BehaviorPatternsCopyWith<$Res>(_self.behaviorPatterns, (value) {
      return _then(_self.copyWith(behaviorPatterns: value));
    });
  }

  /// Create a copy of CarePatterns
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GoalProgressCopyWith<$Res> get goalProgress {
    return $GoalProgressCopyWith<$Res>(_self.goalProgress, (value) {
      return _then(_self.copyWith(goalProgress: value));
    });
  }

  /// Create a copy of CarePatterns
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FamilyEngagementCopyWith<$Res> get familyEngagement {
    return $FamilyEngagementCopyWith<$Res>(_self.familyEngagement, (value) {
      return _then(_self.copyWith(familyEngagement: value));
    });
  }
}

/// @nodoc
mixin _$ServiceUtilization {
  String get trend;
  int get averageHoursPerWeek;
  List<String> get peakDays;
  List<String> get preferredTimes;

  /// Create a copy of ServiceUtilization
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ServiceUtilizationCopyWith<ServiceUtilization> get copyWith =>
      _$ServiceUtilizationCopyWithImpl<ServiceUtilization>(
          this as ServiceUtilization, _$identity);

  /// Serializes this ServiceUtilization to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ServiceUtilization &&
            (identical(other.trend, trend) || other.trend == trend) &&
            (identical(other.averageHoursPerWeek, averageHoursPerWeek) ||
                other.averageHoursPerWeek == averageHoursPerWeek) &&
            const DeepCollectionEquality().equals(other.peakDays, peakDays) &&
            const DeepCollectionEquality()
                .equals(other.preferredTimes, preferredTimes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      trend,
      averageHoursPerWeek,
      const DeepCollectionEquality().hash(peakDays),
      const DeepCollectionEquality().hash(preferredTimes));

  @override
  String toString() {
    return 'ServiceUtilization(trend: $trend, averageHoursPerWeek: $averageHoursPerWeek, peakDays: $peakDays, preferredTimes: $preferredTimes)';
  }
}

/// @nodoc
abstract mixin class $ServiceUtilizationCopyWith<$Res> {
  factory $ServiceUtilizationCopyWith(
          ServiceUtilization value, $Res Function(ServiceUtilization) _then) =
      _$ServiceUtilizationCopyWithImpl;
  @useResult
  $Res call(
      {String trend,
      int averageHoursPerWeek,
      List<String> peakDays,
      List<String> preferredTimes});
}

/// @nodoc
class _$ServiceUtilizationCopyWithImpl<$Res>
    implements $ServiceUtilizationCopyWith<$Res> {
  _$ServiceUtilizationCopyWithImpl(this._self, this._then);

  final ServiceUtilization _self;
  final $Res Function(ServiceUtilization) _then;

  /// Create a copy of ServiceUtilization
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? trend = null,
    Object? averageHoursPerWeek = null,
    Object? peakDays = null,
    Object? preferredTimes = null,
  }) {
    return _then(_self.copyWith(
      trend: null == trend
          ? _self.trend
          : trend // ignore: cast_nullable_to_non_nullable
              as String,
      averageHoursPerWeek: null == averageHoursPerWeek
          ? _self.averageHoursPerWeek
          : averageHoursPerWeek // ignore: cast_nullable_to_non_nullable
              as int,
      peakDays: null == peakDays
          ? _self.peakDays
          : peakDays // ignore: cast_nullable_to_non_nullable
              as List<String>,
      preferredTimes: null == preferredTimes
          ? _self.preferredTimes
          : preferredTimes // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// Adds pattern-matching-related methods to [ServiceUtilization].
extension ServiceUtilizationPatterns on ServiceUtilization {
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
    TResult Function(_ServiceUtilization value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ServiceUtilization() when $default != null:
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
    TResult Function(_ServiceUtilization value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ServiceUtilization():
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
    TResult? Function(_ServiceUtilization value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ServiceUtilization() when $default != null:
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
    TResult Function(String trend, int averageHoursPerWeek,
            List<String> peakDays, List<String> preferredTimes)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ServiceUtilization() when $default != null:
        return $default(_that.trend, _that.averageHoursPerWeek, _that.peakDays,
            _that.preferredTimes);
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
    TResult Function(String trend, int averageHoursPerWeek,
            List<String> peakDays, List<String> preferredTimes)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ServiceUtilization():
        return $default(_that.trend, _that.averageHoursPerWeek, _that.peakDays,
            _that.preferredTimes);
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
    TResult? Function(String trend, int averageHoursPerWeek,
            List<String> peakDays, List<String> preferredTimes)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ServiceUtilization() when $default != null:
        return $default(_that.trend, _that.averageHoursPerWeek, _that.peakDays,
            _that.preferredTimes);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ServiceUtilization implements ServiceUtilization {
  const _ServiceUtilization(
      {required this.trend,
      required this.averageHoursPerWeek,
      required final List<String> peakDays,
      required final List<String> preferredTimes})
      : _peakDays = peakDays,
        _preferredTimes = preferredTimes;
  factory _ServiceUtilization.fromJson(Map<String, dynamic> json) =>
      _$ServiceUtilizationFromJson(json);

  @override
  final String trend;
  @override
  final int averageHoursPerWeek;
  final List<String> _peakDays;
  @override
  List<String> get peakDays {
    if (_peakDays is EqualUnmodifiableListView) return _peakDays;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_peakDays);
  }

  final List<String> _preferredTimes;
  @override
  List<String> get preferredTimes {
    if (_preferredTimes is EqualUnmodifiableListView) return _preferredTimes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_preferredTimes);
  }

  /// Create a copy of ServiceUtilization
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ServiceUtilizationCopyWith<_ServiceUtilization> get copyWith =>
      __$ServiceUtilizationCopyWithImpl<_ServiceUtilization>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ServiceUtilizationToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ServiceUtilization &&
            (identical(other.trend, trend) || other.trend == trend) &&
            (identical(other.averageHoursPerWeek, averageHoursPerWeek) ||
                other.averageHoursPerWeek == averageHoursPerWeek) &&
            const DeepCollectionEquality().equals(other._peakDays, _peakDays) &&
            const DeepCollectionEquality()
                .equals(other._preferredTimes, _preferredTimes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      trend,
      averageHoursPerWeek,
      const DeepCollectionEquality().hash(_peakDays),
      const DeepCollectionEquality().hash(_preferredTimes));

  @override
  String toString() {
    return 'ServiceUtilization(trend: $trend, averageHoursPerWeek: $averageHoursPerWeek, peakDays: $peakDays, preferredTimes: $preferredTimes)';
  }
}

/// @nodoc
abstract mixin class _$ServiceUtilizationCopyWith<$Res>
    implements $ServiceUtilizationCopyWith<$Res> {
  factory _$ServiceUtilizationCopyWith(
          _ServiceUtilization value, $Res Function(_ServiceUtilization) _then) =
      __$ServiceUtilizationCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String trend,
      int averageHoursPerWeek,
      List<String> peakDays,
      List<String> preferredTimes});
}

/// @nodoc
class __$ServiceUtilizationCopyWithImpl<$Res>
    implements _$ServiceUtilizationCopyWith<$Res> {
  __$ServiceUtilizationCopyWithImpl(this._self, this._then);

  final _ServiceUtilization _self;
  final $Res Function(_ServiceUtilization) _then;

  /// Create a copy of ServiceUtilization
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? trend = null,
    Object? averageHoursPerWeek = null,
    Object? peakDays = null,
    Object? preferredTimes = null,
  }) {
    return _then(_ServiceUtilization(
      trend: null == trend
          ? _self.trend
          : trend // ignore: cast_nullable_to_non_nullable
              as String,
      averageHoursPerWeek: null == averageHoursPerWeek
          ? _self.averageHoursPerWeek
          : averageHoursPerWeek // ignore: cast_nullable_to_non_nullable
              as int,
      peakDays: null == peakDays
          ? _self._peakDays
          : peakDays // ignore: cast_nullable_to_non_nullable
              as List<String>,
      preferredTimes: null == preferredTimes
          ? _self._preferredTimes
          : preferredTimes // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
mixin _$HealthTrends {
  double get vitalStability;
  double get medicationCompliance;
  int get incidentFrequency;
  String get overallTrend;

  /// Create a copy of HealthTrends
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $HealthTrendsCopyWith<HealthTrends> get copyWith =>
      _$HealthTrendsCopyWithImpl<HealthTrends>(
          this as HealthTrends, _$identity);

  /// Serializes this HealthTrends to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is HealthTrends &&
            (identical(other.vitalStability, vitalStability) ||
                other.vitalStability == vitalStability) &&
            (identical(other.medicationCompliance, medicationCompliance) ||
                other.medicationCompliance == medicationCompliance) &&
            (identical(other.incidentFrequency, incidentFrequency) ||
                other.incidentFrequency == incidentFrequency) &&
            (identical(other.overallTrend, overallTrend) ||
                other.overallTrend == overallTrend));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, vitalStability,
      medicationCompliance, incidentFrequency, overallTrend);

  @override
  String toString() {
    return 'HealthTrends(vitalStability: $vitalStability, medicationCompliance: $medicationCompliance, incidentFrequency: $incidentFrequency, overallTrend: $overallTrend)';
  }
}

/// @nodoc
abstract mixin class $HealthTrendsCopyWith<$Res> {
  factory $HealthTrendsCopyWith(
          HealthTrends value, $Res Function(HealthTrends) _then) =
      _$HealthTrendsCopyWithImpl;
  @useResult
  $Res call(
      {double vitalStability,
      double medicationCompliance,
      int incidentFrequency,
      String overallTrend});
}

/// @nodoc
class _$HealthTrendsCopyWithImpl<$Res> implements $HealthTrendsCopyWith<$Res> {
  _$HealthTrendsCopyWithImpl(this._self, this._then);

  final HealthTrends _self;
  final $Res Function(HealthTrends) _then;

  /// Create a copy of HealthTrends
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? vitalStability = null,
    Object? medicationCompliance = null,
    Object? incidentFrequency = null,
    Object? overallTrend = null,
  }) {
    return _then(_self.copyWith(
      vitalStability: null == vitalStability
          ? _self.vitalStability
          : vitalStability // ignore: cast_nullable_to_non_nullable
              as double,
      medicationCompliance: null == medicationCompliance
          ? _self.medicationCompliance
          : medicationCompliance // ignore: cast_nullable_to_non_nullable
              as double,
      incidentFrequency: null == incidentFrequency
          ? _self.incidentFrequency
          : incidentFrequency // ignore: cast_nullable_to_non_nullable
              as int,
      overallTrend: null == overallTrend
          ? _self.overallTrend
          : overallTrend // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [HealthTrends].
extension HealthTrendsPatterns on HealthTrends {
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
    TResult Function(_HealthTrends value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _HealthTrends() when $default != null:
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
    TResult Function(_HealthTrends value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HealthTrends():
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
    TResult? Function(_HealthTrends value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HealthTrends() when $default != null:
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
    TResult Function(double vitalStability, double medicationCompliance,
            int incidentFrequency, String overallTrend)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _HealthTrends() when $default != null:
        return $default(_that.vitalStability, _that.medicationCompliance,
            _that.incidentFrequency, _that.overallTrend);
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
    TResult Function(double vitalStability, double medicationCompliance,
            int incidentFrequency, String overallTrend)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HealthTrends():
        return $default(_that.vitalStability, _that.medicationCompliance,
            _that.incidentFrequency, _that.overallTrend);
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
    TResult? Function(double vitalStability, double medicationCompliance,
            int incidentFrequency, String overallTrend)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HealthTrends() when $default != null:
        return $default(_that.vitalStability, _that.medicationCompliance,
            _that.incidentFrequency, _that.overallTrend);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _HealthTrends implements HealthTrends {
  const _HealthTrends(
      {required this.vitalStability,
      required this.medicationCompliance,
      required this.incidentFrequency,
      required this.overallTrend});
  factory _HealthTrends.fromJson(Map<String, dynamic> json) =>
      _$HealthTrendsFromJson(json);

  @override
  final double vitalStability;
  @override
  final double medicationCompliance;
  @override
  final int incidentFrequency;
  @override
  final String overallTrend;

  /// Create a copy of HealthTrends
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$HealthTrendsCopyWith<_HealthTrends> get copyWith =>
      __$HealthTrendsCopyWithImpl<_HealthTrends>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$HealthTrendsToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _HealthTrends &&
            (identical(other.vitalStability, vitalStability) ||
                other.vitalStability == vitalStability) &&
            (identical(other.medicationCompliance, medicationCompliance) ||
                other.medicationCompliance == medicationCompliance) &&
            (identical(other.incidentFrequency, incidentFrequency) ||
                other.incidentFrequency == incidentFrequency) &&
            (identical(other.overallTrend, overallTrend) ||
                other.overallTrend == overallTrend));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, vitalStability,
      medicationCompliance, incidentFrequency, overallTrend);

  @override
  String toString() {
    return 'HealthTrends(vitalStability: $vitalStability, medicationCompliance: $medicationCompliance, incidentFrequency: $incidentFrequency, overallTrend: $overallTrend)';
  }
}

/// @nodoc
abstract mixin class _$HealthTrendsCopyWith<$Res>
    implements $HealthTrendsCopyWith<$Res> {
  factory _$HealthTrendsCopyWith(
          _HealthTrends value, $Res Function(_HealthTrends) _then) =
      __$HealthTrendsCopyWithImpl;
  @override
  @useResult
  $Res call(
      {double vitalStability,
      double medicationCompliance,
      int incidentFrequency,
      String overallTrend});
}

/// @nodoc
class __$HealthTrendsCopyWithImpl<$Res>
    implements _$HealthTrendsCopyWith<$Res> {
  __$HealthTrendsCopyWithImpl(this._self, this._then);

  final _HealthTrends _self;
  final $Res Function(_HealthTrends) _then;

  /// Create a copy of HealthTrends
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? vitalStability = null,
    Object? medicationCompliance = null,
    Object? incidentFrequency = null,
    Object? overallTrend = null,
  }) {
    return _then(_HealthTrends(
      vitalStability: null == vitalStability
          ? _self.vitalStability
          : vitalStability // ignore: cast_nullable_to_non_nullable
              as double,
      medicationCompliance: null == medicationCompliance
          ? _self.medicationCompliance
          : medicationCompliance // ignore: cast_nullable_to_non_nullable
              as double,
      incidentFrequency: null == incidentFrequency
          ? _self.incidentFrequency
          : incidentFrequency // ignore: cast_nullable_to_non_nullable
              as int,
      overallTrend: null == overallTrend
          ? _self.overallTrend
          : overallTrend // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$BehaviorPatterns {
  int get positiveInteractions;
  int get challengingBehaviors;
  List<String> get triggerPatterns;
  double get responseEffectiveness;

  /// Create a copy of BehaviorPatterns
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BehaviorPatternsCopyWith<BehaviorPatterns> get copyWith =>
      _$BehaviorPatternsCopyWithImpl<BehaviorPatterns>(
          this as BehaviorPatterns, _$identity);

  /// Serializes this BehaviorPatterns to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BehaviorPatterns &&
            (identical(other.positiveInteractions, positiveInteractions) ||
                other.positiveInteractions == positiveInteractions) &&
            (identical(other.challengingBehaviors, challengingBehaviors) ||
                other.challengingBehaviors == challengingBehaviors) &&
            const DeepCollectionEquality()
                .equals(other.triggerPatterns, triggerPatterns) &&
            (identical(other.responseEffectiveness, responseEffectiveness) ||
                other.responseEffectiveness == responseEffectiveness));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      positiveInteractions,
      challengingBehaviors,
      const DeepCollectionEquality().hash(triggerPatterns),
      responseEffectiveness);

  @override
  String toString() {
    return 'BehaviorPatterns(positiveInteractions: $positiveInteractions, challengingBehaviors: $challengingBehaviors, triggerPatterns: $triggerPatterns, responseEffectiveness: $responseEffectiveness)';
  }
}

/// @nodoc
abstract mixin class $BehaviorPatternsCopyWith<$Res> {
  factory $BehaviorPatternsCopyWith(
          BehaviorPatterns value, $Res Function(BehaviorPatterns) _then) =
      _$BehaviorPatternsCopyWithImpl;
  @useResult
  $Res call(
      {int positiveInteractions,
      int challengingBehaviors,
      List<String> triggerPatterns,
      double responseEffectiveness});
}

/// @nodoc
class _$BehaviorPatternsCopyWithImpl<$Res>
    implements $BehaviorPatternsCopyWith<$Res> {
  _$BehaviorPatternsCopyWithImpl(this._self, this._then);

  final BehaviorPatterns _self;
  final $Res Function(BehaviorPatterns) _then;

  /// Create a copy of BehaviorPatterns
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? positiveInteractions = null,
    Object? challengingBehaviors = null,
    Object? triggerPatterns = null,
    Object? responseEffectiveness = null,
  }) {
    return _then(_self.copyWith(
      positiveInteractions: null == positiveInteractions
          ? _self.positiveInteractions
          : positiveInteractions // ignore: cast_nullable_to_non_nullable
              as int,
      challengingBehaviors: null == challengingBehaviors
          ? _self.challengingBehaviors
          : challengingBehaviors // ignore: cast_nullable_to_non_nullable
              as int,
      triggerPatterns: null == triggerPatterns
          ? _self.triggerPatterns
          : triggerPatterns // ignore: cast_nullable_to_non_nullable
              as List<String>,
      responseEffectiveness: null == responseEffectiveness
          ? _self.responseEffectiveness
          : responseEffectiveness // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// Adds pattern-matching-related methods to [BehaviorPatterns].
extension BehaviorPatternsPatterns on BehaviorPatterns {
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
    TResult Function(_BehaviorPatterns value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BehaviorPatterns() when $default != null:
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
    TResult Function(_BehaviorPatterns value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BehaviorPatterns():
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
    TResult? Function(_BehaviorPatterns value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BehaviorPatterns() when $default != null:
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
    TResult Function(int positiveInteractions, int challengingBehaviors,
            List<String> triggerPatterns, double responseEffectiveness)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BehaviorPatterns() when $default != null:
        return $default(_that.positiveInteractions, _that.challengingBehaviors,
            _that.triggerPatterns, _that.responseEffectiveness);
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
    TResult Function(int positiveInteractions, int challengingBehaviors,
            List<String> triggerPatterns, double responseEffectiveness)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BehaviorPatterns():
        return $default(_that.positiveInteractions, _that.challengingBehaviors,
            _that.triggerPatterns, _that.responseEffectiveness);
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
    TResult? Function(int positiveInteractions, int challengingBehaviors,
            List<String> triggerPatterns, double responseEffectiveness)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BehaviorPatterns() when $default != null:
        return $default(_that.positiveInteractions, _that.challengingBehaviors,
            _that.triggerPatterns, _that.responseEffectiveness);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _BehaviorPatterns implements BehaviorPatterns {
  const _BehaviorPatterns(
      {required this.positiveInteractions,
      required this.challengingBehaviors,
      required final List<String> triggerPatterns,
      required this.responseEffectiveness})
      : _triggerPatterns = triggerPatterns;
  factory _BehaviorPatterns.fromJson(Map<String, dynamic> json) =>
      _$BehaviorPatternsFromJson(json);

  @override
  final int positiveInteractions;
  @override
  final int challengingBehaviors;
  final List<String> _triggerPatterns;
  @override
  List<String> get triggerPatterns {
    if (_triggerPatterns is EqualUnmodifiableListView) return _triggerPatterns;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_triggerPatterns);
  }

  @override
  final double responseEffectiveness;

  /// Create a copy of BehaviorPatterns
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BehaviorPatternsCopyWith<_BehaviorPatterns> get copyWith =>
      __$BehaviorPatternsCopyWithImpl<_BehaviorPatterns>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$BehaviorPatternsToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BehaviorPatterns &&
            (identical(other.positiveInteractions, positiveInteractions) ||
                other.positiveInteractions == positiveInteractions) &&
            (identical(other.challengingBehaviors, challengingBehaviors) ||
                other.challengingBehaviors == challengingBehaviors) &&
            const DeepCollectionEquality()
                .equals(other._triggerPatterns, _triggerPatterns) &&
            (identical(other.responseEffectiveness, responseEffectiveness) ||
                other.responseEffectiveness == responseEffectiveness));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      positiveInteractions,
      challengingBehaviors,
      const DeepCollectionEquality().hash(_triggerPatterns),
      responseEffectiveness);

  @override
  String toString() {
    return 'BehaviorPatterns(positiveInteractions: $positiveInteractions, challengingBehaviors: $challengingBehaviors, triggerPatterns: $triggerPatterns, responseEffectiveness: $responseEffectiveness)';
  }
}

/// @nodoc
abstract mixin class _$BehaviorPatternsCopyWith<$Res>
    implements $BehaviorPatternsCopyWith<$Res> {
  factory _$BehaviorPatternsCopyWith(
          _BehaviorPatterns value, $Res Function(_BehaviorPatterns) _then) =
      __$BehaviorPatternsCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int positiveInteractions,
      int challengingBehaviors,
      List<String> triggerPatterns,
      double responseEffectiveness});
}

/// @nodoc
class __$BehaviorPatternsCopyWithImpl<$Res>
    implements _$BehaviorPatternsCopyWith<$Res> {
  __$BehaviorPatternsCopyWithImpl(this._self, this._then);

  final _BehaviorPatterns _self;
  final $Res Function(_BehaviorPatterns) _then;

  /// Create a copy of BehaviorPatterns
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? positiveInteractions = null,
    Object? challengingBehaviors = null,
    Object? triggerPatterns = null,
    Object? responseEffectiveness = null,
  }) {
    return _then(_BehaviorPatterns(
      positiveInteractions: null == positiveInteractions
          ? _self.positiveInteractions
          : positiveInteractions // ignore: cast_nullable_to_non_nullable
              as int,
      challengingBehaviors: null == challengingBehaviors
          ? _self.challengingBehaviors
          : challengingBehaviors // ignore: cast_nullable_to_non_nullable
              as int,
      triggerPatterns: null == triggerPatterns
          ? _self._triggerPatterns
          : triggerPatterns // ignore: cast_nullable_to_non_nullable
              as List<String>,
      responseEffectiveness: null == responseEffectiveness
          ? _self.responseEffectiveness
          : responseEffectiveness // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
mixin _$GoalProgress {
  int get onTrack;
  int get needsAttention;
  int get achieved;
  double get averageProgress;

  /// Create a copy of GoalProgress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GoalProgressCopyWith<GoalProgress> get copyWith =>
      _$GoalProgressCopyWithImpl<GoalProgress>(
          this as GoalProgress, _$identity);

  /// Serializes this GoalProgress to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GoalProgress &&
            (identical(other.onTrack, onTrack) || other.onTrack == onTrack) &&
            (identical(other.needsAttention, needsAttention) ||
                other.needsAttention == needsAttention) &&
            (identical(other.achieved, achieved) ||
                other.achieved == achieved) &&
            (identical(other.averageProgress, averageProgress) ||
                other.averageProgress == averageProgress));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, onTrack, needsAttention, achieved, averageProgress);

  @override
  String toString() {
    return 'GoalProgress(onTrack: $onTrack, needsAttention: $needsAttention, achieved: $achieved, averageProgress: $averageProgress)';
  }
}

/// @nodoc
abstract mixin class $GoalProgressCopyWith<$Res> {
  factory $GoalProgressCopyWith(
          GoalProgress value, $Res Function(GoalProgress) _then) =
      _$GoalProgressCopyWithImpl;
  @useResult
  $Res call(
      {int onTrack, int needsAttention, int achieved, double averageProgress});
}

/// @nodoc
class _$GoalProgressCopyWithImpl<$Res> implements $GoalProgressCopyWith<$Res> {
  _$GoalProgressCopyWithImpl(this._self, this._then);

  final GoalProgress _self;
  final $Res Function(GoalProgress) _then;

  /// Create a copy of GoalProgress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? onTrack = null,
    Object? needsAttention = null,
    Object? achieved = null,
    Object? averageProgress = null,
  }) {
    return _then(_self.copyWith(
      onTrack: null == onTrack
          ? _self.onTrack
          : onTrack // ignore: cast_nullable_to_non_nullable
              as int,
      needsAttention: null == needsAttention
          ? _self.needsAttention
          : needsAttention // ignore: cast_nullable_to_non_nullable
              as int,
      achieved: null == achieved
          ? _self.achieved
          : achieved // ignore: cast_nullable_to_non_nullable
              as int,
      averageProgress: null == averageProgress
          ? _self.averageProgress
          : averageProgress // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// Adds pattern-matching-related methods to [GoalProgress].
extension GoalProgressPatterns on GoalProgress {
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
    TResult Function(_GoalProgress value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GoalProgress() when $default != null:
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
    TResult Function(_GoalProgress value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GoalProgress():
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
    TResult? Function(_GoalProgress value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GoalProgress() when $default != null:
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
    TResult Function(int onTrack, int needsAttention, int achieved,
            double averageProgress)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GoalProgress() when $default != null:
        return $default(_that.onTrack, _that.needsAttention, _that.achieved,
            _that.averageProgress);
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
    TResult Function(int onTrack, int needsAttention, int achieved,
            double averageProgress)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GoalProgress():
        return $default(_that.onTrack, _that.needsAttention, _that.achieved,
            _that.averageProgress);
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
    TResult? Function(int onTrack, int needsAttention, int achieved,
            double averageProgress)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GoalProgress() when $default != null:
        return $default(_that.onTrack, _that.needsAttention, _that.achieved,
            _that.averageProgress);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _GoalProgress implements GoalProgress {
  const _GoalProgress(
      {required this.onTrack,
      required this.needsAttention,
      required this.achieved,
      required this.averageProgress});
  factory _GoalProgress.fromJson(Map<String, dynamic> json) =>
      _$GoalProgressFromJson(json);

  @override
  final int onTrack;
  @override
  final int needsAttention;
  @override
  final int achieved;
  @override
  final double averageProgress;

  /// Create a copy of GoalProgress
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GoalProgressCopyWith<_GoalProgress> get copyWith =>
      __$GoalProgressCopyWithImpl<_GoalProgress>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$GoalProgressToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GoalProgress &&
            (identical(other.onTrack, onTrack) || other.onTrack == onTrack) &&
            (identical(other.needsAttention, needsAttention) ||
                other.needsAttention == needsAttention) &&
            (identical(other.achieved, achieved) ||
                other.achieved == achieved) &&
            (identical(other.averageProgress, averageProgress) ||
                other.averageProgress == averageProgress));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, onTrack, needsAttention, achieved, averageProgress);

  @override
  String toString() {
    return 'GoalProgress(onTrack: $onTrack, needsAttention: $needsAttention, achieved: $achieved, averageProgress: $averageProgress)';
  }
}

/// @nodoc
abstract mixin class _$GoalProgressCopyWith<$Res>
    implements $GoalProgressCopyWith<$Res> {
  factory _$GoalProgressCopyWith(
          _GoalProgress value, $Res Function(_GoalProgress) _then) =
      __$GoalProgressCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int onTrack, int needsAttention, int achieved, double averageProgress});
}

/// @nodoc
class __$GoalProgressCopyWithImpl<$Res>
    implements _$GoalProgressCopyWith<$Res> {
  __$GoalProgressCopyWithImpl(this._self, this._then);

  final _GoalProgress _self;
  final $Res Function(_GoalProgress) _then;

  /// Create a copy of GoalProgress
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? onTrack = null,
    Object? needsAttention = null,
    Object? achieved = null,
    Object? averageProgress = null,
  }) {
    return _then(_GoalProgress(
      onTrack: null == onTrack
          ? _self.onTrack
          : onTrack // ignore: cast_nullable_to_non_nullable
              as int,
      needsAttention: null == needsAttention
          ? _self.needsAttention
          : needsAttention // ignore: cast_nullable_to_non_nullable
              as int,
      achieved: null == achieved
          ? _self.achieved
          : achieved // ignore: cast_nullable_to_non_nullable
              as int,
      averageProgress: null == averageProgress
          ? _self.averageProgress
          : averageProgress // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
mixin _$FamilyEngagement {
  String get communicationFrequency;
  double get satisfactionScore;
  int get concernsRaised;
  double get participationLevel;

  /// Create a copy of FamilyEngagement
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $FamilyEngagementCopyWith<FamilyEngagement> get copyWith =>
      _$FamilyEngagementCopyWithImpl<FamilyEngagement>(
          this as FamilyEngagement, _$identity);

  /// Serializes this FamilyEngagement to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is FamilyEngagement &&
            (identical(other.communicationFrequency, communicationFrequency) ||
                other.communicationFrequency == communicationFrequency) &&
            (identical(other.satisfactionScore, satisfactionScore) ||
                other.satisfactionScore == satisfactionScore) &&
            (identical(other.concernsRaised, concernsRaised) ||
                other.concernsRaised == concernsRaised) &&
            (identical(other.participationLevel, participationLevel) ||
                other.participationLevel == participationLevel));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, communicationFrequency,
      satisfactionScore, concernsRaised, participationLevel);

  @override
  String toString() {
    return 'FamilyEngagement(communicationFrequency: $communicationFrequency, satisfactionScore: $satisfactionScore, concernsRaised: $concernsRaised, participationLevel: $participationLevel)';
  }
}

/// @nodoc
abstract mixin class $FamilyEngagementCopyWith<$Res> {
  factory $FamilyEngagementCopyWith(
          FamilyEngagement value, $Res Function(FamilyEngagement) _then) =
      _$FamilyEngagementCopyWithImpl;
  @useResult
  $Res call(
      {String communicationFrequency,
      double satisfactionScore,
      int concernsRaised,
      double participationLevel});
}

/// @nodoc
class _$FamilyEngagementCopyWithImpl<$Res>
    implements $FamilyEngagementCopyWith<$Res> {
  _$FamilyEngagementCopyWithImpl(this._self, this._then);

  final FamilyEngagement _self;
  final $Res Function(FamilyEngagement) _then;

  /// Create a copy of FamilyEngagement
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? communicationFrequency = null,
    Object? satisfactionScore = null,
    Object? concernsRaised = null,
    Object? participationLevel = null,
  }) {
    return _then(_self.copyWith(
      communicationFrequency: null == communicationFrequency
          ? _self.communicationFrequency
          : communicationFrequency // ignore: cast_nullable_to_non_nullable
              as String,
      satisfactionScore: null == satisfactionScore
          ? _self.satisfactionScore
          : satisfactionScore // ignore: cast_nullable_to_non_nullable
              as double,
      concernsRaised: null == concernsRaised
          ? _self.concernsRaised
          : concernsRaised // ignore: cast_nullable_to_non_nullable
              as int,
      participationLevel: null == participationLevel
          ? _self.participationLevel
          : participationLevel // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// Adds pattern-matching-related methods to [FamilyEngagement].
extension FamilyEngagementPatterns on FamilyEngagement {
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
    TResult Function(_FamilyEngagement value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _FamilyEngagement() when $default != null:
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
    TResult Function(_FamilyEngagement value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FamilyEngagement():
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
    TResult? Function(_FamilyEngagement value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FamilyEngagement() when $default != null:
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
    TResult Function(String communicationFrequency, double satisfactionScore,
            int concernsRaised, double participationLevel)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _FamilyEngagement() when $default != null:
        return $default(_that.communicationFrequency, _that.satisfactionScore,
            _that.concernsRaised, _that.participationLevel);
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
    TResult Function(String communicationFrequency, double satisfactionScore,
            int concernsRaised, double participationLevel)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FamilyEngagement():
        return $default(_that.communicationFrequency, _that.satisfactionScore,
            _that.concernsRaised, _that.participationLevel);
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
    TResult? Function(String communicationFrequency, double satisfactionScore,
            int concernsRaised, double participationLevel)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FamilyEngagement() when $default != null:
        return $default(_that.communicationFrequency, _that.satisfactionScore,
            _that.concernsRaised, _that.participationLevel);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _FamilyEngagement implements FamilyEngagement {
  const _FamilyEngagement(
      {required this.communicationFrequency,
      required this.satisfactionScore,
      required this.concernsRaised,
      required this.participationLevel});
  factory _FamilyEngagement.fromJson(Map<String, dynamic> json) =>
      _$FamilyEngagementFromJson(json);

  @override
  final String communicationFrequency;
  @override
  final double satisfactionScore;
  @override
  final int concernsRaised;
  @override
  final double participationLevel;

  /// Create a copy of FamilyEngagement
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$FamilyEngagementCopyWith<_FamilyEngagement> get copyWith =>
      __$FamilyEngagementCopyWithImpl<_FamilyEngagement>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$FamilyEngagementToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _FamilyEngagement &&
            (identical(other.communicationFrequency, communicationFrequency) ||
                other.communicationFrequency == communicationFrequency) &&
            (identical(other.satisfactionScore, satisfactionScore) ||
                other.satisfactionScore == satisfactionScore) &&
            (identical(other.concernsRaised, concernsRaised) ||
                other.concernsRaised == concernsRaised) &&
            (identical(other.participationLevel, participationLevel) ||
                other.participationLevel == participationLevel));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, communicationFrequency,
      satisfactionScore, concernsRaised, participationLevel);

  @override
  String toString() {
    return 'FamilyEngagement(communicationFrequency: $communicationFrequency, satisfactionScore: $satisfactionScore, concernsRaised: $concernsRaised, participationLevel: $participationLevel)';
  }
}

/// @nodoc
abstract mixin class _$FamilyEngagementCopyWith<$Res>
    implements $FamilyEngagementCopyWith<$Res> {
  factory _$FamilyEngagementCopyWith(
          _FamilyEngagement value, $Res Function(_FamilyEngagement) _then) =
      __$FamilyEngagementCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String communicationFrequency,
      double satisfactionScore,
      int concernsRaised,
      double participationLevel});
}

/// @nodoc
class __$FamilyEngagementCopyWithImpl<$Res>
    implements _$FamilyEngagementCopyWith<$Res> {
  __$FamilyEngagementCopyWithImpl(this._self, this._then);

  final _FamilyEngagement _self;
  final $Res Function(_FamilyEngagement) _then;

  /// Create a copy of FamilyEngagement
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? communicationFrequency = null,
    Object? satisfactionScore = null,
    Object? concernsRaised = null,
    Object? participationLevel = null,
  }) {
    return _then(_FamilyEngagement(
      communicationFrequency: null == communicationFrequency
          ? _self.communicationFrequency
          : communicationFrequency // ignore: cast_nullable_to_non_nullable
              as String,
      satisfactionScore: null == satisfactionScore
          ? _self.satisfactionScore
          : satisfactionScore // ignore: cast_nullable_to_non_nullable
              as double,
      concernsRaised: null == concernsRaised
          ? _self.concernsRaised
          : concernsRaised // ignore: cast_nullable_to_non_nullable
              as int,
      participationLevel: null == participationLevel
          ? _self.participationLevel
          : participationLevel // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
mixin _$RiskAssessment {
  String get clientId;
  String get organizationId;
  String get assessmentDate;
  int get overallRisk;
  RiskCategory get fallsRisk;
  RiskCategory get behaviorRisk;
  RiskCategory get healthRisk;
  RiskCategory get medicationRisk;
  RiskCategory get socialRisk;
  RiskCategory get financialRisk;
  RiskTrends get trends;
  List<RiskRecommendation> get recommendations;
  String get nextAssessment;

  /// Create a copy of RiskAssessment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RiskAssessmentCopyWith<RiskAssessment> get copyWith =>
      _$RiskAssessmentCopyWithImpl<RiskAssessment>(
          this as RiskAssessment, _$identity);

  /// Serializes this RiskAssessment to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RiskAssessment &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.assessmentDate, assessmentDate) ||
                other.assessmentDate == assessmentDate) &&
            (identical(other.overallRisk, overallRisk) ||
                other.overallRisk == overallRisk) &&
            (identical(other.fallsRisk, fallsRisk) ||
                other.fallsRisk == fallsRisk) &&
            (identical(other.behaviorRisk, behaviorRisk) ||
                other.behaviorRisk == behaviorRisk) &&
            (identical(other.healthRisk, healthRisk) ||
                other.healthRisk == healthRisk) &&
            (identical(other.medicationRisk, medicationRisk) ||
                other.medicationRisk == medicationRisk) &&
            (identical(other.socialRisk, socialRisk) ||
                other.socialRisk == socialRisk) &&
            (identical(other.financialRisk, financialRisk) ||
                other.financialRisk == financialRisk) &&
            (identical(other.trends, trends) || other.trends == trends) &&
            const DeepCollectionEquality()
                .equals(other.recommendations, recommendations) &&
            (identical(other.nextAssessment, nextAssessment) ||
                other.nextAssessment == nextAssessment));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      clientId,
      organizationId,
      assessmentDate,
      overallRisk,
      fallsRisk,
      behaviorRisk,
      healthRisk,
      medicationRisk,
      socialRisk,
      financialRisk,
      trends,
      const DeepCollectionEquality().hash(recommendations),
      nextAssessment);

  @override
  String toString() {
    return 'RiskAssessment(clientId: $clientId, organizationId: $organizationId, assessmentDate: $assessmentDate, overallRisk: $overallRisk, fallsRisk: $fallsRisk, behaviorRisk: $behaviorRisk, healthRisk: $healthRisk, medicationRisk: $medicationRisk, socialRisk: $socialRisk, financialRisk: $financialRisk, trends: $trends, recommendations: $recommendations, nextAssessment: $nextAssessment)';
  }
}

/// @nodoc
abstract mixin class $RiskAssessmentCopyWith<$Res> {
  factory $RiskAssessmentCopyWith(
          RiskAssessment value, $Res Function(RiskAssessment) _then) =
      _$RiskAssessmentCopyWithImpl;
  @useResult
  $Res call(
      {String clientId,
      String organizationId,
      String assessmentDate,
      int overallRisk,
      RiskCategory fallsRisk,
      RiskCategory behaviorRisk,
      RiskCategory healthRisk,
      RiskCategory medicationRisk,
      RiskCategory socialRisk,
      RiskCategory financialRisk,
      RiskTrends trends,
      List<RiskRecommendation> recommendations,
      String nextAssessment});

  $RiskCategoryCopyWith<$Res> get fallsRisk;
  $RiskCategoryCopyWith<$Res> get behaviorRisk;
  $RiskCategoryCopyWith<$Res> get healthRisk;
  $RiskCategoryCopyWith<$Res> get medicationRisk;
  $RiskCategoryCopyWith<$Res> get socialRisk;
  $RiskCategoryCopyWith<$Res> get financialRisk;
  $RiskTrendsCopyWith<$Res> get trends;
}

/// @nodoc
class _$RiskAssessmentCopyWithImpl<$Res>
    implements $RiskAssessmentCopyWith<$Res> {
  _$RiskAssessmentCopyWithImpl(this._self, this._then);

  final RiskAssessment _self;
  final $Res Function(RiskAssessment) _then;

  /// Create a copy of RiskAssessment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clientId = null,
    Object? organizationId = null,
    Object? assessmentDate = null,
    Object? overallRisk = null,
    Object? fallsRisk = null,
    Object? behaviorRisk = null,
    Object? healthRisk = null,
    Object? medicationRisk = null,
    Object? socialRisk = null,
    Object? financialRisk = null,
    Object? trends = null,
    Object? recommendations = null,
    Object? nextAssessment = null,
  }) {
    return _then(_self.copyWith(
      clientId: null == clientId
          ? _self.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: null == organizationId
          ? _self.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      assessmentDate: null == assessmentDate
          ? _self.assessmentDate
          : assessmentDate // ignore: cast_nullable_to_non_nullable
              as String,
      overallRisk: null == overallRisk
          ? _self.overallRisk
          : overallRisk // ignore: cast_nullable_to_non_nullable
              as int,
      fallsRisk: null == fallsRisk
          ? _self.fallsRisk
          : fallsRisk // ignore: cast_nullable_to_non_nullable
              as RiskCategory,
      behaviorRisk: null == behaviorRisk
          ? _self.behaviorRisk
          : behaviorRisk // ignore: cast_nullable_to_non_nullable
              as RiskCategory,
      healthRisk: null == healthRisk
          ? _self.healthRisk
          : healthRisk // ignore: cast_nullable_to_non_nullable
              as RiskCategory,
      medicationRisk: null == medicationRisk
          ? _self.medicationRisk
          : medicationRisk // ignore: cast_nullable_to_non_nullable
              as RiskCategory,
      socialRisk: null == socialRisk
          ? _self.socialRisk
          : socialRisk // ignore: cast_nullable_to_non_nullable
              as RiskCategory,
      financialRisk: null == financialRisk
          ? _self.financialRisk
          : financialRisk // ignore: cast_nullable_to_non_nullable
              as RiskCategory,
      trends: null == trends
          ? _self.trends
          : trends // ignore: cast_nullable_to_non_nullable
              as RiskTrends,
      recommendations: null == recommendations
          ? _self.recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as List<RiskRecommendation>,
      nextAssessment: null == nextAssessment
          ? _self.nextAssessment
          : nextAssessment // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  /// Create a copy of RiskAssessment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RiskCategoryCopyWith<$Res> get fallsRisk {
    return $RiskCategoryCopyWith<$Res>(_self.fallsRisk, (value) {
      return _then(_self.copyWith(fallsRisk: value));
    });
  }

  /// Create a copy of RiskAssessment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RiskCategoryCopyWith<$Res> get behaviorRisk {
    return $RiskCategoryCopyWith<$Res>(_self.behaviorRisk, (value) {
      return _then(_self.copyWith(behaviorRisk: value));
    });
  }

  /// Create a copy of RiskAssessment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RiskCategoryCopyWith<$Res> get healthRisk {
    return $RiskCategoryCopyWith<$Res>(_self.healthRisk, (value) {
      return _then(_self.copyWith(healthRisk: value));
    });
  }

  /// Create a copy of RiskAssessment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RiskCategoryCopyWith<$Res> get medicationRisk {
    return $RiskCategoryCopyWith<$Res>(_self.medicationRisk, (value) {
      return _then(_self.copyWith(medicationRisk: value));
    });
  }

  /// Create a copy of RiskAssessment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RiskCategoryCopyWith<$Res> get socialRisk {
    return $RiskCategoryCopyWith<$Res>(_self.socialRisk, (value) {
      return _then(_self.copyWith(socialRisk: value));
    });
  }

  /// Create a copy of RiskAssessment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RiskCategoryCopyWith<$Res> get financialRisk {
    return $RiskCategoryCopyWith<$Res>(_self.financialRisk, (value) {
      return _then(_self.copyWith(financialRisk: value));
    });
  }

  /// Create a copy of RiskAssessment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RiskTrendsCopyWith<$Res> get trends {
    return $RiskTrendsCopyWith<$Res>(_self.trends, (value) {
      return _then(_self.copyWith(trends: value));
    });
  }
}

/// Adds pattern-matching-related methods to [RiskAssessment].
extension RiskAssessmentPatterns on RiskAssessment {
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
    TResult Function(_RiskAssessment value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RiskAssessment() when $default != null:
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
    TResult Function(_RiskAssessment value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RiskAssessment():
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
    TResult? Function(_RiskAssessment value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RiskAssessment() when $default != null:
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
            String clientId,
            String organizationId,
            String assessmentDate,
            int overallRisk,
            RiskCategory fallsRisk,
            RiskCategory behaviorRisk,
            RiskCategory healthRisk,
            RiskCategory medicationRisk,
            RiskCategory socialRisk,
            RiskCategory financialRisk,
            RiskTrends trends,
            List<RiskRecommendation> recommendations,
            String nextAssessment)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RiskAssessment() when $default != null:
        return $default(
            _that.clientId,
            _that.organizationId,
            _that.assessmentDate,
            _that.overallRisk,
            _that.fallsRisk,
            _that.behaviorRisk,
            _that.healthRisk,
            _that.medicationRisk,
            _that.socialRisk,
            _that.financialRisk,
            _that.trends,
            _that.recommendations,
            _that.nextAssessment);
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
            String clientId,
            String organizationId,
            String assessmentDate,
            int overallRisk,
            RiskCategory fallsRisk,
            RiskCategory behaviorRisk,
            RiskCategory healthRisk,
            RiskCategory medicationRisk,
            RiskCategory socialRisk,
            RiskCategory financialRisk,
            RiskTrends trends,
            List<RiskRecommendation> recommendations,
            String nextAssessment)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RiskAssessment():
        return $default(
            _that.clientId,
            _that.organizationId,
            _that.assessmentDate,
            _that.overallRisk,
            _that.fallsRisk,
            _that.behaviorRisk,
            _that.healthRisk,
            _that.medicationRisk,
            _that.socialRisk,
            _that.financialRisk,
            _that.trends,
            _that.recommendations,
            _that.nextAssessment);
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
            String clientId,
            String organizationId,
            String assessmentDate,
            int overallRisk,
            RiskCategory fallsRisk,
            RiskCategory behaviorRisk,
            RiskCategory healthRisk,
            RiskCategory medicationRisk,
            RiskCategory socialRisk,
            RiskCategory financialRisk,
            RiskTrends trends,
            List<RiskRecommendation> recommendations,
            String nextAssessment)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RiskAssessment() when $default != null:
        return $default(
            _that.clientId,
            _that.organizationId,
            _that.assessmentDate,
            _that.overallRisk,
            _that.fallsRisk,
            _that.behaviorRisk,
            _that.healthRisk,
            _that.medicationRisk,
            _that.socialRisk,
            _that.financialRisk,
            _that.trends,
            _that.recommendations,
            _that.nextAssessment);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _RiskAssessment implements RiskAssessment {
  const _RiskAssessment(
      {required this.clientId,
      required this.organizationId,
      required this.assessmentDate,
      required this.overallRisk,
      required this.fallsRisk,
      required this.behaviorRisk,
      required this.healthRisk,
      required this.medicationRisk,
      required this.socialRisk,
      required this.financialRisk,
      required this.trends,
      required final List<RiskRecommendation> recommendations,
      required this.nextAssessment})
      : _recommendations = recommendations;
  factory _RiskAssessment.fromJson(Map<String, dynamic> json) =>
      _$RiskAssessmentFromJson(json);

  @override
  final String clientId;
  @override
  final String organizationId;
  @override
  final String assessmentDate;
  @override
  final int overallRisk;
  @override
  final RiskCategory fallsRisk;
  @override
  final RiskCategory behaviorRisk;
  @override
  final RiskCategory healthRisk;
  @override
  final RiskCategory medicationRisk;
  @override
  final RiskCategory socialRisk;
  @override
  final RiskCategory financialRisk;
  @override
  final RiskTrends trends;
  final List<RiskRecommendation> _recommendations;
  @override
  List<RiskRecommendation> get recommendations {
    if (_recommendations is EqualUnmodifiableListView) return _recommendations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recommendations);
  }

  @override
  final String nextAssessment;

  /// Create a copy of RiskAssessment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RiskAssessmentCopyWith<_RiskAssessment> get copyWith =>
      __$RiskAssessmentCopyWithImpl<_RiskAssessment>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$RiskAssessmentToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RiskAssessment &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.assessmentDate, assessmentDate) ||
                other.assessmentDate == assessmentDate) &&
            (identical(other.overallRisk, overallRisk) ||
                other.overallRisk == overallRisk) &&
            (identical(other.fallsRisk, fallsRisk) ||
                other.fallsRisk == fallsRisk) &&
            (identical(other.behaviorRisk, behaviorRisk) ||
                other.behaviorRisk == behaviorRisk) &&
            (identical(other.healthRisk, healthRisk) ||
                other.healthRisk == healthRisk) &&
            (identical(other.medicationRisk, medicationRisk) ||
                other.medicationRisk == medicationRisk) &&
            (identical(other.socialRisk, socialRisk) ||
                other.socialRisk == socialRisk) &&
            (identical(other.financialRisk, financialRisk) ||
                other.financialRisk == financialRisk) &&
            (identical(other.trends, trends) || other.trends == trends) &&
            const DeepCollectionEquality()
                .equals(other._recommendations, _recommendations) &&
            (identical(other.nextAssessment, nextAssessment) ||
                other.nextAssessment == nextAssessment));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      clientId,
      organizationId,
      assessmentDate,
      overallRisk,
      fallsRisk,
      behaviorRisk,
      healthRisk,
      medicationRisk,
      socialRisk,
      financialRisk,
      trends,
      const DeepCollectionEquality().hash(_recommendations),
      nextAssessment);

  @override
  String toString() {
    return 'RiskAssessment(clientId: $clientId, organizationId: $organizationId, assessmentDate: $assessmentDate, overallRisk: $overallRisk, fallsRisk: $fallsRisk, behaviorRisk: $behaviorRisk, healthRisk: $healthRisk, medicationRisk: $medicationRisk, socialRisk: $socialRisk, financialRisk: $financialRisk, trends: $trends, recommendations: $recommendations, nextAssessment: $nextAssessment)';
  }
}

/// @nodoc
abstract mixin class _$RiskAssessmentCopyWith<$Res>
    implements $RiskAssessmentCopyWith<$Res> {
  factory _$RiskAssessmentCopyWith(
          _RiskAssessment value, $Res Function(_RiskAssessment) _then) =
      __$RiskAssessmentCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String clientId,
      String organizationId,
      String assessmentDate,
      int overallRisk,
      RiskCategory fallsRisk,
      RiskCategory behaviorRisk,
      RiskCategory healthRisk,
      RiskCategory medicationRisk,
      RiskCategory socialRisk,
      RiskCategory financialRisk,
      RiskTrends trends,
      List<RiskRecommendation> recommendations,
      String nextAssessment});

  @override
  $RiskCategoryCopyWith<$Res> get fallsRisk;
  @override
  $RiskCategoryCopyWith<$Res> get behaviorRisk;
  @override
  $RiskCategoryCopyWith<$Res> get healthRisk;
  @override
  $RiskCategoryCopyWith<$Res> get medicationRisk;
  @override
  $RiskCategoryCopyWith<$Res> get socialRisk;
  @override
  $RiskCategoryCopyWith<$Res> get financialRisk;
  @override
  $RiskTrendsCopyWith<$Res> get trends;
}

/// @nodoc
class __$RiskAssessmentCopyWithImpl<$Res>
    implements _$RiskAssessmentCopyWith<$Res> {
  __$RiskAssessmentCopyWithImpl(this._self, this._then);

  final _RiskAssessment _self;
  final $Res Function(_RiskAssessment) _then;

  /// Create a copy of RiskAssessment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? clientId = null,
    Object? organizationId = null,
    Object? assessmentDate = null,
    Object? overallRisk = null,
    Object? fallsRisk = null,
    Object? behaviorRisk = null,
    Object? healthRisk = null,
    Object? medicationRisk = null,
    Object? socialRisk = null,
    Object? financialRisk = null,
    Object? trends = null,
    Object? recommendations = null,
    Object? nextAssessment = null,
  }) {
    return _then(_RiskAssessment(
      clientId: null == clientId
          ? _self.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: null == organizationId
          ? _self.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      assessmentDate: null == assessmentDate
          ? _self.assessmentDate
          : assessmentDate // ignore: cast_nullable_to_non_nullable
              as String,
      overallRisk: null == overallRisk
          ? _self.overallRisk
          : overallRisk // ignore: cast_nullable_to_non_nullable
              as int,
      fallsRisk: null == fallsRisk
          ? _self.fallsRisk
          : fallsRisk // ignore: cast_nullable_to_non_nullable
              as RiskCategory,
      behaviorRisk: null == behaviorRisk
          ? _self.behaviorRisk
          : behaviorRisk // ignore: cast_nullable_to_non_nullable
              as RiskCategory,
      healthRisk: null == healthRisk
          ? _self.healthRisk
          : healthRisk // ignore: cast_nullable_to_non_nullable
              as RiskCategory,
      medicationRisk: null == medicationRisk
          ? _self.medicationRisk
          : medicationRisk // ignore: cast_nullable_to_non_nullable
              as RiskCategory,
      socialRisk: null == socialRisk
          ? _self.socialRisk
          : socialRisk // ignore: cast_nullable_to_non_nullable
              as RiskCategory,
      financialRisk: null == financialRisk
          ? _self.financialRisk
          : financialRisk // ignore: cast_nullable_to_non_nullable
              as RiskCategory,
      trends: null == trends
          ? _self.trends
          : trends // ignore: cast_nullable_to_non_nullable
              as RiskTrends,
      recommendations: null == recommendations
          ? _self._recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as List<RiskRecommendation>,
      nextAssessment: null == nextAssessment
          ? _self.nextAssessment
          : nextAssessment // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  /// Create a copy of RiskAssessment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RiskCategoryCopyWith<$Res> get fallsRisk {
    return $RiskCategoryCopyWith<$Res>(_self.fallsRisk, (value) {
      return _then(_self.copyWith(fallsRisk: value));
    });
  }

  /// Create a copy of RiskAssessment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RiskCategoryCopyWith<$Res> get behaviorRisk {
    return $RiskCategoryCopyWith<$Res>(_self.behaviorRisk, (value) {
      return _then(_self.copyWith(behaviorRisk: value));
    });
  }

  /// Create a copy of RiskAssessment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RiskCategoryCopyWith<$Res> get healthRisk {
    return $RiskCategoryCopyWith<$Res>(_self.healthRisk, (value) {
      return _then(_self.copyWith(healthRisk: value));
    });
  }

  /// Create a copy of RiskAssessment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RiskCategoryCopyWith<$Res> get medicationRisk {
    return $RiskCategoryCopyWith<$Res>(_self.medicationRisk, (value) {
      return _then(_self.copyWith(medicationRisk: value));
    });
  }

  /// Create a copy of RiskAssessment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RiskCategoryCopyWith<$Res> get socialRisk {
    return $RiskCategoryCopyWith<$Res>(_self.socialRisk, (value) {
      return _then(_self.copyWith(socialRisk: value));
    });
  }

  /// Create a copy of RiskAssessment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RiskCategoryCopyWith<$Res> get financialRisk {
    return $RiskCategoryCopyWith<$Res>(_self.financialRisk, (value) {
      return _then(_self.copyWith(financialRisk: value));
    });
  }

  /// Create a copy of RiskAssessment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RiskTrendsCopyWith<$Res> get trends {
    return $RiskTrendsCopyWith<$Res>(_self.trends, (value) {
      return _then(_self.copyWith(trends: value));
    });
  }
}

/// @nodoc
mixin _$RiskCategory {
  int get score;
  String get level;
  String? get lastIncident;
  int? get recentIncidents;
  int? get conditions;
  int? get medications;
  int? get isolationIndicators;
  int? get concerns;

  /// Create a copy of RiskCategory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RiskCategoryCopyWith<RiskCategory> get copyWith =>
      _$RiskCategoryCopyWithImpl<RiskCategory>(
          this as RiskCategory, _$identity);

  /// Serializes this RiskCategory to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RiskCategory &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.lastIncident, lastIncident) ||
                other.lastIncident == lastIncident) &&
            (identical(other.recentIncidents, recentIncidents) ||
                other.recentIncidents == recentIncidents) &&
            (identical(other.conditions, conditions) ||
                other.conditions == conditions) &&
            (identical(other.medications, medications) ||
                other.medications == medications) &&
            (identical(other.isolationIndicators, isolationIndicators) ||
                other.isolationIndicators == isolationIndicators) &&
            (identical(other.concerns, concerns) ||
                other.concerns == concerns));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, score, level, lastIncident,
      recentIncidents, conditions, medications, isolationIndicators, concerns);

  @override
  String toString() {
    return 'RiskCategory(score: $score, level: $level, lastIncident: $lastIncident, recentIncidents: $recentIncidents, conditions: $conditions, medications: $medications, isolationIndicators: $isolationIndicators, concerns: $concerns)';
  }
}

/// @nodoc
abstract mixin class $RiskCategoryCopyWith<$Res> {
  factory $RiskCategoryCopyWith(
          RiskCategory value, $Res Function(RiskCategory) _then) =
      _$RiskCategoryCopyWithImpl;
  @useResult
  $Res call(
      {int score,
      String level,
      String? lastIncident,
      int? recentIncidents,
      int? conditions,
      int? medications,
      int? isolationIndicators,
      int? concerns});
}

/// @nodoc
class _$RiskCategoryCopyWithImpl<$Res> implements $RiskCategoryCopyWith<$Res> {
  _$RiskCategoryCopyWithImpl(this._self, this._then);

  final RiskCategory _self;
  final $Res Function(RiskCategory) _then;

  /// Create a copy of RiskCategory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? score = null,
    Object? level = null,
    Object? lastIncident = freezed,
    Object? recentIncidents = freezed,
    Object? conditions = freezed,
    Object? medications = freezed,
    Object? isolationIndicators = freezed,
    Object? concerns = freezed,
  }) {
    return _then(_self.copyWith(
      score: null == score
          ? _self.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
      level: null == level
          ? _self.level
          : level // ignore: cast_nullable_to_non_nullable
              as String,
      lastIncident: freezed == lastIncident
          ? _self.lastIncident
          : lastIncident // ignore: cast_nullable_to_non_nullable
              as String?,
      recentIncidents: freezed == recentIncidents
          ? _self.recentIncidents
          : recentIncidents // ignore: cast_nullable_to_non_nullable
              as int?,
      conditions: freezed == conditions
          ? _self.conditions
          : conditions // ignore: cast_nullable_to_non_nullable
              as int?,
      medications: freezed == medications
          ? _self.medications
          : medications // ignore: cast_nullable_to_non_nullable
              as int?,
      isolationIndicators: freezed == isolationIndicators
          ? _self.isolationIndicators
          : isolationIndicators // ignore: cast_nullable_to_non_nullable
              as int?,
      concerns: freezed == concerns
          ? _self.concerns
          : concerns // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// Adds pattern-matching-related methods to [RiskCategory].
extension RiskCategoryPatterns on RiskCategory {
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
    TResult Function(_RiskCategory value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RiskCategory() when $default != null:
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
    TResult Function(_RiskCategory value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RiskCategory():
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
    TResult? Function(_RiskCategory value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RiskCategory() when $default != null:
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
            int score,
            String level,
            String? lastIncident,
            int? recentIncidents,
            int? conditions,
            int? medications,
            int? isolationIndicators,
            int? concerns)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RiskCategory() when $default != null:
        return $default(
            _that.score,
            _that.level,
            _that.lastIncident,
            _that.recentIncidents,
            _that.conditions,
            _that.medications,
            _that.isolationIndicators,
            _that.concerns);
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
            int score,
            String level,
            String? lastIncident,
            int? recentIncidents,
            int? conditions,
            int? medications,
            int? isolationIndicators,
            int? concerns)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RiskCategory():
        return $default(
            _that.score,
            _that.level,
            _that.lastIncident,
            _that.recentIncidents,
            _that.conditions,
            _that.medications,
            _that.isolationIndicators,
            _that.concerns);
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
            int score,
            String level,
            String? lastIncident,
            int? recentIncidents,
            int? conditions,
            int? medications,
            int? isolationIndicators,
            int? concerns)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RiskCategory() when $default != null:
        return $default(
            _that.score,
            _that.level,
            _that.lastIncident,
            _that.recentIncidents,
            _that.conditions,
            _that.medications,
            _that.isolationIndicators,
            _that.concerns);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _RiskCategory implements RiskCategory {
  const _RiskCategory(
      {required this.score,
      required this.level,
      this.lastIncident,
      this.recentIncidents,
      this.conditions,
      this.medications,
      this.isolationIndicators,
      this.concerns});
  factory _RiskCategory.fromJson(Map<String, dynamic> json) =>
      _$RiskCategoryFromJson(json);

  @override
  final int score;
  @override
  final String level;
  @override
  final String? lastIncident;
  @override
  final int? recentIncidents;
  @override
  final int? conditions;
  @override
  final int? medications;
  @override
  final int? isolationIndicators;
  @override
  final int? concerns;

  /// Create a copy of RiskCategory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RiskCategoryCopyWith<_RiskCategory> get copyWith =>
      __$RiskCategoryCopyWithImpl<_RiskCategory>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$RiskCategoryToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RiskCategory &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.lastIncident, lastIncident) ||
                other.lastIncident == lastIncident) &&
            (identical(other.recentIncidents, recentIncidents) ||
                other.recentIncidents == recentIncidents) &&
            (identical(other.conditions, conditions) ||
                other.conditions == conditions) &&
            (identical(other.medications, medications) ||
                other.medications == medications) &&
            (identical(other.isolationIndicators, isolationIndicators) ||
                other.isolationIndicators == isolationIndicators) &&
            (identical(other.concerns, concerns) ||
                other.concerns == concerns));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, score, level, lastIncident,
      recentIncidents, conditions, medications, isolationIndicators, concerns);

  @override
  String toString() {
    return 'RiskCategory(score: $score, level: $level, lastIncident: $lastIncident, recentIncidents: $recentIncidents, conditions: $conditions, medications: $medications, isolationIndicators: $isolationIndicators, concerns: $concerns)';
  }
}

/// @nodoc
abstract mixin class _$RiskCategoryCopyWith<$Res>
    implements $RiskCategoryCopyWith<$Res> {
  factory _$RiskCategoryCopyWith(
          _RiskCategory value, $Res Function(_RiskCategory) _then) =
      __$RiskCategoryCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int score,
      String level,
      String? lastIncident,
      int? recentIncidents,
      int? conditions,
      int? medications,
      int? isolationIndicators,
      int? concerns});
}

/// @nodoc
class __$RiskCategoryCopyWithImpl<$Res>
    implements _$RiskCategoryCopyWith<$Res> {
  __$RiskCategoryCopyWithImpl(this._self, this._then);

  final _RiskCategory _self;
  final $Res Function(_RiskCategory) _then;

  /// Create a copy of RiskCategory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? score = null,
    Object? level = null,
    Object? lastIncident = freezed,
    Object? recentIncidents = freezed,
    Object? conditions = freezed,
    Object? medications = freezed,
    Object? isolationIndicators = freezed,
    Object? concerns = freezed,
  }) {
    return _then(_RiskCategory(
      score: null == score
          ? _self.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
      level: null == level
          ? _self.level
          : level // ignore: cast_nullable_to_non_nullable
              as String,
      lastIncident: freezed == lastIncident
          ? _self.lastIncident
          : lastIncident // ignore: cast_nullable_to_non_nullable
              as String?,
      recentIncidents: freezed == recentIncidents
          ? _self.recentIncidents
          : recentIncidents // ignore: cast_nullable_to_non_nullable
              as int?,
      conditions: freezed == conditions
          ? _self.conditions
          : conditions // ignore: cast_nullable_to_non_nullable
              as int?,
      medications: freezed == medications
          ? _self.medications
          : medications // ignore: cast_nullable_to_non_nullable
              as int?,
      isolationIndicators: freezed == isolationIndicators
          ? _self.isolationIndicators
          : isolationIndicators // ignore: cast_nullable_to_non_nullable
              as int?,
      concerns: freezed == concerns
          ? _self.concerns
          : concerns // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
mixin _$RiskTrends {
  String get direction;
  int get changePercentage;
  String get period;

  /// Create a copy of RiskTrends
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RiskTrendsCopyWith<RiskTrends> get copyWith =>
      _$RiskTrendsCopyWithImpl<RiskTrends>(this as RiskTrends, _$identity);

  /// Serializes this RiskTrends to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RiskTrends &&
            (identical(other.direction, direction) ||
                other.direction == direction) &&
            (identical(other.changePercentage, changePercentage) ||
                other.changePercentage == changePercentage) &&
            (identical(other.period, period) || other.period == period));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, direction, changePercentage, period);

  @override
  String toString() {
    return 'RiskTrends(direction: $direction, changePercentage: $changePercentage, period: $period)';
  }
}

/// @nodoc
abstract mixin class $RiskTrendsCopyWith<$Res> {
  factory $RiskTrendsCopyWith(
          RiskTrends value, $Res Function(RiskTrends) _then) =
      _$RiskTrendsCopyWithImpl;
  @useResult
  $Res call({String direction, int changePercentage, String period});
}

/// @nodoc
class _$RiskTrendsCopyWithImpl<$Res> implements $RiskTrendsCopyWith<$Res> {
  _$RiskTrendsCopyWithImpl(this._self, this._then);

  final RiskTrends _self;
  final $Res Function(RiskTrends) _then;

  /// Create a copy of RiskTrends
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? direction = null,
    Object? changePercentage = null,
    Object? period = null,
  }) {
    return _then(_self.copyWith(
      direction: null == direction
          ? _self.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as String,
      changePercentage: null == changePercentage
          ? _self.changePercentage
          : changePercentage // ignore: cast_nullable_to_non_nullable
              as int,
      period: null == period
          ? _self.period
          : period // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [RiskTrends].
extension RiskTrendsPatterns on RiskTrends {
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
    TResult Function(_RiskTrends value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RiskTrends() when $default != null:
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
    TResult Function(_RiskTrends value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RiskTrends():
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
    TResult? Function(_RiskTrends value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RiskTrends() when $default != null:
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
    TResult Function(String direction, int changePercentage, String period)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RiskTrends() when $default != null:
        return $default(_that.direction, _that.changePercentage, _that.period);
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
    TResult Function(String direction, int changePercentage, String period)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RiskTrends():
        return $default(_that.direction, _that.changePercentage, _that.period);
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
    TResult? Function(String direction, int changePercentage, String period)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RiskTrends() when $default != null:
        return $default(_that.direction, _that.changePercentage, _that.period);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _RiskTrends implements RiskTrends {
  const _RiskTrends(
      {required this.direction,
      required this.changePercentage,
      required this.period});
  factory _RiskTrends.fromJson(Map<String, dynamic> json) =>
      _$RiskTrendsFromJson(json);

  @override
  final String direction;
  @override
  final int changePercentage;
  @override
  final String period;

  /// Create a copy of RiskTrends
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RiskTrendsCopyWith<_RiskTrends> get copyWith =>
      __$RiskTrendsCopyWithImpl<_RiskTrends>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$RiskTrendsToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RiskTrends &&
            (identical(other.direction, direction) ||
                other.direction == direction) &&
            (identical(other.changePercentage, changePercentage) ||
                other.changePercentage == changePercentage) &&
            (identical(other.period, period) || other.period == period));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, direction, changePercentage, period);

  @override
  String toString() {
    return 'RiskTrends(direction: $direction, changePercentage: $changePercentage, period: $period)';
  }
}

/// @nodoc
abstract mixin class _$RiskTrendsCopyWith<$Res>
    implements $RiskTrendsCopyWith<$Res> {
  factory _$RiskTrendsCopyWith(
          _RiskTrends value, $Res Function(_RiskTrends) _then) =
      __$RiskTrendsCopyWithImpl;
  @override
  @useResult
  $Res call({String direction, int changePercentage, String period});
}

/// @nodoc
class __$RiskTrendsCopyWithImpl<$Res> implements _$RiskTrendsCopyWith<$Res> {
  __$RiskTrendsCopyWithImpl(this._self, this._then);

  final _RiskTrends _self;
  final $Res Function(_RiskTrends) _then;

  /// Create a copy of RiskTrends
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? direction = null,
    Object? changePercentage = null,
    Object? period = null,
  }) {
    return _then(_RiskTrends(
      direction: null == direction
          ? _self.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as String,
      changePercentage: null == changePercentage
          ? _self.changePercentage
          : changePercentage // ignore: cast_nullable_to_non_nullable
              as int,
      period: null == period
          ? _self.period
          : period // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$RiskRecommendation {
  String get priority;
  String get recommendation;
  String get timeline;

  /// Create a copy of RiskRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RiskRecommendationCopyWith<RiskRecommendation> get copyWith =>
      _$RiskRecommendationCopyWithImpl<RiskRecommendation>(
          this as RiskRecommendation, _$identity);

  /// Serializes this RiskRecommendation to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RiskRecommendation &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.recommendation, recommendation) ||
                other.recommendation == recommendation) &&
            (identical(other.timeline, timeline) ||
                other.timeline == timeline));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, priority, recommendation, timeline);

  @override
  String toString() {
    return 'RiskRecommendation(priority: $priority, recommendation: $recommendation, timeline: $timeline)';
  }
}

/// @nodoc
abstract mixin class $RiskRecommendationCopyWith<$Res> {
  factory $RiskRecommendationCopyWith(
          RiskRecommendation value, $Res Function(RiskRecommendation) _then) =
      _$RiskRecommendationCopyWithImpl;
  @useResult
  $Res call({String priority, String recommendation, String timeline});
}

/// @nodoc
class _$RiskRecommendationCopyWithImpl<$Res>
    implements $RiskRecommendationCopyWith<$Res> {
  _$RiskRecommendationCopyWithImpl(this._self, this._then);

  final RiskRecommendation _self;
  final $Res Function(RiskRecommendation) _then;

  /// Create a copy of RiskRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? priority = null,
    Object? recommendation = null,
    Object? timeline = null,
  }) {
    return _then(_self.copyWith(
      priority: null == priority
          ? _self.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as String,
      recommendation: null == recommendation
          ? _self.recommendation
          : recommendation // ignore: cast_nullable_to_non_nullable
              as String,
      timeline: null == timeline
          ? _self.timeline
          : timeline // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [RiskRecommendation].
extension RiskRecommendationPatterns on RiskRecommendation {
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
    TResult Function(_RiskRecommendation value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RiskRecommendation() when $default != null:
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
    TResult Function(_RiskRecommendation value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RiskRecommendation():
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
    TResult? Function(_RiskRecommendation value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RiskRecommendation() when $default != null:
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
    TResult Function(String priority, String recommendation, String timeline)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RiskRecommendation() when $default != null:
        return $default(_that.priority, _that.recommendation, _that.timeline);
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
    TResult Function(String priority, String recommendation, String timeline)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RiskRecommendation():
        return $default(_that.priority, _that.recommendation, _that.timeline);
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
    TResult? Function(String priority, String recommendation, String timeline)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RiskRecommendation() when $default != null:
        return $default(_that.priority, _that.recommendation, _that.timeline);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _RiskRecommendation implements RiskRecommendation {
  const _RiskRecommendation(
      {required this.priority,
      required this.recommendation,
      required this.timeline});
  factory _RiskRecommendation.fromJson(Map<String, dynamic> json) =>
      _$RiskRecommendationFromJson(json);

  @override
  final String priority;
  @override
  final String recommendation;
  @override
  final String timeline;

  /// Create a copy of RiskRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RiskRecommendationCopyWith<_RiskRecommendation> get copyWith =>
      __$RiskRecommendationCopyWithImpl<_RiskRecommendation>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$RiskRecommendationToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RiskRecommendation &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.recommendation, recommendation) ||
                other.recommendation == recommendation) &&
            (identical(other.timeline, timeline) ||
                other.timeline == timeline));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, priority, recommendation, timeline);

  @override
  String toString() {
    return 'RiskRecommendation(priority: $priority, recommendation: $recommendation, timeline: $timeline)';
  }
}

/// @nodoc
abstract mixin class _$RiskRecommendationCopyWith<$Res>
    implements $RiskRecommendationCopyWith<$Res> {
  factory _$RiskRecommendationCopyWith(
          _RiskRecommendation value, $Res Function(_RiskRecommendation) _then) =
      __$RiskRecommendationCopyWithImpl;
  @override
  @useResult
  $Res call({String priority, String recommendation, String timeline});
}

/// @nodoc
class __$RiskRecommendationCopyWithImpl<$Res>
    implements _$RiskRecommendationCopyWith<$Res> {
  __$RiskRecommendationCopyWithImpl(this._self, this._then);

  final _RiskRecommendation _self;
  final $Res Function(_RiskRecommendation) _then;

  /// Create a copy of RiskRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? priority = null,
    Object? recommendation = null,
    Object? timeline = null,
  }) {
    return _then(_RiskRecommendation(
      priority: null == priority
          ? _self.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as String,
      recommendation: null == recommendation
          ? _self.recommendation
          : recommendation // ignore: cast_nullable_to_non_nullable
              as String,
      timeline: null == timeline
          ? _self.timeline
          : timeline // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$FallsRiskAssessment {
  int get riskScore;
  String get riskLevel;
  double get confidence;
  List<ContributingFactor> get contributingFactors;
  List<String> get preventionStrategies;
  MonitoringPlan get monitoringPlan;
  List<String> get interventions;

  /// Create a copy of FallsRiskAssessment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $FallsRiskAssessmentCopyWith<FallsRiskAssessment> get copyWith =>
      _$FallsRiskAssessmentCopyWithImpl<FallsRiskAssessment>(
          this as FallsRiskAssessment, _$identity);

  /// Serializes this FallsRiskAssessment to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is FallsRiskAssessment &&
            (identical(other.riskScore, riskScore) ||
                other.riskScore == riskScore) &&
            (identical(other.riskLevel, riskLevel) ||
                other.riskLevel == riskLevel) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence) &&
            const DeepCollectionEquality()
                .equals(other.contributingFactors, contributingFactors) &&
            const DeepCollectionEquality()
                .equals(other.preventionStrategies, preventionStrategies) &&
            (identical(other.monitoringPlan, monitoringPlan) ||
                other.monitoringPlan == monitoringPlan) &&
            const DeepCollectionEquality()
                .equals(other.interventions, interventions));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      riskScore,
      riskLevel,
      confidence,
      const DeepCollectionEquality().hash(contributingFactors),
      const DeepCollectionEquality().hash(preventionStrategies),
      monitoringPlan,
      const DeepCollectionEquality().hash(interventions));

  @override
  String toString() {
    return 'FallsRiskAssessment(riskScore: $riskScore, riskLevel: $riskLevel, confidence: $confidence, contributingFactors: $contributingFactors, preventionStrategies: $preventionStrategies, monitoringPlan: $monitoringPlan, interventions: $interventions)';
  }
}

/// @nodoc
abstract mixin class $FallsRiskAssessmentCopyWith<$Res> {
  factory $FallsRiskAssessmentCopyWith(
          FallsRiskAssessment value, $Res Function(FallsRiskAssessment) _then) =
      _$FallsRiskAssessmentCopyWithImpl;
  @useResult
  $Res call(
      {int riskScore,
      String riskLevel,
      double confidence,
      List<ContributingFactor> contributingFactors,
      List<String> preventionStrategies,
      MonitoringPlan monitoringPlan,
      List<String> interventions});

  $MonitoringPlanCopyWith<$Res> get monitoringPlan;
}

/// @nodoc
class _$FallsRiskAssessmentCopyWithImpl<$Res>
    implements $FallsRiskAssessmentCopyWith<$Res> {
  _$FallsRiskAssessmentCopyWithImpl(this._self, this._then);

  final FallsRiskAssessment _self;
  final $Res Function(FallsRiskAssessment) _then;

  /// Create a copy of FallsRiskAssessment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? riskScore = null,
    Object? riskLevel = null,
    Object? confidence = null,
    Object? contributingFactors = null,
    Object? preventionStrategies = null,
    Object? monitoringPlan = null,
    Object? interventions = null,
  }) {
    return _then(_self.copyWith(
      riskScore: null == riskScore
          ? _self.riskScore
          : riskScore // ignore: cast_nullable_to_non_nullable
              as int,
      riskLevel: null == riskLevel
          ? _self.riskLevel
          : riskLevel // ignore: cast_nullable_to_non_nullable
              as String,
      confidence: null == confidence
          ? _self.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
      contributingFactors: null == contributingFactors
          ? _self.contributingFactors
          : contributingFactors // ignore: cast_nullable_to_non_nullable
              as List<ContributingFactor>,
      preventionStrategies: null == preventionStrategies
          ? _self.preventionStrategies
          : preventionStrategies // ignore: cast_nullable_to_non_nullable
              as List<String>,
      monitoringPlan: null == monitoringPlan
          ? _self.monitoringPlan
          : monitoringPlan // ignore: cast_nullable_to_non_nullable
              as MonitoringPlan,
      interventions: null == interventions
          ? _self.interventions
          : interventions // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }

  /// Create a copy of FallsRiskAssessment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MonitoringPlanCopyWith<$Res> get monitoringPlan {
    return $MonitoringPlanCopyWith<$Res>(_self.monitoringPlan, (value) {
      return _then(_self.copyWith(monitoringPlan: value));
    });
  }
}

/// Adds pattern-matching-related methods to [FallsRiskAssessment].
extension FallsRiskAssessmentPatterns on FallsRiskAssessment {
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
    TResult Function(_FallsRiskAssessment value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _FallsRiskAssessment() when $default != null:
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
    TResult Function(_FallsRiskAssessment value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FallsRiskAssessment():
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
    TResult? Function(_FallsRiskAssessment value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FallsRiskAssessment() when $default != null:
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
            int riskScore,
            String riskLevel,
            double confidence,
            List<ContributingFactor> contributingFactors,
            List<String> preventionStrategies,
            MonitoringPlan monitoringPlan,
            List<String> interventions)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _FallsRiskAssessment() when $default != null:
        return $default(
            _that.riskScore,
            _that.riskLevel,
            _that.confidence,
            _that.contributingFactors,
            _that.preventionStrategies,
            _that.monitoringPlan,
            _that.interventions);
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
            int riskScore,
            String riskLevel,
            double confidence,
            List<ContributingFactor> contributingFactors,
            List<String> preventionStrategies,
            MonitoringPlan monitoringPlan,
            List<String> interventions)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FallsRiskAssessment():
        return $default(
            _that.riskScore,
            _that.riskLevel,
            _that.confidence,
            _that.contributingFactors,
            _that.preventionStrategies,
            _that.monitoringPlan,
            _that.interventions);
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
            int riskScore,
            String riskLevel,
            double confidence,
            List<ContributingFactor> contributingFactors,
            List<String> preventionStrategies,
            MonitoringPlan monitoringPlan,
            List<String> interventions)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FallsRiskAssessment() when $default != null:
        return $default(
            _that.riskScore,
            _that.riskLevel,
            _that.confidence,
            _that.contributingFactors,
            _that.preventionStrategies,
            _that.monitoringPlan,
            _that.interventions);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _FallsRiskAssessment implements FallsRiskAssessment {
  const _FallsRiskAssessment(
      {required this.riskScore,
      required this.riskLevel,
      required this.confidence,
      required final List<ContributingFactor> contributingFactors,
      required final List<String> preventionStrategies,
      required this.monitoringPlan,
      required final List<String> interventions})
      : _contributingFactors = contributingFactors,
        _preventionStrategies = preventionStrategies,
        _interventions = interventions;
  factory _FallsRiskAssessment.fromJson(Map<String, dynamic> json) =>
      _$FallsRiskAssessmentFromJson(json);

  @override
  final int riskScore;
  @override
  final String riskLevel;
  @override
  final double confidence;
  final List<ContributingFactor> _contributingFactors;
  @override
  List<ContributingFactor> get contributingFactors {
    if (_contributingFactors is EqualUnmodifiableListView)
      return _contributingFactors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_contributingFactors);
  }

  final List<String> _preventionStrategies;
  @override
  List<String> get preventionStrategies {
    if (_preventionStrategies is EqualUnmodifiableListView)
      return _preventionStrategies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_preventionStrategies);
  }

  @override
  final MonitoringPlan monitoringPlan;
  final List<String> _interventions;
  @override
  List<String> get interventions {
    if (_interventions is EqualUnmodifiableListView) return _interventions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_interventions);
  }

  /// Create a copy of FallsRiskAssessment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$FallsRiskAssessmentCopyWith<_FallsRiskAssessment> get copyWith =>
      __$FallsRiskAssessmentCopyWithImpl<_FallsRiskAssessment>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$FallsRiskAssessmentToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _FallsRiskAssessment &&
            (identical(other.riskScore, riskScore) ||
                other.riskScore == riskScore) &&
            (identical(other.riskLevel, riskLevel) ||
                other.riskLevel == riskLevel) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence) &&
            const DeepCollectionEquality()
                .equals(other._contributingFactors, _contributingFactors) &&
            const DeepCollectionEquality()
                .equals(other._preventionStrategies, _preventionStrategies) &&
            (identical(other.monitoringPlan, monitoringPlan) ||
                other.monitoringPlan == monitoringPlan) &&
            const DeepCollectionEquality()
                .equals(other._interventions, _interventions));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      riskScore,
      riskLevel,
      confidence,
      const DeepCollectionEquality().hash(_contributingFactors),
      const DeepCollectionEquality().hash(_preventionStrategies),
      monitoringPlan,
      const DeepCollectionEquality().hash(_interventions));

  @override
  String toString() {
    return 'FallsRiskAssessment(riskScore: $riskScore, riskLevel: $riskLevel, confidence: $confidence, contributingFactors: $contributingFactors, preventionStrategies: $preventionStrategies, monitoringPlan: $monitoringPlan, interventions: $interventions)';
  }
}

/// @nodoc
abstract mixin class _$FallsRiskAssessmentCopyWith<$Res>
    implements $FallsRiskAssessmentCopyWith<$Res> {
  factory _$FallsRiskAssessmentCopyWith(_FallsRiskAssessment value,
          $Res Function(_FallsRiskAssessment) _then) =
      __$FallsRiskAssessmentCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int riskScore,
      String riskLevel,
      double confidence,
      List<ContributingFactor> contributingFactors,
      List<String> preventionStrategies,
      MonitoringPlan monitoringPlan,
      List<String> interventions});

  @override
  $MonitoringPlanCopyWith<$Res> get monitoringPlan;
}

/// @nodoc
class __$FallsRiskAssessmentCopyWithImpl<$Res>
    implements _$FallsRiskAssessmentCopyWith<$Res> {
  __$FallsRiskAssessmentCopyWithImpl(this._self, this._then);

  final _FallsRiskAssessment _self;
  final $Res Function(_FallsRiskAssessment) _then;

  /// Create a copy of FallsRiskAssessment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? riskScore = null,
    Object? riskLevel = null,
    Object? confidence = null,
    Object? contributingFactors = null,
    Object? preventionStrategies = null,
    Object? monitoringPlan = null,
    Object? interventions = null,
  }) {
    return _then(_FallsRiskAssessment(
      riskScore: null == riskScore
          ? _self.riskScore
          : riskScore // ignore: cast_nullable_to_non_nullable
              as int,
      riskLevel: null == riskLevel
          ? _self.riskLevel
          : riskLevel // ignore: cast_nullable_to_non_nullable
              as String,
      confidence: null == confidence
          ? _self.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
      contributingFactors: null == contributingFactors
          ? _self._contributingFactors
          : contributingFactors // ignore: cast_nullable_to_non_nullable
              as List<ContributingFactor>,
      preventionStrategies: null == preventionStrategies
          ? _self._preventionStrategies
          : preventionStrategies // ignore: cast_nullable_to_non_nullable
              as List<String>,
      monitoringPlan: null == monitoringPlan
          ? _self.monitoringPlan
          : monitoringPlan // ignore: cast_nullable_to_non_nullable
              as MonitoringPlan,
      interventions: null == interventions
          ? _self._interventions
          : interventions // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }

  /// Create a copy of FallsRiskAssessment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MonitoringPlanCopyWith<$Res> get monitoringPlan {
    return $MonitoringPlanCopyWith<$Res>(_self.monitoringPlan, (value) {
      return _then(_self.copyWith(monitoringPlan: value));
    });
  }
}

/// @nodoc
mixin _$ContributingFactor {
  String get factor;
  double get weight;
  bool get present;

  /// Create a copy of ContributingFactor
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ContributingFactorCopyWith<ContributingFactor> get copyWith =>
      _$ContributingFactorCopyWithImpl<ContributingFactor>(
          this as ContributingFactor, _$identity);

  /// Serializes this ContributingFactor to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ContributingFactor &&
            (identical(other.factor, factor) || other.factor == factor) &&
            (identical(other.weight, weight) || other.weight == weight) &&
            (identical(other.present, present) || other.present == present));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, factor, weight, present);

  @override
  String toString() {
    return 'ContributingFactor(factor: $factor, weight: $weight, present: $present)';
  }
}

/// @nodoc
abstract mixin class $ContributingFactorCopyWith<$Res> {
  factory $ContributingFactorCopyWith(
          ContributingFactor value, $Res Function(ContributingFactor) _then) =
      _$ContributingFactorCopyWithImpl;
  @useResult
  $Res call({String factor, double weight, bool present});
}

/// @nodoc
class _$ContributingFactorCopyWithImpl<$Res>
    implements $ContributingFactorCopyWith<$Res> {
  _$ContributingFactorCopyWithImpl(this._self, this._then);

  final ContributingFactor _self;
  final $Res Function(ContributingFactor) _then;

  /// Create a copy of ContributingFactor
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? factor = null,
    Object? weight = null,
    Object? present = null,
  }) {
    return _then(_self.copyWith(
      factor: null == factor
          ? _self.factor
          : factor // ignore: cast_nullable_to_non_nullable
              as String,
      weight: null == weight
          ? _self.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as double,
      present: null == present
          ? _self.present
          : present // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [ContributingFactor].
extension ContributingFactorPatterns on ContributingFactor {
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
    TResult Function(_ContributingFactor value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ContributingFactor() when $default != null:
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
    TResult Function(_ContributingFactor value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ContributingFactor():
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
    TResult? Function(_ContributingFactor value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ContributingFactor() when $default != null:
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
    TResult Function(String factor, double weight, bool present)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ContributingFactor() when $default != null:
        return $default(_that.factor, _that.weight, _that.present);
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
    TResult Function(String factor, double weight, bool present) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ContributingFactor():
        return $default(_that.factor, _that.weight, _that.present);
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
    TResult? Function(String factor, double weight, bool present)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ContributingFactor() when $default != null:
        return $default(_that.factor, _that.weight, _that.present);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ContributingFactor implements ContributingFactor {
  const _ContributingFactor(
      {required this.factor, required this.weight, required this.present});
  factory _ContributingFactor.fromJson(Map<String, dynamic> json) =>
      _$ContributingFactorFromJson(json);

  @override
  final String factor;
  @override
  final double weight;
  @override
  final bool present;

  /// Create a copy of ContributingFactor
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ContributingFactorCopyWith<_ContributingFactor> get copyWith =>
      __$ContributingFactorCopyWithImpl<_ContributingFactor>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ContributingFactorToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ContributingFactor &&
            (identical(other.factor, factor) || other.factor == factor) &&
            (identical(other.weight, weight) || other.weight == weight) &&
            (identical(other.present, present) || other.present == present));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, factor, weight, present);

  @override
  String toString() {
    return 'ContributingFactor(factor: $factor, weight: $weight, present: $present)';
  }
}

/// @nodoc
abstract mixin class _$ContributingFactorCopyWith<$Res>
    implements $ContributingFactorCopyWith<$Res> {
  factory _$ContributingFactorCopyWith(
          _ContributingFactor value, $Res Function(_ContributingFactor) _then) =
      __$ContributingFactorCopyWithImpl;
  @override
  @useResult
  $Res call({String factor, double weight, bool present});
}

/// @nodoc
class __$ContributingFactorCopyWithImpl<$Res>
    implements _$ContributingFactorCopyWith<$Res> {
  __$ContributingFactorCopyWithImpl(this._self, this._then);

  final _ContributingFactor _self;
  final $Res Function(_ContributingFactor) _then;

  /// Create a copy of ContributingFactor
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? factor = null,
    Object? weight = null,
    Object? present = null,
  }) {
    return _then(_ContributingFactor(
      factor: null == factor
          ? _self.factor
          : factor // ignore: cast_nullable_to_non_nullable
              as String,
      weight: null == weight
          ? _self.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as double,
      present: null == present
          ? _self.present
          : present // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
mixin _$MonitoringPlan {
  String get frequency;
  List<String> get indicators;
  bool get alerts;

  /// Create a copy of MonitoringPlan
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MonitoringPlanCopyWith<MonitoringPlan> get copyWith =>
      _$MonitoringPlanCopyWithImpl<MonitoringPlan>(
          this as MonitoringPlan, _$identity);

  /// Serializes this MonitoringPlan to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MonitoringPlan &&
            (identical(other.frequency, frequency) ||
                other.frequency == frequency) &&
            const DeepCollectionEquality()
                .equals(other.indicators, indicators) &&
            (identical(other.alerts, alerts) || other.alerts == alerts));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, frequency,
      const DeepCollectionEquality().hash(indicators), alerts);

  @override
  String toString() {
    return 'MonitoringPlan(frequency: $frequency, indicators: $indicators, alerts: $alerts)';
  }
}

/// @nodoc
abstract mixin class $MonitoringPlanCopyWith<$Res> {
  factory $MonitoringPlanCopyWith(
          MonitoringPlan value, $Res Function(MonitoringPlan) _then) =
      _$MonitoringPlanCopyWithImpl;
  @useResult
  $Res call({String frequency, List<String> indicators, bool alerts});
}

/// @nodoc
class _$MonitoringPlanCopyWithImpl<$Res>
    implements $MonitoringPlanCopyWith<$Res> {
  _$MonitoringPlanCopyWithImpl(this._self, this._then);

  final MonitoringPlan _self;
  final $Res Function(MonitoringPlan) _then;

  /// Create a copy of MonitoringPlan
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? frequency = null,
    Object? indicators = null,
    Object? alerts = null,
  }) {
    return _then(_self.copyWith(
      frequency: null == frequency
          ? _self.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as String,
      indicators: null == indicators
          ? _self.indicators
          : indicators // ignore: cast_nullable_to_non_nullable
              as List<String>,
      alerts: null == alerts
          ? _self.alerts
          : alerts // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [MonitoringPlan].
extension MonitoringPlanPatterns on MonitoringPlan {
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
    TResult Function(_MonitoringPlan value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MonitoringPlan() when $default != null:
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
    TResult Function(_MonitoringPlan value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MonitoringPlan():
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
    TResult? Function(_MonitoringPlan value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MonitoringPlan() when $default != null:
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
    TResult Function(String frequency, List<String> indicators, bool alerts)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MonitoringPlan() when $default != null:
        return $default(_that.frequency, _that.indicators, _that.alerts);
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
    TResult Function(String frequency, List<String> indicators, bool alerts)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MonitoringPlan():
        return $default(_that.frequency, _that.indicators, _that.alerts);
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
    TResult? Function(String frequency, List<String> indicators, bool alerts)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MonitoringPlan() when $default != null:
        return $default(_that.frequency, _that.indicators, _that.alerts);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _MonitoringPlan implements MonitoringPlan {
  const _MonitoringPlan(
      {required this.frequency,
      required final List<String> indicators,
      required this.alerts})
      : _indicators = indicators;
  factory _MonitoringPlan.fromJson(Map<String, dynamic> json) =>
      _$MonitoringPlanFromJson(json);

  @override
  final String frequency;
  final List<String> _indicators;
  @override
  List<String> get indicators {
    if (_indicators is EqualUnmodifiableListView) return _indicators;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_indicators);
  }

  @override
  final bool alerts;

  /// Create a copy of MonitoringPlan
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MonitoringPlanCopyWith<_MonitoringPlan> get copyWith =>
      __$MonitoringPlanCopyWithImpl<_MonitoringPlan>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$MonitoringPlanToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MonitoringPlan &&
            (identical(other.frequency, frequency) ||
                other.frequency == frequency) &&
            const DeepCollectionEquality()
                .equals(other._indicators, _indicators) &&
            (identical(other.alerts, alerts) || other.alerts == alerts));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, frequency,
      const DeepCollectionEquality().hash(_indicators), alerts);

  @override
  String toString() {
    return 'MonitoringPlan(frequency: $frequency, indicators: $indicators, alerts: $alerts)';
  }
}

/// @nodoc
abstract mixin class _$MonitoringPlanCopyWith<$Res>
    implements $MonitoringPlanCopyWith<$Res> {
  factory _$MonitoringPlanCopyWith(
          _MonitoringPlan value, $Res Function(_MonitoringPlan) _then) =
      __$MonitoringPlanCopyWithImpl;
  @override
  @useResult
  $Res call({String frequency, List<String> indicators, bool alerts});
}

/// @nodoc
class __$MonitoringPlanCopyWithImpl<$Res>
    implements _$MonitoringPlanCopyWith<$Res> {
  __$MonitoringPlanCopyWithImpl(this._self, this._then);

  final _MonitoringPlan _self;
  final $Res Function(_MonitoringPlan) _then;

  /// Create a copy of MonitoringPlan
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? frequency = null,
    Object? indicators = null,
    Object? alerts = null,
  }) {
    return _then(_MonitoringPlan(
      frequency: null == frequency
          ? _self.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as String,
      indicators: null == indicators
          ? _self._indicators
          : indicators // ignore: cast_nullable_to_non_nullable
              as List<String>,
      alerts: null == alerts
          ? _self.alerts
          : alerts // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
mixin _$BehaviorEscalationPrediction {
  double get escalationProbability;
  String get timeframe;
  double get confidence;
  List<Trigger> get triggers;
  List<String> get earlyWarningSignals;
  List<String> get deEscalationStrategies;
  List<String> get preventiveMeasures;

  /// Create a copy of BehaviorEscalationPrediction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BehaviorEscalationPredictionCopyWith<BehaviorEscalationPrediction>
      get copyWith => _$BehaviorEscalationPredictionCopyWithImpl<
              BehaviorEscalationPrediction>(
          this as BehaviorEscalationPrediction, _$identity);

  /// Serializes this BehaviorEscalationPrediction to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BehaviorEscalationPrediction &&
            (identical(other.escalationProbability, escalationProbability) ||
                other.escalationProbability == escalationProbability) &&
            (identical(other.timeframe, timeframe) ||
                other.timeframe == timeframe) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence) &&
            const DeepCollectionEquality().equals(other.triggers, triggers) &&
            const DeepCollectionEquality()
                .equals(other.earlyWarningSignals, earlyWarningSignals) &&
            const DeepCollectionEquality()
                .equals(other.deEscalationStrategies, deEscalationStrategies) &&
            const DeepCollectionEquality()
                .equals(other.preventiveMeasures, preventiveMeasures));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      escalationProbability,
      timeframe,
      confidence,
      const DeepCollectionEquality().hash(triggers),
      const DeepCollectionEquality().hash(earlyWarningSignals),
      const DeepCollectionEquality().hash(deEscalationStrategies),
      const DeepCollectionEquality().hash(preventiveMeasures));

  @override
  String toString() {
    return 'BehaviorEscalationPrediction(escalationProbability: $escalationProbability, timeframe: $timeframe, confidence: $confidence, triggers: $triggers, earlyWarningSignals: $earlyWarningSignals, deEscalationStrategies: $deEscalationStrategies, preventiveMeasures: $preventiveMeasures)';
  }
}

/// @nodoc
abstract mixin class $BehaviorEscalationPredictionCopyWith<$Res> {
  factory $BehaviorEscalationPredictionCopyWith(
          BehaviorEscalationPrediction value,
          $Res Function(BehaviorEscalationPrediction) _then) =
      _$BehaviorEscalationPredictionCopyWithImpl;
  @useResult
  $Res call(
      {double escalationProbability,
      String timeframe,
      double confidence,
      List<Trigger> triggers,
      List<String> earlyWarningSignals,
      List<String> deEscalationStrategies,
      List<String> preventiveMeasures});
}

/// @nodoc
class _$BehaviorEscalationPredictionCopyWithImpl<$Res>
    implements $BehaviorEscalationPredictionCopyWith<$Res> {
  _$BehaviorEscalationPredictionCopyWithImpl(this._self, this._then);

  final BehaviorEscalationPrediction _self;
  final $Res Function(BehaviorEscalationPrediction) _then;

  /// Create a copy of BehaviorEscalationPrediction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? escalationProbability = null,
    Object? timeframe = null,
    Object? confidence = null,
    Object? triggers = null,
    Object? earlyWarningSignals = null,
    Object? deEscalationStrategies = null,
    Object? preventiveMeasures = null,
  }) {
    return _then(_self.copyWith(
      escalationProbability: null == escalationProbability
          ? _self.escalationProbability
          : escalationProbability // ignore: cast_nullable_to_non_nullable
              as double,
      timeframe: null == timeframe
          ? _self.timeframe
          : timeframe // ignore: cast_nullable_to_non_nullable
              as String,
      confidence: null == confidence
          ? _self.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
      triggers: null == triggers
          ? _self.triggers
          : triggers // ignore: cast_nullable_to_non_nullable
              as List<Trigger>,
      earlyWarningSignals: null == earlyWarningSignals
          ? _self.earlyWarningSignals
          : earlyWarningSignals // ignore: cast_nullable_to_non_nullable
              as List<String>,
      deEscalationStrategies: null == deEscalationStrategies
          ? _self.deEscalationStrategies
          : deEscalationStrategies // ignore: cast_nullable_to_non_nullable
              as List<String>,
      preventiveMeasures: null == preventiveMeasures
          ? _self.preventiveMeasures
          : preventiveMeasures // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// Adds pattern-matching-related methods to [BehaviorEscalationPrediction].
extension BehaviorEscalationPredictionPatterns on BehaviorEscalationPrediction {
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
    TResult Function(_BehaviorEscalationPrediction value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BehaviorEscalationPrediction() when $default != null:
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
    TResult Function(_BehaviorEscalationPrediction value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BehaviorEscalationPrediction():
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
    TResult? Function(_BehaviorEscalationPrediction value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BehaviorEscalationPrediction() when $default != null:
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
            double escalationProbability,
            String timeframe,
            double confidence,
            List<Trigger> triggers,
            List<String> earlyWarningSignals,
            List<String> deEscalationStrategies,
            List<String> preventiveMeasures)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BehaviorEscalationPrediction() when $default != null:
        return $default(
            _that.escalationProbability,
            _that.timeframe,
            _that.confidence,
            _that.triggers,
            _that.earlyWarningSignals,
            _that.deEscalationStrategies,
            _that.preventiveMeasures);
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
            double escalationProbability,
            String timeframe,
            double confidence,
            List<Trigger> triggers,
            List<String> earlyWarningSignals,
            List<String> deEscalationStrategies,
            List<String> preventiveMeasures)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BehaviorEscalationPrediction():
        return $default(
            _that.escalationProbability,
            _that.timeframe,
            _that.confidence,
            _that.triggers,
            _that.earlyWarningSignals,
            _that.deEscalationStrategies,
            _that.preventiveMeasures);
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
            double escalationProbability,
            String timeframe,
            double confidence,
            List<Trigger> triggers,
            List<String> earlyWarningSignals,
            List<String> deEscalationStrategies,
            List<String> preventiveMeasures)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BehaviorEscalationPrediction() when $default != null:
        return $default(
            _that.escalationProbability,
            _that.timeframe,
            _that.confidence,
            _that.triggers,
            _that.earlyWarningSignals,
            _that.deEscalationStrategies,
            _that.preventiveMeasures);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _BehaviorEscalationPrediction implements BehaviorEscalationPrediction {
  const _BehaviorEscalationPrediction(
      {required this.escalationProbability,
      required this.timeframe,
      required this.confidence,
      required final List<Trigger> triggers,
      required final List<String> earlyWarningSignals,
      required final List<String> deEscalationStrategies,
      required final List<String> preventiveMeasures})
      : _triggers = triggers,
        _earlyWarningSignals = earlyWarningSignals,
        _deEscalationStrategies = deEscalationStrategies,
        _preventiveMeasures = preventiveMeasures;
  factory _BehaviorEscalationPrediction.fromJson(Map<String, dynamic> json) =>
      _$BehaviorEscalationPredictionFromJson(json);

  @override
  final double escalationProbability;
  @override
  final String timeframe;
  @override
  final double confidence;
  final List<Trigger> _triggers;
  @override
  List<Trigger> get triggers {
    if (_triggers is EqualUnmodifiableListView) return _triggers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_triggers);
  }

  final List<String> _earlyWarningSignals;
  @override
  List<String> get earlyWarningSignals {
    if (_earlyWarningSignals is EqualUnmodifiableListView)
      return _earlyWarningSignals;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_earlyWarningSignals);
  }

  final List<String> _deEscalationStrategies;
  @override
  List<String> get deEscalationStrategies {
    if (_deEscalationStrategies is EqualUnmodifiableListView)
      return _deEscalationStrategies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_deEscalationStrategies);
  }

  final List<String> _preventiveMeasures;
  @override
  List<String> get preventiveMeasures {
    if (_preventiveMeasures is EqualUnmodifiableListView)
      return _preventiveMeasures;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_preventiveMeasures);
  }

  /// Create a copy of BehaviorEscalationPrediction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BehaviorEscalationPredictionCopyWith<_BehaviorEscalationPrediction>
      get copyWith => __$BehaviorEscalationPredictionCopyWithImpl<
          _BehaviorEscalationPrediction>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$BehaviorEscalationPredictionToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BehaviorEscalationPrediction &&
            (identical(other.escalationProbability, escalationProbability) ||
                other.escalationProbability == escalationProbability) &&
            (identical(other.timeframe, timeframe) ||
                other.timeframe == timeframe) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence) &&
            const DeepCollectionEquality().equals(other._triggers, _triggers) &&
            const DeepCollectionEquality()
                .equals(other._earlyWarningSignals, _earlyWarningSignals) &&
            const DeepCollectionEquality().equals(
                other._deEscalationStrategies, _deEscalationStrategies) &&
            const DeepCollectionEquality()
                .equals(other._preventiveMeasures, _preventiveMeasures));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      escalationProbability,
      timeframe,
      confidence,
      const DeepCollectionEquality().hash(_triggers),
      const DeepCollectionEquality().hash(_earlyWarningSignals),
      const DeepCollectionEquality().hash(_deEscalationStrategies),
      const DeepCollectionEquality().hash(_preventiveMeasures));

  @override
  String toString() {
    return 'BehaviorEscalationPrediction(escalationProbability: $escalationProbability, timeframe: $timeframe, confidence: $confidence, triggers: $triggers, earlyWarningSignals: $earlyWarningSignals, deEscalationStrategies: $deEscalationStrategies, preventiveMeasures: $preventiveMeasures)';
  }
}

/// @nodoc
abstract mixin class _$BehaviorEscalationPredictionCopyWith<$Res>
    implements $BehaviorEscalationPredictionCopyWith<$Res> {
  factory _$BehaviorEscalationPredictionCopyWith(
          _BehaviorEscalationPrediction value,
          $Res Function(_BehaviorEscalationPrediction) _then) =
      __$BehaviorEscalationPredictionCopyWithImpl;
  @override
  @useResult
  $Res call(
      {double escalationProbability,
      String timeframe,
      double confidence,
      List<Trigger> triggers,
      List<String> earlyWarningSignals,
      List<String> deEscalationStrategies,
      List<String> preventiveMeasures});
}

/// @nodoc
class __$BehaviorEscalationPredictionCopyWithImpl<$Res>
    implements _$BehaviorEscalationPredictionCopyWith<$Res> {
  __$BehaviorEscalationPredictionCopyWithImpl(this._self, this._then);

  final _BehaviorEscalationPrediction _self;
  final $Res Function(_BehaviorEscalationPrediction) _then;

  /// Create a copy of BehaviorEscalationPrediction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? escalationProbability = null,
    Object? timeframe = null,
    Object? confidence = null,
    Object? triggers = null,
    Object? earlyWarningSignals = null,
    Object? deEscalationStrategies = null,
    Object? preventiveMeasures = null,
  }) {
    return _then(_BehaviorEscalationPrediction(
      escalationProbability: null == escalationProbability
          ? _self.escalationProbability
          : escalationProbability // ignore: cast_nullable_to_non_nullable
              as double,
      timeframe: null == timeframe
          ? _self.timeframe
          : timeframe // ignore: cast_nullable_to_non_nullable
              as String,
      confidence: null == confidence
          ? _self.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
      triggers: null == triggers
          ? _self._triggers
          : triggers // ignore: cast_nullable_to_non_nullable
              as List<Trigger>,
      earlyWarningSignals: null == earlyWarningSignals
          ? _self._earlyWarningSignals
          : earlyWarningSignals // ignore: cast_nullable_to_non_nullable
              as List<String>,
      deEscalationStrategies: null == deEscalationStrategies
          ? _self._deEscalationStrategies
          : deEscalationStrategies // ignore: cast_nullable_to_non_nullable
              as List<String>,
      preventiveMeasures: null == preventiveMeasures
          ? _self._preventiveMeasures
          : preventiveMeasures // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
mixin _$Trigger {
  String get trigger;
  double get likelihood;

  /// Create a copy of Trigger
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TriggerCopyWith<Trigger> get copyWith =>
      _$TriggerCopyWithImpl<Trigger>(this as Trigger, _$identity);

  /// Serializes this Trigger to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Trigger &&
            (identical(other.trigger, trigger) || other.trigger == trigger) &&
            (identical(other.likelihood, likelihood) ||
                other.likelihood == likelihood));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, trigger, likelihood);

  @override
  String toString() {
    return 'Trigger(trigger: $trigger, likelihood: $likelihood)';
  }
}

/// @nodoc
abstract mixin class $TriggerCopyWith<$Res> {
  factory $TriggerCopyWith(Trigger value, $Res Function(Trigger) _then) =
      _$TriggerCopyWithImpl;
  @useResult
  $Res call({String trigger, double likelihood});
}

/// @nodoc
class _$TriggerCopyWithImpl<$Res> implements $TriggerCopyWith<$Res> {
  _$TriggerCopyWithImpl(this._self, this._then);

  final Trigger _self;
  final $Res Function(Trigger) _then;

  /// Create a copy of Trigger
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? trigger = null,
    Object? likelihood = null,
  }) {
    return _then(_self.copyWith(
      trigger: null == trigger
          ? _self.trigger
          : trigger // ignore: cast_nullable_to_non_nullable
              as String,
      likelihood: null == likelihood
          ? _self.likelihood
          : likelihood // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// Adds pattern-matching-related methods to [Trigger].
extension TriggerPatterns on Trigger {
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
    TResult Function(_Trigger value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Trigger() when $default != null:
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
    TResult Function(_Trigger value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Trigger():
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
    TResult? Function(_Trigger value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Trigger() when $default != null:
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
    TResult Function(String trigger, double likelihood)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Trigger() when $default != null:
        return $default(_that.trigger, _that.likelihood);
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
    TResult Function(String trigger, double likelihood) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Trigger():
        return $default(_that.trigger, _that.likelihood);
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
    TResult? Function(String trigger, double likelihood)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Trigger() when $default != null:
        return $default(_that.trigger, _that.likelihood);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Trigger implements Trigger {
  const _Trigger({required this.trigger, required this.likelihood});
  factory _Trigger.fromJson(Map<String, dynamic> json) =>
      _$TriggerFromJson(json);

  @override
  final String trigger;
  @override
  final double likelihood;

  /// Create a copy of Trigger
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TriggerCopyWith<_Trigger> get copyWith =>
      __$TriggerCopyWithImpl<_Trigger>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TriggerToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Trigger &&
            (identical(other.trigger, trigger) || other.trigger == trigger) &&
            (identical(other.likelihood, likelihood) ||
                other.likelihood == likelihood));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, trigger, likelihood);

  @override
  String toString() {
    return 'Trigger(trigger: $trigger, likelihood: $likelihood)';
  }
}

/// @nodoc
abstract mixin class _$TriggerCopyWith<$Res> implements $TriggerCopyWith<$Res> {
  factory _$TriggerCopyWith(_Trigger value, $Res Function(_Trigger) _then) =
      __$TriggerCopyWithImpl;
  @override
  @useResult
  $Res call({String trigger, double likelihood});
}

/// @nodoc
class __$TriggerCopyWithImpl<$Res> implements _$TriggerCopyWith<$Res> {
  __$TriggerCopyWithImpl(this._self, this._then);

  final _Trigger _self;
  final $Res Function(_Trigger) _then;

  /// Create a copy of Trigger
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? trigger = null,
    Object? likelihood = null,
  }) {
    return _then(_Trigger(
      trigger: null == trigger
          ? _self.trigger
          : trigger // ignore: cast_nullable_to_non_nullable
              as String,
      likelihood: null == likelihood
          ? _self.likelihood
          : likelihood // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
mixin _$CarePlan {
  String get clientId;
  String get organizationId;
  String get planId;
  String get createdAt;
  String get status;
  Assessment get assessment;
  List<SmartGoal> get goals;
  List<ServiceRecommendation> get services;
  Resources get resources;
  Timeline get timeline;
  List<Review> get reviewSchedule;
  List<SuccessMetric> get successMetrics;

  /// Create a copy of CarePlan
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CarePlanCopyWith<CarePlan> get copyWith =>
      _$CarePlanCopyWithImpl<CarePlan>(this as CarePlan, _$identity);

  /// Serializes this CarePlan to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CarePlan &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.planId, planId) || other.planId == planId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.assessment, assessment) ||
                other.assessment == assessment) &&
            const DeepCollectionEquality().equals(other.goals, goals) &&
            const DeepCollectionEquality().equals(other.services, services) &&
            (identical(other.resources, resources) ||
                other.resources == resources) &&
            (identical(other.timeline, timeline) ||
                other.timeline == timeline) &&
            const DeepCollectionEquality()
                .equals(other.reviewSchedule, reviewSchedule) &&
            const DeepCollectionEquality()
                .equals(other.successMetrics, successMetrics));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      clientId,
      organizationId,
      planId,
      createdAt,
      status,
      assessment,
      const DeepCollectionEquality().hash(goals),
      const DeepCollectionEquality().hash(services),
      resources,
      timeline,
      const DeepCollectionEquality().hash(reviewSchedule),
      const DeepCollectionEquality().hash(successMetrics));

  @override
  String toString() {
    return 'CarePlan(clientId: $clientId, organizationId: $organizationId, planId: $planId, createdAt: $createdAt, status: $status, assessment: $assessment, goals: $goals, services: $services, resources: $resources, timeline: $timeline, reviewSchedule: $reviewSchedule, successMetrics: $successMetrics)';
  }
}

/// @nodoc
abstract mixin class $CarePlanCopyWith<$Res> {
  factory $CarePlanCopyWith(CarePlan value, $Res Function(CarePlan) _then) =
      _$CarePlanCopyWithImpl;
  @useResult
  $Res call(
      {String clientId,
      String organizationId,
      String planId,
      String createdAt,
      String status,
      Assessment assessment,
      List<SmartGoal> goals,
      List<ServiceRecommendation> services,
      Resources resources,
      Timeline timeline,
      List<Review> reviewSchedule,
      List<SuccessMetric> successMetrics});

  $AssessmentCopyWith<$Res> get assessment;
  $ResourcesCopyWith<$Res> get resources;
  $TimelineCopyWith<$Res> get timeline;
}

/// @nodoc
class _$CarePlanCopyWithImpl<$Res> implements $CarePlanCopyWith<$Res> {
  _$CarePlanCopyWithImpl(this._self, this._then);

  final CarePlan _self;
  final $Res Function(CarePlan) _then;

  /// Create a copy of CarePlan
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clientId = null,
    Object? organizationId = null,
    Object? planId = null,
    Object? createdAt = null,
    Object? status = null,
    Object? assessment = null,
    Object? goals = null,
    Object? services = null,
    Object? resources = null,
    Object? timeline = null,
    Object? reviewSchedule = null,
    Object? successMetrics = null,
  }) {
    return _then(_self.copyWith(
      clientId: null == clientId
          ? _self.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: null == organizationId
          ? _self.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      planId: null == planId
          ? _self.planId
          : planId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      assessment: null == assessment
          ? _self.assessment
          : assessment // ignore: cast_nullable_to_non_nullable
              as Assessment,
      goals: null == goals
          ? _self.goals
          : goals // ignore: cast_nullable_to_non_nullable
              as List<SmartGoal>,
      services: null == services
          ? _self.services
          : services // ignore: cast_nullable_to_non_nullable
              as List<ServiceRecommendation>,
      resources: null == resources
          ? _self.resources
          : resources // ignore: cast_nullable_to_non_nullable
              as Resources,
      timeline: null == timeline
          ? _self.timeline
          : timeline // ignore: cast_nullable_to_non_nullable
              as Timeline,
      reviewSchedule: null == reviewSchedule
          ? _self.reviewSchedule
          : reviewSchedule // ignore: cast_nullable_to_non_nullable
              as List<Review>,
      successMetrics: null == successMetrics
          ? _self.successMetrics
          : successMetrics // ignore: cast_nullable_to_non_nullable
              as List<SuccessMetric>,
    ));
  }

  /// Create a copy of CarePlan
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AssessmentCopyWith<$Res> get assessment {
    return $AssessmentCopyWith<$Res>(_self.assessment, (value) {
      return _then(_self.copyWith(assessment: value));
    });
  }

  /// Create a copy of CarePlan
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ResourcesCopyWith<$Res> get resources {
    return $ResourcesCopyWith<$Res>(_self.resources, (value) {
      return _then(_self.copyWith(resources: value));
    });
  }

  /// Create a copy of CarePlan
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TimelineCopyWith<$Res> get timeline {
    return $TimelineCopyWith<$Res>(_self.timeline, (value) {
      return _then(_self.copyWith(timeline: value));
    });
  }
}

/// Adds pattern-matching-related methods to [CarePlan].
extension CarePlanPatterns on CarePlan {
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
    TResult Function(_CarePlan value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CarePlan() when $default != null:
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
    TResult Function(_CarePlan value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CarePlan():
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
    TResult? Function(_CarePlan value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CarePlan() when $default != null:
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
            String clientId,
            String organizationId,
            String planId,
            String createdAt,
            String status,
            Assessment assessment,
            List<SmartGoal> goals,
            List<ServiceRecommendation> services,
            Resources resources,
            Timeline timeline,
            List<Review> reviewSchedule,
            List<SuccessMetric> successMetrics)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CarePlan() when $default != null:
        return $default(
            _that.clientId,
            _that.organizationId,
            _that.planId,
            _that.createdAt,
            _that.status,
            _that.assessment,
            _that.goals,
            _that.services,
            _that.resources,
            _that.timeline,
            _that.reviewSchedule,
            _that.successMetrics);
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
            String clientId,
            String organizationId,
            String planId,
            String createdAt,
            String status,
            Assessment assessment,
            List<SmartGoal> goals,
            List<ServiceRecommendation> services,
            Resources resources,
            Timeline timeline,
            List<Review> reviewSchedule,
            List<SuccessMetric> successMetrics)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CarePlan():
        return $default(
            _that.clientId,
            _that.organizationId,
            _that.planId,
            _that.createdAt,
            _that.status,
            _that.assessment,
            _that.goals,
            _that.services,
            _that.resources,
            _that.timeline,
            _that.reviewSchedule,
            _that.successMetrics);
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
            String clientId,
            String organizationId,
            String planId,
            String createdAt,
            String status,
            Assessment assessment,
            List<SmartGoal> goals,
            List<ServiceRecommendation> services,
            Resources resources,
            Timeline timeline,
            List<Review> reviewSchedule,
            List<SuccessMetric> successMetrics)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CarePlan() when $default != null:
        return $default(
            _that.clientId,
            _that.organizationId,
            _that.planId,
            _that.createdAt,
            _that.status,
            _that.assessment,
            _that.goals,
            _that.services,
            _that.resources,
            _that.timeline,
            _that.reviewSchedule,
            _that.successMetrics);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _CarePlan implements CarePlan {
  const _CarePlan(
      {required this.clientId,
      required this.organizationId,
      required this.planId,
      required this.createdAt,
      required this.status,
      required this.assessment,
      required final List<SmartGoal> goals,
      required final List<ServiceRecommendation> services,
      required this.resources,
      required this.timeline,
      required final List<Review> reviewSchedule,
      required final List<SuccessMetric> successMetrics})
      : _goals = goals,
        _services = services,
        _reviewSchedule = reviewSchedule,
        _successMetrics = successMetrics;
  factory _CarePlan.fromJson(Map<String, dynamic> json) =>
      _$CarePlanFromJson(json);

  @override
  final String clientId;
  @override
  final String organizationId;
  @override
  final String planId;
  @override
  final String createdAt;
  @override
  final String status;
  @override
  final Assessment assessment;
  final List<SmartGoal> _goals;
  @override
  List<SmartGoal> get goals {
    if (_goals is EqualUnmodifiableListView) return _goals;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_goals);
  }

  final List<ServiceRecommendation> _services;
  @override
  List<ServiceRecommendation> get services {
    if (_services is EqualUnmodifiableListView) return _services;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_services);
  }

  @override
  final Resources resources;
  @override
  final Timeline timeline;
  final List<Review> _reviewSchedule;
  @override
  List<Review> get reviewSchedule {
    if (_reviewSchedule is EqualUnmodifiableListView) return _reviewSchedule;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_reviewSchedule);
  }

  final List<SuccessMetric> _successMetrics;
  @override
  List<SuccessMetric> get successMetrics {
    if (_successMetrics is EqualUnmodifiableListView) return _successMetrics;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_successMetrics);
  }

  /// Create a copy of CarePlan
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CarePlanCopyWith<_CarePlan> get copyWith =>
      __$CarePlanCopyWithImpl<_CarePlan>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CarePlanToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CarePlan &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.planId, planId) || other.planId == planId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.assessment, assessment) ||
                other.assessment == assessment) &&
            const DeepCollectionEquality().equals(other._goals, _goals) &&
            const DeepCollectionEquality().equals(other._services, _services) &&
            (identical(other.resources, resources) ||
                other.resources == resources) &&
            (identical(other.timeline, timeline) ||
                other.timeline == timeline) &&
            const DeepCollectionEquality()
                .equals(other._reviewSchedule, _reviewSchedule) &&
            const DeepCollectionEquality()
                .equals(other._successMetrics, _successMetrics));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      clientId,
      organizationId,
      planId,
      createdAt,
      status,
      assessment,
      const DeepCollectionEquality().hash(_goals),
      const DeepCollectionEquality().hash(_services),
      resources,
      timeline,
      const DeepCollectionEquality().hash(_reviewSchedule),
      const DeepCollectionEquality().hash(_successMetrics));

  @override
  String toString() {
    return 'CarePlan(clientId: $clientId, organizationId: $organizationId, planId: $planId, createdAt: $createdAt, status: $status, assessment: $assessment, goals: $goals, services: $services, resources: $resources, timeline: $timeline, reviewSchedule: $reviewSchedule, successMetrics: $successMetrics)';
  }
}

/// @nodoc
abstract mixin class _$CarePlanCopyWith<$Res>
    implements $CarePlanCopyWith<$Res> {
  factory _$CarePlanCopyWith(_CarePlan value, $Res Function(_CarePlan) _then) =
      __$CarePlanCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String clientId,
      String organizationId,
      String planId,
      String createdAt,
      String status,
      Assessment assessment,
      List<SmartGoal> goals,
      List<ServiceRecommendation> services,
      Resources resources,
      Timeline timeline,
      List<Review> reviewSchedule,
      List<SuccessMetric> successMetrics});

  @override
  $AssessmentCopyWith<$Res> get assessment;
  @override
  $ResourcesCopyWith<$Res> get resources;
  @override
  $TimelineCopyWith<$Res> get timeline;
}

/// @nodoc
class __$CarePlanCopyWithImpl<$Res> implements _$CarePlanCopyWith<$Res> {
  __$CarePlanCopyWithImpl(this._self, this._then);

  final _CarePlan _self;
  final $Res Function(_CarePlan) _then;

  /// Create a copy of CarePlan
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? clientId = null,
    Object? organizationId = null,
    Object? planId = null,
    Object? createdAt = null,
    Object? status = null,
    Object? assessment = null,
    Object? goals = null,
    Object? services = null,
    Object? resources = null,
    Object? timeline = null,
    Object? reviewSchedule = null,
    Object? successMetrics = null,
  }) {
    return _then(_CarePlan(
      clientId: null == clientId
          ? _self.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: null == organizationId
          ? _self.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      planId: null == planId
          ? _self.planId
          : planId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      assessment: null == assessment
          ? _self.assessment
          : assessment // ignore: cast_nullable_to_non_nullable
              as Assessment,
      goals: null == goals
          ? _self._goals
          : goals // ignore: cast_nullable_to_non_nullable
              as List<SmartGoal>,
      services: null == services
          ? _self._services
          : services // ignore: cast_nullable_to_non_nullable
              as List<ServiceRecommendation>,
      resources: null == resources
          ? _self.resources
          : resources // ignore: cast_nullable_to_non_nullable
              as Resources,
      timeline: null == timeline
          ? _self.timeline
          : timeline // ignore: cast_nullable_to_non_nullable
              as Timeline,
      reviewSchedule: null == reviewSchedule
          ? _self._reviewSchedule
          : reviewSchedule // ignore: cast_nullable_to_non_nullable
              as List<Review>,
      successMetrics: null == successMetrics
          ? _self._successMetrics
          : successMetrics // ignore: cast_nullable_to_non_nullable
              as List<SuccessMetric>,
    ));
  }

  /// Create a copy of CarePlan
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AssessmentCopyWith<$Res> get assessment {
    return $AssessmentCopyWith<$Res>(_self.assessment, (value) {
      return _then(_self.copyWith(assessment: value));
    });
  }

  /// Create a copy of CarePlan
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ResourcesCopyWith<$Res> get resources {
    return $ResourcesCopyWith<$Res>(_self.resources, (value) {
      return _then(_self.copyWith(resources: value));
    });
  }

  /// Create a copy of CarePlan
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TimelineCopyWith<$Res> get timeline {
    return $TimelineCopyWith<$Res>(_self.timeline, (value) {
      return _then(_self.copyWith(timeline: value));
    });
  }
}

/// @nodoc
mixin _$Assessment {
  List<String> get strengths;
  List<String> get needs;
  List<String> get preferences;
  List<String> get riskFactors;

  /// Create a copy of Assessment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AssessmentCopyWith<Assessment> get copyWith =>
      _$AssessmentCopyWithImpl<Assessment>(this as Assessment, _$identity);

  /// Serializes this Assessment to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Assessment &&
            const DeepCollectionEquality().equals(other.strengths, strengths) &&
            const DeepCollectionEquality().equals(other.needs, needs) &&
            const DeepCollectionEquality()
                .equals(other.preferences, preferences) &&
            const DeepCollectionEquality()
                .equals(other.riskFactors, riskFactors));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(strengths),
      const DeepCollectionEquality().hash(needs),
      const DeepCollectionEquality().hash(preferences),
      const DeepCollectionEquality().hash(riskFactors));

  @override
  String toString() {
    return 'Assessment(strengths: $strengths, needs: $needs, preferences: $preferences, riskFactors: $riskFactors)';
  }
}

/// @nodoc
abstract mixin class $AssessmentCopyWith<$Res> {
  factory $AssessmentCopyWith(
          Assessment value, $Res Function(Assessment) _then) =
      _$AssessmentCopyWithImpl;
  @useResult
  $Res call(
      {List<String> strengths,
      List<String> needs,
      List<String> preferences,
      List<String> riskFactors});
}

/// @nodoc
class _$AssessmentCopyWithImpl<$Res> implements $AssessmentCopyWith<$Res> {
  _$AssessmentCopyWithImpl(this._self, this._then);

  final Assessment _self;
  final $Res Function(Assessment) _then;

  /// Create a copy of Assessment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? strengths = null,
    Object? needs = null,
    Object? preferences = null,
    Object? riskFactors = null,
  }) {
    return _then(_self.copyWith(
      strengths: null == strengths
          ? _self.strengths
          : strengths // ignore: cast_nullable_to_non_nullable
              as List<String>,
      needs: null == needs
          ? _self.needs
          : needs // ignore: cast_nullable_to_non_nullable
              as List<String>,
      preferences: null == preferences
          ? _self.preferences
          : preferences // ignore: cast_nullable_to_non_nullable
              as List<String>,
      riskFactors: null == riskFactors
          ? _self.riskFactors
          : riskFactors // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// Adds pattern-matching-related methods to [Assessment].
extension AssessmentPatterns on Assessment {
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
    TResult Function(_Assessment value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Assessment() when $default != null:
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
    TResult Function(_Assessment value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Assessment():
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
    TResult? Function(_Assessment value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Assessment() when $default != null:
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
    TResult Function(List<String> strengths, List<String> needs,
            List<String> preferences, List<String> riskFactors)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Assessment() when $default != null:
        return $default(
            _that.strengths, _that.needs, _that.preferences, _that.riskFactors);
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
    TResult Function(List<String> strengths, List<String> needs,
            List<String> preferences, List<String> riskFactors)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Assessment():
        return $default(
            _that.strengths, _that.needs, _that.preferences, _that.riskFactors);
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
    TResult? Function(List<String> strengths, List<String> needs,
            List<String> preferences, List<String> riskFactors)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Assessment() when $default != null:
        return $default(
            _that.strengths, _that.needs, _that.preferences, _that.riskFactors);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Assessment implements Assessment {
  const _Assessment(
      {required final List<String> strengths,
      required final List<String> needs,
      required final List<String> preferences,
      required final List<String> riskFactors})
      : _strengths = strengths,
        _needs = needs,
        _preferences = preferences,
        _riskFactors = riskFactors;
  factory _Assessment.fromJson(Map<String, dynamic> json) =>
      _$AssessmentFromJson(json);

  final List<String> _strengths;
  @override
  List<String> get strengths {
    if (_strengths is EqualUnmodifiableListView) return _strengths;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_strengths);
  }

  final List<String> _needs;
  @override
  List<String> get needs {
    if (_needs is EqualUnmodifiableListView) return _needs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_needs);
  }

  final List<String> _preferences;
  @override
  List<String> get preferences {
    if (_preferences is EqualUnmodifiableListView) return _preferences;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_preferences);
  }

  final List<String> _riskFactors;
  @override
  List<String> get riskFactors {
    if (_riskFactors is EqualUnmodifiableListView) return _riskFactors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_riskFactors);
  }

  /// Create a copy of Assessment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AssessmentCopyWith<_Assessment> get copyWith =>
      __$AssessmentCopyWithImpl<_Assessment>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AssessmentToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Assessment &&
            const DeepCollectionEquality()
                .equals(other._strengths, _strengths) &&
            const DeepCollectionEquality().equals(other._needs, _needs) &&
            const DeepCollectionEquality()
                .equals(other._preferences, _preferences) &&
            const DeepCollectionEquality()
                .equals(other._riskFactors, _riskFactors));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_strengths),
      const DeepCollectionEquality().hash(_needs),
      const DeepCollectionEquality().hash(_preferences),
      const DeepCollectionEquality().hash(_riskFactors));

  @override
  String toString() {
    return 'Assessment(strengths: $strengths, needs: $needs, preferences: $preferences, riskFactors: $riskFactors)';
  }
}

/// @nodoc
abstract mixin class _$AssessmentCopyWith<$Res>
    implements $AssessmentCopyWith<$Res> {
  factory _$AssessmentCopyWith(
          _Assessment value, $Res Function(_Assessment) _then) =
      __$AssessmentCopyWithImpl;
  @override
  @useResult
  $Res call(
      {List<String> strengths,
      List<String> needs,
      List<String> preferences,
      List<String> riskFactors});
}

/// @nodoc
class __$AssessmentCopyWithImpl<$Res> implements _$AssessmentCopyWith<$Res> {
  __$AssessmentCopyWithImpl(this._self, this._then);

  final _Assessment _self;
  final $Res Function(_Assessment) _then;

  /// Create a copy of Assessment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? strengths = null,
    Object? needs = null,
    Object? preferences = null,
    Object? riskFactors = null,
  }) {
    return _then(_Assessment(
      strengths: null == strengths
          ? _self._strengths
          : strengths // ignore: cast_nullable_to_non_nullable
              as List<String>,
      needs: null == needs
          ? _self._needs
          : needs // ignore: cast_nullable_to_non_nullable
              as List<String>,
      preferences: null == preferences
          ? _self._preferences
          : preferences // ignore: cast_nullable_to_non_nullable
              as List<String>,
      riskFactors: null == riskFactors
          ? _self._riskFactors
          : riskFactors // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
mixin _$SmartGoal {
  String get goalId;
  String get outcomeArea;
  String get goal;
  String get specific;
  String get measurable;
  String get achievable;
  String get relevant;
  String get timeBound;
  String get priority;
  String get status;
  int get progress;
  List<Milestone> get milestones;

  /// Create a copy of SmartGoal
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SmartGoalCopyWith<SmartGoal> get copyWith =>
      _$SmartGoalCopyWithImpl<SmartGoal>(this as SmartGoal, _$identity);

  /// Serializes this SmartGoal to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SmartGoal &&
            (identical(other.goalId, goalId) || other.goalId == goalId) &&
            (identical(other.outcomeArea, outcomeArea) ||
                other.outcomeArea == outcomeArea) &&
            (identical(other.goal, goal) || other.goal == goal) &&
            (identical(other.specific, specific) ||
                other.specific == specific) &&
            (identical(other.measurable, measurable) ||
                other.measurable == measurable) &&
            (identical(other.achievable, achievable) ||
                other.achievable == achievable) &&
            (identical(other.relevant, relevant) ||
                other.relevant == relevant) &&
            (identical(other.timeBound, timeBound) ||
                other.timeBound == timeBound) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.progress, progress) ||
                other.progress == progress) &&
            const DeepCollectionEquality()
                .equals(other.milestones, milestones));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      goalId,
      outcomeArea,
      goal,
      specific,
      measurable,
      achievable,
      relevant,
      timeBound,
      priority,
      status,
      progress,
      const DeepCollectionEquality().hash(milestones));

  @override
  String toString() {
    return 'SmartGoal(goalId: $goalId, outcomeArea: $outcomeArea, goal: $goal, specific: $specific, measurable: $measurable, achievable: $achievable, relevant: $relevant, timeBound: $timeBound, priority: $priority, status: $status, progress: $progress, milestones: $milestones)';
  }
}

/// @nodoc
abstract mixin class $SmartGoalCopyWith<$Res> {
  factory $SmartGoalCopyWith(SmartGoal value, $Res Function(SmartGoal) _then) =
      _$SmartGoalCopyWithImpl;
  @useResult
  $Res call(
      {String goalId,
      String outcomeArea,
      String goal,
      String specific,
      String measurable,
      String achievable,
      String relevant,
      String timeBound,
      String priority,
      String status,
      int progress,
      List<Milestone> milestones});
}

/// @nodoc
class _$SmartGoalCopyWithImpl<$Res> implements $SmartGoalCopyWith<$Res> {
  _$SmartGoalCopyWithImpl(this._self, this._then);

  final SmartGoal _self;
  final $Res Function(SmartGoal) _then;

  /// Create a copy of SmartGoal
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? goalId = null,
    Object? outcomeArea = null,
    Object? goal = null,
    Object? specific = null,
    Object? measurable = null,
    Object? achievable = null,
    Object? relevant = null,
    Object? timeBound = null,
    Object? priority = null,
    Object? status = null,
    Object? progress = null,
    Object? milestones = null,
  }) {
    return _then(_self.copyWith(
      goalId: null == goalId
          ? _self.goalId
          : goalId // ignore: cast_nullable_to_non_nullable
              as String,
      outcomeArea: null == outcomeArea
          ? _self.outcomeArea
          : outcomeArea // ignore: cast_nullable_to_non_nullable
              as String,
      goal: null == goal
          ? _self.goal
          : goal // ignore: cast_nullable_to_non_nullable
              as String,
      specific: null == specific
          ? _self.specific
          : specific // ignore: cast_nullable_to_non_nullable
              as String,
      measurable: null == measurable
          ? _self.measurable
          : measurable // ignore: cast_nullable_to_non_nullable
              as String,
      achievable: null == achievable
          ? _self.achievable
          : achievable // ignore: cast_nullable_to_non_nullable
              as String,
      relevant: null == relevant
          ? _self.relevant
          : relevant // ignore: cast_nullable_to_non_nullable
              as String,
      timeBound: null == timeBound
          ? _self.timeBound
          : timeBound // ignore: cast_nullable_to_non_nullable
              as String,
      priority: null == priority
          ? _self.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      progress: null == progress
          ? _self.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as int,
      milestones: null == milestones
          ? _self.milestones
          : milestones // ignore: cast_nullable_to_non_nullable
              as List<Milestone>,
    ));
  }
}

/// Adds pattern-matching-related methods to [SmartGoal].
extension SmartGoalPatterns on SmartGoal {
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
    TResult Function(_SmartGoal value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SmartGoal() when $default != null:
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
    TResult Function(_SmartGoal value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SmartGoal():
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
    TResult? Function(_SmartGoal value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SmartGoal() when $default != null:
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
            String goalId,
            String outcomeArea,
            String goal,
            String specific,
            String measurable,
            String achievable,
            String relevant,
            String timeBound,
            String priority,
            String status,
            int progress,
            List<Milestone> milestones)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SmartGoal() when $default != null:
        return $default(
            _that.goalId,
            _that.outcomeArea,
            _that.goal,
            _that.specific,
            _that.measurable,
            _that.achievable,
            _that.relevant,
            _that.timeBound,
            _that.priority,
            _that.status,
            _that.progress,
            _that.milestones);
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
            String goalId,
            String outcomeArea,
            String goal,
            String specific,
            String measurable,
            String achievable,
            String relevant,
            String timeBound,
            String priority,
            String status,
            int progress,
            List<Milestone> milestones)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SmartGoal():
        return $default(
            _that.goalId,
            _that.outcomeArea,
            _that.goal,
            _that.specific,
            _that.measurable,
            _that.achievable,
            _that.relevant,
            _that.timeBound,
            _that.priority,
            _that.status,
            _that.progress,
            _that.milestones);
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
            String goalId,
            String outcomeArea,
            String goal,
            String specific,
            String measurable,
            String achievable,
            String relevant,
            String timeBound,
            String priority,
            String status,
            int progress,
            List<Milestone> milestones)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SmartGoal() when $default != null:
        return $default(
            _that.goalId,
            _that.outcomeArea,
            _that.goal,
            _that.specific,
            _that.measurable,
            _that.achievable,
            _that.relevant,
            _that.timeBound,
            _that.priority,
            _that.status,
            _that.progress,
            _that.milestones);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _SmartGoal implements SmartGoal {
  const _SmartGoal(
      {required this.goalId,
      required this.outcomeArea,
      required this.goal,
      required this.specific,
      required this.measurable,
      required this.achievable,
      required this.relevant,
      required this.timeBound,
      required this.priority,
      required this.status,
      required this.progress,
      required final List<Milestone> milestones})
      : _milestones = milestones;
  factory _SmartGoal.fromJson(Map<String, dynamic> json) =>
      _$SmartGoalFromJson(json);

  @override
  final String goalId;
  @override
  final String outcomeArea;
  @override
  final String goal;
  @override
  final String specific;
  @override
  final String measurable;
  @override
  final String achievable;
  @override
  final String relevant;
  @override
  final String timeBound;
  @override
  final String priority;
  @override
  final String status;
  @override
  final int progress;
  final List<Milestone> _milestones;
  @override
  List<Milestone> get milestones {
    if (_milestones is EqualUnmodifiableListView) return _milestones;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_milestones);
  }

  /// Create a copy of SmartGoal
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SmartGoalCopyWith<_SmartGoal> get copyWith =>
      __$SmartGoalCopyWithImpl<_SmartGoal>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SmartGoalToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SmartGoal &&
            (identical(other.goalId, goalId) || other.goalId == goalId) &&
            (identical(other.outcomeArea, outcomeArea) ||
                other.outcomeArea == outcomeArea) &&
            (identical(other.goal, goal) || other.goal == goal) &&
            (identical(other.specific, specific) ||
                other.specific == specific) &&
            (identical(other.measurable, measurable) ||
                other.measurable == measurable) &&
            (identical(other.achievable, achievable) ||
                other.achievable == achievable) &&
            (identical(other.relevant, relevant) ||
                other.relevant == relevant) &&
            (identical(other.timeBound, timeBound) ||
                other.timeBound == timeBound) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.progress, progress) ||
                other.progress == progress) &&
            const DeepCollectionEquality()
                .equals(other._milestones, _milestones));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      goalId,
      outcomeArea,
      goal,
      specific,
      measurable,
      achievable,
      relevant,
      timeBound,
      priority,
      status,
      progress,
      const DeepCollectionEquality().hash(_milestones));

  @override
  String toString() {
    return 'SmartGoal(goalId: $goalId, outcomeArea: $outcomeArea, goal: $goal, specific: $specific, measurable: $measurable, achievable: $achievable, relevant: $relevant, timeBound: $timeBound, priority: $priority, status: $status, progress: $progress, milestones: $milestones)';
  }
}

/// @nodoc
abstract mixin class _$SmartGoalCopyWith<$Res>
    implements $SmartGoalCopyWith<$Res> {
  factory _$SmartGoalCopyWith(
          _SmartGoal value, $Res Function(_SmartGoal) _then) =
      __$SmartGoalCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String goalId,
      String outcomeArea,
      String goal,
      String specific,
      String measurable,
      String achievable,
      String relevant,
      String timeBound,
      String priority,
      String status,
      int progress,
      List<Milestone> milestones});
}

/// @nodoc
class __$SmartGoalCopyWithImpl<$Res> implements _$SmartGoalCopyWith<$Res> {
  __$SmartGoalCopyWithImpl(this._self, this._then);

  final _SmartGoal _self;
  final $Res Function(_SmartGoal) _then;

  /// Create a copy of SmartGoal
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? goalId = null,
    Object? outcomeArea = null,
    Object? goal = null,
    Object? specific = null,
    Object? measurable = null,
    Object? achievable = null,
    Object? relevant = null,
    Object? timeBound = null,
    Object? priority = null,
    Object? status = null,
    Object? progress = null,
    Object? milestones = null,
  }) {
    return _then(_SmartGoal(
      goalId: null == goalId
          ? _self.goalId
          : goalId // ignore: cast_nullable_to_non_nullable
              as String,
      outcomeArea: null == outcomeArea
          ? _self.outcomeArea
          : outcomeArea // ignore: cast_nullable_to_non_nullable
              as String,
      goal: null == goal
          ? _self.goal
          : goal // ignore: cast_nullable_to_non_nullable
              as String,
      specific: null == specific
          ? _self.specific
          : specific // ignore: cast_nullable_to_non_nullable
              as String,
      measurable: null == measurable
          ? _self.measurable
          : measurable // ignore: cast_nullable_to_non_nullable
              as String,
      achievable: null == achievable
          ? _self.achievable
          : achievable // ignore: cast_nullable_to_non_nullable
              as String,
      relevant: null == relevant
          ? _self.relevant
          : relevant // ignore: cast_nullable_to_non_nullable
              as String,
      timeBound: null == timeBound
          ? _self.timeBound
          : timeBound // ignore: cast_nullable_to_non_nullable
              as String,
      priority: null == priority
          ? _self.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      progress: null == progress
          ? _self.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as int,
      milestones: null == milestones
          ? _self._milestones
          : milestones // ignore: cast_nullable_to_non_nullable
              as List<Milestone>,
    ));
  }
}

/// @nodoc
mixin _$Milestone {
  String get milestone;
  String get target;
  String get date;

  /// Create a copy of Milestone
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MilestoneCopyWith<Milestone> get copyWith =>
      _$MilestoneCopyWithImpl<Milestone>(this as Milestone, _$identity);

  /// Serializes this Milestone to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Milestone &&
            (identical(other.milestone, milestone) ||
                other.milestone == milestone) &&
            (identical(other.target, target) || other.target == target) &&
            (identical(other.date, date) || other.date == date));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, milestone, target, date);

  @override
  String toString() {
    return 'Milestone(milestone: $milestone, target: $target, date: $date)';
  }
}

/// @nodoc
abstract mixin class $MilestoneCopyWith<$Res> {
  factory $MilestoneCopyWith(Milestone value, $Res Function(Milestone) _then) =
      _$MilestoneCopyWithImpl;
  @useResult
  $Res call({String milestone, String target, String date});
}

/// @nodoc
class _$MilestoneCopyWithImpl<$Res> implements $MilestoneCopyWith<$Res> {
  _$MilestoneCopyWithImpl(this._self, this._then);

  final Milestone _self;
  final $Res Function(Milestone) _then;

  /// Create a copy of Milestone
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? milestone = null,
    Object? target = null,
    Object? date = null,
  }) {
    return _then(_self.copyWith(
      milestone: null == milestone
          ? _self.milestone
          : milestone // ignore: cast_nullable_to_non_nullable
              as String,
      target: null == target
          ? _self.target
          : target // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [Milestone].
extension MilestonePatterns on Milestone {
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
    TResult Function(_Milestone value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Milestone() when $default != null:
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
    TResult Function(_Milestone value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Milestone():
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
    TResult? Function(_Milestone value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Milestone() when $default != null:
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
    TResult Function(String milestone, String target, String date)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Milestone() when $default != null:
        return $default(_that.milestone, _that.target, _that.date);
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
    TResult Function(String milestone, String target, String date) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Milestone():
        return $default(_that.milestone, _that.target, _that.date);
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
    TResult? Function(String milestone, String target, String date)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Milestone() when $default != null:
        return $default(_that.milestone, _that.target, _that.date);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Milestone implements Milestone {
  const _Milestone(
      {required this.milestone, required this.target, required this.date});
  factory _Milestone.fromJson(Map<String, dynamic> json) =>
      _$MilestoneFromJson(json);

  @override
  final String milestone;
  @override
  final String target;
  @override
  final String date;

  /// Create a copy of Milestone
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MilestoneCopyWith<_Milestone> get copyWith =>
      __$MilestoneCopyWithImpl<_Milestone>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$MilestoneToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Milestone &&
            (identical(other.milestone, milestone) ||
                other.milestone == milestone) &&
            (identical(other.target, target) || other.target == target) &&
            (identical(other.date, date) || other.date == date));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, milestone, target, date);

  @override
  String toString() {
    return 'Milestone(milestone: $milestone, target: $target, date: $date)';
  }
}

/// @nodoc
abstract mixin class _$MilestoneCopyWith<$Res>
    implements $MilestoneCopyWith<$Res> {
  factory _$MilestoneCopyWith(
          _Milestone value, $Res Function(_Milestone) _then) =
      __$MilestoneCopyWithImpl;
  @override
  @useResult
  $Res call({String milestone, String target, String date});
}

/// @nodoc
class __$MilestoneCopyWithImpl<$Res> implements _$MilestoneCopyWith<$Res> {
  __$MilestoneCopyWithImpl(this._self, this._then);

  final _Milestone _self;
  final $Res Function(_Milestone) _then;

  /// Create a copy of Milestone
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? milestone = null,
    Object? target = null,
    Object? date = null,
  }) {
    return _then(_Milestone(
      milestone: null == milestone
          ? _self.milestone
          : milestone // ignore: cast_nullable_to_non_nullable
              as String,
      target: null == target
          ? _self.target
          : target // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$ServiceRecommendation {
  String get serviceType;
  String get frequency;
  String get duration;
  String get priority;
  String get rationale;
  int get estimatedCost;
  List<Provider> get providers;

  /// Create a copy of ServiceRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ServiceRecommendationCopyWith<ServiceRecommendation> get copyWith =>
      _$ServiceRecommendationCopyWithImpl<ServiceRecommendation>(
          this as ServiceRecommendation, _$identity);

  /// Serializes this ServiceRecommendation to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ServiceRecommendation &&
            (identical(other.serviceType, serviceType) ||
                other.serviceType == serviceType) &&
            (identical(other.frequency, frequency) ||
                other.frequency == frequency) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.rationale, rationale) ||
                other.rationale == rationale) &&
            (identical(other.estimatedCost, estimatedCost) ||
                other.estimatedCost == estimatedCost) &&
            const DeepCollectionEquality().equals(other.providers, providers));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      serviceType,
      frequency,
      duration,
      priority,
      rationale,
      estimatedCost,
      const DeepCollectionEquality().hash(providers));

  @override
  String toString() {
    return 'ServiceRecommendation(serviceType: $serviceType, frequency: $frequency, duration: $duration, priority: $priority, rationale: $rationale, estimatedCost: $estimatedCost, providers: $providers)';
  }
}

/// @nodoc
abstract mixin class $ServiceRecommendationCopyWith<$Res> {
  factory $ServiceRecommendationCopyWith(ServiceRecommendation value,
          $Res Function(ServiceRecommendation) _then) =
      _$ServiceRecommendationCopyWithImpl;
  @useResult
  $Res call(
      {String serviceType,
      String frequency,
      String duration,
      String priority,
      String rationale,
      int estimatedCost,
      List<Provider> providers});
}

/// @nodoc
class _$ServiceRecommendationCopyWithImpl<$Res>
    implements $ServiceRecommendationCopyWith<$Res> {
  _$ServiceRecommendationCopyWithImpl(this._self, this._then);

  final ServiceRecommendation _self;
  final $Res Function(ServiceRecommendation) _then;

  /// Create a copy of ServiceRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? serviceType = null,
    Object? frequency = null,
    Object? duration = null,
    Object? priority = null,
    Object? rationale = null,
    Object? estimatedCost = null,
    Object? providers = null,
  }) {
    return _then(_self.copyWith(
      serviceType: null == serviceType
          ? _self.serviceType
          : serviceType // ignore: cast_nullable_to_non_nullable
              as String,
      frequency: null == frequency
          ? _self.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as String,
      duration: null == duration
          ? _self.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as String,
      priority: null == priority
          ? _self.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as String,
      rationale: null == rationale
          ? _self.rationale
          : rationale // ignore: cast_nullable_to_non_nullable
              as String,
      estimatedCost: null == estimatedCost
          ? _self.estimatedCost
          : estimatedCost // ignore: cast_nullable_to_non_nullable
              as int,
      providers: null == providers
          ? _self.providers
          : providers // ignore: cast_nullable_to_non_nullable
              as List<Provider>,
    ));
  }
}

/// Adds pattern-matching-related methods to [ServiceRecommendation].
extension ServiceRecommendationPatterns on ServiceRecommendation {
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
    TResult Function(_ServiceRecommendation value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ServiceRecommendation() when $default != null:
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
    TResult Function(_ServiceRecommendation value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ServiceRecommendation():
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
    TResult? Function(_ServiceRecommendation value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ServiceRecommendation() when $default != null:
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
            String serviceType,
            String frequency,
            String duration,
            String priority,
            String rationale,
            int estimatedCost,
            List<Provider> providers)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ServiceRecommendation() when $default != null:
        return $default(
            _that.serviceType,
            _that.frequency,
            _that.duration,
            _that.priority,
            _that.rationale,
            _that.estimatedCost,
            _that.providers);
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
            String serviceType,
            String frequency,
            String duration,
            String priority,
            String rationale,
            int estimatedCost,
            List<Provider> providers)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ServiceRecommendation():
        return $default(
            _that.serviceType,
            _that.frequency,
            _that.duration,
            _that.priority,
            _that.rationale,
            _that.estimatedCost,
            _that.providers);
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
            String serviceType,
            String frequency,
            String duration,
            String priority,
            String rationale,
            int estimatedCost,
            List<Provider> providers)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ServiceRecommendation() when $default != null:
        return $default(
            _that.serviceType,
            _that.frequency,
            _that.duration,
            _that.priority,
            _that.rationale,
            _that.estimatedCost,
            _that.providers);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ServiceRecommendation implements ServiceRecommendation {
  const _ServiceRecommendation(
      {required this.serviceType,
      required this.frequency,
      required this.duration,
      required this.priority,
      required this.rationale,
      required this.estimatedCost,
      required final List<Provider> providers})
      : _providers = providers;
  factory _ServiceRecommendation.fromJson(Map<String, dynamic> json) =>
      _$ServiceRecommendationFromJson(json);

  @override
  final String serviceType;
  @override
  final String frequency;
  @override
  final String duration;
  @override
  final String priority;
  @override
  final String rationale;
  @override
  final int estimatedCost;
  final List<Provider> _providers;
  @override
  List<Provider> get providers {
    if (_providers is EqualUnmodifiableListView) return _providers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_providers);
  }

  /// Create a copy of ServiceRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ServiceRecommendationCopyWith<_ServiceRecommendation> get copyWith =>
      __$ServiceRecommendationCopyWithImpl<_ServiceRecommendation>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ServiceRecommendationToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ServiceRecommendation &&
            (identical(other.serviceType, serviceType) ||
                other.serviceType == serviceType) &&
            (identical(other.frequency, frequency) ||
                other.frequency == frequency) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.rationale, rationale) ||
                other.rationale == rationale) &&
            (identical(other.estimatedCost, estimatedCost) ||
                other.estimatedCost == estimatedCost) &&
            const DeepCollectionEquality()
                .equals(other._providers, _providers));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      serviceType,
      frequency,
      duration,
      priority,
      rationale,
      estimatedCost,
      const DeepCollectionEquality().hash(_providers));

  @override
  String toString() {
    return 'ServiceRecommendation(serviceType: $serviceType, frequency: $frequency, duration: $duration, priority: $priority, rationale: $rationale, estimatedCost: $estimatedCost, providers: $providers)';
  }
}

/// @nodoc
abstract mixin class _$ServiceRecommendationCopyWith<$Res>
    implements $ServiceRecommendationCopyWith<$Res> {
  factory _$ServiceRecommendationCopyWith(_ServiceRecommendation value,
          $Res Function(_ServiceRecommendation) _then) =
      __$ServiceRecommendationCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String serviceType,
      String frequency,
      String duration,
      String priority,
      String rationale,
      int estimatedCost,
      List<Provider> providers});
}

/// @nodoc
class __$ServiceRecommendationCopyWithImpl<$Res>
    implements _$ServiceRecommendationCopyWith<$Res> {
  __$ServiceRecommendationCopyWithImpl(this._self, this._then);

  final _ServiceRecommendation _self;
  final $Res Function(_ServiceRecommendation) _then;

  /// Create a copy of ServiceRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? serviceType = null,
    Object? frequency = null,
    Object? duration = null,
    Object? priority = null,
    Object? rationale = null,
    Object? estimatedCost = null,
    Object? providers = null,
  }) {
    return _then(_ServiceRecommendation(
      serviceType: null == serviceType
          ? _self.serviceType
          : serviceType // ignore: cast_nullable_to_non_nullable
              as String,
      frequency: null == frequency
          ? _self.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as String,
      duration: null == duration
          ? _self.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as String,
      priority: null == priority
          ? _self.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as String,
      rationale: null == rationale
          ? _self.rationale
          : rationale // ignore: cast_nullable_to_non_nullable
              as String,
      estimatedCost: null == estimatedCost
          ? _self.estimatedCost
          : estimatedCost // ignore: cast_nullable_to_non_nullable
              as int,
      providers: null == providers
          ? _self._providers
          : providers // ignore: cast_nullable_to_non_nullable
              as List<Provider>,
    ));
  }
}

/// @nodoc
mixin _$Provider {
  String get name;
  double get rating;
  String get availability;

  /// Create a copy of Provider
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ProviderCopyWith<Provider> get copyWith =>
      _$ProviderCopyWithImpl<Provider>(this as Provider, _$identity);

  /// Serializes this Provider to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Provider &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.availability, availability) ||
                other.availability == availability));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, rating, availability);

  @override
  String toString() {
    return 'Provider(name: $name, rating: $rating, availability: $availability)';
  }
}

/// @nodoc
abstract mixin class $ProviderCopyWith<$Res> {
  factory $ProviderCopyWith(Provider value, $Res Function(Provider) _then) =
      _$ProviderCopyWithImpl;
  @useResult
  $Res call({String name, double rating, String availability});
}

/// @nodoc
class _$ProviderCopyWithImpl<$Res> implements $ProviderCopyWith<$Res> {
  _$ProviderCopyWithImpl(this._self, this._then);

  final Provider _self;
  final $Res Function(Provider) _then;

  /// Create a copy of Provider
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? rating = null,
    Object? availability = null,
  }) {
    return _then(_self.copyWith(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      rating: null == rating
          ? _self.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
      availability: null == availability
          ? _self.availability
          : availability // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [Provider].
extension ProviderPatterns on Provider {
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
    TResult Function(_Provider value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Provider() when $default != null:
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
    TResult Function(_Provider value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Provider():
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
    TResult? Function(_Provider value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Provider() when $default != null:
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
    TResult Function(String name, double rating, String availability)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Provider() when $default != null:
        return $default(_that.name, _that.rating, _that.availability);
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
    TResult Function(String name, double rating, String availability) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Provider():
        return $default(_that.name, _that.rating, _that.availability);
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
    TResult? Function(String name, double rating, String availability)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Provider() when $default != null:
        return $default(_that.name, _that.rating, _that.availability);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Provider implements Provider {
  const _Provider(
      {required this.name, required this.rating, required this.availability});
  factory _Provider.fromJson(Map<String, dynamic> json) =>
      _$ProviderFromJson(json);

  @override
  final String name;
  @override
  final double rating;
  @override
  final String availability;

  /// Create a copy of Provider
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ProviderCopyWith<_Provider> get copyWith =>
      __$ProviderCopyWithImpl<_Provider>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ProviderToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Provider &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.availability, availability) ||
                other.availability == availability));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, rating, availability);

  @override
  String toString() {
    return 'Provider(name: $name, rating: $rating, availability: $availability)';
  }
}

/// @nodoc
abstract mixin class _$ProviderCopyWith<$Res>
    implements $ProviderCopyWith<$Res> {
  factory _$ProviderCopyWith(_Provider value, $Res Function(_Provider) _then) =
      __$ProviderCopyWithImpl;
  @override
  @useResult
  $Res call({String name, double rating, String availability});
}

/// @nodoc
class __$ProviderCopyWithImpl<$Res> implements _$ProviderCopyWith<$Res> {
  __$ProviderCopyWithImpl(this._self, this._then);

  final _Provider _self;
  final $Res Function(_Provider) _then;

  /// Create a copy of Provider
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = null,
    Object? rating = null,
    Object? availability = null,
  }) {
    return _then(_Provider(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      rating: null == rating
          ? _self.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
      availability: null == availability
          ? _self.availability
          : availability // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$Resources {
  int get workers;
  List<String> get equipment;
  Budget get budget;

  /// Create a copy of Resources
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ResourcesCopyWith<Resources> get copyWith =>
      _$ResourcesCopyWithImpl<Resources>(this as Resources, _$identity);

  /// Serializes this Resources to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Resources &&
            (identical(other.workers, workers) || other.workers == workers) &&
            const DeepCollectionEquality().equals(other.equipment, equipment) &&
            (identical(other.budget, budget) || other.budget == budget));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, workers,
      const DeepCollectionEquality().hash(equipment), budget);

  @override
  String toString() {
    return 'Resources(workers: $workers, equipment: $equipment, budget: $budget)';
  }
}

/// @nodoc
abstract mixin class $ResourcesCopyWith<$Res> {
  factory $ResourcesCopyWith(Resources value, $Res Function(Resources) _then) =
      _$ResourcesCopyWithImpl;
  @useResult
  $Res call({int workers, List<String> equipment, Budget budget});

  $BudgetCopyWith<$Res> get budget;
}

/// @nodoc
class _$ResourcesCopyWithImpl<$Res> implements $ResourcesCopyWith<$Res> {
  _$ResourcesCopyWithImpl(this._self, this._then);

  final Resources _self;
  final $Res Function(Resources) _then;

  /// Create a copy of Resources
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? workers = null,
    Object? equipment = null,
    Object? budget = null,
  }) {
    return _then(_self.copyWith(
      workers: null == workers
          ? _self.workers
          : workers // ignore: cast_nullable_to_non_nullable
              as int,
      equipment: null == equipment
          ? _self.equipment
          : equipment // ignore: cast_nullable_to_non_nullable
              as List<String>,
      budget: null == budget
          ? _self.budget
          : budget // ignore: cast_nullable_to_non_nullable
              as Budget,
    ));
  }

  /// Create a copy of Resources
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BudgetCopyWith<$Res> get budget {
    return $BudgetCopyWith<$Res>(_self.budget, (value) {
      return _then(_self.copyWith(budget: value));
    });
  }
}

/// Adds pattern-matching-related methods to [Resources].
extension ResourcesPatterns on Resources {
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
    TResult Function(_Resources value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Resources() when $default != null:
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
    TResult Function(_Resources value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Resources():
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
    TResult? Function(_Resources value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Resources() when $default != null:
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
    TResult Function(int workers, List<String> equipment, Budget budget)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Resources() when $default != null:
        return $default(_that.workers, _that.equipment, _that.budget);
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
    TResult Function(int workers, List<String> equipment, Budget budget)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Resources():
        return $default(_that.workers, _that.equipment, _that.budget);
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
    TResult? Function(int workers, List<String> equipment, Budget budget)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Resources() when $default != null:
        return $default(_that.workers, _that.equipment, _that.budget);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Resources implements Resources {
  const _Resources(
      {required this.workers,
      required final List<String> equipment,
      required this.budget})
      : _equipment = equipment;
  factory _Resources.fromJson(Map<String, dynamic> json) =>
      _$ResourcesFromJson(json);

  @override
  final int workers;
  final List<String> _equipment;
  @override
  List<String> get equipment {
    if (_equipment is EqualUnmodifiableListView) return _equipment;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_equipment);
  }

  @override
  final Budget budget;

  /// Create a copy of Resources
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ResourcesCopyWith<_Resources> get copyWith =>
      __$ResourcesCopyWithImpl<_Resources>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ResourcesToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Resources &&
            (identical(other.workers, workers) || other.workers == workers) &&
            const DeepCollectionEquality()
                .equals(other._equipment, _equipment) &&
            (identical(other.budget, budget) || other.budget == budget));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, workers,
      const DeepCollectionEquality().hash(_equipment), budget);

  @override
  String toString() {
    return 'Resources(workers: $workers, equipment: $equipment, budget: $budget)';
  }
}

/// @nodoc
abstract mixin class _$ResourcesCopyWith<$Res>
    implements $ResourcesCopyWith<$Res> {
  factory _$ResourcesCopyWith(
          _Resources value, $Res Function(_Resources) _then) =
      __$ResourcesCopyWithImpl;
  @override
  @useResult
  $Res call({int workers, List<String> equipment, Budget budget});

  @override
  $BudgetCopyWith<$Res> get budget;
}

/// @nodoc
class __$ResourcesCopyWithImpl<$Res> implements _$ResourcesCopyWith<$Res> {
  __$ResourcesCopyWithImpl(this._self, this._then);

  final _Resources _self;
  final $Res Function(_Resources) _then;

  /// Create a copy of Resources
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? workers = null,
    Object? equipment = null,
    Object? budget = null,
  }) {
    return _then(_Resources(
      workers: null == workers
          ? _self.workers
          : workers // ignore: cast_nullable_to_non_nullable
              as int,
      equipment: null == equipment
          ? _self._equipment
          : equipment // ignore: cast_nullable_to_non_nullable
              as List<String>,
      budget: null == budget
          ? _self.budget
          : budget // ignore: cast_nullable_to_non_nullable
              as Budget,
    ));
  }

  /// Create a copy of Resources
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BudgetCopyWith<$Res> get budget {
    return $BudgetCopyWith<$Res>(_self.budget, (value) {
      return _then(_self.copyWith(budget: value));
    });
  }
}

/// @nodoc
mixin _$Budget {
  int get weekly;
  int get monthly;

  /// Create a copy of Budget
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BudgetCopyWith<Budget> get copyWith =>
      _$BudgetCopyWithImpl<Budget>(this as Budget, _$identity);

  /// Serializes this Budget to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Budget &&
            (identical(other.weekly, weekly) || other.weekly == weekly) &&
            (identical(other.monthly, monthly) || other.monthly == monthly));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, weekly, monthly);

  @override
  String toString() {
    return 'Budget(weekly: $weekly, monthly: $monthly)';
  }
}

/// @nodoc
abstract mixin class $BudgetCopyWith<$Res> {
  factory $BudgetCopyWith(Budget value, $Res Function(Budget) _then) =
      _$BudgetCopyWithImpl;
  @useResult
  $Res call({int weekly, int monthly});
}

/// @nodoc
class _$BudgetCopyWithImpl<$Res> implements $BudgetCopyWith<$Res> {
  _$BudgetCopyWithImpl(this._self, this._then);

  final Budget _self;
  final $Res Function(Budget) _then;

  /// Create a copy of Budget
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? weekly = null,
    Object? monthly = null,
  }) {
    return _then(_self.copyWith(
      weekly: null == weekly
          ? _self.weekly
          : weekly // ignore: cast_nullable_to_non_nullable
              as int,
      monthly: null == monthly
          ? _self.monthly
          : monthly // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [Budget].
extension BudgetPatterns on Budget {
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
    TResult Function(_Budget value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Budget() when $default != null:
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
    TResult Function(_Budget value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Budget():
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
    TResult? Function(_Budget value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Budget() when $default != null:
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
    TResult Function(int weekly, int monthly)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Budget() when $default != null:
        return $default(_that.weekly, _that.monthly);
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
    TResult Function(int weekly, int monthly) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Budget():
        return $default(_that.weekly, _that.monthly);
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
    TResult? Function(int weekly, int monthly)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Budget() when $default != null:
        return $default(_that.weekly, _that.monthly);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Budget implements Budget {
  const _Budget({required this.weekly, required this.monthly});
  factory _Budget.fromJson(Map<String, dynamic> json) => _$BudgetFromJson(json);

  @override
  final int weekly;
  @override
  final int monthly;

  /// Create a copy of Budget
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BudgetCopyWith<_Budget> get copyWith =>
      __$BudgetCopyWithImpl<_Budget>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$BudgetToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Budget &&
            (identical(other.weekly, weekly) || other.weekly == weekly) &&
            (identical(other.monthly, monthly) || other.monthly == monthly));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, weekly, monthly);

  @override
  String toString() {
    return 'Budget(weekly: $weekly, monthly: $monthly)';
  }
}

/// @nodoc
abstract mixin class _$BudgetCopyWith<$Res> implements $BudgetCopyWith<$Res> {
  factory _$BudgetCopyWith(_Budget value, $Res Function(_Budget) _then) =
      __$BudgetCopyWithImpl;
  @override
  @useResult
  $Res call({int weekly, int monthly});
}

/// @nodoc
class __$BudgetCopyWithImpl<$Res> implements _$BudgetCopyWith<$Res> {
  __$BudgetCopyWithImpl(this._self, this._then);

  final _Budget _self;
  final $Res Function(_Budget) _then;

  /// Create a copy of Budget
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? weekly = null,
    Object? monthly = null,
  }) {
    return _then(_Budget(
      weekly: null == weekly
          ? _self.weekly
          : weekly // ignore: cast_nullable_to_non_nullable
              as int,
      monthly: null == monthly
          ? _self.monthly
          : monthly // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$Timeline {
  String get startDate;
  String get endDate;
  List<Phase> get phases;

  /// Create a copy of Timeline
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TimelineCopyWith<Timeline> get copyWith =>
      _$TimelineCopyWithImpl<Timeline>(this as Timeline, _$identity);

  /// Serializes this Timeline to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Timeline &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            const DeepCollectionEquality().equals(other.phases, phases));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, startDate, endDate,
      const DeepCollectionEquality().hash(phases));

  @override
  String toString() {
    return 'Timeline(startDate: $startDate, endDate: $endDate, phases: $phases)';
  }
}

/// @nodoc
abstract mixin class $TimelineCopyWith<$Res> {
  factory $TimelineCopyWith(Timeline value, $Res Function(Timeline) _then) =
      _$TimelineCopyWithImpl;
  @useResult
  $Res call({String startDate, String endDate, List<Phase> phases});
}

/// @nodoc
class _$TimelineCopyWithImpl<$Res> implements $TimelineCopyWith<$Res> {
  _$TimelineCopyWithImpl(this._self, this._then);

  final Timeline _self;
  final $Res Function(Timeline) _then;

  /// Create a copy of Timeline
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startDate = null,
    Object? endDate = null,
    Object? phases = null,
  }) {
    return _then(_self.copyWith(
      startDate: null == startDate
          ? _self.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as String,
      endDate: null == endDate
          ? _self.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as String,
      phases: null == phases
          ? _self.phases
          : phases // ignore: cast_nullable_to_non_nullable
              as List<Phase>,
    ));
  }
}

/// Adds pattern-matching-related methods to [Timeline].
extension TimelinePatterns on Timeline {
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
    TResult Function(_Timeline value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Timeline() when $default != null:
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
    TResult Function(_Timeline value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Timeline():
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
    TResult? Function(_Timeline value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Timeline() when $default != null:
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
    TResult Function(String startDate, String endDate, List<Phase> phases)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Timeline() when $default != null:
        return $default(_that.startDate, _that.endDate, _that.phases);
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
    TResult Function(String startDate, String endDate, List<Phase> phases)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Timeline():
        return $default(_that.startDate, _that.endDate, _that.phases);
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
    TResult? Function(String startDate, String endDate, List<Phase> phases)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Timeline() when $default != null:
        return $default(_that.startDate, _that.endDate, _that.phases);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Timeline implements Timeline {
  const _Timeline(
      {required this.startDate,
      required this.endDate,
      required final List<Phase> phases})
      : _phases = phases;
  factory _Timeline.fromJson(Map<String, dynamic> json) =>
      _$TimelineFromJson(json);

  @override
  final String startDate;
  @override
  final String endDate;
  final List<Phase> _phases;
  @override
  List<Phase> get phases {
    if (_phases is EqualUnmodifiableListView) return _phases;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_phases);
  }

  /// Create a copy of Timeline
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TimelineCopyWith<_Timeline> get copyWith =>
      __$TimelineCopyWithImpl<_Timeline>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TimelineToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Timeline &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            const DeepCollectionEquality().equals(other._phases, _phases));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, startDate, endDate,
      const DeepCollectionEquality().hash(_phases));

  @override
  String toString() {
    return 'Timeline(startDate: $startDate, endDate: $endDate, phases: $phases)';
  }
}

/// @nodoc
abstract mixin class _$TimelineCopyWith<$Res>
    implements $TimelineCopyWith<$Res> {
  factory _$TimelineCopyWith(_Timeline value, $Res Function(_Timeline) _then) =
      __$TimelineCopyWithImpl;
  @override
  @useResult
  $Res call({String startDate, String endDate, List<Phase> phases});
}

/// @nodoc
class __$TimelineCopyWithImpl<$Res> implements _$TimelineCopyWith<$Res> {
  __$TimelineCopyWithImpl(this._self, this._then);

  final _Timeline _self;
  final $Res Function(_Timeline) _then;

  /// Create a copy of Timeline
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? startDate = null,
    Object? endDate = null,
    Object? phases = null,
  }) {
    return _then(_Timeline(
      startDate: null == startDate
          ? _self.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as String,
      endDate: null == endDate
          ? _self.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as String,
      phases: null == phases
          ? _self._phases
          : phases // ignore: cast_nullable_to_non_nullable
              as List<Phase>,
    ));
  }
}

/// @nodoc
mixin _$Phase {
  String get phase;
  String get duration;
  String get focus;

  /// Create a copy of Phase
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PhaseCopyWith<Phase> get copyWith =>
      _$PhaseCopyWithImpl<Phase>(this as Phase, _$identity);

  /// Serializes this Phase to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Phase &&
            (identical(other.phase, phase) || other.phase == phase) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.focus, focus) || other.focus == focus));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, phase, duration, focus);

  @override
  String toString() {
    return 'Phase(phase: $phase, duration: $duration, focus: $focus)';
  }
}

/// @nodoc
abstract mixin class $PhaseCopyWith<$Res> {
  factory $PhaseCopyWith(Phase value, $Res Function(Phase) _then) =
      _$PhaseCopyWithImpl;
  @useResult
  $Res call({String phase, String duration, String focus});
}

/// @nodoc
class _$PhaseCopyWithImpl<$Res> implements $PhaseCopyWith<$Res> {
  _$PhaseCopyWithImpl(this._self, this._then);

  final Phase _self;
  final $Res Function(Phase) _then;

  /// Create a copy of Phase
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phase = null,
    Object? duration = null,
    Object? focus = null,
  }) {
    return _then(_self.copyWith(
      phase: null == phase
          ? _self.phase
          : phase // ignore: cast_nullable_to_non_nullable
              as String,
      duration: null == duration
          ? _self.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as String,
      focus: null == focus
          ? _self.focus
          : focus // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [Phase].
extension PhasePatterns on Phase {
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
    TResult Function(_Phase value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Phase() when $default != null:
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
    TResult Function(_Phase value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Phase():
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
    TResult? Function(_Phase value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Phase() when $default != null:
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
    TResult Function(String phase, String duration, String focus)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Phase() when $default != null:
        return $default(_that.phase, _that.duration, _that.focus);
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
    TResult Function(String phase, String duration, String focus) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Phase():
        return $default(_that.phase, _that.duration, _that.focus);
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
    TResult? Function(String phase, String duration, String focus)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Phase() when $default != null:
        return $default(_that.phase, _that.duration, _that.focus);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Phase implements Phase {
  const _Phase(
      {required this.phase, required this.duration, required this.focus});
  factory _Phase.fromJson(Map<String, dynamic> json) => _$PhaseFromJson(json);

  @override
  final String phase;
  @override
  final String duration;
  @override
  final String focus;

  /// Create a copy of Phase
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PhaseCopyWith<_Phase> get copyWith =>
      __$PhaseCopyWithImpl<_Phase>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PhaseToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Phase &&
            (identical(other.phase, phase) || other.phase == phase) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.focus, focus) || other.focus == focus));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, phase, duration, focus);

  @override
  String toString() {
    return 'Phase(phase: $phase, duration: $duration, focus: $focus)';
  }
}

/// @nodoc
abstract mixin class _$PhaseCopyWith<$Res> implements $PhaseCopyWith<$Res> {
  factory _$PhaseCopyWith(_Phase value, $Res Function(_Phase) _then) =
      __$PhaseCopyWithImpl;
  @override
  @useResult
  $Res call({String phase, String duration, String focus});
}

/// @nodoc
class __$PhaseCopyWithImpl<$Res> implements _$PhaseCopyWith<$Res> {
  __$PhaseCopyWithImpl(this._self, this._then);

  final _Phase _self;
  final $Res Function(_Phase) _then;

  /// Create a copy of Phase
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? phase = null,
    Object? duration = null,
    Object? focus = null,
  }) {
    return _then(_Phase(
      phase: null == phase
          ? _self.phase
          : phase // ignore: cast_nullable_to_non_nullable
              as String,
      duration: null == duration
          ? _self.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as String,
      focus: null == focus
          ? _self.focus
          : focus // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$Review {
  String get type;
  String get date;

  /// Create a copy of Review
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ReviewCopyWith<Review> get copyWith =>
      _$ReviewCopyWithImpl<Review>(this as Review, _$identity);

  /// Serializes this Review to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Review &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.date, date) || other.date == date));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, type, date);

  @override
  String toString() {
    return 'Review(type: $type, date: $date)';
  }
}

/// @nodoc
abstract mixin class $ReviewCopyWith<$Res> {
  factory $ReviewCopyWith(Review value, $Res Function(Review) _then) =
      _$ReviewCopyWithImpl;
  @useResult
  $Res call({String type, String date});
}

/// @nodoc
class _$ReviewCopyWithImpl<$Res> implements $ReviewCopyWith<$Res> {
  _$ReviewCopyWithImpl(this._self, this._then);

  final Review _self;
  final $Res Function(Review) _then;

  /// Create a copy of Review
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? date = null,
  }) {
    return _then(_self.copyWith(
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [Review].
extension ReviewPatterns on Review {
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
    TResult Function(_Review value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Review() when $default != null:
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
    TResult Function(_Review value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Review():
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
    TResult? Function(_Review value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Review() when $default != null:
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
    TResult Function(String type, String date)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Review() when $default != null:
        return $default(_that.type, _that.date);
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
    TResult Function(String type, String date) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Review():
        return $default(_that.type, _that.date);
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
    TResult? Function(String type, String date)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Review() when $default != null:
        return $default(_that.type, _that.date);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Review implements Review {
  const _Review({required this.type, required this.date});
  factory _Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);

  @override
  final String type;
  @override
  final String date;

  /// Create a copy of Review
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ReviewCopyWith<_Review> get copyWith =>
      __$ReviewCopyWithImpl<_Review>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ReviewToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Review &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.date, date) || other.date == date));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, type, date);

  @override
  String toString() {
    return 'Review(type: $type, date: $date)';
  }
}

/// @nodoc
abstract mixin class _$ReviewCopyWith<$Res> implements $ReviewCopyWith<$Res> {
  factory _$ReviewCopyWith(_Review value, $Res Function(_Review) _then) =
      __$ReviewCopyWithImpl;
  @override
  @useResult
  $Res call({String type, String date});
}

/// @nodoc
class __$ReviewCopyWithImpl<$Res> implements _$ReviewCopyWith<$Res> {
  __$ReviewCopyWithImpl(this._self, this._then);

  final _Review _self;
  final $Res Function(_Review) _then;

  /// Create a copy of Review
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? type = null,
    Object? date = null,
  }) {
    return _then(_Review(
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$SuccessMetric {
  String get metric;
  String get target;

  /// Create a copy of SuccessMetric
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SuccessMetricCopyWith<SuccessMetric> get copyWith =>
      _$SuccessMetricCopyWithImpl<SuccessMetric>(
          this as SuccessMetric, _$identity);

  /// Serializes this SuccessMetric to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SuccessMetric &&
            (identical(other.metric, metric) || other.metric == metric) &&
            (identical(other.target, target) || other.target == target));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, metric, target);

  @override
  String toString() {
    return 'SuccessMetric(metric: $metric, target: $target)';
  }
}

/// @nodoc
abstract mixin class $SuccessMetricCopyWith<$Res> {
  factory $SuccessMetricCopyWith(
          SuccessMetric value, $Res Function(SuccessMetric) _then) =
      _$SuccessMetricCopyWithImpl;
  @useResult
  $Res call({String metric, String target});
}

/// @nodoc
class _$SuccessMetricCopyWithImpl<$Res>
    implements $SuccessMetricCopyWith<$Res> {
  _$SuccessMetricCopyWithImpl(this._self, this._then);

  final SuccessMetric _self;
  final $Res Function(SuccessMetric) _then;

  /// Create a copy of SuccessMetric
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? metric = null,
    Object? target = null,
  }) {
    return _then(_self.copyWith(
      metric: null == metric
          ? _self.metric
          : metric // ignore: cast_nullable_to_non_nullable
              as String,
      target: null == target
          ? _self.target
          : target // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [SuccessMetric].
extension SuccessMetricPatterns on SuccessMetric {
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
    TResult Function(_SuccessMetric value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SuccessMetric() when $default != null:
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
    TResult Function(_SuccessMetric value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SuccessMetric():
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
    TResult? Function(_SuccessMetric value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SuccessMetric() when $default != null:
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
    TResult Function(String metric, String target)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SuccessMetric() when $default != null:
        return $default(_that.metric, _that.target);
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
    TResult Function(String metric, String target) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SuccessMetric():
        return $default(_that.metric, _that.target);
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
    TResult? Function(String metric, String target)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SuccessMetric() when $default != null:
        return $default(_that.metric, _that.target);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _SuccessMetric implements SuccessMetric {
  const _SuccessMetric({required this.metric, required this.target});
  factory _SuccessMetric.fromJson(Map<String, dynamic> json) =>
      _$SuccessMetricFromJson(json);

  @override
  final String metric;
  @override
  final String target;

  /// Create a copy of SuccessMetric
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SuccessMetricCopyWith<_SuccessMetric> get copyWith =>
      __$SuccessMetricCopyWithImpl<_SuccessMetric>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SuccessMetricToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SuccessMetric &&
            (identical(other.metric, metric) || other.metric == metric) &&
            (identical(other.target, target) || other.target == target));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, metric, target);

  @override
  String toString() {
    return 'SuccessMetric(metric: $metric, target: $target)';
  }
}

/// @nodoc
abstract mixin class _$SuccessMetricCopyWith<$Res>
    implements $SuccessMetricCopyWith<$Res> {
  factory _$SuccessMetricCopyWith(
          _SuccessMetric value, $Res Function(_SuccessMetric) _then) =
      __$SuccessMetricCopyWithImpl;
  @override
  @useResult
  $Res call({String metric, String target});
}

/// @nodoc
class __$SuccessMetricCopyWithImpl<$Res>
    implements _$SuccessMetricCopyWith<$Res> {
  __$SuccessMetricCopyWithImpl(this._self, this._then);

  final _SuccessMetric _self;
  final $Res Function(_SuccessMetric) _then;

  /// Create a copy of SuccessMetric
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? metric = null,
    Object? target = null,
  }) {
    return _then(_SuccessMetric(
      metric: null == metric
          ? _self.metric
          : metric // ignore: cast_nullable_to_non_nullable
              as String,
      target: null == target
          ? _self.target
          : target // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$Incident {
  String get incidentId;
  String get reportedAt;
  String get severity;
  String get category;
  List<String> get immediateActions;
  NotificationRouting get notifications;
  Investigation get investigation;

  /// Create a copy of Incident
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $IncidentCopyWith<Incident> get copyWith =>
      _$IncidentCopyWithImpl<Incident>(this as Incident, _$identity);

  /// Serializes this Incident to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Incident &&
            (identical(other.incidentId, incidentId) ||
                other.incidentId == incidentId) &&
            (identical(other.reportedAt, reportedAt) ||
                other.reportedAt == reportedAt) &&
            (identical(other.severity, severity) ||
                other.severity == severity) &&
            (identical(other.category, category) ||
                other.category == category) &&
            const DeepCollectionEquality()
                .equals(other.immediateActions, immediateActions) &&
            (identical(other.notifications, notifications) ||
                other.notifications == notifications) &&
            (identical(other.investigation, investigation) ||
                other.investigation == investigation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      incidentId,
      reportedAt,
      severity,
      category,
      const DeepCollectionEquality().hash(immediateActions),
      notifications,
      investigation);

  @override
  String toString() {
    return 'Incident(incidentId: $incidentId, reportedAt: $reportedAt, severity: $severity, category: $category, immediateActions: $immediateActions, notifications: $notifications, investigation: $investigation)';
  }
}

/// @nodoc
abstract mixin class $IncidentCopyWith<$Res> {
  factory $IncidentCopyWith(Incident value, $Res Function(Incident) _then) =
      _$IncidentCopyWithImpl;
  @useResult
  $Res call(
      {String incidentId,
      String reportedAt,
      String severity,
      String category,
      List<String> immediateActions,
      NotificationRouting notifications,
      Investigation investigation});

  $NotificationRoutingCopyWith<$Res> get notifications;
  $InvestigationCopyWith<$Res> get investigation;
}

/// @nodoc
class _$IncidentCopyWithImpl<$Res> implements $IncidentCopyWith<$Res> {
  _$IncidentCopyWithImpl(this._self, this._then);

  final Incident _self;
  final $Res Function(Incident) _then;

  /// Create a copy of Incident
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? incidentId = null,
    Object? reportedAt = null,
    Object? severity = null,
    Object? category = null,
    Object? immediateActions = null,
    Object? notifications = null,
    Object? investigation = null,
  }) {
    return _then(_self.copyWith(
      incidentId: null == incidentId
          ? _self.incidentId
          : incidentId // ignore: cast_nullable_to_non_nullable
              as String,
      reportedAt: null == reportedAt
          ? _self.reportedAt
          : reportedAt // ignore: cast_nullable_to_non_nullable
              as String,
      severity: null == severity
          ? _self.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      immediateActions: null == immediateActions
          ? _self.immediateActions
          : immediateActions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      notifications: null == notifications
          ? _self.notifications
          : notifications // ignore: cast_nullable_to_non_nullable
              as NotificationRouting,
      investigation: null == investigation
          ? _self.investigation
          : investigation // ignore: cast_nullable_to_non_nullable
              as Investigation,
    ));
  }

  /// Create a copy of Incident
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NotificationRoutingCopyWith<$Res> get notifications {
    return $NotificationRoutingCopyWith<$Res>(_self.notifications, (value) {
      return _then(_self.copyWith(notifications: value));
    });
  }

  /// Create a copy of Incident
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $InvestigationCopyWith<$Res> get investigation {
    return $InvestigationCopyWith<$Res>(_self.investigation, (value) {
      return _then(_self.copyWith(investigation: value));
    });
  }
}

/// Adds pattern-matching-related methods to [Incident].
extension IncidentPatterns on Incident {
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
    TResult Function(_Incident value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Incident() when $default != null:
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
    TResult Function(_Incident value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Incident():
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
    TResult? Function(_Incident value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Incident() when $default != null:
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
            String incidentId,
            String reportedAt,
            String severity,
            String category,
            List<String> immediateActions,
            NotificationRouting notifications,
            Investigation investigation)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Incident() when $default != null:
        return $default(
            _that.incidentId,
            _that.reportedAt,
            _that.severity,
            _that.category,
            _that.immediateActions,
            _that.notifications,
            _that.investigation);
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
            String incidentId,
            String reportedAt,
            String severity,
            String category,
            List<String> immediateActions,
            NotificationRouting notifications,
            Investigation investigation)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Incident():
        return $default(
            _that.incidentId,
            _that.reportedAt,
            _that.severity,
            _that.category,
            _that.immediateActions,
            _that.notifications,
            _that.investigation);
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
            String incidentId,
            String reportedAt,
            String severity,
            String category,
            List<String> immediateActions,
            NotificationRouting notifications,
            Investigation investigation)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Incident() when $default != null:
        return $default(
            _that.incidentId,
            _that.reportedAt,
            _that.severity,
            _that.category,
            _that.immediateActions,
            _that.notifications,
            _that.investigation);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Incident implements Incident {
  const _Incident(
      {required this.incidentId,
      required this.reportedAt,
      required this.severity,
      required this.category,
      required final List<String> immediateActions,
      required this.notifications,
      required this.investigation})
      : _immediateActions = immediateActions;
  factory _Incident.fromJson(Map<String, dynamic> json) =>
      _$IncidentFromJson(json);

  @override
  final String incidentId;
  @override
  final String reportedAt;
  @override
  final String severity;
  @override
  final String category;
  final List<String> _immediateActions;
  @override
  List<String> get immediateActions {
    if (_immediateActions is EqualUnmodifiableListView)
      return _immediateActions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_immediateActions);
  }

  @override
  final NotificationRouting notifications;
  @override
  final Investigation investigation;

  /// Create a copy of Incident
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$IncidentCopyWith<_Incident> get copyWith =>
      __$IncidentCopyWithImpl<_Incident>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$IncidentToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Incident &&
            (identical(other.incidentId, incidentId) ||
                other.incidentId == incidentId) &&
            (identical(other.reportedAt, reportedAt) ||
                other.reportedAt == reportedAt) &&
            (identical(other.severity, severity) ||
                other.severity == severity) &&
            (identical(other.category, category) ||
                other.category == category) &&
            const DeepCollectionEquality()
                .equals(other._immediateActions, _immediateActions) &&
            (identical(other.notifications, notifications) ||
                other.notifications == notifications) &&
            (identical(other.investigation, investigation) ||
                other.investigation == investigation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      incidentId,
      reportedAt,
      severity,
      category,
      const DeepCollectionEquality().hash(_immediateActions),
      notifications,
      investigation);

  @override
  String toString() {
    return 'Incident(incidentId: $incidentId, reportedAt: $reportedAt, severity: $severity, category: $category, immediateActions: $immediateActions, notifications: $notifications, investigation: $investigation)';
  }
}

/// @nodoc
abstract mixin class _$IncidentCopyWith<$Res>
    implements $IncidentCopyWith<$Res> {
  factory _$IncidentCopyWith(_Incident value, $Res Function(_Incident) _then) =
      __$IncidentCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String incidentId,
      String reportedAt,
      String severity,
      String category,
      List<String> immediateActions,
      NotificationRouting notifications,
      Investigation investigation});

  @override
  $NotificationRoutingCopyWith<$Res> get notifications;
  @override
  $InvestigationCopyWith<$Res> get investigation;
}

/// @nodoc
class __$IncidentCopyWithImpl<$Res> implements _$IncidentCopyWith<$Res> {
  __$IncidentCopyWithImpl(this._self, this._then);

  final _Incident _self;
  final $Res Function(_Incident) _then;

  /// Create a copy of Incident
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? incidentId = null,
    Object? reportedAt = null,
    Object? severity = null,
    Object? category = null,
    Object? immediateActions = null,
    Object? notifications = null,
    Object? investigation = null,
  }) {
    return _then(_Incident(
      incidentId: null == incidentId
          ? _self.incidentId
          : incidentId // ignore: cast_nullable_to_non_nullable
              as String,
      reportedAt: null == reportedAt
          ? _self.reportedAt
          : reportedAt // ignore: cast_nullable_to_non_nullable
              as String,
      severity: null == severity
          ? _self.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      immediateActions: null == immediateActions
          ? _self._immediateActions
          : immediateActions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      notifications: null == notifications
          ? _self.notifications
          : notifications // ignore: cast_nullable_to_non_nullable
              as NotificationRouting,
      investigation: null == investigation
          ? _self.investigation
          : investigation // ignore: cast_nullable_to_non_nullable
              as Investigation,
    ));
  }

  /// Create a copy of Incident
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NotificationRoutingCopyWith<$Res> get notifications {
    return $NotificationRoutingCopyWith<$Res>(_self.notifications, (value) {
      return _then(_self.copyWith(notifications: value));
    });
  }

  /// Create a copy of Incident
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $InvestigationCopyWith<$Res> get investigation {
    return $InvestigationCopyWith<$Res>(_self.investigation, (value) {
      return _then(_self.copyWith(investigation: value));
    });
  }
}

/// @nodoc
mixin _$NotificationRouting {
  bool get family;
  bool get supervisor;
  bool get careCoordinator;
  bool get regulator;

  /// Create a copy of NotificationRouting
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $NotificationRoutingCopyWith<NotificationRouting> get copyWith =>
      _$NotificationRoutingCopyWithImpl<NotificationRouting>(
          this as NotificationRouting, _$identity);

  /// Serializes this NotificationRouting to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is NotificationRouting &&
            (identical(other.family, family) || other.family == family) &&
            (identical(other.supervisor, supervisor) ||
                other.supervisor == supervisor) &&
            (identical(other.careCoordinator, careCoordinator) ||
                other.careCoordinator == careCoordinator) &&
            (identical(other.regulator, regulator) ||
                other.regulator == regulator));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, family, supervisor, careCoordinator, regulator);

  @override
  String toString() {
    return 'NotificationRouting(family: $family, supervisor: $supervisor, careCoordinator: $careCoordinator, regulator: $regulator)';
  }
}

/// @nodoc
abstract mixin class $NotificationRoutingCopyWith<$Res> {
  factory $NotificationRoutingCopyWith(
          NotificationRouting value, $Res Function(NotificationRouting) _then) =
      _$NotificationRoutingCopyWithImpl;
  @useResult
  $Res call(
      {bool family, bool supervisor, bool careCoordinator, bool regulator});
}

/// @nodoc
class _$NotificationRoutingCopyWithImpl<$Res>
    implements $NotificationRoutingCopyWith<$Res> {
  _$NotificationRoutingCopyWithImpl(this._self, this._then);

  final NotificationRouting _self;
  final $Res Function(NotificationRouting) _then;

  /// Create a copy of NotificationRouting
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? family = null,
    Object? supervisor = null,
    Object? careCoordinator = null,
    Object? regulator = null,
  }) {
    return _then(_self.copyWith(
      family: null == family
          ? _self.family
          : family // ignore: cast_nullable_to_non_nullable
              as bool,
      supervisor: null == supervisor
          ? _self.supervisor
          : supervisor // ignore: cast_nullable_to_non_nullable
              as bool,
      careCoordinator: null == careCoordinator
          ? _self.careCoordinator
          : careCoordinator // ignore: cast_nullable_to_non_nullable
              as bool,
      regulator: null == regulator
          ? _self.regulator
          : regulator // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [NotificationRouting].
extension NotificationRoutingPatterns on NotificationRouting {
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
    TResult Function(_NotificationRouting value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _NotificationRouting() when $default != null:
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
    TResult Function(_NotificationRouting value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NotificationRouting():
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
    TResult? Function(_NotificationRouting value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NotificationRouting() when $default != null:
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
            bool family, bool supervisor, bool careCoordinator, bool regulator)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _NotificationRouting() when $default != null:
        return $default(_that.family, _that.supervisor, _that.careCoordinator,
            _that.regulator);
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
            bool family, bool supervisor, bool careCoordinator, bool regulator)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NotificationRouting():
        return $default(_that.family, _that.supervisor, _that.careCoordinator,
            _that.regulator);
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
            bool family, bool supervisor, bool careCoordinator, bool regulator)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NotificationRouting() when $default != null:
        return $default(_that.family, _that.supervisor, _that.careCoordinator,
            _that.regulator);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _NotificationRouting implements NotificationRouting {
  const _NotificationRouting(
      {required this.family,
      required this.supervisor,
      required this.careCoordinator,
      required this.regulator});
  factory _NotificationRouting.fromJson(Map<String, dynamic> json) =>
      _$NotificationRoutingFromJson(json);

  @override
  final bool family;
  @override
  final bool supervisor;
  @override
  final bool careCoordinator;
  @override
  final bool regulator;

  /// Create a copy of NotificationRouting
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$NotificationRoutingCopyWith<_NotificationRouting> get copyWith =>
      __$NotificationRoutingCopyWithImpl<_NotificationRouting>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$NotificationRoutingToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _NotificationRouting &&
            (identical(other.family, family) || other.family == family) &&
            (identical(other.supervisor, supervisor) ||
                other.supervisor == supervisor) &&
            (identical(other.careCoordinator, careCoordinator) ||
                other.careCoordinator == careCoordinator) &&
            (identical(other.regulator, regulator) ||
                other.regulator == regulator));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, family, supervisor, careCoordinator, regulator);

  @override
  String toString() {
    return 'NotificationRouting(family: $family, supervisor: $supervisor, careCoordinator: $careCoordinator, regulator: $regulator)';
  }
}

/// @nodoc
abstract mixin class _$NotificationRoutingCopyWith<$Res>
    implements $NotificationRoutingCopyWith<$Res> {
  factory _$NotificationRoutingCopyWith(_NotificationRouting value,
          $Res Function(_NotificationRouting) _then) =
      __$NotificationRoutingCopyWithImpl;
  @override
  @useResult
  $Res call(
      {bool family, bool supervisor, bool careCoordinator, bool regulator});
}

/// @nodoc
class __$NotificationRoutingCopyWithImpl<$Res>
    implements _$NotificationRoutingCopyWith<$Res> {
  __$NotificationRoutingCopyWithImpl(this._self, this._then);

  final _NotificationRouting _self;
  final $Res Function(_NotificationRouting) _then;

  /// Create a copy of NotificationRouting
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? family = null,
    Object? supervisor = null,
    Object? careCoordinator = null,
    Object? regulator = null,
  }) {
    return _then(_NotificationRouting(
      family: null == family
          ? _self.family
          : family // ignore: cast_nullable_to_non_nullable
              as bool,
      supervisor: null == supervisor
          ? _self.supervisor
          : supervisor // ignore: cast_nullable_to_non_nullable
              as bool,
      careCoordinator: null == careCoordinator
          ? _self.careCoordinator
          : careCoordinator // ignore: cast_nullable_to_non_nullable
              as bool,
      regulator: null == regulator
          ? _self.regulator
          : regulator // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
mixin _$Investigation {
  String get investigator;
  String get dueDate;
  List<String> get steps;

  /// Create a copy of Investigation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $InvestigationCopyWith<Investigation> get copyWith =>
      _$InvestigationCopyWithImpl<Investigation>(
          this as Investigation, _$identity);

  /// Serializes this Investigation to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Investigation &&
            (identical(other.investigator, investigator) ||
                other.investigator == investigator) &&
            (identical(other.dueDate, dueDate) || other.dueDate == dueDate) &&
            const DeepCollectionEquality().equals(other.steps, steps));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, investigator, dueDate,
      const DeepCollectionEquality().hash(steps));

  @override
  String toString() {
    return 'Investigation(investigator: $investigator, dueDate: $dueDate, steps: $steps)';
  }
}

/// @nodoc
abstract mixin class $InvestigationCopyWith<$Res> {
  factory $InvestigationCopyWith(
          Investigation value, $Res Function(Investigation) _then) =
      _$InvestigationCopyWithImpl;
  @useResult
  $Res call({String investigator, String dueDate, List<String> steps});
}

/// @nodoc
class _$InvestigationCopyWithImpl<$Res>
    implements $InvestigationCopyWith<$Res> {
  _$InvestigationCopyWithImpl(this._self, this._then);

  final Investigation _self;
  final $Res Function(Investigation) _then;

  /// Create a copy of Investigation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? investigator = null,
    Object? dueDate = null,
    Object? steps = null,
  }) {
    return _then(_self.copyWith(
      investigator: null == investigator
          ? _self.investigator
          : investigator // ignore: cast_nullable_to_non_nullable
              as String,
      dueDate: null == dueDate
          ? _self.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as String,
      steps: null == steps
          ? _self.steps
          : steps // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// Adds pattern-matching-related methods to [Investigation].
extension InvestigationPatterns on Investigation {
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
    TResult Function(_Investigation value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Investigation() when $default != null:
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
    TResult Function(_Investigation value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Investigation():
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
    TResult? Function(_Investigation value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Investigation() when $default != null:
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
    TResult Function(String investigator, String dueDate, List<String> steps)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Investigation() when $default != null:
        return $default(_that.investigator, _that.dueDate, _that.steps);
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
    TResult Function(String investigator, String dueDate, List<String> steps)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Investigation():
        return $default(_that.investigator, _that.dueDate, _that.steps);
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
    TResult? Function(String investigator, String dueDate, List<String> steps)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Investigation() when $default != null:
        return $default(_that.investigator, _that.dueDate, _that.steps);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Investigation implements Investigation {
  const _Investigation(
      {required this.investigator,
      required this.dueDate,
      required final List<String> steps})
      : _steps = steps;
  factory _Investigation.fromJson(Map<String, dynamic> json) =>
      _$InvestigationFromJson(json);

  @override
  final String investigator;
  @override
  final String dueDate;
  final List<String> _steps;
  @override
  List<String> get steps {
    if (_steps is EqualUnmodifiableListView) return _steps;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_steps);
  }

  /// Create a copy of Investigation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$InvestigationCopyWith<_Investigation> get copyWith =>
      __$InvestigationCopyWithImpl<_Investigation>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$InvestigationToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Investigation &&
            (identical(other.investigator, investigator) ||
                other.investigator == investigator) &&
            (identical(other.dueDate, dueDate) || other.dueDate == dueDate) &&
            const DeepCollectionEquality().equals(other._steps, _steps));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, investigator, dueDate,
      const DeepCollectionEquality().hash(_steps));

  @override
  String toString() {
    return 'Investigation(investigator: $investigator, dueDate: $dueDate, steps: $steps)';
  }
}

/// @nodoc
abstract mixin class _$InvestigationCopyWith<$Res>
    implements $InvestigationCopyWith<$Res> {
  factory _$InvestigationCopyWith(
          _Investigation value, $Res Function(_Investigation) _then) =
      __$InvestigationCopyWithImpl;
  @override
  @useResult
  $Res call({String investigator, String dueDate, List<String> steps});
}

/// @nodoc
class __$InvestigationCopyWithImpl<$Res>
    implements _$InvestigationCopyWith<$Res> {
  __$InvestigationCopyWithImpl(this._self, this._then);

  final _Investigation _self;
  final $Res Function(_Investigation) _then;

  /// Create a copy of Investigation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? investigator = null,
    Object? dueDate = null,
    Object? steps = null,
  }) {
    return _then(_Investigation(
      investigator: null == investigator
          ? _self.investigator
          : investigator // ignore: cast_nullable_to_non_nullable
              as String,
      dueDate: null == dueDate
          ? _self.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as String,
      steps: null == steps
          ? _self._steps
          : steps // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
mixin _$RootCauseAnalysis {
  String get incidentId;
  String get analyzedAt;
  List<RootCause> get rootCauses;
  List<ContributingFactorAnalysis> get contributingFactors;
  List<String> get systemicIssues;
  List<SimilarIncident> get similarIncidents;
  List<String> get recommendations;

  /// Create a copy of RootCauseAnalysis
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RootCauseAnalysisCopyWith<RootCauseAnalysis> get copyWith =>
      _$RootCauseAnalysisCopyWithImpl<RootCauseAnalysis>(
          this as RootCauseAnalysis, _$identity);

  /// Serializes this RootCauseAnalysis to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RootCauseAnalysis &&
            (identical(other.incidentId, incidentId) ||
                other.incidentId == incidentId) &&
            (identical(other.analyzedAt, analyzedAt) ||
                other.analyzedAt == analyzedAt) &&
            const DeepCollectionEquality()
                .equals(other.rootCauses, rootCauses) &&
            const DeepCollectionEquality()
                .equals(other.contributingFactors, contributingFactors) &&
            const DeepCollectionEquality()
                .equals(other.systemicIssues, systemicIssues) &&
            const DeepCollectionEquality()
                .equals(other.similarIncidents, similarIncidents) &&
            const DeepCollectionEquality()
                .equals(other.recommendations, recommendations));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      incidentId,
      analyzedAt,
      const DeepCollectionEquality().hash(rootCauses),
      const DeepCollectionEquality().hash(contributingFactors),
      const DeepCollectionEquality().hash(systemicIssues),
      const DeepCollectionEquality().hash(similarIncidents),
      const DeepCollectionEquality().hash(recommendations));

  @override
  String toString() {
    return 'RootCauseAnalysis(incidentId: $incidentId, analyzedAt: $analyzedAt, rootCauses: $rootCauses, contributingFactors: $contributingFactors, systemicIssues: $systemicIssues, similarIncidents: $similarIncidents, recommendations: $recommendations)';
  }
}

/// @nodoc
abstract mixin class $RootCauseAnalysisCopyWith<$Res> {
  factory $RootCauseAnalysisCopyWith(
          RootCauseAnalysis value, $Res Function(RootCauseAnalysis) _then) =
      _$RootCauseAnalysisCopyWithImpl;
  @useResult
  $Res call(
      {String incidentId,
      String analyzedAt,
      List<RootCause> rootCauses,
      List<ContributingFactorAnalysis> contributingFactors,
      List<String> systemicIssues,
      List<SimilarIncident> similarIncidents,
      List<String> recommendations});
}

/// @nodoc
class _$RootCauseAnalysisCopyWithImpl<$Res>
    implements $RootCauseAnalysisCopyWith<$Res> {
  _$RootCauseAnalysisCopyWithImpl(this._self, this._then);

  final RootCauseAnalysis _self;
  final $Res Function(RootCauseAnalysis) _then;

  /// Create a copy of RootCauseAnalysis
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? incidentId = null,
    Object? analyzedAt = null,
    Object? rootCauses = null,
    Object? contributingFactors = null,
    Object? systemicIssues = null,
    Object? similarIncidents = null,
    Object? recommendations = null,
  }) {
    return _then(_self.copyWith(
      incidentId: null == incidentId
          ? _self.incidentId
          : incidentId // ignore: cast_nullable_to_non_nullable
              as String,
      analyzedAt: null == analyzedAt
          ? _self.analyzedAt
          : analyzedAt // ignore: cast_nullable_to_non_nullable
              as String,
      rootCauses: null == rootCauses
          ? _self.rootCauses
          : rootCauses // ignore: cast_nullable_to_non_nullable
              as List<RootCause>,
      contributingFactors: null == contributingFactors
          ? _self.contributingFactors
          : contributingFactors // ignore: cast_nullable_to_non_nullable
              as List<ContributingFactorAnalysis>,
      systemicIssues: null == systemicIssues
          ? _self.systemicIssues
          : systemicIssues // ignore: cast_nullable_to_non_nullable
              as List<String>,
      similarIncidents: null == similarIncidents
          ? _self.similarIncidents
          : similarIncidents // ignore: cast_nullable_to_non_nullable
              as List<SimilarIncident>,
      recommendations: null == recommendations
          ? _self.recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// Adds pattern-matching-related methods to [RootCauseAnalysis].
extension RootCauseAnalysisPatterns on RootCauseAnalysis {
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
    TResult Function(_RootCauseAnalysis value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RootCauseAnalysis() when $default != null:
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
    TResult Function(_RootCauseAnalysis value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RootCauseAnalysis():
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
    TResult? Function(_RootCauseAnalysis value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RootCauseAnalysis() when $default != null:
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
            String incidentId,
            String analyzedAt,
            List<RootCause> rootCauses,
            List<ContributingFactorAnalysis> contributingFactors,
            List<String> systemicIssues,
            List<SimilarIncident> similarIncidents,
            List<String> recommendations)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RootCauseAnalysis() when $default != null:
        return $default(
            _that.incidentId,
            _that.analyzedAt,
            _that.rootCauses,
            _that.contributingFactors,
            _that.systemicIssues,
            _that.similarIncidents,
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
            String incidentId,
            String analyzedAt,
            List<RootCause> rootCauses,
            List<ContributingFactorAnalysis> contributingFactors,
            List<String> systemicIssues,
            List<SimilarIncident> similarIncidents,
            List<String> recommendations)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RootCauseAnalysis():
        return $default(
            _that.incidentId,
            _that.analyzedAt,
            _that.rootCauses,
            _that.contributingFactors,
            _that.systemicIssues,
            _that.similarIncidents,
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
            String incidentId,
            String analyzedAt,
            List<RootCause> rootCauses,
            List<ContributingFactorAnalysis> contributingFactors,
            List<String> systemicIssues,
            List<SimilarIncident> similarIncidents,
            List<String> recommendations)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RootCauseAnalysis() when $default != null:
        return $default(
            _that.incidentId,
            _that.analyzedAt,
            _that.rootCauses,
            _that.contributingFactors,
            _that.systemicIssues,
            _that.similarIncidents,
            _that.recommendations);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _RootCauseAnalysis implements RootCauseAnalysis {
  const _RootCauseAnalysis(
      {required this.incidentId,
      required this.analyzedAt,
      required final List<RootCause> rootCauses,
      required final List<ContributingFactorAnalysis> contributingFactors,
      required final List<String> systemicIssues,
      required final List<SimilarIncident> similarIncidents,
      required final List<String> recommendations})
      : _rootCauses = rootCauses,
        _contributingFactors = contributingFactors,
        _systemicIssues = systemicIssues,
        _similarIncidents = similarIncidents,
        _recommendations = recommendations;
  factory _RootCauseAnalysis.fromJson(Map<String, dynamic> json) =>
      _$RootCauseAnalysisFromJson(json);

  @override
  final String incidentId;
  @override
  final String analyzedAt;
  final List<RootCause> _rootCauses;
  @override
  List<RootCause> get rootCauses {
    if (_rootCauses is EqualUnmodifiableListView) return _rootCauses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_rootCauses);
  }

  final List<ContributingFactorAnalysis> _contributingFactors;
  @override
  List<ContributingFactorAnalysis> get contributingFactors {
    if (_contributingFactors is EqualUnmodifiableListView)
      return _contributingFactors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_contributingFactors);
  }

  final List<String> _systemicIssues;
  @override
  List<String> get systemicIssues {
    if (_systemicIssues is EqualUnmodifiableListView) return _systemicIssues;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_systemicIssues);
  }

  final List<SimilarIncident> _similarIncidents;
  @override
  List<SimilarIncident> get similarIncidents {
    if (_similarIncidents is EqualUnmodifiableListView)
      return _similarIncidents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_similarIncidents);
  }

  final List<String> _recommendations;
  @override
  List<String> get recommendations {
    if (_recommendations is EqualUnmodifiableListView) return _recommendations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recommendations);
  }

  /// Create a copy of RootCauseAnalysis
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RootCauseAnalysisCopyWith<_RootCauseAnalysis> get copyWith =>
      __$RootCauseAnalysisCopyWithImpl<_RootCauseAnalysis>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$RootCauseAnalysisToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RootCauseAnalysis &&
            (identical(other.incidentId, incidentId) ||
                other.incidentId == incidentId) &&
            (identical(other.analyzedAt, analyzedAt) ||
                other.analyzedAt == analyzedAt) &&
            const DeepCollectionEquality()
                .equals(other._rootCauses, _rootCauses) &&
            const DeepCollectionEquality()
                .equals(other._contributingFactors, _contributingFactors) &&
            const DeepCollectionEquality()
                .equals(other._systemicIssues, _systemicIssues) &&
            const DeepCollectionEquality()
                .equals(other._similarIncidents, _similarIncidents) &&
            const DeepCollectionEquality()
                .equals(other._recommendations, _recommendations));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      incidentId,
      analyzedAt,
      const DeepCollectionEquality().hash(_rootCauses),
      const DeepCollectionEquality().hash(_contributingFactors),
      const DeepCollectionEquality().hash(_systemicIssues),
      const DeepCollectionEquality().hash(_similarIncidents),
      const DeepCollectionEquality().hash(_recommendations));

  @override
  String toString() {
    return 'RootCauseAnalysis(incidentId: $incidentId, analyzedAt: $analyzedAt, rootCauses: $rootCauses, contributingFactors: $contributingFactors, systemicIssues: $systemicIssues, similarIncidents: $similarIncidents, recommendations: $recommendations)';
  }
}

/// @nodoc
abstract mixin class _$RootCauseAnalysisCopyWith<$Res>
    implements $RootCauseAnalysisCopyWith<$Res> {
  factory _$RootCauseAnalysisCopyWith(
          _RootCauseAnalysis value, $Res Function(_RootCauseAnalysis) _then) =
      __$RootCauseAnalysisCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String incidentId,
      String analyzedAt,
      List<RootCause> rootCauses,
      List<ContributingFactorAnalysis> contributingFactors,
      List<String> systemicIssues,
      List<SimilarIncident> similarIncidents,
      List<String> recommendations});
}

/// @nodoc
class __$RootCauseAnalysisCopyWithImpl<$Res>
    implements _$RootCauseAnalysisCopyWith<$Res> {
  __$RootCauseAnalysisCopyWithImpl(this._self, this._then);

  final _RootCauseAnalysis _self;
  final $Res Function(_RootCauseAnalysis) _then;

  /// Create a copy of RootCauseAnalysis
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? incidentId = null,
    Object? analyzedAt = null,
    Object? rootCauses = null,
    Object? contributingFactors = null,
    Object? systemicIssues = null,
    Object? similarIncidents = null,
    Object? recommendations = null,
  }) {
    return _then(_RootCauseAnalysis(
      incidentId: null == incidentId
          ? _self.incidentId
          : incidentId // ignore: cast_nullable_to_non_nullable
              as String,
      analyzedAt: null == analyzedAt
          ? _self.analyzedAt
          : analyzedAt // ignore: cast_nullable_to_non_nullable
              as String,
      rootCauses: null == rootCauses
          ? _self._rootCauses
          : rootCauses // ignore: cast_nullable_to_non_nullable
              as List<RootCause>,
      contributingFactors: null == contributingFactors
          ? _self._contributingFactors
          : contributingFactors // ignore: cast_nullable_to_non_nullable
              as List<ContributingFactorAnalysis>,
      systemicIssues: null == systemicIssues
          ? _self._systemicIssues
          : systemicIssues // ignore: cast_nullable_to_non_nullable
              as List<String>,
      similarIncidents: null == similarIncidents
          ? _self._similarIncidents
          : similarIncidents // ignore: cast_nullable_to_non_nullable
              as List<SimilarIncident>,
      recommendations: null == recommendations
          ? _self._recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
mixin _$RootCause {
  String get cause;
  String get likelihood;

  /// Create a copy of RootCause
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RootCauseCopyWith<RootCause> get copyWith =>
      _$RootCauseCopyWithImpl<RootCause>(this as RootCause, _$identity);

  /// Serializes this RootCause to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RootCause &&
            (identical(other.cause, cause) || other.cause == cause) &&
            (identical(other.likelihood, likelihood) ||
                other.likelihood == likelihood));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, cause, likelihood);

  @override
  String toString() {
    return 'RootCause(cause: $cause, likelihood: $likelihood)';
  }
}

/// @nodoc
abstract mixin class $RootCauseCopyWith<$Res> {
  factory $RootCauseCopyWith(RootCause value, $Res Function(RootCause) _then) =
      _$RootCauseCopyWithImpl;
  @useResult
  $Res call({String cause, String likelihood});
}

/// @nodoc
class _$RootCauseCopyWithImpl<$Res> implements $RootCauseCopyWith<$Res> {
  _$RootCauseCopyWithImpl(this._self, this._then);

  final RootCause _self;
  final $Res Function(RootCause) _then;

  /// Create a copy of RootCause
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cause = null,
    Object? likelihood = null,
  }) {
    return _then(_self.copyWith(
      cause: null == cause
          ? _self.cause
          : cause // ignore: cast_nullable_to_non_nullable
              as String,
      likelihood: null == likelihood
          ? _self.likelihood
          : likelihood // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [RootCause].
extension RootCausePatterns on RootCause {
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
    TResult Function(_RootCause value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RootCause() when $default != null:
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
    TResult Function(_RootCause value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RootCause():
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
    TResult? Function(_RootCause value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RootCause() when $default != null:
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
    TResult Function(String cause, String likelihood)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RootCause() when $default != null:
        return $default(_that.cause, _that.likelihood);
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
    TResult Function(String cause, String likelihood) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RootCause():
        return $default(_that.cause, _that.likelihood);
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
    TResult? Function(String cause, String likelihood)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RootCause() when $default != null:
        return $default(_that.cause, _that.likelihood);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _RootCause implements RootCause {
  const _RootCause({required this.cause, required this.likelihood});
  factory _RootCause.fromJson(Map<String, dynamic> json) =>
      _$RootCauseFromJson(json);

  @override
  final String cause;
  @override
  final String likelihood;

  /// Create a copy of RootCause
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RootCauseCopyWith<_RootCause> get copyWith =>
      __$RootCauseCopyWithImpl<_RootCause>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$RootCauseToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RootCause &&
            (identical(other.cause, cause) || other.cause == cause) &&
            (identical(other.likelihood, likelihood) ||
                other.likelihood == likelihood));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, cause, likelihood);

  @override
  String toString() {
    return 'RootCause(cause: $cause, likelihood: $likelihood)';
  }
}

/// @nodoc
abstract mixin class _$RootCauseCopyWith<$Res>
    implements $RootCauseCopyWith<$Res> {
  factory _$RootCauseCopyWith(
          _RootCause value, $Res Function(_RootCause) _then) =
      __$RootCauseCopyWithImpl;
  @override
  @useResult
  $Res call({String cause, String likelihood});
}

/// @nodoc
class __$RootCauseCopyWithImpl<$Res> implements _$RootCauseCopyWith<$Res> {
  __$RootCauseCopyWithImpl(this._self, this._then);

  final _RootCause _self;
  final $Res Function(_RootCause) _then;

  /// Create a copy of RootCause
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? cause = null,
    Object? likelihood = null,
  }) {
    return _then(_RootCause(
      cause: null == cause
          ? _self.cause
          : cause // ignore: cast_nullable_to_non_nullable
              as String,
      likelihood: null == likelihood
          ? _self.likelihood
          : likelihood // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$ContributingFactorAnalysis {
  String get factor;
  String get contribution;

  /// Create a copy of ContributingFactorAnalysis
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ContributingFactorAnalysisCopyWith<ContributingFactorAnalysis>
      get copyWith =>
          _$ContributingFactorAnalysisCopyWithImpl<ContributingFactorAnalysis>(
              this as ContributingFactorAnalysis, _$identity);

  /// Serializes this ContributingFactorAnalysis to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ContributingFactorAnalysis &&
            (identical(other.factor, factor) || other.factor == factor) &&
            (identical(other.contribution, contribution) ||
                other.contribution == contribution));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, factor, contribution);

  @override
  String toString() {
    return 'ContributingFactorAnalysis(factor: $factor, contribution: $contribution)';
  }
}

/// @nodoc
abstract mixin class $ContributingFactorAnalysisCopyWith<$Res> {
  factory $ContributingFactorAnalysisCopyWith(ContributingFactorAnalysis value,
          $Res Function(ContributingFactorAnalysis) _then) =
      _$ContributingFactorAnalysisCopyWithImpl;
  @useResult
  $Res call({String factor, String contribution});
}

/// @nodoc
class _$ContributingFactorAnalysisCopyWithImpl<$Res>
    implements $ContributingFactorAnalysisCopyWith<$Res> {
  _$ContributingFactorAnalysisCopyWithImpl(this._self, this._then);

  final ContributingFactorAnalysis _self;
  final $Res Function(ContributingFactorAnalysis) _then;

  /// Create a copy of ContributingFactorAnalysis
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? factor = null,
    Object? contribution = null,
  }) {
    return _then(_self.copyWith(
      factor: null == factor
          ? _self.factor
          : factor // ignore: cast_nullable_to_non_nullable
              as String,
      contribution: null == contribution
          ? _self.contribution
          : contribution // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [ContributingFactorAnalysis].
extension ContributingFactorAnalysisPatterns on ContributingFactorAnalysis {
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
    TResult Function(_ContributingFactorAnalysis value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ContributingFactorAnalysis() when $default != null:
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
    TResult Function(_ContributingFactorAnalysis value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ContributingFactorAnalysis():
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
    TResult? Function(_ContributingFactorAnalysis value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ContributingFactorAnalysis() when $default != null:
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
    TResult Function(String factor, String contribution)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ContributingFactorAnalysis() when $default != null:
        return $default(_that.factor, _that.contribution);
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
    TResult Function(String factor, String contribution) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ContributingFactorAnalysis():
        return $default(_that.factor, _that.contribution);
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
    TResult? Function(String factor, String contribution)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ContributingFactorAnalysis() when $default != null:
        return $default(_that.factor, _that.contribution);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ContributingFactorAnalysis implements ContributingFactorAnalysis {
  const _ContributingFactorAnalysis(
      {required this.factor, required this.contribution});
  factory _ContributingFactorAnalysis.fromJson(Map<String, dynamic> json) =>
      _$ContributingFactorAnalysisFromJson(json);

  @override
  final String factor;
  @override
  final String contribution;

  /// Create a copy of ContributingFactorAnalysis
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ContributingFactorAnalysisCopyWith<_ContributingFactorAnalysis>
      get copyWith => __$ContributingFactorAnalysisCopyWithImpl<
          _ContributingFactorAnalysis>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ContributingFactorAnalysisToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ContributingFactorAnalysis &&
            (identical(other.factor, factor) || other.factor == factor) &&
            (identical(other.contribution, contribution) ||
                other.contribution == contribution));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, factor, contribution);

  @override
  String toString() {
    return 'ContributingFactorAnalysis(factor: $factor, contribution: $contribution)';
  }
}

/// @nodoc
abstract mixin class _$ContributingFactorAnalysisCopyWith<$Res>
    implements $ContributingFactorAnalysisCopyWith<$Res> {
  factory _$ContributingFactorAnalysisCopyWith(
          _ContributingFactorAnalysis value,
          $Res Function(_ContributingFactorAnalysis) _then) =
      __$ContributingFactorAnalysisCopyWithImpl;
  @override
  @useResult
  $Res call({String factor, String contribution});
}

/// @nodoc
class __$ContributingFactorAnalysisCopyWithImpl<$Res>
    implements _$ContributingFactorAnalysisCopyWith<$Res> {
  __$ContributingFactorAnalysisCopyWithImpl(this._self, this._then);

  final _ContributingFactorAnalysis _self;
  final $Res Function(_ContributingFactorAnalysis) _then;

  /// Create a copy of ContributingFactorAnalysis
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? factor = null,
    Object? contribution = null,
  }) {
    return _then(_ContributingFactorAnalysis(
      factor: null == factor
          ? _self.factor
          : factor // ignore: cast_nullable_to_non_nullable
              as String,
      contribution: null == contribution
          ? _self.contribution
          : contribution // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$SimilarIncident {
  String get incidentId;
  String get date;
  double get similarity;

  /// Create a copy of SimilarIncident
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SimilarIncidentCopyWith<SimilarIncident> get copyWith =>
      _$SimilarIncidentCopyWithImpl<SimilarIncident>(
          this as SimilarIncident, _$identity);

  /// Serializes this SimilarIncident to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SimilarIncident &&
            (identical(other.incidentId, incidentId) ||
                other.incidentId == incidentId) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.similarity, similarity) ||
                other.similarity == similarity));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, incidentId, date, similarity);

  @override
  String toString() {
    return 'SimilarIncident(incidentId: $incidentId, date: $date, similarity: $similarity)';
  }
}

/// @nodoc
abstract mixin class $SimilarIncidentCopyWith<$Res> {
  factory $SimilarIncidentCopyWith(
          SimilarIncident value, $Res Function(SimilarIncident) _then) =
      _$SimilarIncidentCopyWithImpl;
  @useResult
  $Res call({String incidentId, String date, double similarity});
}

/// @nodoc
class _$SimilarIncidentCopyWithImpl<$Res>
    implements $SimilarIncidentCopyWith<$Res> {
  _$SimilarIncidentCopyWithImpl(this._self, this._then);

  final SimilarIncident _self;
  final $Res Function(SimilarIncident) _then;

  /// Create a copy of SimilarIncident
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? incidentId = null,
    Object? date = null,
    Object? similarity = null,
  }) {
    return _then(_self.copyWith(
      incidentId: null == incidentId
          ? _self.incidentId
          : incidentId // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      similarity: null == similarity
          ? _self.similarity
          : similarity // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// Adds pattern-matching-related methods to [SimilarIncident].
extension SimilarIncidentPatterns on SimilarIncident {
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
    TResult Function(_SimilarIncident value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SimilarIncident() when $default != null:
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
    TResult Function(_SimilarIncident value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SimilarIncident():
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
    TResult? Function(_SimilarIncident value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SimilarIncident() when $default != null:
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
    TResult Function(String incidentId, String date, double similarity)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SimilarIncident() when $default != null:
        return $default(_that.incidentId, _that.date, _that.similarity);
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
    TResult Function(String incidentId, String date, double similarity)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SimilarIncident():
        return $default(_that.incidentId, _that.date, _that.similarity);
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
    TResult? Function(String incidentId, String date, double similarity)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SimilarIncident() when $default != null:
        return $default(_that.incidentId, _that.date, _that.similarity);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _SimilarIncident implements SimilarIncident {
  const _SimilarIncident(
      {required this.incidentId, required this.date, required this.similarity});
  factory _SimilarIncident.fromJson(Map<String, dynamic> json) =>
      _$SimilarIncidentFromJson(json);

  @override
  final String incidentId;
  @override
  final String date;
  @override
  final double similarity;

  /// Create a copy of SimilarIncident
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SimilarIncidentCopyWith<_SimilarIncident> get copyWith =>
      __$SimilarIncidentCopyWithImpl<_SimilarIncident>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SimilarIncidentToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SimilarIncident &&
            (identical(other.incidentId, incidentId) ||
                other.incidentId == incidentId) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.similarity, similarity) ||
                other.similarity == similarity));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, incidentId, date, similarity);

  @override
  String toString() {
    return 'SimilarIncident(incidentId: $incidentId, date: $date, similarity: $similarity)';
  }
}

/// @nodoc
abstract mixin class _$SimilarIncidentCopyWith<$Res>
    implements $SimilarIncidentCopyWith<$Res> {
  factory _$SimilarIncidentCopyWith(
          _SimilarIncident value, $Res Function(_SimilarIncident) _then) =
      __$SimilarIncidentCopyWithImpl;
  @override
  @useResult
  $Res call({String incidentId, String date, double similarity});
}

/// @nodoc
class __$SimilarIncidentCopyWithImpl<$Res>
    implements _$SimilarIncidentCopyWith<$Res> {
  __$SimilarIncidentCopyWithImpl(this._self, this._then);

  final _SimilarIncident _self;
  final $Res Function(_SimilarIncident) _then;

  /// Create a copy of SimilarIncident
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? incidentId = null,
    Object? date = null,
    Object? similarity = null,
  }) {
    return _then(_SimilarIncident(
      incidentId: null == incidentId
          ? _self.incidentId
          : incidentId // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      similarity: null == similarity
          ? _self.similarity
          : similarity // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

IncidentPatternData _$IncidentPatternDataFromJson(Map<String, dynamic> json) {
  return _IncidentPatterns.fromJson(json);
}

/// @nodoc
mixin _$IncidentPatternData {
  String get organizationId;
  String get timeframe;
  String get analyzedAt;
  FrequencyPatterns get frequencyPatterns;
  List<RecurringIssue> get recurringIssues;
  Trends get trends;
  List<HighRiskArea> get highRiskAreas;
  List<String> get preventiveActions;

  /// Create a copy of IncidentPatternData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $IncidentPatternDataCopyWith<IncidentPatternData> get copyWith =>
      _$IncidentPatternDataCopyWithImpl<IncidentPatternData>(
          this as IncidentPatternData, _$identity);

  /// Serializes this IncidentPatternData to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is IncidentPatternData &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.timeframe, timeframe) ||
                other.timeframe == timeframe) &&
            (identical(other.analyzedAt, analyzedAt) ||
                other.analyzedAt == analyzedAt) &&
            (identical(other.frequencyPatterns, frequencyPatterns) ||
                other.frequencyPatterns == frequencyPatterns) &&
            const DeepCollectionEquality()
                .equals(other.recurringIssues, recurringIssues) &&
            (identical(other.trends, trends) || other.trends == trends) &&
            const DeepCollectionEquality()
                .equals(other.highRiskAreas, highRiskAreas) &&
            const DeepCollectionEquality()
                .equals(other.preventiveActions, preventiveActions));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      organizationId,
      timeframe,
      analyzedAt,
      frequencyPatterns,
      const DeepCollectionEquality().hash(recurringIssues),
      trends,
      const DeepCollectionEquality().hash(highRiskAreas),
      const DeepCollectionEquality().hash(preventiveActions));

  @override
  String toString() {
    return 'IncidentPatternData(organizationId: $organizationId, timeframe: $timeframe, analyzedAt: $analyzedAt, frequencyPatterns: $frequencyPatterns, recurringIssues: $recurringIssues, trends: $trends, highRiskAreas: $highRiskAreas, preventiveActions: $preventiveActions)';
  }
}

/// @nodoc
abstract mixin class $IncidentPatternDataCopyWith<$Res> {
  factory $IncidentPatternDataCopyWith(
          IncidentPatternData value, $Res Function(IncidentPatternData) _then) =
      _$IncidentPatternDataCopyWithImpl;
  @useResult
  $Res call(
      {String organizationId,
      String timeframe,
      String analyzedAt,
      FrequencyPatterns frequencyPatterns,
      List<RecurringIssue> recurringIssues,
      Trends trends,
      List<HighRiskArea> highRiskAreas,
      List<String> preventiveActions});

  $FrequencyPatternsCopyWith<$Res> get frequencyPatterns;
  $TrendsCopyWith<$Res> get trends;
}

/// @nodoc
class _$IncidentPatternDataCopyWithImpl<$Res>
    implements $IncidentPatternDataCopyWith<$Res> {
  _$IncidentPatternDataCopyWithImpl(this._self, this._then);

  final IncidentPatternData _self;
  final $Res Function(IncidentPatternData) _then;

  /// Create a copy of IncidentPatternData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? organizationId = null,
    Object? timeframe = null,
    Object? analyzedAt = null,
    Object? frequencyPatterns = null,
    Object? recurringIssues = null,
    Object? trends = null,
    Object? highRiskAreas = null,
    Object? preventiveActions = null,
  }) {
    return _then(_self.copyWith(
      organizationId: null == organizationId
          ? _self.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      timeframe: null == timeframe
          ? _self.timeframe
          : timeframe // ignore: cast_nullable_to_non_nullable
              as String,
      analyzedAt: null == analyzedAt
          ? _self.analyzedAt
          : analyzedAt // ignore: cast_nullable_to_non_nullable
              as String,
      frequencyPatterns: null == frequencyPatterns
          ? _self.frequencyPatterns
          : frequencyPatterns // ignore: cast_nullable_to_non_nullable
              as FrequencyPatterns,
      recurringIssues: null == recurringIssues
          ? _self.recurringIssues
          : recurringIssues // ignore: cast_nullable_to_non_nullable
              as List<RecurringIssue>,
      trends: null == trends
          ? _self.trends
          : trends // ignore: cast_nullable_to_non_nullable
              as Trends,
      highRiskAreas: null == highRiskAreas
          ? _self.highRiskAreas
          : highRiskAreas // ignore: cast_nullable_to_non_nullable
              as List<HighRiskArea>,
      preventiveActions: null == preventiveActions
          ? _self.preventiveActions
          : preventiveActions // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }

  /// Create a copy of IncidentPatternData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FrequencyPatternsCopyWith<$Res> get frequencyPatterns {
    return $FrequencyPatternsCopyWith<$Res>(_self.frequencyPatterns, (value) {
      return _then(_self.copyWith(frequencyPatterns: value));
    });
  }

  /// Create a copy of IncidentPatternData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TrendsCopyWith<$Res> get trends {
    return $TrendsCopyWith<$Res>(_self.trends, (value) {
      return _then(_self.copyWith(trends: value));
    });
  }
}

/// Adds pattern-matching-related methods to [IncidentPatternData].
extension IncidentPatternDataPatterns on IncidentPatternData {
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
    TResult Function(_IncidentPatterns value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _IncidentPatterns() when $default != null:
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
    TResult Function(_IncidentPatterns value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _IncidentPatterns():
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
    TResult? Function(_IncidentPatterns value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _IncidentPatterns() when $default != null:
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
            String timeframe,
            String analyzedAt,
            FrequencyPatterns frequencyPatterns,
            List<RecurringIssue> recurringIssues,
            Trends trends,
            List<HighRiskArea> highRiskAreas,
            List<String> preventiveActions)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _IncidentPatterns() when $default != null:
        return $default(
            _that.organizationId,
            _that.timeframe,
            _that.analyzedAt,
            _that.frequencyPatterns,
            _that.recurringIssues,
            _that.trends,
            _that.highRiskAreas,
            _that.preventiveActions);
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
            String timeframe,
            String analyzedAt,
            FrequencyPatterns frequencyPatterns,
            List<RecurringIssue> recurringIssues,
            Trends trends,
            List<HighRiskArea> highRiskAreas,
            List<String> preventiveActions)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _IncidentPatterns():
        return $default(
            _that.organizationId,
            _that.timeframe,
            _that.analyzedAt,
            _that.frequencyPatterns,
            _that.recurringIssues,
            _that.trends,
            _that.highRiskAreas,
            _that.preventiveActions);
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
            String timeframe,
            String analyzedAt,
            FrequencyPatterns frequencyPatterns,
            List<RecurringIssue> recurringIssues,
            Trends trends,
            List<HighRiskArea> highRiskAreas,
            List<String> preventiveActions)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _IncidentPatterns() when $default != null:
        return $default(
            _that.organizationId,
            _that.timeframe,
            _that.analyzedAt,
            _that.frequencyPatterns,
            _that.recurringIssues,
            _that.trends,
            _that.highRiskAreas,
            _that.preventiveActions);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _IncidentPatterns implements IncidentPatternData {
  const _IncidentPatterns(
      {required this.organizationId,
      required this.timeframe,
      required this.analyzedAt,
      required this.frequencyPatterns,
      required final List<RecurringIssue> recurringIssues,
      required this.trends,
      required final List<HighRiskArea> highRiskAreas,
      required final List<String> preventiveActions})
      : _recurringIssues = recurringIssues,
        _highRiskAreas = highRiskAreas,
        _preventiveActions = preventiveActions;
  factory _IncidentPatterns.fromJson(Map<String, dynamic> json) =>
      _$IncidentPatternsFromJson(json);

  @override
  final String organizationId;
  @override
  final String timeframe;
  @override
  final String analyzedAt;
  @override
  final FrequencyPatterns frequencyPatterns;
  final List<RecurringIssue> _recurringIssues;
  @override
  List<RecurringIssue> get recurringIssues {
    if (_recurringIssues is EqualUnmodifiableListView) return _recurringIssues;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recurringIssues);
  }

  @override
  final Trends trends;
  final List<HighRiskArea> _highRiskAreas;
  @override
  List<HighRiskArea> get highRiskAreas {
    if (_highRiskAreas is EqualUnmodifiableListView) return _highRiskAreas;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_highRiskAreas);
  }

  final List<String> _preventiveActions;
  @override
  List<String> get preventiveActions {
    if (_preventiveActions is EqualUnmodifiableListView)
      return _preventiveActions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_preventiveActions);
  }

  /// Create a copy of IncidentPatternData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$IncidentPatternsCopyWith<_IncidentPatterns> get copyWith =>
      __$IncidentPatternsCopyWithImpl<_IncidentPatterns>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$IncidentPatternsToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _IncidentPatterns &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.timeframe, timeframe) ||
                other.timeframe == timeframe) &&
            (identical(other.analyzedAt, analyzedAt) ||
                other.analyzedAt == analyzedAt) &&
            (identical(other.frequencyPatterns, frequencyPatterns) ||
                other.frequencyPatterns == frequencyPatterns) &&
            const DeepCollectionEquality()
                .equals(other._recurringIssues, _recurringIssues) &&
            (identical(other.trends, trends) || other.trends == trends) &&
            const DeepCollectionEquality()
                .equals(other._highRiskAreas, _highRiskAreas) &&
            const DeepCollectionEquality()
                .equals(other._preventiveActions, _preventiveActions));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      organizationId,
      timeframe,
      analyzedAt,
      frequencyPatterns,
      const DeepCollectionEquality().hash(_recurringIssues),
      trends,
      const DeepCollectionEquality().hash(_highRiskAreas),
      const DeepCollectionEquality().hash(_preventiveActions));

  @override
  String toString() {
    return 'IncidentPatternData(organizationId: $organizationId, timeframe: $timeframe, analyzedAt: $analyzedAt, frequencyPatterns: $frequencyPatterns, recurringIssues: $recurringIssues, trends: $trends, highRiskAreas: $highRiskAreas, preventiveActions: $preventiveActions)';
  }
}

/// @nodoc
abstract mixin class _$IncidentPatternsCopyWith<$Res>
    implements $IncidentPatternDataCopyWith<$Res> {
  factory _$IncidentPatternsCopyWith(
          _IncidentPatterns value, $Res Function(_IncidentPatterns) _then) =
      __$IncidentPatternsCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String organizationId,
      String timeframe,
      String analyzedAt,
      FrequencyPatterns frequencyPatterns,
      List<RecurringIssue> recurringIssues,
      Trends trends,
      List<HighRiskArea> highRiskAreas,
      List<String> preventiveActions});

  @override
  $FrequencyPatternsCopyWith<$Res> get frequencyPatterns;
  @override
  $TrendsCopyWith<$Res> get trends;
}

/// @nodoc
class __$IncidentPatternsCopyWithImpl<$Res>
    implements _$IncidentPatternsCopyWith<$Res> {
  __$IncidentPatternsCopyWithImpl(this._self, this._then);

  final _IncidentPatterns _self;
  final $Res Function(_IncidentPatterns) _then;

  /// Create a copy of IncidentPatternData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? organizationId = null,
    Object? timeframe = null,
    Object? analyzedAt = null,
    Object? frequencyPatterns = null,
    Object? recurringIssues = null,
    Object? trends = null,
    Object? highRiskAreas = null,
    Object? preventiveActions = null,
  }) {
    return _then(_IncidentPatterns(
      organizationId: null == organizationId
          ? _self.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      timeframe: null == timeframe
          ? _self.timeframe
          : timeframe // ignore: cast_nullable_to_non_nullable
              as String,
      analyzedAt: null == analyzedAt
          ? _self.analyzedAt
          : analyzedAt // ignore: cast_nullable_to_non_nullable
              as String,
      frequencyPatterns: null == frequencyPatterns
          ? _self.frequencyPatterns
          : frequencyPatterns // ignore: cast_nullable_to_non_nullable
              as FrequencyPatterns,
      recurringIssues: null == recurringIssues
          ? _self._recurringIssues
          : recurringIssues // ignore: cast_nullable_to_non_nullable
              as List<RecurringIssue>,
      trends: null == trends
          ? _self.trends
          : trends // ignore: cast_nullable_to_non_nullable
              as Trends,
      highRiskAreas: null == highRiskAreas
          ? _self._highRiskAreas
          : highRiskAreas // ignore: cast_nullable_to_non_nullable
              as List<HighRiskArea>,
      preventiveActions: null == preventiveActions
          ? _self._preventiveActions
          : preventiveActions // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }

  /// Create a copy of IncidentPatternData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FrequencyPatternsCopyWith<$Res> get frequencyPatterns {
    return $FrequencyPatternsCopyWith<$Res>(_self.frequencyPatterns, (value) {
      return _then(_self.copyWith(frequencyPatterns: value));
    });
  }

  /// Create a copy of IncidentPatternData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TrendsCopyWith<$Res> get trends {
    return $TrendsCopyWith<$Res>(_self.trends, (value) {
      return _then(_self.copyWith(trends: value));
    });
  }
}

/// @nodoc
mixin _$FrequencyPatterns {
  Map<String, int> get byType;
  Map<String, int> get byLocation;
  Map<String, int> get byTimeOfDay;
  Map<String, int> get byDayOfWeek;

  /// Create a copy of FrequencyPatterns
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $FrequencyPatternsCopyWith<FrequencyPatterns> get copyWith =>
      _$FrequencyPatternsCopyWithImpl<FrequencyPatterns>(
          this as FrequencyPatterns, _$identity);

  /// Serializes this FrequencyPatterns to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is FrequencyPatterns &&
            const DeepCollectionEquality().equals(other.byType, byType) &&
            const DeepCollectionEquality()
                .equals(other.byLocation, byLocation) &&
            const DeepCollectionEquality()
                .equals(other.byTimeOfDay, byTimeOfDay) &&
            const DeepCollectionEquality()
                .equals(other.byDayOfWeek, byDayOfWeek));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(byType),
      const DeepCollectionEquality().hash(byLocation),
      const DeepCollectionEquality().hash(byTimeOfDay),
      const DeepCollectionEquality().hash(byDayOfWeek));

  @override
  String toString() {
    return 'FrequencyPatterns(byType: $byType, byLocation: $byLocation, byTimeOfDay: $byTimeOfDay, byDayOfWeek: $byDayOfWeek)';
  }
}

/// @nodoc
abstract mixin class $FrequencyPatternsCopyWith<$Res> {
  factory $FrequencyPatternsCopyWith(
          FrequencyPatterns value, $Res Function(FrequencyPatterns) _then) =
      _$FrequencyPatternsCopyWithImpl;
  @useResult
  $Res call(
      {Map<String, int> byType,
      Map<String, int> byLocation,
      Map<String, int> byTimeOfDay,
      Map<String, int> byDayOfWeek});
}

/// @nodoc
class _$FrequencyPatternsCopyWithImpl<$Res>
    implements $FrequencyPatternsCopyWith<$Res> {
  _$FrequencyPatternsCopyWithImpl(this._self, this._then);

  final FrequencyPatterns _self;
  final $Res Function(FrequencyPatterns) _then;

  /// Create a copy of FrequencyPatterns
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? byType = null,
    Object? byLocation = null,
    Object? byTimeOfDay = null,
    Object? byDayOfWeek = null,
  }) {
    return _then(_self.copyWith(
      byType: null == byType
          ? _self.byType
          : byType // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      byLocation: null == byLocation
          ? _self.byLocation
          : byLocation // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      byTimeOfDay: null == byTimeOfDay
          ? _self.byTimeOfDay
          : byTimeOfDay // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      byDayOfWeek: null == byDayOfWeek
          ? _self.byDayOfWeek
          : byDayOfWeek // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
    ));
  }
}

/// Adds pattern-matching-related methods to [FrequencyPatterns].
extension FrequencyPatternsPatterns on FrequencyPatterns {
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
    TResult Function(_FrequencyPatterns value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _FrequencyPatterns() when $default != null:
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
    TResult Function(_FrequencyPatterns value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FrequencyPatterns():
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
    TResult? Function(_FrequencyPatterns value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FrequencyPatterns() when $default != null:
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
    TResult Function(Map<String, int> byType, Map<String, int> byLocation,
            Map<String, int> byTimeOfDay, Map<String, int> byDayOfWeek)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _FrequencyPatterns() when $default != null:
        return $default(_that.byType, _that.byLocation, _that.byTimeOfDay,
            _that.byDayOfWeek);
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
    TResult Function(Map<String, int> byType, Map<String, int> byLocation,
            Map<String, int> byTimeOfDay, Map<String, int> byDayOfWeek)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FrequencyPatterns():
        return $default(_that.byType, _that.byLocation, _that.byTimeOfDay,
            _that.byDayOfWeek);
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
    TResult? Function(Map<String, int> byType, Map<String, int> byLocation,
            Map<String, int> byTimeOfDay, Map<String, int> byDayOfWeek)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FrequencyPatterns() when $default != null:
        return $default(_that.byType, _that.byLocation, _that.byTimeOfDay,
            _that.byDayOfWeek);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _FrequencyPatterns implements FrequencyPatterns {
  const _FrequencyPatterns(
      {required final Map<String, int> byType,
      required final Map<String, int> byLocation,
      required final Map<String, int> byTimeOfDay,
      required final Map<String, int> byDayOfWeek})
      : _byType = byType,
        _byLocation = byLocation,
        _byTimeOfDay = byTimeOfDay,
        _byDayOfWeek = byDayOfWeek;
  factory _FrequencyPatterns.fromJson(Map<String, dynamic> json) =>
      _$FrequencyPatternsFromJson(json);

  final Map<String, int> _byType;
  @override
  Map<String, int> get byType {
    if (_byType is EqualUnmodifiableMapView) return _byType;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_byType);
  }

  final Map<String, int> _byLocation;
  @override
  Map<String, int> get byLocation {
    if (_byLocation is EqualUnmodifiableMapView) return _byLocation;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_byLocation);
  }

  final Map<String, int> _byTimeOfDay;
  @override
  Map<String, int> get byTimeOfDay {
    if (_byTimeOfDay is EqualUnmodifiableMapView) return _byTimeOfDay;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_byTimeOfDay);
  }

  final Map<String, int> _byDayOfWeek;
  @override
  Map<String, int> get byDayOfWeek {
    if (_byDayOfWeek is EqualUnmodifiableMapView) return _byDayOfWeek;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_byDayOfWeek);
  }

  /// Create a copy of FrequencyPatterns
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$FrequencyPatternsCopyWith<_FrequencyPatterns> get copyWith =>
      __$FrequencyPatternsCopyWithImpl<_FrequencyPatterns>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$FrequencyPatternsToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _FrequencyPatterns &&
            const DeepCollectionEquality().equals(other._byType, _byType) &&
            const DeepCollectionEquality()
                .equals(other._byLocation, _byLocation) &&
            const DeepCollectionEquality()
                .equals(other._byTimeOfDay, _byTimeOfDay) &&
            const DeepCollectionEquality()
                .equals(other._byDayOfWeek, _byDayOfWeek));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_byType),
      const DeepCollectionEquality().hash(_byLocation),
      const DeepCollectionEquality().hash(_byTimeOfDay),
      const DeepCollectionEquality().hash(_byDayOfWeek));

  @override
  String toString() {
    return 'FrequencyPatterns(byType: $byType, byLocation: $byLocation, byTimeOfDay: $byTimeOfDay, byDayOfWeek: $byDayOfWeek)';
  }
}

/// @nodoc
abstract mixin class _$FrequencyPatternsCopyWith<$Res>
    implements $FrequencyPatternsCopyWith<$Res> {
  factory _$FrequencyPatternsCopyWith(
          _FrequencyPatterns value, $Res Function(_FrequencyPatterns) _then) =
      __$FrequencyPatternsCopyWithImpl;
  @override
  @useResult
  $Res call(
      {Map<String, int> byType,
      Map<String, int> byLocation,
      Map<String, int> byTimeOfDay,
      Map<String, int> byDayOfWeek});
}

/// @nodoc
class __$FrequencyPatternsCopyWithImpl<$Res>
    implements _$FrequencyPatternsCopyWith<$Res> {
  __$FrequencyPatternsCopyWithImpl(this._self, this._then);

  final _FrequencyPatterns _self;
  final $Res Function(_FrequencyPatterns) _then;

  /// Create a copy of FrequencyPatterns
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? byType = null,
    Object? byLocation = null,
    Object? byTimeOfDay = null,
    Object? byDayOfWeek = null,
  }) {
    return _then(_FrequencyPatterns(
      byType: null == byType
          ? _self._byType
          : byType // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      byLocation: null == byLocation
          ? _self._byLocation
          : byLocation // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      byTimeOfDay: null == byTimeOfDay
          ? _self._byTimeOfDay
          : byTimeOfDay // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      byDayOfWeek: null == byDayOfWeek
          ? _self._byDayOfWeek
          : byDayOfWeek // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
    ));
  }
}

/// @nodoc
mixin _$RecurringIssue {
  String get issue;
  int get frequency;
  String get trend;

  /// Create a copy of RecurringIssue
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RecurringIssueCopyWith<RecurringIssue> get copyWith =>
      _$RecurringIssueCopyWithImpl<RecurringIssue>(
          this as RecurringIssue, _$identity);

  /// Serializes this RecurringIssue to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RecurringIssue &&
            (identical(other.issue, issue) || other.issue == issue) &&
            (identical(other.frequency, frequency) ||
                other.frequency == frequency) &&
            (identical(other.trend, trend) || other.trend == trend));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, issue, frequency, trend);

  @override
  String toString() {
    return 'RecurringIssue(issue: $issue, frequency: $frequency, trend: $trend)';
  }
}

/// @nodoc
abstract mixin class $RecurringIssueCopyWith<$Res> {
  factory $RecurringIssueCopyWith(
          RecurringIssue value, $Res Function(RecurringIssue) _then) =
      _$RecurringIssueCopyWithImpl;
  @useResult
  $Res call({String issue, int frequency, String trend});
}

/// @nodoc
class _$RecurringIssueCopyWithImpl<$Res>
    implements $RecurringIssueCopyWith<$Res> {
  _$RecurringIssueCopyWithImpl(this._self, this._then);

  final RecurringIssue _self;
  final $Res Function(RecurringIssue) _then;

  /// Create a copy of RecurringIssue
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? issue = null,
    Object? frequency = null,
    Object? trend = null,
  }) {
    return _then(_self.copyWith(
      issue: null == issue
          ? _self.issue
          : issue // ignore: cast_nullable_to_non_nullable
              as String,
      frequency: null == frequency
          ? _self.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as int,
      trend: null == trend
          ? _self.trend
          : trend // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [RecurringIssue].
extension RecurringIssuePatterns on RecurringIssue {
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
    TResult Function(_RecurringIssue value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RecurringIssue() when $default != null:
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
    TResult Function(_RecurringIssue value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RecurringIssue():
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
    TResult? Function(_RecurringIssue value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RecurringIssue() when $default != null:
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
    TResult Function(String issue, int frequency, String trend)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RecurringIssue() when $default != null:
        return $default(_that.issue, _that.frequency, _that.trend);
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
    TResult Function(String issue, int frequency, String trend) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RecurringIssue():
        return $default(_that.issue, _that.frequency, _that.trend);
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
    TResult? Function(String issue, int frequency, String trend)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RecurringIssue() when $default != null:
        return $default(_that.issue, _that.frequency, _that.trend);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _RecurringIssue implements RecurringIssue {
  const _RecurringIssue(
      {required this.issue, required this.frequency, required this.trend});
  factory _RecurringIssue.fromJson(Map<String, dynamic> json) =>
      _$RecurringIssueFromJson(json);

  @override
  final String issue;
  @override
  final int frequency;
  @override
  final String trend;

  /// Create a copy of RecurringIssue
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RecurringIssueCopyWith<_RecurringIssue> get copyWith =>
      __$RecurringIssueCopyWithImpl<_RecurringIssue>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$RecurringIssueToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RecurringIssue &&
            (identical(other.issue, issue) || other.issue == issue) &&
            (identical(other.frequency, frequency) ||
                other.frequency == frequency) &&
            (identical(other.trend, trend) || other.trend == trend));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, issue, frequency, trend);

  @override
  String toString() {
    return 'RecurringIssue(issue: $issue, frequency: $frequency, trend: $trend)';
  }
}

/// @nodoc
abstract mixin class _$RecurringIssueCopyWith<$Res>
    implements $RecurringIssueCopyWith<$Res> {
  factory _$RecurringIssueCopyWith(
          _RecurringIssue value, $Res Function(_RecurringIssue) _then) =
      __$RecurringIssueCopyWithImpl;
  @override
  @useResult
  $Res call({String issue, int frequency, String trend});
}

/// @nodoc
class __$RecurringIssueCopyWithImpl<$Res>
    implements _$RecurringIssueCopyWith<$Res> {
  __$RecurringIssueCopyWithImpl(this._self, this._then);

  final _RecurringIssue _self;
  final $Res Function(_RecurringIssue) _then;

  /// Create a copy of RecurringIssue
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? issue = null,
    Object? frequency = null,
    Object? trend = null,
  }) {
    return _then(_RecurringIssue(
      issue: null == issue
          ? _self.issue
          : issue // ignore: cast_nullable_to_non_nullable
              as String,
      frequency: null == frequency
          ? _self.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as int,
      trend: null == trend
          ? _self.trend
          : trend // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$Trends {
  String get direction;
  int get changePercentage;
  String get significance;

  /// Create a copy of Trends
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TrendsCopyWith<Trends> get copyWith =>
      _$TrendsCopyWithImpl<Trends>(this as Trends, _$identity);

  /// Serializes this Trends to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Trends &&
            (identical(other.direction, direction) ||
                other.direction == direction) &&
            (identical(other.changePercentage, changePercentage) ||
                other.changePercentage == changePercentage) &&
            (identical(other.significance, significance) ||
                other.significance == significance));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, direction, changePercentage, significance);

  @override
  String toString() {
    return 'Trends(direction: $direction, changePercentage: $changePercentage, significance: $significance)';
  }
}

/// @nodoc
abstract mixin class $TrendsCopyWith<$Res> {
  factory $TrendsCopyWith(Trends value, $Res Function(Trends) _then) =
      _$TrendsCopyWithImpl;
  @useResult
  $Res call({String direction, int changePercentage, String significance});
}

/// @nodoc
class _$TrendsCopyWithImpl<$Res> implements $TrendsCopyWith<$Res> {
  _$TrendsCopyWithImpl(this._self, this._then);

  final Trends _self;
  final $Res Function(Trends) _then;

  /// Create a copy of Trends
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? direction = null,
    Object? changePercentage = null,
    Object? significance = null,
  }) {
    return _then(_self.copyWith(
      direction: null == direction
          ? _self.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as String,
      changePercentage: null == changePercentage
          ? _self.changePercentage
          : changePercentage // ignore: cast_nullable_to_non_nullable
              as int,
      significance: null == significance
          ? _self.significance
          : significance // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [Trends].
extension TrendsPatterns on Trends {
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
    TResult Function(_Trends value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Trends() when $default != null:
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
    TResult Function(_Trends value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Trends():
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
    TResult? Function(_Trends value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Trends() when $default != null:
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
            String direction, int changePercentage, String significance)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Trends() when $default != null:
        return $default(
            _that.direction, _that.changePercentage, _that.significance);
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
            String direction, int changePercentage, String significance)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Trends():
        return $default(
            _that.direction, _that.changePercentage, _that.significance);
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
            String direction, int changePercentage, String significance)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Trends() when $default != null:
        return $default(
            _that.direction, _that.changePercentage, _that.significance);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Trends implements Trends {
  const _Trends(
      {required this.direction,
      required this.changePercentage,
      required this.significance});
  factory _Trends.fromJson(Map<String, dynamic> json) => _$TrendsFromJson(json);

  @override
  final String direction;
  @override
  final int changePercentage;
  @override
  final String significance;

  /// Create a copy of Trends
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TrendsCopyWith<_Trends> get copyWith =>
      __$TrendsCopyWithImpl<_Trends>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TrendsToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Trends &&
            (identical(other.direction, direction) ||
                other.direction == direction) &&
            (identical(other.changePercentage, changePercentage) ||
                other.changePercentage == changePercentage) &&
            (identical(other.significance, significance) ||
                other.significance == significance));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, direction, changePercentage, significance);

  @override
  String toString() {
    return 'Trends(direction: $direction, changePercentage: $changePercentage, significance: $significance)';
  }
}

/// @nodoc
abstract mixin class _$TrendsCopyWith<$Res> implements $TrendsCopyWith<$Res> {
  factory _$TrendsCopyWith(_Trends value, $Res Function(_Trends) _then) =
      __$TrendsCopyWithImpl;
  @override
  @useResult
  $Res call({String direction, int changePercentage, String significance});
}

/// @nodoc
class __$TrendsCopyWithImpl<$Res> implements _$TrendsCopyWith<$Res> {
  __$TrendsCopyWithImpl(this._self, this._then);

  final _Trends _self;
  final $Res Function(_Trends) _then;

  /// Create a copy of Trends
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? direction = null,
    Object? changePercentage = null,
    Object? significance = null,
  }) {
    return _then(_Trends(
      direction: null == direction
          ? _self.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as String,
      changePercentage: null == changePercentage
          ? _self.changePercentage
          : changePercentage // ignore: cast_nullable_to_non_nullable
              as int,
      significance: null == significance
          ? _self.significance
          : significance // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$HighRiskArea {
  String get area;
  String get riskLevel;

  /// Create a copy of HighRiskArea
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $HighRiskAreaCopyWith<HighRiskArea> get copyWith =>
      _$HighRiskAreaCopyWithImpl<HighRiskArea>(
          this as HighRiskArea, _$identity);

  /// Serializes this HighRiskArea to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is HighRiskArea &&
            (identical(other.area, area) || other.area == area) &&
            (identical(other.riskLevel, riskLevel) ||
                other.riskLevel == riskLevel));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, area, riskLevel);

  @override
  String toString() {
    return 'HighRiskArea(area: $area, riskLevel: $riskLevel)';
  }
}

/// @nodoc
abstract mixin class $HighRiskAreaCopyWith<$Res> {
  factory $HighRiskAreaCopyWith(
          HighRiskArea value, $Res Function(HighRiskArea) _then) =
      _$HighRiskAreaCopyWithImpl;
  @useResult
  $Res call({String area, String riskLevel});
}

/// @nodoc
class _$HighRiskAreaCopyWithImpl<$Res> implements $HighRiskAreaCopyWith<$Res> {
  _$HighRiskAreaCopyWithImpl(this._self, this._then);

  final HighRiskArea _self;
  final $Res Function(HighRiskArea) _then;

  /// Create a copy of HighRiskArea
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? area = null,
    Object? riskLevel = null,
  }) {
    return _then(_self.copyWith(
      area: null == area
          ? _self.area
          : area // ignore: cast_nullable_to_non_nullable
              as String,
      riskLevel: null == riskLevel
          ? _self.riskLevel
          : riskLevel // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [HighRiskArea].
extension HighRiskAreaPatterns on HighRiskArea {
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
    TResult Function(_HighRiskArea value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _HighRiskArea() when $default != null:
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
    TResult Function(_HighRiskArea value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HighRiskArea():
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
    TResult? Function(_HighRiskArea value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HighRiskArea() when $default != null:
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
    TResult Function(String area, String riskLevel)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _HighRiskArea() when $default != null:
        return $default(_that.area, _that.riskLevel);
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
    TResult Function(String area, String riskLevel) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HighRiskArea():
        return $default(_that.area, _that.riskLevel);
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
    TResult? Function(String area, String riskLevel)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HighRiskArea() when $default != null:
        return $default(_that.area, _that.riskLevel);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _HighRiskArea implements HighRiskArea {
  const _HighRiskArea({required this.area, required this.riskLevel});
  factory _HighRiskArea.fromJson(Map<String, dynamic> json) =>
      _$HighRiskAreaFromJson(json);

  @override
  final String area;
  @override
  final String riskLevel;

  /// Create a copy of HighRiskArea
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$HighRiskAreaCopyWith<_HighRiskArea> get copyWith =>
      __$HighRiskAreaCopyWithImpl<_HighRiskArea>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$HighRiskAreaToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _HighRiskArea &&
            (identical(other.area, area) || other.area == area) &&
            (identical(other.riskLevel, riskLevel) ||
                other.riskLevel == riskLevel));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, area, riskLevel);

  @override
  String toString() {
    return 'HighRiskArea(area: $area, riskLevel: $riskLevel)';
  }
}

/// @nodoc
abstract mixin class _$HighRiskAreaCopyWith<$Res>
    implements $HighRiskAreaCopyWith<$Res> {
  factory _$HighRiskAreaCopyWith(
          _HighRiskArea value, $Res Function(_HighRiskArea) _then) =
      __$HighRiskAreaCopyWithImpl;
  @override
  @useResult
  $Res call({String area, String riskLevel});
}

/// @nodoc
class __$HighRiskAreaCopyWithImpl<$Res>
    implements _$HighRiskAreaCopyWith<$Res> {
  __$HighRiskAreaCopyWithImpl(this._self, this._then);

  final _HighRiskArea _self;
  final $Res Function(_HighRiskArea) _then;

  /// Create a copy of HighRiskArea
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? area = null,
    Object? riskLevel = null,
  }) {
    return _then(_HighRiskArea(
      area: null == area
          ? _self.area
          : area // ignore: cast_nullable_to_non_nullable
              as String,
      riskLevel: null == riskLevel
          ? _self.riskLevel
          : riskLevel // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$DrugInteraction {
  List<String> get medications;
  String get severity;
  String get description;
  String get recommendation;
  List<String> get references;

  /// Create a copy of DrugInteraction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DrugInteractionCopyWith<DrugInteraction> get copyWith =>
      _$DrugInteractionCopyWithImpl<DrugInteraction>(
          this as DrugInteraction, _$identity);

  /// Serializes this DrugInteraction to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DrugInteraction &&
            const DeepCollectionEquality()
                .equals(other.medications, medications) &&
            (identical(other.severity, severity) ||
                other.severity == severity) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.recommendation, recommendation) ||
                other.recommendation == recommendation) &&
            const DeepCollectionEquality()
                .equals(other.references, references));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(medications),
      severity,
      description,
      recommendation,
      const DeepCollectionEquality().hash(references));

  @override
  String toString() {
    return 'DrugInteraction(medications: $medications, severity: $severity, description: $description, recommendation: $recommendation, references: $references)';
  }
}

/// @nodoc
abstract mixin class $DrugInteractionCopyWith<$Res> {
  factory $DrugInteractionCopyWith(
          DrugInteraction value, $Res Function(DrugInteraction) _then) =
      _$DrugInteractionCopyWithImpl;
  @useResult
  $Res call(
      {List<String> medications,
      String severity,
      String description,
      String recommendation,
      List<String> references});
}

/// @nodoc
class _$DrugInteractionCopyWithImpl<$Res>
    implements $DrugInteractionCopyWith<$Res> {
  _$DrugInteractionCopyWithImpl(this._self, this._then);

  final DrugInteraction _self;
  final $Res Function(DrugInteraction) _then;

  /// Create a copy of DrugInteraction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? medications = null,
    Object? severity = null,
    Object? description = null,
    Object? recommendation = null,
    Object? references = null,
  }) {
    return _then(_self.copyWith(
      medications: null == medications
          ? _self.medications
          : medications // ignore: cast_nullable_to_non_nullable
              as List<String>,
      severity: null == severity
          ? _self.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      recommendation: null == recommendation
          ? _self.recommendation
          : recommendation // ignore: cast_nullable_to_non_nullable
              as String,
      references: null == references
          ? _self.references
          : references // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// Adds pattern-matching-related methods to [DrugInteraction].
extension DrugInteractionPatterns on DrugInteraction {
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
    TResult Function(_DrugInteraction value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DrugInteraction() when $default != null:
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
    TResult Function(_DrugInteraction value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DrugInteraction():
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
    TResult? Function(_DrugInteraction value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DrugInteraction() when $default != null:
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
    TResult Function(List<String> medications, String severity,
            String description, String recommendation, List<String> references)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DrugInteraction() when $default != null:
        return $default(_that.medications, _that.severity, _that.description,
            _that.recommendation, _that.references);
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
    TResult Function(List<String> medications, String severity,
            String description, String recommendation, List<String> references)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DrugInteraction():
        return $default(_that.medications, _that.severity, _that.description,
            _that.recommendation, _that.references);
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
    TResult? Function(List<String> medications, String severity,
            String description, String recommendation, List<String> references)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DrugInteraction() when $default != null:
        return $default(_that.medications, _that.severity, _that.description,
            _that.recommendation, _that.references);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _DrugInteraction implements DrugInteraction {
  const _DrugInteraction(
      {required final List<String> medications,
      required this.severity,
      required this.description,
      required this.recommendation,
      required final List<String> references})
      : _medications = medications,
        _references = references;
  factory _DrugInteraction.fromJson(Map<String, dynamic> json) =>
      _$DrugInteractionFromJson(json);

  final List<String> _medications;
  @override
  List<String> get medications {
    if (_medications is EqualUnmodifiableListView) return _medications;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_medications);
  }

  @override
  final String severity;
  @override
  final String description;
  @override
  final String recommendation;
  final List<String> _references;
  @override
  List<String> get references {
    if (_references is EqualUnmodifiableListView) return _references;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_references);
  }

  /// Create a copy of DrugInteraction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DrugInteractionCopyWith<_DrugInteraction> get copyWith =>
      __$DrugInteractionCopyWithImpl<_DrugInteraction>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$DrugInteractionToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DrugInteraction &&
            const DeepCollectionEquality()
                .equals(other._medications, _medications) &&
            (identical(other.severity, severity) ||
                other.severity == severity) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.recommendation, recommendation) ||
                other.recommendation == recommendation) &&
            const DeepCollectionEquality()
                .equals(other._references, _references));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_medications),
      severity,
      description,
      recommendation,
      const DeepCollectionEquality().hash(_references));

  @override
  String toString() {
    return 'DrugInteraction(medications: $medications, severity: $severity, description: $description, recommendation: $recommendation, references: $references)';
  }
}

/// @nodoc
abstract mixin class _$DrugInteractionCopyWith<$Res>
    implements $DrugInteractionCopyWith<$Res> {
  factory _$DrugInteractionCopyWith(
          _DrugInteraction value, $Res Function(_DrugInteraction) _then) =
      __$DrugInteractionCopyWithImpl;
  @override
  @useResult
  $Res call(
      {List<String> medications,
      String severity,
      String description,
      String recommendation,
      List<String> references});
}

/// @nodoc
class __$DrugInteractionCopyWithImpl<$Res>
    implements _$DrugInteractionCopyWith<$Res> {
  __$DrugInteractionCopyWithImpl(this._self, this._then);

  final _DrugInteraction _self;
  final $Res Function(_DrugInteraction) _then;

  /// Create a copy of DrugInteraction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? medications = null,
    Object? severity = null,
    Object? description = null,
    Object? recommendation = null,
    Object? references = null,
  }) {
    return _then(_DrugInteraction(
      medications: null == medications
          ? _self._medications
          : medications // ignore: cast_nullable_to_non_nullable
              as List<String>,
      severity: null == severity
          ? _self.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      recommendation: null == recommendation
          ? _self.recommendation
          : recommendation // ignore: cast_nullable_to_non_nullable
              as String,
      references: null == references
          ? _self._references
          : references // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
mixin _$MedicationCompliance {
  String get clientId;
  String get period;
  String get analyzedAt;
  double get overallCompliance;
  List<MedicationComplianceDetail> get byMedication;
  CompliancePatterns get patterns;
  ComplianceRiskAssessment get riskAssessment;

  /// Create a copy of MedicationCompliance
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MedicationComplianceCopyWith<MedicationCompliance> get copyWith =>
      _$MedicationComplianceCopyWithImpl<MedicationCompliance>(
          this as MedicationCompliance, _$identity);

  /// Serializes this MedicationCompliance to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MedicationCompliance &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.period, period) || other.period == period) &&
            (identical(other.analyzedAt, analyzedAt) ||
                other.analyzedAt == analyzedAt) &&
            (identical(other.overallCompliance, overallCompliance) ||
                other.overallCompliance == overallCompliance) &&
            const DeepCollectionEquality()
                .equals(other.byMedication, byMedication) &&
            (identical(other.patterns, patterns) ||
                other.patterns == patterns) &&
            (identical(other.riskAssessment, riskAssessment) ||
                other.riskAssessment == riskAssessment));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      clientId,
      period,
      analyzedAt,
      overallCompliance,
      const DeepCollectionEquality().hash(byMedication),
      patterns,
      riskAssessment);

  @override
  String toString() {
    return 'MedicationCompliance(clientId: $clientId, period: $period, analyzedAt: $analyzedAt, overallCompliance: $overallCompliance, byMedication: $byMedication, patterns: $patterns, riskAssessment: $riskAssessment)';
  }
}

/// @nodoc
abstract mixin class $MedicationComplianceCopyWith<$Res> {
  factory $MedicationComplianceCopyWith(MedicationCompliance value,
          $Res Function(MedicationCompliance) _then) =
      _$MedicationComplianceCopyWithImpl;
  @useResult
  $Res call(
      {String clientId,
      String period,
      String analyzedAt,
      double overallCompliance,
      List<MedicationComplianceDetail> byMedication,
      CompliancePatterns patterns,
      ComplianceRiskAssessment riskAssessment});

  $CompliancePatternsCopyWith<$Res> get patterns;
  $ComplianceRiskAssessmentCopyWith<$Res> get riskAssessment;
}

/// @nodoc
class _$MedicationComplianceCopyWithImpl<$Res>
    implements $MedicationComplianceCopyWith<$Res> {
  _$MedicationComplianceCopyWithImpl(this._self, this._then);

  final MedicationCompliance _self;
  final $Res Function(MedicationCompliance) _then;

  /// Create a copy of MedicationCompliance
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clientId = null,
    Object? period = null,
    Object? analyzedAt = null,
    Object? overallCompliance = null,
    Object? byMedication = null,
    Object? patterns = null,
    Object? riskAssessment = null,
  }) {
    return _then(_self.copyWith(
      clientId: null == clientId
          ? _self.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      period: null == period
          ? _self.period
          : period // ignore: cast_nullable_to_non_nullable
              as String,
      analyzedAt: null == analyzedAt
          ? _self.analyzedAt
          : analyzedAt // ignore: cast_nullable_to_non_nullable
              as String,
      overallCompliance: null == overallCompliance
          ? _self.overallCompliance
          : overallCompliance // ignore: cast_nullable_to_non_nullable
              as double,
      byMedication: null == byMedication
          ? _self.byMedication
          : byMedication // ignore: cast_nullable_to_non_nullable
              as List<MedicationComplianceDetail>,
      patterns: null == patterns
          ? _self.patterns
          : patterns // ignore: cast_nullable_to_non_nullable
              as CompliancePatterns,
      riskAssessment: null == riskAssessment
          ? _self.riskAssessment
          : riskAssessment // ignore: cast_nullable_to_non_nullable
              as ComplianceRiskAssessment,
    ));
  }

  /// Create a copy of MedicationCompliance
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CompliancePatternsCopyWith<$Res> get patterns {
    return $CompliancePatternsCopyWith<$Res>(_self.patterns, (value) {
      return _then(_self.copyWith(patterns: value));
    });
  }

  /// Create a copy of MedicationCompliance
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ComplianceRiskAssessmentCopyWith<$Res> get riskAssessment {
    return $ComplianceRiskAssessmentCopyWith<$Res>(_self.riskAssessment,
        (value) {
      return _then(_self.copyWith(riskAssessment: value));
    });
  }
}

/// Adds pattern-matching-related methods to [MedicationCompliance].
extension MedicationCompliancePatterns on MedicationCompliance {
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
    TResult Function(_MedicationCompliance value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MedicationCompliance() when $default != null:
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
    TResult Function(_MedicationCompliance value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MedicationCompliance():
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
    TResult? Function(_MedicationCompliance value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MedicationCompliance() when $default != null:
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
            String clientId,
            String period,
            String analyzedAt,
            double overallCompliance,
            List<MedicationComplianceDetail> byMedication,
            CompliancePatterns patterns,
            ComplianceRiskAssessment riskAssessment)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MedicationCompliance() when $default != null:
        return $default(
            _that.clientId,
            _that.period,
            _that.analyzedAt,
            _that.overallCompliance,
            _that.byMedication,
            _that.patterns,
            _that.riskAssessment);
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
            String clientId,
            String period,
            String analyzedAt,
            double overallCompliance,
            List<MedicationComplianceDetail> byMedication,
            CompliancePatterns patterns,
            ComplianceRiskAssessment riskAssessment)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MedicationCompliance():
        return $default(
            _that.clientId,
            _that.period,
            _that.analyzedAt,
            _that.overallCompliance,
            _that.byMedication,
            _that.patterns,
            _that.riskAssessment);
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
            String clientId,
            String period,
            String analyzedAt,
            double overallCompliance,
            List<MedicationComplianceDetail> byMedication,
            CompliancePatterns patterns,
            ComplianceRiskAssessment riskAssessment)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MedicationCompliance() when $default != null:
        return $default(
            _that.clientId,
            _that.period,
            _that.analyzedAt,
            _that.overallCompliance,
            _that.byMedication,
            _that.patterns,
            _that.riskAssessment);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _MedicationCompliance implements MedicationCompliance {
  const _MedicationCompliance(
      {required this.clientId,
      required this.period,
      required this.analyzedAt,
      required this.overallCompliance,
      required final List<MedicationComplianceDetail> byMedication,
      required this.patterns,
      required this.riskAssessment})
      : _byMedication = byMedication;
  factory _MedicationCompliance.fromJson(Map<String, dynamic> json) =>
      _$MedicationComplianceFromJson(json);

  @override
  final String clientId;
  @override
  final String period;
  @override
  final String analyzedAt;
  @override
  final double overallCompliance;
  final List<MedicationComplianceDetail> _byMedication;
  @override
  List<MedicationComplianceDetail> get byMedication {
    if (_byMedication is EqualUnmodifiableListView) return _byMedication;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_byMedication);
  }

  @override
  final CompliancePatterns patterns;
  @override
  final ComplianceRiskAssessment riskAssessment;

  /// Create a copy of MedicationCompliance
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MedicationComplianceCopyWith<_MedicationCompliance> get copyWith =>
      __$MedicationComplianceCopyWithImpl<_MedicationCompliance>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$MedicationComplianceToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MedicationCompliance &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.period, period) || other.period == period) &&
            (identical(other.analyzedAt, analyzedAt) ||
                other.analyzedAt == analyzedAt) &&
            (identical(other.overallCompliance, overallCompliance) ||
                other.overallCompliance == overallCompliance) &&
            const DeepCollectionEquality()
                .equals(other._byMedication, _byMedication) &&
            (identical(other.patterns, patterns) ||
                other.patterns == patterns) &&
            (identical(other.riskAssessment, riskAssessment) ||
                other.riskAssessment == riskAssessment));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      clientId,
      period,
      analyzedAt,
      overallCompliance,
      const DeepCollectionEquality().hash(_byMedication),
      patterns,
      riskAssessment);

  @override
  String toString() {
    return 'MedicationCompliance(clientId: $clientId, period: $period, analyzedAt: $analyzedAt, overallCompliance: $overallCompliance, byMedication: $byMedication, patterns: $patterns, riskAssessment: $riskAssessment)';
  }
}

/// @nodoc
abstract mixin class _$MedicationComplianceCopyWith<$Res>
    implements $MedicationComplianceCopyWith<$Res> {
  factory _$MedicationComplianceCopyWith(_MedicationCompliance value,
          $Res Function(_MedicationCompliance) _then) =
      __$MedicationComplianceCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String clientId,
      String period,
      String analyzedAt,
      double overallCompliance,
      List<MedicationComplianceDetail> byMedication,
      CompliancePatterns patterns,
      ComplianceRiskAssessment riskAssessment});

  @override
  $CompliancePatternsCopyWith<$Res> get patterns;
  @override
  $ComplianceRiskAssessmentCopyWith<$Res> get riskAssessment;
}

/// @nodoc
class __$MedicationComplianceCopyWithImpl<$Res>
    implements _$MedicationComplianceCopyWith<$Res> {
  __$MedicationComplianceCopyWithImpl(this._self, this._then);

  final _MedicationCompliance _self;
  final $Res Function(_MedicationCompliance) _then;

  /// Create a copy of MedicationCompliance
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? clientId = null,
    Object? period = null,
    Object? analyzedAt = null,
    Object? overallCompliance = null,
    Object? byMedication = null,
    Object? patterns = null,
    Object? riskAssessment = null,
  }) {
    return _then(_MedicationCompliance(
      clientId: null == clientId
          ? _self.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      period: null == period
          ? _self.period
          : period // ignore: cast_nullable_to_non_nullable
              as String,
      analyzedAt: null == analyzedAt
          ? _self.analyzedAt
          : analyzedAt // ignore: cast_nullable_to_non_nullable
              as String,
      overallCompliance: null == overallCompliance
          ? _self.overallCompliance
          : overallCompliance // ignore: cast_nullable_to_non_nullable
              as double,
      byMedication: null == byMedication
          ? _self._byMedication
          : byMedication // ignore: cast_nullable_to_non_nullable
              as List<MedicationComplianceDetail>,
      patterns: null == patterns
          ? _self.patterns
          : patterns // ignore: cast_nullable_to_non_nullable
              as CompliancePatterns,
      riskAssessment: null == riskAssessment
          ? _self.riskAssessment
          : riskAssessment // ignore: cast_nullable_to_non_nullable
              as ComplianceRiskAssessment,
    ));
  }

  /// Create a copy of MedicationCompliance
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CompliancePatternsCopyWith<$Res> get patterns {
    return $CompliancePatternsCopyWith<$Res>(_self.patterns, (value) {
      return _then(_self.copyWith(patterns: value));
    });
  }

  /// Create a copy of MedicationCompliance
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ComplianceRiskAssessmentCopyWith<$Res> get riskAssessment {
    return $ComplianceRiskAssessmentCopyWith<$Res>(_self.riskAssessment,
        (value) {
      return _then(_self.copyWith(riskAssessment: value));
    });
  }
}

/// @nodoc
mixin _$MedicationComplianceDetail {
  String get medication;
  int get prescribed;
  int get administered;
  int get missed;
  double get compliance;

  /// Create a copy of MedicationComplianceDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MedicationComplianceDetailCopyWith<MedicationComplianceDetail>
      get copyWith =>
          _$MedicationComplianceDetailCopyWithImpl<MedicationComplianceDetail>(
              this as MedicationComplianceDetail, _$identity);

  /// Serializes this MedicationComplianceDetail to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MedicationComplianceDetail &&
            (identical(other.medication, medication) ||
                other.medication == medication) &&
            (identical(other.prescribed, prescribed) ||
                other.prescribed == prescribed) &&
            (identical(other.administered, administered) ||
                other.administered == administered) &&
            (identical(other.missed, missed) || other.missed == missed) &&
            (identical(other.compliance, compliance) ||
                other.compliance == compliance));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, medication, prescribed, administered, missed, compliance);

  @override
  String toString() {
    return 'MedicationComplianceDetail(medication: $medication, prescribed: $prescribed, administered: $administered, missed: $missed, compliance: $compliance)';
  }
}

/// @nodoc
abstract mixin class $MedicationComplianceDetailCopyWith<$Res> {
  factory $MedicationComplianceDetailCopyWith(MedicationComplianceDetail value,
          $Res Function(MedicationComplianceDetail) _then) =
      _$MedicationComplianceDetailCopyWithImpl;
  @useResult
  $Res call(
      {String medication,
      int prescribed,
      int administered,
      int missed,
      double compliance});
}

/// @nodoc
class _$MedicationComplianceDetailCopyWithImpl<$Res>
    implements $MedicationComplianceDetailCopyWith<$Res> {
  _$MedicationComplianceDetailCopyWithImpl(this._self, this._then);

  final MedicationComplianceDetail _self;
  final $Res Function(MedicationComplianceDetail) _then;

  /// Create a copy of MedicationComplianceDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? medication = null,
    Object? prescribed = null,
    Object? administered = null,
    Object? missed = null,
    Object? compliance = null,
  }) {
    return _then(_self.copyWith(
      medication: null == medication
          ? _self.medication
          : medication // ignore: cast_nullable_to_non_nullable
              as String,
      prescribed: null == prescribed
          ? _self.prescribed
          : prescribed // ignore: cast_nullable_to_non_nullable
              as int,
      administered: null == administered
          ? _self.administered
          : administered // ignore: cast_nullable_to_non_nullable
              as int,
      missed: null == missed
          ? _self.missed
          : missed // ignore: cast_nullable_to_non_nullable
              as int,
      compliance: null == compliance
          ? _self.compliance
          : compliance // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// Adds pattern-matching-related methods to [MedicationComplianceDetail].
extension MedicationComplianceDetailPatterns on MedicationComplianceDetail {
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
    TResult Function(_MedicationComplianceDetail value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MedicationComplianceDetail() when $default != null:
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
    TResult Function(_MedicationComplianceDetail value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MedicationComplianceDetail():
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
    TResult? Function(_MedicationComplianceDetail value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MedicationComplianceDetail() when $default != null:
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
    TResult Function(String medication, int prescribed, int administered,
            int missed, double compliance)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MedicationComplianceDetail() when $default != null:
        return $default(_that.medication, _that.prescribed, _that.administered,
            _that.missed, _that.compliance);
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
    TResult Function(String medication, int prescribed, int administered,
            int missed, double compliance)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MedicationComplianceDetail():
        return $default(_that.medication, _that.prescribed, _that.administered,
            _that.missed, _that.compliance);
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
    TResult? Function(String medication, int prescribed, int administered,
            int missed, double compliance)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MedicationComplianceDetail() when $default != null:
        return $default(_that.medication, _that.prescribed, _that.administered,
            _that.missed, _that.compliance);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _MedicationComplianceDetail implements MedicationComplianceDetail {
  const _MedicationComplianceDetail(
      {required this.medication,
      required this.prescribed,
      required this.administered,
      required this.missed,
      required this.compliance});
  factory _MedicationComplianceDetail.fromJson(Map<String, dynamic> json) =>
      _$MedicationComplianceDetailFromJson(json);

  @override
  final String medication;
  @override
  final int prescribed;
  @override
  final int administered;
  @override
  final int missed;
  @override
  final double compliance;

  /// Create a copy of MedicationComplianceDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MedicationComplianceDetailCopyWith<_MedicationComplianceDetail>
      get copyWith => __$MedicationComplianceDetailCopyWithImpl<
          _MedicationComplianceDetail>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$MedicationComplianceDetailToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MedicationComplianceDetail &&
            (identical(other.medication, medication) ||
                other.medication == medication) &&
            (identical(other.prescribed, prescribed) ||
                other.prescribed == prescribed) &&
            (identical(other.administered, administered) ||
                other.administered == administered) &&
            (identical(other.missed, missed) || other.missed == missed) &&
            (identical(other.compliance, compliance) ||
                other.compliance == compliance));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, medication, prescribed, administered, missed, compliance);

  @override
  String toString() {
    return 'MedicationComplianceDetail(medication: $medication, prescribed: $prescribed, administered: $administered, missed: $missed, compliance: $compliance)';
  }
}

/// @nodoc
abstract mixin class _$MedicationComplianceDetailCopyWith<$Res>
    implements $MedicationComplianceDetailCopyWith<$Res> {
  factory _$MedicationComplianceDetailCopyWith(
          _MedicationComplianceDetail value,
          $Res Function(_MedicationComplianceDetail) _then) =
      __$MedicationComplianceDetailCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String medication,
      int prescribed,
      int administered,
      int missed,
      double compliance});
}

/// @nodoc
class __$MedicationComplianceDetailCopyWithImpl<$Res>
    implements _$MedicationComplianceDetailCopyWith<$Res> {
  __$MedicationComplianceDetailCopyWithImpl(this._self, this._then);

  final _MedicationComplianceDetail _self;
  final $Res Function(_MedicationComplianceDetail) _then;

  /// Create a copy of MedicationComplianceDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? medication = null,
    Object? prescribed = null,
    Object? administered = null,
    Object? missed = null,
    Object? compliance = null,
  }) {
    return _then(_MedicationComplianceDetail(
      medication: null == medication
          ? _self.medication
          : medication // ignore: cast_nullable_to_non_nullable
              as String,
      prescribed: null == prescribed
          ? _self.prescribed
          : prescribed // ignore: cast_nullable_to_non_nullable
              as int,
      administered: null == administered
          ? _self.administered
          : administered // ignore: cast_nullable_to_non_nullable
              as int,
      missed: null == missed
          ? _self.missed
          : missed // ignore: cast_nullable_to_non_nullable
              as int,
      compliance: null == compliance
          ? _self.compliance
          : compliance // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
mixin _$CompliancePatterns {
  MissedDoses get missedDoses;

  /// Create a copy of CompliancePatterns
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CompliancePatternsCopyWith<CompliancePatterns> get copyWith =>
      _$CompliancePatternsCopyWithImpl<CompliancePatterns>(
          this as CompliancePatterns, _$identity);

  /// Serializes this CompliancePatterns to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CompliancePatterns &&
            (identical(other.missedDoses, missedDoses) ||
                other.missedDoses == missedDoses));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, missedDoses);

  @override
  String toString() {
    return 'CompliancePatterns(missedDoses: $missedDoses)';
  }
}

/// @nodoc
abstract mixin class $CompliancePatternsCopyWith<$Res> {
  factory $CompliancePatternsCopyWith(
          CompliancePatterns value, $Res Function(CompliancePatterns) _then) =
      _$CompliancePatternsCopyWithImpl;
  @useResult
  $Res call({MissedDoses missedDoses});

  $MissedDosesCopyWith<$Res> get missedDoses;
}

/// @nodoc
class _$CompliancePatternsCopyWithImpl<$Res>
    implements $CompliancePatternsCopyWith<$Res> {
  _$CompliancePatternsCopyWithImpl(this._self, this._then);

  final CompliancePatterns _self;
  final $Res Function(CompliancePatterns) _then;

  /// Create a copy of CompliancePatterns
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? missedDoses = null,
  }) {
    return _then(_self.copyWith(
      missedDoses: null == missedDoses
          ? _self.missedDoses
          : missedDoses // ignore: cast_nullable_to_non_nullable
              as MissedDoses,
    ));
  }

  /// Create a copy of CompliancePatterns
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MissedDosesCopyWith<$Res> get missedDoses {
    return $MissedDosesCopyWith<$Res>(_self.missedDoses, (value) {
      return _then(_self.copyWith(missedDoses: value));
    });
  }
}

/// Adds pattern-matching-related methods to [CompliancePatterns].
extension CompliancePatternsPatterns on CompliancePatterns {
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
    TResult Function(_CompliancePatterns value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CompliancePatterns() when $default != null:
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
    TResult Function(_CompliancePatterns value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CompliancePatterns():
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
    TResult? Function(_CompliancePatterns value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CompliancePatterns() when $default != null:
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
    TResult Function(MissedDoses missedDoses)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CompliancePatterns() when $default != null:
        return $default(_that.missedDoses);
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
    TResult Function(MissedDoses missedDoses) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CompliancePatterns():
        return $default(_that.missedDoses);
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
    TResult? Function(MissedDoses missedDoses)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CompliancePatterns() when $default != null:
        return $default(_that.missedDoses);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _CompliancePatterns implements CompliancePatterns {
  const _CompliancePatterns({required this.missedDoses});
  factory _CompliancePatterns.fromJson(Map<String, dynamic> json) =>
      _$CompliancePatternsFromJson(json);

  @override
  final MissedDoses missedDoses;

  /// Create a copy of CompliancePatterns
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CompliancePatternsCopyWith<_CompliancePatterns> get copyWith =>
      __$CompliancePatternsCopyWithImpl<_CompliancePatterns>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CompliancePatternsToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CompliancePatterns &&
            (identical(other.missedDoses, missedDoses) ||
                other.missedDoses == missedDoses));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, missedDoses);

  @override
  String toString() {
    return 'CompliancePatterns(missedDoses: $missedDoses)';
  }
}

/// @nodoc
abstract mixin class _$CompliancePatternsCopyWith<$Res>
    implements $CompliancePatternsCopyWith<$Res> {
  factory _$CompliancePatternsCopyWith(
          _CompliancePatterns value, $Res Function(_CompliancePatterns) _then) =
      __$CompliancePatternsCopyWithImpl;
  @override
  @useResult
  $Res call({MissedDoses missedDoses});

  @override
  $MissedDosesCopyWith<$Res> get missedDoses;
}

/// @nodoc
class __$CompliancePatternsCopyWithImpl<$Res>
    implements _$CompliancePatternsCopyWith<$Res> {
  __$CompliancePatternsCopyWithImpl(this._self, this._then);

  final _CompliancePatterns _self;
  final $Res Function(_CompliancePatterns) _then;

  /// Create a copy of CompliancePatterns
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? missedDoses = null,
  }) {
    return _then(_CompliancePatterns(
      missedDoses: null == missedDoses
          ? _self.missedDoses
          : missedDoses // ignore: cast_nullable_to_non_nullable
              as MissedDoses,
    ));
  }

  /// Create a copy of CompliancePatterns
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MissedDosesCopyWith<$Res> get missedDoses {
    return $MissedDosesCopyWith<$Res>(_self.missedDoses, (value) {
      return _then(_self.copyWith(missedDoses: value));
    });
  }
}

/// @nodoc
mixin _$MissedDoses {
  List<String> get timeOfDay;
  List<String> get dayOfWeek;
  List<String> get reasons;

  /// Create a copy of MissedDoses
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MissedDosesCopyWith<MissedDoses> get copyWith =>
      _$MissedDosesCopyWithImpl<MissedDoses>(this as MissedDoses, _$identity);

  /// Serializes this MissedDoses to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MissedDoses &&
            const DeepCollectionEquality().equals(other.timeOfDay, timeOfDay) &&
            const DeepCollectionEquality().equals(other.dayOfWeek, dayOfWeek) &&
            const DeepCollectionEquality().equals(other.reasons, reasons));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(timeOfDay),
      const DeepCollectionEquality().hash(dayOfWeek),
      const DeepCollectionEquality().hash(reasons));

  @override
  String toString() {
    return 'MissedDoses(timeOfDay: $timeOfDay, dayOfWeek: $dayOfWeek, reasons: $reasons)';
  }
}

/// @nodoc
abstract mixin class $MissedDosesCopyWith<$Res> {
  factory $MissedDosesCopyWith(
          MissedDoses value, $Res Function(MissedDoses) _then) =
      _$MissedDosesCopyWithImpl;
  @useResult
  $Res call(
      {List<String> timeOfDay, List<String> dayOfWeek, List<String> reasons});
}

/// @nodoc
class _$MissedDosesCopyWithImpl<$Res> implements $MissedDosesCopyWith<$Res> {
  _$MissedDosesCopyWithImpl(this._self, this._then);

  final MissedDoses _self;
  final $Res Function(MissedDoses) _then;

  /// Create a copy of MissedDoses
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timeOfDay = null,
    Object? dayOfWeek = null,
    Object? reasons = null,
  }) {
    return _then(_self.copyWith(
      timeOfDay: null == timeOfDay
          ? _self.timeOfDay
          : timeOfDay // ignore: cast_nullable_to_non_nullable
              as List<String>,
      dayOfWeek: null == dayOfWeek
          ? _self.dayOfWeek
          : dayOfWeek // ignore: cast_nullable_to_non_nullable
              as List<String>,
      reasons: null == reasons
          ? _self.reasons
          : reasons // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// Adds pattern-matching-related methods to [MissedDoses].
extension MissedDosesPatterns on MissedDoses {
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
    TResult Function(_MissedDoses value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MissedDoses() when $default != null:
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
    TResult Function(_MissedDoses value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MissedDoses():
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
    TResult? Function(_MissedDoses value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MissedDoses() when $default != null:
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
    TResult Function(List<String> timeOfDay, List<String> dayOfWeek,
            List<String> reasons)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MissedDoses() when $default != null:
        return $default(_that.timeOfDay, _that.dayOfWeek, _that.reasons);
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
    TResult Function(List<String> timeOfDay, List<String> dayOfWeek,
            List<String> reasons)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MissedDoses():
        return $default(_that.timeOfDay, _that.dayOfWeek, _that.reasons);
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
    TResult? Function(List<String> timeOfDay, List<String> dayOfWeek,
            List<String> reasons)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MissedDoses() when $default != null:
        return $default(_that.timeOfDay, _that.dayOfWeek, _that.reasons);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _MissedDoses implements MissedDoses {
  const _MissedDoses(
      {required final List<String> timeOfDay,
      required final List<String> dayOfWeek,
      required final List<String> reasons})
      : _timeOfDay = timeOfDay,
        _dayOfWeek = dayOfWeek,
        _reasons = reasons;
  factory _MissedDoses.fromJson(Map<String, dynamic> json) =>
      _$MissedDosesFromJson(json);

  final List<String> _timeOfDay;
  @override
  List<String> get timeOfDay {
    if (_timeOfDay is EqualUnmodifiableListView) return _timeOfDay;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_timeOfDay);
  }

  final List<String> _dayOfWeek;
  @override
  List<String> get dayOfWeek {
    if (_dayOfWeek is EqualUnmodifiableListView) return _dayOfWeek;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_dayOfWeek);
  }

  final List<String> _reasons;
  @override
  List<String> get reasons {
    if (_reasons is EqualUnmodifiableListView) return _reasons;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_reasons);
  }

  /// Create a copy of MissedDoses
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MissedDosesCopyWith<_MissedDoses> get copyWith =>
      __$MissedDosesCopyWithImpl<_MissedDoses>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$MissedDosesToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MissedDoses &&
            const DeepCollectionEquality()
                .equals(other._timeOfDay, _timeOfDay) &&
            const DeepCollectionEquality()
                .equals(other._dayOfWeek, _dayOfWeek) &&
            const DeepCollectionEquality().equals(other._reasons, _reasons));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_timeOfDay),
      const DeepCollectionEquality().hash(_dayOfWeek),
      const DeepCollectionEquality().hash(_reasons));

  @override
  String toString() {
    return 'MissedDoses(timeOfDay: $timeOfDay, dayOfWeek: $dayOfWeek, reasons: $reasons)';
  }
}

/// @nodoc
abstract mixin class _$MissedDosesCopyWith<$Res>
    implements $MissedDosesCopyWith<$Res> {
  factory _$MissedDosesCopyWith(
          _MissedDoses value, $Res Function(_MissedDoses) _then) =
      __$MissedDosesCopyWithImpl;
  @override
  @useResult
  $Res call(
      {List<String> timeOfDay, List<String> dayOfWeek, List<String> reasons});
}

/// @nodoc
class __$MissedDosesCopyWithImpl<$Res> implements _$MissedDosesCopyWith<$Res> {
  __$MissedDosesCopyWithImpl(this._self, this._then);

  final _MissedDoses _self;
  final $Res Function(_MissedDoses) _then;

  /// Create a copy of MissedDoses
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? timeOfDay = null,
    Object? dayOfWeek = null,
    Object? reasons = null,
  }) {
    return _then(_MissedDoses(
      timeOfDay: null == timeOfDay
          ? _self._timeOfDay
          : timeOfDay // ignore: cast_nullable_to_non_nullable
              as List<String>,
      dayOfWeek: null == dayOfWeek
          ? _self._dayOfWeek
          : dayOfWeek // ignore: cast_nullable_to_non_nullable
              as List<String>,
      reasons: null == reasons
          ? _self._reasons
          : reasons // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
mixin _$ComplianceRiskAssessment {
  double get nonComplianceRisk;
  List<String> get factors;
  List<String> get recommendations;

  /// Create a copy of ComplianceRiskAssessment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ComplianceRiskAssessmentCopyWith<ComplianceRiskAssessment> get copyWith =>
      _$ComplianceRiskAssessmentCopyWithImpl<ComplianceRiskAssessment>(
          this as ComplianceRiskAssessment, _$identity);

  /// Serializes this ComplianceRiskAssessment to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ComplianceRiskAssessment &&
            (identical(other.nonComplianceRisk, nonComplianceRisk) ||
                other.nonComplianceRisk == nonComplianceRisk) &&
            const DeepCollectionEquality().equals(other.factors, factors) &&
            const DeepCollectionEquality()
                .equals(other.recommendations, recommendations));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      nonComplianceRisk,
      const DeepCollectionEquality().hash(factors),
      const DeepCollectionEquality().hash(recommendations));

  @override
  String toString() {
    return 'ComplianceRiskAssessment(nonComplianceRisk: $nonComplianceRisk, factors: $factors, recommendations: $recommendations)';
  }
}

/// @nodoc
abstract mixin class $ComplianceRiskAssessmentCopyWith<$Res> {
  factory $ComplianceRiskAssessmentCopyWith(ComplianceRiskAssessment value,
          $Res Function(ComplianceRiskAssessment) _then) =
      _$ComplianceRiskAssessmentCopyWithImpl;
  @useResult
  $Res call(
      {double nonComplianceRisk,
      List<String> factors,
      List<String> recommendations});
}

/// @nodoc
class _$ComplianceRiskAssessmentCopyWithImpl<$Res>
    implements $ComplianceRiskAssessmentCopyWith<$Res> {
  _$ComplianceRiskAssessmentCopyWithImpl(this._self, this._then);

  final ComplianceRiskAssessment _self;
  final $Res Function(ComplianceRiskAssessment) _then;

  /// Create a copy of ComplianceRiskAssessment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nonComplianceRisk = null,
    Object? factors = null,
    Object? recommendations = null,
  }) {
    return _then(_self.copyWith(
      nonComplianceRisk: null == nonComplianceRisk
          ? _self.nonComplianceRisk
          : nonComplianceRisk // ignore: cast_nullable_to_non_nullable
              as double,
      factors: null == factors
          ? _self.factors
          : factors // ignore: cast_nullable_to_non_nullable
              as List<String>,
      recommendations: null == recommendations
          ? _self.recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// Adds pattern-matching-related methods to [ComplianceRiskAssessment].
extension ComplianceRiskAssessmentPatterns on ComplianceRiskAssessment {
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
    TResult Function(_ComplianceRiskAssessment value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ComplianceRiskAssessment() when $default != null:
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
    TResult Function(_ComplianceRiskAssessment value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ComplianceRiskAssessment():
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
    TResult? Function(_ComplianceRiskAssessment value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ComplianceRiskAssessment() when $default != null:
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
    TResult Function(double nonComplianceRisk, List<String> factors,
            List<String> recommendations)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ComplianceRiskAssessment() when $default != null:
        return $default(
            _that.nonComplianceRisk, _that.factors, _that.recommendations);
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
    TResult Function(double nonComplianceRisk, List<String> factors,
            List<String> recommendations)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ComplianceRiskAssessment():
        return $default(
            _that.nonComplianceRisk, _that.factors, _that.recommendations);
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
    TResult? Function(double nonComplianceRisk, List<String> factors,
            List<String> recommendations)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ComplianceRiskAssessment() when $default != null:
        return $default(
            _that.nonComplianceRisk, _that.factors, _that.recommendations);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ComplianceRiskAssessment implements ComplianceRiskAssessment {
  const _ComplianceRiskAssessment(
      {required this.nonComplianceRisk,
      required final List<String> factors,
      required final List<String> recommendations})
      : _factors = factors,
        _recommendations = recommendations;
  factory _ComplianceRiskAssessment.fromJson(Map<String, dynamic> json) =>
      _$ComplianceRiskAssessmentFromJson(json);

  @override
  final double nonComplianceRisk;
  final List<String> _factors;
  @override
  List<String> get factors {
    if (_factors is EqualUnmodifiableListView) return _factors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_factors);
  }

  final List<String> _recommendations;
  @override
  List<String> get recommendations {
    if (_recommendations is EqualUnmodifiableListView) return _recommendations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recommendations);
  }

  /// Create a copy of ComplianceRiskAssessment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ComplianceRiskAssessmentCopyWith<_ComplianceRiskAssessment> get copyWith =>
      __$ComplianceRiskAssessmentCopyWithImpl<_ComplianceRiskAssessment>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ComplianceRiskAssessmentToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ComplianceRiskAssessment &&
            (identical(other.nonComplianceRisk, nonComplianceRisk) ||
                other.nonComplianceRisk == nonComplianceRisk) &&
            const DeepCollectionEquality().equals(other._factors, _factors) &&
            const DeepCollectionEquality()
                .equals(other._recommendations, _recommendations));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      nonComplianceRisk,
      const DeepCollectionEquality().hash(_factors),
      const DeepCollectionEquality().hash(_recommendations));

  @override
  String toString() {
    return 'ComplianceRiskAssessment(nonComplianceRisk: $nonComplianceRisk, factors: $factors, recommendations: $recommendations)';
  }
}

/// @nodoc
abstract mixin class _$ComplianceRiskAssessmentCopyWith<$Res>
    implements $ComplianceRiskAssessmentCopyWith<$Res> {
  factory _$ComplianceRiskAssessmentCopyWith(_ComplianceRiskAssessment value,
          $Res Function(_ComplianceRiskAssessment) _then) =
      __$ComplianceRiskAssessmentCopyWithImpl;
  @override
  @useResult
  $Res call(
      {double nonComplianceRisk,
      List<String> factors,
      List<String> recommendations});
}

/// @nodoc
class __$ComplianceRiskAssessmentCopyWithImpl<$Res>
    implements _$ComplianceRiskAssessmentCopyWith<$Res> {
  __$ComplianceRiskAssessmentCopyWithImpl(this._self, this._then);

  final _ComplianceRiskAssessment _self;
  final $Res Function(_ComplianceRiskAssessment) _then;

  /// Create a copy of ComplianceRiskAssessment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? nonComplianceRisk = null,
    Object? factors = null,
    Object? recommendations = null,
  }) {
    return _then(_ComplianceRiskAssessment(
      nonComplianceRisk: null == nonComplianceRisk
          ? _self.nonComplianceRisk
          : nonComplianceRisk // ignore: cast_nullable_to_non_nullable
              as double,
      factors: null == factors
          ? _self._factors
          : factors // ignore: cast_nullable_to_non_nullable
              as List<String>,
      recommendations: null == recommendations
          ? _self._recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
mixin _$MedicationAlert {
  String get type;
  String get severity;
  String? get medication;
  List<String>? get medications;
  String get message;
  String get action;
  String? get dueDate;
  String? get timestamp;

  /// Create a copy of MedicationAlert
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MedicationAlertCopyWith<MedicationAlert> get copyWith =>
      _$MedicationAlertCopyWithImpl<MedicationAlert>(
          this as MedicationAlert, _$identity);

  /// Serializes this MedicationAlert to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MedicationAlert &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.severity, severity) ||
                other.severity == severity) &&
            (identical(other.medication, medication) ||
                other.medication == medication) &&
            const DeepCollectionEquality()
                .equals(other.medications, medications) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.action, action) || other.action == action) &&
            (identical(other.dueDate, dueDate) || other.dueDate == dueDate) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      type,
      severity,
      medication,
      const DeepCollectionEquality().hash(medications),
      message,
      action,
      dueDate,
      timestamp);

  @override
  String toString() {
    return 'MedicationAlert(type: $type, severity: $severity, medication: $medication, medications: $medications, message: $message, action: $action, dueDate: $dueDate, timestamp: $timestamp)';
  }
}

/// @nodoc
abstract mixin class $MedicationAlertCopyWith<$Res> {
  factory $MedicationAlertCopyWith(
          MedicationAlert value, $Res Function(MedicationAlert) _then) =
      _$MedicationAlertCopyWithImpl;
  @useResult
  $Res call(
      {String type,
      String severity,
      String? medication,
      List<String>? medications,
      String message,
      String action,
      String? dueDate,
      String? timestamp});
}

/// @nodoc
class _$MedicationAlertCopyWithImpl<$Res>
    implements $MedicationAlertCopyWith<$Res> {
  _$MedicationAlertCopyWithImpl(this._self, this._then);

  final MedicationAlert _self;
  final $Res Function(MedicationAlert) _then;

  /// Create a copy of MedicationAlert
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? severity = null,
    Object? medication = freezed,
    Object? medications = freezed,
    Object? message = null,
    Object? action = null,
    Object? dueDate = freezed,
    Object? timestamp = freezed,
  }) {
    return _then(_self.copyWith(
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      severity: null == severity
          ? _self.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as String,
      medication: freezed == medication
          ? _self.medication
          : medication // ignore: cast_nullable_to_non_nullable
              as String?,
      medications: freezed == medications
          ? _self.medications
          : medications // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      action: null == action
          ? _self.action
          : action // ignore: cast_nullable_to_non_nullable
              as String,
      dueDate: freezed == dueDate
          ? _self.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as String?,
      timestamp: freezed == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [MedicationAlert].
extension MedicationAlertPatterns on MedicationAlert {
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
    TResult Function(_MedicationAlert value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MedicationAlert() when $default != null:
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
    TResult Function(_MedicationAlert value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MedicationAlert():
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
    TResult? Function(_MedicationAlert value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MedicationAlert() when $default != null:
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
            String type,
            String severity,
            String? medication,
            List<String>? medications,
            String message,
            String action,
            String? dueDate,
            String? timestamp)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MedicationAlert() when $default != null:
        return $default(
            _that.type,
            _that.severity,
            _that.medication,
            _that.medications,
            _that.message,
            _that.action,
            _that.dueDate,
            _that.timestamp);
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
            String type,
            String severity,
            String? medication,
            List<String>? medications,
            String message,
            String action,
            String? dueDate,
            String? timestamp)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MedicationAlert():
        return $default(
            _that.type,
            _that.severity,
            _that.medication,
            _that.medications,
            _that.message,
            _that.action,
            _that.dueDate,
            _that.timestamp);
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
            String type,
            String severity,
            String? medication,
            List<String>? medications,
            String message,
            String action,
            String? dueDate,
            String? timestamp)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MedicationAlert() when $default != null:
        return $default(
            _that.type,
            _that.severity,
            _that.medication,
            _that.medications,
            _that.message,
            _that.action,
            _that.dueDate,
            _that.timestamp);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _MedicationAlert implements MedicationAlert {
  const _MedicationAlert(
      {required this.type,
      required this.severity,
      this.medication,
      final List<String>? medications,
      required this.message,
      required this.action,
      this.dueDate,
      this.timestamp})
      : _medications = medications;
  factory _MedicationAlert.fromJson(Map<String, dynamic> json) =>
      _$MedicationAlertFromJson(json);

  @override
  final String type;
  @override
  final String severity;
  @override
  final String? medication;
  final List<String>? _medications;
  @override
  List<String>? get medications {
    final value = _medications;
    if (value == null) return null;
    if (_medications is EqualUnmodifiableListView) return _medications;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String message;
  @override
  final String action;
  @override
  final String? dueDate;
  @override
  final String? timestamp;

  /// Create a copy of MedicationAlert
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MedicationAlertCopyWith<_MedicationAlert> get copyWith =>
      __$MedicationAlertCopyWithImpl<_MedicationAlert>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$MedicationAlertToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MedicationAlert &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.severity, severity) ||
                other.severity == severity) &&
            (identical(other.medication, medication) ||
                other.medication == medication) &&
            const DeepCollectionEquality()
                .equals(other._medications, _medications) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.action, action) || other.action == action) &&
            (identical(other.dueDate, dueDate) || other.dueDate == dueDate) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      type,
      severity,
      medication,
      const DeepCollectionEquality().hash(_medications),
      message,
      action,
      dueDate,
      timestamp);

  @override
  String toString() {
    return 'MedicationAlert(type: $type, severity: $severity, medication: $medication, medications: $medications, message: $message, action: $action, dueDate: $dueDate, timestamp: $timestamp)';
  }
}

/// @nodoc
abstract mixin class _$MedicationAlertCopyWith<$Res>
    implements $MedicationAlertCopyWith<$Res> {
  factory _$MedicationAlertCopyWith(
          _MedicationAlert value, $Res Function(_MedicationAlert) _then) =
      __$MedicationAlertCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String type,
      String severity,
      String? medication,
      List<String>? medications,
      String message,
      String action,
      String? dueDate,
      String? timestamp});
}

/// @nodoc
class __$MedicationAlertCopyWithImpl<$Res>
    implements _$MedicationAlertCopyWith<$Res> {
  __$MedicationAlertCopyWithImpl(this._self, this._then);

  final _MedicationAlert _self;
  final $Res Function(_MedicationAlert) _then;

  /// Create a copy of MedicationAlert
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? type = null,
    Object? severity = null,
    Object? medication = freezed,
    Object? medications = freezed,
    Object? message = null,
    Object? action = null,
    Object? dueDate = freezed,
    Object? timestamp = freezed,
  }) {
    return _then(_MedicationAlert(
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      severity: null == severity
          ? _self.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as String,
      medication: freezed == medication
          ? _self.medication
          : medication // ignore: cast_nullable_to_non_nullable
              as String?,
      medications: freezed == medications
          ? _self._medications
          : medications // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      action: null == action
          ? _self.action
          : action // ignore: cast_nullable_to_non_nullable
              as String,
      dueDate: freezed == dueDate
          ? _self.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as String?,
      timestamp: freezed == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
